SKIP: FAILED

RWByteAddressBuffer prevent_dce : register(u0);

int subgroupXor_694b17() {
  int arg_0 = 1;
  int res = asint(WaveActiveBitXor(asuint(arg_0)));
  return res;
}

[numthreads(1, 1, 1)]
void compute_main() {
  prevent_dce.Store(0u, asuint(subgroupXor_694b17()));
  return;
}
FXC validation failure:
C:\src\dawn\Shader@0x00000202AF560C30(5,19-49): error X3004: undeclared identifier 'WaveActiveBitXor'

