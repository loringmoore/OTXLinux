local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

 
function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	
	local player = Player(cid)
	
	if(msgcontains(msg, "outfit")) then
		if(getPlayerStorageValue(cid, 6021) < 1) then
			npcHandler:say("It's so elegant, isn\'t it? I make outfits for the aristocrat class. Is that why you're here, to place a request?", cid)
			npcHandler.topic[cid] = 1
		else
			npcHandler:say("You have already bought the outfit.", cid)
		end

	elseif(msgcontains(msg, "yes")) then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("You\'ve come to the right seamstress! I can tailor an outfit that is sure to turn heads - for the right price.", cid)
			npcHandler.topic[cid] = 2
		elseif npcHandler.topic[cid] == 3 then
			if(doPlayerRemoveMoney(cid, 150000) and getPlayerStorageValue(cid, 6021) < 1) then
				npcHandler:say("Congratulations! Here is your brand-new outfit, I hope you like it.", cid)
				npcHandler.topic[cid] = 0
				setPlayerStorageValue(cid, 6021, 1)
			end
		end

		
	elseif(msgcontains(msg, "price")) and (npcHandler.topic[cid] == 2) and (getPlayerStorageValue(cid, 6021) < 1) then
		npcHandler:say("It will cost no less than 500,000 gold coins to craft such an exquisite outfit. What do you say, are you interested?", cid)
		npcHandler.topic[cid] = 3
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())