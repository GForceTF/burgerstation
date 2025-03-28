SUBSYSTEM_DEF(recipe)
	name = "Recipe Subsystem"
	desc = "Store all the recipes."
	priority = SS_ORDER_FIRST
	var/list/recipe/all_recipes = list()
	var/list/cooking_recipe/all_cooking_recipes_plate = list()

/subsystem/recipe/Initialize()

	for(var/v in subtypesof(/recipe/))
		var/recipe/R = new v
		all_recipes += R

	for(var/v in subtypesof(/cooking_recipe/plate))
		var/cooking_recipe/plate/R = new v
		all_cooking_recipes_plate += R

	log_subsystem(name,"Initialized [length(all_recipes)] recipes.")

	return ..()

/proc/generate_crafting_table(var/mob/living/advanced/activator,var/obj/item/crafting_bench/C)

	var/list/item_table = list()

	for(var/k in C.inventories)
		var/obj/hud/inventory/crafting/I = k
		var/obj/item/held_item = I.get_top_object()
		if(held_item)
			item_table[I.id] = held_item
		else
			item_table[I.id] = null

	return item_table


/proc/get_plate_recipe(var/list/list_contents)

	if(!length(list_contents))
		return null

	for(var/k in SSrecipe.all_cooking_recipes_plate)
		var/cooking_recipe/plate/R = k
		if(R.check(list_contents,null))
			return R

	return null