SKIP: FAILED

RWByteAddressBuffer prevent_dce : register(u0);

uint subgroupMul_4f8ee6() {
  uint res = WaveActiveProduct(1u);
  return res;
}

[numthreads(1, 1, 1)]
void compute_main() {
  prevent_dce.Store(0u, asuint(subgroupMul_4f8ee6()));
  return;
}
FXC validation failure:
C:\src\dawn\Shader@0x00000268847D86C0(4,14-34): error X3004: undeclared identifier 'WaveActiveProduct'

