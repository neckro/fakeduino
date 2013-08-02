#include <inttypes.h>

#define HIGH 1
#define LOW 0
#define pinMode(a,b) {}
void digitalWrite(int16_t pin, int16_t data);

#ifndef DW_DATAPIN
	#define DW_DATAPIN 7
#endif
