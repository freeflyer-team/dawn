SKIP: FAILED


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec3<i32>;

fn subgroupShuffle_824702() -> vec3<i32> {
  var res : vec3<i32> = subgroupShuffle(vec3<i32>(1i), 1i);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupShuffle_824702();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupShuffle_824702();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupShuffle/824702.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec3<i32>;

fn subgroupShuffle_824702() -> vec3<i32> {
  var res : vec3<i32> = subgroupShuffle(vec3<i32>(1i), 1i);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupShuffle_824702();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupShuffle_824702();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupShuffle/824702.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

