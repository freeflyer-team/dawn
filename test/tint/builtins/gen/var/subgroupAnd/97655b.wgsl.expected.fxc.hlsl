SKIP: FAILED

RWByteAddressBuffer prevent_dce : register(u0);

int4 subgroupAnd_97655b() {
  int4 arg_0 = (1).xxxx;
  int4 res = asint(WaveActiveBitAnd(asuint(arg_0)));
  return res;
}

[numthreads(1, 1, 1)]
void compute_main() {
  prevent_dce.Store4(0u, asuint(subgroupAnd_97655b()));
  return;
}
FXC validation failure:
C:\src\dawn\Shader@0x00000147CD86DCC0(5,20-50): error X3004: undeclared identifier 'WaveActiveBitAnd'

