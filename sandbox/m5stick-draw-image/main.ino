#include <M5StickC.h>

void setup()
{
  M5.begin();
  drawPixelArt();
}

void loop()
{
  M5.update();
}
