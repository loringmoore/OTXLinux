local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()						npcHandler:onThink()						end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	
	local player = Player(cid)
	if msgcontains(msg, "orange") then
		if player:getStorageValue(6009) < 1 then
			npcHandler:say("Did you manage to find an orange for me?", cid)
			npcHandler.topic[cid] = 1
		end

	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			if player:removeItem(2675, 1) then
				npcHandler:say({
					"An orange! Great. Take this shield so you don\'t get killed by all the dangerous monsters out there."
				}, cid)
				player:setStorageValue(6009, 1)
				player:addItem(2521, 1)
			else
				npcHandler:say("You don't have it...", cid)
			end
			npcHandler.topic[cid] = 0
		end
		return true
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
			
			
			
			
			
		--	if npcHandler.topic[cid] == 1 then
			-- if getPlayerItemCount(cid,2675) >= 1 then
      			--doPlayerRemoveItem(cid,2675,1)
				--npcHandler:say("An orange! Great. Take this shield so you don\'t get killed by all the dangerous monsters out there.")
				--doPlayerAddItem(cid,3973,1)
				--setPlayerStorageValue(cid,6009,1)
				--npcHandler.topic[cid] = 0
			--else
			--	npcHandler:say('You\'re wasting my time.', cid)
			--end
		--elseif(msgcontains(msg, "orange")) and (getPlayerStorageValue(cid,6009) < 1) then
			--npcHandler:say("Have you found an orange for me?", cid)
			--npcHandler.topic[cid] = 1
		--end
	--return true
--end
