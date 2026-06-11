
#include "gtest/gtest.h"

TEST(BasicTest, Basic) {
#ifdef __FIRST_SYSTEMCORE__
  EXPECT_EQ(1, IS_SYSTEMCORE_TEST);
#else
  EXPECT_EQ(0, IS_SYSTEMCORE_TEST);
#endif
}
