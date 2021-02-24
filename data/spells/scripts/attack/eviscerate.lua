local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREWORK_RED)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_THROWINGKNIFE)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setArea(createCombatArea(AREA_CROSS1X1))


function onGetFormulaValues(player, skill, attack, factor)
	local distSkill = player:getEffectiveSkillLevel(SKILL_DISTANCE)
	local min = (player:getLevel() / 5) + distSkill * 3.3
	local max = (player:getLevel() / 5) + distSkill * 6.2
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
