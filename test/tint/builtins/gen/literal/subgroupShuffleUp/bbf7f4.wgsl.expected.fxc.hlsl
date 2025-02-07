SKIP: Wave ops not supported before SM 6.0

RWByteAddressBuffer prevent_dce : register(u0);

float16_t subgroupShuffleUp_bbf7f4() {
  float16_t res = WaveReadLaneAt(float16_t(1.0h), (WaveGetLaneIndex() - 1u));
  return res;
}

void fragment_main() {
  prevent_dce.Store<float16_t>(0u, subgroupShuffleUp_bbf7f4());
  return;
}

[numthreads(1, 1, 1)]
void compute_main() {
  prevent_dce.Store<float16_t>(0u, subgroupShuffleUp_bbf7f4());
  return;
}
