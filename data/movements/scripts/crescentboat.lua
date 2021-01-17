local failPosition = Position(453, 1007, 6)

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getLevel() >= 10 then
		return true
	end

	player:teleportTo(failPosition)
	failPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You need to be at least Level 10 to sail!')
	return true
end