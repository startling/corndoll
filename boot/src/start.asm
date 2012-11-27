        section .text

global start
start:
        ;; Get the registers in a known state.
        xor ax, ax     ; First, clear ax.
        mov es, ax     ; Set es from it.
        mov ds, ax     ; Set ds from it, too.
        cld            ; Clear the direction flag.
        ;; Set up the stack growing down from 0x7c00.
        ;; Supposedly there's 30KiB here, free for use.
        ;; http://wiki.osdev.org/Memory_Map_(x86)
        cli            ; Turn of interrupts temporarily.
	    mov sp, 0x7c00 ; Starts at 0x7c00.
        mov ss, ax     ; Set the high byte to 0 via ax.
        sti            ; Turn interrupts back on.

;;; Halt forever.
global halt
halt:
        hlt
        jmp halt
