local teleports = {
	[2250] = Position(602, 565, 8),
}

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	
	if math.random(10) == 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have been roped!')
		player:teleportTo(teleports[item.uid])
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		return false
	end
	return true
end