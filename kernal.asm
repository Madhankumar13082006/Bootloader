org 0x0500
bits 16

start:
    mov ah, 0x0E
    mov al, 'M'
    int 0x10

hang:
    hlt
    jmp hang
