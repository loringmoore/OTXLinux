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
	elseif msgcontains(msg, "rags") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("I guess I must be out of touch with the world of fashion of this is what's 'in' right now. Very well, if you are willing to collect some things for me, I can give you an outfit just like mine. What do you say?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "staff") then
		if player:getStorageValue(6080) == 1 then
			npcHandler:say("Did you bring me a new staff?", cid)
			npcHandler.topic[cid] = 4
		end
	elseif msgcontains(msg, "beard") then
		if player:getStorageValue(6080) == 2 then
			npcHandler:say("Did you bring me a new beard?", cid)
			npcHandler.topic[cid] = 5
		end
	elseif msgcontains(msg, "necklace") then
		if player:getStorageValue(6080) == 3 then
			npcHandler:say("Did you find my necklace?", cid)
			npcHandler.topic[cid] = 6
		end
	elseif msgcontains(msg, "cloth") then
		if player:getStorageValue(6080) == 3 then
			npcHandler:say("Did you collect 100 brown pieces of cloth?", cid)
			npcHandler.topic[cid] = 7
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say({
				"Alright if that's what you really want. ...",
				"First, you'll need a staff. Something sturdy, like an amber staff. If you get me a new one, I'll give you mine. ...",
				"I'll let you in on a secret - this isn't my real beard, it's actually a dwarven beard! It's starting to get pretty gross though, I need you to bring me a new one. ...",
				"Next, I need you to do me a favor. I once lost a valuable necklace deep in spider's cave under the mountain. I'm too lazy to retrieve it, so I'll ask that you do it for me. ...",
				"Finally, I'll need some material to work with. Bring me...say...100 brown pieces of cloth. ...",
				"You still want to work with me, |PLAYERNAME|?"
			}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("Good luck!", cid)
			player:setStorageValue(6080, 1)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:removeItem(5212, 1) then
				npcHandler:say("Ha! Thanks for bringing me a new staff, you can have my old one. Now go get that new beard I asked for!", cid)
				player:setStorageValue(6080, 2)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Do you want me to help you or not?", cid)
			end
		elseif npcHandler.topic[cid] == 5 then
			if player:removeItem(5270, 1) then
				npcHandler:say("Wow, it's perfect! Now go find that necklace I lost.", cid)
				player:setStorageValue(6080, 3)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Do you want me to help you or not?", cid)
			end
		elseif npcHandler.topic[cid] == 6 then
			if player:removeItem(2132, 1) then
				npcHandler:say("To be honest, I didn't actually think you'd survive. You know what, you can keep the necklace. Wear it if you want, I don't care.", cid)
				player:setStorageValue(6080, 4)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Do you want me to help you or not?", cid)
			end
		elseif npcHandler.topic[cid] == 7 then
			if player:getItemCount(5281) >= 100 then
				npcHandler:say("Well, I suppose you've done everything I asked. Enjoy your outfit...I guess.", cid)
				player:removeItem(5281, 100)
				player:setStorageValue(6080, 5)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Do you want me to help you or not?", cid)
			end
	elseif msgcontains(msg, "no") then
		if npcHandler.topic[cid] > 1 then
			npcHandler:say("Whatever, and people say I'M weird.", cid)
			npcHandler.topic[cid] = 0
		end
	end
	return true
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())