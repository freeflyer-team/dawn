SKIP: Wave ops not support before SM6.0

RWByteAddressBuffer prevent_dce : register(u0);

uint2 subgroupMax_b8fb0e() {
  uint2 arg_0 = (1u).xx;
  uint2 res = WaveActiveMax(arg_0);
  return res;
}

[numthreads(1, 1, 1)]
void compute_main() {
  prevent_dce.Store2(0u, asuint(subgroupMax_b8fb0e()));
  return;
}
