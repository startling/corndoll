#include "vga.h"

void go () {
    volatile vga_pair *top = (vga_pair *) 0xB8000;
    top[0].character = '!';
    top[0].attr = (0 << 4) | (15 & 0x0f);
}
