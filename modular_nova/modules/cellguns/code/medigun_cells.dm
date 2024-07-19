#define UPGRADED_MEDICELL_PASSFLAGS parent_type::pass_flags | PASSGLASS | PASSGRILLE
#define MINIMUM_TEMP_DIFFERENCE 25
#define TEMP_PER_SHOT 30

/obj/item/ammo_casing/energy/medical
	select_name = "coderbus"
	fire_sound = 'sound/effects/stealthoff.ogg'
	e_cost = LASER_SHOTS(8, STANDARD_CELL_CHARGE)
	delay = 8
	harmful = FALSE
	/// The saftey mode, determines if the shot is able to bypass certain damage threshholds for potentially worse side effects
	var/safety = TRUE

/obj/projectile/energy/medical
	name = "medical heal shot"
	icon_state = "blue_laser"
	damage = 0
	var/safety

/obj/projectile/energy/medical/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(isliving(target))
		cell_effect(target)

/// The actual effects from getting blasted. No need to call parent.
/obj/projectile/energy/medical/proc/cell_effect(mob/living/target)
	return

/obj/projectile/energy/medical/healing
	var/healing_amount
	var/base_disgust

/obj/projectile/energy/medical/healing/proc/et_heal_amount(mob/living/target)
	return healing_amount

/obj/projectile/energy/medical/healing/cell_effect(mob/living/target)
	if(target.stat == DEAD)
		return
	var/damage_amount = target.get_current_damage_of_type(damage_type)
	if(safety && damage_amount > 50)
		return
	var/final_disgust
	target.heal_damage_type(healing_amount, damage_type)
	if(isnull(base_disgust))
		return
	switch(damage_amount)
		if(0 to 50)
			final_disgust = base_disgust
		if(50 to 100)
			final_disgust = base_disgust + 1.5
		if(100 to INFINITY)
			final_disgust = base_disgust + 3

	target.adjust_disgust(final_disgust)

/obj/item/ammo_casing/energy/medical/healing/brute
	projectile_type = /obj/projectile/energy/medical/healing/brute
	select_name = "brute"
	select_color = "#ff0000ff"

/obj/item/ammo_casing/energy/medical/healing/brute/improved
	projectile_type = /obj/projectile/energy/medical/healing/brute/improved
	select_name = "brute II"

/obj/item/ammo_casing/energy/medical/healing/brute/superior
	projectile_type = /obj/projectile/energy/medical/healing/brute/superior
	select_name = "brute III"

/obj/item/ammo_casing/energy/medical/healing/burn
	projectile_type = /obj/projectile/energy/medical/healing/burn
	select_name = "burn I"
	select_color = "#ffae00ff"

/obj/item/ammo_casing/energy/medical/healing/burn/improved
	projectile_type = /obj/projectile/energy/medical/healing/burn/improved
	select_name = "burn II"

/obj/item/ammo_casing/energy/medical/healing/burn/superior
	projectile_type = /obj/projectile/energy/medical/healing/burn/superior
	select_name = "burn III"

/obj/item/ammo_casing/energy/medical/healing/oxygen
	projectile_type = /obj/projectile/energy/medical/healing/oxygen
	select_name = "oxygen I"
	select_color = "#00d9ffff"

/obj/item/ammo_casing/energy/medical/healing/oxygen/improved
	projectile_type = /obj/projectile/energy/medical/healing/oxygen/improved
	select_name = "oxygen II"

/obj/item/ammo_casing/energy/medical/healing/oxygen/superior
	projectile_type = /obj/projectile/energy/medical/healing/oxygen/superior
	select_name = "oxygen III"

/obj/item/ammo_casing/energy/medical/healing/toxin
	projectile_type = /obj/projectile/energy/medical/healing/toxin
	select_name = "toxin I"
	select_color = "#15ff00ff"

/obj/item/ammo_casing/energy/medical/healing/toxin/improved
	projectile_type = /obj/projectile/energy/medical/healing/toxin/improved
	select_name = "toxin II"

/obj/item/ammo_casing/energy/medical/healing/toxin/superior
	projectile_type = /obj/projectile/energy/medical/healing/toxin/superior
	select_name = "toxin III"

/obj/projectile/energy/medical/healing/brute
	name = "brute heal shot"
	icon_state = "red_laser"
	damage_type = BRUTE
	healing_amount = 7.5
	base_disgust = 3

