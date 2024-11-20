.macro SET_FUNC name, value
	.global \name
	.type   \name, %function
	.set    \name, \value
.endm

SET_FUNC bazaar_code, (0x02164000)

.arm
@ 0x0213594c
bazaar_hook:
    ldr r0, =bazaar_code
    mov pc, r0
