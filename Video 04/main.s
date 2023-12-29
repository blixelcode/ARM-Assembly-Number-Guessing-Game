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
	prompt:		.ascii	"Type a number: "
	winmsg:		.ascii	"You win!\n"
	highmsg:	.ascii	"Too high\n"
	lowmsg:		.ascii	"Too low\n"
	input:		.ds.b	INPUT_SIZE,FILL_VALUE
	secret:		.int	88

.text

_start:
	// Initialization section

loop:
	// PROMPT
	mov 	r0, #STDOUT
	ldr 	r1, =prompt
	mov 	r2, #15
	mov 	r7, #WRITE
	svc 	SVC_CALL

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
	mov 	r0, #STDOUT
	ldr 	r1, =winmsg
	mov 	r2, #9
	mov 	r7, #WRITE
	svc 	SVC_CALL
	b		exit

toohigh:
	mov 	r0, #STDOUT
	ldr 	r1, =highmsg
	mov 	r2, #9
	mov 	r7, #WRITE
	svc 	SVC_CALL
	b		loop

toolow:
	mov 	r0, #STDOUT
	ldr 	r1, =lowmsg
	mov 	r2, #8
	mov 	r7, #WRITE
	svc 	SVC_CALL
	b		loop

exit:
	mov r0, #EXIT_CODE
	mov r7, #EXIT_CALL
	svc SVC_CALL

.end
