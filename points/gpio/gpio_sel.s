// gpio_sel.s
// Selects a function for a GPIO pin. Address of GPIO pins in memory must
// already be mapped before running this function.
// Calling scheme:
//      r0, GPIO_ADDR
//      r1, PIN_NUMBER
//      r2, PIN_FUNCTION
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

    mov     r4, r0              // store gpio address r4
    mov     r5, r1              // store pin number in r5
    mov     r6, r2              // store pin function in r2
    
                                // r5 = 27 for example

// Compute GPFSEL register address
    mov     r3, #10             // divisor 10 registers in each GPFSEL
    udiv    r0, r5, r3          // r0 = r5 / r3 = 2

    mul     r1, r0, r3          // r1 = r0 * r3 = 20
    sub     r1, r5, r1          // r1 = r5 - r1 = 7

// Set the GPIO pin function register in program memory
    lsl     r0, r0, #2          // r0 = r0 << 2 == 0x8 (0b0010 -> 0b1000)
    add     r0, r4, r0          // r0 = r4 + r0 == 0x8 (*GPFSEL2)
    ldr     r2, [r0, #0]        // r2 = GPFSEL

    mov     r3, r1              // r3 = r1 = 7
    add     r1, r1, r3, lsl 1   // r1 = r1 + (r3 << 1) = 21
    mov     r3, PIN_FIELD       // r3 = 0b111
    lsl     r3, r3, r1          // r3 = r3 << r1 = 0x00E00000
    bic     r2, r2, r3          // r2 = r2 & (^r3) = r2 clear previous setting 

    lsl     r6, r6, r1          // r6 = r6 << r1 = 0x00200000
    orr     r2, r2, r6          // r2 = r2 | r6 = 0x00200000
    str     r2, [r0, #0]        // r0 = GPFSEL2

    mov     r0, #0              // return 0
    ldr     r4, [sp, #4]        // restore stack
    ldr     r5, [sp, #8]
    ldr     r6, [sp, #12]
    ldr     fp, [sp, #16]
    ldr     lr, [sp, #20]
    add     sp, sp, #24
    bx      lr

