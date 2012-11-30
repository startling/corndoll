#include "vga.h"

void vga_addChar (char c, int x, int y) {
    int index = x + 80 * y;
    vga_vram[index].character = c;
    vga_vram[index].attr = vga_color(vga_light_green, vga_black);
}
