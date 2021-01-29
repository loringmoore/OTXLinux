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
		if player:getStorageValue(6045) < 1 and player:getSex() == PLAYERSEX_FEMALE then
			npcHandler:say("Oh, my winged tiara and gloves? This is traditional garb worn by Amazon who have proved themselves to be expert markswomen. The outfit is awarded after completing dangerous tasks for our clan.", cid)
		else
			npcHandler:say("Oh, my winged tiara and gloves? This is traditional garb worn by Amazon who have proved themselves to be expert markswomen. The outfit is awarded after completing dangerous tasks for our clan. Although there are no men in our society, we would award a male warrior brave enough to complete these tasks with a hooded cloak instead of a tiara.", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "task") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("So, you are saying that you would like to prove that you deserve to wear the prestigious hunter garb?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "sniper gloves") then
		if player:getStorageValue(6045) == 1 then
			npcHandler:say("Did you find the sniper gloves?", cid)
			npcHandler.topic[cid] = 4
		end
	elseif msgcontains(msg, "leather") then
		if player:getStorageValue(6045) == 2 then
			npcHandler:say("Did you bring me 100 pieces of minotaur leather, 100 pieces of lizard leather, 100 pieces of red dragon leather and 100 pieces of green dragon leather?", cid)
			npcHandler.topic[cid] = 5
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say({
				"Alright, I will give you a chance to prove yourself worthy. Pay close attention to what I'm going to tell you now. ...",
				"Recently, one of our scouts was exploring the volcano to the north, and scaled it in order to survey the land. Upon reaching the summit, she paused to rest, only to be attacked by a firey creature. In her haste to escape, she left a pair of sniper gloves behind. ...",
				"Each pair of these gloves is hand-crafted by our artisans, and the process is very time-consuming. If you could retrieve the gloves, I'll let you wear them. ...",
				"Secondly, we need a lot of leather for new quivers. Leather can only be obtained from monsters like minotaus, lizards and dragons, and hunting them can be extremely dangerous. ...",
				"Prove your skill with the bow by bringing back 100 pieces of minotaur leather, 100 pieces of lizard leather, 100 pieces of red dragon leather, and 100 pieces of green dragon leather. ...",
				"Lastly, for our arrow heads we need a lot of steel. Best would be one piece of royal steel, one piece of draconian steel and one piece of hell steel. ...",
				"Did you understand everything I told you and are willing to handle this task?"
			}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("Such spirit! I wish you luck, |PLAYERNAME|!", cid)
			player:setStorageValue(6045, 1)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:removeItem(5247, 1) then
				npcHandler:say("I\'ll admit that was much faster than I expected! Maybe I underestimated you, |PLAYERNAME|! Please bring me 100 pieces of lizard leather and 100 pieces of red dragon leather now!", cid)
				player:setStorageValue(6045, 2)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("You don't have it...", cid)
			end
		elseif npcHandler.topic[cid] == 5 then
			if player:getItemCount(5250) >= 100 and player:getItemCount(5248) >= 100 and player:getItemCount(5249) >= 100 and player:getItemCount(5294) >= 100 then
				npcHandler:say("Good work, |PLAYERNAME|! That is enough leather for a lot of sturdy quivers. Well, you certainly have proven yourself worthy, |PLAYERNAME|, and I will honor my end of the deal. Take this traditional hunter garb, and where it with pride!", cid)
				player:removeItem(5250, 100)
				player:removeItem(5248, 100)
				player:removeItem(5249, 100)
				player:removeItem(5294, 100)
				player:setStorageValue(6045, 3)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("You don't have it...", cid)
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