SKIP: FAILED


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec2<i32>;

fn quadBroadcast_c0e704() -> vec2<i32> {
  var res : vec2<i32> = quadBroadcast(vec2<i32>(1i), 1i);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = quadBroadcast_c0e704();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = quadBroadcast_c0e704();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/quadBroadcast/c0e704.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec2<i32>;

fn quadBroadcast_c0e704() -> vec2<i32> {
  var res : vec2<i32> = quadBroadcast(vec2<i32>(1i), 1i);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = quadBroadcast_c0e704();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = quadBroadcast_c0e704();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/quadBroadcast/c0e704.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

