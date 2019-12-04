// Define the Pi
    .cpu    cortex-a53
    .fpu    neon-fp-armv8
    .syntax unified
    
    .equ    PAGE_SIZE, 4096 // Size of the page file
    .equ    STACK_ARGS, 8   //stack 8-byte aligned

.global unmapMem
unmapMem:
    sub sp, sp, #16
    str r4, [sp, #0]
    str r5, [sp, #4]
    str fp, [sp, #8]
    str lr, [sp, #12]
    add fp, sp, #12
    sub sp, sp, STACK_ARGS


@ BEGIN UNMAP
// cleanup and exit
    mov r0, r5                  // memory to unmap
    mov r1, PAGE_SIZE           // amount we mapped
    bl  munmap
    mov r0, r4
    bl close

    mov r0, r5
    add sp, sp, STACK_ARGS
    ldr r4, [sp, #0]
    ldr r5, [sp, #4]
    ldr fp, [sp, #8]
    ldr lr, [sp, #12]
    add sp, sp, #16
    bx lr
