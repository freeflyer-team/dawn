SKIP: Wave ops not supported before SM 6.0

RWByteAddressBuffer prevent_dce : register(u0);

vector<float16_t, 3> subgroupShuffle_821df9() {
  vector<float16_t, 3> res = WaveReadLaneAt((float16_t(1.0h)).xxx, 1);
  return res;
}

void fragment_main() {
  prevent_dce.Store<vector<float16_t, 3> >(0u, subgroupShuffle_821df9());
  return;
}

[numthreads(1, 1, 1)]
void compute_main() {
  prevent_dce.Store<vector<float16_t, 3> >(0u, subgroupShuffle_821df9());
  return;
}
