SKIP: FAILED

RWByteAddressBuffer prevent_dce : register(u0);

vector<float16_t, 2> subgroupMul_6aaaf3() {
  vector<float16_t, 2> res = WaveActiveProduct((float16_t(1.0h)).xx);
  return res;
}

[numthreads(1, 1, 1)]
void compute_main() {
  prevent_dce.Store<vector<float16_t, 2> >(0u, subgroupMul_6aaaf3());
  return;
}
FXC validation failure:
C:\src\dawn\Shader@0x000002112182F430(3,8-16): error X3000: syntax error: unexpected token 'float16_t'

