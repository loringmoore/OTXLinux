local destination = {x=1020, y=552, z=6}

function onUse(player, item, target, toPosition, isHotkey)
	if item:getActionId() ~= 2033 then
		return false
	end

	player:teleportTo(destination)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end