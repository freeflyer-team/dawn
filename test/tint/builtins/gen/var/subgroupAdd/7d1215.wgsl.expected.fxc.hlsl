SKIP: FAILED

RWByteAddressBuffer prevent_dce : register(u0);

float3 subgroupAdd_7d1215() {
  float3 arg_0 = (1.0f).xxx;
  float3 res = WaveActiveSum(arg_0);
  return res;
}

[numthreads(1, 1, 1)]
void compute_main() {
  prevent_dce.Store3(0u, asuint(subgroupAdd_7d1215()));
  return;
}
FXC validation failure:
C:\src\dawn\Shader@0x0000022CB470F2E0(5,16-35): error X3004: undeclared identifier 'WaveActiveSum'