/obj/projectile/energy/medical/healing/brute/improved
	name = "strong brute heal shot"
	pass_flags = UPGRADED_MEDICELL_PASSFLAGS
	healing_amount = 11.25
	base_disgust = 2

/obj/projectile/energy/medical/healing/brute/superior
	name = "powerful brute heal shot"
	pass_flags = UPGRADED_MEDICELL_PASSFLAGS
	healing_amount = 15
	base_disgust = 1

/obj/projectile/energy/medical/healing/burn
	name = "burn heal shot"
	icon_state = "yellow_laser"
	damage_type = BURN
	healing_amount = 7.5
	base_disgust = 3

/obj/projectile/energy/medical/healing/burn/improved
	name = "strong burn heal shot"
	pass_flags = UPGRADED_MEDICELL_PASSFLAGS
	healing_amount = 11.25
	base_disgust = 2

/obj/projectile/energy/medical/healing/burn/superior
	name = "powerful burn heal shot"
	pass_flags = UPGRADED_MEDICELL_PASSFLAGS
	healing_amount = 15
	base_disgust = 1

/obj/projectile/energy/medical/healing/toxin
	name = "toxin heal shot"
	icon_state = "green_laser"
	damage_type = TOX
	healing_amount = 5

/obj/projectile/energy/medical/healing/toxin/improved
	name = "strong toxin heal shot"
	pass_flags = UPGRADED_MEDICELL_PASSFLAGS
	healing_amount = 7.5

/obj/projectile/energy/medical/healing/toxin/superior
	name = "powerful toxin heal shot"
	pass_flags = UPGRADED_MEDICELL_PASSFLAGS
	healing_amount = 10

/obj/projectile/energy/medical/healing/toxin/get_heal_amount(mob/living/target)
	var/healing_multiplier = 1.5

	for(var/reagent in target.reagents.reagent_list)
		if(!istype(reagent, /datum/reagent/medicine))
			healing_multiplier -= 0.25
	return healing_amount * max(0.25, healing_multiplier)

/obj/projectile/energy/medical/healing/oxygen
	name = "oxygen heal shot"
	icon_state = "yellow_laser"
	damage_type = OXY
	healing_amount = 10

/obj/projectile/energy/medical/healing/oxygen/improved
	name = "strong oxygen heal shot"
	pass_flags = UPGRADED_MEDICELL_PASSFLAGS
	healing_amount = 20

/obj/projectile/energy/medical/healing/oxygen/superior
	name = "powerful oxygen heal shot"
	pass_flags = UPGRADED_MEDICELL_PASSFLAGS
	healing_amount = 30

/*
*	UTILITY CELLS
*/

//Utility basis
/obj/projectile/energy/medical/utility
	name = "utility medical shot"
	pass_flags =  UPGRADED_MEDICELL_PASSFLAGS

//Clotting
/obj/item/ammo_casing/energy/medical/utility/clotting
	projectile_type = /obj/projectile/energy/medical/utility/clotting
	select_name = "clotting"
	select_color = "#ff00eaff"

/obj/projectile/energy/medical/utility/clotting
	name = "clotting agent shot"

/obj/projectile/energy/medical/utility/clotting/on_hit(mob/living/target, blocked = 0, pierce_hit)
	. = ..()
//	if(!IsLivingHuman(target))
//		return FALSE

	if(target.reagents.get_reagent_amount(/datum/reagent/medicine/coagulant/fabricated) < 5) //injects the target with a weaker coagulant agent
		target.reagents.add_reagent(/datum/reagent/medicine/coagulant/fabricated, 1)
		target.reagents.add_reagent(/datum/reagent/iron, 2) //adds in iron to help compensate for the relatively weak blood clotting
	else
		return

//Temprature Adjustment
/obj/item/ammo_casing/energy/medical/utility/temperature
	projectile_type = /obj/projectile/energy/medical/utility/temperature
	select_name = "temperature"
	select_color = "#fbff00ff"

/obj/projectile/energy/medical/utility/temperature
	name = "temperature adjustment shot"

/obj/projectile/energy/medical/utility/temperature/on_hit(mob/living/target, blocked = 0, pierce_hit)
	. = ..()
