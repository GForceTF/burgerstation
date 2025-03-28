var/global/next_announcement = 0

/obj/item/announcement/
	name = "broadcast announcement device"
	desc = "One day while..."
	desc_extended = "A one time use announcement system."
	icon = 'icons/obj/item/pda.dmi'
	icon_state = "captain"

	value = 3000
	value_burgerbux = 5

	var/sound_to_play = 'sound/alert/announcement.ogg'

	var/sender
	var/title
	var/print_owner = TRUE

	weight = 3

	var/stored_message

	rarity = RARITY_RARE

/obj/item/announcement/proc/can_use(var/mob/activator)
	return TRUE

/obj/item/announcement/click_self(var/mob/activator,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	if(!activator.client)
		return FALSE

	if(!can_use(activator))
		return FALSE

	if(next_announcement > world.time)
		activator.to_chat(span("warning","Please wait [DECISECONDS_TO_SECONDS(CEILING(next_announcement - world.time,10))] seconds before sending an announcement!"))
		return FALSE

	var/message = input("What should the message be?", "Message", stored_message) as message | null

	if(src.qdeleting)
		return FALSE

	INTERACT_CHECK_OTHER(src) //Hacky

	stored_message = message

	if(!message)
		activator.to_chat(span("notice","You decide not to use the device."))
		return FALSE

	message = police_text(activator.client,message,check_characters=TRUE)

	if(!message)
		activator.to_chat(span("notice","You decide not to use the device."))
		return FALSE

	if(get_turf(activator) != get_turf(src))
		activator.to_chat(span("warning","You're too far away!"))
		return FALSE

	if(!sender)
		sender = "Central Command Portable Announcement System."

	if(!title)
		title = "Message from [activator.name]"

	if(print_owner)
		message = "[message]<br> -[activator.name]"

	if(next_announcement > world.time)
		activator.to_chat(span("warning","Please wait [DECISECONDS_TO_SECONDS(CEILING(next_announcement - world.time,10))] seconds before sending an announcement!"))
		return FALSE

	announce(sender,title,message,sound_to_play=sound_to_play)

	next_announcement = world.time + SECONDS_TO_DECISECONDS(60)

	stored_message = null

	qdel(src)

	return TRUE

/obj/item/announcement/syndicate
	desc_extended = "A one time use announcement system that sends a taunt to the crew. This one is for syndicate. Automatically signs your name in the message."
	icon_state = "syndicate"
	title = "Declaration of War"
	sender = "The Syndicate"
	value = 500
	sound_to_play = 'sound/alert/warning.ogg'

/obj/item/announcement/syndicate/can_use(var/mob/activator)

	if(!is_living(activator))
		activator.to_chat(span("warning","You don't seem to know how to use this..."))
		return FALSE

	var/mob/living/L = activator
	if(L.loyalty_tag != "Syndicate")
		L.to_chat(span("warning","You don't seem to know how to use this..."))
		return FALSE

	return TRUE


/obj/item/announcement/wizard
	desc_extended = "A one time use announcement system that sends a taunt to the crew. This one is for wizard. Automatically signs your name in the message."
	icon_state = "syndicate"
	title = "Declaration of Wizarding"
	sender = "The Wizard Federation"
	value = 500
	sound_to_play = 'sound/alert/warning.ogg'

/obj/item/announcement/wizard/can_use(var/mob/activator)

	if(!is_living(activator))
		activator.to_chat(span("warning","You don't seem to know how to use this..."))
		return FALSE

	var/mob/living/L = activator
	if(L.loyalty_tag != "Wizard Federation")
		L.to_chat(span("warning","You don't seem to know how to use this..."))
		return FALSE

	return TRUE

/obj/item/announcement/rev
	desc_extended = "A one time use announcement system that sends a taunt to the crew. This one is for revolutionaries. Automatically signs your name in the message."
	icon_state = "rev"
	title = "Declaration of Mutiny"
	sender = "The Revolutionaries"
	value = 500
	var/sounds_to_play = list('sound/alert/rev_pda_1.ogg','sound/alert/rev_pda_2.ogg','sound/alert/rev_pda_3.ogg','sound/alert/rev_pda_4.ogg')

/obj/item/announcement/rev/can_use(var/mob/activator)

	if(!is_living(activator))
		activator.to_chat(span("warning","You don't seem to know how to use this..."))
		return FALSE

	var/mob/living/L = activator
	if(L.loyalty_tag != "Revolutionary")
		L.to_chat(span("warning","You don't seem to know how to use this..."))
		return FALSE

	return TRUE

//This is fucking horrible but it works so I don't care
/obj/item/announcement/rev/click_self(var/mob/activator,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	if(!activator.client)
		return FALSE

	if(!can_use(activator))
		return FALSE

	if(next_announcement > world.time)
		activator.to_chat(span("warning","Please wait [DECISECONDS_TO_SECONDS(CEILING(next_announcement - world.time,10))] seconds before sending an announcement!"))
		return FALSE

	var/message = input("What should the message be?", "Message", stored_message) as message | null

	if(src.qdeleting)
		return FALSE

	INTERACT_CHECK_OTHER(src) //Hacky

	stored_message = message

	if(!message)
		activator.to_chat(span("notice","You decide not to use the device."))
		return FALSE

	message = police_text(activator.client,message,check_characters=TRUE)

	if(!message)
		activator.to_chat(span("notice","You decide not to use the device."))
		return FALSE

	if(get_turf(activator) != get_turf(src))
		activator.to_chat(span("warning","You're too far away!"))
		return FALSE

	if(!sender)
		sender = "Central Command Portable Announcement System."

	if(!title)
		title = "Message from [activator.name]"

	if(print_owner)
		message = "[message]<br> -[activator.name]"

	if(next_announcement > world.time)
		activator.to_chat(span("warning","Please wait [DECISECONDS_TO_SECONDS(CEILING(next_announcement - world.time,10))] seconds before sending an announcement!"))
		return FALSE

	announce(sender,title,message,sound_to_play=pick(sounds_to_play))

	next_announcement = world.time + SECONDS_TO_DECISECONDS(60)

	stored_message = null

	qdel(src)

	return TRUE

