/obj/item/weapon/ranged/bullet/revolver/rocket
	name = "70mm Recoilless NT-AAWS"
	desc = "I'm a Rocket Man."
	desc_extended = "NT's answer to the Syndicate Mechs and Borgs: NT Anti Armor Weapon System. Single-shot portable anti-tank weapon, though if you're brave enough you can try to use it more than once."
	icon = 'icons/obj/item/weapons/ranged/misc/rocket.dmi'
	icon_state = "inventory"
	value = 6000

	company_type = "NanoTrasen"

	tier_type = "rocket launcher"

	tier = 3
	bypass_balance_check = TRUE

	automatic = FALSE

	bullet_count_max = 1

	shoot_sounds = list('sound/weapons/ranged/rifle/rocket/shoot.ogg')

	can_wield = TRUE

	size = SIZE_5
	weight = 16

	zoom_mul = 2

	view_punch_mod = 0

	bullet_length_min = 750
	bullet_length_best = 800
	bullet_length_max = 850

	bullet_diameter_min = 65
	bullet_diameter_best = 70
	bullet_diameter_max = 75

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 1
	movement_spread_base = 1

	uses_until_condition_fall = 0

	rarity = RARITY_RARE

/obj/item/weapon/ranged/bullet/revolver/rocket/get_base_spread()
	return 0.02

/obj/item/weapon/ranged/bullet/revolver/rocket/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/revolver/rocket/get_skill_spread(var/mob/living/L)
	return max(0,0.03 - (0.12 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/revolver/rocket/use_condition(var/amount_to_use=1)
	adjust_quality(-10)
	return TRUE
