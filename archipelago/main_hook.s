.arm
_start:
	ldr r4, =#0x02163ee0
	ldr r0, [r4]
	cmp r0, #0
	movne pc, r0
	push {r4-r6, lr}
	ldr r0, =#0x0211CCF8 @ Filename. MelonDS freezes if it's invalid (other emulators don't)
	bl FUN_0201fe38 @ Adjust manually. (0xEBFE25C9)
	mov r2, #0x1000
	ldr r1, =#0x05280d28
	stmib r0, {r1, r2}
	add r1, pc, #4
    str r1, [sp, #0xc]
	bl FUN_0208acac @ Returns loaded address in r0
	add r0, #0x18
	str r0, [r4]
	mov pc, r0
