#include <stdio.h>
#include "pins_arduino.h"

void digitalWrite(int16_t pin, int16_t data) {
	static int8_t bit = 0;
	static uint8_t line = 0;
	static uint8_t val = 0;

	// set the data offset
	if (pin < 1) {
		bit = data;
		val = 0;
		return;
	}

	if (pin != DW_DATAPIN) return;

	if (++bit < 1) return;
	printf("%u", data);
	val |= data << (8 - bit);

	if (bit < 8) return;
	printf(" (%03u) ", val);
	bit = val = 0;

	if (++line < 3) return;
	printf("\n");
	line = 0;
}
