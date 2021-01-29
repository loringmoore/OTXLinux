function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
    local playerPos = player:getPosition()
    if Tile(playerPos):hasFlag(TILESTATE_PROTECTIONZONE) then
        playerPos:sendMagicEffect(CONST_ME_POFF)
        return true
    end
	
	if Tile(playerPos):hasFlag(TILESTATE_NOPVPZONE) then
		Game.createMonster("Thul", player:getPosition())
		item:remove(1)
	else
		player:sendCancelMessage("You may only use this item in a non-PvP zone.")	
	return true
	end
end