# temp-convert

An ARMv8 assembly program that converts a temperature between Celsius,
Fahrenheit and Kelvin. One file, two modes. It replaces the two one-way
converters this repo used to hold.

## Interactive

Run it with no arguments. It draws the three scales, then reads one
temperature at a time until you type q.

```
$ ./temp-convert
temp-convert
  a reading is a number and a unit: 36.6C, 98.6F, 310K.
  type q to quit.

reading> 98.6F
      37.00 C  =     98.60 F  =    310.15 K
             abs zero                   ice body  boil
                                            v
 C   -273.15 +--------------------------+---+-----+  100.00
 F   -459.67 +--------------------------+---+-----+  212.00
 K      0.00 +--------------------------+---+-----+  373.15
  right about human body temperature.

reading> q
bye.
```

The three rows are one axis read three ways, so the pointer sits at the
same column on all of them. Case does not matter and the unit can be
lowercase. Anything colder than absolute zero is refused, with the floor
quoted back in the unit you typed.

## One shot

Give it a value and a unit. It prints the conversion and exits 0.

```
$ ./temp-convert 32 F
       0.00 C  =     32.00 F  =    273.15 K
```

That line carries no colour codes, so it pipes cleanly. Any other number
of arguments prints a usage line and exits 1.

## Build

On the CS ARM servers, where gcc is already aarch64:

```
m4 temp-convert.asm > temp-convert.s
gcc temp-convert.s -o temp-convert
```

Or use the Makefile:

```
make        # build, then run ./temp-convert 32 F
make run    # build, then start the interactive mode
make cross  # build with aarch64-linux-gnu-gcc, for qemu on an x86 box
```

## Run it in a browser

https://aarch64-playground.vercel.app/playground?example=temp-convert
