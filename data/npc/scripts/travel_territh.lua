local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)            npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)        npcHandler:onCreatureDisappear(cid)            end
function onCreatureSay(cid, type, msg)        npcHandler:onCreatureSay(cid, type, msg)        end
function onThink()                npcHandler:onThink()                    end

-- Travel
local function addTravelKeyword(keyword, cost, destination, action)
    local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Do you seek a seek a passage to ' .. keyword:titleCase() .. ' for |TRAVELCOST|?', cost = cost, discount = 'postman'})
        travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = true, cost = cost, discount = 'postman', destination = destination}, nil, action)
        travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'We would like to serve you some time.', reset = true})
end

addTravelKeyword('gravenport', 130, Position(529, 978, 6), function(player) if player:getStorageValue(Storage.postman.Mission01) == 3 then player:setStorageValue(Storage.postman.Mission01, 4) end end)
addTravelKeyword('crescent isle', 160, Position(472, 690, 6))
addTravelKeyword('madrissa', 110, Position(1094, 632, 6))
addTravelKeyword('thunder cove', 160, Position(1065, 1202, 6))
addTravelKeyword('rhymveil', 120, Position(778, 125, 6))

-- Kick
-- keywordHandler:addKeyword({'kick'}, StdModule.kick, {npcHandler = npcHandler, destination = {Position(33174, 31773, 6), Position(33175, 31771, 6), Position(33177, 31772, 6)}})

-- Basic
keywordHandler:addKeyword({'sail'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To Gravenport, Madrissa, Crescent Isle, Thunder Cove or Rhymveil?'})
keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To Gravenport, Madrissa, Crescent Isle, Thunder Cove or Rhymveil?'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'I am the captain of this vessel.'})
keywordHandler:addKeyword({'here'}, StdModule.say, {npcHandler = npcHandler, text = 'This is Madrissa. Where do you want to go?'})
keywordHandler:addKeyword({'territh'}, StdModule.say, {npcHandler = npcHandler, text = 'We\'re already there.}'})

npcHandler:setMessage(MESSAGE_GREET, 'Welcome on board, |PLAYERNAME|. Where may I sail you today?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())