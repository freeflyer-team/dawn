SKIP: FAILED

RWByteAddressBuffer prevent_dce : register(u0);

float2 subgroupAdd_dcf73f() {
  float2 arg_0 = (1.0f).xx;
  float2 res = WaveActiveSum(arg_0);
  return res;
}

[numthreads(1, 1, 1)]
void compute_main() {
  prevent_dce.Store2(0u, asuint(subgroupAdd_dcf73f()));
  return;
}
FXC validation failure:
C:\src\dawn\Shader@0x0000018791DB7DD0(5,16-35): error X3004: undeclared identifier 'WaveActiveSum'

