// When this function returns, r0 will contain
// the random number.

.global rand

.equ	BUFFER_SIZE,4

.data
	filename:	.ascii	"/dev/urandom"
	fd:			.int	0
	buffer:		.ds.b	BUFFER_SIZE,0

.text

rand:
	push	{r2-r7, lr}
	
	mov		r3, r0	// MIN_RAND
	mov		r4, r1	// MAX_RAND
	
	// THIS IS TEMP
	mov		r3, #1
	mov		r4, #100

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

	// R3 is min, R4 is max
	mov		r6, #0	// bitmask
	mov		r5, r4	// Backup MAX_RAND

	loop:
		cmp		r5, #0
		beq		exit_loop
		lsr		r5, #1
		lsl		r6, #1
		add		r6, #1
		b		loop
		
	exit_loop:
	and		r0, r6

exit:
	pop		{r2-r7, lr}
	bx		lr

.end
