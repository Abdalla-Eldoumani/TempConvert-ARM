# temp-convert

An ARMv8 assembly program that converts a temperature between Celsius,
Fahrenheit and Kelvin. One file, three faces, picked by what you pass it.
It replaces the two one-way converters this repo used to hold.

A reading is a number with a unit stuck to it: 36.6C, 98.6f, 310K. Case
does not matter. Everything comes out to two decimals, and anything
colder than absolute zero is refused with the floor quoted back in the
unit you typed.

## The terminal

Run it with no arguments. It draws a thermometer for every reading:
a bulb at the cold end, a column filled to where the reading landed, and
the three scales sharing one axis so the pointer sits at the same place
on all of them. The column is coloured by the band it reached: cyan
below freezing, the face's own grey through the ordinary middle, amber
at body heat, red above it.

```
$ ./temp-convert
temp-convert
  a reading is a number and a unit: 36.6C, 98.6F, 310K.
  type q to quit.

  reading -------------------------------------------------
  > 98.6F
      37.00 C  =     98.60 F  =    310.15 K
              abs zero                  ice body  boil
                                            v
 C -273.15 (*)+=========================+===+-----+  100.00
 F -459.67 (*)+=========================+===+-----+  212.00
 K    0.00 (*)+=========================+===+-----+  373.15
  right about human body temperature.

  reading -------------------------------------------------
  > q
bye.
```

Nothing is ever redrawn or moved, so every reading stays on screen under
the one before it.

## The console

Pass `console` for the same loop with no escape bytes in it at all: no
colours, and the fill still reads because a filled column is `=` where an
empty one is `-`. This is the face for anything that shows the output as
text rather than driving a terminal.

```
$ ./temp-convert console
temp-convert
  a reading is a number and a unit: 36.6C, 98.6F, 310K.
  type q to quit.

  reading -------------------------------------------------
  > -1K
  -1.00 K is below absolute zero (0.00 K).

  reading -------------------------------------------------
  > q
bye.
```

## One shot

Give it a value and a unit. It prints the conversion, draws the same
instrument, and exits 0. No colour codes, so it pipes.

```
$ ./temp-convert 32 F
       0.00 C  =     32.00 F  =    273.15 K
              abs zero                  ice body  boil
                                        v
 C -273.15 (*)+=========================+---+-----+  100.00
 F -459.67 (*)+=========================+---+-----+  212.00
 K    0.00 (*)+=========================+---+-----+  373.15
  right at the freezing point of water.
```

Anything else prints one usage line and exits 1.

## Build

On the CS ARM servers, where gcc is already aarch64:

```
m4 temp-convert.asm > temp-convert.s
gcc temp-convert.s -o temp-convert
```

Or use the Makefile:

```
make        # build, then run ./temp-convert 32 F
make run    # build, then start the interactive terminal face
make cross  # build with aarch64-linux-gnu-gcc, for qemu on an x86 box
```

## Run it in a browser

https://aarch64-playground.vercel.app/playground?example=temp-convert
