function onPrepareDeath(creature)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	local amuletItem = player:getSlotItem(CONST_SLOT_NECKLACE)
	if not amuletItem or amuletItem:getId() ~= 2196 then
		return true
	end
	
	local health = player:getMaxHealth()
	
	player:addHealth(health)
	amuletItem:remove()
	return false
end