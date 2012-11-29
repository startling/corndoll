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
;;; Quick introduction to my understanding of real mode segmented
;;; addressing: SS:SP represents the top of the stack, meaning the
;;; linear address you get by multiplying the segment selector (SS in
;;; this case) by 16 and adding that to the offset (SP).
;;; 
;;; tl;dr: The linear address of the stack is SS * 16 + SP.
;;; ==================================================================
;;; There's some space (30 KiB) immediately before 0x7c00 that we can
;;; use for the stack. See: http://wiki.osdev.org/Memory_Map_(x86)
        mov ss, ax              ; Zero out SS and set SP such that
        mov sp, 0x7c00          ; SS * 16 + SP == 0x7c00.
;;; ==================================================================
 ;;; Now we set up the Global Descriptor Table, below.
        lgdt [gdtPtr]
;;; ==================================================================
;;; And set the low bit of CR0 to 1, going into protected mode.
        mov eax, cr0
        or al, 0x1
        mov cr0, eax
;;; ==================================================================
;;; Finally, we can re-enable interrupts.
        sti
;;; ==================================================================
halt:
;;; ==================================================================
;;; Halt forever -- shut off interrupts and then hlt.
        cli
        hlt

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
