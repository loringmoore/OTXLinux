local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

local condition = Condition(CONDITION_ENERGY)
condition:setTicks(8000)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:setParameter(CONDITION_PARAM_TICKINTERVAL, 2000)

function onGetFormulaValues(player, skill, attack, factor)
	local swordSkill = player:getEffectiveSkillLevel(SKILL_SWORD)
	local min = swordSkill * 0
	local max = swordSkill * 2.96
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local function UseWeapon(cid, var)
    local player = Player(cid)
    local level = player:getLevel()
    local maglevel = player:getMagicLevel()
    min = -((level / 5) + (maglevel * 0.4) + 2)
    max = -((level / 5) + (maglevel * 0.9) + 7)
    condition:setParameter(CONDITION_PARAM_PERIODICDAMAGE, math.random(min,max))
    combat:setCondition(condition)
	return true
    end
   
function onUseWeapon(creature, var)
    UseWeapon(creature:getId(), var)
    return combat:execute(creature, var)
end