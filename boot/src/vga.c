#include "vga.h"

void go () {
    volatile vga_pair *top = vga_start;
    top[0].character = '!';
    top[0].attr = (0 << 4) | (15 & 0x0f);
}
