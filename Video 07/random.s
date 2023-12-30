.global _start

.equ	BUFFER_SIZE,10

.data
	filename:	.ascii	"file.dat"
	fd:			.int	0
	buffer:		.ds.b	BUFFER_SIZE,0

.text

_start:
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


.end
