%ifndef ELF  ; 
org 0x7C00  ; starting address of our bootloader in floopy disk just pretend it by declare it , so only BIOS lodas this bootloader 
%endif

bits 16 ; we use 16 bit address mode 
global start ; by declare globbal it visible to linker and loader

start:
    jmp boot   ; like function to jump to boot function 

boot:  ;initilize the stack 
    cli	;prevent any hardware interupt , else while boot cause error 
    cld ; ensure SI increment , else wrong location of pointer prints any wrong or backward

    mov ax, cs  
    mov ds, ax
    mov ss, ax
    mov sp, 0x7C00 ; start address , here stack starts form this go downwards

    mov si, msg
.print:   ; Just here print logic 
    lodsb
    cmp al, 0
    je load_kernel
    mov ah, 0x0E
    int 0x10
    jmp .print

load_kernel:
    mov ax, 0x50  ; start address of kernal sector 2 
    mov es, ax 
    xor bx, bx

    mov ah, 0x02  
    mov al, 1 
    mov ch, 0
    mov cl, 2 ; tell thats kernel at sector 2
    mov dh, 0
    int 0x13
    jc disk_error

    jmp 0x50:0x0000

disk_error:  ; print error message 
    mov si, err
.errloop:
    lodsb
    cmp al, 0
    je $
    mov ah, 0x0E
    int 0x10
    jmp .errloop

msg db "Welcome to Maddy Operating System :)", 13, 10, 0
err db "Disk read error", 0

times 510-($-$$) db 0  ; bootloader only loads exactly 512 bytes hence padding of remaining bytes 
dw 0xAA55 ; here is core line in bootloader , BIOS only loads the kernel if last two bytes is AA 55 
