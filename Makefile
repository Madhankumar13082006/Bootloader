BUILD_DIR  = build
BOOTLOADER = $(BUILD_DIR)/bootloader/bootloader.bin
KERNEL     = $(BUILD_DIR)/os/kernel.bin
DISK_IMG   = build/disk.img

.PHONY: all clean qemu bootloader kernel

all: $(DISK_IMG)

bootloader:
	$(MAKE) -C bootloader

kernel:
	$(MAKE) -C os

$(DISK_IMG): bootloader kernel
	dd if=/dev/zero of=$(DISK_IMG) bs=512 count=2880
	dd if=$(BOOTLOADER) of=$(DISK_IMG) bs=512 count=1 seek=0 conv=notrunc
	dd if=$(KERNEL) of=$(DISK_IMG) bs=512 count=1 seek=1 conv=notrunc

qemu: $(DISK_IMG)
	qemu-system-i386 -fda $(DISK_IMG)

clean:
	$(MAKE) -C bootloader clean
	$(MAKE) -C os clean
	rm -f $(DISK_IMG)
