;;; ==================================================================
;;; The assembled contents of this file should be placed in the boot
;;; sector of some drive. It needs to be 440 bytes or fewer, so that
;;; copying it doesn't overwrite the partition table or boot signature.
;;; This isn't enforced anyway, so keep an eye out.
;;; ==================================================================
;;; The contents of this file are the very first things to be run, and
;;; so they run in real (= 16-bit) mode.
;;; ==================================================================
bits 16
extern protected
;;; ==================================================================
;;; The program code of the bootloader follows:
        section .text
;;; ==================================================================
global start
start:
;;; ==================================================================
;;; Disable interrupts temporarily and begin to initialize things.
        cli
        cld                     ; Clear the direction flag.
;;; ==================================================================
;;; Set up VGA mode 0x03 (Color, 80x25). See
;;; http://www.ctyme.com/intr/rb-0069.htm
        mov al, 0x03            ; AH should still be 0.
        mov ah, 0x00
        int 0x10                ; SET VIDEO MODE
;;; ==================================================================
;;; Now we set up the Global Descriptor Table, below.
        lgdt [gdtPtr]
;;; ==================================================================
;;; And set the low bit of CR0 to 1, going into protected mode.
        mov eax, cr0
        or al, 0x1
        mov cr0, eax
;;; ==================================================================
;;; DS and SS should both be in the data (= 0x02) segment.
        mov ax, (0x02 << 3)
        mov ds, ax
        mov ss, ax
;;; ==================================================================
;;; And CS gets changed to the code (= 0x01) segment with this jump.
        jmp (0x01 << 3):protected
;;; ==================================================================
        section .data
;;; ==================================================================
        %include "boot/src/gdt.asm"
gdtPtr:
;;; ==================================================================
;;; A description of the descriptor table: four entries at gdtEntries.
        gdtDescriptor 3, gdtEntries
;;; ==================================================================
gdtEntries:
;;; ==================================================================
;;; Three descriptor table entries, as seen on the OSDev wiki
;;; http://wiki.osdev.org/GDT_Tutorial#Flat_Setup
        ;; The null segment descriptor.
        gdtEntry 0, 0, 0
        ;; A kernel-space code segment.
        gdtEntry 0xffffffff, 0, gdtAccess(0, 0, 1, 0)
        ;; A kernel-space data segment.
        gdtEntry 0xffffffff, 0, gdtAccess(1, 1, 0, 0)
        ;; TODO: tss descriptor
;;; ==================================================================
