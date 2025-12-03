all:
	nasm -f bin ./bootloader/src/boot.asm -o ./bin/boot.bin

clean:
	rm -rf ./bin/boot.bin