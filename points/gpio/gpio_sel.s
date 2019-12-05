// gpio_sel.s
// Selects a function for a GPIO pin. Address of GPIO pins in memory must
// already be mapped before running this function.
// Calling scheme:
//      r0, PIN_NUMBER
//      r1, PIN_FUNCTION
//      bl gpioSelect
//
// Code adapted from: https://bob.cs.sonoma.edu/IntroCompOrg-RPi/sec-gpio-pins
// .html

// Define the pi
    .cpu    cortex-a53
    .fpu    neon-fp-armv8
    .syntax unified

// Constants
    .equ PIN_FIELD, 0b111 // 3 bits!

.text
.align 2
.global gpioSelect
.type gpioSelect, %function

gpioSelect:
    // set up registers
    sub     sp, sp, #24         // create room in stack (8-byte aligned)
    str     r4, [sp, #4]
    str     r5, [sp, #8]
    str     r6, [sp, #12]
    str     fp, [sp, #16]
    str     lr, [sp, #20]
    add     fp, sp, #20

    mov     r4, r0
    mov     r5, r1              // store pin number in r5
    mov     r6, r2              // store pin function in r2

// Compute GPFSEL register address
    mov     r3, #10             // divisor 10 registers in each GPFSEL
    udiv    r0, r5, r3          // get the GPFSEL number

    mul     r1, r0, r3          // computers the remainder for the
    sub     r1, r5, r1          //      GPFSEL pin

// Set the GPIO pin function register in program memory
    lsl     r0, r0, #2
    add     r0, r4, r0
    ldr     r2, [r0, #0]

    mov     r3, r1
    add     r1, r1, r3, lsl 1
    mov     r3, PIN_FIELD
    lsl     r3, r3, r1
    bic     r2, r2, r3

    lsl     r6, r6, r1
    orr     r2, r2, r6
    str     r2, [r0, #0]

    mov     r0, #0
    ldr     r4, [sp, #4]
    ldr     r5, [sp, #8]
    ldr     r6, [sp, #12]
    ldr     fp, [sp, #16]
    ldr     lr, [sp, #20]
    add     sp, sp, #24
    bx      lr

