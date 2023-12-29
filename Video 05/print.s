// r1 must be preloaded with the string to be printed
// before this function is called.
//
// The string that is loaded into r1 must be of type
// .asciz, not .ascii. This ensures the string will
// have a null byte at the end.
.global	print

.equ	SVC_CALL,	0
.equ	STDOUT,		1
.equ	WRITE,		4

.text

print:
	push	{r0,r2,r3,r7,lr}
	mov		r2, #0

	loop:
		ldrb	r3, [r1], #1
		cmp		r3, #0
		beq		finished
		add		r2, #1
		b		loop

finished:
	mov 	r0, #STDOUT
	mov 	r7, #WRITE
	svc 	SVC_CALL
	pop		{r0,r2,r3,r7,lr}
	bx		lr

.end
