// Copyright 2017 The Dawn Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "dawn_native/ShaderModule.h"

#include "common/HashUtils.h"
#include "dawn_native/BindGroupLayout.h"
#include "dawn_native/Device.h"
#include "dawn_native/Pipeline.h"
#include "dawn_native/PipelineLayout.h"

#include <spirv-tools/libspirv.hpp>
#include <spirv_cross.hpp>

#ifdef DAWN_ENABLE_WGSL
// Tint include must be after spirv_cross.hpp, because spirv-cross has its own
// version of spirv_headers.
// clang-format off
#include <tint/tint.h>
// clang-format on
#endif  // DAWN_ENABLE_WGSL

#include <sstream>

namespace dawn_native {

    namespace {
        Format::Type SpirvCrossBaseTypeToFormatType(spirv_cross::SPIRType::BaseType spirvBaseType) {
            switch (spirvBaseType) {
                case spirv_cross::SPIRType::Float:
                    return Format::Type::Float;
                case spirv_cross::SPIRType::Int:
                    return Format::Type::Sint;
                case spirv_cross::SPIRType::UInt:
                    return Format::Type::Uint;
                default:
                    UNREACHABLE();
                    return Format::Type::Other;
            }
        }

        wgpu::TextureViewDimension SpirvDimToTextureViewDimension(spv::Dim dim, bool arrayed) {
            switch (dim) {
                case spv::Dim::Dim1D:
                    return wgpu::TextureViewDimension::e1D;
                case spv::Dim::Dim2D:
                    if (arrayed) {
                        return wgpu::TextureViewDimension::e2DArray;
                    } else {
                        return wgpu::TextureViewDimension::e2D;
                    }
                case spv::Dim::Dim3D:
                    return wgpu::TextureViewDimension::e3D;
                case spv::Dim::DimCube:
                    if (arrayed) {
                        return wgpu::TextureViewDimension::CubeArray;
                    } else {
                        return wgpu::TextureViewDimension::Cube;
                    }
                default:
                    UNREACHABLE();
                    return wgpu::TextureViewDimension::Undefined;
            }
        }

        wgpu::TextureFormat ToWGPUTextureFormat(spv::ImageFormat format) {
            switch (format) {
                case spv::ImageFormatR8:
                    return wgpu::TextureFormat::R8Unorm;
                case spv::ImageFormatR8Snorm:
                    return wgpu::TextureFormat::R8Snorm;
                case spv::ImageFormatR8ui:
                    return wgpu::TextureFormat::R8Uint;
                case spv::ImageFormatR8i:
                    return wgpu::TextureFormat::R8Sint;
                case spv::ImageFormatR16ui:
                    return wgpu::TextureFormat::R16Uint;
                case spv::ImageFormatR16i:
                    return wgpu::TextureFormat::R16Sint;
                case spv::ImageFormatR16f:
                    return wgpu::TextureFormat::R16Float;
                case spv::ImageFormatRg8:
                    return wgpu::TextureFormat::RG8Unorm;
                case spv::ImageFormatRg8Snorm:
                    return wgpu::TextureFormat::RG8Snorm;
                case spv::ImageFormatRg8ui:
                    return wgpu::TextureFormat::RG8Uint;
                case spv::ImageFormatRg8i:
                    return wgpu::TextureFormat::RG8Sint;
                case spv::ImageFormatR32f:
                    return wgpu::TextureFormat::R32Float;
                case spv::ImageFormatR32ui:
                    return wgpu::TextureFormat::R32Uint;
                case spv::ImageFormatR32i:
                    return wgpu::TextureFormat::R32Sint;
                case spv::ImageFormatRg16ui:
                    return wgpu::TextureFormat::RG16Uint;
                case spv::ImageFormatRg16i:
                    return wgpu::TextureFormat::RG16Sint;
                case spv::ImageFormatRg16f:
                    return wgpu::TextureFormat::RG16Float;
                case spv::ImageFormatRgba8:
                    return wgpu::TextureFormat::RGBA8Unorm;
                case spv::ImageFormatRgba8Snorm:
                    return wgpu::TextureFormat::RGBA8Snorm;
                case spv::ImageFormatRgba8ui:
                    return wgpu::TextureFormat::RGBA8Uint;
                case spv::ImageFormatRgba8i:
                    return wgpu::TextureFormat::RGBA8Sint;
                case spv::ImageFormatRgb10A2:
                    return wgpu::TextureFormat::RGB10A2Unorm;
                case spv::ImageFormatR11fG11fB10f:
                    return wgpu::TextureFormat::RG11B10Ufloat;
                case spv::ImageFormatRg32f:
                    return wgpu::TextureFormat::RG32Float;
                case spv::ImageFormatRg32ui:
                    return wgpu::TextureFormat::RG32Uint;
                case spv::ImageFormatRg32i:
                    return wgpu::TextureFormat::RG32Sint;
                case spv::ImageFormatRgba16ui:
                    return wgpu::TextureFormat::RGBA16Uint;
                case spv::ImageFormatRgba16i:
                    return wgpu::TextureFormat::RGBA16Sint;
                case spv::ImageFormatRgba16f:
                    return wgpu::TextureFormat::RGBA16Float;
                case spv::ImageFormatRgba32f:
                    return wgpu::TextureFormat::RGBA32Float;
                case spv::ImageFormatRgba32ui:
                    return wgpu::TextureFormat::RGBA32Uint;
                case spv::ImageFormatRgba32i:
                    return wgpu::TextureFormat::RGBA32Sint;
                default:
                    return wgpu::TextureFormat::Undefined;
            }
        }

