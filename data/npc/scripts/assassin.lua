local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'arrow'}, 2544, 3, 'arrow')
shopModule:addBuyableItem({'assassin star'}, 5423, 100, 'assassin star')
shopModule:addBuyableItem({'bolt'}, 2543, 4, 'bolt')
shopModule:addBuyableItem({'bow'}, 2456, 400, 'bow')
shopModule:addBuyableItem({'crossbow'}, 2455, 500, 'crossbow')
shopModule:addBuyableItem({'spear'}, 2389, 9, 'spear')

local function greetCallback(cid)
	if Player(cid):getCondition(CONDITION_INVISIBLE) then
		npcHandler:setMessage(MESSAGE_GREET, 'Ahh, finally! Another master of stealth and shadow. Why are you here, |PLAYERNAME|?')
	else
		return false
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if msgcontains(msg, "outfit") then
		if player:getStorageValue(6076) < 1 then
			npcHandler:say("This getup? I am the leader of the elusive Assassin Clan. If you're feeling brave, you can attempt initiation.", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "initiation") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("An assassin can move around in the shadows without being seen, eliminating enemies before they have a chance to react. Are you sure you would like to proceed?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "tokens") then
		if player:getStorageValue(6076) == 1 then
			npcHandler:say("Did you eliminate the targets?", cid)
			npcHandler.topic[cid] = 4
		end
	elseif msgcontains(msg, "cloth") then
		if player:getStorageValue(6076) == 2 then
			npcHandler:say("Did you collect 100 pieces of blue cloth?", cid)
			npcHandler.topic[cid] = 5
		end
	elseif msgcontains(msg, "sword") then
		if player:getStorageValue(6076) == 3 then
			npcHandler:say("Did you bring back a samurai sword?", cid)
			npcHandler.topic[cid] = 6
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say({
				"As you wish. ...",
				"First, I need you to prove your ability to infiltrate enemy territory and remove a target with surgical precision. ...",
				"I need you to find and kill various leaders of other clans that pose a threat to our existence. ...",
				"The Horned Fox, the leader of the minotaurs. Demodras, who rules over the brood of dragons who reside in the mountains east of Madrissa. ...",
				"Fernfang, the elusive but dangerous monk who hides out south of Thunder Cove. Finally, Necropharus, an evil necromancer who engages in horrible dark rituals. ...",
				"Find and eliminate all these threats and bring back their respective tokens as proof of your success. ...",
				"After you have eliminated these targets, your task is only halfway done. Bring me 100 pieces of the finest blue cloth you can find for the head and body wrapping and a samurai sword to wear around your waist. ...",
				"Are you sure you still want to join the Clan?"
			}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("Good luck, |PLAYERNAME|.", cid)
			player:setStorageValue(6076, 1)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:removeItem(5246, 1) and player:removeItem(5243, 1) and player:removeItem(5285, 1) and player:removeItem(5244, 1) then
				npcHandler:say("Impressive, |PLAYERNAME|! You have rendered a great service to the Clan!", cid)
				player:setStorageValue(6076, 2)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Come back when you have finished!", cid)
			end
		elseif npcHandler.topic[cid] == 5 then
			if player:removeItem(5280, 100) then
				npcHandler:say("These are of superb quality! Only one task left, bring me a samurai sword!", cid)
				player:setStorageValue(6076, 3)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Come back when you have what I asked for!", cid)
			end
		elseif npcHandler.topic[cid] == 6 then
			if player:removeItem(5226, 1) then
				npcHandler:say("Good work, |PLAYERNAME|. Only a select few ever get to truly call themselves assassins, and it is my honor to welcome you into the Clan!", cid)
				player:setStorageValue(6076, 4)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Come back when you have what I asked for!", cid)
			end
		end
	elseif msgcontains(msg, "no") then
		if npcHandler.topic[cid] > 1 then
			npcHandler:say("Then get out, and pray you are never in our crosshairs!", cid)
			npcHandler.topic[cid] = 0
		end
	return true
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())