-----------------------------------
-- ??? Needles
--
-- Description: Shoots multiple needles at enemies within range.
--
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    -- from http://ffxiclopedia.wikia.com/wiki/%3F%3F%3F_Needles
    -- "Seen totals ranging from 15, 000 to 55, 000 needles."
    local needles = math.random(15000, 55000) / skill:getTotalTargets()

    local dmg = MobFinalAdjustments(needles, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.LIGHT, MOBPARAM_WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.LIGHT)

    return dmg
end

return mobskill_object
