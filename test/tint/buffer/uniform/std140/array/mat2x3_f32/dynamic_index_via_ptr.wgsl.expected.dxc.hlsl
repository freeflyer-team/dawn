cbuffer cbuffer_a : register(b0, space0) {
  uint4 a[8];
};
static int counter = 0;

int i() {
  counter = (counter + 1);
  return counter;
}

float2x3 tint_symbol_1(uint4 buffer[8], uint offset) {
  const uint scalar_offset = ((offset + 0u)) / 4;
  const uint scalar_offset_1 = ((offset + 16u)) / 4;
  return float2x3(asfloat(buffer[scalar_offset / 4].xyz), asfloat(buffer[scalar_offset_1 / 4].xyz));
}

typedef float2x3 tint_symbol_ret[4];
tint_symbol_ret tint_symbol(uint4 buffer[8], uint offset) {
  float2x3 arr[4] = (float2x3[4])0;
  {
    for(uint i_1 = 0u; (i_1 < 4u); i_1 = (i_1 + 1u)) {
      arr[i_1] = tint_symbol_1(buffer, (offset + (i_1 * 32u)));
    }
  }
  return arr;
}

[numthreads(1, 1, 1)]
void f() {
  const int p_a_i_save = i();
  const int p_a_i_i_save = i();
  const float2x3 l_a[4] = tint_symbol(a, 0u);
  const float2x3 l_a_i = tint_symbol_1(a, (32u * uint(p_a_i_save)));
  const uint scalar_offset_2 = (((32u * uint(p_a_i_save)) + (16u * uint(p_a_i_i_save)))) / 4;
  const float3 l_a_i_i = asfloat(a[scalar_offset_2 / 4].xyz);
  return;
}
