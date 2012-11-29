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
%define gdtAccess(rw, dc, ex, pr) \
;;; ==================================================================
;;; A macro for creating the "access" bitfield for gdt entries.
        ;; The access bit; should start out at 0.
        0
        ;; Whether this is segment is readable as a code segment or
        ;; writable as a data segment. No code segments can be written
        ;; to; all data segments can be read from.
        | rw << 1 \
        ;; The direction for this segment as a data segment (0 is up,
        ;; 1 is down, you probably want 1) or the "conforming" bit for
        ;; this segment as a code segment (whether it can be executed
        ;; by lower-privileged code).
        | dc << 2 \
        ;; Whether this code can be executed (1 for executable).
        | ex << 3 \
        ;; Just a 1.
        | 01 << 4 \
        ;; The two-bit representation of the segment's privilege ring.
        | pr << 5 \
        ;; The "present" bit -- must be 1.
        | 01 << 7
;;; ==================================================================
%macro gdtEntry 3-5 1, 1
;;; ==================================================================
;;; Create a descriptor table entry, given its limit, base, access
;;; flags, and, optionally, its size bit and granularity bit.
        dw (%1 & 0xffff)        ; The low word of the limit...
        dw (%2 & 0xffff)        ; and the low word of the base.
        db ((%2 >> 16) & 0xff)  ; Then the middle byte of the base...
        db %3                   ; and the access byte.
        ;; The high four bits of the limit and the granularity bit,
        ;; as well as 1 (= 32bit) for the size bit.
        db (((%1 >> 16) & 0xf) | (%5 << 7) | (%4 << 6))
        ;; And finally the highest byte of the base.
        db ((%2 >> 24) & 0xff)
%endmacro
;;; ==================================================================
