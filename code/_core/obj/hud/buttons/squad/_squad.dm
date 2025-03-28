/obj/hud/button/squad/main
	name = "squad button"
	desc = "We ARMA now."
	desc_extended = "Click here to open the squad menu."
	icon = 'icons/hud/hud.dmi'
	icon_state = "squad"
	screen_loc = "LEFT,TOP-2"

	flags_hud = FLAG_HUD_MOB

	alpha = 100

	has_quick_function = FALSE

/obj/hud/button/squad/main/update_icon()

	if(owner && is_player(owner))
		var/mob/living/advanced/player/P = owner
		if(P.current_squad && alpha != 255)
			animate(src,alpha = 255,time=10)
		else if(!P.current_squad && alpha != 100)
			animate(src,alpha = 100,time=10)

	return ..()

/obj/hud/button/squad/main/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	. = ..()

	if(. && is_player(activator))
		var/mob/living/advanced/player/P = activator

		if(length(SSsquad.all_squads))

			var/list/squad_table = list()

			squad_table["Create New Squad"] = "Create New Squad"

			if(P.current_squad)
				squad_table["Leave Existing Squad"] = "Leave Existing Squad"

			for(var/k in SSsquad.all_squads)
				var/squad/S = k
				var/name_format = "[S.name] ([length(S.members)]/[SQUAD_MEMBERS_MAX])"
				squad_table[name_format] = S

			var/answer = input("Which squad would you like to join?","Squad Selection",null) as null|anything in squad_table

			if(!P || !answer)
				return FALSE

			if(P.current_squad && answer == "Leave Existing Squad")
				P.current_squad.remove_member(P)
				return ..()

			else if(answer == "Create New Squad")
				new_squad(P)
				return ..()

			else if(answer != "Cancel")
				var/squad/S = squad_table[answer]
				if(S)
					S.add_member(P)
					update_sprite()
				else
					activator.to_chat(span("danger","For some reason that squad doesn't exist. Please tell burger you can't join the squad [answer]."))

		else
			var/answer = input("There aren't any squads available to join. Would you like to create a squad?","Squad Creation","Cancel") in list("Yes","No","Cancel")
			if(answer == "Yes")
				new_squad(P)


/obj/hud/button/squad/main/proc/new_squad(var/mob/living/advanced/player/P)
	while(P.client)
		var/squad_name = input("Please enter your squad name. Enter nothing to cancel.","Squad Creation",null) as text|null

		if(squad_name == "Cancel" || squad_name == "Create New Squad" || squad_name == "Cancel")
			P.to_chat(span("danger","You cheeky bastard. That's an invalid name!"))
			return FALSE

		if(!squad_name)
			return FALSE

		if(P.client)
			squad_name = police_text(P.client,squad_name,check_name=TRUE,check_characters=TRUE,min_length=2,max_length=40)

		if(!squad_name)
			return FALSE

		var/found_name = FALSE
		for(var/k in SSsquad.all_squads)
			var/squad/S = k
			if(S.name == squad_name)
				found_name = TRUE

		if(found_name)
			P.to_chat(span("warning","The squad name \"[found_name]\" is already taken!"))
			continue

		var/squad/S = new
		S.name = squad_name
		S.add_member(P)
		S.set_leader(P)
		update_sprite()
		return TRUE

/obj/hud/button/squad/member
	name = "squad member button"
	desc = "Represents a squad member."

	icon = 'icons/hud/progress.dmi'
	icon_state = "progress"

	maptext = "Name Here"
	maptext_width = TILE_SIZE*3
	maptext_y = 8

	screen_loc = "CENTER,CENTER"

	var/mob/living/advanced/player/tracked_mob

/obj/hud/button/squad/member/Destroy()
	tracked_mob = null
	return ..()

/obj/hud/button/squad/member/New(var/desired_loc,var/desired_tracked_mob)
	tracked_mob = desired_tracked_mob
	return ..()

/obj/hud/button/squad/member/update_owner(var/desired_owner)

	. = ..()

	if(.)
		update_sprite()


/obj/hud/button/squad/member/update_underlays()
	. = ..()
	var/icon/I = new(initial(icon),initial(icon_state))
	swap_colors(I)
	underlays += I

/obj/hud/button/squad/member/update_icon()
	. = ..()
	if(tracked_mob && tracked_mob.health)
		var/desired_num = FLOOR((tracked_mob.health.health_current/tracked_mob.health.health_max) * 26, 1)
		icon_state = "bar_[desired_num]"


/obj/hud/button/squad/member/update_sprite()
	maptext = tracked_mob.name
	return ..()