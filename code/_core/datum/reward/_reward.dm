#define FLAG_REWARD_NONE 0x0
#define FLAG_REWARD_ONCE 0x1

/reward/
	var/name = "Reward Name"
	var/desc = "Reward Description"

	var/flags_reward = FLAG_REWARD_NONE

/reward/proc/can_reward(var/client/C)

	if(flags_reward & FLAG_REWARD_ONCE)
		if(C.globals.loaded_data["redeemed_rewards"] && (src.type in C.globals.loaded_data["redeemed_rewards"]))
			C.to_chat(span("warning","You already redeemed this reward!"))
			return FALSE

	return TRUE

/reward/proc/on_reward(var/client/C)

	if(flags_reward & FLAG_REWARD_ONCE)
		if(!C.globals.loaded_data["redeemed_rewards"])
			C.globals.loaded_data["redeemed_rewards"] = list()
		C.globals.loaded_data["redeemed_rewards"] |= src.type
		C.globals.save()

	return TRUE

/reward/proc/on_fail(var/client/C)
	return TRUE

/reward/credits/
	name = "Credit Reward"
	desc = "Dosh!"

	var/credits_to_give = 0

/reward/credits/can_reward(var/client/C)
	if(!is_player(C.mob))
		return FALSE
	return ..()

/reward/credits/on_reward(var/client/C)
	var/mob/living/advanced/player/P = C.mob
	P.adjust_currency(credits_to_give)
	return ..()


/reward/credits/survey_aug_2020
	name = "August 2020 Survey Reward"
	desc = "A 5000 credit reward for completing the August 2020 Player Survey"
	flags_reward = FLAG_REWARD_ONCE
	credits_to_give = 5000