local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)            npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)        npcHandler:onCreatureDisappear(cid)            end
function onCreatureSay(cid, type, msg)        npcHandler:onCreatureSay(cid, type, msg)        end
function onThink()                npcHandler:onThink()                    end



-- Travel
local function addTravelKeyword(keyword, cost, destination, action)
    local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Do you seek a passage to Jaarsk for |TRAVELCOST|?', cost = cost, discount = 'postman'})
        travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = true, cost = cost, discount = 'postman', destination = destination}, nil, action)
        travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'We would like to serve you some time.', reset = true})
end

addTravelKeyword('passage', 160, Position(387, 264, 7))


-- Kick
-- keywordHandler:addKeyword({'kick'}, StdModule.kick, {npcHandler = npcHandler, destination = {Position(33174, 31773, 6), Position(33175, 31771, 6), Position(33177, 31772, 6)}})

-- Basic
keywordHandler:addKeyword({'sail'}, StdModule.say, {npcHandler = npcHandler, text = 'I can take you to Jaarsk if you like.'})
keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'I can take you to Jaarsk if you like.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'I am the captain of this ship.'})
keywordHandler:addKeyword({'here'}, StdModule.say, {npcHandler = npcHandler, text = 'This is Rhymveil.'})


npcHandler:setMessage(MESSAGE_GREET, 'Hello, |PLAYERNAME|. Would you like a passage?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, stay warm!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())