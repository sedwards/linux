#ifndef M1_COMPAT_H
#define M1_COMPAT_H

// Check if uuid_t is already defined
#ifdef __APPLE__
#include <sys/_types/_uuid_t.h>
#else
// Define a struct-based uuid_t compatible with the Linux kernel
typedef struct {
    unsigned char b[16];
} uuid_t;
#endif

#endif // M1_COMPAT_H


