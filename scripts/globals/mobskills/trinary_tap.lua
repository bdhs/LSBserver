-----------------------------------
-- Trinary Tap
-- Attempts to absorb three buffs from a single target, or otherwise steals HP.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores Shadows
-- Range: Melee
-- Notes: Can be any (positive) buff, including food. Will drain about 100HP if it can't take any buffs
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if (mob:isMobType(MOBTYPE_NOTORIOUS)) then
        return 0
    end
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    -- try to drain buff
    local effect1 = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
    local effect2 = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
    local effect3 = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
    local dmg = 0

    if (effect1 ~= 0) then
        local count = 1
        if (effect2 ~= 0) then
            count = count + 1
        end
        if (effect3 ~= 0) then
            count = count + 1
        end

        skill:setMsg(xi.msg.basic.EFFECT_DRAINED)

        return count
    else
        -- time to drain HP. 150-300
        local power = math.random(0, 151) + 150
        dmg = MobFinalAdjustments(power, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)

        skill:setMsg(MobPhysicalDrainMove(mob, target, skill, MOBDRAIN_HP, dmg))
        return dmg
    end

end

return mobskill_object
