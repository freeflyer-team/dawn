SKIP: FAILED

RWByteAddressBuffer prevent_dce : register(u0);

float4 subgroupAdd_8f4c15() {
  float4 arg_0 = (1.0f).xxxx;
  float4 res = WaveActiveSum(arg_0);
  return res;
}

[numthreads(1, 1, 1)]
void compute_main() {
  prevent_dce.Store4(0u, asuint(subgroupAdd_8f4c15()));
  return;
}
FXC validation failure:
C:\src\dawn\Shader@0x0000024228742450(5,16-35): error X3004: undeclared identifier 'WaveActiveSum'

