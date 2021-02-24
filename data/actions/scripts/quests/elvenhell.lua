local destination = {x=948, y=970, z=9}    -- Change your destination here.

function onUse(cid, item, fromPosition, itemEx, toPosition)

doTeleportThing(creature, destination, false)
doSendMagicEffect(getPlayerPosition(creature), CONST_ME_TELEPORT)

return true
end