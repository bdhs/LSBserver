-----------------------------------
-- Healing Ruby
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill)
    local base = 14+target:getMainLvl()+skill:getTP()/12
    if (pet:getMainLvl()>30) then
        base = 44 + 3*(pet:getMainLvl()-30) + skill:getTP()/12 * (pet:getMainLvl()*0.075 - 1)
    end

    if (target:getHP()+base > target:getMaxHP()) then
        base = target:getMaxHP() - target:getHP() --cap it
    end
    skill:setMsg(xi.msg.basic.SELF_HEAL)
    target:addHP(base)
    return base
end

return ability_object
