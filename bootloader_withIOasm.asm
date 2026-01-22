org 0x7C00
bits 16

start:
    cli
    cld

    mov ax, cs
    mov ds, ax

    ; Move cursor using library
    mov bh, 15
    mov bl, 20
    call MovCursor

    ; Print welcome message
    mov si, message
    call Print

hang:
    hlt
    jmp hang

message db "Welcome to Maddy operating system", 0

%include "io.asm"

times 510-($-$$) db 0
dw 0xAA55
