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
		if player:getStorageValue(6023) < 1 then
			npcHandler:say("As a member of the Druid Guild, I am permitted to wear these paws and this hood as a symbol of my devotion to be one with nature.", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "nature") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("Are you interested in joining the Druid Guild by devoting your life to nature and the healing art?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "paws") then
		if player:getStorageValue(6023) == 1 then
			npcHandler:say("Were you able to collect 50 wolf paws and 50 bear paws?", cid)
			npcHandler.topic[cid] = 4
		end
	elseif msgcontains(msg, "flowers") then
		if player:getStorageValue(6023) == 2 then
			npcHandler:say("Did Did you collect the heaven blossoms and holy orchids I asked for?", cid)
			npcHandler.topic[cid] = 5
		end
	elseif msgcontains(msg, "mandrake") then
		if player:getStorageValue(6023) == 3 then
			npcHandler:say("Were you actually able to locate the elusive mandrake?", cid)
			npcHandler.topic[cid] = 6
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say({
				"Becoming a Druid is no small task. You will need to embark on a mission to collect herbs and ingredients from various places across the land. ...",
				"First, you\'ll need to collect 50 wolf paws and 50 bear paws. They help ward off evil spirits and promote healing. ...",
				"Next, you'll need to gather 30 heaven blossoms and 30 holy orchids. These beautiful flowers are important ingredients in various remedies. ...",
				"Finally, I need you to bring me back a mandrake. This root has deep magical properties, but is extremely rare. ...",
				"Now that you know what you have to do, are you still up to the task?"
			}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("Wonderful! Nature\'s blessing be upon you!", cid)
			player:setStorageValue(6023, 1)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:getItemCount(5266) >= 50 and player:getItemCount(5267) >= 50 then
				npcHandler:say("Well done, |PLAYERNAME|! Next please bring me 30 heaven blossoms and 30 holy orchids.", cid)
				player:removeItem(5266, 50)
				player:removeItem(5267, 50)
				player:setStorageValue(6023, 2)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("You don't have it...", cid)
			end
		elseif npcHandler.topic[cid] == 5 then
			if player:getItemCount(5287) >= 30 and player:getItemCount(5288) >= 30 then
				npcHandler:say("Thank you, |PLAYERNAME|! I can feel the soothing energy eminating from the petals already. The last thing I need is the Mandrake!", cid)
				player:removeItem(5287, 30)
				player:removeItem(5288, 30)
				player:setStorageValue(6023, 3)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("You don't have it...", cid)
			end
		elseif npcHandler.topic[cid] == 6 then
			if player:removeItem(5015, 1) then
				npcHandler:say("Incredible! This will be enough to brew powerful remedies for years to come. |PLAYERNAME|, it is my honor to welcome you to the Druid\'s Guild. You may now wear these paws and this hood!", cid)
				player:setStorageValue(6023, 4)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("You don't have it...", cid)
			end
		end
	elseif msgcontains(msg, "no") then
		if npcHandler.topic[cid] > 1 then
			npcHandler:say("Then I\'m afraid I can\'t help you.", cid)
			npcHandler.topic[cid] = 0
		end
	return true
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())