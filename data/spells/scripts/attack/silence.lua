local tarmonster = true -- Can we cast this spell on monsters. Default is true
local ptime = 8000 -- This is how long the spell will last on a Player. Default is 8 seconds = 8000
local mtime = 10000 -- This is how long the spell will last on a Monster. Default is 10 seconds = 10000
 
local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
 
local mute = Condition(CONDITION_MUTED)
 
function onCastSpell(creature, var)
local tar = creature:getTarget()
 
    if tar:getCondition(CONDITION_MUTED) then
        return creature:sendTextMessage(MESSAGE_STATUS_SMALL, "This creature is already muted")
    end
    if tar:isPlayer() then 
        tar:say("^SILENCED^",TALKTYPE_MONSTER_SAY)
        mute:setParameter(CONDITION_PARAM_TICKS, ptime)
        combat:setCondition(mute)
        return combat:execute(creature, tar)
    end
    if tar:isMonster() and tarmonster then
        tar:say("^SILENCED^",TALKTYPE_MONSTER_SAY)
        mute:setParameter(CONDITION_PARAM_TICKS, mtime)
        combat:setCondition(mute)
        return combat:execute(creature, tar)
    else
        return creature:sendTextMessage(MESSAGE_STATUS_SMALL, "You can only use this spell on Players.")
    end
end