#include "filter2.hpp"


// Section 1: static internal state
data_type section1(data_type input) {
	static bool initialized = false;
	static data_type d1;
	static data_type d2;

	// One-time initialization
	if (!initialized) {
		d1 = 0.0;
		d2 = 0.0;
		initialized = true;
	}


    // Scaled input
	accum_type input_scaled = input * scaleconst1_section1;

    // Filter math
	accum_type a2mul = d1 * coeff_a2_section1;
	accum_type a3mul = d2 * coeff_a3_section1;
	accum_type a1sum = (input_scaled - a2mul) - a3mul;
	accum_type b1sum = a1sum - d2;  // b3 = -1 * d2

    // Update delay line
    d2 = d1;
    d1 = a1sum;

    // Scaled output
    return b1sum * scaleconst2_section1;
}

// Section 2: static internal state
data_type section2(data_type input) {
	static bool initialized = false;
	static data_type d1;
	static data_type d2;

	// One-time initialization
	if (!initialized) {
		d1 = 0.0;
		d2 = 0.0;
		initialized = true;
	}

    // Filter math
	accum_type a2mul = d1 * coeff_a2_section2;
	accum_type a3mul = d2 * coeff_a3_section2;
	accum_type a1sum = (input - a2mul) - a3mul;
	accum_type b1sum = a1sum - d2;  // b3 = -1 * d2

    // Update delay line
    d2 = d1;
    d1 = a1sum;

    return b1sum;
}

// Top-level function using both sections
data_type filter2(data_type input) {
	data_type stage1;
	data_type output;

	stage1 = section1(input);
	output = section2(stage1);
    return output;
}