        std::string GetShaderDeclarationString(BindGroupIndex group, BindingNumber binding) {
            std::ostringstream ostream;
            ostream << "the shader module declaration at set " << static_cast<uint32_t>(group)
                    << " binding " << static_cast<uint32_t>(binding);
            return ostream.str();
        }

#ifdef DAWN_ENABLE_WGSL
        tint::ast::transform::VertexFormat ToTintVertexFormat(wgpu::VertexFormat format) {
            switch (format) {
                case wgpu::VertexFormat::UChar2:
                    return tint::ast::transform::VertexFormat::kVec2U8;
                case wgpu::VertexFormat::UChar4:
                    return tint::ast::transform::VertexFormat::kVec4U8;
                case wgpu::VertexFormat::Char2:
                    return tint::ast::transform::VertexFormat::kVec2I8;
                case wgpu::VertexFormat::Char4:
                    return tint::ast::transform::VertexFormat::kVec4I8;
                case wgpu::VertexFormat::UChar2Norm:
                    return tint::ast::transform::VertexFormat::kVec2U8Norm;
                case wgpu::VertexFormat::UChar4Norm:
                    return tint::ast::transform::VertexFormat::kVec4U8Norm;
                case wgpu::VertexFormat::Char2Norm:
                    return tint::ast::transform::VertexFormat::kVec2I8Norm;
                case wgpu::VertexFormat::Char4Norm:
                    return tint::ast::transform::VertexFormat::kVec4I8Norm;
                case wgpu::VertexFormat::UShort2:
                    return tint::ast::transform::VertexFormat::kVec2U16;
                case wgpu::VertexFormat::UShort4:
                    return tint::ast::transform::VertexFormat::kVec4U16;
                case wgpu::VertexFormat::Short2:
                    return tint::ast::transform::VertexFormat::kVec2I16;
                case wgpu::VertexFormat::Short4:
                    return tint::ast::transform::VertexFormat::kVec4I16;
                case wgpu::VertexFormat::UShort2Norm:
                    return tint::ast::transform::VertexFormat::kVec2U16Norm;
                case wgpu::VertexFormat::UShort4Norm:
                    return tint::ast::transform::VertexFormat::kVec4U16Norm;
                case wgpu::VertexFormat::Short2Norm:
                    return tint::ast::transform::VertexFormat::kVec2I16Norm;
                case wgpu::VertexFormat::Short4Norm:
                    return tint::ast::transform::VertexFormat::kVec4I16Norm;
                case wgpu::VertexFormat::Half2:
                    return tint::ast::transform::VertexFormat::kVec2F16;
                case wgpu::VertexFormat::Half4:
                    return tint::ast::transform::VertexFormat::kVec4F16;
                case wgpu::VertexFormat::Float:
                    return tint::ast::transform::VertexFormat::kF32;
                case wgpu::VertexFormat::Float2:
                    return tint::ast::transform::VertexFormat::kVec2F32;
                case wgpu::VertexFormat::Float3:
                    return tint::ast::transform::VertexFormat::kVec3F32;
                case wgpu::VertexFormat::Float4:
                    return tint::ast::transform::VertexFormat::kVec4F32;
                case wgpu::VertexFormat::UInt:
                    return tint::ast::transform::VertexFormat::kU32;
                case wgpu::VertexFormat::UInt2:
                    return tint::ast::transform::VertexFormat::kVec2U32;
                case wgpu::VertexFormat::UInt3:
                    return tint::ast::transform::VertexFormat::kVec3U32;
                case wgpu::VertexFormat::UInt4:
                    return tint::ast::transform::VertexFormat::kVec4U32;
                case wgpu::VertexFormat::Int:
                    return tint::ast::transform::VertexFormat::kI32;
                case wgpu::VertexFormat::Int2:
                    return tint::ast::transform::VertexFormat::kVec2I32;
                case wgpu::VertexFormat::Int3:
                    return tint::ast::transform::VertexFormat::kVec3I32;
                case wgpu::VertexFormat::Int4:
                    return tint::ast::transform::VertexFormat::kVec4I32;
            }
        }

        tint::ast::transform::InputStepMode ToTintInputStepMode(wgpu::InputStepMode mode) {
            switch (mode) {
                case wgpu::InputStepMode::Vertex:
                    return tint::ast::transform::InputStepMode::kVertex;
                case wgpu::InputStepMode::Instance:
                    return tint::ast::transform::InputStepMode::kInstance;
            }
        }
#endif

