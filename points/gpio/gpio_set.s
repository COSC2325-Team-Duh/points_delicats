// gpio_set.s
// Sets a gpio pin. Assumes that GPIO registers have been mapped to programming
// memory
// Calling scheme:
//      r0, GPIO_ADDR
//      r1, PIN_NUMBER
//      bl gpioSet

// Define Raspi
    .cpu    cortex-a53
    .fpu    neon-fp-armv8
    .syntax unified

// Constants
    .equ    PIN, 1
    .equ    PINS_IN_REG, 32
    .equ    GPSET0, 0x1c            // set register offset

.text
.align 2
.global gpioSet
.type gpioSet, %function

gpioSet:
    sub     sp, sp, #24
    str     r4, [sp, #0]
    str     r5, [sp, #4]
    str     r6, [sp, #8]
    str     fp, [sp, #12]
    str     lr, [sp, #16]
    add     fp, sp, #16
                                    // (for the example math)
    mov     r5, r1                  // pin number = 34

    add     r4, r0, GPSET0          // r4 = 0x1c <--offset for *GPSETn regs

// compute addres of GPSET register and pin field
    mov     r3, PINS_IN_REG         // r3 = 32
    udiv    r0, r5, r3              // *GPSETn r0 = r5 / r3 = 1

    mul     r1, r0, r3              // r1 = r0 * r3 = 32
    sub     r1, r5, r1              // r1 = r5 - r1 = 2

    lsl     r0, r0, #2              // r0 = r0 << 2 = 0x04
    add     r0, r0, r4              // r0 = r0 + *GPSET = 0x20 (*GPSET1)

    ldr     r2, [r0]                // r2 = *GPSET1
    mov     r3, PIN                 // r3 = 1
    lsl     r3, r3, r1              // r3 = r3 << r1 = 0x00000002
    orr     r2, r2, r3              // r2 = r2 | r3 (write the pin)
    str     r2, [r0]                // GPSET1 = r2

    mov     r0, #0                  // return 0
    ldr     r4, [sp, #0]            // restore the stack
    ldr     r5, [sp, #4]
    ldr     r6, [sp, #8]
    ldr     fp, [sp, #12]
    ldr     lr, [sp, #16]

    add     sp, sp, #24
    bx      lr
