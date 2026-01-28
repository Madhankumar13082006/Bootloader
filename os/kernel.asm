; ===============================
; Real-mode kernel (loaded at 0x500)
; ===============================

%ifndef ELF
org 0x500
%endif

bits 16
global start

start:
    mov ah, 0x0E ;acculator high just select character print sunction like 
    mov al, 'M' ; then print it print M
    int 0x10 ;which location to print like grid of the computer screen 

hang: ; safe stop
    hlt
    jmp hang