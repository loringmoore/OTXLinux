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
	if msgcontains(msg, "outfit") then
		if player:getStorageValue(6081) < 1 then
			npcHandler:say("You like it? This is typical dress for a son or daughter of the desert!", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "desert") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("The desert isn't all that bad of a place, you just need to know how to dress. If you're willing to collect some items, I'll have Irma turn them into an outfit for you, how's that?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "cloth") then
		if player:getStorageValue(6081) == 1 then
			npcHandler:say("Did you collect 25 yellow, green, red and white pieces of cloth?", cid)
			npcHandler.topic[cid] = 4
		end
	elseif msgcontains(msg, "metal") then
		if player:getStorageValue(6081) == 2 then
			npcHandler:say("Did you collect a violet, blue, red, yellow and green gem and 30 iron ores?", cid)
			npcHandler.topic[cid] = 5
		end
	elseif msgcontains(msg, "voice") or msgcontains(msg, "note") then
		if player:getStorageValue(6081) == 3 then
			npcHandler:say("Did you find a blue note?", cid)
			npcHandler.topic[cid] = 6
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say({
				"Wonderful! I'll tell you what you need. ...",
				"Fine cloth is the key to comfortable desert attire. Bring me 25 yellow, green, red and white pieces of cloth. ...",
				"Next, you need a traditional ornament. Men typically wear a scimitar and women wear a jewelled belt. Bring me a violet, blue, red, yellow and gren gem as well as 30 iron ores. ...",
				"Finally, to prove you are in tune with the voice of the desert, bring me a blue note. ...",
				"Do you think you can handle all of this, |PLAYERNAME|?"
			}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("Good luck, |PLAYERNAME|!", cid)
			player:setStorageValue(6081, 1)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:removeItem(5277, 25) and player:removeItem(5278, 25) and player:removeItem(5279, 25) and player:removeItem(5282, 25) then
				npcHandler:say("Thank you, |PLAYERNAME|, now bring me the gems and ores.", cid)
				player:setStorageValue(6081, 2)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("You don't everything you need.", cid)
			end
		elseif npcHandler.topic[cid] == 5 then
			if player:removeItem(2153, 1) and player:removeItem(2154, 1) and player:removeItem(2155, 1) and player:removeItem(2156, 1) and player:removeItem(2158, 1) and player:removeItem(5252, 30) then
				npcHandler:say("Thank you, |PLAYERNMAE|, the cut on these gems is fantastic. All that's left is the blue note!", cid)
				player:setStorageValue(6081, 3)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("You don't everything you need.", cid)
			end
		elseif npcHandler.topic[cid] == 6 then
			if player:getItemCount(2349) >= 1 then
				npcHandler:say("Fantastic job! Now go see Irma about crafting your outfit", cid)
				player:setStorageValue(6081, 4)
				player:removeItem(2340, 1)
			else
				npcHandler:say("You don't the thing you need.", cid)
			end
	elseif msgcontains(msg, "no") then
		if npcHandler.topic[cid] > 1 then
			npcHandler:say("Then I guess you aren't desert material!", cid)
			npcHandler.topic[cid] = 0
		end
	end
	return true
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())