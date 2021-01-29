local config = {
	[2033] = {flamePosition = Position(572, 535, 11), toPosition = Position(572, 540, 11)}	
}

function onAddItem(moveitem, tileitem, position)
	local targetCoalBasin = config[tileitem.uid]
	if not targetCoalBasin then
		return true
	end

	if moveitem.itemid ~= 2159 then
		position:sendMagicEffect(CONST_ME_POFF)
		return true
	end

	moveitem:remove()
	position:sendMagicEffect(CONST_ME_HITBYFIRE)

	Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
	targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end