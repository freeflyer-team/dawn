SKIP: FAILED


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : u32;

fn quadBroadcast_a2d2b4() -> u32 {
  var res : u32 = quadBroadcast(1u, 1i);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = quadBroadcast_a2d2b4();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = quadBroadcast_a2d2b4();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/quadBroadcast/a2d2b4.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : u32;

fn quadBroadcast_a2d2b4() -> u32 {
  var res : u32 = quadBroadcast(1u, 1i);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = quadBroadcast_a2d2b4();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = quadBroadcast_a2d2b4();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/quadBroadcast/a2d2b4.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

