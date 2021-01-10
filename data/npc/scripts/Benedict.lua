local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) 			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) 		end
function onCreatureSay(cid, type, msg) 		npcHandler:onCreatureSay(cid, type, msg) 	end
function onThink()							npcHandler:onThink()						end
function onPlayerEndTrade(cid)				npcHandler:onPlayerEndTrade(cid)			end
function onPlayerCloseChannel(cid)			npcHandler:onPlayerCloseChannel(cid)		end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = cid
	local p = Player(cid)
	local heal = false
	local hp = p:getHealth()
	
	if msgcontains(msg, "heal") then
		if getCreatureCondition(cid, CONDITION_FIRE) then
			selfSay("You are burning. I will help you.", cid)
			doRemoveCondition(cid, CONDITION_FIRE)
			heal = true
		elseif getCreatureCondition(cid, CONDITION_POISON) then
			selfSay("You are poisoned. I will cure you.", cid)
			doRemoveCondition(cid, CONDITION_POISON)
			heal = true
		elseif getCreatureCondition(cid, CONDITION_ENERGY) then
			selfSay("You are electrificed. I will help you.", cid)
			doRemoveCondition(cid, CONDITION_ENERGY)
			heal = true
		elseif getCreatureCondition(cid, CONDITION_PARALYZE) then
			selfSay("You are paralyzed. I will cure you.", cid)
			doRemoveCondition(cid, CONDITION_PARALYZE)
			heal = true
		elseif getCreatureCondition(cid, CONDITION_DROWN) then
			selfSay("You are drowing. I will help you.", cid)
			doRemoveCondition(cid, CONDITION_DROWN)
			heal = true
		elseif getCreatureCondition(cid, CONDITION_BLEEDING) then
			selfSay("You are bleeding! I will help you.", cid)
			doRemoveCondition(cid, CONDITION_BLEEDING)
			heal = true
		elseif getCreatureCondition(cid, CONDITION_DAZZLED) then
			selfSay("You are dazzled! Do not mess with holy creatures anymore!", cid)
			doRemoveCondition(cid, CONDITION_DAZZLED)
			heal = true
		elseif getCreatureCondition(cid, CONDITION_CURSED) then
			selfSay("You are cursed! I will remove it.", cid)
			doRemoveCondition(cid, CONDITION_CURSED)
			heal = true
		elseif hp < 65 then
			selfSay("You are looking really bad. Let me heal your wounds.", cid)
			p:addHealth(65 - hp)
			heal = true
		elseif hp < 200 then
			selfSay("I did my best to fix your wounds.", cid)
			p:addHealth(200 - hp)
			heal = true
		end
		
		if heal then
			p:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		else
			local msgheal = {
				"You aren't looking really bad, " .. getCreatureName(cid) .. ". I only help in cases of real emergencies. Raise your health simply by eating {food}.", 
				"Seriously? It's just a scratch", 
				"Don't be a child. You don't need any help with your health.", 
				"I'm not an expert. If you need help find a medic.", 
				"Don't even waste my time, I have bigger problems than your scratched armor."
			}
			selfSay("" .. msgheal[math.random(1, #msgheal)] .. "", cid)
		end
	return true
	end
	
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())