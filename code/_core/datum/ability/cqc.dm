/ability/cqc
	name = "CQC: Big Boss"
	desc = "A cqc ability."
	category = "CQC"
	icon_state = "big_boss"

	var/cqc_category_to_learn = "Big Boss"

	toggle = TRUE

	resource_type = STAMINA
	cost = 10
	cooldown = SECONDS_TO_DECISECONDS(4)

/ability/cqc/on_cast(var/mob/activator,var/atom/target,location,params)

	if(is_advanced(activator))
		var/mob/living/advanced/L = activator
		if(L.cqc_category == cqc_category_to_learn)
			L.cqc_category = null
		else
			L.cqc_category = cqc_category_to_learn

	return TRUE

/ability/cqc/is_active(var/mob/activator)

	if(is_advanced(activator))
		var/mob/living/advanced/L = activator
		return L.cqc_category == cqc_category_to_learn

	return FALSE

/ability/cqc/sleeping_carp
	name = "CQC: Sleeping Carp"
	cqc_category_to_learn = "Sleeping Carp"
	icon_state = "sleeping_carp"


