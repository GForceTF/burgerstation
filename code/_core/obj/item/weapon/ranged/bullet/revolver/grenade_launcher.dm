/obj/item/weapon/ranged/bullet/revolver/grenade_launcher
	name = "\improper 40mm Grenade Launcher"
	desc = "Blooper"
	desc_extended = "An old grenade launcher from a past era, uses 40mm grenades."
	icon = 'icons/obj/item/weapons/ranged/grenade_launcher.dmi'
	icon_state = "inventory"
	value = 2400

	company_type = "Solarian"

	tier_type = "grenade launcher"

	tier = 1
	bypass_balance_check = TRUE

	shoot_delay = 10

	automatic = TRUE

	bullet_count_max = 1

	insert_limit = 1

	shoot_sounds = list('sound/weapons/ranged/rifle/grenade_launcher/shoot.ogg')

	size = SIZE_4
	weight = 12

	bullet_length_min = 45
	bullet_length_best = 46
	bullet_length_max = 47

	bullet_diameter_min = 39
	bullet_diameter_best = 40
	bullet_diameter_max = 41

	heat_max = 0.18

	open = TRUE

	attachment_whitelist = list(
		/obj/item/attachment/sight/laser_sight = FALSE,
		/obj/item/attachment/sight/quickfire_adapter = FALSE,
		/obj/item/attachment/sight/red_dot = FALSE,
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = FALSE,



		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 0 - 16
	attachment_barrel_offset_y = 0 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 0 - 16
	attachment_undermount_offset_y = 0 - 16

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.04

	rarity = RARITY_RARE

/obj/item/weapon/ranged/bullet/revolver/grenade_launcher/get_base_spread()
	return 0.1

/obj/item/weapon/ranged/bullet/revolver/grenade_launcher/get_static_spread()
	return 0.01

/obj/item/weapon/ranged/bullet/revolver/grenade_launcher/get_skill_spread(var/mob/living/L)
	return max(0,0.03 - (0.12 * L.get_skill_power(SKILL_RANGED)))


/obj/item/weapon/ranged/bullet/revolver/grenade_launcher/undermount
	attachment_whitelist = list() //no
	value = 0
	open = TRUE
	can_shoot_while_open = TRUE

/obj/item/weapon/ranged/bullet/revolver/grenade_launcher/undermount/click_self(var/mob/activator,location,control,params)
	return TRUE

/obj/item/weapon/ranged/bullet/revolver/grenade_launcher/multibarrel
	name = "40mm revolving grenade launcher"
	desc = "Thoomp! Thoomp! Thoomp!"
	desc_extended = "An old grenade launcher from a past era, uses 40mm grenades."
	icon = 'icons/obj/item/weapons/ranged/grenade_launcher_multi.dmi'
	icon_state = "inventory"
	value = 2400

	company_type = "Solarian"

	tier = 2

	shoot_delay = 20

	automatic = FALSE

	bullet_count_max = 4

	rarity = RARITY_RARE

/obj/item/weapon/ranged/bullet/revolver/grenade_launcher/nanotrasen
	name = "\improper 40mm Grenade Thumper"
	desc = "Thumper."
	desc_extended = "A modern single capacity grenade launcher for a modern corporate army."
	icon = 'icons/obj/item/weapons/ranged/grenade_launcher_nt.dmi'
	icon_state = "inventory"
	value = 2400

	shoot_delay = 20

	company_type = "NanoTrasen"

	rarity = RARITY_RARE