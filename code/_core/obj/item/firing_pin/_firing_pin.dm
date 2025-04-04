/obj/item/firing_pin/
	name = "firing pin"
	desc = "Yes, these exist here too."
	desc_extended = "Acts as a trigger mechanism for the gun. Controls who can fire the gun, what can trigger the gun, when can the gun be fired, where the gun can be fired, why the gun can be fired, and how the gun should be fired. This also controls the IFF settings for the gun."
	var/iff_tag = null
	icon = 'icons/obj/item/firing_pins.dmi'
	icon_state = "normal"

	weight = 0.25

	rarity = RARITY_UNCOMMON

	value = 0

/obj/item/firing_pin/proc/can_shoot(var/mob/activator,var/obj/item/weapon,var/messages=TRUE)
	return TRUE

/obj/item/firing_pin/proc/on_shoot(var/mob/activator,var/obj/item/weapon)
	return TRUE

/obj/item/firing_pin/electronic
	name = "electronic firing pin"

/obj/item/firing_pin/electronic/iff/can_shoot(var/mob/activator,var/obj/item/weapon,var/messages=TRUE)

	if(src.iff_tag)
		if(!is_living(activator))
			if(messages) activator.to_chat(span("danger","The firing pin doesn't detect your IFF signature and refuses to fire!"))
			return FALSE

		var/mob/living/L = activator

		if(L.iff_tag != src.iff_tag)
			if(messages) activator.to_chat(span("danger","The firing pin doesn't recognize your IFF signature and refuses to fire!"))
			return FALSE

	. = ..()

/obj/item/firing_pin/electronic/iff/nanotrasen
	name = "electronic nanotrasen firing pin"
	desc_extended = "Acts as a trigger mechanism for the gun. The gun can only be fired by those with a registered NanoTrasen IFF implant, and prevents firing at those with one."
	iff_tag = "NanoTrasen"
	icon_state = "nanotrasen"

/obj/item/firing_pin/electronic/iff/nanotrasen/can_shoot(var/mob/activator,var/obj/item/weapon)

	var/area/A = get_area(activator)
	if(A.flags_area & FLAG_AREA_TUTORIAL)
		activator.to_chat(span("danger","\The [src.name] refuses to fire in this area!"))
		return FALSE

	return TRUE

/obj/item/firing_pin/electronic/iff/nanotrasen/nyantrasen
	name = "electronic nyantrasen firing pin"
	desc_extended = "Acts as a trigger mechanism for the gun. The gun can only be fired by those with a registered NanoTrasen IFF implant, and prevents firing at those with one. This one seems to have some sort of speaker..."
	iff_tag = "NanoTrasen"
	icon_state = "nanotrasen"
	value = 1000

/obj/item/firing_pin/electronic/iff/nanotrasen/nyantrasen/on_shoot(var/mob/activator,var/obj/item/weapon)
	if(activator && weapon)
		var/turf/T = get_turf(weapon)
		if(T) play_sound('sound/voice/catgirl/meow.ogg',T)
	return ..()

/obj/item/firing_pin/electronic/iff/nanotrasen/honkmother
	name = "electronic honkmother firing pin"
	desc_extended = "Acts as a trigger mechanism for the gun. The gun can only be fired by those with a registered NanoTrasen IFF implant, and prevents firing at those with one. This one seems to have some sort of speaker..."
	iff_tag = "NanoTrasen"
	icon_state = "nanotrasen"
	value = 666

/obj/item/firing_pin/electronic/iff/nanotrasen/honkmother/on_shoot(var/mob/activator,var/obj/item/weapon)
	if(activator && weapon)
		var/turf/T = get_turf(weapon)
		if(T) play_sound('sound/items/bikehorn.ogg',T)
	return ..()

/obj/item/firing_pin/electronic/iff/syndicate
	name = "syndicate firing pin"
	desc_extended = "Acts as a trigger mechanism for the gun. The gun can only be fired by those with a registered Syndicate IFF implant, and prevents firing at those with one."
	iff_tag = "Syndicate"
	icon_state = "syndicate"


/obj/item/firing_pin/electronic/iff/bone
	name = "bone firing pin"
	desc_extended = "Acts as a trigger mechanism for the gun. The gun can only be fired by those with a registered Bone IFF implant, and prevents firing at those with one."
	iff_tag = "Skeleton"
	icon_state = "bone"


/obj/item/firing_pin/electronic/iff/revolutionary
	name = "revolutionary firing pin"
	desc_extended = "Acts as a trigger mechanism for the gun. The gun can only be fired by those with a registered Revolutionary IFF implant, and prevents firing at those with one."
	iff_tag = "Revolutionary"
	icon_state = "revolution"


/obj/item/firing_pin/electronic/iff/deathsquad
	name = "deathsquad firing pin"
	desc_extended = "Acts as a trigger mechanism for the gun. The gun can only be fired by those with a registered Deathsquad IFF implant, and prevents firing at those with one."
	iff_tag = "Deathsquad"
	icon_state = "deathsquad"

/obj/item/firing_pin/electronic/iff/space_cop
	name = "space police firing pin"
	desc_extended = "Acts as a trigger mechanism for the gun. The gun can only be fired by those with a registered Space Cop IFF implant, and prevents firing at those with one."
	iff_tag = "Space Cop"
	icon_state = "deathsquad"

/obj/item/firing_pin/electronic/iff/mercenary
	name = "mercenary firing pin"
	desc_extended = "Acts as a trigger mechanism for the gun. The gun can only be fired by those with a registered Mercenary IFF implant, and prevents firing at those with one."
	iff_tag = "Mercenary"
	icon_state = "deathsquad"