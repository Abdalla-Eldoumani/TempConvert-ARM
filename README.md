# TempConvert-ARM

TempConvert-ARM is a simple project containing ARMv8 assembly programs for converting temperatures between Celsius and Fahrenheit.

## Files
- **Celsius-To-Fahrenheit.asm**: Converts a Celsius input to Fahrenheit.
- **Fahrenheit-To-Celsius.asm**: Converts a Fahrenheit input to Celsius.

## Usage
Compile and run the assembly programs using an ARMv8 environment or emulator.

```bash
m4 Celsius-To-Fahrenheit.asm > ctf.s
gcc ctf.s -o ctf
./ctf 0 # Expected output: 32

m4 Fahrenheit-To-Celsius.asm > ftc.s
gcc ftc.s -o ftc
./ftc 32 # Expected output: 0
```
Or use the provided Makefile to compile and run the programs.

```bash
make
```