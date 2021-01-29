function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	if item:getActionId() ~= 1000  then
		return false
	end	
		
	if item:getActionId() == 101 and player:getStorageValue(6032) == 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'The ice is empty.')
	else if item:getActionId() == 101 and player:getStorageValue(6032) == 0 then
		player:setStorageValue(6032, 1)
		player:addItem(5436, 1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have found a scroll.')
		toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	end
		return true
	end
end