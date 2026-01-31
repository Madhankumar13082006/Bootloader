🧠 Minimal x86 Bootloader & Kernel (From Scratch)

This project is a minimal x86 operating system bootstrapping experiment, developed while studying the book
Operating Systems: From 0 to 1.
The goal is to understand how a computer boots from power-on to executing the first instruction, at the lowest possible level — before any operating system, runtime, or libraries exist.

📌 Overview

This project demonstrates:
BIOS boot process
Boot sector execution at 0x7C00
Loading a kernel from disk
Flat binary vs ELF binaries
Low-level debugging using QEMU + GDB
Build automation using GNU Make

🛠 Tools & Environment

NASM – Assembly compiler (x86, 16-bit & 32-bit)
QEMU – Hardware emulator (acts like a fresh computer)
GDB – Low-level debugging
GNU Make – Build automation
Ubuntu (WSL) – Linux environment on Windows
(Initially MSYS was used, later switched to Ubuntu for better tooling support)

🧩 Initial Manual Workflow

At first, everything was done manually:
Assemble .asm files into .bin
Create a floppy disk image
Write bootloader to sector 1
Write kernel to sector 2
Run QEMU manually
This worked, but it was repetitive and error-prone.

⚙️ Build Automation (Makefile)

To reduce overhead, a Makefile-based build system was created.
With a single command:make

Assembles bootloader and kernel
Creates a floppy disk image
Writes binaries into correct disk sectors
To start a fresh virtual computer:
make qemu

🧬 Boot Process (Step-by-Step)

QEMU starts and emulates real x86 hardware
BIOS performs POST (Power-On Self Test)
BIOS loads sector 1 into memory at 0x7C00
BIOS checks boot signature 0xAA55
Execution jumps to the bootloader
Bootloader reads sector 2 from disk
Kernel is loaded into memory
Control is transferred to the kernel
This matches how real PCs boot.

📍 Why 0x7C00?

BIOS always loads the first boot sector to memory address 0x7C00
Breakpoints are placed at 0x7C00 in GDB to debug bootloader execution
This address is fixed by BIOS convention

📦 Binary vs ELF (Important Insight)
.bin (Flat Binary)

Required by BIOS
No symbols or debug info
Hard to debug

.elf (For Debugging)

Contains symbols, labels, and addresses
Used by GDB for source-level debugging
Helps track execution flow during early boot

👉 BIOS executes only .bin,
👉 ELF files are used only for debugging & inspection.

🐞 Debugging with QEMU + GDB

QEMU runs with a GDB stub
GDB connects remotely
Breakpoints can be placed at:
0x7C00 (bootloader start)
Kernel entry point
This allows inspection of registers, memory, and instruction flow in real time.

🎯 Learning Outcome

This project helped understand:
BIOS boot mechanics
Disk sector loading
Memory addressing in real mode
Why OS kernels are freestanding
How ELF metadata helps debugging
How a computer starts before an OS exists
This is a minimal educational OS project, focused on clarity and fundamentals, not features.

📚 Reference

Operating Systems: From 0 to 1
