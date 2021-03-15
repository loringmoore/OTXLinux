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
		if player:getStorageValue(6091) < 1 then
			npcHandler:say("You want to help me sleep? I appreciate the concern but sleeping isn't something you can do for me, I need to do it myself. I just can't get comfortable down here!", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "comfortable") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("Hey...maybe there is something you can do to help me. I saw a big red pillow in the shape of a heart for sale once...do you think you could bring me one?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "pillow") then
		if player:getStorageValue(6091) == 1 then
			npcHandler:say("Did you find something that will help me rest?", cid)
			npcHandler.topic[cid] = 4
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say({
				"Right on! If you bring me back a pillow, I'll let you pass through to the dungeon below. ...",
				"Do you think you can do that for me?"
			}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("Hurry back, |PLAYERNAME|!", cid)
			player:setStorageValue(6091, 1)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:removeItem(1685, 1) then
				npcHandler:say("Oh my, it's so soft! I'm going to to take a much-needed nap. You may proceed into the dungeon if you wish.", cid)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				player:setStorageValue(6092, 1)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Are you trying to torture me?", cid)
			end
	elseif msgcontains(msg, "no") then
		if npcHandler.topic[cid] > 1 then
			npcHandler:say("Why are you wasting my time then?", cid)
			npcHandler.topic[cid] = 0
		end
	end
	return true
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())