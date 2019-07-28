/*	Everything here is a library of all traits that will be shown on the character creation screen. A lot more cleaner
than the clusterfuck some code can be. This is likely another stage for development for modular fine tuning of the traits.*/

//For initial character creation

// Physical traits are what they sound like, and involve the character's physical body, as opposed to their mental state.

#define TRAIT_AI		0x1
#define TRAIT_HUMAN		0x2
#define TRAIT_CREATURE	0x3
#define TRAIT_DEBUG		0x4

/datum/trait
	var/name = "Blank slate"		//Name of trait
	var/desc = "This is a root trait, if your seeing this than an issue has occured"	//Description of the trait
	var/debug = null				//Traits related to testing or general fuckery.
	var/mutually_exclusive = null	//Can't have contradictory traits.
	var/category = null				//What category do they fill?
	var/points = 100				//For initial character or mob creation.
	var/datum/pool = list(var/traits = list(), var/attribute_library = list(), var/perk_library = list())	//A list of lists for the library to assemble.
	var/whitelisted = list()		//A trait that is whitelisted for specific user(s)


/datum/trait/category/physical
	category = "Physical Attributes"



/*
/datum/trait/category/physical/ai
	name = "Artificial"
	desc = "You are an AI. Something that is living yet also not. A product from artificial means of construction."
	category = /datum/category/trait/ai
	mutually_exclusive = list(/datum/trait/category/physical/organic)

/datum/trait/category/physical/organic
	name = "Organic"
	desc = "You're more fragile than most, and have less of an ability to endure harm."
	category = /datum/category/trait/organic
	mutually_exclusive = list(/datum/trait/category/physical/ai)

*/

