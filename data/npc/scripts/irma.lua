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
	
		if npcHandler.topic[cid] == 4 then
			 if getPlayerItemCount(cid,5251) >= 10 then
      			doPlayerRemoveItem(cid,5251,10)
				npcHandler:say("10 giant spider silks! Wonderful. Here, take this spool of yarn!", cid)
				doPlayerAddItem(cid,5257,1)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say('Are you trying to mess with me?!', cid)
			end
		if npcHandler.topic[cid] == 5 then
			 if getPlayerItemCount(cid,2655) >= 1 then
      			doPlayerRemoveItem(cid,2655,1)
				npcHandler:say("A Red Robe! Great. Here, take this red piece of cloth, I don\'t need it anyway.", cid)
				doPlayerAddItem(cid,5279,1)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say('Are you trying to mess with me?!', cid)
			end
		elseif npcHandler.topic[cid] == 6 then
   			 if getPlayerItemCount(cid,2663) >= 1 then
				doPlayerRemoveItem(cid,2663,1)
				npcHandler:say("A Mystic Turban! Great. Here, take this blue piece of cloth, I don\'t need it anyway.", cid)
				doPlayerAddItem(cid,5280,1)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say('Are you trying to mess with me?!', cid)
			end
		elseif npcHandler.topic[cid] == 7 then
   			 if getPlayerItemCount(cid,2652) >= 20 then
				doPlayerRemoveItem(cid,2652,20)
				npcHandler:say("20 Green Tunics! Great. Here, take this green piece of cloth, I don\'t need it anyway.", cid)
				doPlayerAddItem(cid,5278,1)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say('Are you trying to mess with me?!', cid)
			end
		elseif(msgcontains(msg, "spider silk")) then
			npcHandler:say("Did you bring 10 spider silks for me to weave?", cid)
			npcHandler.topic[cid] = 4
		elseif(msgcontains(msg, "red robe")) then
			npcHandler:say("Have you found a Red Robe for me?", cid)
			npcHandler.topic[cid] = 5
		elseif(msgcontains(msg, "mystic turban")) then
			npcHandler:say("Have you found a Mystic Turban for me?", cid)
			npcHandler.topic[cid] = 6
		elseif(msgcontains(msg, "green tunic")) then
			npcHandler:say("Have you found 20 Green Tunics for me?", cid)
			npcHandler.topic[cid] = 7
		end
	return true
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())