//	if(!IsLivingHuman(target))
//		return FALSE

	var/ideal_temp = target.get_body_temp_normal(apply_change=FALSE) //Gets the temperature we should be aiming for.
	var/current_temp = target.bodytemperature //Retrieves the targets body temperature
	var/difference = ideal_temp - current_temp

	if(abs(difference) <= MINIMUM_TEMP_DIFFERENCE) //It won't adjust temperature if the difference is too low
		return FALSE

	target.adjust_bodytemperature(difference < 0 ? -TEMP_PER_SHOT : TEMP_PER_SHOT)

//Surgical Gown Medicell.
/obj/item/ammo_casing/energy/medical/utility/gown
	projectile_type = /obj/projectile/energy/medical/utility/gown
	select_name = "gown"
	select_color = "#00ffbf"

/obj/projectile/energy/medical/utility/gown
	name = "hardlight surgical gown field"

/obj/projectile/energy/medical/utility/gown/on_hit(mob/living/target, blocked = 0, pierce_hit)
	. = ..()
	if(!istype(target, /mob/living/carbon/human)) //Dead check isn't fully needed, since it'd be reasonable for this to work on corpses.
		return

	var/mob/living/carbon/wearer = target
	var/obj/item/clothing/gown = new /obj/item/clothing/suit/toggle/labcoat/hospitalgown/hardlight

	if(wearer.equip_to_slot_if_possible(gown, ITEM_SLOT_OCLOTHING, 1, 1, 1))
		wearer.visible_message(span_notice("The [gown] covers [wearer] body"), span_notice("The [gown] wraps around your body, covering you"))
		return
	else
		wearer.visible_message(span_notice("The [gown] fails to fit on [wearer], instantly disentagrating away"), span_notice("The [gown] unable to fit on you, disentagrates into nothing"))
		return FALSE

//Salve Medicell
/obj/item/ammo_casing/energy/medical/utility/salve
	projectile_type = /obj/projectile/energy/medical/utility/salve
	select_name = "salve"
	select_color = "#00af57"

/obj/projectile/energy/medical/utility/salve
	name = "salve globule"
	icon_state = "glob_projectile"
	shrapnel_type = /obj/item/mending_globule/hardlight
	embed_type = /datum/embed_data/salve_globule
	damage = 0

/datum/embed_data/salve_globule
	embed_chance = 100
	ignore_throwspeed_threshold = TRUE
	pain_mult = 0
	jostle_pain_mult = 0
	fall_chance = 0

/obj/projectile/energy/medical/utility/salve/on_hit(mob/living/target, blocked = 0, pierce_hit)
//	if(!IsLivingHuman(target)) //No using this on the dead or synths.
//		return FALSE
	return ..()

//Hardlight Rollerbed Medicell
/obj/item/ammo_casing/energy/medical/utility/bed
	projectile_type = /obj/projectile/energy/medical/utility/bed
	select_name = "rollerbed"
	select_color = "#00fff2"

/obj/projectile/energy/medical/utility/bed
	name = "hardlight bed field"

/obj/projectile/energy/medical/utility/bed/on_hit(mob/living/target, blocked = 0, pierce_hit)
	. = ..()

	if(!istype(target, /mob/living/carbon/human)) //Only checks if they are human, it would make sense for this to work on the dead.
		return FALSE

	for(var/obj/structure/bed/medical/medigun in target.loc) //Prevents multiple beds from being spawned on the same turf
		return FALSE

	if(HAS_TRAIT(target, TRAIT_FLOORED) || target.resting) //Is the person already on the floor to begin with? Mostly a measure to prevent spamming.
		var /obj/structure/bed/medical/medigun/created_bed = new /obj/structure/bed/medical/medigun(target.loc)

		if(!target.stat == CONSCIOUS)
			created_bed.buckle_mob(target)
		return TRUE
	else
		return FALSE

/obj/item/ammo_casing/energy/medical/utility/body_teleporter
	projectile_type = /obj/projectile/energy/medical/utility/body_teleporter
	select_name = "teleporter"
	select_color = "#4400ff"
	delay = 12 //This is a powerful cell, It'd be good for this to have a bit of a delay

/obj/projectile/energy/medical/utility/body_teleporter
	name = "bluespace transportation field"

/obj/projectile/energy/medical/utility/body_teleporter/on_hit(mob/living/target, blocked = 0, pierce_hit)
	. = ..()

	if(!ishuman(target) || (target.stat != DEAD && !HAS_TRAIT(target, TRAIT_DEATHCOMA)))
		return FALSE

	var/mob/living/carbon/body = target

	teleport_effect(body.loc)
	body.forceMove(firer.loc)
	teleport_effect(body.loc)

	body.visible_message(span_notice("[body]'s body teleports to [firer]!"))

