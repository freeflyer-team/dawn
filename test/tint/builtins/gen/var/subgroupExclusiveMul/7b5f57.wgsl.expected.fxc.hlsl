SKIP: FAILED

RWByteAddressBuffer prevent_dce : register(u0);

float4 subgroupExclusiveMul_7b5f57() {
  float4 arg_0 = (1.0f).xxxx;
  float4 res = WavePrefixProduct(arg_0);
  return res;
}

[numthreads(1, 1, 1)]
void compute_main() {
  prevent_dce.Store4(0u, asuint(subgroupExclusiveMul_7b5f57()));
  return;
}
FXC validation failure:
C:\src\dawn\Shader@0x000001868919D5F0(5,16-39): error X3004: undeclared identifier 'WavePrefixProduct'