        MaybeError ValidateSpirv(DeviceBase*, const uint32_t* code, uint32_t codeSize) {
            spvtools::SpirvTools spirvTools(SPV_ENV_VULKAN_1_1);

            std::ostringstream errorStream;
            errorStream << "SPIRV Validation failure:" << std::endl;

            spirvTools.SetMessageConsumer([&errorStream](spv_message_level_t level, const char*,
                                                         const spv_position_t& position,
                                                         const char* message) {
                switch (level) {
                    case SPV_MSG_FATAL:
                    case SPV_MSG_INTERNAL_ERROR:
                    case SPV_MSG_ERROR:
                        errorStream << "error: line " << position.index << ": " << message
                                    << std::endl;
                        break;
                    case SPV_MSG_WARNING:
                        errorStream << "warning: line " << position.index << ": " << message
                                    << std::endl;
                        break;
                    case SPV_MSG_INFO:
                        errorStream << "info: line " << position.index << ": " << message
                                    << std::endl;
                        break;
                    default:
                        break;
                }
            });

            if (!spirvTools.Validate(code, codeSize)) {
                return DAWN_VALIDATION_ERROR(errorStream.str().c_str());
            }

            return {};
        }

#ifdef DAWN_ENABLE_WGSL
        MaybeError ValidateWGSL(const char* source) {
            std::ostringstream errorStream;
            errorStream << "Tint WGSL failure:" << std::endl;

            tint::Context context;
            tint::reader::wgsl::Parser parser(&context, source);

            if (!parser.Parse()) {
                errorStream << "Parser: " << parser.error() << std::endl;
                return DAWN_VALIDATION_ERROR(errorStream.str().c_str());
            }

            tint::ast::Module module = parser.module();
            if (!module.IsValid()) {
                errorStream << "Invalid module generated..." << std::endl;
                return DAWN_VALIDATION_ERROR(errorStream.str().c_str());
            }

            tint::TypeDeterminer type_determiner(&context, &module);
            if (!type_determiner.Determine()) {
                errorStream << "Type Determination: " << type_determiner.error();
                return DAWN_VALIDATION_ERROR(errorStream.str().c_str());
            }

            tint::Validator validator;
            if (!validator.Validate(&module)) {
                errorStream << "Validation: " << validator.error() << std::endl;
                return DAWN_VALIDATION_ERROR(errorStream.str().c_str());
            }

            return {};
        }

        ResultOrError<std::vector<uint32_t>> ConvertWGSLToSPIRV(const char* source) {
            std::ostringstream errorStream;
            errorStream << "Tint WGSL->SPIR-V failure:" << std::endl;

            tint::Context context;
            tint::reader::wgsl::Parser parser(&context, source);

            // TODO: This is a duplicate parse with ValidateWGSL, need to store
            // state between calls to avoid this.
            if (!parser.Parse()) {
                errorStream << "Parser: " << parser.error() << std::endl;
                return DAWN_VALIDATION_ERROR(errorStream.str().c_str());
            }

            tint::ast::Module module = parser.module();
            if (!module.IsValid()) {
                errorStream << "Invalid module generated..." << std::endl;
                return DAWN_VALIDATION_ERROR(errorStream.str().c_str());
            }

            tint::TypeDeterminer type_determiner(&context, &module);
            if (!type_determiner.Determine()) {
                errorStream << "Type Determination: " << type_determiner.error();
                return DAWN_VALIDATION_ERROR(errorStream.str().c_str());
            }

            tint::writer::spirv::Generator generator(std::move(module));
            if (!generator.Generate()) {
                errorStream << "Generator: " << generator.error() << std::endl;
                return DAWN_VALIDATION_ERROR(errorStream.str().c_str());
            }

            std::vector<uint32_t> spirv = generator.result();
            return std::move(spirv);
        }

