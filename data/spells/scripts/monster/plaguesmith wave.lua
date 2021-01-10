local combat = {}

for i = 100, 200 do
	combat[i] = Combat()
	combat[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
	combat[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_YELLOW_RINGS)
	
	local condition = Condition(CONDITION_BLEEDING)
	condition:setParameter(CONDITION_PARAM_DELAYED, 0)
	
	local damage = i
	condition:addDamage(1, 4000, -damage)

	local area = createCombatArea({
	{1, 1, 1},
	{1, 1, 1},
	{0, 1, 0},
	{0, 1, 0},
	{0, 3, 0},
})
	combat[i]:setArea(area)
	combat[i]:setCondition(condition)
end

function onCastSpell(creature, var)
	return combat[math.random(100, 200)]:execute(creature, var)
end