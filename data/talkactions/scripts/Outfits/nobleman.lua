function onSay(player, words)
	
	local position = player:getPosition()
	
	if player:getStorageValue(6021) < 1 then
		player:sendCancelMessage("You have not earned this outfit.")
			position:sendMagicEffect(CONST_ME_POFF)
			return false
		end
	
	local outfit1 = player:getOutfit()
        outfit1.lookType = 197
	local outfit0 = player:getOutfit()
		outfit0.lookType = 226
	if player:getSex() == PLAYERSEX_FEMALE then
        player:setOutfit(outfit0)
		else
		player:setOutfit(outfit1)
		end
	return false
end