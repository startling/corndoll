;;; ==================================================================
;;; The contents of this file are executed in protected (= 32-bit)
;;; mode. The label `protected` is jumped to immediately after we
;;; get there.
;;; ==================================================================
bits 32
extern vga_addChar
;;; ==================================================================
global protected
protected:
;;; ==================================================================
;;; Set up the stack growing downwards from 0x7c00.
;;; ==================================================================
        mov esp, 0x7c00
;;; ==================================================================
;;; Stick a dwarf on the screen.
        push 0
        push 0
        push 1
        call vga_addChar
halt:
;;; ==================================================================
;;; Halt forever -- shut off interrupts and then hlt.
        cli
        hlt
;;; ==================================================================
