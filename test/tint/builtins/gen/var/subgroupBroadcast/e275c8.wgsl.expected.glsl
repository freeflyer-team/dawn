SKIP: FAILED


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec3<i32>;

fn subgroupBroadcast_e275c8() -> vec3<i32> {
  var arg_0 = vec3<i32>(1i);
  const arg_1 = 1u;
  var res : vec3<i32> = subgroupBroadcast(arg_0, arg_1);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupBroadcast_e275c8();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupBroadcast_e275c8();
}

Failed to generate: <dawn>/test/tint/builtins/gen/var/subgroupBroadcast/e275c8.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec3<i32>;

fn subgroupBroadcast_e275c8() -> vec3<i32> {
  var arg_0 = vec3<i32>(1i);
  const arg_1 = 1u;
  var res : vec3<i32> = subgroupBroadcast(arg_0, arg_1);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupBroadcast_e275c8();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupBroadcast_e275c8();
}

Failed to generate: <dawn>/test/tint/builtins/gen/var/subgroupBroadcast/e275c8.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

