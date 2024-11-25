.arm
@ 0x021644D0
pub_quest_reward_code:
    @ r2 = item_id
    cmp r2, #0x300
    bge special_item
normal_item:
    add r2, r2, #0x2f8
    b pub_quest_reward_normal

special_item:
    push {r0-r1}
    sub r2, r2, #0x300
    sub r2, r2, #0x1
    ldr r0, =custom_item_names
    mov r2, r2, lsl #0x1
    ldrh r2, [r0, r2]

    @ Change item id
    add r0, r5, r1, lsl #0x2
    mov r1, #job_item_icon
    strh r1, [r0, #0x6]



    pop {r0-r1}
    b pub_quest_reward_special
