function onUse(player, item, fromPosition, target, toPosition)
	
	local position = player:getPosition()
	local monster = "wolf"
	
	if math.random(100) > 97 then
		item:getPosition():sendMagicEffect(CONST_ME_SOUND_RED)
		game.createMonster(monster, position)
		monster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		item:getPosition():sendMagicEffect(CONST_ME_SOUND_YELLOW
	end
	return true
end

	