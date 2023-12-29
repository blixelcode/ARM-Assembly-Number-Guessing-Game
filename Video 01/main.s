.global _start

.equ	SVC_CALL,	0
.equ	EXIT_CODE,	0
.equ	EXIT_CALL,	1
.equ	STDOUT,		1
.equ	WRITE,		4

.data
	prompt:	.ascii	"Type a number: "

.text

_start:
	// Initialization section

loop:
	mov r0, #STDOUT
	ldr r1, =prompt
	mov r2, #15
	mov r7, #WRITE
	svc SVC_CALL

exit:
	mov r0, #EXIT_CODE
	mov r7, #EXIT_CALL
	svc SVC_CALL

.end
