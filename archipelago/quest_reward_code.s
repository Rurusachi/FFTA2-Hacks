.arm
@ 0x02164450
quest_reward_code:
    @ r0 = item_id, r1 = item_amount
    cmp r0, #0x300
    bge special_item
    cmp r0, #0xf5
    beq end
give_item:
    bl FUN_give_item
end:
    b quest_reward_continue

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

    @ set name
    sub r0, r0, #0x1
    ldr r2, =custom_item_names
    mov r0, r0, lsl #0x1
    ldrh r1, [r2, r0]
    ldrb r3, [r10,#0x86] @ Reward index
    sub r3, r3, #0x1 @ Was incremented before this
    mov r3, r3, lsl #0x2
    strh r1, [r6, r3]

    @ set icon
    add r0, r10, r4, lsl #0x2
    mov r1, #job_item_icon
    strh r1, [r0, #0xa2]

    pop {r0-r3}
    b quest_reward_continue
