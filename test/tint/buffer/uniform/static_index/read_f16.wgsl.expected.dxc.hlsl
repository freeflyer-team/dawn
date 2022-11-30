struct Inner {
  int scalar_i32;
  float scalar_f32;
  float16_t scalar_f16;
};

cbuffer cbuffer_ub : register(b0, space0) {
  uint4 ub[55];
};

float2x2 tint_symbol_16(uint4 buffer[55], uint offset) {
  const uint scalar_offset = ((offset + 0u)) / 4;
  uint4 ubo_load = buffer[scalar_offset / 4];
  const uint scalar_offset_1 = ((offset + 8u)) / 4;
  uint4 ubo_load_1 = buffer[scalar_offset_1 / 4];
  return float2x2(asfloat(((scalar_offset & 2) ? ubo_load.zw : ubo_load.xy)), asfloat(((scalar_offset_1 & 2) ? ubo_load_1.zw : ubo_load_1.xy)));
}

float2x3 tint_symbol_17(uint4 buffer[55], uint offset) {
  const uint scalar_offset_2 = ((offset + 0u)) / 4;
  const uint scalar_offset_3 = ((offset + 16u)) / 4;
  return float2x3(asfloat(buffer[scalar_offset_2 / 4].xyz), asfloat(buffer[scalar_offset_3 / 4].xyz));
}

float2x4 tint_symbol_18(uint4 buffer[55], uint offset) {
  const uint scalar_offset_4 = ((offset + 0u)) / 4;
  const uint scalar_offset_5 = ((offset + 16u)) / 4;
  return float2x4(asfloat(buffer[scalar_offset_4 / 4]), asfloat(buffer[scalar_offset_5 / 4]));
}

float3x2 tint_symbol_19(uint4 buffer[55], uint offset) {
  const uint scalar_offset_6 = ((offset + 0u)) / 4;
  uint4 ubo_load_2 = buffer[scalar_offset_6 / 4];
  const uint scalar_offset_7 = ((offset + 8u)) / 4;
  uint4 ubo_load_3 = buffer[scalar_offset_7 / 4];
  const uint scalar_offset_8 = ((offset + 16u)) / 4;
  uint4 ubo_load_4 = buffer[scalar_offset_8 / 4];
  return float3x2(asfloat(((scalar_offset_6 & 2) ? ubo_load_2.zw : ubo_load_2.xy)), asfloat(((scalar_offset_7 & 2) ? ubo_load_3.zw : ubo_load_3.xy)), asfloat(((scalar_offset_8 & 2) ? ubo_load_4.zw : ubo_load_4.xy)));
}

float3x3 tint_symbol_20(uint4 buffer[55], uint offset) {
  const uint scalar_offset_9 = ((offset + 0u)) / 4;
  const uint scalar_offset_10 = ((offset + 16u)) / 4;
  const uint scalar_offset_11 = ((offset + 32u)) / 4;
  return float3x3(asfloat(buffer[scalar_offset_9 / 4].xyz), asfloat(buffer[scalar_offset_10 / 4].xyz), asfloat(buffer[scalar_offset_11 / 4].xyz));
}

float3x4 tint_symbol_21(uint4 buffer[55], uint offset) {
  const uint scalar_offset_12 = ((offset + 0u)) / 4;
  const uint scalar_offset_13 = ((offset + 16u)) / 4;
  const uint scalar_offset_14 = ((offset + 32u)) / 4;
  return float3x4(asfloat(buffer[scalar_offset_12 / 4]), asfloat(buffer[scalar_offset_13 / 4]), asfloat(buffer[scalar_offset_14 / 4]));
}

float4x2 tint_symbol_22(uint4 buffer[55], uint offset) {
  const uint scalar_offset_15 = ((offset + 0u)) / 4;
  uint4 ubo_load_5 = buffer[scalar_offset_15 / 4];
  const uint scalar_offset_16 = ((offset + 8u)) / 4;
  uint4 ubo_load_6 = buffer[scalar_offset_16 / 4];
  const uint scalar_offset_17 = ((offset + 16u)) / 4;
  uint4 ubo_load_7 = buffer[scalar_offset_17 / 4];
  const uint scalar_offset_18 = ((offset + 24u)) / 4;
  uint4 ubo_load_8 = buffer[scalar_offset_18 / 4];
  return float4x2(asfloat(((scalar_offset_15 & 2) ? ubo_load_5.zw : ubo_load_5.xy)), asfloat(((scalar_offset_16 & 2) ? ubo_load_6.zw : ubo_load_6.xy)), asfloat(((scalar_offset_17 & 2) ? ubo_load_7.zw : ubo_load_7.xy)), asfloat(((scalar_offset_18 & 2) ? ubo_load_8.zw : ubo_load_8.xy)));
}

