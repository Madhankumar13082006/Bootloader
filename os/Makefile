# Output directory (relative to os/)
BUILD_DIR := ../build/os

KERNEL_OBJ = $(BUILD_DIR)/kernel.o
KERNEL_ELF = $(BUILD_DIR)/kernel.elf
KERNEL_BIN = $(BUILD_DIR)/kernel.bin

.PHONY: all clean

all: $(KERNEL_BIN)  #initally loads all in this directory

$(KERNEL_BIN): kernel.asm kernel.lds  #this bin depends on .asm and .lsd
	mkdir -p $(BUILD_DIR)
	nasm -f elf32 -DELF -g -F dwarf kernel.asm -o $(KERNEL_OBJ)  #build .obj
	ld -m elf_i386 -T kernel.lds $(KERNEL_OBJ) -o $(KERNEL_ELF) #build .elf
	objcopy -O binary $(KERNEL_ELF) $(KERNEL_BIN) #build .bin --final need to bootloader to load in bootloader bios is need it 

clean:
	rm -rf $(BUILD_DIR)
