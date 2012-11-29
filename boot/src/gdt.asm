;;; ==================================================================
;;; Some nice macros for GDT entries and descriptors. Most of this is
;;; sourced from the following page of the OSDev wiki:
;;; http://wiki.osdev.org/Global_Descriptor_Table
;;; ==================================================================
%define gdtEntrySize 8
;;; ==================================================================
%macro gdtDescriptor 2
;;; ==================================================================
;;; Create a gdt descriptor, given the number of entries and the
;;; linear address to the gdt's location.
        dw (%1 * gdtEntrySize - 1)
        dd %2
%endmacro
;;; ==================================================================
%define gdtAccess(rw, dc, ex, pr) 0 | (rw << 1) | (dc << 2) | \
  (ex << 3) | (1 << 4) | (pr << 5) | (1 << 7)
;;; ==================================================================
;;; A macro for creating the "access" bitfield for gdt entries.
;;; * The access bit is set to 0.
;;; * The rw bit tells whether a segment is readable as a code segment
;;;   or writable as a data segment. No code segments can be written
;;;   to and all data segments can be read from.
;;; * The dc bit tells the direction for this segment as a data
;;;   segment or the whether, as a code segment, it's 'conforming'
;;;   -- i.e., whether lower-privileged code can jump into it.
;;; * The ex bit tells whether this code can be executed.
;;; * The pr is two bits representing this segment's privilege ring.
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
