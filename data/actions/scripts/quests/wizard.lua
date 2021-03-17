function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(6077) == 1 then
        player:sendCancelMessage("You have already earned this outfit.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
    else
        player:setStorageValue(6077, 1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have earned the wizard outfit.")
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		item:remove(1)
    end
    return true
end