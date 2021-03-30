function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(6013) == 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'The chest is empty.')
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have found a magic longsword.')
		player:addItem(2390, 1)
		player:setStorageValue(6013, 1)
	end
	return true
end