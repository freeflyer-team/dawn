SKIP: Wave ops not supported before SM 6.0

RWByteAddressBuffer prevent_dce : register(u0);

int4 subgroupShuffle_2ee993() {
  int4 arg_0 = (1).xxxx;
  int arg_1 = 1;
  int4 res = WaveReadLaneAt(arg_0, arg_1);
  return res;
}

void fragment_main() {
  prevent_dce.Store4(0u, asuint(subgroupShuffle_2ee993()));
  return;
}

[numthreads(1, 1, 1)]
void compute_main() {
  prevent_dce.Store4(0u, asuint(subgroupShuffle_2ee993()));
  return;
}
