--[[
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- @Description: change character attribute
 -- If any question ,Please email me using Chinese to let me distinguish whether it is spam
 -- @version 1.0.0
 -- @author td1madao
 -- @email td1madao@163.com
 -- @qq 360810498
 -- @date 16/8/6
 ]]
-- inst.components.td1madao_leveler:getCurrentExp()
local Td1madao_attributer = Class(function(self, inst)
    self.inst = inst
    self.attributes = {}
end)

-- inst.components.td1madao_attributer:setAttribute()
function Td1madao_attributer:setAttribute(att)
    self.attributes = att
end

-- refresh character base attribute
function Td1madao_attributer:setBaseAttr(myweapon, validWeapon)
    local inst = self.inst
    local tmplevel = inst.components.td1madao_leveler:getCurrentLevel()
    local weapon = td1madao_getPlayerWeapon()
    if myweapon and validWeapon then
        weapon = myweapon
    end
    local period = 1
    local greengem = weapon.greengem or 0
    local yellowgem = weapon.yellowgem or 0
    local bluegem = weapon.bluegem or 0
    local orangegem = weapon.orangegem or 0
    local purplegem = weapon.purplegem or 0
    if weapon.period then
        period = weapon.period
    end
    if not inst.components[td1madao_getstr("xxxmagic_%s")] then
        inst:AddComponent(td1madao_getstr("xxxmagic_%s"))
    end
    local loltmpabsorb = 0.003 * (td1madao_getRuneAtt(4) + inst.lolphysiquepoint) + self.attributes.defend + (tmplevel + bluegem * 2) * self.attributes.defendraise
    if loltmpabsorb >= 1 then
        loltmpabsorb = 0.8
    end
    if inst.components[td1madao_getstr("xxxmagic_%s")] and inst.components[td1madao_getstr("xxxmagic_%s")].armor == 0 then
        if inst.components.health.SetAbsorptionAmount then
            inst.components.health:SetAbsorptionAmount(loltmpabsorb)
        else
            inst.components.health.absorb = loltmpabsorb
        end
    end
    inst.absorb = loltmpabsorb
    inst.components.health.absorb = inst.absorb
    inst.components.sanity.night_drain_mult = self.attributes.afraid
    inst.components.sanity.neg_aura_mult = self.attributes.afraid
    inst.components.hunger.hungerrate = self.attributes.hungeryrate * self.attributes.hungeryratespeed
    inst.components.combat.damagemultiplier = self.attributes.attack + tmplevel * self.attributes.attackraise + (td1madao_getRuneAtt(1) + inst.lolattackpoint) * 0.0062
    if inst.components.combat.AddDamageModifier then
        inst.components.combat:AddDamageModifier(TD1MADAO_CHAR, self.attributes.attack + tmplevel * self.attributes.attackraise - 1)
    end
    inst.charcritmulti = inst.components.combat.damagemultiplier
    local maprd = self.attributes.attackspeedbase * (self.attributes.attackspeed - (tmplevel + yellowgem * 2) * self.attributes.attackspeedraise) * period - (td1madao_getRuneAtt(3) + inst.lolagilepoint) * 0.0006
    if maprd < 0.1 then
        maprd = 0.1
    end
    inst.components.combat.min_attack_period = maprd
    inst.components.locomotor.walkspeed = self.attributes.walkspeed * (self.attributes.charspeed + (tmplevel + yellowgem * 2) * self.attributes.charspeedraise) + (td1madao_getRuneAtt(3) + inst.lolagilepoint) * 0.006
    inst.components.locomotor.runspeed = self.attributes.runspeed * (self.attributes.charspeed + (tmplevel + yellowgem * 2) * self.attributes.charspeedraise) + (td1madao_getRuneAtt(3) + inst.lolagilepoint) * 0.006
    inst.walkspeedback = inst.components.locomotor.walkspeed
    inst.runspeedback = inst.components.locomotor.runspeed
    inst.cdtime = self.attributes.cdtime - (tmplevel + purplegem * 2) * self.attributes.cdtimeraise - (td1madao_getRuneAtt(4) + inst.lolphysiquepoint) * 0.001
    inst.charcrit = self.attributes.charcrit + (tmplevel + orangegem * 2) * self.attributes.charcritraise + (td1madao_getRuneAtt(3) + inst.lolagilepoint) * 0.0019
    inst.components.health:StartRegen(0.001 * (td1madao_getRuneAtt(4) + inst.lolphysiquepoint) + (self.attributes.heal + (self.attributes.healspeed * (tmplevel + greengem * 2))) * 4, 4)
    if weapon.td1madao_safeRemove then
        weapon.td1madao_safeRemove()
    end
end

-- refresh all attributes
function Td1madao_attributer:setattr(update)
    local inst = self.inst
    local tmplevel = inst.components.td1madao_leveler:getCurrentLevel() - 1
    inst.components.health.maxhealth = self.attributes.charhealth + tmplevel * self.attributes.charhealthraise + (td1madao_getRuneAtt(4) + inst.lolphysiquepoint) * 3
    inst.components.hunger.max = self.attributes.charhunger + tmplevel * self.attributes.charhungerraise + (td1madao_getRuneAtt(1) + inst.lolattackpoint) * 1
    inst.components.sanity.max = self.attributes.charsanity + tmplevel * self.attributes.charsanityraise + (td1madao_getRuneAtt(2) + inst.lolwisepoint) * 1
    if update then
        local curhealth = inst.components.health.currenthealth
        local curhunger = inst.components.hunger.current
        local cursanity = inst.components.sanity.current
        inst.components.health.currenthealth = curhealth + self.attributes.charhealthraise
        inst.components.hunger.current = curhunger + self.attributes.charhungerraise
        inst.components.sanity.current = cursanity + self.attributes.charsanityraise
        inst.components.health:DoDelta(0)
        inst.components.hunger:DoDelta(0)
        inst.components.sanity:DoDelta(0)
    end
    self:setBaseAttr()
end

-- inst.components.td1madao_attributer:refresh()
function Td1madao_attributer:refresh()
    self:setattr(false)
end

-- inst.components.td1madao_attributer:levelUp()
function Td1madao_attributer:levelUp()
    self:setattr(true)
end

-- inst.components.td1madao_attributer:changeWeapon()
function Td1madao_attributer:changeWeapon(weapon)
    self:setBaseAttr(weapon, true)
end

-- inst.components.td1madao_attributer:changeWeapon()
function Td1madao_attributer:removeWeapon()
    self:setBaseAttr(nil, false)
end

return Td1madao_attributer