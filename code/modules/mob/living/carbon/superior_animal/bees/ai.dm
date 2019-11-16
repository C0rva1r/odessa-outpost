/mob/living/carbon/superior_animal/bee/findTarget()
	. = ..()
	if(. != FORM_SPIDER)
		visible_emote("flies towards [.]!")
		playsound(src, 'sound/voice/insect_battle_screeching.ogg', 30, 1, -3)
	else
		return FALSE