typedef struct {
    char attr;
    char character;
}__attribute__((packed)) vga_pair;

#define vga_start 0xb8000
#define vga_end 0xbffff
#define vga_count 0x34fff
