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
		if player:getStorageValue(6080) < 1 then
			npcHandler:say("These rags? Are you seriously interested in dressing like me?", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("I guess I must be out of touch with the world of fashion of this is what's 'in' right now. Very well, if you are willing to collect some things for me, I can give you an outfit just like mine. What do you say?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "initiation") then
		if player:getStorageValue(6080) == 1 then
			npcHandler:say("Did you collect 50 hardened bones, 5 bast skirts and a hydra egg?", cid)
			npcHandler.topic[cid] = 4
		end
	elseif msgcontains(msg, "staff") then
		if player:getStorageValue(6080) == 2 then
			npcHandler:say("Did you bring back 2 voodoo dolls and a banana staff?", cid)
			npcHandler.topic[cid] = 5
		end
	elseif msgcontains(msg, "mask") then
		if player:getStorageValue(6080) == 3 then
			npcHandler:say("Did you find 3 tribal masks and 10 enchanted chicken wings?", cid)
			npcHandler.topic[cid] = 6
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 and player:getSex() == PLAYERSEX_FEMALE then
			npcHandler:say({
				"Alright if that's what you really want. ...",
				"First, you'll need a staff. Something sturdy, like an amber staff. ...",
				"I can't imagine you'd want a beard like mine, but I could use a new one. Bring me a dwarven beard. ...",
				"Next, I need you to do me a favor. I once lost a valuable necklace deep in spider's cave under the mountain. I'm too lazy to retrieve it, so I'll ask that you do it for me. ...",
				"Finally, I'll need some material to work with. Bring me...say...100 brown pieces of cloth. ...",
				"You still want to work with me, |PLAYERNAME|?"
			}, cid)
			else
			npcHandler:say({
				"Alright if that's what you really want. ...",
				"First, you'll need a staff. Something sturdy, like an amber staff. ...",
				"You don't look like you're capable of growing a beard like mine, so you'll have to find one. Bring me a dwarven beard and I'll see what I can do. ...",
				"Next, I need you to do me a favor. I once lost a valuable necklace deep in spider's cave under the mountain. I'm too lazy to retrieve it, so I'll ask that you do it for me. ...",
				"Finally, I'll need some material to work with. Bring me...say...100 brown pieces of cloth. ...",
				"You still want to work with me, |PLAYERNAME|?"
			}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("Good luck, |PLAYERNAME|!", cid)
			player:setStorageValue(6080, 1)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:removeItem(5289, 50) and player:removeItem(3963, 5) and player:removeItem(4850, 1) then
				npcHandler:say("Well done |PLAYERNAME| - let the ritual commence! <Chants incoherently> Now, bring the materials to fashion a staff!", cid)
				player:setStorageValue(6080, 2)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("You did not bring what I asked!", cid)
			end
		elseif npcHandler.topic[cid] == 5 then
			if player:removeItem(3955, 2) and player:removeItem(3966, 1) then
				npcHandler:say("Aaahh, yes, yes! These dolls are full of voodoo magic and this staff is in pristine condition! Bring me the final pieces for your mask and your journey will be complete!", cid)
				player:setStorageValue(6080, 3)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("You did not bring what I asked!", cid)
			end
		elseif npcHandler.topic[cid] == 6 then
			if player:getItemCount(3967) >= 3 and player:getItemCount(5031) >= 10 then
				npcHandler:say("Well done, |PLAYERNAME|! You have proven yourself ready and worthy to walk the Shamanic path. May the spirits guide you!", cid)
				player:removeItem(3967, 3)
				player:removeItem(5031, 10)
				player:setStorageValue(6080, 4)
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
	end
	return true
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())