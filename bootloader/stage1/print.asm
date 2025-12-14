BITS 16

newline dw 2
db 13, 10

stage1_message dw 17
db  'Stage 1 finished.'

Real_mode_print:
    push ax
    push cx
    push si
    mov cx, word [si]
    add si, 2
    .string_loop:
        lodsb
        mov ah, 0eh
        int 10h
        loop .string_loop
    pop si
    pop cx
    pop ax
    ret

Real_mode_println:
    push si
    call Real_mode_print
    mov si, newline
    call Real_mode_print
    pop si
    ret