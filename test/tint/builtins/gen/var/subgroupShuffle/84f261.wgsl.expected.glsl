SKIP: FAILED


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec4<u32>;

fn subgroupShuffle_84f261() -> vec4<u32> {
  var arg_0 = vec4<u32>(1u);
  var arg_1 = 1u;
  var res : vec4<u32> = subgroupShuffle(arg_0, arg_1);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupShuffle_84f261();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupShuffle_84f261();
}

Failed to generate: <dawn>/test/tint/builtins/gen/var/subgroupShuffle/84f261.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec4<u32>;

fn subgroupShuffle_84f261() -> vec4<u32> {
  var arg_0 = vec4<u32>(1u);
  var arg_1 = 1u;
  var res : vec4<u32> = subgroupShuffle(arg_0, arg_1);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupShuffle_84f261();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupShuffle_84f261();
}

Failed to generate: <dawn>/test/tint/builtins/gen/var/subgroupShuffle/84f261.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

