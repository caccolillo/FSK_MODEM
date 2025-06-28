// iir_filter.c
#include "iir_filter.h"

#define MWSPT_NSEC 7
#define MAX_SECTIONS 3

// Coefficients
const int NUM[MWSPT_NSEC][3] = {
  {  9117545, 0, 0 },
  { 2147483647, 0, -2147483648 },
  {  9117545, 0, 0 },
  { 2147483647, 0, -2147483648 },
  {  9098292, 0, 0 },
  { 2147483647, 0, -2147483648 },
  { 2147483647, 0, 0 }
};

const int DEN[MWSPT_NSEC][3] = {
  { 2147483647, 0, 0 },
  { 2147483647, -2147483648, 2138011531 },
  { 2147483647, 0, 0 },
  { 2147483647, -2147483648, 2138720858 },
  { 2147483647, 0, 0 },
  { 2147483647, -2147483648, 2129287064 },
  { 2147483647, 0, 0 }
};

// State memory
typedef struct {
    int32_t w1;
    int32_t w2;
} BiquadState;

static BiquadState filter_state[MAX_SECTIONS];

// Multiply and shift for Q31 format
static inline int32_t mult32(int32_t a, int32_t b) {
    int64_t temp = (int64_t)a * (int64_t)b;
    return (int32_t)(temp >> 31);
}

// Reset filter state
void iir_filter_reset(void) {
    for (int i = 0; i < MAX_SECTIONS; ++i) {
        filter_state[i].w1 = 0;
        filter_state[i].w2 = 0;
    }
}

// Process a single biquad section
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

// Process a single input sample
int32_t iir_filter(int32_t input) {
    int32_t x = input;

    // Section 1: Gain
    x = mult32(NUM[0][0], x);

    // Section 2: Biquad 1
    x = process_biquad(0, 1, 1, x);

    // Section 3: Gain
    x = mult32(NUM[2][0], x);

    // Section 4: Biquad 2
    x = process_biquad(1, 3, 3, x);

    // Section 5: Gain
    x = mult32(NUM[4][0], x);

    // Section 6: Biquad 3
    x = process_biquad(2, 5, 5, x);

    // Section 7: Final Gain
    x = mult32(NUM[6][0], x);

    return x;
}
