local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if msgcontains(msg, "help") then
		if player:getStorageValue(6051) < 1 then
			npcHandler:say("Say...maybe I could use your help. Listen - if you do me a favor, I'll put in a good word for you with a demon buddy of mine who works as a master blacksmith in Gravenport.", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "favor") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("Right, I need something to rejuvinate my inner demon. I think some demonic essences should do the trick. Do you think you could go retrieve some for me?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "demonic essences") then
		if player:getStorageValue(6051) == 1 then
			npcHandler:say("Did you collect 10 demonic essences for me?", cid)
			npcHandler.topic[cid] = 4
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say({"Hot dog! Let's see..10 essences should be enough. Are you still in?"}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("YES! What are you waiting for? Go and get me those essences!", cid)
			player:setStorageValue(6051, 1)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:removeItem(5032, 10) then
				npcHandler:say("Ahh, yes, YES! I can almost hear the screams of tormented souls just holding them in my hand! Well, you did what I asked, I'll put in a good word with my buddy in Gravenport. Bring him rare armors and he'll compensate you handsomely!", cid)
				player:setStorageValue(1023, 1)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("You didn't bring enough!", cid)
			end
		end
	elseif msgcontains(msg, "no") then
		if npcHandler.topic[cid] > 1 then
			npcHandler:say("Then screw right off!", cid)
			npcHandler.topic[cid] = 0
		end
	return true
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())