BUILD_DIR=build
BOOTLOADER=$(BUILD_DIR)/bootloader/bootloader.o
OS=$(BUILD_DIR)/os/kernal.o
DISK_IMG=disk.img

.PHONY: all bootdisk bootloader os clean

all: bootdisk

bootloader:
	$(MAKE) -C bootloader

os:
	$(MAKE) -C os

bootdisk: bootloader os
	dd if=/dev/zero of=$(DISK_IMG) bs=512 count=2880
	dd conv=notrunc if=$(BOOTLOADER) of=$(DISK_IMG) bs=512 count=1 seek=0
	dd conv=notrunc if=$(OS) of=$(DISK_IMG) bs=512 count=1 seek=1

clean:
	$(MAKE) -C bootloader clean
	$(MAKE) -C os clean
	rm -f $(DISK_IMG)