float4x3 tint_symbol_23(uint4 buffer[55], uint offset) {
  const uint scalar_offset_19 = ((offset + 0u)) / 4;
  const uint scalar_offset_20 = ((offset + 16u)) / 4;
  const uint scalar_offset_21 = ((offset + 32u)) / 4;
  const uint scalar_offset_22 = ((offset + 48u)) / 4;
  return float4x3(asfloat(buffer[scalar_offset_19 / 4].xyz), asfloat(buffer[scalar_offset_20 / 4].xyz), asfloat(buffer[scalar_offset_21 / 4].xyz), asfloat(buffer[scalar_offset_22 / 4].xyz));
}

float4x4 tint_symbol_24(uint4 buffer[55], uint offset) {
  const uint scalar_offset_23 = ((offset + 0u)) / 4;
  const uint scalar_offset_24 = ((offset + 16u)) / 4;
  const uint scalar_offset_25 = ((offset + 32u)) / 4;
  const uint scalar_offset_26 = ((offset + 48u)) / 4;
  return float4x4(asfloat(buffer[scalar_offset_23 / 4]), asfloat(buffer[scalar_offset_24 / 4]), asfloat(buffer[scalar_offset_25 / 4]), asfloat(buffer[scalar_offset_26 / 4]));
}

matrix<float16_t, 2, 2> tint_symbol_25(uint4 buffer[55], uint offset) {
  const uint scalar_offset_27 = ((offset + 0u)) / 4;
  uint ubo_load_9 = buffer[scalar_offset_27 / 4][scalar_offset_27 % 4];
  const uint scalar_offset_28 = ((offset + 4u)) / 4;
  uint ubo_load_10 = buffer[scalar_offset_28 / 4][scalar_offset_28 % 4];
  return matrix<float16_t, 2, 2>(vector<float16_t, 2>(float16_t(f16tof32(ubo_load_9 & 0xFFFF)), float16_t(f16tof32(ubo_load_9 >> 16))), vector<float16_t, 2>(float16_t(f16tof32(ubo_load_10 & 0xFFFF)), float16_t(f16tof32(ubo_load_10 >> 16))));
}

matrix<float16_t, 2, 3> tint_symbol_26(uint4 buffer[55], uint offset) {
  const uint scalar_offset_29 = ((offset + 0u)) / 4;
  uint4 ubo_load_12 = buffer[scalar_offset_29 / 4];
  uint2 ubo_load_11 = ((scalar_offset_29 & 2) ? ubo_load_12.zw : ubo_load_12.xy);
  vector<float16_t, 2> ubo_load_11_xz = vector<float16_t, 2>(f16tof32(ubo_load_11 & 0xFFFF));
  float16_t ubo_load_11_y = f16tof32(ubo_load_11[0] >> 16);
  const uint scalar_offset_30 = ((offset + 8u)) / 4;
  uint4 ubo_load_14 = buffer[scalar_offset_30 / 4];
  uint2 ubo_load_13 = ((scalar_offset_30 & 2) ? ubo_load_14.zw : ubo_load_14.xy);
  vector<float16_t, 2> ubo_load_13_xz = vector<float16_t, 2>(f16tof32(ubo_load_13 & 0xFFFF));
  float16_t ubo_load_13_y = f16tof32(ubo_load_13[0] >> 16);
  return matrix<float16_t, 2, 3>(vector<float16_t, 3>(ubo_load_11_xz[0], ubo_load_11_y, ubo_load_11_xz[1]), vector<float16_t, 3>(ubo_load_13_xz[0], ubo_load_13_y, ubo_load_13_xz[1]));
}

