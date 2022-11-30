#version 310 es

struct S {
  int before;
  uint pad;
  uint pad_1;
  uint pad_2;
  mat3 m;
  int after;
  uint pad_3;
  uint pad_4;
  uint pad_5;
  uint pad_6;
  uint pad_7;
  uint pad_8;
  uint pad_9;
  uint pad_10;
  uint pad_11;
  uint pad_12;
  uint pad_13;
  uint pad_14;
  uint pad_15;
  uint pad_16;
  uint pad_17;
};

layout(binding = 0, std140) uniform u_block_ubo {
  S inner[4];
} u;

void f() {
  mat3 t = transpose(u.inner[2].m);
  float l = length(u.inner[0].m[1].zxy);
  float a = abs(u.inner[0].m[1].zxy.x);
}

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main() {
  f();
  return;
}
