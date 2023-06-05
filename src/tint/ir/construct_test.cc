// Copyright 2023 The Tint Authors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "src/tint/ir/construct.h"
#include "gtest/gtest-spi.h"
#include "src/tint/ir/ir_test_helper.h"

namespace tint::ir {
namespace {

using namespace tint::number_suffixes;  // NOLINT
using IR_ConstructTest = IRTestHelper;

TEST_F(IR_ConstructTest, Usage) {
    auto* arg1 = b.Constant(true);
    auto* arg2 = b.Constant(false);
    auto* c = b.Construct(mod.Types().f32(), utils::Vector{arg1, arg2});

    ASSERT_EQ(1u, arg1->Usage().Length());
    ASSERT_EQ(1u, arg2->Usage().Length());
    EXPECT_EQ(c, arg1->Usage()[0]);
    EXPECT_EQ(c, arg2->Usage()[0]);
}

TEST_F(IR_ConstructTest, Fail_NullType) {
    EXPECT_FATAL_FAILURE(
        {
            Module mod;
            Builder b{mod};
            b.Construct(nullptr);
        },
        "");
}

TEST_F(IR_ConstructTest, Fail_NullArg) {
    EXPECT_FATAL_FAILURE(
        {
            Module mod;
            Builder b{mod};
            b.Construct(mod.Types().f32(), utils::Vector<Value*, 1>{nullptr});
        },
        "");
}

}  // namespace
}  // namespace tint::ir