matrix<float16_t, 2, 4> tint_symbol_27(uint4 buffer[55], uint offset) {
  const uint scalar_offset_31 = ((offset + 0u)) / 4;
  uint4 ubo_load_16 = buffer[scalar_offset_31 / 4];
  uint2 ubo_load_15 = ((scalar_offset_31 & 2) ? ubo_load_16.zw : ubo_load_16.xy);
  vector<float16_t, 2> ubo_load_15_xz = vector<float16_t, 2>(f16tof32(ubo_load_15 & 0xFFFF));
  vector<float16_t, 2> ubo_load_15_yw = vector<float16_t, 2>(f16tof32(ubo_load_15 >> 16));
  const uint scalar_offset_32 = ((offset + 8u)) / 4;
  uint4 ubo_load_18 = buffer[scalar_offset_32 / 4];
  uint2 ubo_load_17 = ((scalar_offset_32 & 2) ? ubo_load_18.zw : ubo_load_18.xy);
  vector<float16_t, 2> ubo_load_17_xz = vector<float16_t, 2>(f16tof32(ubo_load_17 & 0xFFFF));
  vector<float16_t, 2> ubo_load_17_yw = vector<float16_t, 2>(f16tof32(ubo_load_17 >> 16));
  return matrix<float16_t, 2, 4>(vector<float16_t, 4>(ubo_load_15_xz[0], ubo_load_15_yw[0], ubo_load_15_xz[1], ubo_load_15_yw[1]), vector<float16_t, 4>(ubo_load_17_xz[0], ubo_load_17_yw[0], ubo_load_17_xz[1], ubo_load_17_yw[1]));
}

matrix<float16_t, 3, 2> tint_symbol_28(uint4 buffer[55], uint offset) {
  const uint scalar_offset_33 = ((offset + 0u)) / 4;
  uint ubo_load_19 = buffer[scalar_offset_33 / 4][scalar_offset_33 % 4];
  const uint scalar_offset_34 = ((offset + 4u)) / 4;
  uint ubo_load_20 = buffer[scalar_offset_34 / 4][scalar_offset_34 % 4];
  const uint scalar_offset_35 = ((offset + 8u)) / 4;
  uint ubo_load_21 = buffer[scalar_offset_35 / 4][scalar_offset_35 % 4];
  return matrix<float16_t, 3, 2>(vector<float16_t, 2>(float16_t(f16tof32(ubo_load_19 & 0xFFFF)), float16_t(f16tof32(ubo_load_19 >> 16))), vector<float16_t, 2>(float16_t(f16tof32(ubo_load_20 & 0xFFFF)), float16_t(f16tof32(ubo_load_20 >> 16))), vector<float16_t, 2>(float16_t(f16tof32(ubo_load_21 & 0xFFFF)), float16_t(f16tof32(ubo_load_21 >> 16))));
}

matrix<float16_t, 3, 3> tint_symbol_29(uint4 buffer[55], uint offset) {
  const uint scalar_offset_36 = ((offset + 0u)) / 4;
  uint4 ubo_load_23 = buffer[scalar_offset_36 / 4];
  uint2 ubo_load_22 = ((scalar_offset_36 & 2) ? ubo_load_23.zw : ubo_load_23.xy);
  vector<float16_t, 2> ubo_load_22_xz = vector<float16_t, 2>(f16tof32(ubo_load_22 & 0xFFFF));
  float16_t ubo_load_22_y = f16tof32(ubo_load_22[0] >> 16);
  const uint scalar_offset_37 = ((offset + 8u)) / 4;
  uint4 ubo_load_25 = buffer[scalar_offset_37 / 4];
  uint2 ubo_load_24 = ((scalar_offset_37 & 2) ? ubo_load_25.zw : ubo_load_25.xy);
  vector<float16_t, 2> ubo_load_24_xz = vector<float16_t, 2>(f16tof32(ubo_load_24 & 0xFFFF));
  float16_t ubo_load_24_y = f16tof32(ubo_load_24[0] >> 16);
  const uint scalar_offset_38 = ((offset + 16u)) / 4;
  uint4 ubo_load_27 = buffer[scalar_offset_38 / 4];
  uint2 ubo_load_26 = ((scalar_offset_38 & 2) ? ubo_load_27.zw : ubo_load_27.xy);
  vector<float16_t, 2> ubo_load_26_xz = vector<float16_t, 2>(f16tof32(ubo_load_26 & 0xFFFF));
  float16_t ubo_load_26_y = f16tof32(ubo_load_26[0] >> 16);
  return matrix<float16_t, 3, 3>(vector<float16_t, 3>(ubo_load_22_xz[0], ubo_load_22_y, ubo_load_22_xz[1]), vector<float16_t, 3>(ubo_load_24_xz[0], ubo_load_24_y, ubo_load_24_xz[1]), vector<float16_t, 3>(ubo_load_26_xz[0], ubo_load_26_y, ubo_load_26_xz[1]));
}

