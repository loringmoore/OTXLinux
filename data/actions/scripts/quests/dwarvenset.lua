local t = {
	Position(363, 906, 8), -- bars position
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 1945 then
		local tile = t[1]:getTile()
		if tile then
			local stone = tile:getItemById(1544)
			if stone then
				stone:remove()
			end
		end
		
	elseif item.itemid == 1946 then
		Game.createItem(1544, 1, t[1])
	end
	return item:transform(item.itemid == 1945 and 1946 or 1945)
end