function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(6039) == 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'The chest is empty.')
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have found a dragon shield.')
		player:addItem(2516, 1)
		player:setStorageValue(6039, 1)
	end
	return true
end