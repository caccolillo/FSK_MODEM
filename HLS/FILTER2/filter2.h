// iir_filter.h
#ifndef IIR_FILTER_H
#define IIR_FILTER_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

// Processes one sample through the fixed-point IIR filter
int32_t iir_filter(int32_t input);

// Resets internal state of the IIR filter
void iir_filter_reset(void);

#ifdef __cplusplus
}
#endif

#endif // IIR_FILTER_H

