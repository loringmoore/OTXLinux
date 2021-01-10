function onSay(player, words, param)
	local party = player:getParty()
	if not party then
		player:sendCancelMessage("You are not in a party.")
		return false
	end
	
	if party:getLeader() ~= player then
		player:sendCancelMessage("You are not the leader of your party.")
		return false
	end
	
	if party:isSharedExperienceActive() then
		if player:getCondition(CONDITION_INFIGHT) then
			player:sendCancelMessage("You are in fight. Experience sharing not disabled.")
		else
			party:setSharedExperience(false)
		end
	else
		if player:getCondition(CONDITION_INFIGHT) then
			player:sendCancelMessage("You are in fight. Experience sharing not enabled.")
		else
			party:setSharedExperience(true)
		end
	end
		
	return false
end