matrix<float16_t, 3, 4> tint_symbol_30(uint4 buffer[55], uint offset) {
  const uint scalar_offset_39 = ((offset + 0u)) / 4;
  uint4 ubo_load_29 = buffer[scalar_offset_39 / 4];
  uint2 ubo_load_28 = ((scalar_offset_39 & 2) ? ubo_load_29.zw : ubo_load_29.xy);
  vector<float16_t, 2> ubo_load_28_xz = vector<float16_t, 2>(f16tof32(ubo_load_28 & 0xFFFF));
  vector<float16_t, 2> ubo_load_28_yw = vector<float16_t, 2>(f16tof32(ubo_load_28 >> 16));
  const uint scalar_offset_40 = ((offset + 8u)) / 4;
  uint4 ubo_load_31 = buffer[scalar_offset_40 / 4];
  uint2 ubo_load_30 = ((scalar_offset_40 & 2) ? ubo_load_31.zw : ubo_load_31.xy);
  vector<float16_t, 2> ubo_load_30_xz = vector<float16_t, 2>(f16tof32(ubo_load_30 & 0xFFFF));
  vector<float16_t, 2> ubo_load_30_yw = vector<float16_t, 2>(f16tof32(ubo_load_30 >> 16));
  const uint scalar_offset_41 = ((offset + 16u)) / 4;
  uint4 ubo_load_33 = buffer[scalar_offset_41 / 4];
  uint2 ubo_load_32 = ((scalar_offset_41 & 2) ? ubo_load_33.zw : ubo_load_33.xy);
  vector<float16_t, 2> ubo_load_32_xz = vector<float16_t, 2>(f16tof32(ubo_load_32 & 0xFFFF));
  vector<float16_t, 2> ubo_load_32_yw = vector<float16_t, 2>(f16tof32(ubo_load_32 >> 16));
  return matrix<float16_t, 3, 4>(vector<float16_t, 4>(ubo_load_28_xz[0], ubo_load_28_yw[0], ubo_load_28_xz[1], ubo_load_28_yw[1]), vector<float16_t, 4>(ubo_load_30_xz[0], ubo_load_30_yw[0], ubo_load_30_xz[1], ubo_load_30_yw[1]), vector<float16_t, 4>(ubo_load_32_xz[0], ubo_load_32_yw[0], ubo_load_32_xz[1], ubo_load_32_yw[1]));
}

matrix<float16_t, 4, 2> tint_symbol_31(uint4 buffer[55], uint offset) {
  const uint scalar_offset_42 = ((offset + 0u)) / 4;
  uint ubo_load_34 = buffer[scalar_offset_42 / 4][scalar_offset_42 % 4];
  const uint scalar_offset_43 = ((offset + 4u)) / 4;
  uint ubo_load_35 = buffer[scalar_offset_43 / 4][scalar_offset_43 % 4];
  const uint scalar_offset_44 = ((offset + 8u)) / 4;
  uint ubo_load_36 = buffer[scalar_offset_44 / 4][scalar_offset_44 % 4];
  const uint scalar_offset_45 = ((offset + 12u)) / 4;
  uint ubo_load_37 = buffer[scalar_offset_45 / 4][scalar_offset_45 % 4];
  return matrix<float16_t, 4, 2>(vector<float16_t, 2>(float16_t(f16tof32(ubo_load_34 & 0xFFFF)), float16_t(f16tof32(ubo_load_34 >> 16))), vector<float16_t, 2>(float16_t(f16tof32(ubo_load_35 & 0xFFFF)), float16_t(f16tof32(ubo_load_35 >> 16))), vector<float16_t, 2>(float16_t(f16tof32(ubo_load_36 & 0xFFFF)), float16_t(f16tof32(ubo_load_36 >> 16))), vector<float16_t, 2>(float16_t(f16tof32(ubo_load_37 & 0xFFFF)), float16_t(f16tof32(ubo_load_37 >> 16))));
}

