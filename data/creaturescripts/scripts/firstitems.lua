-- Without Rookgaard
local config = {
	[1] = {
		--equipment spellbook, wand of vortex, magician's robe, mage hat, studded legs, leather boots, scarf
		items = {{2175, 1}, {2190, 1}, {2468, 1}, {2643, 1}, {2661, 1}},
		--container rope, shovel, mana potion
		container = {{2120, 1}, {2554, 1}, {7620, 1}}
	},
	[2] = {
		--equipment spellbook, snakebite rod, magician's robe, mage hat, studded legs, leather boots scarf
		items = {{2175, 1}, {2182, 1}, {2468, 1}, {2643, 1}, {2661, 1}},
		--container rope, shovel, mana potion
		container = {{2120, 1}, {2554, 1}, {7620, 1}}
	},
	[3] = {
		--equipment: wooden shield, jacket, leather legs, leather helmet
		items = {{2512, 1}, { {2650, 1}, {2649, 1}, {2461, 1}},
		--container rope, shovel, hand axe, rapier, wand of vortex, spellbook
		container = {{2120, 1}, {2554, 1}, {2389, 5}, {2380, 1}, {2384, 1}, {2401, 1}, {2190,1}, {2175,1}}
	},
	[4] = {
		--equipment dwarven shield, steel axe, brass armor, brass helmet, brass legs scarf
		items = {{2525, 1}, {2465, 1}, {2460, 1}, {2478, 1}, {2643, 1}, {2661, 1}},
		--container jagged sword, daramian mace, rope, shovel, health potion
		container = {{2439, 1}, {2120, 1}, {2554, 1}}
	}
}

function onLogin(player)
	local targetVocation = config[player:getVocation():getId()]
	if not targetVocation then
		return true
	end

	if player:getLastLoginSaved() ~= 0 then
		return true
	end

	for i = 1, #targetVocation.items do
		player:addItem(targetVocation.items[i][1], targetVocation.items[i][2])
	end

	local backpack = player:addItem(1988)
	if not backpack then
		return true
	end

	for i = 1, #targetVocation.container do
		backpack:addItem(targetVocation.container[i][1], targetVocation.container[i][2])
	end
	return true
end
