local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEAREA)
combat:setArea(createCombatArea(AREA_CIRCLE2X2))

local condition = Condition(CONDITION_DROWN)
condition:setParameter(CONDITION_PARAM_DELAYED, true)
condition:addDamage(20, 2000, -20)
combat:setCondition(condition)

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end