        ResultOrError<std::vector<uint32_t>> ConvertWGSLToSPIRVWithPulling(
            const char* source,
            const VertexStateDescriptor& vertexState,
            const std::string& entryPoint,
            uint32_t pullingBufferBindingSet) {
            std::ostringstream errorStream;
            errorStream << "Tint WGSL->SPIR-V failure:" << std::endl;

            tint::Context context;
            tint::reader::wgsl::Parser parser(&context, source);

            // TODO: This is a duplicate parse with ValidateWGSL, need to store
            // state between calls to avoid this.
            if (!parser.Parse()) {
                errorStream << "Parser: " << parser.error() << std::endl;
                return DAWN_VALIDATION_ERROR(errorStream.str().c_str());
            }

            tint::ast::Module module = parser.module();
            if (!module.IsValid()) {
                errorStream << "Invalid module generated..." << std::endl;
                return DAWN_VALIDATION_ERROR(errorStream.str().c_str());
            }

            tint::ast::transform::VertexPullingTransform transform(&context, &module);
            auto state = std::make_unique<tint::ast::transform::VertexStateDescriptor>();
            for (uint32_t i = 0; i < vertexState.vertexBufferCount; ++i) {
                auto& vertexBuffer = vertexState.vertexBuffers[i];
                tint::ast::transform::VertexBufferLayoutDescriptor layout;
                layout.array_stride = vertexBuffer.arrayStride;
                layout.step_mode = ToTintInputStepMode(vertexBuffer.stepMode);

                for (uint32_t j = 0; j < vertexBuffer.attributeCount; ++j) {
                    auto& attribute = vertexBuffer.attributes[j];
                    tint::ast::transform::VertexAttributeDescriptor attr;
                    attr.format = ToTintVertexFormat(attribute.format);
                    attr.offset = attribute.offset;
                    attr.shader_location = attribute.shaderLocation;

                    layout.attributes.push_back(std::move(attr));
                }

                state->vertex_buffers.push_back(std::move(layout));
            }
            transform.SetVertexState(std::move(state));
            transform.SetEntryPoint(entryPoint);
            transform.SetPullingBufferBindingSet(pullingBufferBindingSet);

            if (!transform.Run()) {
                errorStream << "Vertex pulling transform: " << transform.GetError();
                return DAWN_VALIDATION_ERROR(errorStream.str().c_str());
            }

            tint::TypeDeterminer type_determiner(&context, &module);
            if (!type_determiner.Determine()) {
                errorStream << "Type Determination: " << type_determiner.error();
                return DAWN_VALIDATION_ERROR(errorStream.str().c_str());
            }

            tint::writer::spirv::Generator generator(std::move(module));
            if (!generator.Generate()) {
                errorStream << "Generator: " << generator.error() << std::endl;
                return DAWN_VALIDATION_ERROR(errorStream.str().c_str());
            }

            std::vector<uint32_t> spirv = generator.result();
            return std::move(spirv);
        }
#endif  // DAWN_ENABLE_WGSL

        std::vector<uint64_t> GetBindGroupMinBufferSizes(
            const EntryPointMetadata::BindingGroupInfoMap& shaderBindings,
            const BindGroupLayoutBase* layout) {
            std::vector<uint64_t> requiredBufferSizes(layout->GetUnverifiedBufferCount());
            uint32_t packedIdx = 0;

            for (BindingIndex bindingIndex{0}; bindingIndex < layout->GetBufferCount();
                 ++bindingIndex) {
                const BindingInfo& bindingInfo = layout->GetBindingInfo(bindingIndex);
                if (bindingInfo.minBufferBindingSize != 0) {
                    // Skip bindings that have minimum buffer size set in the layout
                    continue;
                }

                ASSERT(packedIdx < requiredBufferSizes.size());
                const auto& shaderInfo = shaderBindings.find(bindingInfo.binding);
                if (shaderInfo != shaderBindings.end()) {
                    requiredBufferSizes[packedIdx] = shaderInfo->second.minBufferBindingSize;
                } else {
                    // We have to include buffers if they are included in the bind group's
                    // packed vector. We don't actually need to check these at draw time, so
                    // if this is a problem in the future we can optimize it further.
                    requiredBufferSizes[packedIdx] = 0;
                }
                ++packedIdx;
            }

            return requiredBufferSizes;
        }

