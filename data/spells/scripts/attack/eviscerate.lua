local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ARCANE)

local t = {}
for a = 1, 400 do
	t[a] = {}
	for b = 0, 156 do
		t[a][b] = createConditionObject(CONDITION_BLEEDING)
		setConditionParam(t[a][b], CONDITION_PARAM_DELAYED, true)
		addDamageCondition(t[a][b], math.ceil(a / 3 + b / 3), 9000, -10)
	end
end

function onCastSpell(cid, var)
	if doCombat(cid, combat, var) then
		local target = variantToNumber(var)
		if target == 0 then
			target = getTopCreature(variantToPosition(var)).uid
		end
		if target == 0 then
			return false
		end
		return doTargetCombatCondition(cid, target, t[getPlayerLevel(cid)][getPlayerMagLevel(cid)], CONST_ME_NONE)
	end
end