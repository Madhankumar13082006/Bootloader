# It is top most make file which compile things are correctly loads in the floppy disk

BUILD_DIR  = build
BOOTLOADER = $(BUILD_DIR)/bootloader/bootloader.bin
KERNEL     = $(BUILD_DIR)/os/kernel.bin
DISK_IMG   = build/disk.img

.PHONY: all clean qemu bootloader kernel

all: $(DISK_IMG)

bootloader:
	$(MAKE) -C bootloader   # just call bootloader make file to execute those things

kernel:
	$(MAKE) -C os

$(DISK_IMG): bootloader kernel
	dd if=/dev/zero of=$(DISK_IMG) bs=512 count=2880  # just create the floppy disk of 512*2880=1.4 mb
	dd if=$(BOOTLOADER) of=$(DISK_IMG) bs=512 count=1 seek=0 conv=notrunc  # bootloader.bin raw bytes are loads in sector 1 0x7c00
	dd if=$(KERNEL) of=$(DISK_IMG) bs=512 count=1 seek=1 conv=notrunc     # kernel.bin raw bytes are loads in sector 2 0x500

qemu: $(DISK_IMG)
	qemu-system-i386 -fda $(DISK_IMG)   # QEMU runs that floppy disk

clean:
	$(MAKE) -C bootloader clean
	$(MAKE) -C os clean
	rm -f $(DISK_IMG)
