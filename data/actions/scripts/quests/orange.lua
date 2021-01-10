function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(6006) == 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'The orange tree is empty.')
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have found an orange.')
		player:addItem(2675, 1)
		player:setStorageValue(6006, 1)
	end
	return true
end