.arm
@ 02163EF8
mov r0, r10
bl FUN_020cbab8
mov r11, r0
bl FUN_020cbac8
mov r6, r0
cmp r11, #0x0
cmpne r6, #0x0
mov r9, #0x0
moveq r0, #0x0
popeq {r3-r11,pc}
mov r0, #0x2
bl FUN_02096a58
mov r8, r0
mov r7, r9
and r5, r10, #0x3f
mov r4, #0x1
b LAB_02096788

LAB_02096738:
	cmp r5,#0x0
	ldrb r0,[r6,#0x3a]
	bne LAB_02096754
	mov r0,r0, lsl #0x1d
	movs r0,r0, lsr #0x1f
	beq LAB_02096760
	b LAB_02096780
LAB_02096754:
	mov r0,r0, lsl #0x1c
	movs r0,r0, lsr #0x1f
	beq LAB_02096780
LAB_02096760:
	ldrb r2,[r6,#0xc]
	mov r1,r10
	and r0,r7,#0xff
	str r2,[sp,#0x0]
	ldrb r2,[r6,#0xa]
	ldrb r3,[r6,#0xb]
	bl FUN_Add_unit_to_clan
	mov r9,r4
LAB_02096780:
	add r7, r7, #0x1
	add r6, r6, #0x3c
LAB_02096788:
	cmp r7, r8
	blt LAB_02096738
	cmp r9, #0x0
	beq LAB_020967a8
	tst r10, #0x3f
	bne LAB_020967a8
	mov r0, r11
	bl FUN_02095be4
LAB_020967a8:
	mov r0,r9
	pop {r3-r11,pc}
