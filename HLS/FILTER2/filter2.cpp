#include "filter2.hpp"



data_type filter2(data_type input) {
	static bool initialized = false;
	static data_type d1;
	static data_type d2;
	static data_type output;

	// One-time initialization
	if (!initialized) {
		d1 = 0.0;
		d2 = 0.0;
		output = 0.0;
		initialized = true;
	}


    // Scale the input
	accum_type scaled_input = input * scaleconst1;

    // Filter operations
	accum_type a2mul = d1 * a2;
	accum_type a3mul = d2 * a3;

	accum_type a2sum = scaled_input - a2mul;
	accum_type a1sum = a2sum - a3mul;

    output = a1sum - d2;

    // Update delay line (internal static variables)
    d2 = d1;
    d1 = a1sum;

    return output;
}


