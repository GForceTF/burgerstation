/obj/item/crafting_bench/filter
	name = "portable filtering device"
	icon = 'icons/obj/item/ore.dmi'
	icon_state = "filter"
	desc= "Another thing that needs instructions."
	desc_extended = "It filters chems out of some things into another! Alt-click to set the filter size!"

	inventories = list(
		/obj/hud/inventory/crafting/slotB1,
		/obj/hud/inventory/crafting/slotB2,
		/obj/hud/inventory/crafting/slotB3,

		/obj/hud/inventory/crafting/result
	)

	crafting_id = "filter"

	crafting_type = "filter"

	value = 25

	size = SIZE_4

	var/filter_setting = 0

	var/precision = 0.1

	value_burgerbux = 1

/obj/item/crafting_bench/filter/click_self(var/mob/activator,location,control,params)

	if(activator.attack_flags & CONTROL_MOD_DISARM)
		var/current_setting
		var/possible_inputs = list()
		for(var/i=0,i<=1,i=FLOOR(i+precision,0.1))
			var/input_name = "[i]"
			switch(i)
				if(0)
					input_name = "[input_name](fine)"
				if(1)
					input_name = "[input_name](dense)"
			if(filter_setting == i)
				current_setting = input_name
			possible_inputs[input_name] = i
		possible_inputs["Cancel"] = "Cancel"
		var/desired_input = input("What filter setting would you like to choose?","Filter Setting",current_setting) as null|anything in possible_inputs
		if(!desired_input || desired_input == "Cancel")
			return TRUE
		filter_setting = possible_inputs[desired_input]
		activator.to_chat(span("notice","You set the filter to [desired_input]."))
		return TRUE

	. = ..()

/obj/item/crafting_bench/filter/attempt_to_craft(var/mob/living/advanced/activator)

	var/obj/item/container/C //Final slot container.

	for(var/obj/hud/inventory/crafting/result/R in src.inventories)
		var/obj/item/top_object = R.get_top_object()
		if(top_object.reagents && top_object.allow_reagent_transfer_to)
			C = top_object
			break

	if(!C)
		activator.to_chat(span("warning","You're missing a valid container in the product slot!"))
		return FALSE

	var/list/item_table = generate_crafting_table(activator,src)

	var/success = FALSE

	for(var/i=1,i<=3,i++)

		var/obj/item/I = item_table["b[i]"]

		if(!I || !I.reagents || !length(I.reagents.stored_reagents))
			continue

		var/transfered = FALSE

		for(var/k in I.reagents.stored_reagents)
			var/reagent/R = REAGENT(k)
			var/volume = I.reagents.stored_reagents[k]
			if(R.particle_size < filter_setting)
				var/temperature = I.reagents.stored_reagents_temperature[k]
				var/amount_removed = -I.reagents.add_reagent(k,-volume,should_update=FALSE,check_recipes=FALSE,activator=activator)
				C.reagents.add_reagent(k,amount_removed,temperature,should_update=FALSE,check_recipes=FALSE,activator=activator)
				transfered = TRUE
				success = TRUE

		if(transfered)
			I.reagents.update_container(activator)
			I.reagents.process_recipes(activator)

	if(success)
		C.reagents.update_container(activator)
		C.reagents.process_recipes(activator)
	else
		activator.to_chat(span("warning","\The [src.name] could not filter anything!"))

	return TRUE




