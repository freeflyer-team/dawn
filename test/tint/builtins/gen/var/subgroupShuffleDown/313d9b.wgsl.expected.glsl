SKIP: FAILED


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec4<i32>;

fn subgroupShuffleDown_313d9b() -> vec4<i32> {
  var arg_0 = vec4<i32>(1i);
  var arg_1 = 1u;
  var res : vec4<i32> = subgroupShuffleDown(arg_0, arg_1);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupShuffleDown_313d9b();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupShuffleDown_313d9b();
}

Failed to generate: <dawn>/test/tint/builtins/gen/var/subgroupShuffleDown/313d9b.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec4<i32>;

fn subgroupShuffleDown_313d9b() -> vec4<i32> {
  var arg_0 = vec4<i32>(1i);
  var arg_1 = 1u;
  var res : vec4<i32> = subgroupShuffleDown(arg_0, arg_1);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupShuffleDown_313d9b();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupShuffleDown_313d9b();
}

Failed to generate: <dawn>/test/tint/builtins/gen/var/subgroupShuffleDown/313d9b.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

