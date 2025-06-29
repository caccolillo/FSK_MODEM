#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

// Define filter function prototype
int32_t applyIIRFilter(int32_t input);

// Q31 step input: full-scale 1.0
#define STEP_INPUT 0x7FFFFFFF
#define NUM_SAMPLES 256

int main() {
    FILE *fp = fopen("step_response.csv", "w");
    if (!fp) {
        perror("Failed to open file");
        return EXIT_FAILURE;
    }

    fprintf(fp, "Sample,Output_Q31,Output_Float\n");

    for (int n = 0; n < NUM_SAMPLES; ++n) {
        int32_t input = STEP_INPUT;
        int32_t output = applyIIRFilter(input);
        fprintf(fp, "%d,%f,%f\n", n, input , output );
    }

    fclose(fp);
    printf("Step response saved to step_response.csv\n");
    return EXIT_SUCCESS;
}

