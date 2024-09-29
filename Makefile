compile:
	m4 Celsius-To-Fahrenheit.asm > ctf.s
	gcc ctf.s -o ctf
	./ctf 0

	m4 Fahrenheit-To-Celsius.asm > ftc.s
	gcc ftc.s -o ftc
	./ftc 32