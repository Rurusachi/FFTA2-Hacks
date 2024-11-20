.macro SET_FUNC name, value
	.global \name
	.type   \name, %function
	.set    \name, \value
.endm

SET_FUNC FUN_give_item, (0x020f1358)

.global continue
.set continue, 0x0213595c

.global item_list
.set item_list, 0x02164100 @ 0x0542AD48 in rom

.arm
@ 0x02164000
bazaar_code: 
    ldr r0, [r8, #0x0]
    add r0, r0, #0x1800
    ldrh r0, [r0, #0xba]
    lsl r0, r0, #0x1
    ldr r1, =item_list
    ldrh r0, [r1, r0] @ Load item+amount into r0
    lsr r1, r0, #0xa @ amount in r1
    lsl r0, r0, #0x16
    lsr r0, r0, #0x16 @ item in r0
    @ mov r1, #0x1
    @ bl FUN_give_item
    mov lr, pc
    ldr pc, =FUN_give_item

end:
    ldr r0, [r8, #0x0]
    add r0, r0, #0x1800
    ldrh r0, [r0, #0xba]
    mov r1, #0x1
    ldr r2, =continue
    mov pc, r2
