SKIP: FAILED


enable subgroups;
enable subgroups_f16;
enable f16;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec2<f16>;

fn subgroupBroadcast_13f36c() -> vec2<f16> {
  var res : vec2<f16> = subgroupBroadcast(vec2<f16>(1.0h), 1u);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupBroadcast_13f36c();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupBroadcast_13f36c();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupBroadcast/13f36c.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;
enable subgroups_f16;
enable f16;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec2<f16>;

fn subgroupBroadcast_13f36c() -> vec2<f16> {
  var res : vec2<f16> = subgroupBroadcast(vec2<f16>(1.0h), 1u);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupBroadcast_13f36c();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupBroadcast_13f36c();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupBroadcast/13f36c.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

