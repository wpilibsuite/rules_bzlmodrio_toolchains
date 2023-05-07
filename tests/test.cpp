
#include "gtest/gtest.h"

TEST(BasicTest, Basic) {
#ifdef __FRC_ROBORIO__
  EXPECT_EQ(1, IS_ROBORIO_TEST);
#else
  EXPECT_EQ(0, IS_ROBORIO_TEST);
#endif

#ifdef __CROSS_BULLSEYE__
  EXPECT_EQ(1, IS_BULLSEYE_TEST);
#else
  EXPECT_EQ(0, IS_BULLSEYE_TEST);
#endif

#ifdef __RASPBIAN__
  EXPECT_EQ(1, IS_RASPBIAN_TEST);
#else
  EXPECT_EQ(0, IS_RASPBIAN_TEST);
#endif
}