matrix<float16_t, 4, 3> tint_symbol_32(uint4 buffer[55], uint offset) {
  const uint scalar_offset_46 = ((offset + 0u)) / 4;
  uint4 ubo_load_39 = buffer[scalar_offset_46 / 4];
  uint2 ubo_load_38 = ((scalar_offset_46 & 2) ? ubo_load_39.zw : ubo_load_39.xy);
  vector<float16_t, 2> ubo_load_38_xz = vector<float16_t, 2>(f16tof32(ubo_load_38 & 0xFFFF));
  float16_t ubo_load_38_y = f16tof32(ubo_load_38[0] >> 16);
  const uint scalar_offset_47 = ((offset + 8u)) / 4;
  uint4 ubo_load_41 = buffer[scalar_offset_47 / 4];
  uint2 ubo_load_40 = ((scalar_offset_47 & 2) ? ubo_load_41.zw : ubo_load_41.xy);
  vector<float16_t, 2> ubo_load_40_xz = vector<float16_t, 2>(f16tof32(ubo_load_40 & 0xFFFF));
  float16_t ubo_load_40_y = f16tof32(ubo_load_40[0] >> 16);
  const uint scalar_offset_48 = ((offset + 16u)) / 4;
  uint4 ubo_load_43 = buffer[scalar_offset_48 / 4];
  uint2 ubo_load_42 = ((scalar_offset_48 & 2) ? ubo_load_43.zw : ubo_load_43.xy);
  vector<float16_t, 2> ubo_load_42_xz = vector<float16_t, 2>(f16tof32(ubo_load_42 & 0xFFFF));
  float16_t ubo_load_42_y = f16tof32(ubo_load_42[0] >> 16);
  const uint scalar_offset_49 = ((offset + 24u)) / 4;
  uint4 ubo_load_45 = buffer[scalar_offset_49 / 4];
  uint2 ubo_load_44 = ((scalar_offset_49 & 2) ? ubo_load_45.zw : ubo_load_45.xy);
  vector<float16_t, 2> ubo_load_44_xz = vector<float16_t, 2>(f16tof32(ubo_load_44 & 0xFFFF));
  float16_t ubo_load_44_y = f16tof32(ubo_load_44[0] >> 16);
  return matrix<float16_t, 4, 3>(vector<float16_t, 3>(ubo_load_38_xz[0], ubo_load_38_y, ubo_load_38_xz[1]), vector<float16_t, 3>(ubo_load_40_xz[0], ubo_load_40_y, ubo_load_40_xz[1]), vector<float16_t, 3>(ubo_load_42_xz[0], ubo_load_42_y, ubo_load_42_xz[1]), vector<float16_t, 3>(ubo_load_44_xz[0], ubo_load_44_y, ubo_load_44_xz[1]));
}

