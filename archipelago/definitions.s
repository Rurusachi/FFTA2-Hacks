.macro SET_FUNC name, value
	.global \name
	.type   \name, %function
	.set    \name, \value
.endm

@ Main

SET_FUNC FUN_0201fe38, (0x0201fe38)
SET_FUNC FUN_0208acac, (0x0208acac)
SET_FUNC FUN_020cbab8, (0x020cbab8)
SET_FUNC FUN_020cbac8, (0x020cbac8)
SET_FUNC FUN_02096a58, (0x02096a58)
SET_FUNC FUN_Add_unit_to_clan, (0x0209648c)
SET_FUNC FUN_02095be4, (0x02095be4)
@SET_FUNC FUN_continue, (0x02096734)


@ Bazaar

SET_FUNC bazaar_code, (0x02164000)
SET_FUNC FUN_give_item, (0x020f1358)

.global bazaar_continue
.set bazaar_continue, 0x0213595c

.global bazaar_item_list
.set bazaar_item_list, 0x02164100 @ 0x0542AD48 in rom


@ Quest rewards

SET_FUNC quest_reward_code, (0x02164400)
SET_FUNC quest_reward_continue, (0x020ff590)
SET_FUNC quest_reward_next, (0x020ff5ac) @ skip giving and writing name

.global job_flags
.set job_flags, 0x0212d755


.global job_item_icon
.set job_item_icon, 0xFB

.global custom_item_names
.set custom_item_names, 0x02164500 @ 0x0542AD48 in rom


@ Pub quest rewards

SET_FUNC pub_quest_reward_code, (0x02164480)
SET_FUNC pub_quest_reward_normal, (0x0213a6b8)
SET_FUNC pub_quest_reward_special, (0x0213a6bc)
