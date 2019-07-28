/*	Everything here is a library of all traits that will be shown on the character creation screen. A lot more cleaner
than the clusterfuck some code can be. This is likely another stage for development for modular fine tuning of the traits.*/

//For initial character creation
#define TRAIT_AI		0x1
#define TRAIT_HUMAN		0x2
#define TRAIT_CREATURE	0x3
#define TRAIT_DEBUG		0x4

/datum/mob/library
	var/points = 100			//For initial character or mob creation
	var/list/pools = list(var/trait_library = list(), var/attribute_library = list(), var/perk_library = list())	//A list of lists for the library to assemble.
	var/stable = TRUE			//Traits that can be selected by public users
	var/dev = FALSE				//Traits in development but may be used for certain users or controllers with access.
	var/legacy = FALSE			//Traits no longer supported but can still be used with proper access.
	var/whitelisted = list()	//A trait that is whitelisted for specific user(s)




// This contains character setup datums for traits.
// The actual modifiers (if used) for these are stored inside code/modules/mob/_modifiers/traits.dm
/*
/datum/trait/modifier
	var/modifier_type = null // Type to add to the mob post spawn.

/datum/trait/modifier/apply_trait_post_spawn(mob/living/L)
	L.add_modifier(modifier_type)

/datum/trait/modifier/generate_desc()
	var/new_desc = desc
	if(!modifier_type)
		new_desc = "[new_desc] This trait is not implemented yet."
		return new_desc
	var/datum/modifier/M = new modifier_type()
	if(!desc)
		new_desc = M.desc // Use the modifier's description, if the trait doesn't have one defined.
	var/modifier_effects = M.describe_modifier_effects()
	new_desc = "[new_desc][modifier_effects ? "<br>[modifier_effects]":""]" // Now describe what the trait actually does.
	qdel(M)
	return new_desc*/