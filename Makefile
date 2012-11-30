# -*- mode: makefile -*-
AS=nasm
ASFLAGS=-felf
LD=i386-elf-ld
CC=clang
CFLAGS=-ccc-host-triple i386-pc-linux-gnu -nostdlib -nostdinc\
 -fno-builtin -fno-stack-protector

all: boot/all disk/all

clean: boot/clean disk/clean

include boot/Makefrag
include disk/Makefrag

.PHONY: all clean
