SKIP: FAILED

RWByteAddressBuffer prevent_dce : register(u0);

float16_t subgroupBroadcast_07e2d8() {
  float16_t res = WaveReadLaneAt(float16_t(1.0h), 1u);
  return res;
}

[numthreads(1, 1, 1)]
void compute_main() {
  prevent_dce.Store<float16_t>(0u, subgroupBroadcast_07e2d8());
  return;
}
FXC validation failure:
C:\src\dawn\Shader@0x00000207D706F440(3,1-9): error X3000: unrecognized identifier 'float16_t'

