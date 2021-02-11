local t = {
	Position(696, 544, 4), -- bars position
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 1945 then
		local tile = t[1]:getTile()
		if tile then
			local stone = tile:getItemById(3519)
			if stone then
				stone:remove()
			end
		end
		
	elseif item.itemid == 1946 then
		Game.createItem(3519, 1, t[1])
	end
	return item:transform(item.itemid == 1945 and 1946 or 1945)
end