        MaybeError ValidateCompatibilityWithBindGroupLayout(BindGroupIndex group,
                                                            const EntryPointMetadata& entryPoint,
                                                            const BindGroupLayoutBase* layout) {
            const BindGroupLayoutBase::BindingMap& layoutBindings = layout->GetBindingMap();

            // Iterate over all bindings used by this group in the shader, and find the
            // corresponding binding in the BindGroupLayout, if it exists.
            for (const auto& it : entryPoint.bindings[group]) {
                BindingNumber bindingNumber = it.first;
                const EntryPointMetadata::ShaderBindingInfo& shaderInfo = it.second;

                const auto& bindingIt = layoutBindings.find(bindingNumber);
                if (bindingIt == layoutBindings.end()) {
                    return DAWN_VALIDATION_ERROR("Missing bind group layout entry for " +
                                                 GetShaderDeclarationString(group, bindingNumber));
                }
                BindingIndex bindingIndex(bindingIt->second);
                const BindingInfo& layoutInfo = layout->GetBindingInfo(bindingIndex);

                if (layoutInfo.type != shaderInfo.type) {
                    // Binding mismatch between shader and bind group is invalid. For example, a
                    // writable binding in the shader with a readonly storage buffer in the bind
                    // group layout is invalid. However, a readonly binding in the shader with a
                    // writable storage buffer in the bind group layout is valid.
                    bool validBindingConversion =
                        layoutInfo.type == wgpu::BindingType::StorageBuffer &&
                        shaderInfo.type == wgpu::BindingType::ReadonlyStorageBuffer;

                    // TODO(crbug.com/dawn/367): Temporarily allow using either a sampler or a
                    // comparison sampler until we can perform the proper shader analysis of what
                    // type is used in the shader module.
                    validBindingConversion |=
                        (layoutInfo.type == wgpu::BindingType::Sampler &&
                         shaderInfo.type == wgpu::BindingType::ComparisonSampler);
                    validBindingConversion |=
                        (layoutInfo.type == wgpu::BindingType::ComparisonSampler &&
                         shaderInfo.type == wgpu::BindingType::Sampler);

                    if (!validBindingConversion) {
                        return DAWN_VALIDATION_ERROR(
                            "The binding type of the bind group layout entry conflicts " +
                            GetShaderDeclarationString(group, bindingNumber));
                    }
                }

                if ((layoutInfo.visibility & StageBit(entryPoint.stage)) == 0) {
                    return DAWN_VALIDATION_ERROR("The bind group layout entry for " +
                                                 GetShaderDeclarationString(group, bindingNumber) +
                                                 " is not visible for the shader stage");
                }

                switch (layoutInfo.type) {
                    case wgpu::BindingType::SampledTexture: {
                        if (layoutInfo.textureComponentType != shaderInfo.textureComponentType) {
                            return DAWN_VALIDATION_ERROR(
                                "The textureComponentType of the bind group layout entry is "
                                "different from " +
                                GetShaderDeclarationString(group, bindingNumber));
                        }

                        if (layoutInfo.viewDimension != shaderInfo.viewDimension) {
                            return DAWN_VALIDATION_ERROR(
                                "The viewDimension of the bind group layout entry is different "
                                "from " +
                                GetShaderDeclarationString(group, bindingNumber));
                        }
                        break;
                    }

                    case wgpu::BindingType::ReadonlyStorageTexture:
                    case wgpu::BindingType::WriteonlyStorageTexture: {
                        ASSERT(layoutInfo.storageTextureFormat != wgpu::TextureFormat::Undefined);
                        ASSERT(shaderInfo.storageTextureFormat != wgpu::TextureFormat::Undefined);
                        if (layoutInfo.storageTextureFormat != shaderInfo.storageTextureFormat) {
                            return DAWN_VALIDATION_ERROR(
                                "The storageTextureFormat of the bind group layout entry is "
                                "different from " +
                                GetShaderDeclarationString(group, bindingNumber));
                        }
                        if (layoutInfo.viewDimension != shaderInfo.viewDimension) {
                            return DAWN_VALIDATION_ERROR(
                                "The viewDimension of the bind group layout entry is different "
                                "from " +
                                GetShaderDeclarationString(group, bindingNumber));
                        }
                        break;
                    }

                    case wgpu::BindingType::UniformBuffer:
                    case wgpu::BindingType::ReadonlyStorageBuffer:
                    case wgpu::BindingType::StorageBuffer: {
                        if (layoutInfo.minBufferBindingSize != 0 &&
                            shaderInfo.minBufferBindingSize > layoutInfo.minBufferBindingSize) {
                            return DAWN_VALIDATION_ERROR(
                                "The minimum buffer size of the bind group layout entry is smaller "
                                "than " +
                                GetShaderDeclarationString(group, bindingNumber));
                        }
                        break;
                    }
                    case wgpu::BindingType::Sampler:
                    case wgpu::BindingType::ComparisonSampler:
                        break;

                    case wgpu::BindingType::StorageTexture:
                    default:
                        UNREACHABLE();
                        return DAWN_VALIDATION_ERROR("Unsupported binding type");
                }
            }

            return {};
        }

    }  // anonymous namespace

    MaybeError ValidateShaderModuleDescriptor(DeviceBase* device,
                                              const ShaderModuleDescriptor* descriptor) {
        const ChainedStruct* chainedDescriptor = descriptor->nextInChain;
        if (chainedDescriptor == nullptr) {
            return DAWN_VALIDATION_ERROR("Shader module descriptor missing chained descriptor");
        }
        // For now only a single SPIRV or WGSL subdescriptor is allowed.
        if (chainedDescriptor->nextInChain != nullptr) {
            return DAWN_VALIDATION_ERROR(
                "Shader module descriptor chained nextInChain must be nullptr");
        }

        switch (chainedDescriptor->sType) {
            case wgpu::SType::ShaderModuleSPIRVDescriptor: {
                const auto* spirvDesc =
                    static_cast<const ShaderModuleSPIRVDescriptor*>(chainedDescriptor);
                DAWN_TRY(ValidateSpirv(device, spirvDesc->code, spirvDesc->codeSize));
                break;
            }

            case wgpu::SType::ShaderModuleWGSLDescriptor: {
#ifdef DAWN_ENABLE_WGSL
                const auto* wgslDesc =
                    static_cast<const ShaderModuleWGSLDescriptor*>(chainedDescriptor);
                DAWN_TRY(ValidateWGSL(wgslDesc->source));
                break;
#else
                return DAWN_VALIDATION_ERROR("WGSL not supported (yet)");
#endif  // DAWN_ENABLE_WGSL
            }
            default:
                return DAWN_VALIDATION_ERROR("Unsupported sType");
        }

        return {};
    }

    RequiredBufferSizes ComputeRequiredBufferSizesForLayout(const EntryPointMetadata& entryPoint,
                                                            const PipelineLayoutBase* layout) {
        RequiredBufferSizes bufferSizes;
        for (BindGroupIndex group : IterateBitSet(layout->GetBindGroupLayoutsMask())) {
            bufferSizes[group] = GetBindGroupMinBufferSizes(entryPoint.bindings[group],
                                                            layout->GetBindGroupLayout(group));
        }

        return bufferSizes;
    }

