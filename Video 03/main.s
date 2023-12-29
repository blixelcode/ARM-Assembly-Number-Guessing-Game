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
	prompt:	.ascii	"Type a number: "
	input:	.ds.b	INPUT_SIZE,FILL_VALUE

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

	// HANDLE INPUT
	mov		r4, #0			// Total
	mov		r5, #10			// Power of 10 Multiplier
	handle_input:
	ldrb 	r3, [r1], #1
	sub		r3, r3, #48	
	cmp		r3, #0
	blt		exit
	// v1 = v2 * v3 + v4
	mla		r4, r6, r5, r3	
	b		handle_input

exit:
	mov r0, #EXIT_CODE
	mov r7, #EXIT_CALL
	svc SVC_CALL

.end
