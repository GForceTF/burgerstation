/obj/item/paper/
	name = "Paper"
	desc = "Paper!"
	desc_extended = "Historically used to write things on."

	icon = 'icons/obj/item/paper.dmi'
	icon_state = "normal"

	var/last_page = 1

	var/list/data = list("There is nothing here.","Also nothing here.")

	value = 1

	drop_sound = 'sound/items/drop/paper.ogg'

	var/editable = TRUE

	weight = 0.01

/obj/item/paper/click_self(var/mob/activator,location,control,params)

	if(!is_player(activator) || !activator.client)
		return ..()

	INTERACT_CHECK
	INTERACT_DELAY(2)

	var/mob/living/advanced/player/P = activator

	if(P.active_paper)
		close_menu(P,/menu/paper/)

	if(P.active_paper == src)
		P.active_paper = null
		return TRUE

	P.active_paper = src
	open_menu(P,/menu/paper/)

	return TRUE

/obj/item/paper/on_unequip(var/obj/hud/inventory/old_inventory,var/silent=FALSE)

	if(old_inventory && is_player(old_inventory.owner) && old_inventory.owner.client)
		var/mob/living/advanced/player/P = old_inventory.owner
		if(P.active_paper == src)
			close_menu(P,/menu/paper/)
			P.active_paper = null

	return ..()

