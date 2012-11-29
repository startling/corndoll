;;; ==================================================================
;;; The contents of this file are executed in protected (= 32-bit)
;;; mode. The label `protected` is jumped to immediately after we
;;; get there.
;;; ==================================================================
global protected
protected:
;;; ==================================================================
halt:
;;; ==================================================================
;;; Halt forever -- shut off interrupts and then hlt.
        cli
        hlt
;;; ==================================================================
