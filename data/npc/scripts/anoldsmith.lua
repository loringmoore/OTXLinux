local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)
	npcHandler:onCreatureAppear(cid)
end
function onCreatureDisappear(cid)
	npcHandler:onCreatureDisappear(cid)
end
function onCreatureSay(cid, type, msg)
	npcHandler:onCreatureSay(cid, type, msg)
end
function onThink()
	npcHandler:onThink()
end
local function greetCallback(cid)
	if getPlayerStorageValue(cid, 1023) ~= 1 then
        npcHandler:say("Who do you think you are, barging in uninvited? Get out!", cid)
        return false
	else
		 npcHandler:say("Ah yes, you must be the one Chyros told me about! Welcome to my forge, |PLAYERNAME|.", cid)
    end
    return true
end
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:addModule(FocusModule:new())