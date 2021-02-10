function onStepIn(creature, item, position, fromPosition)
	-- created portal (by lever)
	if item.actionid == 2019 then
		local player = creature:getPlayer()
		if not player then
			return true
		end

		player:teleportTo(Position(1059, 464, 13))
		position:sendMagicEffect(CONST_ME_TELEPORT)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end