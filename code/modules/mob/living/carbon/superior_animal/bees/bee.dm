/mob/living/carbon/superior_animal/bee
	name = "Bee"
	desc = "It's a normal honey bee"

	mob_bump_flag = SIMPLE_ANIMAL
	mob_swap_flags = SIMPLE_ANIMAL
	mob_push_flags = SIMPLE_ANIMAL
	mob_size = MOB_TINY
	a_intent = I_HURT

	icon = 'icons/mob/animal.dmi'
	icon_state = "tomato"

	icon_living = "tomato"
	icon_dead = null
	icon_rest = null //resting/unconscious animation
	icon_gib = null //gibbing animation
	randpixel = 9 //Mob may be offset randomly on both axes by this much

	overkill_gib = 10
	overkill_dust = 20

	emote_see = list() //chat emotes
	speak_chance = 2 //percentage chance of speaking a line from 'emote_see'

	turns_per_move = 3 //number of life ticks per random movement
	turns_since_move = 0 //number of life ticks since last random movement
	wander = 1 //perform automated random movement when idle
	stop_automated_movement_when_pulled = 1

	deathmessage = "dies."
	attacktext = "stings"
	attack_sound = 'sound/weapons/spiderlunge.ogg'
	attack_sound_chance = 33
	attack_sound_volume = 20

	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/roachmeat
	meat_amount = 3

	melee_damage_lower = 1
	melee_damage_upper = 2

	viewRange = 9 //how far the mob AI can see
	acceptableTargetDistance = 1 //consider all targets within this range equally

	environment_smash = 0
	destroy_surroundings = 0
	can_burrow = FALSE