-----------------------------------
-- Void of Repentance
--
-- Description: Fills a single target with regret, inflicting Terror.
-- Type: Enfeebling
-- Can be dispelled: N/A
-- Utsusemi/Blink absorb: Ignores shadows?
-- Range: Unknown
-- Notes: Accompanied by text
-- "Repent thy irreverence...
-- The gate to salvation...lies before thee...
-- Revelation...is within thy reach..."
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
    skill:setMsg(MobStatusEffectMove(mob, target, xi.effect.TERROR, 1, 0, 30))

    return xi.effect.TERROR
end

return mobskill_object
