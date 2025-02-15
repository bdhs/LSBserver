-----------------------------------
--  Vitrolic Barrage
--
--  Description: Bombards nearby targets with acid, dealing fixed Water damage. Additional effect: Poison
--  Type: ??? (Water)
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: AoE 10'
--  Notes: Poison is 20/tic
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local needles = 1000 / skill:getTotalTargets()
    local typeEffect = xi.effect.POISON

    MobStatusEffectMove(mob, target, typeEffect, 20, 3, 60)

    local dmg = MobFinalAdjustments(needles, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.WATER, MOBPARAM_WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.WATER)

    return dmg
end

return mobskill_object
