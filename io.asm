bits 16

; --------------------------------
; MovCursor
; BH = row (Y)
; BL = column (X)
; --------------------------------
MovCursor:
    mov ah, 0x02
    mov dh, bh
    mov dl, bl
    mov bh, 0x00
    int 0x10
    ret

; --------------------------------
; Print
; DS:SI = zero-terminated string
; --------------------------------
Print:
.next:
    lodsb
    or al, al
    jz .done

    mov ah, 0x0E
    int 0x10
    jmp .next

.done:
    ret
