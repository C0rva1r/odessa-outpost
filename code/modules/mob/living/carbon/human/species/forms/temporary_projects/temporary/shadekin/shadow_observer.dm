/*TODO:

	FUCK ME, please don't let me spaghettify the entire code. This will be done later whenever or as soon as possible.

*/

/datum/species/observer
	
	name = "Strange Creature"
	blurb = "A beta race in the making."
	min_age = 18
	max_age = 500000000	   				//This is what you get.
	total_health = 100

	unarmed_types = list(
		/datum/unarmed_attack/claws/strong,
		/datum/unarmed_attack/bite
		)

	default_form = FORM_SHADEKIN

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
	heat_level_1 = 5000                           // Heat damage level 1 above this point.
	heat_level_2 = 10000                           // Heat damage level 2 above this point.
	heat_level_3 = 20000                           // Heat damage level 3 above this point.
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


/mob/living/carbon/human/observer
	species_name = "observer"

	incorporeal_move = 0 				//0 is off, 1 is normal, 2 is for ninjas.
	see_in_dark = 30
	see_invisible = SEE_INVISIBLE_LIVING
	
	datum/species/species = /datum/species/observer

	maxHealth = 200
	health = 200

	move_to_delay = 0					//Speedy bois -- Nylon
	
	special_voice = "Strange Voice"
	list/languages = list(LANGUAGE_COMMON, LANGUAGE_EMPATHY)         	// For speaking/listening.
	list/speak_emote = list("says") 	// Verbs used when speaking. Defaults to 'say' if speak_emote is null.
	emote_type = 1						// Define emote default type, 1 for seen emotes, 2 for heard emotes
	facing_dir = null   				// Used for the ancient art of moonwalking.

	bodytemperature = 365.15

	default_pixel_x = 0
	default_pixel_y = 0
	old_x = 0
	old_y = 0
	nutrition = 1000
	max_nutrition = 1000
	list/eat_sounds = list('sound/items/eatfood.ogg')


	datum/hud/hud_used = null

	can_pull_size = ITEM_SIZE_NO_CONTAINER 				// Maximum w_class the mob can pull.
	can_pull_mobs = MOB_PULL_LARGER       				// Whether or not the mob can pull other mobs.

	list/active_genes=list()
	list/mutations = list() //Carbon -- Doohl

	voice_name = "unidentifiable voice"

	faction = "Observer" 								//Used for checking whether hostile simple animals will attack you, possibly more stuff later
	captured = 0 										//Functionally, should give the same effect as being buckled into a chair when true.

	blinded = null
	ear_deaf = null										//Carbon

	var/list/observer_abilities = list()				//will populate this with something -- Nylon

	mouse_drag_pointer = MOUSE_ACTIVE_POINTER

	update_icon = 1 //Set to 1 to trigger update_icons() at the next life() call

	status_flags = CANSTUN|CANWEAKEN|CANPARALYSE|CANPUSH	//bitflags defining which status effects can be inflicted (replaces canweaken, canstun, etc)

	area/lastarea = null

	digitalcamo = 0 // Can they be tracked by the AI?

	obj/control_object //Used by admins to possess objects. All mobs should have this var

	//Whether or not mobs can understand other mobtypes. These stay in /mob so that ghosts can hear everything.
	universal_speak = 0 // Set to 1 to enable the mob to speak to everyone -- TLE
	universal_understand = 1 // Set to 1 to enable the mob to understand everyone, not necessarily speak

	//If set, indicates that the client "belonging" to this (clientless) mob is currently controlling some other mob
	//so don't treat them as being SSD even though their client var is null.
	mob/teleop = null

	mob_size = MOB_LARGE

	paralysis = 0
	stunned = 0
	weakened = 0
	drowsyness = 0.0


	list/HUDneed = list() 						// What HUD object need see
	list/HUDinventory = list()
	list/HUDfrippery = list()					//flavor
	list/HUDprocess = list() 					//What HUD object need process
	list/HUDtech = list()
	defaultHUD = ""								//Default mob hud
	hud_updateflag = 0

	list/progressbars = null


	speed_factor = 6.0

	datum/stat_holder/stats

	mob_classification = 0 //Bitfield. Uses TYPE_XXXX defines in defines/mobs.dm.

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