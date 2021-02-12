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
			npcHandler:say("What you see in front of you is traditional barbarian garb! You clearly aren't of barbarian blood, but anyone who is willing to complete the barbarian rite of passage can be adopted as a son or daughter of the North.", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "rite of passage") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("Every barbarian must pass through the same trials to achieve recognition in our society. If you're truly interested, I will explain in greater detail.", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "fur") then
		if player:getStorageValue(6071) == 1 then
			npcHandler:say("Did you collect 100 pieces of ape fur?", cid)
			npcHandler.topic[cid] = 4
		end
	elseif msgcontains(msg, "wig") then
		if player:getStorageValue(6071) == 2 then
			npcHandler:say("Were you able to pilfer a complete pirate uniform?", cid)
			npcHandler.topic[cid] = 5
		end
	elseif msgcontains(msg, "axe") then
		if player:getStorageValue(6071) == 3 then
			npcHandler:say("Did you track down and kill Captain Ironblade?", cid)
			npcHandler.topic[cid] = 6
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say({
				"Very well. First, you must collect enough fur to fashion clothes that will protect you from the cold. Ape fur is an excellent insulator, but you will need 100 pieces to have enough material for a whole outfit. ...",
				"The wig that we wear is woven from giant spider's silk. As you can see it is quite ornate, and you will need 10 spools of yarn to craft one of your own. ...",
				"Next, you will need to collect enough honeycomb to mash into a strong glue for the traditional barbarian wig. This is a tedious process, and will require you to collect 100 honeycombs. ...",	
				"Finally, for the axe you see on my back, you will need to bring 3 huge chunks of crude iron. ...",
				"Do you still think you have what it takes to become a barbarian?"
			}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("Then go forth, |PLAYERNAME|, and come back when you have finished your task.", cid)
			player:setStorageValue(6071, 1)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:getItemCount(5255) >= 100 then
				npcHandler:say("Well done, |PLAYERNAME|. All of this fine fur will surely keep you warm in even the harshest winter!", cid)
				player:removeItem(5255, 100)
				player:setStorageValue(6071, 2)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Get back out there and find the necessary items to complete your task.", cid)
			end
		elseif npcHandler.topic[cid] == 5 then
			if player:removeItem(5271, 100) and player:removeItem(5257, 10) then
				npcHandler:say("You faring better than I imagined! With these honeycombs and spools of yarn you will have an authentic barbarian wig.", cid)
				player:setStorageValue(6071, 3)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Get back out there and find the necessary items to complete your task.", cid)
			end
		elseif npcHandler.topic[cid] == 6 then
			if player:removeItem(5262, 3) then
				npcHandler:say("Congratulations, |PLAYERNAME|! You have proven yourself worthy of the barbarian and title and deserve to wear this authentic barbarian outfit.", cid)
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