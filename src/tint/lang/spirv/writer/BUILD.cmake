# Copyright 2023 The Tint Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

################################################################################
# File generated by 'tools/src/cmd/gen' using the template:
#   tools/src/cmd/gen/build/BUILD.cmake.tmpl
#
# To regenerate run: './tools/run gen'
#
#                       Do not modify this file directly
################################################################################

include(lang/spirv/writer/ast_printer/BUILD.cmake)
include(lang/spirv/writer/ast_raise/BUILD.cmake)
include(lang/spirv/writer/common/BUILD.cmake)
include(lang/spirv/writer/printer/BUILD.cmake)
include(lang/spirv/writer/raise/BUILD.cmake)

if(TINT_BUILD_SPV_WRITER)
################################################################################
# Target:    tint_lang_spirv_writer
# Kind:      lib
# Condition: TINT_BUILD_SPV_WRITER
################################################################################
tint_add_target(tint_lang_spirv_writer lib
  lang/spirv/writer/output.h
  lang/spirv/writer/writer.cc
  lang/spirv/writer/writer.h
)

tint_target_add_dependencies(tint_lang_spirv_writer lib
  tint_api_common
  tint_api_options
  tint_lang_core
  tint_lang_core_constant
  tint_lang_core_ir
  tint_lang_core_ir_transform
  tint_lang_core_type
  tint_lang_spirv_ir
  tint_lang_wgsl_ast
  tint_lang_wgsl_program
  tint_lang_wgsl_reader_program_to_ir
  tint_lang_wgsl_sem
  tint_utils_containers
  tint_utils_diagnostic
  tint_utils_ice
  tint_utils_id
  tint_utils_macros
  tint_utils_math
  tint_utils_memory
  tint_utils_reflection
  tint_utils_result
  tint_utils_rtti
  tint_utils_symbol
  tint_utils_text
  tint_utils_traits
)

if(TINT_BUILD_SPV_READER OR TINT_BUILD_SPV_WRITER)
  tint_target_add_external_dependencies(tint_lang_spirv_writer lib
    "spirv-headers"
  )
endif(TINT_BUILD_SPV_READER OR TINT_BUILD_SPV_WRITER)

if(TINT_BUILD_SPV_WRITER)
  tint_target_add_dependencies(tint_lang_spirv_writer lib
    tint_lang_spirv_writer_ast_printer
    tint_lang_spirv_writer_common
    tint_lang_spirv_writer_printer
    tint_lang_spirv_writer_raise
  )
endif(TINT_BUILD_SPV_WRITER)

endif(TINT_BUILD_SPV_WRITER)
if(TINT_BUILD_SPV_WRITER)
################################################################################
# Target:    tint_lang_spirv_writer_test
# Kind:      test
# Condition: TINT_BUILD_SPV_WRITER
################################################################################
tint_add_target(tint_lang_spirv_writer_test test
  lang/spirv/writer/access_test.cc
  lang/spirv/writer/atomic_builtin_test.cc
  lang/spirv/writer/binary_test.cc
  lang/spirv/writer/bitcast_test.cc
  lang/spirv/writer/builtin_test.cc
  lang/spirv/writer/constant_test.cc
  lang/spirv/writer/construct_test.cc
  lang/spirv/writer/convert_test.cc
  lang/spirv/writer/discard_test.cc
  lang/spirv/writer/function_test.cc
  lang/spirv/writer/if_test.cc
  lang/spirv/writer/let_test.cc
  lang/spirv/writer/loop_test.cc
  lang/spirv/writer/switch_test.cc
  lang/spirv/writer/swizzle_test.cc
  lang/spirv/writer/texture_builtin_test.cc
  lang/spirv/writer/type_test.cc
  lang/spirv/writer/unary_test.cc
  lang/spirv/writer/var_test.cc
  lang/spirv/writer/writer_test.cc
)

tint_target_add_dependencies(tint_lang_spirv_writer_test test
  tint_api_common
  tint_api_options
  tint_lang_core
  tint_lang_core_constant
  tint_lang_core_ir
  tint_lang_core_type
  tint_lang_spirv_ir
  tint_utils_containers
  tint_utils_diagnostic
  tint_utils_ice
  tint_utils_id
  tint_utils_macros
  tint_utils_math
  tint_utils_memory
  tint_utils_reflection
  tint_utils_result
  tint_utils_rtti
  tint_utils_symbol
  tint_utils_text
  tint_utils_traits
)

tint_target_add_external_dependencies(tint_lang_spirv_writer_test test
  "gtest"
)

if(TINT_BUILD_SPV_READER OR TINT_BUILD_SPV_WRITER)
  tint_target_add_external_dependencies(tint_lang_spirv_writer_test test
    "spirv-headers"
    "spirv-tools"
  )
endif(TINT_BUILD_SPV_READER OR TINT_BUILD_SPV_WRITER)

if(TINT_BUILD_SPV_WRITER)
  tint_target_add_dependencies(tint_lang_spirv_writer_test test
    tint_lang_spirv_writer_common
    tint_lang_spirv_writer_common_test
    tint_lang_spirv_writer_printer
    tint_lang_spirv_writer_raise
  )
endif(TINT_BUILD_SPV_WRITER)

endif(TINT_BUILD_SPV_WRITER)
if(TINT_BUILD_SPV_WRITER)
################################################################################
# Target:    tint_lang_spirv_writer_bench
# Kind:      bench
# Condition: TINT_BUILD_SPV_WRITER
################################################################################
tint_add_target(tint_lang_spirv_writer_bench bench
  lang/spirv/writer/writer_bench.cc
)

tint_target_add_dependencies(tint_lang_spirv_writer_bench bench
  tint_api_common
  tint_api_options
  tint_cmd_bench
  tint_lang_core
  tint_lang_core_constant
  tint_lang_core_type
  tint_lang_wgsl_ast
  tint_lang_wgsl_program
  tint_lang_wgsl_sem
  tint_utils_containers
  tint_utils_diagnostic
  tint_utils_ice
  tint_utils_id
  tint_utils_macros
  tint_utils_math
  tint_utils_memory
  tint_utils_reflection
  tint_utils_result
  tint_utils_rtti
  tint_utils_symbol
  tint_utils_text
  tint_utils_traits
)

if(TINT_BUILD_SPV_WRITER)
  tint_target_add_dependencies(tint_lang_spirv_writer_bench bench
    tint_lang_spirv_writer
    tint_lang_spirv_writer_common
  )
endif(TINT_BUILD_SPV_WRITER)

endif(TINT_BUILD_SPV_WRITER)