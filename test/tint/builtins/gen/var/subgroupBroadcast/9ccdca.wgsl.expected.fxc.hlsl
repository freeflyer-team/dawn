SKIP: Wave ops not supported before SM 6.0

RWByteAddressBuffer prevent_dce : register(u0);

int subgroupBroadcast_9ccdca() {
  int arg_0 = 1;
  int res = WaveReadLaneAt(arg_0, 1);
  return res;
}

void fragment_main() {
  prevent_dce.Store(0u, asuint(subgroupBroadcast_9ccdca()));
  return;
}

[numthreads(1, 1, 1)]
void compute_main() {
  prevent_dce.Store(0u, asuint(subgroupBroadcast_9ccdca()));
  return;
}
