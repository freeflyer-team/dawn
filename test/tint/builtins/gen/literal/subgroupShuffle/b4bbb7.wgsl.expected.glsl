SKIP: FAILED


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec3<i32>;

fn subgroupShuffle_b4bbb7() -> vec3<i32> {
  var res : vec3<i32> = subgroupShuffle(vec3<i32>(1i), 1u);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupShuffle_b4bbb7();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupShuffle_b4bbb7();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupShuffle/b4bbb7.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec3<i32>;

fn subgroupShuffle_b4bbb7() -> vec3<i32> {
  var res : vec3<i32> = subgroupShuffle(vec3<i32>(1i), 1u);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupShuffle_b4bbb7();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupShuffle_b4bbb7();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupShuffle/b4bbb7.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

