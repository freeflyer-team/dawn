SKIP: FAILED


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec4<u32>;

fn subgroupBroadcastFirst_612d6f() -> vec4<u32> {
  var res : vec4<u32> = subgroupBroadcastFirst(vec4<u32>(1u));
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupBroadcastFirst_612d6f();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupBroadcastFirst_612d6f();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupBroadcastFirst/612d6f.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec4<u32>;

fn subgroupBroadcastFirst_612d6f() -> vec4<u32> {
  var res : vec4<u32> = subgroupBroadcastFirst(vec4<u32>(1u));
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupBroadcastFirst_612d6f();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupBroadcastFirst_612d6f();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupBroadcastFirst/612d6f.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

