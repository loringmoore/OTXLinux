function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not target or not target:isPlayer() then
        return false
    end

    local health, magiclevel = player:getMaxHealth(), player:getMagicLevel()
    local min = 75 + (health * 0.07) * (magiclevel * 0.1)
    local max = 105 + (health * 0.10) * (magiclevel * 0.15)

    local health = math.random(min, max)
	
	target:say("Aaaah...", TALKTYPE_MONSTER_SAY)
    target:addHealth(health)
    toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	item:remove(1)
    return true
end