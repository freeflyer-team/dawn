SKIP: FAILED


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec4<i32>;

fn subgroupShuffleXor_bdddba() -> vec4<i32> {
  var res : vec4<i32> = subgroupShuffleXor(vec4<i32>(1i), 1u);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupShuffleXor_bdddba();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupShuffleXor_bdddba();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupShuffleXor/bdddba.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec4<i32>;

fn subgroupShuffleXor_bdddba() -> vec4<i32> {
  var res : vec4<i32> = subgroupShuffleXor(vec4<i32>(1i), 1u);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupShuffleXor_bdddba();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupShuffleXor_bdddba();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupShuffleXor/bdddba.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

