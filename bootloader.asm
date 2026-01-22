org 0x7C00
bits 16

start:
    jmp boot

boot:
    cli
    cld

    ; ---- setup segments ----
    mov ax, cs
    mov ds, ax
    mov ss, ax
    mov sp, 0x7C00

    ; ---- print message ----
    mov si, msg
.print:
    lodsb              ; AL = [SI], SI++
    cmp al, 0
    je load_kernel
    mov ah, 0x0E
    int 0x10
    jmp .print

load_kernel:
    ; ---- load kernel at 0x0500 ----
    mov ax, 0x50
    mov es, ax
    xor bx, bx

    ; ---- BIOS disk read ----
    mov ah, 0x02        ; read sectors
    mov al, 1           ; read 1 sector
    mov ch, 0
    mov cl, 2           ; sector 2
    mov dh, 0
    ; DO NOT touch DL
    int 0x13
    jc disk_error

    ; ---- jump to kernel ----
    jmp 0x50:0x0000

disk_error:
    mov si, err
.errloop:
    lodsb
    cmp al, 0
    je $
    mov ah, 0x0E
    int 0x10
    jmp .errloop

msg db "Maddy OS load successfully", 0x0D, 0x0A, 0
err db "Disk read error", 0

times 510-($-$$) db 0
dw 0xAA55
