SKIP: FAILED

RWByteAddressBuffer prevent_dce : register(u0);

int2 subgroupAdd_1eb429() {
  int2 arg_0 = (1).xx;
  int2 res = WaveActiveSum(arg_0);
  return res;
}

[numthreads(1, 1, 1)]
void compute_main() {
  prevent_dce.Store2(0u, asuint(subgroupAdd_1eb429()));
  return;
}
FXC validation failure:
C:\src\dawn\Shader@0x00000228FD2163D0(5,14-33): error X3004: undeclared identifier 'WaveActiveSum'

