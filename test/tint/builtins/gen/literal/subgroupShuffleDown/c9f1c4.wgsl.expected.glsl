SKIP: FAILED


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec2<u32>;

fn subgroupShuffleDown_c9f1c4() -> vec2<u32> {
  var res : vec2<u32> = subgroupShuffleDown(vec2<u32>(1u), 1u);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupShuffleDown_c9f1c4();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupShuffleDown_c9f1c4();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupShuffleDown/c9f1c4.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec2<u32>;

fn subgroupShuffleDown_c9f1c4() -> vec2<u32> {
  var res : vec2<u32> = subgroupShuffleDown(vec2<u32>(1u), 1u);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupShuffleDown_c9f1c4();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupShuffleDown_c9f1c4();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupShuffleDown/c9f1c4.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

