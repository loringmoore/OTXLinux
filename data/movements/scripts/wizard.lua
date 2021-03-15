local helmetIds = {5034, 2178, 5292, 2123, 5317}

function onAddItem(creature, moveitem, tileitem, position)
	
	local player = creature:getPlayer()
		if player == nil then
			return false
		end

	if not isInArray(helmetIds, moveitem.itemid) then
		return true
	end

	local tile, helmetItems = Tile(position), {}
	local helmetItem
	for i = 1, #helmetIds do
		helmetItem = tile:getItemById(helmetIds[i])
		if not helmetItem then
			return true
		end

		helmetItems[#helmetItems + 1] = helmetItem
	end

	for i = 1, #helmetItems do
		helmetItems[i]:remove()
	end

	player:setStorageValue(6077, 1)
	position:sendMagicEffect(CONST_ME_FIREATTACK)
	return true
end


