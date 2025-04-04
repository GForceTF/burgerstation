

/obj/item/device/signaller
	name = "signaller"
	desc = "Suspiciously detonator shaped."
	desc_extended = "A device used to send a signal to the selected frequency."
	icon_state = "signaller"

	var/frequency_current = RADIO_FREQ_MIN
	var/frequency_min = RADIO_FREQ_MIN
	var/frequency_max = RADIO_FREQ_MAX

	var/signal_current = 20
	var/signal_min = 1
	var/signal_max = 50

	var/spam_fix_time = 0

	var/mode = FALSE

	value = 20

/obj/item/device/signaller/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("frequency_current")
	SAVEVAR("signal_current")

/obj/item/device/signaller/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("frequency_current")
	LOADVAR("signal_current")

/obj/item/device/signaller/door
	frequency_current = RADIO_FREQ_DOOR
	signal_current = 1

/obj/item/device/signaller/New(var/desired_loc)
	SSradio.all_signalers += src
	return ..()

/obj/item/device/signaller/PreDestroy()
	SSradio.all_signalers -= src
	return ..()

/obj/item/device/signaller/attack(var/atom/attacker,var/atom/victim,var/list/params=list(),var/atom/blamed,var/ignore_distance = FALSE, var/precise = FALSE,var/damage_multiplier=1,var/damagetype/damage_type_override)  //The src attacks the victim, with the blamed taking responsibility
	trigger(attacker,src,-1,-1)
	return TRUE

/obj/item/device/signaller/trigger(var/mob/activator,var/atom/source,var/signal_freq,var/signal_code)

	if(signal_freq == -1 && signal_code == -1)
		for(var/k in SSradio.all_signalers)
			var/obj/item/device/signaller/S = k
			if(S == src)
				continue
			S.trigger(activator,src,frequency_current,signal_current)
		return TRUE

	if(loc && signal_freq == frequency_current && signal_code == signal_current)
		loc.trigger(activator,src,-1,-1)
		return TRUE

	return TRUE

/obj/item/device/signaller/click_self(var/mob/activator,location,control,params)
	INTERACT_CHECK
	INTERACT_DELAY(1)
	mode = !mode
	activator.to_chat(span("notice","You change the mode to [mode ? "frequency" : "signal"]."))
	spam_fix_time = 0
	return TRUE

/obj/item/device/signaller/mouse_wheel_on_object(var/mob/activator,delta_x,delta_y,location,control,params)

	var/fixed_delta = clamp(delta_y,-1,1)

	if(mode)
		var/old_frequency = frequency_current
		frequency_current = clamp(frequency_current + 0.2*fixed_delta,frequency_min,frequency_max)
		if(old_frequency == frequency_current)
			activator.to_chat(span("notice","\The [src.name]'s frequency can't seem to go any [frequency_current == frequency_min ? "lower" : "higher"]."))
		else if(spam_fix_time <= world.time)
			activator.to_chat(span("notice","You change \the [src.name]'s frequency to [frequency_current] kHz..."))
		else
			activator.to_chat(span("notice","...[frequency_current] kHz..."))
	else
		var/old_signal = signal_current
		signal_current = clamp(signal_current + 1*fixed_delta,signal_min,signal_max)
		if(old_signal == signal_current)
			activator.to_chat(span("notice","\The [src.name]'s signal can't seem to go any [signal_current == signal_min ? "lower" : "higher"]."))
		else if(spam_fix_time <= world.time)
			activator.to_chat(span("notice","You change \the [src.name]'s signal to [signal_current]..."))
		else
			activator.to_chat(span("notice","...[signal_current]..."))

	spam_fix_time = world.time + 20

	return TRUE