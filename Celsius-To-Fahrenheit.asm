fmt: .string "%f\n"                         // Format string for printf
fmt_error: .string "Usage: %s <celsius>\n"  // Format string for error message

.data
thirtytwo: .double 32.0                     // The value 32.0 that we will use in the calculation in our formula for converting Celsius to Fahrenheit

.bss
.global val
val: .skip 8                                // Allocate space for a double value to store the result of the calculation

.text
.balign 4
.global main

main:
    stp x29, x30, [sp, -16]!                // allocate stack frame
    mov x29, sp

    cmp w0, 2                               // Check if there are at least two arguments
    b.lt error                              // Branch to error if there are not enough arguments

    cmp w0, 3                               // Check if there are more than two arguments
    b.ge error                              // Branch to error if there are too many arguments

    ldr x24, =thirtytwo                     // Load the address of the value 32.0 into x24
    ldr d5, [x24]                           // Load the value 32.0 into d5

                                            // The formula for converting Celsius to Fahrenheit is: (C * 9/5) + 32
    fmov d8, 9.0                            // Load the value 9.0 into d8
    fmov d9, 5.0                            // Load the value 5.0 into d9
    fmov d10, d5                            // Load the value 32.0 into d10

    ldr x0, [x1, 8]                         // Load the argument from the command line into x0
    bl atof                                 // Convert the argument from a string to a double
    fmov d6, d0                             // Move the converted double value into d6

    ldr x22, =val                           // Load the address of the variable val into x22

    fdiv d11, d8, d9                        // Divide 9.0 by 5.0
    fmul d12, d11, d6                       // Multiply the result of the division by the Celsius value
    fadd d13, d12, d10                      // Add 32.0 to the result of the multiplication

    str d13, [x22]                          // Store the result of the calculation in the variable val

    ldr x0, =fmt                            // Load the address of the format string into x0
    ldr d0, [x22]                           // Load the value of the variable val into d0
    bl printf                               // Print the result of the calculation
    b exit

error:
    ldr x0, =fmt_error                      // Load the address of the error message format string into x0
    ldr x1, [x1, 0]                         // Load the first argument (the program name) into x1
    mov x2, x1                              
    bl printf                               // Print the error message

exit:
    mov w0, 0                               // Return 0
    ldp x29, x30, [sp], 16                  // deallocate stack frame
    ret
