/obj/hud/button/chargen/species/
	name = "change species"
	desc_extended = "Click here to change your character's species. Note that changing your character's species will cause you to lose your previous changes."
	icon_state = "change_species"
	screen_loc = "CENTER+2,CENTER+0"

	user_colors = TRUE

	chargen_flags = CHARGEN_NONE

/obj/hud/button/chargen/species/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	. = ..()

	if(. && is_advanced(activator))
		var/mob/living/advanced/A = activator

		var/species_choice = input("What species do you wish to change to?") as null|anything in list("Human","Lizard","Cyborg","Dionae","Moth")
		if(!species_choice)
			return TRUE

		var/list/choice_to_species = list(
			"Human" = "human",
			"Lizard" = "reptile_advanced",
			"Cyborg" = "cyborg",
			"Dionae" = "diona",
			"Moth" = "moth"
		)

		var/choice = input("Are you sure you want to change your species to [species_choice]? Your appearance will reset to that species' default.","Species Change") in list("Yes","No")

		if(choice == "Yes")
			A.perform_specieschange(choice_to_species[species_choice],TRUE,TRUE)
