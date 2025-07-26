#include <stdio.h>
#include <stdint.h>
#include "filter_envelope_detector.hpp"

// Define filter function prototype
data_type applyIIRFilter(data_type filter_in) ;
// Q31 step input: full-scale 1.0
#define STEP_INPUT 3
#define NUM_SAMPLES 2560

int main() {
	data_type input = 0;
	data_type output = 0;

    FILE *fp = fopen("step_response.csv", "w");
    if (!fp) {
        perror("Failed to open file");
        return 0;
    }

    fprintf(fp, "Sample,Output_Q31,Output_Float\n");

    for (int n = 0; n < NUM_SAMPLES; ++n) {
        input = STEP_INPUT;
        output = applyIIRFilter(input);
        fprintf(fp, "%d,%d,%d\n", n, input , output );
    }

    fclose(fp);
    printf("Step response saved to step_response.csv\n");
    return 0;
}

