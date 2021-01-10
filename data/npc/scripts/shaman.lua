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
		if player:getStorageValue(6025) < 1 then
			npcHandler:say("It seems you are drawn to the shamanic path, |PLAYERNAME|, that is good. You can become a shaman too if you desire!", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "shaman") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("The shamanic path is not an easy one, but it is worth it. I can show you the way, but you must be willing to complete a series of difficult tasks. Are you ready?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "initiation") then
		if player:getStorageValue(6025) == 1 then
			npcHandler:say("Did you collect 50 hardened bones and 5 bast skirts?", cid)
			npcHandler.topic[cid] = 4
		end
	elseif msgcontains(msg, "staff") then
		if player:getStorageValue(6025) == 2 then
			npcHandler:say("Did you bring back 2 voodoo dolls and a banana staff?", cid)
			npcHandler.topic[cid] = 5
		end
	elseif msgcontains(msg, "mask") then
		if player:getStorageValue(6025) == 3 then
			npcHandler:say("Did you find 3 tribal masks and 10 enchanted chicken wings?", cid)
			npcHandler.topic[cid] = 6
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say({
				"Wonderful, my child. Now, hear me speak: For your initiation, I ask that you collect some bones for me. Any old bones will not do, it needs to be hardened bones. Please bring me 50. ...",
				"You/'ll need a skirt like the one I wear. If you bring me 5 bast skirts I should be able to weave one big enough for you. ...",
				"Next, you will need to gather materials for your staff. A true shaman/'s staff like the one I carry requires the power of 2 voodoo dolls mounted on a banana staff. ...",
				"Next, the mask. Bring me 3 tribal masks and 10 enchanted chicken wings and I shall craft a traditional mask like the one I wear. ...",
				"Lastly, as your final test, bring me back an egg of the mighty hydra. ...",
				"Are ready to face these challenges, |PLAYERNAME|?"
			}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("May the Spirits guide you, |PLAYERNAME|!", cid)
			player:setStorageValue(6025, 1)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:removeItem(5247, 1) then
				npcHandler:say("Well done |PLAYERNAME| - let the ritual commence! <Chants incoherently> Now, bring the materials to fashion a staff!", cid)
				player:setStorageValue(6025, 2)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("You did not bring what I asked!", cid)
			end
		elseif npcHandler.topic[cid] == 5 then
			if player:getItemCount(5250) >= 100 and player:getItemCount(5248) >= 100 and player:getItemCount(5249) >= 100 and player:getItemCount(5294) >= 100 then
				npcHandler:say("Aaahh, yes, yes! These dolls are full of voodoo magic and this staff is in pristine condition! Bring me the final pieces for your mask and your journey will be complete!", cid)
				player:removeItem(5250, 100)
				player:removeItem(5248, 100)
				player:removeItem(5249, 100)
				player:removeItem(5294, 100)
				player:setStorageValue(6025, 3)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("You did not bring what I asked!", cid)
			end
	elseif msgcontains(msg, "no") then
		if npcHandler.topic[cid] > 1 then
			npcHandler:say("Then no.", cid)
			npcHandler.topic[cid] = 0
		end
	return true
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())