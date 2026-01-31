; ===============================
; Real-mode kernel (loaded at 0x500)
; ===============================

%ifndef ELF
org 0x500 ; as same pretend this sector starting address is 0x500
%endif

bits 16
global start

start:
    mov si, msg        ; SI points to message

.print:
    lodsb              ; AL = [SI], SI++
    cmp al, 0
    je hang             ; end of string
    mov ah, 0x0E        ; BIOS teletype
    int 0x10
    jmp .print

hang:
    hlt
    jmp hang

msg db "Maddy Kernel loaded successfully", 0
