/obj/structure/interactive/disposals/machine/chute
	name = "disposals chute"
	desc = "Express delivery!"
	desc_extended = "Throw trash in here."
	icon_state = "disposal"

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	collision_dir = NORTH | EAST | SOUTH | WEST

	var/disposals_countdown = SECONDS_TO_DECISECONDS(5)

	bullet_block_chance = 50

	density = TRUE

/obj/structure/interactive/disposals/machine/chute/think()

	if(disposals_countdown <= 0)
		var/obj/disposals_container/disposals_container = new(src)
		INITIALIZE(disposals_container)
		GENERATE(disposals_container)
		FINALIZE(disposals_container)
		for(var/atom/movable/M in src.contents)
			M.force_move(disposals_container)
		STOP_THINKING(src)
		disposals_countdown = initial(disposals_countdown)
		flick("disposal-flush",src)
		play_sound('sound/effects/disposals/flush.ogg',get_turf(src))
		STOP_THINKING(src)

	disposals_countdown--

	return TRUE

/obj/structure/interactive/disposals/machine/chute/Entered(atom/movable/Obj,atom/OldLoc)
	START_THINKING(src)
	return ..()

/obj/structure/interactive/disposals/machine/chute/Crossed(atom/movable/O,atom/OldLoc)
	if(O.collision_flags & (FLAG_COLLISION_WALKING | FLAG_COLLISION_ITEM))
		O.Move(src)
	return ..()

/obj/structure/interactive/disposals/machine/chute/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	if(is_item(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		var/obj/item/I = object
		I.drop_item(src)
		return TRUE

	return ..()

/obj/structure/interactive/disposals/machine/chute/drop_on_object(var/mob/activator,var/atom/object,location,control,params)
	//Todo, interact delay.
	if(ismob(object) && activator == object)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		var/mob/living/L = object
		L.Move(src)
		return TRUE

	return ..()