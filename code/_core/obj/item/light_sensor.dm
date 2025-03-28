/obj/item/light_sensor
	name = "ambient light sensor"
	desc = "Let there be light."
	desc_extended = "A special passive light sensor that detects ambient light levels."

	icon = 'icons/obj/item/analyzers/light.dmi'
	icon_state = "inventory"

	value = 200

	var/active = FALSE

	weight = 1

/obj/item/light_sensor/Finalize()
	. = ..()
	update_sprite()

/obj/item/light_sensor/update_underlays()
	. = ..()
	var/image/I = new/image(initial(icon),initial(icon_state))
	add_underlay(I)

/obj/item/light_sensor/click_self(var/mob/activator,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(10)
	SPAM_CHECK(3)

	active = !active

	activator.to_chat(span("notice","You turn \the [src.name] [active ? "on" : "off"]."))

	play_sound('sound/machines/click.ogg',get_turf(src),range_max=VIEW_RANGE*0.25)

	if(active)
		START_THINKING(src)
	else
		STOP_THINKING(src)

	update_icon()

	return TRUE

/obj/item/light_sensor/think()
	update_icon() //Not update_sprite
	return TRUE

/obj/item/light_sensor/update_icon()

	icon_state = initial(icon_state)

	if(active)
		var/turf/T = get_turf(src)
		if(T) icon_state = "[icon_state]_[CEILING(clamp(T.lightness/1,0,1)*9,1)]"

	return ..()



