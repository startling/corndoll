        section .text

global start
start:
        ;; Get the registers in a known state.
        xor ax, ax         ; By first clearing ax.
        mov es, ax         ; And setting es from it.
        mov ds, ax         ; ds, too.
        cld                ; Clear the direction flag.

;;; Halt forever.
global halt
halt:
        hlt
        jmp halt
