local helmetIds = {5034, 2178, 5292, 2123, 5317}

function onAddItem(moveitem, tileitem, position)

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

	
	Game.createItem(5784, 1, position)
	position:sendMagicEffect(CONST_ME_FIREATTACK)
	return true
end