SKIP: FAILED

RWByteAddressBuffer prevent_dce : register(u0);

uint3 subgroupExclusiveMul_f039f4() {
  uint3 res = WavePrefixProduct((1u).xxx);
  return res;
}

[numthreads(1, 1, 1)]
void compute_main() {
  prevent_dce.Store3(0u, asuint(subgroupExclusiveMul_f039f4()));
  return;
}
FXC validation failure:
C:\src\dawn\Shader@0x000001EB5103F970(4,15-41): error X3004: undeclared identifier 'WavePrefixProduct'

