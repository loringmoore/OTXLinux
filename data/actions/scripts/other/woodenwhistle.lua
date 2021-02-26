function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
    local playerPos = player:getPosition()
    if Tile(playerPos):hasFlag(TILESTATE_PROTECTIONZONE) then
        playerPos:sendMagicEffect(CONST_ME_POFF)
        return true
    end
	
	if math.random(100) > 97 then
		item:getPosition():sendMagicEffect(CONST_ME_SOUND_RED)
		Game.createMonster("wolf", player:getPosition())
		item:remove(1)
	else
		item:getPosition():sendMagicEffect(CONST_ME_SOUND_YELLOW)	
	return true
	end
end