local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_HOLY)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_HOLYAREA)

function onGetFormulaValues(cid, level, maglevel)
	min = -((level / 6) + (maglevel * 0.16) + 30)
	max = -((level / 6) + (maglevel * 0.19) + 40)
	return min, max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onUseWeapon(player, var)
	return doCombat(player, combat, var)
end
