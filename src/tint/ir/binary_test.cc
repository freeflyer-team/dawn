// Copyright 2022 The Tint Authors.
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

#include "gtest/gtest-spi.h"
#include "src/tint/ir/instruction.h"
#include "src/tint/ir/ir_test_helper.h"

namespace tint::ir {
namespace {

using namespace tint::number_suffixes;  // NOLINT

using IR_BinaryTest = IRTestHelper;

TEST_F(IR_BinaryTest, Fail_NullType) {
    EXPECT_FATAL_FAILURE(
        {
            Module mod;
            Builder b{mod};
            b.Add(nullptr, b.Constant(u32(1)), b.Constant(u32(2)));
        },
        "");
}

TEST_F(IR_BinaryTest, Fail_NullLHS) {
    EXPECT_FATAL_FAILURE(
        {
            Module mod;
            Builder b{mod};
            b.Add(mod.Types().u32(), nullptr, b.Constant(u32(2)));
        },
        "");
}

TEST_F(IR_BinaryTest, Fail_NullRHS) {
    EXPECT_FATAL_FAILURE(
        {
            Module mod;
            Builder b{mod};
            b.Add(mod.Types().u32(), b.Constant(u32(1)), nullptr);
        },
        "");
}

TEST_F(IR_BinaryTest, CreateAnd) {
    const auto* inst = b.And(mod.Types().i32(), b.Constant(4_i), b.Constant(2_i));

    ASSERT_TRUE(inst->Is<Binary>());
    EXPECT_EQ(inst->Kind(), Binary::Kind::kAnd);
    ASSERT_NE(inst->Type(), nullptr);

    ASSERT_TRUE(inst->LHS()->Is<Constant>());
    auto lhs = inst->LHS()->As<Constant>()->Value();
    ASSERT_TRUE(lhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(4_i, lhs->As<constant::Scalar<i32>>()->ValueAs<i32>());

    ASSERT_TRUE(inst->RHS()->Is<Constant>());
    auto rhs = inst->RHS()->As<Constant>()->Value();
    ASSERT_TRUE(rhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(2_i, rhs->As<constant::Scalar<i32>>()->ValueAs<i32>());
}

TEST_F(IR_BinaryTest, CreateOr) {
    const auto* inst = b.Or(mod.Types().i32(), b.Constant(4_i), b.Constant(2_i));

    ASSERT_TRUE(inst->Is<Binary>());
    EXPECT_EQ(inst->Kind(), Binary::Kind::kOr);

    ASSERT_TRUE(inst->LHS()->Is<Constant>());
    auto lhs = inst->LHS()->As<Constant>()->Value();
    ASSERT_TRUE(lhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(4_i, lhs->As<constant::Scalar<i32>>()->ValueAs<i32>());

    ASSERT_TRUE(inst->RHS()->Is<Constant>());
    auto rhs = inst->RHS()->As<Constant>()->Value();
    ASSERT_TRUE(rhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(2_i, rhs->As<constant::Scalar<i32>>()->ValueAs<i32>());
}

TEST_F(IR_BinaryTest, CreateXor) {
    const auto* inst = b.Xor(mod.Types().i32(), b.Constant(4_i), b.Constant(2_i));

    ASSERT_TRUE(inst->Is<Binary>());
    EXPECT_EQ(inst->Kind(), Binary::Kind::kXor);

    ASSERT_TRUE(inst->LHS()->Is<Constant>());
    auto lhs = inst->LHS()->As<Constant>()->Value();
    ASSERT_TRUE(lhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(4_i, lhs->As<constant::Scalar<i32>>()->ValueAs<i32>());

    ASSERT_TRUE(inst->RHS()->Is<Constant>());
    auto rhs = inst->RHS()->As<Constant>()->Value();
    ASSERT_TRUE(rhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(2_i, rhs->As<constant::Scalar<i32>>()->ValueAs<i32>());
}

TEST_F(IR_BinaryTest, CreateEqual) {
    const auto* inst = b.Equal(mod.Types().bool_(), b.Constant(4_i), b.Constant(2_i));

    ASSERT_TRUE(inst->Is<Binary>());
    EXPECT_EQ(inst->Kind(), Binary::Kind::kEqual);

    ASSERT_TRUE(inst->LHS()->Is<Constant>());
    auto lhs = inst->LHS()->As<Constant>()->Value();
    ASSERT_TRUE(lhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(4_i, lhs->As<constant::Scalar<i32>>()->ValueAs<i32>());

    ASSERT_TRUE(inst->RHS()->Is<Constant>());
    auto rhs = inst->RHS()->As<Constant>()->Value();
    ASSERT_TRUE(rhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(2_i, rhs->As<constant::Scalar<i32>>()->ValueAs<i32>());
}

TEST_F(IR_BinaryTest, CreateNotEqual) {
    const auto* inst = b.NotEqual(mod.Types().bool_(), b.Constant(4_i), b.Constant(2_i));

    ASSERT_TRUE(inst->Is<Binary>());
    EXPECT_EQ(inst->Kind(), Binary::Kind::kNotEqual);

    ASSERT_TRUE(inst->LHS()->Is<Constant>());
    auto lhs = inst->LHS()->As<Constant>()->Value();
    ASSERT_TRUE(lhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(4_i, lhs->As<constant::Scalar<i32>>()->ValueAs<i32>());

    ASSERT_TRUE(inst->RHS()->Is<Constant>());
    auto rhs = inst->RHS()->As<Constant>()->Value();
    ASSERT_TRUE(rhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(2_i, rhs->As<constant::Scalar<i32>>()->ValueAs<i32>());
}

TEST_F(IR_BinaryTest, CreateLessThan) {
    const auto* inst = b.LessThan(mod.Types().bool_(), b.Constant(4_i), b.Constant(2_i));

    ASSERT_TRUE(inst->Is<Binary>());
    EXPECT_EQ(inst->Kind(), Binary::Kind::kLessThan);

    ASSERT_TRUE(inst->LHS()->Is<Constant>());
    auto lhs = inst->LHS()->As<Constant>()->Value();
    ASSERT_TRUE(lhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(4_i, lhs->As<constant::Scalar<i32>>()->ValueAs<i32>());

    ASSERT_TRUE(inst->RHS()->Is<Constant>());
    auto rhs = inst->RHS()->As<Constant>()->Value();
    ASSERT_TRUE(rhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(2_i, rhs->As<constant::Scalar<i32>>()->ValueAs<i32>());
}

TEST_F(IR_BinaryTest, CreateGreaterThan) {
    const auto* inst = b.GreaterThan(mod.Types().bool_(), b.Constant(4_i), b.Constant(2_i));

    ASSERT_TRUE(inst->Is<Binary>());
    EXPECT_EQ(inst->Kind(), Binary::Kind::kGreaterThan);

    ASSERT_TRUE(inst->LHS()->Is<Constant>());
    auto lhs = inst->LHS()->As<Constant>()->Value();
    ASSERT_TRUE(lhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(4_i, lhs->As<constant::Scalar<i32>>()->ValueAs<i32>());

    ASSERT_TRUE(inst->RHS()->Is<Constant>());
    auto rhs = inst->RHS()->As<Constant>()->Value();
    ASSERT_TRUE(rhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(2_i, rhs->As<constant::Scalar<i32>>()->ValueAs<i32>());
}

TEST_F(IR_BinaryTest, CreateLessThanEqual) {
    const auto* inst = b.LessThanEqual(mod.Types().bool_(), b.Constant(4_i), b.Constant(2_i));

    ASSERT_TRUE(inst->Is<Binary>());
    EXPECT_EQ(inst->Kind(), Binary::Kind::kLessThanEqual);

    ASSERT_TRUE(inst->LHS()->Is<Constant>());
    auto lhs = inst->LHS()->As<Constant>()->Value();
    ASSERT_TRUE(lhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(4_i, lhs->As<constant::Scalar<i32>>()->ValueAs<i32>());

    ASSERT_TRUE(inst->RHS()->Is<Constant>());
    auto rhs = inst->RHS()->As<Constant>()->Value();
    ASSERT_TRUE(rhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(2_i, rhs->As<constant::Scalar<i32>>()->ValueAs<i32>());
}

TEST_F(IR_BinaryTest, CreateGreaterThanEqual) {
    const auto* inst = b.GreaterThanEqual(mod.Types().bool_(), b.Constant(4_i), b.Constant(2_i));

    ASSERT_TRUE(inst->Is<Binary>());
    EXPECT_EQ(inst->Kind(), Binary::Kind::kGreaterThanEqual);

    ASSERT_TRUE(inst->LHS()->Is<Constant>());
    auto lhs = inst->LHS()->As<Constant>()->Value();
    ASSERT_TRUE(lhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(4_i, lhs->As<constant::Scalar<i32>>()->ValueAs<i32>());

    ASSERT_TRUE(inst->RHS()->Is<Constant>());
    auto rhs = inst->RHS()->As<Constant>()->Value();
    ASSERT_TRUE(rhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(2_i, rhs->As<constant::Scalar<i32>>()->ValueAs<i32>());
}

TEST_F(IR_BinaryTest, CreateNot) {
    const auto* inst = b.Not(mod.Types().bool_(), b.Constant(true));

    ASSERT_TRUE(inst->Is<Binary>());
    EXPECT_EQ(inst->Kind(), Binary::Kind::kEqual);

    ASSERT_TRUE(inst->LHS()->Is<Constant>());
    auto lhs = inst->LHS()->As<Constant>()->Value();
    ASSERT_TRUE(lhs->Is<constant::Scalar<bool>>());
    EXPECT_TRUE(lhs->As<constant::Scalar<bool>>()->ValueAs<bool>());

    ASSERT_TRUE(inst->RHS()->Is<Constant>());
    auto rhs = inst->RHS()->As<Constant>()->Value();
    ASSERT_TRUE(rhs->Is<constant::Scalar<bool>>());
    EXPECT_FALSE(rhs->As<constant::Scalar<bool>>()->ValueAs<bool>());
}

TEST_F(IR_BinaryTest, CreateShiftLeft) {
    const auto* inst = b.ShiftLeft(mod.Types().i32(), b.Constant(4_i), b.Constant(2_i));

    ASSERT_TRUE(inst->Is<Binary>());
    EXPECT_EQ(inst->Kind(), Binary::Kind::kShiftLeft);

    ASSERT_TRUE(inst->LHS()->Is<Constant>());
    auto lhs = inst->LHS()->As<Constant>()->Value();
    ASSERT_TRUE(lhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(4_i, lhs->As<constant::Scalar<i32>>()->ValueAs<i32>());

    ASSERT_TRUE(inst->RHS()->Is<Constant>());
    auto rhs = inst->RHS()->As<Constant>()->Value();
    ASSERT_TRUE(rhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(2_i, rhs->As<constant::Scalar<i32>>()->ValueAs<i32>());
}

TEST_F(IR_BinaryTest, CreateShiftRight) {
    const auto* inst = b.ShiftRight(mod.Types().i32(), b.Constant(4_i), b.Constant(2_i));

    ASSERT_TRUE(inst->Is<Binary>());
    EXPECT_EQ(inst->Kind(), Binary::Kind::kShiftRight);

    ASSERT_TRUE(inst->LHS()->Is<Constant>());
    auto lhs = inst->LHS()->As<Constant>()->Value();
    ASSERT_TRUE(lhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(4_i, lhs->As<constant::Scalar<i32>>()->ValueAs<i32>());

    ASSERT_TRUE(inst->RHS()->Is<Constant>());
    auto rhs = inst->RHS()->As<Constant>()->Value();
    ASSERT_TRUE(rhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(2_i, rhs->As<constant::Scalar<i32>>()->ValueAs<i32>());
}

TEST_F(IR_BinaryTest, CreateAdd) {
    const auto* inst = b.Add(mod.Types().i32(), b.Constant(4_i), b.Constant(2_i));

    ASSERT_TRUE(inst->Is<Binary>());
    EXPECT_EQ(inst->Kind(), Binary::Kind::kAdd);

    ASSERT_TRUE(inst->LHS()->Is<Constant>());
    auto lhs = inst->LHS()->As<Constant>()->Value();
    ASSERT_TRUE(lhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(4_i, lhs->As<constant::Scalar<i32>>()->ValueAs<i32>());

    ASSERT_TRUE(inst->RHS()->Is<Constant>());
    auto rhs = inst->RHS()->As<Constant>()->Value();
    ASSERT_TRUE(rhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(2_i, rhs->As<constant::Scalar<i32>>()->ValueAs<i32>());
}

TEST_F(IR_BinaryTest, CreateSubtract) {
    const auto* inst = b.Subtract(mod.Types().i32(), b.Constant(4_i), b.Constant(2_i));

    ASSERT_TRUE(inst->Is<Binary>());
    EXPECT_EQ(inst->Kind(), Binary::Kind::kSubtract);

    ASSERT_TRUE(inst->LHS()->Is<Constant>());
    auto lhs = inst->LHS()->As<Constant>()->Value();
    ASSERT_TRUE(lhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(4_i, lhs->As<constant::Scalar<i32>>()->ValueAs<i32>());

    ASSERT_TRUE(inst->RHS()->Is<Constant>());
    auto rhs = inst->RHS()->As<Constant>()->Value();
    ASSERT_TRUE(rhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(2_i, rhs->As<constant::Scalar<i32>>()->ValueAs<i32>());
}

TEST_F(IR_BinaryTest, CreateMultiply) {
    const auto* inst = b.Multiply(mod.Types().i32(), b.Constant(4_i), b.Constant(2_i));

    ASSERT_TRUE(inst->Is<Binary>());
    EXPECT_EQ(inst->Kind(), Binary::Kind::kMultiply);

    ASSERT_TRUE(inst->LHS()->Is<Constant>());
    auto lhs = inst->LHS()->As<Constant>()->Value();
    ASSERT_TRUE(lhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(4_i, lhs->As<constant::Scalar<i32>>()->ValueAs<i32>());

    ASSERT_TRUE(inst->RHS()->Is<Constant>());
    auto rhs = inst->RHS()->As<Constant>()->Value();
    ASSERT_TRUE(rhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(2_i, rhs->As<constant::Scalar<i32>>()->ValueAs<i32>());
}

TEST_F(IR_BinaryTest, CreateDivide) {
    const auto* inst = b.Divide(mod.Types().i32(), b.Constant(4_i), b.Constant(2_i));

    ASSERT_TRUE(inst->Is<Binary>());
    EXPECT_EQ(inst->Kind(), Binary::Kind::kDivide);

    ASSERT_TRUE(inst->LHS()->Is<Constant>());
    auto lhs = inst->LHS()->As<Constant>()->Value();
    ASSERT_TRUE(lhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(4_i, lhs->As<constant::Scalar<i32>>()->ValueAs<i32>());

    ASSERT_TRUE(inst->RHS()->Is<Constant>());
    auto rhs = inst->RHS()->As<Constant>()->Value();
    ASSERT_TRUE(rhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(2_i, rhs->As<constant::Scalar<i32>>()->ValueAs<i32>());
}

TEST_F(IR_BinaryTest, CreateModulo) {
    const auto* inst = b.Modulo(mod.Types().i32(), b.Constant(4_i), b.Constant(2_i));

    ASSERT_TRUE(inst->Is<Binary>());
    EXPECT_EQ(inst->Kind(), Binary::Kind::kModulo);

    ASSERT_TRUE(inst->LHS()->Is<Constant>());
    auto lhs = inst->LHS()->As<Constant>()->Value();
    ASSERT_TRUE(lhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(4_i, lhs->As<constant::Scalar<i32>>()->ValueAs<i32>());

    ASSERT_TRUE(inst->RHS()->Is<Constant>());
    auto rhs = inst->RHS()->As<Constant>()->Value();
    ASSERT_TRUE(rhs->Is<constant::Scalar<i32>>());
    EXPECT_EQ(2_i, rhs->As<constant::Scalar<i32>>()->ValueAs<i32>());
}

TEST_F(IR_BinaryTest, Binary_Usage) {
    const auto* inst = b.And(mod.Types().i32(), b.Constant(4_i), b.Constant(2_i));

    EXPECT_EQ(inst->Kind(), Binary::Kind::kAnd);

    ASSERT_NE(inst->LHS(), nullptr);
    ASSERT_EQ(inst->LHS()->Usage().Length(), 1u);
    EXPECT_EQ(inst->LHS()->Usage()[0], inst);

    ASSERT_NE(inst->RHS(), nullptr);
    ASSERT_EQ(inst->RHS()->Usage().Length(), 1u);
    EXPECT_EQ(inst->RHS()->Usage()[0], inst);
}

TEST_F(IR_BinaryTest, Binary_Usage_DuplicateValue) {
    auto val = b.Constant(4_i);
    const auto* inst = b.And(mod.Types().i32(), val, val);

    EXPECT_EQ(inst->Kind(), Binary::Kind::kAnd);
    ASSERT_EQ(inst->LHS(), inst->RHS());

    ASSERT_NE(inst->LHS(), nullptr);
    ASSERT_EQ(inst->LHS()->Usage().Length(), 1u);
    EXPECT_EQ(inst->LHS()->Usage()[0], inst);
}

}  // namespace
}  // namespace tint::ir
