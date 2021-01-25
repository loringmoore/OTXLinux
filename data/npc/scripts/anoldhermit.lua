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
	if msgcontains(msg, "task") then
		if player:getStorageValue(6046) < 1 then
			npcHandler:say("What I need is quite simple: a spool of yarn. Not just any yarn mind you, yarn from a giant spiders' silk. I can't be out grappling with monsters anymore, so if you can bring me a spool of yarn I'll make it worth your while.", cid)
		else
			npcHandler:say("I don't have any other jobs for you.", cid)
		end
	elseif msgcontains(msg, "giant spider") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("I would check the swamp to the south, I know for certain there is a large giant spider lair there. Let me warn you though, they are dangerous creatures; viscious and cunning. Collecting enough silks to make yarn won/'t be easy. Are you still up to the task?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "yarn") then
		if player:getStorageValue(6046) == 1 then
			npcHandler:say("Did you bring me a spool of yarn?", cid)
			npcHandler.topic[cid] = 4
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say({"Excellent! It/'s settled then. Collect enough silks and take them to the seamstress Irma. I believe her shop is in Madrissa. She will be able to spin those silks into a fine yarn. Does that all make sense?"}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("Good luck out there, |PLAYERNAME|!", cid)
			player:setStorageValue(6056, 1)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:removeItem(5257, 1) then
				npcHandler:say("Hohoho, you/'ve dont it, |PLAYERNAME|! With this sturdy yarn I will be able to finish remodeling my little home. Take this old quiver as thanks; it's worn, but sturdy.", cid)
				player:setStorageValue(6046, 2)
				player:addItem(5720, 1)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("You didn't bring it!", cid)
			end
	elseif msgcontains(msg, "no") then
		if npcHandler.topic[cid] > 1 then
			npcHandler:say("Then why are you still in my house? Leave!", cid)
			npcHandler.topic[cid] = 0
		end
	return true
	end
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())