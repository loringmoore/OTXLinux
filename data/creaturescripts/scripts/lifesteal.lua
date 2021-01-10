local cfg = {
    weaponId = 2421,
    chance = 10,
    percent = 10
}
 
function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    local damage = primaryDamage + secondaryDamage
    if attacker:isPlayer() then
        if math.random(100) <= cfg.chance then
            local weapon = attacker:getSlotItem(CONST_SLOT_LEFT)
            if weapon and weapon:getId() == cfg.weaponId then
                attacker:addHealth(damage * (cfg.percent/100))
            end
        end
    end
    creature:unregisterEvent("lifesteal")
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end