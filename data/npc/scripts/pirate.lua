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
		if player:getStorageValue(6064) < 1 then
			npcHandler:say("So, you wanna dress like one of us, eh? Well, in order to dress like a pirate you need to BE a pirate!", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "pirate") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("We don't tolerate double-crossers. You can prove your loyalty to us by aiding in the ongoing conflict with the pirate faction on Clandestia. Are you willing to fight by our side?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "tokens") then
		if player:getStorageValue(6064) == 1 then
			npcHandler:say("Did you slaughter enough pirates to collect 30 eye patches, 30 peg legs, and 30 hooks?", cid)
			npcHandler.topic[cid] = 4
		end
	elseif msgcontains(msg, "uniform") then
		if player:getStorageValue(6064) == 2 then
			npcHandler:say("Were you able to pilfer a complete pirate uniform?", cid)
			npcHandler.topic[cid] = 5
		end
	elseif msgcontains(msg, "sabre") then
		if player:getStorageValue(6064) == 3 then
			npcHandler:say("Did you track down and kill Captain Ironblade?", cid)
			npcHandler.topic[cid] = 6
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say({
				"Excellent! In that case, your first mission will be to weaken their ground forces. They've amassed quite a sizeable army and I fear they may be preparing for an invasion soon. ...",
				"Bring me back enough eye patches, hooks, and peg legs as a sign that you've delivered a signifcant blow to their numbers. I reckon 30 of each of these tokens should suffice. ...",
				"Unfortunately, while morale is high, supplies are not. I'm afraid we don't have any uniforms to spare. If you want to dress like a pirate, snag a complete uniform while you/'re fighting the pirates on Clandestia. To be clear, this consists of a pirate hat, bandana, pirate shirt, pirate knee breeches and pirate boots. ...",
				"Last but certainly not least, as your final test, I need you to track down and kill the nefarious Captain Ironblade. Bring me back his sabre as proof of his defeat. ...",
				"Well, you have your orders, are you ready to begin?"
			}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("May the wind be in your sails, |PLAYERNAME|! Talk to Captain Bentley about getting to Clandestia.", cid)
			player:setStorageValue(6064, 1)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:getItemCount(5298) >= 30 and player:getItemCount(5299) >= 30 and player:getItemCount(5300) >= 30 then
				npcHandler:say("Excellent job, |PLAYERNAME|! You've dealt a serious blow to their numbers. As soon as you manage to locate a complete pirate uniform, bring it to me!", cid)
				player:removeItem(5298, 30)
				player:removeItem(5299, 30)
				player:removeItem(5300, 30)
				player:setStorageValue(6064, 2)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Come back when you have the items I asked for.", cid)
			end
		elseif npcHandler.topic[cid] == 5 then
			if player:removeItem(5296, 1) and player:removeItem(5283, 1) and player:removeItem(5295, 1) and player:removeItem(5284, 1) and player:removeItem(5328, 1) then
				npcHandler:say("These are in great shape, |PLAYERNAME|! I'll need to make some alterations and give these a wash before you put them on. Why don't you begin your final task of taking out Captain Ironblade? With how fast you work, I'm sure everything will be ready by the time you're done.", cid)
				player:setStorageValue(6064, 3)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Come back when you have the items I asked for.", cid)
			end
		elseif npcHandler.topic[cid] == 6 then
			if player:removeItem(5297, 1) then
				npcHandler:say("Unbelievable! You've done us a great service, |PLAYERNAME|, and I am forever grateful. Your outift is ready, wear it proudly!", cid)
				player:setStorageValue(6064, 4)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Come back when you have the item I asked for.", cid)
			end
	elseif msgcontains(msg, "no") then
		if npcHandler.topic[cid] > 1 then
			npcHandler:say("Why are you wasting my time then?", cid)
			npcHandler.topic[cid] = 0
		end
	end
	return true
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())