/*TODO:

	Get shadekins OFF the simple mobs and into something more stable like the human species template.

	Make some adjustments for better RP and Combat authenticity.

	Pray every night that Verysoft doesn't get mad for messing with the shadekins to the degree we might be doing.

*/

/mob/living/simple_animal/shadekin //Spawning the prototype spawns a random one, see initialize()
	name = "shadekin"
	desc = "A strange, undocumented creature. It doesn't look like anything you've seen before."
	icon = 'temp/vore_shadekin.dmi'
	icon_state = "map_example"
	icon_living = "map_example"
	faction = "shadekin"
	ui_icons = 'temp/shadekin_hud.dmi'

	maxHealth = 200
	health = 200

	move_to_delay = 2
	speed = -1
//	see_in_dark = 10 //SHADEkin
	has_hands = TRUE //Pawbs
//	seedarkness = FALSE //SHAAAADEkin
	attack_sound = 'sound/weapons/bladeslice.ogg'
	has_langs = list(LANGUAGE_COMMON,LANGUAGE_SHADEKIN)

	investigates = TRUE
	reacts = TRUE
	run_at_them = FALSE
	cooperative = FALSE

	melee_damage_lower = 10
	melee_damage_upper = 20

	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	maxbodytemp = 600 //Used to be 900, reduced to 600 for purposes of making them a bit more vulnerable. - Nylon

	speak_chance = 2
	speak = list("Marrr.", "Marrr?", "Marrr!")
	response_help = "pets the"
	response_disarm = "bops the"
	response_harm = "hits the"
	attacktext = list("mauled","slashed","clawed")
	friendly = list("boops", "pawbs", "mars softly at", "sniffs on")
	reactions = list("Mar?" = "Marrr!", "Mar!" = "Marrr???", "Mar." = "Marrr.")

	var/eye_state = RED_EYES //Eye color/energy gain/loss mode
	var/eye_icon_state = null //Default, changed in init
	var/eye_desc //Eye color description added to examine

	var/mob/living/carbon/human/henlo_human //Human we're stalking currently

	//Behavior
	var/stalker = TRUE //Do we creep up on humans
	var/shy_approach = FALSE //Do we creep up slowly on humans to boop them

	//Icon handling
	var/image/tailimage //Cached tail image

	//Darknesssss
	var/energy = 100 //For abilities
	var/energy_adminbuse = FALSE //For adminbuse infinite energy
	var/dark_gains = 0 //Last tick's change in energy
	var/ability_flags = 0 //Flags for active abilities
	var/obj/screen/darkhud //Holder to update this icon
	var/obj/screen/energyhud //Holder to update this icon

	var/list/shadekin_abilities

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

/mob/living/simple_animal/shadekin/Destroy()
	QDEL_NULL_LIST(shadekin_abilities)
	. = ..()

/mob/living/simple_animal/shadekin/Life()
	. = ..()
	if(ability_flags & AB_PHASE_SHIFTED)
		density = FALSE

	//Convert spare nutrition into energy at a certain ratio
	if(. && nutrition > initial(nutrition) && energy < 100)
		nutrition = max(0, nutrition-5)
		energy = min(100,energy+1)

/mob/living/simple_animal/shadekin/update_icon()
	. = ..()

	cut_overlay(tailimage)

	tailimage.icon_state = icon_state

	add_overlay(tailimage)
	add_overlay(eye_icon_state)

/mob/living/simple_animal/shadekin/Stat()
	. = ..()
	if(statpanel("Shadekin"))
		abilities_stat()

/mob/living/simple_animal/shadekin/proc/abilities_stat()
	for(var/A in shadekin_abilities)
		var/obj/effect/shadekin_ability/ability = A
		stat("[ability.ability_name]",ability.atom_button_text())

//They phase back to the dark when killed
/mob/living/simple_animal/shadekin/death(gibbed, deathmessage = "phases to somewhere far away!")
	overlays = list()
	icon_state = ""
	flick("tp_out",src)
	spawn(1 SECOND)
		qdel(src) //Back from whence you came!

	. = ..(FALSE, deathmessage)

//Blue-eyes want to nom people to heal them
/mob/living/simple_animal/shadekin/Found(var/atom/A)
	if(specific_targets && isliving(A)) //Healing!
		var/mob/living/L = A
		var/health_percent = (L.health/L.maxHealth)*100
		if(health_percent <= 50)
			return A
	. = ..()

//They reach nutritional equilibrium (important for blue-eyes healbelly)
/mob/living/simple_animal/shadekin/Life()
	if((. = ..()))
		handle_shade()

