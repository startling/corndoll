        section .text

global start
start:
        nop

;;; Halt forever.
global halt
halt:
        hlt
        jmp halt
