;;; ==================================================================
;;; Some nice macros for GDT entries and descriptors. Most of this is
;;; sourced from the following page of the OSDev wiki:
;;; http://wiki.osdev.org/Global_Descriptor_Table
;;; ==================================================================
%define gdtSize 8
;;; ==================================================================
%macro gdtDescriptor 2
;;; ==================================================================
;;; Create a gdt descriptor, given the number of entries and the
;;; linear address to the gdt's location.
        dw (%1 * gdtSize - 1)
        dd %2
%endmacro
;;; ==================================================================
%macro gdtEntry 4
;;; ==================================================================
;;; Create a descriptor table entry, given its limit, base, access
;;; flags, and granularity bit.
        dw (%1 & 0xffff)        ; The low word of the limit...
        dw (%2 & 0xffff)        ; and the low word of the base.
        db ((%2 >> 16) & 0xff)  ; Then the middle byte of the base...
        db %3                   ; and the access byte.
        ;; The high four bits of the limit and the granularity bit.
        db (((%1 >> 16) & 0xf) | (%4 & 0xf0))
        ;; And finally the highest byte of the base.
        db ((%2 >> 24) & 0xff)
%endmacro
;;; ==================================================================
