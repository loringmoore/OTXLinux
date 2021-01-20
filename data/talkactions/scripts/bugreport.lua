local config = {
    storage = 6707,
    cooldown = 10,
    file = "data/logs/bugs.log"
}

function onSay(player, words, param)
    local file = io.open(config.file, "a")
    if not file then
        print(string.format("Warning: Could not open %s", config.file))
        return true
    end

    local split = param:split(",")
    local action = split[1]
  
    if (action == nil) then
        return true
    end
  
    if player:getStorageValue(config.storage) >= os.time() then
        player:sendTextMessage(MESSAGE_INFO_DESCR, string.format('You must wait %d seconds to use this command again', config.cooldown))
        return false
    end
  
    io.output(file)
    io.write("------------------------------\n")
    local position = player:getPosition()
    player:sendTextMessage(MESSAGE_INFO_DESCR, string.format('[%s] - Player %s reported a bug at %d, %d, %d with description: %s.', os.date("%c"), player:getName(), position.x, position.y, position.z, param))
    player:setStorageValue(config.storage, os.time() + config.cooldown)
    player:sendCancelMessage("Your report has been received successfully!")
    return false
end