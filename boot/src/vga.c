#include "vga.h"

void go () {
    vga_vram[0].character = 1;
    vga_vram[0].attr = vga_color(vga_light_green, vga_black);
}
