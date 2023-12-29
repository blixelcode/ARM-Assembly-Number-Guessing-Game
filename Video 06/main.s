.global _start

.equ	SVC_CALL,	0
.equ	EXIT_CODE,	0
.equ	STDIN,		0
.equ	FILL_VALUE,	0
.equ	EXIT_CALL,	1
.equ	STDOUT,		1
.equ	READ,		3
.equ	WRITE,		4
.equ	INPUT_SIZE,	10

.data
	prompt:		.asciz	"Type a number: "
	winmsg:		.asciz	"You win!\n"
	highmsg:	.asciz	"Too high\n"
	lowmsg:		.asciz	"Too low\n"
	input:		.ds.b	INPUT_SIZE,FILL_VALUE
	secret:		.int	88

.text

_start:
	// Initialization section

loop:
	// PROMPT
	ldr 	r1, =prompt
	bl		print

	// GET INPUT
	mov 	r0, #STDIN
	ldr 	r1, =input
	mov 	r2, #INPUT_SIZE
	mov 	r7, #READ
	svc		SVC_CALL

	// CHECK FOR EXIT
	mov		r0, r1
	ldrb 	r2, [r0], #1
	cmp		r2, #'x'
	beq		exit

	// HANDLE INPUT
	mov		r4, #0			// Total
	mov		r5, #10			// Power of 10 Multiplier
	handle_input:
	ldrb 	r3, [r1], #1
	sub		r3, r3, #48	
	cmp		r3, #0
	blt		compare
	mla		r4, r5, r4, r3	
	b		handle_input

compare:
	// LOAD SECRET NUMBER
	ldr		r0,	=secret
	ldr		r0, [r0]

	// COMPARE INPUT WITH SECRET NUMBER
	cmp		r4, r0
	bgt		toohigh
	blt		toolow

gameover:
	ldr 	r1, =winmsg
	bl		print
	b		exit

toohigh:
	ldr 	r1, =highmsg
	bl		print
	b		loop

toolow:
	ldr 	r1, =lowmsg
	bl		print
	b		loop

exit:
	mov r0, #EXIT_CODE
	mov r7, #EXIT_CALL
	svc SVC_CALL

.end
