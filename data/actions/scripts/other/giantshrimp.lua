function onUse(player, item, fromPosition, target, toPosition)
	local position = player:getPosition()
	
	if Tile(playerPos):hasFlag(TILESTATE_PROTECTIONZONE) then
		playerPos:sendMagicEffect(CONST_ME_POFF)
		return true
	end
		
	Game.createMonster("Thul", playerPos)
	playerPos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	item:remove(1)
	return true
end	