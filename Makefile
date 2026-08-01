compile: build
	./temp-convert 32 F

build:
	m4 temp-convert.asm > temp-convert.s
	gcc temp-convert.s -o temp-convert

cross:
	m4 temp-convert.asm > temp-convert.s
	aarch64-linux-gnu-gcc -static temp-convert.s -o temp-convert

run: build
	./temp-convert
