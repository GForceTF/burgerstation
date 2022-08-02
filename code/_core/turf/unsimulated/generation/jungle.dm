/turf/unsimulated/generation/jungle
	name = "jungle generation"
	icon_state = "jungle"

/turf/unsimulated/generation/jungle/path
	icon_state = "jungle_path"
	density = FALSE

/turf/unsimulated/generation/jungle/generate(var/size = WORLD_SIZE)

	if(!density)
		new /turf/simulated/floor/colored/dirt/jungle(src)
		if(src.loc.type == /area/) new /area/mission/jungle(src)
		disallow_generation = TRUE
		return ..()

	if(is_different)
		new /turf/simulated/floor/colored/dirt/jungle(src)
		if(src.loc.type == /area/) new /area/mission/jungle(src)
		disallow_generation = TRUE
		return ..()

	var/x_seed = x / size
	var/y_seed = y / size

	var/max_instances = 1
	var/noise = 0
	for(var/i=1,i<=max_instances,i++)
		noise += text2num(rustg_noise_get_at_coordinates("[SSturf.seeds[z+i]]","[x_seed]","[y_seed]"))
	noise *= 1/max_instances
	noise = 0.5 + sin((noise+0.5)*3*180)*0.5
	noise += (x/world.maxx + y/world.maxy)/2 - 0.5



	switch(noise)
		if(-INFINITY to 0.05)
			new /turf/simulated/floor/grass/jungle(src)
			if(prob(5))
				new /obj/marker/generation/foliage/tree/jungle(src)
				if(prob(0.5))
					new /obj/marker/generation/jungle_dirt(src)
			else if(prob(1))
				new /obj/marker/generation/foliage/grass/jungle(src)
			else if(prob(4))
				new /obj/marker/generation/foliage/grass/jungle/rock(src)
				if(prob(4))
					new /obj/marker/generation/jungle_dirt(src)
			else if(prob(2))
				new /obj/marker/generation/foliage/bushes/fern(src)
		if(0.05 to 0.12)
			if(prob(1))
				new /obj/marker/generation/jungle_wall(src)
			else if(prob(1))
				new /obj/marker/generation/jungle_dirt(src)
			new /turf/simulated/floor/cave_dirt(src)
		if(0.12 to 0.13)
			if(prob(0.25))
				new /obj/marker/generation/jungle_wall(src)
			else if(prob(0.5))
				new /obj/marker/generation/jungle_dirt(src)
			new /turf/simulated/floor/colored/dirt/jungle(src)
		if(0.13 to 0.15)
			if(prob(10))
				new /obj/marker/generation/foliage/grass/jungle/rock(src)
			if(density &&prob(1))
				new /obj/marker/generation/mob/venus_human_trap(src)
			new /turf/simulated/floor/colored/grass/jungle(src)
		if(0.15 to 0.4)
			new /turf/simulated/floor/grass/jungle(src)
			if(prob(5))
				new /obj/marker/generation/foliage/tree/jungle(src)
				if(prob(0.5))
					new /obj/marker/generation/jungle_dirt(src)
			else if(prob(1))
				new /obj/marker/generation/foliage/grass/jungle(src)
			else if(prob(4))
				new /obj/marker/generation/foliage/grass/jungle/rock(src)
				if(prob(4))
					new /obj/marker/generation/jungle_dirt(src)
			else if(prob(2))
				new /obj/marker/generation/foliage/bushes/fern(src)
			if(density && prob(1))
				new /obj/marker/generation/mob/venus_human_trap(src)
		if(0.4 to 0.42)
			if(prob(5))
				new /obj/marker/generation/foliage/grass/jungle/rock(src)
				if(prob(5))
					new /obj/marker/generation/jungle_dirt(src)
			if(density &&prob(1))
				new /obj/marker/generation/mob/venus_human_trap(src)
			new /turf/simulated/floor/colored/grass/jungle(src)
		if(0.42 to 0.44)
			new /turf/simulated/liquid/water/river/jungle(src)
			if(prob(5))
				new /obj/marker/generation/water/jungle(src)
		if(0.44 to 0.45)
			if(prob(1))
				new /obj/marker/generation/mob/arachnid(src)
			new /turf/simulated/floor/colored/dirt/jungle(src)
		if(0.45 to 0.47)
			new /turf/simulated/wall/rock/brown(src)
			if(prob(1))
				new /obj/marker/generation/jungle_wall(src)
		if(0.47 to 0.48)
			if(density &&prob(1))
				new /obj/marker/generation/mob/arachnid(src)
			new /turf/simulated/floor/colored/dirt/jungle(src)
		if(0.48 to 0.85)
			new /turf/simulated/floor/grass/jungle(src)
			if(prob(5))
				new /obj/marker/generation/foliage/tree/jungle(src)
			else if(prob(2))
				new  /obj/marker/generation/foliage/tree/jungle(src)
			else if(prob(1))
				new /obj/marker/generation/foliage/grass/jungle(src)
			else if(prob(4))
				new /obj/marker/generation/foliage/grass/jungle/rock(src)
			else if(prob(2))
				new /obj/marker/generation/foliage/bushes/fern(src)
			if(density && prob(1))
				new /obj/marker/generation/mob/venus_human_trap(src)
		if(0.85 to 0.87)
			new /turf/simulated/floor/colored/grass/jungle(src)
			if(prob(5))
				new /obj/marker/generation/foliage/grass/jungle/rock(src)
			if(density && prob(1))
				new /obj/marker/generation/mob/venus_human_trap(src)
		if(0.87 to 0.9)
			new /turf/simulated/liquid/water/river/jungle(src)
		if(0.9 to INFINITY)
			new /turf/simulated/liquid/water/river/jungle(src)
			if(prob(5))
				new /obj/marker/generation/water/jungle(src)

	if(src.loc.type == /area/) new /area/mission/jungle(src)


	return ..()