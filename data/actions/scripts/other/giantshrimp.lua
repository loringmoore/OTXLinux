function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    Game.createMonster("Thul", player:getPosition())
	item:remove(1)
    return true
end