/*
/datum/trait/category/physical/frail
	name = "Frail"
	desc = "Your body is very fragile, and has even less of an ability to endure harm."
	category_type = /datum/category/trait/frail
	mutually_exclusive = list(/datum/trait/category/physical/flimsy)


/datum/trait/category/physical/haemophilia
	name = "Haemophilia"
	desc = "Some say that when it rains, it pours.  Unfortunately, this is also true for yourself if you get cut."
	category_type = /datum/category/trait/haemophilia

/datum/trait/category/physical/haemophilia/test_for_invalidity(var/datum/category_item/player_setup_item/traits/setup)
	if(TRAIT_AI)
		return "Full Body Prosthetics cannot bleed."
	// If a species lacking blood is added, it is suggested to add a check for them here.
	return ..()


/datum/trait/category/physical/weak
	name = "Weak"
	desc = "A lack of physical strength causes a diminshed capability in close quarters combat."
	category_type = /datum/category/trait/weak
	mutually_exclusive = list(/datum/trait/category/physical/wimpy)


/datum/trait/category/physical/wimpy
	name = "Wimpy"
	desc = "An extreme lack of physical strength causes a greatly diminished capability in close quarters combat."
	category_type = /datum/category/trait/wimpy
	mutually_exclusive = list(/datum/trait/category/physical/weak)


/datum/trait/category/physical/inaccurate
	name = "Inaccurate"
	desc = "You're rather inexperienced with guns, you've never used one in your life, or you're just really rusty.  \
	Regardless, you find it quite difficult to land shots where you wanted them to go."
	category_type = /datum/category/trait/inaccurate


//Size
/datum/trait/category/physical/smaller
	name = "Smaller"
	category_type = /datum/category/trait/smaller
	mutually_exclusive = list(/datum/trait/category/physical/small, /datum/trait/category/physical/large, /datum/trait/category/physical/larger)

/datum/trait/category/physical/small
	name = "Small"
	category_type = /datum/category/trait/small
	mutually_exclusive = list(/datum/trait/category/physical/smaller, /datum/trait/category/physical/large, /datum/trait/category/physical/larger)

/datum/trait/category/physical/large
	name = "Large"
	category_type = /datum/category/trait/large
	mutually_exclusive = list(/datum/trait/category/physical/smaller, /datum/trait/category/physical/small, /datum/trait/category/physical/larger)

/datum/trait/category/physical/larger
	name = "Larger"
	category_type = /datum/category/trait/larger
	mutually_exclusive = list(/datum/trait/category/physical/smaller, /datum/trait/category/physical/small, /datum/trait/category/physical/large)


//Colour blindness
/datum/trait/category/physical/colorblind_protanopia
	name = "Protanopia"
	desc = "You have a form of red-green colorblindness. You cannot see reds, and have trouble distinguishing them from yellows and greens."
	category_type = /datum/category/trait/colorblind_protanopia
	mutually_exclusive = list(/datum/trait/category/physical/colorblind_deuteranopia, /datum/trait/category/physical/colorblind_tritanopia, /datum/trait/category/physical/colorblind_monochrome)

/datum/trait/category/physical/colorblind_deuteranopia
	name = "Deuteranopia"
	desc = "You have a form of red-green colorblindness. You cannot see greens, and have trouble distinguishing them from yellows and reds."
	category_type = /datum/category/trait/colorblind_deuteranopia
	mutually_exclusive = list(/datum/trait/category/physical/colorblind_protanopia, /datum/trait/category/physical/colorblind_tritanopia, /datum/trait/category/physical/colorblind_monochrome)

/datum/trait/category/physical/colorblind_tritanopia
	name = "Tritanopia"
	desc = "You have a form of blue-yellow colorblindness. You have trouble distinguishing between blues, greens, and yellows, and see blues and violets as dim."
	category_type = /datum/category/trait/colorblind_tritanopia
	mutually_exclusive = list(/datum/trait/category/physical/colorblind_protanopia, /datum/trait/category/physical/colorblind_deuteranopia, /datum/trait/category/physical/colorblind_monochrome)

/datum/trait/category/physical/colorblind_monochrome
	name = "Monochromacy"
	desc = "You are fully colorblind. Your condition is rare, but you can see no colors at all."
	category_type = /datum/category/trait/colorblind_monochrome
	mutually_exclusive = list(/datum/trait/category/physical/colorblind_protanopia, /datum/trait/category/physical/colorblind_deuteranopia, /datum/trait/category/physical/colorblind_tritanopia)


// Metabolism
/datum/trait/category/physical/high_metabolism
	name = "High Metabolism"
	category_type = /datum/category/trait/high_metabolism
	mutually_exclusive = list(/datum/trait/category/physical/low_metabolism)

/datum/trait/category/physical/high_metabolism/test_for_invalidity(var/datum/category_item/player_setup_item/traits/setup)
	if(TRAIT_AI)
		return "Full Body Prosthetics do not have a metabolism."
	return ..()

/datum/trait/category/physical/low_metabolism
	name = "Low Metabolism"
	category_type = /datum/category/trait/low_metabolism
	mutually_exclusive = list(/datum/trait/category/physical/high_metabolism)

/datum/trait/category/physical/low_metabolism/test_for_invalidity(var/datum/category_item/player_setup_item/traits/setup)
	if(TRAIT_AI)
		return "Full Body Prosthetics do not have a metabolism."
	return ..()

/datum/trait/category/physical/cloned/test_for_invalidity(var/datum/category_item/player_setup_item/traits/setup)
	if(TRAIT_AI)
		return "Full Body Prosthetics cannot be cloned."
	return ..()

// Cloning and Borging
/datum/trait/category/physical/no_clone
	name = "Cloning Incompatability"
	category_type = /datum/category/no_clone

/datum/trait/category/physical/no_clone/test_for_invalidity(var/datum/category_item/player_setup_item/traits/setup)
	if(TRAIT_AI || ATT_FBP)
		return "Full Body Prosthetics cannot be cloned anyways."
	return ..()

/datum/trait/category/physical/no_borg
	name = "Cybernetic Incompatability"
	category_type = /datum/category/no_borg

/datum/trait/category/physical/no_borg/test_for_invalidity(var/datum/category_item/player_setup_item/traits/setup)
	if(TRAIT_AI)
		return "Full Body Prosthetics are already partly or fully mechanical."
	return ..()



/datum/trait/category/allergy
	name = "Allergies to substances"
	category_type = /datum/category/allergies

/datum/trait/category/allergy/feline
	if(TRAIT_AI)
		return "Your selection cannot be completed because you are an Full Body Prosthetic or an AI"

*/