#define IC_TOPIC_UNHANDLED 		0
#define IC_TOPIC_HANDLED 		1
#define IC_TOPIC_REFRESH 		2
#define IC_FLAG_ANCHORABLE 		1
#define IC_FLAG_CAN_FIRE 		2

#define IC_INPUT 		"I"
#define IC_OUTPUT		"O"
#define IC_ACTIVATOR	"A"

// Pin functionality.
#define DATA_CHANNEL "data channel"
#define PULSE_CHANNEL "pulse channel"

// Methods of obtaining a circuit.
#define IC_SPAWN_DEFAULT			1 // If the circuit comes in the default circuit box and able to be printed in the IC printer.
#define IC_SPAWN_RESEARCH 			2 // If the circuit design will be available in the IC printer after upgrading it.

// Categories that help differentiate circuits that can do different tipes of actions
#define IC_ACTION_MOVEMENT		(1<<0) // If the circuit can move the assembly
#define IC_ACTION_COMBAT		(1<<1) // If the circuit can cause harm
#define IC_ACTION_LONG_RANGE	(1<<2) // If the circuit communicate with something outside of the assembly

// Displayed along with the pin name to show what type of pin it is.
#define IC_FORMAT_ANY			"\<ANY\>"
#define IC_FORMAT_STRING		"\<TEXT\>"
#define IC_FORMAT_CHAR			"\<CHAR\>"
#define IC_FORMAT_COLOR			"\<COLOR\>"
#define IC_FORMAT_NUMBER		"\<NUM\>"
#define IC_FORMAT_DIR			"\<DIR\>"
#define IC_FORMAT_BOOLEAN		"\<BOOL\>"
#define IC_FORMAT_REF			"\<REF\>"
#define IC_FORMAT_LIST			"\<LIST\>"
#define IC_FORMAT_INDEX			"\<INDEX\>"

#define IC_FORMAT_PULSE			"\<PULSE\>"

// Used inside input/output list to tell the constructor what pin to make.
#define IC_PINTYPE_ANY				/datum/integrated_io
#define IC_PINTYPE_STRING			/datum/integrated_io/string
#define IC_PINTYPE_CHAR				/datum/integrated_io/char
#define IC_PINTYPE_COLOR			/datum/integrated_io/color
#define IC_PINTYPE_NUMBER			/datum/integrated_io/number
#define IC_PINTYPE_DIR				/datum/integrated_io/dir
#define IC_PINTYPE_BOOLEAN			/datum/integrated_io/boolean
#define IC_PINTYPE_REF				/datum/integrated_io/ref
#define IC_PINTYPE_LIST				/datum/integrated_io/lists
#define IC_PINTYPE_INDEX			/datum/integrated_io/index

#define IC_PINTYPE_PULSE_IN			/datum/integrated_io/activate
#define IC_PINTYPE_PULSE_OUT		/datum/integrated_io/activate/out

// Data limits.
#define IC_MAX_LIST_LENGTH			500

#define MOB_INPUT_TEXT	"Text"

//Used in mob/proc/get_input
#define MOB_INPUT_TEXT "text"
#define MOB_INPUT_MESSAGE "message"
#define MOB_INPUT_NUM "num"

//*Squish
#define SLIME_EVOLUTION_THRESHOLD 10



/mob/proc/get_input(var/message, var/title, var/default, var/choice_type, var/obj/required_item)
	if(src.incapacitated() || (required_item && !GLOB.hands_state.can_use_topic(required_item,src)))
		return null
	var/choice
	if(islist(choice_type))
		choice = input(src, message, title, default) as null|anything in choice_type
	else
		switch(choice_type)
			if(MOB_INPUT_TEXT)
				choice = input(src, message, title, default) as null|text
			if(MOB_INPUT_NUM)
				choice = input(src, message, title, default) as null|num
			if(MOB_INPUT_MESSAGE)
				choice = input(src, message, title, default) as null|message
	if(isnull(choice) || src.incapacitated() || (required_item && !GLOB.hands_state.can_use_topic(required_item,src)))
		return null
	return choice