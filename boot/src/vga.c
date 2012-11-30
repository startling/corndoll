#include "vga.h"

void go () {
    vga_vram[0].character = '!';
    vga_vram[0].attr = (0 << 4) | (15 & 0x0f);
}
