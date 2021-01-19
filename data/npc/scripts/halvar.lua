local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

-- Travel
-- addTravelKeyword('peg leg', 'Ohhhh. So... <lowers his voice> \'you know who\' sent you so I sail you to \'you know where\'. <wink> <wink> It will cost |TRAVELCOST| to cover my expenses. Is it that what you wish?', 50, Position(32348, 32625, 7), function(player) return player:getStorageValue(Storage.TheShatteredIsles.AccessToMeriana) == 1 end)
addTravelKeyword('Jaarsk', 'Do you seek a passage to Jaarsk for |TRAVELCOST|?', 150, Position(387, 264, 7))

keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To Jaarsk?'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'I am the captain of this ship.'})
keywordHandler:addKeyword({'captain'}, StdModule.say, {npcHandler = npcHandler, text = 'I am the captain of this ship.'})

npcHandler:setMessage(MESSAGE_GREET, "Greetings, daring adventurer. If you need a passage, let me know.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Oh well.")
npcHandler:addModule(FocusModule:new())