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
        