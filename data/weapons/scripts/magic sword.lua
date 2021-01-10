local combat = createCombatObject()
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)

local config = {
    weapon_type = 'sword', --Options: 'sword' 'axe' 'club' 'distance' 'magic'
    percent_heal_health = 10, --15 percent is added
    combat_type = 'physical', --Options: energy, poison, fire, undefined, lifedrain, manadrain
}
function onUseWeapon(player, var)
    if config.weapon_type == 'sword' then
        SKILL = SKILL_SWORD
    elseif config.weapon_type == 'axe' then
        SKILL = SKILL_AXE
    elseif config.weapon_type == 'club' then
        SKILL = SKILL_CLUB
    elseif config.weapon_type == 'distance' then
        SKILL = SKILL_DISTANCE
    end
   
    if config.combat_type == 'energy' then
        COMBAT = COMBAT_ENERGYDAMAGE
    elseif config.combat_type == 'poison' then
        COMBAT = COMBAT_POISONDAMAGE
    elseif config.combat_type == 'fire' then
        COMBAT = COMBAT_FIREDAMAGE
    elseif config.combat_type == 'undefined' then
        COMBAT = COMBAT_UNDEFINEDDAMAGE
    elseif config.combat_type == 'lifedrain' then
        COMBAT = COMBAT_LIFEDRAIN
    elseif config.combat_type == 'manadrain' then
        COMBAT = COMBAT_MANADRAIN
    elseif config.combat_type == 'physical' then
        COMBAT = COMBAT_PHYSICALDAMAGE
    end
 
    if SKILL then
        dmg_min = (player:getSkillLevel(SKILL) * 0)
        dmg_max = (player:getSkillLevel(SKILL) * 3.95)
    else
        dmg_min = (player:getMagicLevel() * 2) + (player:getLevel())
        dmg_max = (player:getMagicLevel() * 2) + (player:getLevel() + 20)
    end

    dmg_amount = math.random(dmg_min, dmg_max)
    heal_amount = (config.percent_heal_health / 100) * dmg_amount
    target = Creature(variantToNumber(var))
    player:addMana(heal_amount)
	player:addHealth(heal_amount)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	doTargetCombatHealth(player, target, COMBAT, -dmg_amount, -dmg_amount)
    doCombat(player, combat, var)
    return true
end