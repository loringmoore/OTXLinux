local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_LIFEDRAIN)

function onGetFormulaValues(cid, level, skill, attack, element, factor)
local hp_target = getCreatureHealth(getCreatureTarget(cid)) * 0.25
local min = hp_target
local max = hp_target
	return -math.ceil(min), -math.ceil(max)
end

function onCastSpell(cid, var)
	doCombat(cid, combat, var)
	return true
end