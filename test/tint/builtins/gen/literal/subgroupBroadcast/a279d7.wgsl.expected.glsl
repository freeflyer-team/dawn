SKIP: FAILED


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec2<u32>;

fn subgroupBroadcast_a279d7() -> vec2<u32> {
  var res : vec2<u32> = subgroupBroadcast(vec2<u32>(1u), 1i);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupBroadcast_a279d7();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupBroadcast_a279d7();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupBroadcast/a279d7.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec2<u32>;

fn subgroupBroadcast_a279d7() -> vec2<u32> {
  var res : vec2<u32> = subgroupBroadcast(vec2<u32>(1u), 1i);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupBroadcast_a279d7();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupBroadcast_a279d7();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupBroadcast/a279d7.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

