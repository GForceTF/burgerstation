/obj/item/material/glass
	name = "glass"
	desc = "I am error."
	icon = 'icons/obj/items/material.dmi'
	icon_state = "glass"

	item_count_current = 1
	item_count_max = 50
	item_count_max_icon = 3

	weight = 0.2

	crafting_id = "glass"

/obj/item/material/glass/normal
	name = "glass sheets"
	desc = "The basic building material."
	material_id = "glass"

/obj/item/material/glass/normal/spawn_50/on_spawn()
	item_count_current = 50
	update_icon()
	return ..()


