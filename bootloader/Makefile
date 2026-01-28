# Output directory (relative to bootloader/)
BUILD_DIR := ../build/bootloader

BOOT_BIN := $(BUILD_DIR)/bootloader.bin
BOOT_ELF := $(BUILD_DIR)/bootloader.elf
BOOT_OBJ := $(BUILD_DIR)/bootloader.o

.PHONY: all clean

all: $(BOOT_BIN)

$(BOOT_BIN): bootloader.asm bootloader.lds
	mkdir -p $(BUILD_DIR)
	nasm -f elf32 -DELF -g -F dwarf bootloader.asm -o $(BOOT_OBJ)
	ld -m elf_i386 -T bootloader.lds $(BOOT_OBJ) -o $(BOOT_ELF)
	objcopy -O binary $(BOOT_ELF) $(BOOT_BIN)

clean:
	rm -rf $(BUILD_DIR)
