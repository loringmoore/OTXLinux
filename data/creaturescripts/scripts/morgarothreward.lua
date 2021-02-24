local portalId, t = 1387,
{
    ["morgaroth"] = {
        message = "Morgaroth has been defeated!",
        config = {
            createPos = {x = 1059, y = 437, z = 13},
            toPos = {x = 1056, y = 435, z = 13},
            portalTime = 1, --minutes
        }
    },
}
 
local function removePortal(position)
    local portal = Tile(position):getItemById(portalId)
    if portal then
        portal:remove()
    end
end
 
function onKill(creature, target, player, cid)
    if not target:isMonster() or target:getMaster() then
        return true
    end
    
    local player = Player(cid)
    local k = t[target:getName():lower()]
    if not k then
        return true
    end
    
    local pos, cPos = target:getPosition()
    if type(k.config.createPos) == 'table' then
        if next(k.config.createPos) == nil then
            cPos = pos
        else
            cPos = k.config.createPos
        end
    end
 
    local item = Game.createItem(portalId, 1, cPos)
    if item:isTeleport() then
        item:setDestination(k.config.toPos)
    end
 	
	local player = Player(cid)
    local pt = k.config.portalTime
    addEvent(removePortal, k.config.portalTime * 60 * 1000, cPos)
    return true
end