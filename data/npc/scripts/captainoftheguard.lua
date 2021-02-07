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
		if player:getStorageValue(6065) < 1 then
			npcHandler:say("My helmet and sword? I'm afraid I can't just give them away. However, if you can prove to me that you posess the strength of a Knight, I'll take some time out of my busy schedule to craft an outfit for you.", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "knight") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("This helmet and sword aren't just for looks - they will serve you well in battle! Are you ready to do begin?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "helmet") then
		if player:getStorageValue(6065) == 1 then
			npcHandler:say("Did you find 2 tusks and a piece of royal steel?", cid)
			npcHandler.topic[cid] = 4
		end
	elseif msgcontains(msg, "valor") then
		if player:getStorageValue(6065) == 2 then
			npcHandler:say("Did you bring me 50 demonic essences, 30 behemoth fangs and 15 behemoth claws?", cid)
			npcHandler.topic[cid] = 5
		end
	elseif msgcontains(msg, "sword") then
		if player:getStorageValue(6065) == 3 then
			npcHandler:say("Did bring me 50 iron ores and a sword hilt?", cid)
			npcHandler.topic[cid] = 6
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say({
				"I see. First, I will need you to collect 2 tusks for the helmet adornment. These need to be tusks of fine ivory, only obtainable from fully-grown elephants and mammoths. ...",
				"I'll need a piece of royal steel to forge the helmet from. Find and bring me a piece of this rare metal. ...",
				"A true Knight is forever dedicated to keeping evil forces at bay. Slay enough demons to collect 50 of their essence and bring them to me as proof of your valor. ...",
				"The behemoths deep below the mountain to the east are growing bolder by the day. Go put them in their place by thinning their ranks, and bring me back 30 of their fangs and 15 of their claws. ...",
				"I will need a lot of iron ore to forge the blade of the sword. 50 pieces should be plenty. ...",
				"There are tales of an ancient sword hilt buried beneath the desert to the north. Find it and bring to me as your final test. ...",
				"Do you think you can handle all of that?",
			}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("Go in strength, |PLAYERNAME|!", cid)
			player:setStorageValue(6065, 1)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:removeItem(3956, 2) and player:removeItem(5258, 1) then
				npcHandler:say("Impressive, |PLAYERNAME|! These tusks are in great condition, and I've never seen finer steel! Now go and prove your bravery by slaying the monsters I asked you to.", cid)
				player:setStorageValue(6065, 2)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Come back once you have finished the task!", cid)
			end
		elseif npcHandler.topic[cid] == 5 then
			if player:removeItem(5032, 50) and player:removeItem(5263, 30) and player:removeItem(5290, 15) then
				npcHandler:say("You have done well, |PLAYERNAME|. The people of this land can sleep better at night knowing there are warriors like you pushing back against the forces of evil. Bring me the materials for the sword and you will have more than proven your worth.", cid)
				player:setStorageValue(6065, 3)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Come back once you have finished the task!", cid)
			end	
		elseif npcHandler.topic[cid] == 6 then
			if player:getItemCount(5252) >= 50 and player:getItemCount(2350) >= 1 then
				npcHandler:say("Unbelievable! This sword hilt was once owned by the Pharoah Morguthis and hasn't seen the light of day in centuries. You have proven yourself a true Knight, |PLAYERNAME|!", cid)
				player:removeItem(5252, 50)
				player:removeItem(2350, 1)
				player:setStorageValue(6065, 4)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Come back once you have finished the task!", cid)
			end
	elseif msgcontains(msg, "no") then
		if npcHandler.topic[cid] > 1 then
			npcHandler:say("Then I'm afraid I can't help you.", cid)
			npcHandler.topic[cid] = 0
		end
	end
	return true
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())