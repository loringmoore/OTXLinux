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
		if player:getStorageValue(6075) < 1 then
			npcHandler:say("My wand and hat are rare magical artifacts, I'm afraid I can't just give them away.", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "artifacts") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("Anyone can find rare magical items, they just need to know where to look. I'll tell you what, if you find a wand and hat of your own, I'll fashion them into an outfit. Would you like that?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "crystal wand") then
		if player:getStorageValue(6075) == 1 then
			npcHandler:say("Did you find a crystal wand?", cid)
			npcHandler.topic[cid] = 4
		end
	elseif msgcontains(msg, "ferumbra's hat") then
		if player:getStorageValue(6075) == 2 then
			npcHandler:say("Did you slay Ferumbras and bring back his hat?", cid)
			npcHandler.topic[cid] = 5
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say({
				"I only require two things from you; the hat of the mighty wizard Ferumbras, and a crystal wand. ...",
				"I was part of a team of heroes who banished Ferumbras from this realm many years ago, that is why I wear his hat today. He hasn't shown his face in this world for a while, but I fear he may return again someday soon. If you can best him and retrieve his hat, you can wear it. ...",
				"There are rumors that one of the great Pharoahs was buried with a crystal wand. I suppose the tombs under Madrissa would be a good place to start searching. ...",
				"Short, but not at all simple. Are you up to the task my young friend?"
			}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("Good luck, |PLAYERNAME|.", cid)
			player:setStorageValue(6075, 1)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:removeItem(2184, 1) then
				npcHandler:say("This wand is in perfect condition! You're halfway there, |PLAYERNAME|, now bring me the hat of Ferumbras!", cid)
				player:setStorageValue(6075, 2)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("You don't have it.", cid)
			end
		elseif npcHandler.topic[cid] == 5 then
			if player:removeItem(5272, 1) then
				npcHandler:say("Truly unbelievable, |PLAYERNAME|. Because of you, this realm remains safe from Ferumbras' dark ambitions for world conquest. You truly have mastered the magic arts, wear this outfit with pride!", cid)
				player:setStorageValue(6075, 3)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("You don't have it.", cid)
			end
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