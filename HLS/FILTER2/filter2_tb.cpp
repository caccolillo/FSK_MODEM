#include <stdio.h>
#include <stdint.h>
#include "filter2.hpp"


#define STEP_INPUT 1
#define NUM_SAMPLES 256000

// Define filter function prototype
extern data_type filter2(data_type input);
extern data_type section1(data_type input);
extern data_type section2(data_type input);



int main() {
	data_type input = 0;
	data_type output = 0;

    FILE *fp = fopen("step_response.csv", "w");
    if (!fp) {
        perror("Failed to open file");
        return 0;
    }

    fprintf(fp, "Sample,Input,Output\n");

    for (int n = 0; n < NUM_SAMPLES; ++n) {
        input = STEP_INPUT;
        output = filter2(input);
        fprintf(fp, "%d,%d,%d\n", n, input , output );
    }

    fclose(fp);
    printf("Step response saved to step_response.csv\n");
    return 0;
}
