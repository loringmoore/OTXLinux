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
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid        
local spells = {
				[1] = {spell_name = "Poison Field" ,price = 300, words = 'ADEVO GRAV POX', number = 1},
				[2] = {spell_name = "Light Magic Missile" ,price = 500, words = 'ADORI', number = 2},
				[3] = {spell_name = "Fire Field" ,price = 500, words = 'ADORI GRAV FLAM', number = 3},
				[4] = {spell_name = "Fireball" ,price = 1600, words = 'ADORI FLAM', number = 4},
				[5] = {spell_name = "Energy Field" ,price = 700, words = 'ADEVO GRAV VIS', number = 5},
				[6] = {spell_name = "Envenom" ,price = 6000, words = 'ADEVO RES POX', number = 6},
				[7] = {spell_name = "Great Fireball" ,price = 1200, words = 'ADORI GRAN FLAM', number = 7},
				[8] = {spell_name = "Thunderstorm" ,price = 1200, words = 'ADORI GRAN VIS', number = 8},
				[9] = {spell_name = "Poison Shower" ,price = 1200, words = 'ADORI GRAN POX', number = 9},
				[10] = {spell_name = "Avalanche" ,price = 1200, words = 'ADORI GRAN AQUA', number = 10},
				[11] = {spell_name = "Heavy Magic Missile" ,price = 1500, words = 'ADORI GRAN', number = 11},
				[12] = {spell_name = "Poison Bomb" ,price = 1000, words = 'ADEVO MAS POX', number = 12},
				[13] = {spell_name = "Firebomb" ,price = 1500, words = 'ADEVO MAS FLAM', number = 13},
				[14] = {spell_name = "Soulfire" ,price = 1800, words = 'ADEVO RES FLAM', number = 14},
				[15] = {spell_name = "Poison Wall" ,price = 1600, words = 'ADEVO MAS GRAV POX', number = 15},
				[16] = {spell_name = "Explosion" ,price = 1800, words = 'ADEVO MAS HUR', number = 16},
				[17] = {spell_name = "Fire Wall" ,price = 2000, words = 'ADEVO MAS GRAV FLAM', number = 17},
				[18] = {spell_name = "Energybomb" ,price = 2300, words = 'ADEVO MAS VIS', number = 18},
				[19] = {spell_name = "Energy Wall" ,price = 2500, words = 'ADEVO MAS GRAV VIS', number = 19},
				[20] = {spell_name = "Sudden Death" ,price = 3000, words = 'ADORI VITA VIS', number = 20},
				[21] = {spell_name = "Antidote Rune" ,price = 600, words = 'ADANA POX', number = 21},
				[22] = {spell_name = "Intense Healing Rune" ,price = 600, words = 'ADURA GRAN', number = 22},
				[23] = {spell_name = "Ultimate Healing Rune" ,price = 1500, words = 'ADURA VITA', number = 23},
				[24] = {spell_name = "Convince Creature" ,price = 800, words = 'ADETA SIO', number = 24},
				[25] = {spell_name = "Animate Dead" ,price = 1200, words = 'ADANA MORT', number = 25},
				[26] = {spell_name = "Chameleon" ,price = 1300, words = 'ADEVO INA', number = 26},
				[27] = {spell_name = "Destroy Field" ,price = 700, words = 'ADITO GRAV', number = 27},
				[28] = {spell_name = "Disintegrate" ,price = 900, words = 'ADITO TERA', number = 28},
				[29] = {spell_name = "Magic Wall" ,price = 2100, words = 'ADEVO GRAV TERA', number = 29},
				[30] = {spell_name = "Wild Growth" ,price = 2000, words = 'ADEVO GRAV VITA', number = 30},
				[30] = {spell_name = "Paralyze" ,price = 1900, words = 'ADANA ANI', number = 31},
		
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
				npcHandler:say("To cast this spell say "..spells[i].words.."}.", cid)
				doPlayerLearnInstantSpell(cid, spells[i].spell_name)
				doSendMagicEffect(getCreaturePosition(cid), 12)
			else
				npcHandler:say("You don\'t have enough money.", cid)
			end
		end
	end
end
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())