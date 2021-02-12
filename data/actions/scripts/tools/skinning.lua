local config = {
	[5276] = {
		
		-- Minotaurs
		[2830] = {value = 15000, newItem = 5250, after = 2831}, -- minotaur
		[2871] = {value = 15000, newItem = 5250, after = 2872}, -- minotaur archer		
		[2866] = {value = 15000, newItem = 5250, after = 2867}, -- minotaur mage		
		[2876] = {value = 15000, newItem = 5250, after = 2877}, -- minotaur guard				
		
		-- Low Class Lizards
		[4259] = {value = 15000, newItem = 5248, after = 4260}, -- lizard sentinel
		[4262] = {value = 15000, newItem = 5248, after = 4263}, -- lizard snakecharmer
		[4256] = {value = 15000, newItem = 5248, after = 4257}, -- lizard templar

		-- Wolves
		
		[2826] = {value = 15000, newItem = 5267, after = 2827},
		[2924] = {value = 15000, newItem = 5267, after = 2925},
		[2969] = {value = 15000, newItem = 5267, after = 2970},
		
		-- Quaras
		[5163] = {value = 15000, newItem = 5265, after = 5164},
		[5166] = {value = 15000, newItem = 5265, after = 5167},
		[5169] = {value = 15000, newItem = 5265, after = 5170},
		[5172] = {value = 15000, newItem = 5265, after = 5173},
		[5175] = {value = 15000, newItem = 5265, after = 5176},
		[5362] = {value = 15000, newItem = 5265, after = 5363},
		
		--Apes
		[4268] = {value = 15000, newItem = 5255, after = 4269}, -- kongra		
		[4271] = {value = 15000, newItem = 5255, after = 4272}, -- merlkin
		[4274] = {value = 15000, newItem = 5255, after = 4275}, -- sibang
		
		-- Bears
		[2893] = {value = 15000, newItem = 5266, after = 2984},
		[2849] = {value = 15000, newItem = 5266, after = 2850},
		
		-- High Class Lizards
		[5351] = {value = 15000, newItem = 5248, after = 5352}, -- lizard legionnaire 		
		[5354] = {value = 15000, newItem = 5248, after = 5355}, -- lizard dragon priest
		[5348] = {value = 15000, newItem = 5248, after = 5349}, -- lizard high guard	

		-- Dragons
		[2844] = {value = 15000, newItem = 5249, after = 2845}, -- dragon
		[2881] = {value = 15000, newItem = 5294, after = 2882}, -- dragon lord
		[5613] = {value = 15000, newItem = 5294, after = 5614}, -- dragon king

		-- Behemoth
		[2931] = {value = 25000, newItem = 5263, after = 2932},

		-- Bone Beast
		[3031] = {value = 15000, newItem = 5289, after = 3032},
		
		-- Stone monsters
		[2952] = {value = 5000, newItem = 5252, after = 2953}, -- stone golem
		--[5347] = {value = 25000, newItem = 5252, after = 2257}, -- eternal guardian
		[3022] = {value = 5000, newItem = 5252, after = 3023}, -- gargoyle
		[5357] = {value = 15000, newItem = 5252, after = 5358}, -- earth elemental
		
		-- Beholders
		[2908] = {value = 10000, newItem = 5268, after = 2909}, -- beholder
		[3052] = {value = 15000, newItem = 5268, after = 3053}, -- beholder
		[3049] = {value = 5000, newItem = 5268, after = 3050}, -- beholder
	},
	
	[5038] = {
		-- Demons
		[2916] = {value = 15000, newItem = 5275, after = 2917}, -- demon
		[5373] = {value = 15000, newItem = 5275, after = 5374}, -- ice demon
		[5371] = {value = 15000, newItem = 5275, after = 5372}, -- black demon

		-- Vampires
		[2956] = {value = 15000, newItem = 5274, after = 2957}, -- vampire
		[5676] = {value = 15000, newItem = 5274, after = 5677}, -- vampire
	}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local skin = config[item.itemid][target.itemid]

	if not skin then
		player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return true
	end

	local random, effect, transform = math.random(1, 100000), CONST_ME_MAGIC_GREEN, true
	if type(skin[1]) == 'table' then
		local added = false
		local _skin
		for i = 1, #skin do
			_skin = skin[i]	
		end

	elseif random <= skin.value then
			player:addItem(skin.newItem, skin.amount or 1)
		else
			effect = CONST_ME_BLOCKHIT
		end
	
	toPosition:sendMagicEffect(effect)
	if transform then
		target:transform(skin.after or target:getType():getDecayId() or target.itemid + 1)
	else 
		target:remove()		
	end

	return true
end