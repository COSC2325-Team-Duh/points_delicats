// gpio_mem.s
// Selects a function for a GPIO pin.
// Code adapted from https://bob.cs.sonoma.edu/IntroCompOrg-RPi/sec-gpio-mem
// .html

// Define the Pi
    .cpu    cortex-a53
    .fpu    neon-fp-armv8
    .syntax unified

// the following are defined in /usr/include/asm-generic/fcnl.h
    .equ    O_RDWR, 00000002 // open for read/write
    .equ    O_DSYNC, 00010000 // synchronize virtual memory
    .equ    __O_SYNC, 04000000
    .equ    O_SYNC, __O_SYNC|O_DSYNC // I/O Memory

// the following are defined in /usr/include/asm-generic/mman-common.h
    .equ    PROT_READ, 0x1  // page can be read
    .equ    PROT_WRITE, 0x2 // page can be written
    .equ    MAP_SHARED, 0x01 // share changes

// The following are defined by the original author
// These are how the memory is mapped and accessed.

    .equ    PERIPH, 0x3f000000 // RPI 2 & 3 periphals
    .equ    GPIO_OFFSET, 0x200000 // Start of GPIO device in mem
    .equ    O_FLAGS,O_RDWR|O_SYNC
    .equ    PROT_RDWR, PROT_READ|PROT_WRITE
    .equ    NO_PREF, 0
    .equ    PAGE_SIZE, 4096 // Size of the page file
    .equ    FILE_DESCRP_ARG, 0  // file descriptor
    .equ    DEVICE_ARG, 4   // device address
    .equ    STACK_ARGS, 8   //stack 8-byte aligned

.data
.align 2
device:
    .asciz  "/dev/gpiomem"
fdMsg:
    .asciz  "File descriptor = %i\n"
memMsg:
    .asciz  "Using memory at %p\n"

// main program
.text
.align 2
.global mapMem
.type   mapMem, %function

mapMem:             // RETURN GPIO ADDRESS as r0
    sub sp, sp, #16
    str r4, [sp, #0]
    str r5, [sp, #4]
    str fp, [sp, #8]
    str lr, [sp, #12]
    add fp, sp, #12
    sub sp, sp, STACK_ARGS

// Open /dev/gpiomem
    ldr r0, deviceAddr
    ldr r1, openMode
    bl  open
    mov r4, r0

// map the GPIO
    str r4, [sp, FILE_DESCRP_ARG]
    ldr r0, gpio                // address of GPIO
    str r0, [sp, DEVICE_ARG]    // location of GPIO
    mov r0, NO_PREF             // kernel pick memory
    mov r1, PAGE_SIZE           // get 1 page of memory
    mov r2, PROT_RDWR           // READ/WRITE THIS MEM
    mov r3, MAP_SHARED          // share with other processes
    bl  mmap
    mov r5, r0                  // save virtual mem address

@ END OF MEMORY MAPPIN, DAWG

// restore stack
    mov r0, r5
    add sp, sp, STACK_ARGS
    ldr r4, [sp, #0]
    ldr r5, [sp, #4]
    ldr fp, [sp, #8]
    ldr lr, [sp, #12]
    add sp, sp, #16
    bx lr

.align 2
fdMsgAddr:  .word   fdMsg
deviceAddr: .word   device
openMode:   .word   O_FLAGS
memMsgAddr: .word   memMsg
gpio:       .word   PERIPH+GPIO_OFFSET
delayMS:    .int    1000
