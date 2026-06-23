
// SystemCore Toolchain
#if defined(__FIRST_SYSTEMCORE__) && IS_SYSTEMCORE_TEST == 0
#error "This shouldn't happen"
#elif !defined(__FIRST_SYSTEMCORE__) && IS_SYSTEMCORE_TEST == 1
#error "This shouldn't happen"
#endif

#include <iostream>

int main() { return 0; }
