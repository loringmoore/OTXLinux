local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_ICEATTACK)

local area = createCombatArea(AREA_WAVE7)
setCombatArea(combat, area)

function onGetFormulaValues(cid, level, maglevel)
	min = -((level / 5) + (maglevel * 4.5) + 20)
	max = -((level / 5) + (maglevel * 7.6) + 48)
	return min, max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end
