#include <inttypes.h>

#define MSBFIRST 0
#define SPI_MODE0 0

class SPIClass {
  public:
    static void begin();
    static void end();
    static void transfer(uint8_t);
    static void setBitOrder(uint8_t);
    static void setDataMode(uint8_t);
    static void setClockDivider(uint8_t);
};

extern SPIClass SPI;
