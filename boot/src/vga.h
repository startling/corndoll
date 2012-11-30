typedef struct {
    char attr;
    char character;
}__attribute__((packed)) vga_pair;

#define vga_start ((volatile vga_pair *) 0xb8000)
#define vga_end ((volatile vga_pair *) 0xbffff)
#define vga_count 0x34fff
#define vga_vram vga_start
