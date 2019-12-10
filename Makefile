CFLAGS=-m32
AFLAGS=-f elf

build:	tema2

tema2:	tema2.o include/macro.o include/utils.o
	gcc $^ -o $@ $(CFLAGS)

tema2.o:tema2.asm
	nasm $^ -o $@ $(AFLAGS)

debug: build
	gdb --args ./tema2 inputs/task4_3.pgm 4 cent 50

clean:
	rm -rf tema2.o tema2