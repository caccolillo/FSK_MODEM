#include <ap_int.h>
#include <ap_fixed.h>
#include <math.h>


// Data format
const int DataWordSize = 25;
const int DataIntSize = 3;
const float DataMaxVal = pow(2.0, DataIntSize-1);
typedef ap_fixed<DataWordSize, DataIntSize, AP_RND, AP_SAT, 0> data_type;


//coefficient constants and data types
const int CoeffWordSize = 18;
const int CoeffIntSize = 4;
typedef ap_fixed<CoeffWordSize, CoeffIntSize, AP_RND, AP_SAT, 0> coeff_type;



// Coefficients for section 1
const coeff_type scaleconst1_section1 = 6.1170672733034965E-03;
const coeff_type coeff_a2_section1 = -1.9812743944956361E+00;
const coeff_type coeff_a3_section1 = 9.9095325489279062E-01;
const coeff_type scaleconst2_section1 = 6.1170672733034965E-03;

// Coefficients for section 2
const coeff_type coeff_a2_section2 = -1.9836937929369820E+00;
const coeff_type coeff_a3_section2 = 9.9174538760882180E-01;

typedef ap_fixed<DataWordSize+CoeffWordSize+3, DataIntSize+CoeffIntSize, AP_TRN, AP_WRAP, 0> accum_type;



// Processes one sample through the fixed-point IIR filter
data_type filter1(data_type input);
data_type section1(data_type input);
data_type section2(data_type input);


