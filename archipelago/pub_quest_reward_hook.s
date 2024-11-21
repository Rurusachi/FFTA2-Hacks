.arm
@ 0x0213a6b4
pub_quest_reward_hook:
    b pub_quest_reward_code
    @ re-arranged order
    add r2, r2, #0x2800
    mov lr, r12, lsl #0x2
