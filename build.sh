if [ ! -d bin ] 
then
    mkdir -p bin
fi

#assembly files
nasm -f elf ./boot/boot.asm -o ./bin/boot.o

#compile c source files
gcc -m32 -elf_i386 -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I./kernel/include -c -o ./bin/main.o ./kernel/main.c
gcc -m32 -elf_i386 -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I./kernel/include -c -o ./bin/screen.o ./kernel/screen.c
gcc -m32 -elf_i386 -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I./kernel/include -c -o ./bin/gdt.o ./kernel/gdt.c
gcc -m32 -elf_i386 -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I./kernel/include -c -o ./bin/idt.o ./kernel/idt.c
gcc -m32 -elf_i386 -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I./kernel/include -c -o ./bin/isr.o ./kernel/isr.c


#linker scripts
ld -T link.ld -m elf_i386 -o kernel.bin ./bin/boot.o ./bin/main.o ./bin/screen.o ./bin/gdt.o ./bin/idt.o ./bin/isr.o