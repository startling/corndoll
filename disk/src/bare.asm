;;; Pad up to 510 -- no disk signature or partition table for now.
        times 510 - ($ - $$) db 0
;;; And then the boot signature.
        dw 0xaa55