    MaybeError ValidateCompatibilityWithPipelineLayout(const EntryPointMetadata& entryPoint,
                                                       const PipelineLayoutBase* layout) {
        for (BindGroupIndex group : IterateBitSet(layout->GetBindGroupLayoutsMask())) {
            DAWN_TRY(ValidateCompatibilityWithBindGroupLayout(group, entryPoint,
                                                              layout->GetBindGroupLayout(group)));
        }

        for (BindGroupIndex group : IterateBitSet(~layout->GetBindGroupLayoutsMask())) {
            if (entryPoint.bindings[group].size() > 0) {
                std::ostringstream ostream;
                ostream << "No bind group layout entry matches the declaration set "
                        << static_cast<uint32_t>(group) << " in the shader module";
                return DAWN_VALIDATION_ERROR(ostream.str());
            }
        }

        return {};
    }

    // EntryPointMetadata

    EntryPointMetadata::EntryPointMetadata() {
        fragmentOutputFormatBaseTypes.fill(Format::Type::Other);
    }

    // ShaderModuleBase

    ShaderModuleBase::ShaderModuleBase(DeviceBase* device, const ShaderModuleDescriptor* descriptor)
        : CachedObject(device), mType(Type::Undefined) {
        ASSERT(descriptor->nextInChain != nullptr);
        switch (descriptor->nextInChain->sType) {
            case wgpu::SType::ShaderModuleSPIRVDescriptor: {
                mType = Type::Spirv;
                const auto* spirvDesc =
                    static_cast<const ShaderModuleSPIRVDescriptor*>(descriptor->nextInChain);
                mSpirv.assign(spirvDesc->code, spirvDesc->code + spirvDesc->codeSize);
                break;
            }
            case wgpu::SType::ShaderModuleWGSLDescriptor: {
                mType = Type::Wgsl;
                const auto* wgslDesc =
                    static_cast<const ShaderModuleWGSLDescriptor*>(descriptor->nextInChain);
                mWgsl = std::string(wgslDesc->source);
                break;
            }
            default:
                UNREACHABLE();
        }
    }

    ShaderModuleBase::ShaderModuleBase(DeviceBase* device, ObjectBase::ErrorTag tag)
        : CachedObject(device, tag), mType(Type::Undefined) {
    }

    ShaderModuleBase::~ShaderModuleBase() {
        if (IsCachedReference()) {
            GetDevice()->UncacheShaderModule(this);
        }
    }

    // static
    ShaderModuleBase* ShaderModuleBase::MakeError(DeviceBase* device) {
        return new ShaderModuleBase(device, ObjectBase::kError);
    }

    bool ShaderModuleBase::HasEntryPoint(const std::string& entryPoint,
                                         SingleShaderStage stage) const {
        // TODO(dawn:216): Properly extract all entryPoints from the shader module.
        return entryPoint == "main" && stage == mMainEntryPoint->stage;
    }

    const EntryPointMetadata& ShaderModuleBase::GetEntryPoint(const std::string& entryPoint,
                                                              SingleShaderStage stage) const {
        // TODO(dawn:216): Properly extract all entryPoints from the shader module.
        ASSERT(entryPoint == "main");
        ASSERT(stage == mMainEntryPoint->stage);
        return *mMainEntryPoint;
    }

    MaybeError ShaderModuleBase::ExtractSpirvInfo(const spirv_cross::Compiler& compiler) {
        ASSERT(!IsError());
        DAWN_TRY_ASSIGN(mMainEntryPoint, ExtractSpirvInfoImpl(compiler));
        return {};
    }

