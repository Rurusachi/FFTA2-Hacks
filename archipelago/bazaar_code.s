.arm
@ 0x02164000
bazaar_code: 
    ldr r0, [r8, #0x0]
    add r0, r0, #0x1800
    ldrh r0, [r0, #0xba]
    lsl r0, r0, #0x1
    ldr r1, =bazaar_item_list
    ldrh r0, [r1, r0] @ Load item+amount into r0
    lsr r1, r0, #0xa @ amount in r1
    lsl r0, r0, #0x16
    lsr r0, r0, #0x16 @ item in r0
    @ mov r1, #0x1
    cmp r0, #0x300
    bge special_item
    cmp r0, #0xf5
    beq end
    bl FUN_give_item

end:
    ldr r0, [r8, #0x0]
    add r0, r0, #0x1800
    ldrh r0, [r0, #0xba]
    mov r1, #0x1
    b bazaar_continue

special_item:
    @ Job items only
    push {r0-r3}
    sub r0, r0, #0x300
    @ prepare flag
    and r2, r0, #0x7 @ bit_index
    mov r1, #1
    mov r1, r1, lsl r2
    
    ldr r3, =job_flags
    ldrb r2, [r3, r0, lsr #0x3]
    orr r2, r2, r1
    strb r2, [r3, r0, lsr #0x3]

    pop {r0-r3}
    b end
