SKIP: FAILED

RWByteAddressBuffer prevent_dce : register(u0);

float4 subgroupExclusiveAdd_71ad0f() {
  float4 arg_0 = (1.0f).xxxx;
  float4 res = WavePrefixSum(arg_0);
  return res;
}

[numthreads(1, 1, 1)]
void compute_main() {
  prevent_dce.Store4(0u, asuint(subgroupExclusiveAdd_71ad0f()));
  return;
}
FXC validation failure:
C:\src\dawn\Shader@0x0000019D312F7D40(5,16-35): error X3004: undeclared identifier 'WavePrefixSum'

