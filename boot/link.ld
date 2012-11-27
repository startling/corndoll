ENTRY(start)
OUTPUT_FORMAT(binary)
SECTIONS
{
  /* Code will be loaded to 0x7c00. */
  . = 0x7c00;
  .text : { *(.text) }
  .data : { *(.data) }
  .bss  : { *(.gbss)  }
}
