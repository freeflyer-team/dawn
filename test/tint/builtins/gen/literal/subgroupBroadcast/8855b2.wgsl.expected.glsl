SKIP: FAILED


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec3<f32>;

fn subgroupBroadcast_8855b2() -> vec3<f32> {
  var res : vec3<f32> = subgroupBroadcast(vec3<f32>(1.0f), 1i);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupBroadcast_8855b2();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupBroadcast_8855b2();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupBroadcast/8855b2.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec3<f32>;

fn subgroupBroadcast_8855b2() -> vec3<f32> {
  var res : vec3<f32> = subgroupBroadcast(vec3<f32>(1.0f), 1i);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupBroadcast_8855b2();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupBroadcast_8855b2();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupBroadcast/8855b2.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