    ResultOrError<std::unique_ptr<EntryPointMetadata>> ShaderModuleBase::ExtractSpirvInfoImpl(
        const spirv_cross::Compiler& compiler) {
        DeviceBase* device = GetDevice();
        std::unique_ptr<EntryPointMetadata> metadata = std::make_unique<EntryPointMetadata>();

        // TODO(cwallez@chromium.org): make errors here creation errors
        // currently errors here do not prevent the shadermodule from being used
        const auto& resources = compiler.get_shader_resources();

        switch (compiler.get_execution_model()) {
            case spv::ExecutionModelVertex:
                metadata->stage = SingleShaderStage::Vertex;
                break;
            case spv::ExecutionModelFragment:
                metadata->stage = SingleShaderStage::Fragment;
                break;
            case spv::ExecutionModelGLCompute:
                metadata->stage = SingleShaderStage::Compute;
                break;
            default:
                UNREACHABLE();
                return DAWN_VALIDATION_ERROR("Unexpected shader execution model");
        }

        if (resources.push_constant_buffers.size() > 0) {
            return DAWN_VALIDATION_ERROR("Push constants aren't supported.");
        }

        if (resources.sampled_images.size() > 0) {
            return DAWN_VALIDATION_ERROR("Combined images and samplers aren't supported.");
        }

        // Fill in bindingInfo with the SPIRV bindings
        auto ExtractResourcesBinding =
            [](const DeviceBase* device,
               const spirv_cross::SmallVector<spirv_cross::Resource>& resources,
               const spirv_cross::Compiler& compiler, wgpu::BindingType bindingType,
               EntryPointMetadata::BindingInfo* metadataBindings) -> MaybeError {
            for (const auto& resource : resources) {
                if (!compiler.get_decoration_bitset(resource.id).get(spv::DecorationBinding)) {
                    return DAWN_VALIDATION_ERROR("No Binding decoration set for resource");
                }

                if (!compiler.get_decoration_bitset(resource.id)
                         .get(spv::DecorationDescriptorSet)) {
                    return DAWN_VALIDATION_ERROR("No Descriptor Decoration set for resource");
                }

                BindingNumber bindingNumber(
                    compiler.get_decoration(resource.id, spv::DecorationBinding));
                BindGroupIndex bindGroupIndex(
                    compiler.get_decoration(resource.id, spv::DecorationDescriptorSet));

                if (bindGroupIndex >= kMaxBindGroupsTyped) {
                    return DAWN_VALIDATION_ERROR("Bind group index over limits in the SPIRV");
                }

                const auto& it = (*metadataBindings)[bindGroupIndex].emplace(
                    bindingNumber, EntryPointMetadata::ShaderBindingInfo{});
                if (!it.second) {
                    return DAWN_VALIDATION_ERROR("Shader has duplicate bindings");
                }

                EntryPointMetadata::ShaderBindingInfo* info = &it.first->second;
                info->id = resource.id;
                info->base_type_id = resource.base_type_id;

                if (bindingType == wgpu::BindingType::UniformBuffer ||
                    bindingType == wgpu::BindingType::StorageBuffer ||
                    bindingType == wgpu::BindingType::ReadonlyStorageBuffer) {
                    // Determine buffer size, with a minimum of 1 element in the runtime array
                    spirv_cross::SPIRType type = compiler.get_type(info->base_type_id);
                    info->minBufferBindingSize =
                        compiler.get_declared_struct_size_runtime_array(type, 1);
                }

                switch (bindingType) {
                    case wgpu::BindingType::SampledTexture: {
                        spirv_cross::SPIRType::ImageType imageType =
                            compiler.get_type(info->base_type_id).image;
                        spirv_cross::SPIRType::BaseType textureComponentType =
                            compiler.get_type(imageType.type).basetype;

                        info->multisampled = imageType.ms;
                        info->viewDimension =
                            SpirvDimToTextureViewDimension(imageType.dim, imageType.arrayed);
                        info->textureComponentType =
                            SpirvCrossBaseTypeToFormatType(textureComponentType);
                        info->type = bindingType;
                        break;
                    }
                    case wgpu::BindingType::StorageBuffer: {
                        // Differentiate between readonly storage bindings and writable ones
                        // based on the NonWritable decoration
                        spirv_cross::Bitset flags = compiler.get_buffer_block_flags(resource.id);
                        if (flags.get(spv::DecorationNonWritable)) {
                            info->type = wgpu::BindingType::ReadonlyStorageBuffer;
                        } else {
                            info->type = wgpu::BindingType::StorageBuffer;
                        }
                        break;
                    }
                    case wgpu::BindingType::StorageTexture: {
                        spirv_cross::Bitset flags = compiler.get_decoration_bitset(resource.id);
                        if (flags.get(spv::DecorationNonReadable)) {
                            info->type = wgpu::BindingType::WriteonlyStorageTexture;
                        } else if (flags.get(spv::DecorationNonWritable)) {
                            info->type = wgpu::BindingType::ReadonlyStorageTexture;
                        } else {
                            info->type = wgpu::BindingType::StorageTexture;
                        }

                        spirv_cross::SPIRType::ImageType imageType =
                            compiler.get_type(info->base_type_id).image;
                        wgpu::TextureFormat storageTextureFormat =
                            ToWGPUTextureFormat(imageType.format);
                        if (storageTextureFormat == wgpu::TextureFormat::Undefined) {
                            return DAWN_VALIDATION_ERROR(
                                "Invalid image format declaration on storage image");
                        }
                        const Format& format = device->GetValidInternalFormat(storageTextureFormat);
                        if (!format.supportsStorageUsage) {
                            return DAWN_VALIDATION_ERROR(
                                "The storage texture format is not supported");
                        }
                        info->multisampled = imageType.ms;
                        info->storageTextureFormat = storageTextureFormat;
                        info->viewDimension =
                            SpirvDimToTextureViewDimension(imageType.dim, imageType.arrayed);
                        break;
                    }
                    default:
                        info->type = bindingType;
                }
            }
            return {};
        };

        DAWN_TRY(ExtractResourcesBinding(device, resources.uniform_buffers, compiler,
                                         wgpu::BindingType::UniformBuffer, &metadata->bindings));
        DAWN_TRY(ExtractResourcesBinding(device, resources.separate_images, compiler,
                                         wgpu::BindingType::SampledTexture, &metadata->bindings));
        DAWN_TRY(ExtractResourcesBinding(device, resources.separate_samplers, compiler,
                                         wgpu::BindingType::Sampler, &metadata->bindings));
        DAWN_TRY(ExtractResourcesBinding(device, resources.storage_buffers, compiler,
                                         wgpu::BindingType::StorageBuffer, &metadata->bindings));
        DAWN_TRY(ExtractResourcesBinding(device, resources.storage_images, compiler,
                                         wgpu::BindingType::StorageTexture, &metadata->bindings));

        // Extract the vertex attributes
        if (metadata->stage == SingleShaderStage::Vertex) {
            for (const auto& attrib : resources.stage_inputs) {
                if (!(compiler.get_decoration_bitset(attrib.id).get(spv::DecorationLocation))) {
                    return DAWN_VALIDATION_ERROR(
                        "Unable to find Location decoration for Vertex input");
                }
                uint32_t location = compiler.get_decoration(attrib.id, spv::DecorationLocation);

                if (location >= kMaxVertexAttributes) {
                    return DAWN_VALIDATION_ERROR("Attribute location over limits in the SPIRV");
                }

                metadata->usedVertexAttributes.set(location);
            }

            // Without a location qualifier on vertex outputs, spirv_cross::CompilerMSL gives
            // them all the location 0, causing a compile error.
            for (const auto& attrib : resources.stage_outputs) {
                if (!compiler.get_decoration_bitset(attrib.id).get(spv::DecorationLocation)) {
                    return DAWN_VALIDATION_ERROR("Need location qualifier on vertex output");
                }
            }
        }

        if (metadata->stage == SingleShaderStage::Fragment) {
            // Without a location qualifier on vertex inputs, spirv_cross::CompilerMSL gives
            // them all the location 0, causing a compile error.
            for (const auto& attrib : resources.stage_inputs) {
                if (!compiler.get_decoration_bitset(attrib.id).get(spv::DecorationLocation)) {
                    return DAWN_VALIDATION_ERROR("Need location qualifier on fragment input");
                }
            }

            for (const auto& fragmentOutput : resources.stage_outputs) {
                if (!compiler.get_decoration_bitset(fragmentOutput.id)
                         .get(spv::DecorationLocation)) {
                    return DAWN_VALIDATION_ERROR(
                        "Unable to find Location decoration for Fragment output");
                }
                uint32_t unsanitizedAttachment =
                    compiler.get_decoration(fragmentOutput.id, spv::DecorationLocation);
                if (unsanitizedAttachment >= kMaxColorAttachments) {
                    return DAWN_VALIDATION_ERROR(
                        "Fragment output attachment index must be less than max number of color "
                        "attachments");
                }
                ColorAttachmentIndex attachment(static_cast<uint8_t>(unsanitizedAttachment));

                spirv_cross::SPIRType::BaseType shaderFragmentOutputBaseType =
                    compiler.get_type(fragmentOutput.base_type_id).basetype;
                Format::Type formatType =
                    SpirvCrossBaseTypeToFormatType(shaderFragmentOutputBaseType);
                if (formatType == Format::Type::Other) {
                    return DAWN_VALIDATION_ERROR("Unexpected Fragment output type");
                }
                metadata->fragmentOutputFormatBaseTypes[attachment] = formatType;
            }
        }

        return {std::move(metadata)};
    }

