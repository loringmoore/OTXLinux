function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(6067) ~= 1 then
		player:setStorageValue(6067, 1)
		player:getPosition():sendMagicEffect(CONST_ME_FIREATTACK)
		Game.createMonster('Warlock', Position(1062, 402, 6), false, true)
		Game.createMonster('Warlock', Position(1066, 402, 6), false, true)
	else
		fromPosition:sendMagicEffect(CONST_ME_POFF)
	end
	return true
end