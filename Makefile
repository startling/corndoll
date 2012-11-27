# -*- mode: makefile -*-
AS=nasm
ASFLAGS=-felf
LD=i386-elf-ld

all: boot/all disk/all

clean: boot/clean disk/clean

include boot/Makefrag
include disk/Makefrag

.PHONY: all clean
