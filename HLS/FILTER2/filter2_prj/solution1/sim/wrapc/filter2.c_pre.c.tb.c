// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
# 1 "/home/caccolillo/Downloads/TUTORIAL_FSK/FSK_MODEM/HLS/FILTER2/filter2.c"
# 1 "/home/caccolillo/Downloads/TUTORIAL_FSK/FSK_MODEM/HLS/FILTER2/filter2.c" 1
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 149 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "/home/caccolillo/Downloads/TUTORIAL_FSK/FSK_MODEM/HLS/FILTER2/filter2.c" 2

# 1 "/home/caccolillo/Downloads/TUTORIAL_FSK/FSK_MODEM/HLS/FILTER2/filter2.h" 1




# 1 "/home/caccolillo/Xilinx_2022_2/Vitis_HLS/2022.2/lnx64/tools/clang/bin/../lib/clang/3.1/include/stdint.h" 1 3
# 34 "/home/caccolillo/Xilinx_2022_2/Vitis_HLS/2022.2/lnx64/tools/clang/bin/../lib/clang/3.1/include/stdint.h" 3
# 1 "/usr/include/stdint.h" 1 3 4
# 26 "/usr/include/stdint.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/libc-header-start.h" 1 3 4
# 33 "/usr/include/x86_64-linux-gnu/bits/libc-header-start.h" 3 4
# 1 "/usr/include/features.h" 1 3 4
# 439 "/usr/include/features.h" 3 4
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 440 "/usr/include/features.h" 2 3 4
# 461 "/usr/include/features.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/sys/cdefs.h" 1 3 4
# 452 "/usr/include/x86_64-linux-gnu/sys/cdefs.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/wordsize.h" 1 3 4
# 453 "/usr/include/x86_64-linux-gnu/sys/cdefs.h" 2 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/long-double.h" 1 3 4
# 454 "/usr/include/x86_64-linux-gnu/sys/cdefs.h" 2 3 4
# 462 "/usr/include/features.h" 2 3 4
# 485 "/usr/include/features.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/gnu/stubs.h" 1 3 4
# 10 "/usr/include/x86_64-linux-gnu/gnu/stubs.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/gnu/stubs-64.h" 1 3 4
# 11 "/usr/include/x86_64-linux-gnu/gnu/stubs.h" 2 3 4
# 486 "/usr/include/features.h" 2 3 4
# 34 "/usr/include/x86_64-linux-gnu/bits/libc-header-start.h" 2 3 4
# 27 "/usr/include/stdint.h" 2 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/types.h" 1 3 4
# 27 "/usr/include/x86_64-linux-gnu/bits/types.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/wordsize.h" 1 3 4
# 28 "/usr/include/x86_64-linux-gnu/bits/types.h" 2 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/timesize.h" 1 3 4
# 29 "/usr/include/x86_64-linux-gnu/bits/types.h" 2 3 4


typedef unsigned char __u_char;
typedef unsigned short int __u_short;
typedef unsigned int __u_int;
typedef unsigned long int __u_long;


typedef signed char __int8_t;
typedef unsigned char __uint8_t;
typedef signed short int __int16_t;
typedef unsigned short int __uint16_t;
typedef signed int __int32_t;
typedef unsigned int __uint32_t;

typedef signed long int __int64_t;
typedef unsigned long int __uint64_t;






typedef __int8_t __int_least8_t;
typedef __uint8_t __uint_least8_t;
typedef __int16_t __int_least16_t;
typedef __uint16_t __uint_least16_t;
typedef __int32_t __int_least32_t;
typedef __uint32_t __uint_least32_t;
typedef __int64_t __int_least64_t;
typedef __uint64_t __uint_least64_t;



typedef long int __quad_t;
typedef unsigned long int __u_quad_t;







typedef long int __intmax_t;
typedef unsigned long int __uintmax_t;
# 141 "/usr/include/x86_64-linux-gnu/bits/types.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/typesizes.h" 1 3 4
# 142 "/usr/include/x86_64-linux-gnu/bits/types.h" 2 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/time64.h" 1 3 4
# 143 "/usr/include/x86_64-linux-gnu/bits/types.h" 2 3 4


typedef unsigned long int __dev_t;
typedef unsigned int __uid_t;
typedef unsigned int __gid_t;
typedef unsigned long int __ino_t;
typedef unsigned long int __ino64_t;
typedef unsigned int __mode_t;
typedef unsigned long int __nlink_t;
typedef long int __off_t;
typedef long int __off64_t;
typedef int __pid_t;
typedef struct { int __val[2]; } __fsid_t;
typedef long int __clock_t;
typedef unsigned long int __rlim_t;
typedef unsigned long int __rlim64_t;
typedef unsigned int __id_t;
typedef long int __time_t;
typedef unsigned int __useconds_t;
typedef long int __suseconds_t;

typedef int __daddr_t;
typedef int __key_t;


typedef int __clockid_t;


typedef void * __timer_t;


typedef long int __blksize_t;




typedef long int __blkcnt_t;
typedef long int __blkcnt64_t;


typedef unsigned long int __fsblkcnt_t;
typedef unsigned long int __fsblkcnt64_t;


typedef unsigned long int __fsfilcnt_t;
typedef unsigned long int __fsfilcnt64_t;


typedef long int __fsword_t;

typedef long int __ssize_t;


typedef long int __syscall_slong_t;

