SKIP: FAILED


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec4<u32>;

fn subgroupShuffleUp_88eb07() -> vec4<u32> {
  var res : vec4<u32> = subgroupShuffleUp(vec4<u32>(1u), 1u);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupShuffleUp_88eb07();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupShuffleUp_88eb07();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupShuffleUp/88eb07.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^


enable subgroups;

@group(0) @binding(0) var<storage, read_write> prevent_dce : vec4<u32>;

fn subgroupShuffleUp_88eb07() -> vec4<u32> {
  var res : vec4<u32> = subgroupShuffleUp(vec4<u32>(1u), 1u);
  return res;
}

@fragment
fn fragment_main() {
  prevent_dce = subgroupShuffleUp_88eb07();
}

@compute @workgroup_size(1)
fn compute_main() {
  prevent_dce = subgroupShuffleUp_88eb07();
}

Failed to generate: <dawn>/test/tint/builtins/gen/literal/subgroupShuffleUp/88eb07.wgsl:41:8 error: GLSL backend does not support extension 'subgroups'
enable subgroups;
       ^^^^^^^^^

