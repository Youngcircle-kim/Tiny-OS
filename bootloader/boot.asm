stage1_start:
	times 90 db 0 ; BPB(BIOS Parameter Block) 공간 확보
	%include "stage1/bootstage1.asm"
stage1_end:

stage2_start:
stage2_end:

kernel_start:
kernel_end: