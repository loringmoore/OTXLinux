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
		if player:getStorageValue(6071) < 1 then
			npcHandler:say("My outfit is quite special, it is proof of my abilities in combat.", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "combat") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("A warrior is relentless in combat. If you can prove your skill as a fighter to me, I'll reward you with an outfit of your own. What do you say?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "scales") then
		if player:getStorageValue(6071) == 1 then
			npcHandler:say("Did you slay enough dragons to collect 50 green and 50 red dragon scales?", cid)
			npcHandler.topic[cid] = 4
		end
	elseif msgcontains(msg, "sweat") then
		if player:getStorageValue(6071) == 2 then
			npcHandler:say("Did you collect 10 flasks of warrior's sweat?", cid)
			npcHandler.topic[cid] = 5
		end
	elseif msgcontains(msg, "sword") then
		if player:getStorageValue(6071) == 3 then
			npcHandler:say("Did you collect 30 iron ores and a piece of hell steel?", cid)
			npcHandler.topic[cid] = 6
		end
	elseif msgcontains(msg, "ultimate test") then
		if player:getStorageValue(6071) == 4 then
			npcHandler:say("Did you slay Massacre in combat and bring back a piece of his shell?", cid)
			npcHandler.topic[cid] = 7
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say({
				"I admire your desire! First, slay enough dragons to bring me 50 red and 50 green dragon scales. ...",
				"Next, bring me 10 flasks of warrior's sweat. ...",
				"You will need to provide the materials for the sword. Bring me 30 iron ores and a piece of hell steel. ...",	
				"Finally, for your ultimate test, slay the demon Massacre and bring me back a piece of his shell. ...",
				"Are you prepared to prove yourself a true warrior?"
			}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("Then go forth, |PLAYERNAME|, and come back when you have finished your task.", cid)
			player:setStorageValue(6071, 1)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:getItemCount(5254) >= 50 and player:getItemCount(5286) >=50 then
				npcHandler:say("Very good, |PLAYERNAME|. Not just anyone can kill a dragon! You are already showing signs of a warrior's spirit.", cid)
				player:removeItem(5254, 50)
				player:removeItem(5286, 50)
				player:setStorageValue(6071, 2)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Get back out there and find the necessary items to complete your task.", cid)
			end
		elseif npcHandler.topic[cid] == 5 then
			if player:removeItem(5256, 10) then
				npcHandler:say("Wonderfully done, |PLAYERNAME|. Warrior's sweat is a rare and magical substance.", cid)
				player:setStorageValue(6071, 3)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Get back out there and find the necessary items to complete your task.", cid)
			end
		elseif npcHandler.topic[cid] == 6 then
			if player:removeItem(5252, 30) and player:removeItem(5259, 1) then
				npcHandler:say("These ores will be enough to craft a fine, strong blade.", cid)
				player:setStorageValue(6071, 3)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Get back out there and find the necessary items to complete your task.", cid)
			end
		elseif npcHandler.topic[cid] == 7 then
			if player:removeItem(5305, 1) then
				npcHandler:say("Truly incredible, |PLAYERNAME|! You are a true warrior in my eyes.", cid)
				player:setStorageValue(6071, 4)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Get back out there and find the necessary items to complete your task.", cid)
			end
	elseif msgcontains(msg, "no") then
		if npcHandler.topic[cid] > 1 then
			npcHandler:say("I figured as much, you didn't look so tough anyway.", cid)
			npcHandler.topic[cid] = 0
		end
	end
	return true
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())