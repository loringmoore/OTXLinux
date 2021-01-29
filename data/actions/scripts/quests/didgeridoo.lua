function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(6059) == 1 then
		item:getPosition():sendMagicEffect(CONST_ME_SOUND_GREEN)
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'Nightmarish images swim across your vision...')
		item:getPosition():sendMagicEffect(CONST_ME_SOUND_PURPLE)
		player:setStorageValue(6059, 1)
	end
	return true
end