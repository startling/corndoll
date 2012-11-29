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
        xor ax, ax              ; Zero out AX.
        ;; And zero out the segment registers, via AX.
        mov ds, ax
        mov es, ax
        mov fs, ax
        mov gs, ax
        cld                     ; Clear the direction flag.
;;; ==================================================================
 ;;; Now we set up the Global Descriptor Table, below.
        lgdt [gdtPtr]
;;; ==================================================================
;;; And set the low bit of CR0 to 1, going into protected mode.
        mov eax, cr0
        or al, 0x1
        mov cr0, eax
;;; ==================================================================
;;; Finally, we can re-enable interrupts and then continue.
        sti
        jmp protected
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
