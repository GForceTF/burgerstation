/obj/item/implanter
	name = "autoimplanter"
	desc = "Breast implants when?"
	desc_extended = "A handheld chip implanter that allows you to self-insert implant chips, and sometimes even organs, into your skin and bones. Just scan the target area and press the button. Cannot be used to implant those other than the user."
	var/removes_existing = FALSE

	var/obj/item/organ/internal/stored_implant

	icon = 'icons/obj/item/implanter.dmi'
	icon_state = "implanter"

	value = 0

	weight = 3

	rarity = RARITY_UNCOMMON

/obj/item/implanter/PreDestroy()
	QDEL_NULL(stored_implant)
	. = ..()

/obj/item/implanter/update_icon()

	icon_state = initial(icon_state)

	if(stored_implant)
		icon_state = "[icon_state]_1"

	return ..()

/obj/item/implanter/New(var/desired_loc)
	. = ..()
	if(stored_implant)
		name = "[initial(name)] ([initial(stored_implant.name)])"
	update_sprite()


/obj/item/implanter/get_examine_details_list(var/mob/examiner)
	. = ..()
	. += div("notice","Details: [initial(stored_implant.desc_extended)]")

/obj/item/implanter/click_on_object(var/mob/activator as mob,var/atom/object,location,control,params)

	if(activator != object || !is_advanced(activator))
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	if(!stored_implant)
		activator.to_chat(span("warning","There is no implanter loaded in \the [src.name]!"))
		return TRUE

	var/mob/living/advanced/A = activator

	var/initial_id = initial(stored_implant.id)

	if(A.labeled_organs[initial_id])
		if(removes_existing)
			var/obj/item/organ/O = A.labeled_organs[initial_id]
			A.remove_organ(O,get_turf(A))
		else
			activator.to_chat(span("warning","You already have an implant of that type!"))
			return TRUE

	var/obj/item/organ/internal/implant/added_implant = A.add_organ(stored_implant)
	if(added_implant)
		activator.visible_message(span("notice","\The [activator.name] implants something into their [added_implant.attached_organ.name]."),span("notice","You implant \the [added_implant.name] into your [added_implant.attached_organ.name]."))
		name = initial(name)
		stored_implant = null

	update_sprite()

	return TRUE

/obj/item/implanter/head/
	name = "head implanter"

/obj/item/implanter/head/iff
	stored_implant = /obj/item/organ/internal/implant/hand/left/iff/nanotrasen
	removes_existing = FALSE
	value_burgerbux = 1

	rarity = RARITY_LEGENDARY
	can_save = FALSE

/obj/item/implanter/torso
	name = "torso implanter"

/obj/item/implanter/torso/od_purge
	stored_implant = /obj/item/organ/internal/implant/torso/od_purge
	removes_existing = TRUE
	value = 1000

/obj/item/implanter/torso/death_alarm
	stored_implant = /obj/item/organ/internal/implant/torso/death_alarm
	removes_existing = TRUE
	value = 500