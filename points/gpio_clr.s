// gpio_set.s
// Sets a gpio pin. Assumes that GPIO registers have been mapped to programming
// memory
// Calling scheme:
//      mov r0, GPIO_ADDRESS
//      mov r1, PIN_NUMBER
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
    sub     sp, sp, #16
    str     r4, [sp, #0]
    str     r5, [sp, #4]
    str     fp, [sp, #8]
    str     lr, [sp, #12]
    add     fp, sp, #12

    add     r4, r0, GPSET0          // pointer to GPSET regs
    mov     r5, r1

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
    ldr     fp, [sp, #8]
    ldr     lr, [sp, #12]

    add     sp, sp, #16
    bx      lr
