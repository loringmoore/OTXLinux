function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(6020) == 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'The mushroom is empty.')
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have found a copper key.')
		player:addItem(2089, 5821)
		player:setStorageValue(6020, 1)
	end
	return true
end