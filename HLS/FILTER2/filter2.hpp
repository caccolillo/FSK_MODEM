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

// Coefficients
const coeff_type scaleconst1 = 6.5174976764364075E-03;
const coeff_type a2 = -1.9830539690604794E+00;
const coeff_type a3 = 9.8696500464712711E-01;

typedef ap_fixed<DataWordSize+CoeffWordSize+3, DataIntSize+CoeffIntSize, AP_TRN, AP_WRAP, 0> accum_type;

// Processes one sample through the fixed-point IIR filter
data_type filter2(data_type input);



