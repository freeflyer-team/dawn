SKIP: FAILED


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : i32;

fn subgroupBroadcastFirst_9a1bdc() -> i32 {
  var arg_0 = 1i;
  var res : i32 = subgroupBroadcastFirst(arg_0);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupBroadcastFirst_9a1bdc();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupBroadcastFirst_9a1bdc();
}

Failed to generate: <dawn>/test/tint/builtins/gen/var/subgroupBroadcastFirst/9a1bdc.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : i32;

fn subgroupBroadcastFirst_9a1bdc() -> i32 {
  var arg_0 = 1i;
  var res : i32 = subgroupBroadcastFirst(arg_0);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupBroadcastFirst_9a1bdc();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupBroadcastFirst_9a1bdc();
}

Failed to generate: <dawn>/test/tint/builtins/gen/var/subgroupBroadcastFirst/9a1bdc.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

