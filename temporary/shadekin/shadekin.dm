/*TODO:

	FUCK ME, please don't let me spaghettifying the entire code.

*/

/datum/species/observer //Spawning the prototype spawns a random one, see initialize()
	name = "Strange Creature"
	var/icon_state = "map_example"
	var/icon_living = "map_example"
	blurb = "A beta race in the making."

	min_age = 18
	max_age = 500000000	   				//This is what you get.

	total_health = 100

	unarmed_types = list(
		/datum/unarmed_attack/claws/strong,
		/datum/unarmed_attack/bite
		)

	brute_mod =     1                    // Physical damage multiplier.
	burn_mod =      1                    // Burn damage multiplier.
	oxy_mod =       0                    // Oxyloss modifier
	toxins_mod =    1                    // Toxloss modifier
	radiation_mod = 0                    // Radiation modifier
	flash_mod =     2                    // Stun from blindness modifier.

	breath_pressure = -1
	breath_pressure = 16                          // Minimum partial pressure safe for breathing, kPa
	breath_type = "oxygen"                        // Non-oxygen gas breathed, if any.
	poison_type = "plasma"                        // Poisonous air.
	exhale_type = "carbon_dioxide"                // Exhaled gas type.
	cold_level_1 = -1                             // Cold damage level 1 below this point.
	cold_level_2 = -1                             // Cold damage level 2 below this point.
	cold_level_3 = -1                             // Cold damage level 3 below this point.
	heat_level_1 = 1000                           // Heat damage level 1 above this point.
	heat_level_2 = 2000                           // Heat damage level 2 above this point.
	heat_level_3 = 3000                           // Heat damage level 3 above this point.
	light_dam = 0                                 // If set, mob will be damaged in light over this value and heal in light below its negative.
	body_temperature = 365.15	                  // Non-IS_SYNTHETIC species will try to stabilize at this temperature.

	cold_discomfort_level = null
	heat_discomfort_level = 1000

	darksight = 25

	var/eye_state = RED_EYES //Eye color/energy gain/loss mode
	var/eye_icon_state = null //Default, changed in init
	var/eye_desc //Eye color description added to examine

	//Icon handling
	var/image/tailimage //Cached tail image

	//Darknesssss
	var/energy = 100 //For abilities
	var/energy_adminbuse = FALSE //For adminbuse infinite energy
	var/dark_gains = 0 //Last tick's change in energy
	var/ability_flags = 0 //Flags for active abilities
	var/obj/screen/darkhud //Holder to update this icon
	var/obj/screen/energyhud //Holder to update this icon

	var/list/observer_abilities

/*
/mob/living/simple_animal/shadekin/initialize()
	//You spawned the prototype, and want a totally random one.
	if(type == /mob/living/simple_animal/shadekin)

		//I'm told by VerySoft these are the liklihood values
		var/list/sk_types = list(
			/mob/living/simple_animal/shadekin/red = 20,	//Actively seek people out to nom, so fairly common to see (relatively speaking),
			/mob/living/simple_animal/shadekin/blue = 15,	//Explorers that like to interact with people, so still fairly common,
			/mob/living/simple_animal/shadekin/purple = 15,	//Also explorers that may or may not homf people,
			/mob/living/simple_animal/shadekin/yellow = 1	//Very rare, usually never leaves their home
		)
		var/new_type = pickweight(sk_types)

		new new_type(loc)
		initialized = TRUE
		return INITIALIZE_HINT_QDEL

	if(icon_state == "map_example")
		icon_state = pick("white","dark","brown")

	icon_living = icon_state

	switch(eye_state)
		if(BLUE_EYES)
			eye_icon_state = "e_blue"
		if(RED_EYES)
			eye_icon_state = "e_red"
		if(PURPLE_EYES)
			eye_icon_state = "e_purple"
		if(YELLOW_EYES)
			eye_icon_state = "e_yellow"
		if(GREEN_EYES)
			eye_icon_state = "e_green"
		if(ORANGE_EYES)
			eye_icon_state = "e_orange"
		else
			eye_icon_state = "e_red"

	tailimage = image('icons/mob/vore_shadekin64.dmi',null,icon_state)
	tailimage.pixel_x = -16

	if(eye_desc)
		desc += " This one has [eye_desc]!"

	var/list/ability_types = subtypesof(/obj/effect/shadekin_ability)
	shadekin_abilities = list()
	for(var/type in ability_types)
		shadekin_abilities += new type(src)

	update_icon()

	return ..()
*/

/datum/language/observer
	name = "Observer Empathy"
	desc = "A none documented language of the mysterious creatures."
	colour = "changeling"
	speech_verb = "mars"
	ask_verb = "mars"
	exclaim_verb = "mars"
	key = "m"
	machine_understands = 0
	flags = RESTRICTED | HIVEMIND
