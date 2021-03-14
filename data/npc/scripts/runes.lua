local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid)                          npcHandler:onCreatureAppear(cid)                        end
function onCreatureDisappear(cid)                       npcHandler:onCreatureDisappear(cid)                     end
function onCreatureSay(cid, type, msg)                  npcHandler:onCreatureSay(cid, type, msg)                end
function onThink()                                      npcHandler:onThink()                                    end
function creatureSayCallback(cid, type, msg)
        if(not npcHandler:isFocused(cid)) then
                return false
        end
local player = Player(cid)
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid        
local spells = {
				[1] = {spell_name = "Poison Field" ,price = 300, words = 'adevo grav pox', number = 1},
				[2] = {spell_name = "Light Magic Missile" ,price = 500, words = 'adori', number = 2},
				[3] = {spell_name = "Fire Field" ,price = 500, words = 'adori grav flam', number = 3},
				[4] = {spell_name = "Fireball" ,price = 1600, words = 'adori flam', number = 4},
				[5] = {spell_name = "Energy Field" ,price = 700, words = 'adevo grav vis', number = 5},
				[6] = {spell_name = "Envenom" ,price = 6000, words = 'adevo res pox', number = 6},
				[7] = {spell_name = "Great Fireball" ,price = 1200, words = 'adori gran flam', number = 7},
				[8] = {spell_name = "Thunderstorm" ,price = 1200, words = 'adori gran vis', number = 8},
				[9] = {spell_name = "Poison Shower" ,price = 1200, words = 'adori gran pox', number = 9},
				[10] = {spell_name = "Avalanche" ,price = 1200, words = 'adori gran aqua', number = 10},
				[11] = {spell_name = "Heavy Magic Missile" ,price = 1500, words = 'adori gran', number = 11},
				[12] = {spell_name = "Poison Bomb" ,price = 1000, words = 'adevo mas pox', number = 12},
				[13] = {spell_name = "Firebomb" ,price = 1500, words = 'adevo mas flam', number = 13},
				[14] = {spell_name = "Soulfire" ,price = 1800, words = 'adevo res flam', number = 14},
				[15] = {spell_name = "Poison Wall" ,price = 1600, words = 'adevo mas grav pox', number = 15},
				[16] = {spell_name = "Explosion" ,price = 1800, words = 'adevo mas hur', number = 16},
				[17] = {spell_name = "Fire Wall" ,price = 2000, words = 'adevo mas grav flam', number = 17},
				[18] = {spell_name = "Energybomb" ,price = 2300, words = 'adevo mas vis', number = 18},
				[19] = {spell_name = "Energy Wall" ,price = 2500, words = 'adevo mas grav vis', number = 19},
				[20] = {spell_name = "Sudden Death" ,price = 3000, words = 'adori vita vis', number = 20},
				[21] = {spell_name = "Antidote Rune" ,price = 600, words = 'adana pox', number = 21},
				[22] = {spell_name = "Intense Healing Rune" ,price = 600, words = 'adura gran', number = 22},
				[23] = {spell_name = "Ultimate Healing Rune" ,price = 1500, words = 'adura vita', number = 23},
				[24] = {spell_name = "Convince Creature" ,price = 800, words = 'adeta sio', number = 24},
				[25] = {spell_name = "Animate Dead" ,price = 1200, words = 'adana mort', number = 25},
				[26] = {spell_name = "Chameleon" ,price = 1300, words = 'adevo ina', number = 26},
				[27] = {spell_name = "Destroy Field" ,price = 700, words = 'adito grav', number = 27},
				[28] = {spell_name = "Disintegrate" ,price = 900, words = 'adito tera', number = 28},
				[29] = {spell_name = "Magic Wall" ,price = 2100, words = 'adevo grav tera', number = 29},
				[30] = {spell_name = "Wild Growth" ,price = 2000, words = 'adevo grav vita', number = 30},
				[31] = {spell_name = "Paralyze" ,price = 1900, words = 'adana ani', number = 31},
		
				}	
for i = 1, #spells do
	if msgcontains(msg, spells[i].spell_name) then
		if getPlayerLearnedInstantSpell(cid, spells[i].spell_name) == false then
			npcHandler:say("Would you like to buy "..spells[i].spell_name.." for "..spells[i].price.." gold?", cid)
			talkState[talkUser] = spells[i].number
		else
			npcHandler:say("You already know how to cast this spell.", cid)
		end
	elseif msgcontains(msg, 'yes') then
		if talkState[talkUser] == spells[i].number then
			if getPlayerMoney(cid) >= spells[i].price then
				doPlayerRemoveMoney(cid, spells[i].price)
				npcHandler:say("To cast this spell say "..spells[i].words..".", cid)
				player:learnSpell(spells[i].spell_name)
				doSendMagicEffect(getCreaturePosition(cid), 14)
			else
				npcHandler:say("You don't have enough money.", cid)
			end
		end
	end
end
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())