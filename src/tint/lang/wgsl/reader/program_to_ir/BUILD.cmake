# Copyright 2023 The Tint Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

################################################################################
# File generated by 'tools/src/cmd/gen' using the template:
#   tools/src/cmd/gen/build/BUILD.cmake.tmpl
#
# To regenerate run: './tools/run gen'
#
#                       Do not modify this file directly
################################################################################

################################################################################
# Target:    tint_lang_wgsl_reader_program_to_ir
# Kind:      lib
################################################################################
tint_add_target(tint_lang_wgsl_reader_program_to_ir lib
  lang/wgsl/reader/program_to_ir/program_to_ir.cc
  lang/wgsl/reader/program_to_ir/program_to_ir.h
)

tint_target_add_dependencies(tint_lang_wgsl_reader_program_to_ir lib
  tint_api_common
  tint_lang_core
  tint_lang_core_constant
  tint_lang_core_ir
  tint_lang_core_type
  tint_lang_wgsl_ast
  tint_lang_wgsl_program
  tint_lang_wgsl_sem
  tint_utils_containers
  tint_utils_diagnostic
  tint_utils_ice
  tint_utils_id
  tint_utils_macros
  tint_utils_math
  tint_utils_memory
  tint_utils_reflection
  tint_utils_result
  tint_utils_rtti
  tint_utils_symbol
  tint_utils_text
  tint_utils_traits
)

################################################################################
# Target:    tint_lang_wgsl_reader_program_to_ir_test
# Kind:      test
################################################################################
tint_add_target(tint_lang_wgsl_reader_program_to_ir_test test
  lang/wgsl/reader/program_to_ir/accessor_test.cc
  lang/wgsl/reader/program_to_ir/binary_test.cc
  lang/wgsl/reader/program_to_ir/builtin_test.cc
  lang/wgsl/reader/program_to_ir/call_test.cc
  lang/wgsl/reader/program_to_ir/function_test.cc
  lang/wgsl/reader/program_to_ir/let_test.cc
  lang/wgsl/reader/program_to_ir/literal_test.cc
  lang/wgsl/reader/program_to_ir/materialize_test.cc
  lang/wgsl/reader/program_to_ir/program_to_ir_test.cc
  lang/wgsl/reader/program_to_ir/shadowing_test.cc
  lang/wgsl/reader/program_to_ir/store_test.cc
  lang/wgsl/reader/program_to_ir/unary_test.cc
  lang/wgsl/reader/program_to_ir/var_test.cc
)

tint_target_add_dependencies(tint_lang_wgsl_reader_program_to_ir_test test
  tint_api_common
  tint_lang_core
  tint_lang_core_constant
  tint_lang_core_ir
  tint_lang_core_type
  tint_lang_wgsl_ast
  tint_lang_wgsl_helpers_test
  tint_lang_wgsl_program
  tint_lang_wgsl_reader
  tint_lang_wgsl_reader_program_to_ir
  tint_lang_wgsl_resolver
  tint_lang_wgsl_sem
  tint_utils_containers
  tint_utils_diagnostic
  tint_utils_ice
  tint_utils_id
  tint_utils_macros
  tint_utils_math
  tint_utils_memory
  tint_utils_reflection
  tint_utils_result
  tint_utils_rtti
  tint_utils_symbol
  tint_utils_text
  tint_utils_traits
)

tint_target_add_external_dependencies(tint_lang_wgsl_reader_program_to_ir_test test
  "gtest"
)
