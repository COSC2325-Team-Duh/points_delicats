
//---------------------------------------
//	Code Section
// ---------------------------------------

.text
.global main


main:

	push 	{ip, lr}	// push return address + dummy register
						// for alignment

	//  printf( "Raspberry Pi - Blinking led test in assembly" )
	ldr	r0, =IntroMsg
	bl 	printf

	bl	wiringPiSetup

init:
	//  pinMode(pin, OUTPUT)
	ldr	r0, =pin
	ldr	r0, [r0]
	mov	r1, #OUTPUT
	bl	pinMode

	//while loopCounter < 4:
	ldr	r4, =loopCounter
	ldr	r4, [r4]
	mov	r5, #4
    	b 	whileLoop

whileLoop:
	// digitalWrite(pin, 1)
	ldr	r0, =LedOnMsg
	bl 	printf
	ldr	r0, =pin
	ldr	r0, [r0]
	mov	r1, #1
	bl 	digitalWrite

	// delay(1000)
	ldr	r0, =delayMs
	ldr	r0, [r0]
	bl	delay

	// digitalWrite(pin, 0)
	ldr	r0, =LedOffMsg
	bl 	printf
	ldr	r0, =pin
	ldr	r0, [r0]
	mov	r1, #0
	bl 	digitalWrite

	// delay(1000)
	ldr	r0, =delayMs
	ldr	r0, [r0]
	bl	delay

	add	r4, #1
	cmp r4, r5
	beq done
	b	whileLoop

done:
    pop 	{ip, pc}	//pop return address into pc

//---------------------------------------
//	Data Section
// ---------------------------------------

.data

IntroMsg: 	.asciz  "Raspberry Pi - Blinking led test in assembly\n"
LedOnMsg:	.asciz "...led on\n"
LedOffMsg:	.asciz "led off...\n"
ErrMsg:	 	.asciz	"Setup didn't work... Aborting...\n"
pin:	 	.int	22
loopCounter:.int	0
delayMs: 	.int	1000
OUTPUT	 =	1


