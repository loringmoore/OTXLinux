function onSay(player, words, param, item, fromPosition, target, toPosition, isHotkey)
    if not target or not target:isPlayer() then
        return false
    end
	
    local mana, magiclevel = player:getMaxMana(), player:getMagicLevel()
    local min = 100 + (magiclevel * 2.7)
    local max = 175 + (magiclevel * 3.6)

    local mana = math.random(min, max)
	
	target:say("Aaaah...", TALKTYPE_MONSTER_SAY)
    target:addMana(mana)
    toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    return true
end