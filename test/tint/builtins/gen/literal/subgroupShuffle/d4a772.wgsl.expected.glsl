SKIP: FAILED


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : i32;

fn subgroupShuffle_d4a772() -> i32 {
  var res : i32 = subgroupShuffle(1i, 1u);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupShuffle_d4a772();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupShuffle_d4a772();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupShuffle/d4a772.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : i32;

fn subgroupShuffle_d4a772() -> i32 {
  var res : i32 = subgroupShuffle(1i, 1u);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupShuffle_d4a772();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupShuffle_d4a772();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupShuffle/d4a772.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

