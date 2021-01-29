function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(6010) == 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'The chest is empty.')
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have found a bright sword.')
		player:addItem(2407, 1)
		player:setStorageValue(6010, 1)
	end
	return true
end