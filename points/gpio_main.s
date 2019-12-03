.global main
.type main, %function

main:
    sub     sp, sp, #16
    str     r5, [sp, #0]
    str     r6, [sp, #4]
    str     lr, [sp, #8]
    str     fp, [sp, #12]
    add     fp, sp, #16

// get the memory address
    bl      mapMem
    mov     r5, r0
    
// set the pinMode
    mov r0, r5              // GPIO Address
    mov r1, #6              // pin number
    mov r2, #1              // Pin Function type: 01 to set an output, 00 is
                            // input, which is set by default
                            

    bl gpioSelect

// set a value to the Pin

    mov r0, r5              // GPIO Address
    mov r1, #6              // pin number
    bl gpioSet

    mov r0, #2
    bl sleep

    mov r0, r5
    mov r1, #6
    bl gpioClr

    mov r0, #2
    bl sleep

    mov r0, r5              // GPIO Address
    mov r1, #6              // pin number
    bl gpioSet

    mov r0, #2
    bl sleep

    mov r0, r5
    mov r1, #6
    bl gpioClr
    bl      unmapMem

// clean up and exit
    ldr     r5, [sp, #0]
    ldr     r6, [sp, #4]
    ldr     lr, [sp, #8]
    ldr     fp, [sp, #12]
    add     sp, sp, #16
    mov     r0, #0
    bx      lr

.data
msg:
    .asciz "Made it this far!\n"
