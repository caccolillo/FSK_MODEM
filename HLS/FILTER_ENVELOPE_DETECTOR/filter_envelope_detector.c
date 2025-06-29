#include <stdint.h>
#include "filter_envelope_detector.h"

#define MWSPT_NSEC 11
#define Q31_SHIFT 31

extern const int32_t NUM[MWSPT_NSEC][3];
extern const int32_t DEN[MWSPT_NSEC][3];
extern const int NL[MWSPT_NSEC];
extern const int DL[MWSPT_NSEC];

int32_t delay[MWSPT_NSEC][2] = {0};  // One state per biquad (Direct Form II)

int32_t applyIIRFilter(int32_t input) {
    int32_t x = input;
    for (int i = 0; i < MWSPT_NSEC; i += 2) {
        // Stage 1: Gain stage (single-tap)
        int32_t y = (int64_t)x * NUM[i][0] >> Q31_SHIFT;

        // Stage 2: Second-order section (biquad)
        int64_t acc = (int64_t)y * NUM[i + 1][0]
                    + (int64_t)delay[i + 1][0] * NUM[i + 1][1]
                    + (int64_t)delay[i + 1][1] * NUM[i + 1][2]
                    - (int64_t)delay[i + 1][0] * DEN[i + 1][1]
                    - (int64_t)delay[i + 1][1] * DEN[i + 1][2];
        acc >>= Q31_SHIFT;
        int32_t output = (int32_t)acc;

        // Shift states
        delay[i + 1][1] = delay[i + 1][0];
        delay[i + 1][0] = output;

        x = output;
    }
    return x;
}