/obj/projectile/energy/medical/utility/body_teleporter/proc/teleport_effect(location)
	var/datum/effect_system/spark_spread/quantum/sparks = new /datum/effect_system/spark_spread/quantum //uses the teleport effect from quantum pads
	sparks.set_up(5, 1, get_turf(location))
	sparks.start()

//Objects Used by medicells.
/obj/item/clothing/suit/toggle/labcoat/hospitalgown/hardlight
	name = "hardlight hospital gown"
	desc = "A hospital gown made out of hardlight - you can barely feel it on your body, especially with all the anesthetics."
	greyscale_colors = "#B2D3CA#B2D3CA#B2D3CA#B2D3CA"

/obj/item/clothing/suit/toggle/labcoat/hospitalgown/hardlight/dropped(mob/user)
	. = ..()
	var/mob/living/carbon/wearer = user

	if((wearer.get_item_by_slot(ITEM_SLOT_OCLOTHING)) == src && !QDELETED(src))
		to_chat(wearer, span_notice("The [src] disappeared after being removed"))
		qdel(src)
		return

//Salve Globule
/obj/item/mending_globule/hardlight
	name = "salve globule"
	desc = "A ball of regenerative synthetic plant matter, contained within a soft hardlight field."
	embed_type = /datum/embed_data/salve_globule
	icon = 'modular_nova/modules/cellguns/icons/obj/guns/mediguns/misc.dmi'
	icon_state = "globule"
	heals_left = 40 //This means it'll be heaing 15 damage per type max.

/obj/item/mending_globule/hardlight/unembedded()
	. = ..()
	qdel(src)

/obj/item/mending_globule/hardlight/process()
	if(!bodypart)
		return FALSE

	if(!bodypart.get_damage()) //Makes it poof as soon as the body part is fully healed, no keeping this on forever.
		qdel(src)
		return FALSE

	bodypart.heal_damage(0.25,0.25) //Reduced healing rate over original
	heals_left--

	if(heals_left <= 0)
		qdel(src)

//Hardlight Emergency Bed.
/obj/structure/bed/medical/medigun
	name = "hardlight medical bed"
	desc = "A medical bed made out of Hardlight"
	icon = 'modular_nova/modules/cellguns/icons/obj/guns/mediguns/misc.dmi'
	icon_state = "hardlight_down"
	base_icon_state = "hardlight"
	max_integrity = 1
	build_stack_type = null //It would not be good if people could use this to farm materials.
	var/deploy_time = 20 SECONDS //How long the roller beds lasts for without someone buckled to it.

/obj/structure/bed/medical/medigun/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(check_bed)), deploy_time)

// formerly NO_DECONSTRUCTION
/obj/structure/bed/medical/medigun/wrench_act_secondary(mob/living/user, obj/item/weapon)
	return NONE

/obj/structure/bed/medical/medigun/proc/check_bed() //Checks to see if anyone is buckled to the bed, if not the bed will qdel itself.
	if(!has_buckled_mobs())
		qdel(src) //Deletes the roller bed, mostly meant to prevent stockpiling and clutter
		return TRUE //There is nothing on the bed.
	else
		return FALSE //There is something on the bed.

/obj/structure/bed/medical/medigun/post_unbuckle_mob(mob/living/M)
	. = ..()
	qdel(src)

/obj/structure/bed/medical/medigun/mouse_drop_dragged(atom/over, mob/user, src_location, over_location, params)
	if(over == user && Adjacent(user))
		if(!ishuman(user) || !user.can_perform_action(src))
			return FALSE

		if(has_buckled_mobs())
			return FALSE

		user.visible_message(span_notice("[user] deactivates \the [src]."), span_notice("You deactivate \the [src]."))
		qdel(src)

//Oppressive Force Relocation
/obj/item/ammo_casing/energy/medical/utility/relocation
	projectile_type = /obj/projectile/energy/medical/utility/relocation
	select_name = "relocation"
	select_color = "#140085"

//The version that the normal medicells use
/obj/item/ammo_casing/energy/medical/utility/relocation/standard
	projectile_type = /obj/projectile/energy/medical/utility/relocation/standard
	delay = 12

