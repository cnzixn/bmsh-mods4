--[[
 -- @Description: here will not save any data For compatibility with older versions save file
 -- If any question ,Please email me using Chinese to let me distinguish whether it is spam
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- @version 1.0.0
 -- @author td1madao
 -- @email td1madao@163.com
 -- @qq 360810498
 -- @date 16/8/6
 ]]
local Garen_skill_fx = Class(function(self, inst)
    self.inst = inst
end)

function Garen_skill_fx:showQSkillLight()
    local player = self.inst
    local fx1 = td1madao_deployAsChild(player, 'forcefieldfx')
    td1madao_setColor(fx1, 0, 0, 1)
    fx1.AnimState:PlayAnimation("idle_loop", true)
    td1madao_setPosition(fx1, -0.4, 0, 0)
    local fx2 = td1madao_deployAsChild(player, 'forcefieldfx')
    td1madao_setColor(fx2, 0, 0, 1)
    fx2.AnimState:PlayAnimation("idle_loop", true)
    td1madao_setPosition(fx2, 0.4, 0, 0)
    local fx3 = td1madao_setPosition(td1madao_deployAsChild(player, "garenqlight"), -0.4, 0.3, 0)
    local fx4 = td1madao_setPosition(td1madao_deployAsChild(player, "garenqlight"), 0.4, 0.3, 0)
    local fx5 = td1madao_setColor(td1madao_deployAsChild(player, 'moose_nest_fx'), 1, 0, 0)
    player:DoTaskInTime(0.2, function()
        td1madao_safeRemove(fx1)
        td1madao_safeRemove(fx2)
        td1madao_safeRemove(fx3)
        td1madao_safeRemove(fx4)
        td1madao_safeRemove(fx5)
    end)
end

function Garen_skill_fx:removeEkillObserver()
    td1madao_removeTask(self.inst, "testrskilltarget2", function() self.inst:RemoveTag("ebuffon") end)
end

function Garen_skill_fx:usePassiveSkill(v)
    local abi = self.inst.passiveAbility
    if td1madao_isAlive(abi) then
        abi = nil
    elseif abi and not abi.components.health then
        abi = nil
    end
    if v and not abi then
        self.inst.passiveAbility = v
        v.absorbbackup = v.components.health.absorb
        td1madao_setArmor(v, td1madao_noNegative(v.components.health.absorb - 0.15))
        local fx2 = td1madao_deployAsChild(v, "garentag")
        fx2.Transform:SetPosition(0, 1.5, 0)
        fx2.Transform:SetScale(1.2, 1.2, 1.2)
        v:DoTaskInTime(3, function()
            if td1madao_isAlive(v) then
                GetPlayer().passiveAbility = nil
                if v.absorbbackup then
                    td1madao_setArmor(v, td1madao_noNegative(v.absorbbackup))
                end
            end
        end)
    end
end


return Garen_skill_fx