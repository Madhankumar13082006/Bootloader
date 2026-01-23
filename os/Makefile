BUILD_DIR=../build/os

BOOTLOADER_SRCS := $(wildcard *.asm)
BOOTLOADER_OBJS := $(patsubst %.asm,$(BUILD_DIR)/%.o,$(BOOTLOADER_SRCS))

.PHONY: all clean

all: $(BOOTLOADER_OBJS)

$(BUILD_DIR)/%.o: %.asm
	nasm -f bin $< -o $@

clean:
	rm -f $(BUILD_DIR)/*.o