/mob/living/simple_animal/shadekin/proc/handle_shade()
	//Shifted kin don't gain/lose energy (and save time if we're at the cap)
	var/darkness = 1


	var/turf/T = get_turf(src)
	if(!T)
		dark_gains = 0
		return

	var/brightness = T.get_lumcount() //Brightness in 0.0 to 1.0
	darkness = 1-brightness //Invert

	if(ability_flags & AB_PHASE_SHIFTED)
		dark_gains = 0
	else
		//Heal (very) slowly in good darkness -- Adjusted for better Gameplay. save an extra few decades just to head a bit per tick. - Nylon
		if(darkness >= 0.75)
			adjustFireLoss(-0.9)
			adjustBruteLoss(-0.8)
			adjustToxLoss(-1.4)

		switch(eye_state)
			//Blue has constant, steady (slow) regen and ignores darkness.
			if(BLUE_EYES)
				dark_gains = 0.5
			//Red has extremely tiny energy buildup in dark, none in light, and hunts for energy.
			if(RED_EYES) //Kinda hoping my math isn't wrong - Nylon
				dark_gains = round((darkness - 0.75) * 1.5, 0.1)
				//if(darkness >= 0.75)
					//dark_gains = 0.25
			//Purple eyes have moderate gains in darkness and loss in light.
			if(PURPLE_EYES)
				dark_gains = round((darkness - 0.5) * 2, 0.1)
			//Yellow has extreme gains in darkness and loss in light.
			if(YELLOW_EYES)
				dark_gains = round((darkness - 0.5) * 4, 0.1)
			//Similar to blues, but passive is less, and affected by dark
			if(GREEN_EYES)
				dark_gains = 0.25
				dark_gains += round((darkness - 0.5), 0.1)
			//More able to get energy out of the dark, worse attack gains tho
			if(ORANGE_EYES)
				if(darkness >= 0.65) //Some adjustments - Nylon
					dark_gains = 0.60

	energy = max(0,min(initial(energy),energy + dark_gains))

	if(energy_adminbuse) //You Mega gay for using this - Nylon
		energy = 100

	//Update turf darkness hud
	if(darkhud)
		switch(darkness)
			if(0.80 to 1.00)
				darkhud.icon_state = "dark2"
			if(0.60 to 0.80)
				darkhud.icon_state = "dark1"
			if(0.40 to 0.60)
				darkhud.icon_state = "dark"
			if(0.20 to 0.40)
				darkhud.icon_state = "dark-1"
			if(0.00 to 0.20)
				darkhud.icon_state = "dark-2"

	//Update energy storage hud
	if(energyhud)
		switch(energy)
			if(80 to INFINITY)
				energyhud.icon_state = "energy0"
			if(60 to 80)
				energyhud.icon_state = "energy1"
			if(40 to 60)
				energyhud.icon_state = "energy2"
			if(20 to 40)
				energyhud.icon_state = "energy3"
			if(0 to 20)
				energyhud.icon_state = "energy4"

//Friendly ones wander towards people, maybe shy-ly if they are set to shy
//This will be removed later when shadekins get ported over to a human species template but we'll keep this code just in case for reference. - Nylon

/mob/living/simple_animal/shadekin/speech_bubble_appearance()
	return "ghost"

/mob/living/simple_animal/shadekin/DoPunch(var/atom/A)
	. = ..(A)
	if(isliving(A)) //We punched something!
		var/mob/living/L = A
		if(L.stat != DEAD)
			var/gains = 0
			switch(eye_state) //Some adjustments, Originals will be commented - Nylon
				if(RED_EYES)
					gains = 15
				if(BLUE_EYES)
					gains = 3
				if(PURPLE_EYES)
					gains = 5
				if(YELLOW_EYES)
					gains = 4
				if(GREEN_EYES)
					gains = 2
				if(ORANGE_EYES)
					gains = 6

			energy += gains

//Special hud elements for darkness and energy gains
/mob/living/simple_animal/shadekin/extra_huds(var/datum/hud/hud,var/icon/ui_style,var/list/hud_elements)
	//Darkness hud
	darkhud = new /obj/screen()
	darkhud.icon = ui_style
	darkhud.icon_state = "dark"
	darkhud.name = "darkness"
	darkhud.screen_loc = "CENTER-2:16,SOUTH:5" //Left of the left hand
	darkhud.alpha = 150
	hud_elements |= darkhud

	//Energy hud
	energyhud = new /obj/screen()
	energyhud.icon = ui_style
	energyhud.icon_state = "energy0"
	energyhud.name = "energy"
	energyhud.screen_loc = "CENTER+1:16,SOUTH:5" //Right of the right hand
	energyhud.alpha = 150
	hud_elements |= energyhud

// When someone clicks us with an empty hand
/mob/living/simple_animal/shadekin/attack_hand(mob/living/carbon/human/M as mob)
	. = ..()
	if(M.a_intent == I_HELP)
		shy_approach = FALSE //ACCLIMATED

/datum/language/shadekin
	name = "Shadekin Empathy"
	desc = "Shadekin seem to always know what the others are thinking. This is probably why."
	colour = "changeling"
	speech_verb = "mars"
	ask_verb = "mars"
	exclaim_verb = "mars"
	key = "m"
	machine_understands = 0
	flags = RESTRICTED | HIVEMIND
