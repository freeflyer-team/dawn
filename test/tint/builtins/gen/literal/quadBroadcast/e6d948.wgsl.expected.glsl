SKIP: FAILED


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : u32;

fn quadBroadcast_e6d948() -> u32 {
  var res : u32 = quadBroadcast(1u, 1u);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = quadBroadcast_e6d948();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = quadBroadcast_e6d948();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/quadBroadcast/e6d948.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : u32;

fn quadBroadcast_e6d948() -> u32 {
  var res : u32 = quadBroadcast(1u, 1u);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = quadBroadcast_e6d948();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = quadBroadcast_e6d948();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/quadBroadcast/e6d948.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

