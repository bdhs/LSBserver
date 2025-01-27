-----------------------------------
-- Core Meltdown (Ghrah)
-- Reactor core fails and self-destructs, damaging any nearby targets.
-- Note: Very rare, estimated 5% chance
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if (mob:isMobType(MOBTYPE_NOTORIOUS)) then
        return 1
    elseif (mob:getAnimationSub() ~=0) then -- form check
        return 1
    elseif (math.random(1, 100) >= 5) then -- here's the 95% chance to not blow up
        return 1
    else
        return 0
    end
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1

    -- TODO: The damage type should be based off of the Ghrah's element
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*math.random(7, 15), xi.magic.ele.NONE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL, MOBPARAM_IGNORE_SHADOWS)
    mob:setHP(0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)
    return dmg
end

return mobskill_object
