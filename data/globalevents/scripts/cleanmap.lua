local function saveServer()
	cleanMap()
	broadcastMessage("Map clean completed. Next clean will occur in 2 hours.", MESSAGE_STATUS_CONSOLE_RED)
end

function onThink(interval)
	broadcastMessage("Cleaning map in 5 minutes.", MESSAGE_STATUS_WARNING)
	addEvent(saveServer, 5 * 60 * 1000)
	return true
end
