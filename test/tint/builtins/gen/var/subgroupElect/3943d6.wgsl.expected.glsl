SKIP: FAILED


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : i32;

fn subgroupElect_3943d6() -> i32 {
  var res : bool = subgroupElect();
  return select(0, 1, all((res == bool())));
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupElect_3943d6();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupElect_3943d6();
}

Failed to generate: <dawn>/test/tint/builtins/gen/var/subgroupElect/3943d6.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : i32;

fn subgroupElect_3943d6() -> i32 {
  var res : bool = subgroupElect();
  return select(0, 1, all((res == bool())));
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupElect_3943d6();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupElect_3943d6();
}

Failed to generate: <dawn>/test/tint/builtins/gen/var/subgroupElect/3943d6.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