matrix<float16_t, 4, 4> tint_symbol_33(uint4 buffer[55], uint offset) {
  const uint scalar_offset_50 = ((offset + 0u)) / 4;
  uint4 ubo_load_47 = buffer[scalar_offset_50 / 4];
  uint2 ubo_load_46 = ((scalar_offset_50 & 2) ? ubo_load_47.zw : ubo_load_47.xy);
  vector<float16_t, 2> ubo_load_46_xz = vector<float16_t, 2>(f16tof32(ubo_load_46 & 0xFFFF));
  vector<float16_t, 2> ubo_load_46_yw = vector<float16_t, 2>(f16tof32(ubo_load_46 >> 16));
  const uint scalar_offset_51 = ((offset + 8u)) / 4;
  uint4 ubo_load_49 = buffer[scalar_offset_51 / 4];
  uint2 ubo_load_48 = ((scalar_offset_51 & 2) ? ubo_load_49.zw : ubo_load_49.xy);
  vector<float16_t, 2> ubo_load_48_xz = vector<float16_t, 2>(f16tof32(ubo_load_48 & 0xFFFF));
  vector<float16_t, 2> ubo_load_48_yw = vector<float16_t, 2>(f16tof32(ubo_load_48 >> 16));
  const uint scalar_offset_52 = ((offset + 16u)) / 4;
  uint4 ubo_load_51 = buffer[scalar_offset_52 / 4];
  uint2 ubo_load_50 = ((scalar_offset_52 & 2) ? ubo_load_51.zw : ubo_load_51.xy);
  vector<float16_t, 2> ubo_load_50_xz = vector<float16_t, 2>(f16tof32(ubo_load_50 & 0xFFFF));
  vector<float16_t, 2> ubo_load_50_yw = vector<float16_t, 2>(f16tof32(ubo_load_50 >> 16));
  const uint scalar_offset_53 = ((offset + 24u)) / 4;
  uint4 ubo_load_53 = buffer[scalar_offset_53 / 4];
  uint2 ubo_load_52 = ((scalar_offset_53 & 2) ? ubo_load_53.zw : ubo_load_53.xy);
  vector<float16_t, 2> ubo_load_52_xz = vector<float16_t, 2>(f16tof32(ubo_load_52 & 0xFFFF));
  vector<float16_t, 2> ubo_load_52_yw = vector<float16_t, 2>(f16tof32(ubo_load_52 >> 16));
  return matrix<float16_t, 4, 4>(vector<float16_t, 4>(ubo_load_46_xz[0], ubo_load_46_yw[0], ubo_load_46_xz[1], ubo_load_46_yw[1]), vector<float16_t, 4>(ubo_load_48_xz[0], ubo_load_48_yw[0], ubo_load_48_xz[1], ubo_load_48_yw[1]), vector<float16_t, 4>(ubo_load_50_xz[0], ubo_load_50_yw[0], ubo_load_50_xz[1], ubo_load_50_yw[1]), vector<float16_t, 4>(ubo_load_52_xz[0], ubo_load_52_yw[0], ubo_load_52_xz[1], ubo_load_52_yw[1]));
}

typedef float3 tint_symbol_34_ret[2];
tint_symbol_34_ret tint_symbol_34(uint4 buffer[55], uint offset) {
  float3 arr[2] = (float3[2])0;
  {
    for(uint i = 0u; (i < 2u); i = (i + 1u)) {
      const uint scalar_offset_54 = ((offset + (i * 16u))) / 4;
      arr[i] = asfloat(buffer[scalar_offset_54 / 4].xyz);
    }
  }
  return arr;
}

typedef matrix<float16_t, 4, 2> tint_symbol_35_ret[2];
tint_symbol_35_ret tint_symbol_35(uint4 buffer[55], uint offset) {
  matrix<float16_t, 4, 2> arr_1[2] = (matrix<float16_t, 4, 2>[2])0;
  {
    for(uint i_1 = 0u; (i_1 < 2u); i_1 = (i_1 + 1u)) {
      arr_1[i_1] = tint_symbol_31(buffer, (offset + (i_1 * 16u)));
    }
  }
  return arr_1;
}

Inner tint_symbol_36(uint4 buffer[55], uint offset) {
  const uint scalar_offset_55 = ((offset + 0u)) / 4;
  const uint scalar_offset_56 = ((offset + 4u)) / 4;
  const uint scalar_offset_bytes = ((offset + 8u));
  const uint scalar_offset_index = scalar_offset_bytes / 4;
  const Inner tint_symbol_38 = {asint(buffer[scalar_offset_55 / 4][scalar_offset_55 % 4]), asfloat(buffer[scalar_offset_56 / 4][scalar_offset_56 % 4]), float16_t(f16tof32(((buffer[scalar_offset_index / 4][scalar_offset_index % 4] >> (scalar_offset_bytes % 4 == 0 ? 0 : 16)) & 0xFFFF)))};
  return tint_symbol_38;
}

typedef Inner tint_symbol_37_ret[4];
tint_symbol_37_ret tint_symbol_37(uint4 buffer[55], uint offset) {
  Inner arr_2[4] = (Inner[4])0;
  {
    for(uint i_2 = 0u; (i_2 < 4u); i_2 = (i_2 + 1u)) {
      arr_2[i_2] = tint_symbol_36(buffer, (offset + (i_2 * 16u)));
    }
  }
  return arr_2;
}