/obj/projectile/energy/medical/utility/relocation
	name = "bluespace transportation field"
	/// Determines whether or not this works anywhere?
	var/area_locked = FALSE
	/// A list of areas that the effect works in, if area_locked is set to true
	var/list/teleport_areas
	/// Where the target will be teleported to.
	var/destination_area = /area/station/medical/medbay/lobby

	/// Is there a grace period before someone is teleported
	var/grace_period = FALSE
	/// How much time does the target have to leave the area before they end up getting teleported?
	var/time_allowance = 10 SECONDS

	/// Is access required to teleport
	var/access_teleporting = FALSE
	/// if the target doesn't have this access on their ID, they will be teleported
	var/required_access = ACCESS_SURGERY

/obj/projectile/energy/medical/utility/relocation/standard
	area_locked = TRUE
	teleport_areas = list(/area/station/medical/surgery, /area/station/medical/treatment_center, /area/station/medical/storage, /area/station/medical/patients_rooms)
	grace_period = TRUE
	access_teleporting = TRUE

/obj/projectile/energy/medical/utility/relocation/on_hit(mob/living/target, blocked = 0, pierce_hit)
	. = ..()

	if(!ishuman(target))
		return FALSE

	var/mob/living/carbon/human/teleportee = target

	if(area_locked && length(teleport_areas) && !is_type_in_list(get_area(target), teleport_areas))
		return FALSE

	if(access_teleporting && teleportee.wear_id)
		var/target_access = teleportee.wear_id.GetAccess() //Stores the access of the target within a variable
		if(required_access in target_access)
			return FALSE

	if(teleportee.GetComponent(/datum/component/medigun_relocation))
		return FALSE

	if(target.buckled)
		return FALSE

	if(grace_period)
		to_chat(teleportee, span_warning("You have [(time_allowance / 10)] seconds to leave, if you do not leave in this time, you will be forcibly teleported outside."))
		teleportee.AddComponent(/datum/component/medigun_relocation, time_allowance, destination_area, area_locked, teleport_areas)
		return TRUE

	var/list/turf_list

	if(!turf_list)
		turf_list = list()
		for(var/turf/turf_in_area in get_area_turfs(destination_area))
			if(!turf_in_area.is_blocked_turf())
				turf_list += turf_in_area

	teleportee.visible_message(span_notice("[teleportee] is teleported away!"))

	do_teleport(teleportee, pick(turf_list), no_effects = FALSE, channel = TELEPORT_CHANNEL_QUANTUM)

/// Used to handle teleporting if there is a grace period
/datum/component/medigun_relocation
	/// Area that the target is teleported to
	var/area/destination_area
	/// The person that is being teleported
	var/mob/living/carbon/human/teleportee
	/// Is the teleport locked to only specific areas.
	var/area_locked
	/// If area_locked is enabled, people can be teleported while in these areas.
	var/list/teleport_areas

/datum/component/medigun_relocation/Initialize(time_allowance, destination, locked, areas)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	var/atom/parent_atom = parent

	teleport_areas = areas
	teleportee = parent_atom
	area_locked = locked
	destination_area = destination

	addtimer(CALLBACK(src, PROC_REF(dispense_treat)), (time_allowance * 0.95))
	QDEL_IN(src, time_allowance)

/datum/component/medigun_relocation/Destroy()
	if(area_locked && length(teleport_areas) && !is_type_in_list(get_area(teleportee), teleport_areas))
		return ..()

	if(!teleportee.stat == CONSCIOUS) // This is mostly here to stop medical from accidentally teleporting out people they otherwise wouldn't want to.
		return ..()

	var/list/turf_list

	if(!turf_list)
		turf_list = list()
		for(var/turf/turf_in_area in get_area_turfs(destination_area))
			if(!turf_in_area.is_blocked_turf())
				turf_list += turf_in_area

	teleportee.visible_message(span_notice("[teleportee] is teleported away!"))

	do_teleport(teleportee, pick(turf_list), no_effects = FALSE, channel = TELEPORT_CHANNEL_QUANTUM)

	return ..()

/// Puts a treat in the teleportee's hands.
/datum/component/medigun_relocation/proc/dispense_treat()
	var/obj/item/goodbye_treat = new /obj/item/food/lollipop/cyborg(teleportee) // The borg one is being used because it has psicodine instead of omnizine.
	teleportee.put_in_hands(goodbye_treat)

//End of utility
#undef UPGRADED_MEDICELL_PASSFLAGS
#undef MINIMUM_TEMP_DIFFERENCE
#undef TEMP_PER_SHOT
