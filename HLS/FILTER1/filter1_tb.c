#include <stdio.h>
#include <stdint.h>
#include "filter1.h"

#define STEP_VALUE   100000  // step height
#define NUM_SAMPLES  10000  // Length of step response

int main(void) {
    int32_t input[NUM_SAMPLES];
    int32_t output[NUM_SAMPLES];
    int i;

    // Step input: constant value after time zero
    for (i = 0; i < NUM_SAMPLES; ++i) {
        input[i] = STEP_VALUE;
    }

    // Reset filter state
    iir_filter_reset();

    // Apply filter
    for (i = 0; i < NUM_SAMPLES; ++i) {
        output[i] = filter1(input[i]);
    }

    // Save to CSV
    FILE *fp = fopen("step_response.csv", "w");
    if (!fp) {
        perror("Unable to open file");
        return 1;
    }

    fprintf(fp, "Sample,Output_Q31,Output_Float\n");
    for (i = 0; i < NUM_SAMPLES; ++i) {
        float y_float = output[i] / 2147483647.0f;
        fprintf(fp, "%d,%d,%.7f\n", i, output[i], y_float);
    }

    fclose(fp);

    // Optionally print to console as well
    printf("Step response written to step_response.csv\n");

    return 0;
}

