org 0x0500  ; starting of sector or location
bits 16 ; 16 bit in real mode

start:
    mov ah, 0x0E ;acculator high just select character print sunction like 
    mov al, 'M' ; then print it print M
    int 0x10 ;which location to print like grid of the computer screen 

hang: ; safe stop
    hlt
    jmp hang
