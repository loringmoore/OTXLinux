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
    if player:getStorageValue(storage) <= os.time() then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your report has been received successfully!")
        db.query("INSERT INTO  `znote_player_reports` (`id` ,`name` ,`posx` ,`posy` ,`posz` ,`report_description` ,`date`)VALUES (NULL ,  '" .. player:getName() .. "',  '" .. x .. "',  '" .. y .. "',  '" .. z .. "',  " .. db.escapeString(param) .. ",  '" .. os.time() .. "')")
        player:setStorageValue(storage,os.time()+delaytime)
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have to wait ".. player:getStorageValue(storage) - os.time().." seconds to report again.")
    end
    return false
end