    size_t ShaderModuleBase::HashFunc::operator()(const ShaderModuleBase* module) const {
        size_t hash = 0;

        for (uint32_t word : module->mSpirv) {
            HashCombine(&hash, word);
        }

        return hash;
    }

    bool ShaderModuleBase::EqualityFunc::operator()(const ShaderModuleBase* a,
                                                    const ShaderModuleBase* b) const {
        return a->mSpirv == b->mSpirv;
    }

    const std::vector<uint32_t>& ShaderModuleBase::GetSpirv() const {
        return mSpirv;
    }

#ifdef DAWN_ENABLE_WGSL
    ResultOrError<std::vector<uint32_t>> ShaderModuleBase::GeneratePullingSpirv(
        const VertexStateDescriptor& vertexState,
        const std::string& entryPoint,
        uint32_t pullingBufferBindingSet) const {
        return ConvertWGSLToSPIRVWithPulling(mWgsl.c_str(), vertexState, entryPoint,
                                             pullingBufferBindingSet);
    }
#endif

    MaybeError ShaderModuleBase::InitializeBase() {
        if (mType == Type::Wgsl) {
#ifdef DAWN_ENABLE_WGSL
            DAWN_TRY_ASSIGN(mSpirv, ConvertWGSLToSPIRV(mWgsl.c_str()));
#else
            return DAWN_VALIDATION_ERROR("WGSL not supported (yet)");
#endif  // DAWN_ENABLE_WGSL
        }

        return {};
    }

    SingleShaderStage ShaderModuleBase::GetMainEntryPointStageForTransition() const {
        ASSERT(!IsError());
        return mMainEntryPoint->stage;
    }

}  // namespace dawn_native
