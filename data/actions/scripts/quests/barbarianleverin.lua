local destination = {x=315, y=338, z=7}    -- Change your destination here.
local stand = {x=313, y=336, z=7} -- tile where player must stand

function onUse(cid, item, fromPosition, itemEx, toPosition)

local creature = getTopCreature(stand).uid

if not creature or not isPlayer(creature) then      
    doPlayerSendCancel(cid, "A player must stand on the tile first.")
    return true
end


doTeleportThing(creature, destination, false)
doTransformItem(item.uid, item.itemid == 1945 and 1946 or 1945)
doSendMagicEffect(getPlayerPosition(creature), CONST_ME_TELEPORT)

return true
end