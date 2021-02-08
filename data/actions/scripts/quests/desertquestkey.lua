function onUse(cid, item, fromPosition, target, toPosition, isHotkey)
	
	local player = Player(cid)
	
	if player:getStorageValue(6020) == 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'The mushroom is empty.')
	else
		player:setStorageValue(6020, 1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have found a copper key.')
		local key = player:addItem(2089, 1)
		if key then
			key:setActionId(3142)
		end
	end
	return true
end