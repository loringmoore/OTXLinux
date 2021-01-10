local spellName = "berserk"

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:hasLearnedSpell(spellName) then
        player:sendCancelMessage("You have already learned this spell.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
    else
        player:learnSpell(spellName)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have learned the spell ".. spellName)
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		item:remove(1)
    end
    return true
end