typedef unsigned long int __syscall_ulong_t;



typedef __off64_t __loff_t;
typedef char *__caddr_t;


typedef long int __intptr_t;


typedef unsigned int __socklen_t;




typedef int __sig_atomic_t;
# 28 "/usr/include/stdint.h" 2 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/wchar.h" 1 3 4
# 29 "/usr/include/stdint.h" 2 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/wordsize.h" 1 3 4
# 30 "/usr/include/stdint.h" 2 3 4




# 1 "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h" 1 3 4
# 24 "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h" 3 4
typedef __int8_t int8_t;
typedef __int16_t int16_t;
typedef __int32_t int32_t;
typedef __int64_t int64_t;
# 35 "/usr/include/stdint.h" 2 3 4


# 1 "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h" 1 3 4
# 24 "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h" 3 4
typedef __uint8_t uint8_t;
typedef __uint16_t uint16_t;
typedef __uint32_t uint32_t;
typedef __uint64_t uint64_t;
# 38 "/usr/include/stdint.h" 2 3 4





typedef __int_least8_t int_least8_t;
typedef __int_least16_t int_least16_t;
typedef __int_least32_t int_least32_t;
typedef __int_least64_t int_least64_t;


typedef __uint_least8_t uint_least8_t;
typedef __uint_least16_t uint_least16_t;
typedef __uint_least32_t uint_least32_t;
typedef __uint_least64_t uint_least64_t;





typedef signed char int_fast8_t;

typedef long int int_fast16_t;
typedef long int int_fast32_t;
typedef long int int_fast64_t;
# 71 "/usr/include/stdint.h" 3 4
typedef unsigned char uint_fast8_t;

typedef unsigned long int uint_fast16_t;
typedef unsigned long int uint_fast32_t;
typedef unsigned long int uint_fast64_t;
# 87 "/usr/include/stdint.h" 3 4
typedef long int intptr_t;


typedef unsigned long int uintptr_t;
# 101 "/usr/include/stdint.h" 3 4
typedef __intmax_t intmax_t;
typedef __uintmax_t uintmax_t;
# 35 "/home/caccolillo/Xilinx_2022_2/Vitis_HLS/2022.2/lnx64/tools/clang/bin/../lib/clang/3.1/include/stdint.h" 2 3
# 6 "/home/caccolillo/Downloads/TUTORIAL_FSK/FSK_MODEM/HLS/FILTER2/filter2.h" 2






int32_t iir_filter(int32_t input);


void iir_filter_reset(void);
# 3 "/home/caccolillo/Downloads/TUTORIAL_FSK/FSK_MODEM/HLS/FILTER2/filter2.c" 2





const int NUM[7][3] = {
  {
       9722799, 0, 0
  },
  {
    2147483647, 0, -2147483648
  },
  {
       9722799, 0, 0
  },
  {
    2147483647, 0, -2147483648
  },
  {
       9700913, 0, 0
  },
  {
    2147483647, 0, -2147483648
  },
  {
    2147483647, 0, 0
  }
};

const int DEN[7][3] = {
  {
    2147483647, 0, 0
  },
  {
    2147483647, -2147483648, 2137155102
  },
  {
    2147483647, 0, 0
  },
  {
    2147483647, -2147483648, 2138366919
  },
  {
    2147483647, 0, 0
  },
  {
    2147483647, -2147483648, 2128081823
  },
  {
    2147483647, 0, 0
  }
};


typedef struct {
    int32_t w1;
    int32_t w2;
} BiquadState;

static BiquadState filter_state[3];


static inline int32_t mult32(int32_t a, int32_t b) {
    int64_t temp = (int64_t)a * (int64_t)b;
    return (int32_t)(temp >> 31);
}


void iir_filter_reset(void) {
    for (int i = 0; i < 3; ++i) {
        filter_state[i].w1 = 0;
        filter_state[i].w2 = 0;
    }
}


static int32_t process_biquad(int section_index, int num_index, int den_index, int32_t x) {
    BiquadState* state = &filter_state[section_index];
    int32_t w = x - mult32(DEN[den_index][1], state->w1)
                  - mult32(DEN[den_index][2], state->w2);
    int32_t y = mult32(NUM[num_index][0], w)
              + mult32(NUM[num_index][1], state->w1)
              + mult32(NUM[num_index][2], state->w2);
    state->w2 = state->w1;
    state->w1 = w;
    return y;
}


int32_t filter2(int32_t input) {
    int32_t x = input;


    x = mult32(NUM[0][0], x);


    x = process_biquad(0, 1, 1, x);


    x = mult32(NUM[2][0], x);


    x = process_biquad(1, 3, 3, x);


    x = mult32(NUM[4][0], x);


    x = process_biquad(2, 5, 5, x);


    x = mult32(NUM[6][0], x);

    return x;
}
#ifndef HLS_FASTSIM
#ifdef __cplusplus
extern "C"
#endif
int apatb_filter2_ir(int);
#ifdef __cplusplus
extern "C"
#endif
int filter2_hw_stub(int input){
int _ret = filter2(input);
return _ret;
}
#ifdef __cplusplus
extern "C"
#endif
int apatb_filter2_sw(int input){
int _ret = apatb_filter2_ir(input);
return _ret;
}
#endif
# 117 "/home/caccolillo/Downloads/TUTORIAL_FSK/FSK_MODEM/HLS/FILTER2/filter2.c"

