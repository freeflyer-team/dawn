SKIP: FAILED


enable subgroups;
enable subgroups_f16;
enable f16;

@group(0) @binding(0) var<storage, read_write> prevent_dce : f16;

fn subgroupBroadcast_719ad6() -> f16 {
  var arg_0 = 1.0h;
  const arg_1 = 1i;
  var res : f16 = subgroupBroadcast(arg_0, arg_1);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupBroadcast_719ad6();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupBroadcast_719ad6();
}

Failed to generate: <dawn>/test/tint/builtins/gen/var/subgroupBroadcast/719ad6.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;
enable subgroups_f16;
enable f16;

@group(0) @binding(0) var<storage, read_write> prevent_dce : f16;

fn subgroupBroadcast_719ad6() -> f16 {
  var arg_0 = 1.0h;
  const arg_1 = 1i;
  var res : f16 = subgroupBroadcast(arg_0, arg_1);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupBroadcast_719ad6();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupBroadcast_719ad6();
}

Failed to generate: <dawn>/test/tint/builtins/gen/var/subgroupBroadcast/719ad6.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

