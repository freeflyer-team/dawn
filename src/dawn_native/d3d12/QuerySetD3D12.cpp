// Copyright 2020 The Dawn Authors
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

#include "dawn_native/d3d12/QuerySetD3D12.h"

#include "dawn_native/d3d12/D3D12Error.h"
#include "dawn_native/d3d12/DeviceD3D12.h"

namespace dawn_native { namespace d3d12 {

    namespace {
        D3D12_QUERY_HEAP_TYPE D3D12QueryHeapType(wgpu::QueryType type) {
            switch (type) {
                case wgpu::QueryType::Occlusion:
                    return D3D12_QUERY_HEAP_TYPE_OCCLUSION;
                case wgpu::QueryType::PipelineStatistics:
                    return D3D12_QUERY_HEAP_TYPE_PIPELINE_STATISTICS;
                case wgpu::QueryType::Timestamp:
                    return D3D12_QUERY_HEAP_TYPE_TIMESTAMP;
            }
        }
    }  // anonymous namespace

    // static
    ResultOrError<Ref<QuerySet>> QuerySet::Create(Device* device,
                                                  const QuerySetDescriptor* descriptor) {
        Ref<QuerySet> querySet = AcquireRef(new QuerySet(device, descriptor));
        DAWN_TRY(querySet->Initialize());
        return querySet;
    }

    MaybeError QuerySet::Initialize() {
        D3D12_QUERY_HEAP_DESC queryHeapDesc = {};
        queryHeapDesc.Type = D3D12QueryHeapType(GetQueryType());
        queryHeapDesc.Count = GetQueryCount();

        ID3D12Device* d3d12Device = ToBackend(GetDevice())->GetD3D12Device();
        return CheckOutOfMemoryHRESULT(
            d3d12Device->CreateQueryHeap(&queryHeapDesc, IID_PPV_ARGS(&mQueryHeap)),
            "ID3D12Device::CreateQueryHeap");
    }

    ID3D12QueryHeap* QuerySet::GetQueryHeap() const {
        return mQueryHeap.Get();
    }

    QuerySet::~QuerySet() {
        DestroyInternal();
    }

    void QuerySet::DestroyImpl() {
        ToBackend(GetDevice())->ReferenceUntilUnused(mQueryHeap);
    }

}}  // namespace dawn_native::d3d12
