--local area = createCombatArea({
--{0, 0, 1, 1, 1, 0, 0},
--{0, 1, 1, 1, 1, 1, 0},
--{1, 1, 1, 1, 1, 1, 1},
--{1, 1, 1, 3, 1, 1, 1},
--{1, 1, 1, 1, 1, 1, 1},
--{0, 1, 1, 1, 1, 1, 0},
--{0, 0, 1, 1, 1, 0, 0}
--})

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
--combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_CRYSTALARROW)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, false)
combat:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 1, 0)
--combat:setArea(area)

function onUseWeapon(player, variant)
	return combat:execute(player, variant)
end
