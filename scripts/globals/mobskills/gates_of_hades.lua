-----------------------------------
--  Gates of Hades
--
--  Description: Deals severe Fire damage to enemies within an area of effect. Additional effect: Burn
--  Type:  Magical
--
--
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 20' radial
--  Notes: Only used when a cerberus's health is 25% or lower (may not be the case for Orthrus). The burn effect takes off upwards of 20 HP per tick.
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
  if(mob:getFamily() == 316) then
    local mobSkin = mob:getModelId()

    if (mobSkin == 1793) then
        return 0
    else
        return 1
    end
  end
    local result = 1
    local mobhp = mob:getHPP()

    if (mobhp <= 25) then
        result = 0
    end

    return result
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.BURN
    local power = 21

    MobStatusEffectMove(mob, target, typeEffect, power, 3, 60)

    local dmgmod = 1.8
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*6, xi.magic.ele.FIRE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end

return mobskill_object
