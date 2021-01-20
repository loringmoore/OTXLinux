function onSay(player, words, param)
    local storage = 67081 -- (You can change the storage if its already in use)
    local delaytime = 30 -- (Exhaust In Seconds.)
    local x = player:getPosition().x -- (Do not edit this.)
    local y = player:getPosition().y -- (Do not edit this.)
    local z =  player:getPosition().z -- (Do not edit this.)
    if (param == '') then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Command param required.")
        return false
    end
 
    return false
end