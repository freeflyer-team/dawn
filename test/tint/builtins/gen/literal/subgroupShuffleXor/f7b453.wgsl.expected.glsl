SKIP: FAILED


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec2<f32>;

fn subgroupShuffleXor_f7b453() -> vec2<f32> {
  var res : vec2<f32> = subgroupShuffleXor(vec2<f32>(1.0f), 1u);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupShuffleXor_f7b453();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupShuffleXor_f7b453();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupShuffleXor/f7b453.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec2<f32>;

fn subgroupShuffleXor_f7b453() -> vec2<f32> {
  var res : vec2<f32> = subgroupShuffleXor(vec2<f32>(1.0f), 1u);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupShuffleXor_f7b453();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupShuffleXor_f7b453();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupShuffleXor/f7b453.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

