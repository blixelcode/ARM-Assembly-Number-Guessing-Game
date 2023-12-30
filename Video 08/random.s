// When this function returns, r0 will contain
// the random number.

.global rand

.equ	BUFFER_SIZE,1

.data
	filename:	.ascii	"/dev/urandom"
	fd:			.int	0
	buffer:		.ds.b	BUFFER_SIZE,0

.text

rand:
	push	{r1-r2, r7, lr}

	// Open File
	ldr		r0, =filename
	mov		r1, #0
	mov		r2, #0
	mov		r7, #5
	svc		0

	// Store fd
	ldr		r1,	=fd
	str		r0,	[r1]

	// Read File
	ldr		r1, =buffer
	mov		r2, #BUFFER_SIZE
	mov		r7, #3
	svc		0

	// Close File
	ldr		r0, =fd
	ldr		r0, [r0]
	mov		r7, #6
	svc		0

	// Recall value in buffer
	ldr		r0, [r1]

exit:
	pop		{r1-r2, r7, lr}
	bx		lr

.end
