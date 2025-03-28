/obj/item/container/blood_pack
	name = "blood pack"
	desc = "Keep away from Vampires."
	desc_extended = "A special plastic blood pack that comes with it's own butterfly needle. Can be attached to living beings to draw or inject blood at a steady rate. When injecting, it auto-detaches if the patient's blood level is 10% greater than normal. Alt-Click to toggle mode."
	icon = 'icons/obj/item/container/bloodpack.dmi'
	icon_state = "regular"
	var/icon_count = 15

	var/injecting = FALSE

	var/mob/living/attached_to

	reagents = /reagent_container/beaker/large

	var/draw_delay = 10

	value = 20

	rarity = RARITY_UNCOMMON

/obj/item/container/blood_pack/feed(var/mob/activator,var/mob/living/target)
	return FALSE

/obj/item/container/blood_pack/drop_item(var/atom/desired_loc,var/pixel_x_offset = 0,var/pixel_y_offset = 0,var/silent=FALSE)
	. = ..()
	update_sprite()

/obj/item/container/blood_pack/on_equip(var/atom/old_location,var/silent=FALSE) //When the item is picked up.
	. = ..()
	update_sprite()

/obj/item/container/blood_pack/Finalize()
	. = ..()
	update_sprite()

/obj/item/container/blood_pack/proc/is_safe_to_attach(var/mob/living/activator,var/mob/living/target,var/messages=TRUE,var/desired_inject)

	if(!isnum(desired_inject))
		desired_inject = injecting

	if(activator == target)
		return TRUE

	if(!allow_hostile_action(activator.loyalty_tag,target))
		if(desired_inject)
			if(reagents.contains_lethal)
				if(messages) activator.to_chat(span("warning","Your loyalty tag prevents you from injecting lethal reagents!"))
				return FALSE
		else
			if(messages) activator.to_chat(span("warning","Your loyalty tag prevents you from draining the blood of allies!"))
			return FALSE

	return TRUE

/obj/item/container/blood_pack/click_on_object(var/mob/activator as mob,var/atom/object,location,control,params)

	if(is_living(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		var/mob/living/L = object
		if(attached_to == L)
			detach(activator)
			return TRUE
		if(attached_to) //This statement and the above is weird and I hate it.
			detach(activator)
		if(!is_living(activator) || is_safe_to_attach(activator,object))
			try_attach(activator,object)
		return TRUE

	return ..()

/obj/item/container/blood_pack/proc/detach(var/mob/activator)
	var/turf/T = get_turf(src)
	if(activator)
		T.visible_message(span("notice","\The [activator.name] detaches \the [src.name] from [attached_to.name]."))
	else
		T.visible_message(span("notice","\The [src.name] detaches itself from \the [attached_to.name]."))
	attached_to = null
	STOP_THINKING(src)
	update_sprite()
	return TRUE

/obj/item/container/blood_pack/proc/attach(var/mob/activator,var/mob/living/target)
	draw_delay = initial(draw_delay)
	var/turf/T = get_turf(src)
	attached_to = target
	T.visible_message(span("notice","\The [activator.name] attaches \the [src.name] to \the [attached_to.name]."),span("notice","You attach \the [src.name] to \the [attached_to.name]."))
	START_THINKING(src)
	update_sprite()
	return TRUE

/obj/item/container/blood_pack/click_self(var/mob/activator,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	if(!is_living(activator))
		return ..()

	var/mob/living/L = activator

	if(L.is_busy())
		return FALSE

	if(activator.attack_flags & CONTROL_MOD_DISARM)
		if(attached_to)
			detach(activator)
		else
			activator.to_chat(span("warning","There is nothing to detach \the [src.name] from!"))
	else
		if(!attached_to || is_safe_to_attach(activator,attached_to,desired_inject = !injecting))
			injecting = !injecting
			activator.to_chat(span("notice","You toggle \the [src.name] to [injecting ? "inject" : "draw"] its contents."))
			update_sprite()

	return TRUE

/obj/item/container/blood_pack/proc/try_attach(var/mob/activator,var/mob/living/target)

	if(!can_attach_to(activator,target))
		return FALSE

	activator.visible_message(span("warning","\The [activator.name] begins to attach \the [src.name] to \the [target.name]..."),span("notice","You begin to attach \the [src.name] to \the [target.name]..."))

	PROGRESS_BAR(activator,src,SECONDS_TO_DECISECONDS(3),src::attach(),activator,target)
	PROGRESS_BAR_CONDITIONS(activator,src,src::can_attach_to(),activator,target)

	return TRUE

/obj/item/container/blood_pack/proc/can_attach_to(var/mob/activator,var/mob/living/target)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(target)

	if(!target.reagents)
		activator.to_chat(span("warning","You can't find a way to attach \the [src.name] to \the [target.name]!"))
		return FALSE

	return TRUE

/obj/item/container/blood_pack/think()

	. = ..()

	if(!attached_to || attached_to.qdeleting || get_dist(src,attached_to) > 1)
		detach()
		return FALSE

	if(attached_to.dead)
		detach()
		return FALSE

	if(!is_living(last_interacted) || !is_safe_to_attach(last_interacted,attached_to))
		detach()
		return FALSE

	if(draw_delay <= 0)
		if(reagents)
			if(injecting)
				if(attached_to.blood_volume/attached_to.blood_volume_max >= 1.1)
					detach()
					return FALSE
				if(!reagents.volume_current || !src.reagents.transfer_reagents_to(attached_to.reagents,1))
					detach()
					return FALSE
				draw_delay = initial(draw_delay)*0.25
			else
				if(!attached_to.draw_blood(null,src,1))
					detach()
					return FALSE
				draw_delay = initial(draw_delay)
	else
		draw_delay--


/obj/item/container/blood_pack/update_icon()
	icon = initial(icon)
	icon_state = "liquid_[CEILING(clamp(reagents.volume_current/reagents.volume_max,0,1)*icon_count,1)]"
	color = reagents.color
	return ..()

/obj/item/container/blood_pack/update_overlays()

	var/image/I = new/image(icon,initial(icon_state))
	I.appearance_flags = src.appearance_flags | RESET_COLOR
	add_overlay(I)

	if(src.loc && is_inventory(src.loc))
		var/image/I2 = image(icon,"action_[injecting]")
		I2.appearance_flags = src.appearance_flags | RESET_COLOR
		add_overlay(I2)

	return ..()

/obj/item/container/blood_pack/full


/obj/item/container/blood_pack/full/o_negative/
	name = "blood pack (O-)"

/obj/item/container/blood_pack/full/o_negative/Generate()
	reagents.add_reagent(/reagent/blood/human/o_negative,reagents.volume_max)
	return ..()

/obj/item/container/blood_pack/full/reptile/
	name = "blood pack (L)"

/obj/item/container/blood_pack/full/reptile/Generate()
	reagents.add_reagent(/reagent/blood/reptile,reagents.volume_max)
	return ..()

/obj/item/container/blood_pack/full/rad_be_gone
	name = "rad-b-gone pack"

/obj/item/container/blood_pack/full/rad_be_gone/Generate()
	reagents.add_reagent(/reagent/medicine/rad_b_gone,reagents.volume_max)
	return ..()

/obj/item/container/blood_pack/full/synthblood/
	name = "blood pack (synthblood)"

/obj/item/container/blood_pack/full/synthblood/Generate()
	reagents.add_reagent(/reagent/medicine/synthblood,reagents.volume_max)
	return ..()