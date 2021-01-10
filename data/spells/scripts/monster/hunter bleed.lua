local combat = {}

for i = 15, 15 do
	combat[i] = Combat()
	combat[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
	combat[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_DRAWBLOOD)
	
	local condition = Condition(CONDITION_BLEEDING)
	condition:setParameter(CONDITION_PARAM_DELAYED, 1)
	
	local damage = i
	condition:addDamage(20, 2000, -damage)

	local area = createCombatArea(AREA_CIRCLE2X2)
	
	combat[i]:setArea(area)
	combat[i]:setCondition(condition)
end

function onCastSpell(creature, var)
	return combat[math.random(15, 15)]:execute(creature, var)
end