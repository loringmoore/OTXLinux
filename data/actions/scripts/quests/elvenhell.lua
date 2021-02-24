local destination = {x=948, y=970, z=9}

function onUse(player, item, target, toPosition, isHotkey)
	if item:getActionId() ~= 2032 then
		return false
	end

	player:teleportTo(destination)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end