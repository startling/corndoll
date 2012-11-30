;;; ==================================================================
;;; The contents of this file are executed in protected (= 32-bit)
;;; mode. The label `protected` is jumped to immediately after we
;;; get there.
;;; ==================================================================
bits 32
extern go
;;; ==================================================================
global protected
protected:
;;; ==================================================================
;;; Set up the stack growing downwards from 0x7c00.
;;; ==================================================================
        mov esp, 0x7c00
;;; ==================================================================
        call go
halt:
;;; ==================================================================
;;; Halt forever -- shut off interrupts and then hlt.
        cli
        hlt
;;; ==================================================================
