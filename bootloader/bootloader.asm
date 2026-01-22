org 0x7C00 ; start at this location
bits 16 ;real mode 16 bit 

start:
    jmp boot ;like function 

boot:
    cli ;clear interupt
    cld ;forward string instruction first 

    ; ---- setup segments ---- this means setup stack gradually form that 0x7C00
    mov ax, cs
    mov ds, ax
    mov ss, ax
    mov sp, 0x7C00

    ; ---- print message ---- just like this is loop to print the of the message 
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
    mov ax, 0x50 ; accumator register 
    mov es, ax ; extra segment register
    xor bx, bx ;bx=0

    ; ---- BIOS disk read ----
    mov ah, 0x02        ; read sectors - ah for high bit
    mov al, 1           ; read 1 sector -acummalator low 
    mov ch, 0
    mov cl, 2           ; sector 2
    mov dh, 0
    ; DO NOT touch DL why because conventionally designated register for passing input parameters to system calls
    int 0x13
    jc disk_error

    ; ---- jump to kernel ----
    jmp 0x50:0x0000

disk_error:
    mov si, err
.errloop: ; just print in loop error message
    lodsb
    cmp al, 0
    je $
    mov ah, 0x0E
    int 0x10
    jmp .errloop

msg db "Maddy OS load successfully", 0x0D, 0x0A, 0
err db "Disk read error", 0

times 510-($-$$) db 0  ;this is for padding remaong bytes
dw 0xAA55  ; last two bytes are AA 55 because to verify that this sector is bootloader or not 
