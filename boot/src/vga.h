typedef struct {
    char character;
    char attr;
}__attribute__((packed)) vga_pair;

#define vga_vram ((volatile vga_pair *) 0xb8000)
#define vga_vram_end ((volatile vga_pair *) 0xbffff)

typedef enum {
    vga_black = 0,
    vga_blue = 1,
    vga_green = 2,
    vga_cyan = 3,
    vga_red = 4,
    vga_magenta = 5,
    vga_brown = 6,
    vga_grey = 7,
    vga_dark_grey = 8,
    vga_light_blue = 9,
    vga_light_green = 10,
    vga_light_cyan = 11,
    vga_light_red = 12,
    vga_light_magenta = 13,
    vga_yellow = 14,
    vga_white = 15
} vga_color_t;

#define vga_white 15
#define vga_color(fg, bg) ((bg << 4) | fg)
