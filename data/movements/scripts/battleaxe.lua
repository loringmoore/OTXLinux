local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_SKILL_AXEPERCENT, 150)
condition:setParameter(CONDITION_PARAM_TICKS, -1)

local condition2 = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_SKILL_DISTANCEPERCENT, 100)
condition:setParameter(CONDITION_PARAM_TICKS, -1)


function onEquip(cid, item)
    local player = Player(cid)
        player:addCondition(condition)
    return true
end

function onDeEquip(cid, item)
    local player = Player(cid)
    player:addCondition(condition2)
    return true
end