-- local freeBlessMaxLevel = 100 -->

function onLogin(player)
	--if player:getLevel() <= freeBlessMaxLevel then
		for i = 1, 6 do
			player:addBlessing(i)
			player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
		end
	-- end 

	-- if player:getStorageValue(Storage.FreeBless) == 1 then
		-- for i = 1, 6 do
			-- player:addBlessing(i)
			-- player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
		-- end
	-- end
		return true
end