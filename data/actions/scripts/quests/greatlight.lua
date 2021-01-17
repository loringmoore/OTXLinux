function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(6026) == 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'The tree is empty.')
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have found a scroll.')
		player:addItem(5444, 1)
		player:setStorageValue(6026, 1)
	end
	return true
end