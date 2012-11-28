        section .text

global start
start:
        cli                     ; Disable interrupts for initialization.
        xor ax, ax              ; Zero out AX.
        cld                     ; Clear the direction flag.
;;; ==================================================================
;;; Quick introduction to my understanding of real mode segmented
;;; addressing: SS:SP represents the top of the stack, meaning the
;;; linear address you get by multiplying the segment selector (SS in
;;; this case) by 16 and adding that to the offset (SP).
;;; 
;;; tl;dr: The linear address of the stack is SS * 16 + SP.
;;; ==================================================================
;;; There's some space (30 KiB) immediately before 0x7c00 that we can
;;; use for the stack. See: http://wiki.osdev.org/Memory_Map_(x86)
        mov ss, ax              ; Zero out SS and set SP such that
        mov sp, 0x7c00          ; SS * 16 + SP == 0x7c00.
        sti                     ; We can reenable interrupts now.

;;; Halt forever -- shut off interrupts and then hlt.
halt:
        cli
        hlt
