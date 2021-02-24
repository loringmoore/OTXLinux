local teleportToPosition = Position(1056, 435, 14)
local teleportCreatePosition = Position(1059, 437, 13)
local bossName = "Morgaroth"
local killMessage = "Morgaroth has been defeated! You have 60 seconds to enter the portal and claim your reward!"

-- Function that will remove the teleport after a given time
local function removeTeleport(position)
    local teleportItem = Tile(position):getItemById(1387)
    if teleportItem then
        teleportItem:remove()
        position:sendMagicEffect(CONST_ME_POFF)
    end
end

function onKill(creature, target)
    if target:isPlayer() or target:getMaster()  or target:getName():lower() ~= bossName then
        return true
    end

    local position = target:getPosition()
    position:sendMagicEffect(CONST_ME_TELEPORT)
    local item = Game.createItem(1387, 1, teleportCreatePosition)
    if item:isTeleport() then
        item:setDestination(teleportToPosition)
    end
    target:say(killMessage, TALKTYPE_MONSTER_SAY, 0, 0, position)

    -- Remove portal after 1 minute
    addEvent(removeTeleport, 1 * 60 * 1000, position)

    return true
end