local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)                          npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)                       npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)                  npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                                      npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid


    local travels = {
    ["gravenport"] = {talk=1, cost=130, level=0,  stor=false,  storId=1010, destination={x=529, y=978, z=6}},
    ["crescent isle"] = {talk=2, cost=160, level=0, stor=false,  storId=1010, destination={x=454, y=1003, z=6}},
    ["madrissa"] = {talk=3, cost=110, level=0, stor=false,  storId=1010, destination={x=472, y=690, z=6}},
    ["territh"] = {talk=4, cost=160, level=0, stor=false,  storId=1010, destination={x=1094, y=632, z=6}},
	["rhymveil"] = {talk=5, cost=120, level=0, stor=false,  storId=1010, destination={x=778, y=125, z=6}},
	["clandestia"] = {talk=6, cost=50, level=0, stor=true,  storId=6064, destination={x=768, y=1264, z=6}}
    }

    for k, v in pairs(travels) do
        if(msgcontains(msg, k)) then
            if v.stor then
                if getPlayerStorageValue(cid, v.storId) > 0 then
                    selfSay('Do you want to travel to '..k..' for '..v.cost..' gold coins?', cid)
                    talkState[talkUser] = v.talk
                    else
                        selfSay('Sorry, Clandestia isn\'t open for tourism right now', cid)
                        talkState[talkUser] = 0
                    end
                    else
                        selfSay('Do you want to travel to '..k..' for '..v.cost..' gold coins?', cid)
                        talkState[talkUser] = v.talk
                    end          
                elseif(msgcontains(msg, 'yes') and talkState[talkUser] == v.talk) then
                                if getPlayerLevel(cid) >= v.level then
                                        if(doPlayerRemoveMoney(cid, v.cost) == TRUE) then
                                                doTeleportThing(cid, v.destination, FALSE)
												doSendMagicEffect(v.destination, CONST_ME_TELEPORT)
                                        else
                                        selfSay('Sorry, you don\'t have enough gold coins.', cid)
                                        end
                                else
                                selfSay('Sorry, you don\'t have enough level.', cid)
                                end  
                talkState[talkUser] = 0
                elseif(msgcontains(msg, 'no') and isInArray({v.talk}, talkState[talkUser]) == TRUE) then
                        talkState[talkUser] = 0
                        selfSay('Ok then.', cid)
                end
        end  

        return true
end

-- Basic
keywordHandler:addKeyword({'sail'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To Gravenport, Madrissa, Crescent Isle, Territh, Clandestia or Rhymveil?'})
keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To Gravenport, Madrissa, Crescent Isle, Territh, Clandestia or Rhymveil?'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'I am the captain of this vessel.'})
keywordHandler:addKeyword({'here'}, StdModule.say, {npcHandler = npcHandler, text = 'This is Thunder Cove. Where do you want to go?'})
keywordHandler:addKeyword({'thunder cove'}, StdModule.say, {npcHandler = npcHandler, text = 'We\'re already there.}'})

npcHandler:setMessage(MESSAGE_GREET, 'Welcome on board, |PLAYERNAME|. Where may I sail you today?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())