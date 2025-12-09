BITS 16

ORG 0x7C00

Stage1_entrypoint:
    jmp 0x0000:.setup_segments
    .setup_segments:
        ;   ------------------------------
        ;   Set all segment registers to 0.
        ;   ------------------------------
        xor ax, ax              ;   AX(16-bit Accumulator register) = 0
        mov ss, ax            ;    Stack Segment  = 0x0000
        mov ds, ax            ;    Data Segment  = 0x0000
        mov es, ax            ;    Extra Segment = 0x0000
        mov fs, ax             ;    F Segment = 0x0000
        mov gs, ax            ;    G Segment = 0x0000

        ;   ------------------------------
        ;   Set up a temporary stack
        ;   ------------------------------
        ;  SS:SP = 0x0000:Stage1_entrypoint
        mov sp, Stage1_entrypoint

        ; Clear direction flag
        cld

        ; Loading stage 2 from disk into RAM
        mov [disk], dl         ;    Storing disk number.
        mov ax, (stage2_start-stage1_start)/512     ;   ax : start sector
        mov cx, (kernel_end-stage2_start)/512       ;   cx : number of sectors to read
        mov bx, stage2_start    ;   bx : offset of buffer
        
        xor dx, dx                ; dx : segment of buffer

        call Real_mode_read_disk

        mov si, stage1_message
        call Real_mode_println

    .halt:  ; Infinite loop
        hlt
        jmp .halt

%include "stage1/disk.asm"  
%include "stage1/print.asm"  

times 510-($-$$) db 0    ; Padding
dw 0xAA55                       ; 마지막 2바이트는 반드시 0xAA55 여야 BIOS가 부팅 가능한 디스크로 인식.        