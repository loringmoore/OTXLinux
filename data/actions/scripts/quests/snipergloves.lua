function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(6056) == 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'The dead tree is empty.')
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have found a pair of sniper gloves.')
		player:addItem(5247, 1)
		player:setStorageValue(6056, 1)
	end
	return true
end