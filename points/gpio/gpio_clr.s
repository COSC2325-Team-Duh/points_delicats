// gpio_set.s
// Sets a gpio pin. Assumes that GPIO registers have been mapped to programming
// memory
// Calling scheme:
//      mov r0, PIN_NUMBER
//      bl gpioSet

// Define Raspi
    .cpu    cortex-a53
    .fpu    neon-fp-armv8
    .syntax unified

// Constants
    .equ    PIN, 1
    .equ    PINS_IN_REG, 32
    .equ    GPSET0, 0x28            // set register offset

.text
.align 2
.global gpioClr
.type gpioClr, %function

gpioClr:
    sub     sp, sp, #24
    str     r4, [sp, #0]
    str     r5, [sp, #4]
    str     r6, [sp, #8]
    str     fp, [sp, #12]
    str     lr, [sp, #16]
    add     fp, sp, #16

    mov     r5, r1
                                    // works the same as gpio_set.s
    add     r4, r0, GPSET0          // see that file for details

// compute addres of GPSET register and pin field
    mov     r3, PINS_IN_REG
    udiv    r0, r5, r3              //GPSET number
    mul     r1, r0, r3              // computer remained
    sub     r1, r5, r1

    lsl     r0, r0, 2
    add     r0, r0, r4

    ldr     r2, [r0]
    mov     r3, PIN
    lsl     r3, r3, r1
    orr     r2, r2, r3
    str     r2, [r0]

    mov     r0, #0
    ldr     r4, [sp, #0]
    ldr     r5, [sp, #4]
    ldr     r6, [sp, #8]
    ldr     fp, [sp, #12]
    ldr     lr, [sp, #16]

    add     sp, sp, #24
    bx      lr
