local config = {
	[5276] = {
		
		-- Minotaurs
		[2830] = {value = 25000, newItem = 5250, after = 2831}, -- minotaur
		[2871] = {value = 25000, newItem = 5250, after = 2872}, -- minotaur archer		
		[2866] = {value = 25000, newItem = 5250, after = 2867}, -- minotaur mage		
		[2876] = {value = 25000, newItem = 5250, after = 2877}, -- minotaur guard				
		
		-- Low Class Lizards
		[4259] = {value = 25000, newItem = 5248, after = 4260}, -- lizard sentinel
		[4262] = {value = 25000, newItem = 5248, after = 4263}, -- lizard snakecharmer
		[4256] = {value = 25000, newItem = 5248, after = 4257}, -- lizard templar

		-- Wolves
		
		[2827] = {value = 25000, newItem = 5267, after = 2828},
		[2924] = {value = 25000, newItem = 5267, after = 2925},
		[2969] = {value = 25000, newItem = 5267, after = 2970},
		
		-- Bears
		[2894] = {value = 25000, newItem = 5266, after = 2985},
		[2850] = {value = 25000, newItem = 5266, after = 2851},
		
		-- High Class Lizards
		[5351] = {value = 25000, newItem = 5248, after = 5352}, -- lizard legionnaire 		
		[5354] = {value = 25000, newItem = 5248, after = 5355}, -- lizard dragon priest
		[5348] = {value = 25000, newItem = 5248, after = 5349}, -- lizard high guard	

		-- Dragons
		[2844] = {value = 25000, newItem = 5249, after = 2845}, -- dragon
		[2881] = {value = 25000, newItem = 5294, after = 2882}, -- dragon lord
		[5613] = {value = 25000, newItem = 5294, after = 5614}, -- dragon king

		-- Behemoth
		[2931] = {value = 35000, newItem = 5263, after = 2932},

		-- Bone Beast
		[3031] = {value = 25000, newItem = 5289, after = 3032},
		
		-- Stone monsters
		[2952] = {value = 25000, newItem = 5252, after = 2953}, -- stone golem
		--[5347] = {value = 25000, newItem = 5252, after = 2257}, -- eternal guardian
		[3022] = {value = 25000, newItem = 5252, after = 3023}, -- gargoyle
		[5357] = {value = 25000, newItem = 5252, after = 5358}, -- earth elemental
		
		-- Beholders
		[2908] = {value = 25000, newItem = 5268, after = 2909}, -- beholder
		[3052] = {value = 25000, newItem = 5268, after = 3053}, -- beholder
		[3049] = {value = 15000, newItem = 5268, after = 3050}, -- beholder
	},
	
	[5038] = {
		-- Demons
		[2916] = {value = 25000, newItem = 5275, after = 2917}, -- demon
		[5373] = {value = 25000, newItem = 5275, after = 5374}, -- ice demon
		[5371] = {value = 25000, newItem = 5275, after = 5372}, -- black demon

		-- Vampires
		[2956] = {value = 25000, newItem = 5274, after = 2957}, -- vampire
		[5676] = {value = 25000, newItem = 5274, after = 5677}, -- vampire
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