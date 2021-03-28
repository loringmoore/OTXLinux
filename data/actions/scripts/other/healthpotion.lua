function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not target or not target:isPlayer() then
        return false
    end

    local health, magiclevel = player:getMaxHealth(), player:getMagicLevel()
    local min = (health * 0.12) * (magiclevel * 0.1)
    local max = (health * 0.15) * (magiclevel * 0.15)

    local health = math.random(min, max)
	
	target:say("Aaaah...", TALKTYPE_MONSTER_SAY)
    target:addHealth(health)
    toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	item:remove(1)
    return true
end