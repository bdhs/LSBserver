-----------------------------------
--  Frost Breath
--
--  Description: Deals ice damage to enemies within a fan-shaped area originating from the caster. Additional effect: Paralysis.
--  Type: Magical (Ice)
--
--
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    -- only used in Uleguerand_Range
    if (mob:getZoneID() == 5) then
        return 0
    end
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS

    MobStatusEffectMove(mob, target, typeEffect, 25, 0, 120)

    local dmgmod = MobBreathMove(mob, target, 0.333, 0.625, xi.magic.ele.ICE, 500)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.ICE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.ICE)
    return dmg
end

return mobskill_object