[numthreads(1, 1, 1)]
void main() {
  const float scalar_f32 = asfloat(ub[0].x);
  const int scalar_i32 = asint(ub[0].y);
  const uint scalar_u32 = ub[0].z;
  const float16_t scalar_f16 = float16_t(f16tof32(((ub[0].w) & 0xFFFF)));
  const float2 vec2_f32 = asfloat(ub[1].xy);
  const int2 vec2_i32 = asint(ub[1].zw);
  const uint2 vec2_u32 = ub[2].xy;
  uint ubo_load_54 = ub[2].z;
  const vector<float16_t, 2> vec2_f16 = vector<float16_t, 2>(float16_t(f16tof32(ubo_load_54 & 0xFFFF)), float16_t(f16tof32(ubo_load_54 >> 16)));
  const float3 vec3_f32 = asfloat(ub[3].xyz);
  const int3 vec3_i32 = asint(ub[4].xyz);
  const uint3 vec3_u32 = ub[5].xyz;
  uint2 ubo_load_55 = ub[6].xy;
  vector<float16_t, 2> ubo_load_55_xz = vector<float16_t, 2>(f16tof32(ubo_load_55 & 0xFFFF));
  float16_t ubo_load_55_y = f16tof32(ubo_load_55[0] >> 16);
  const vector<float16_t, 3> vec3_f16 = vector<float16_t, 3>(ubo_load_55_xz[0], ubo_load_55_y, ubo_load_55_xz[1]);
  const float4 vec4_f32 = asfloat(ub[7]);
  const int4 vec4_i32 = asint(ub[8]);
  const uint4 vec4_u32 = ub[9];
  uint2 ubo_load_56 = ub[10].xy;
  vector<float16_t, 2> ubo_load_56_xz = vector<float16_t, 2>(f16tof32(ubo_load_56 & 0xFFFF));
  vector<float16_t, 2> ubo_load_56_yw = vector<float16_t, 2>(f16tof32(ubo_load_56 >> 16));
  const vector<float16_t, 4> vec4_f16 = vector<float16_t, 4>(ubo_load_56_xz[0], ubo_load_56_yw[0], ubo_load_56_xz[1], ubo_load_56_yw[1]);
  const float2x2 mat2x2_f32 = tint_symbol_16(ub, 168u);
  const float2x3 mat2x3_f32 = tint_symbol_17(ub, 192u);
  const float2x4 mat2x4_f32 = tint_symbol_18(ub, 224u);
  const float3x2 mat3x2_f32 = tint_symbol_19(ub, 256u);
  const float3x3 mat3x3_f32 = tint_symbol_20(ub, 288u);
  const float3x4 mat3x4_f32 = tint_symbol_21(ub, 336u);
  const float4x2 mat4x2_f32 = tint_symbol_22(ub, 384u);
  const float4x3 mat4x3_f32 = tint_symbol_23(ub, 416u);
  const float4x4 mat4x4_f32 = tint_symbol_24(ub, 480u);
  const matrix<float16_t, 2, 2> mat2x2_f16 = tint_symbol_25(ub, 544u);
  const matrix<float16_t, 2, 3> mat2x3_f16 = tint_symbol_26(ub, 552u);
  const matrix<float16_t, 2, 4> mat2x4_f16 = tint_symbol_27(ub, 568u);
  const matrix<float16_t, 3, 2> mat3x2_f16 = tint_symbol_28(ub, 584u);
  const matrix<float16_t, 3, 3> mat3x3_f16 = tint_symbol_29(ub, 600u);
  const matrix<float16_t, 3, 4> mat3x4_f16 = tint_symbol_30(ub, 624u);
  const matrix<float16_t, 4, 2> mat4x2_f16 = tint_symbol_31(ub, 648u);
  const matrix<float16_t, 4, 3> mat4x3_f16 = tint_symbol_32(ub, 664u);
  const matrix<float16_t, 4, 4> mat4x4_f16 = tint_symbol_33(ub, 696u);
  const float3 arr2_vec3_f32[2] = tint_symbol_34(ub, 736u);
  const matrix<float16_t, 4, 2> arr2_mat4x2_f16[2] = tint_symbol_35(ub, 768u);
  const Inner struct_inner = tint_symbol_36(ub, 800u);
  const Inner array_struct_inner[4] = tint_symbol_37(ub, 816u);
  return;
}
