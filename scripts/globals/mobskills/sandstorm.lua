-----------------------------------
-- Sandstorm
-- Kicks up a blinding dust cloud on targets in an area of effect.
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
    local typeEffect = xi.effect.BLINDNESS
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 15, 0, 120))

    return typeEffect
end

return mobskill_object
