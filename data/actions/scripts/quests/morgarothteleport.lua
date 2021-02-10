function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	--first lever to open the ladder
	if item.actionid == 2018 then
		local portaltile = Tile(Position({x = 1059, y = 467, z = 13}))
		if item.itemid == 1945 then
			if portaltile:getItemById(1387) then
				portaltile:getItemById(1387):remove()
			else
				local portal = Game.createItem(1387, 1, {x = 1059, y = 467, z = 13})
				if portal then
					portal:setActionId(2019)
				end
				item:transform(1946)
			end
		else
			if portaltile:getItemById(1387) then
				portaltile:getItemById(1387):remove()
				item:transform(1945)
			end
		end
	end
	return true
end