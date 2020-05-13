--[[
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- @Description: my character has a skill bar hud
 -- If any question ,Please email me using Chinese to let me distinguish whether it is spam
 -- @version 1.0.0
 -- @author td1madao
 -- @email td1madao@163.com
 -- @qq 360810498
 -- @date 16/8/6
 ]]
local Badge = require "widgets/badge"

local MagicBadge = Class(Badge, function(self, owner)
    Badge._ctor(self, "beaver_meter", owner)
end)

-- inst.components.td1madao_leveler:getCurrentExp()
local Td1madao_magic_huder = Class(function(self, inst)
    self.inst = inst
    local magicName = td1madao_getstr("xxxmagic_%s")
    local eventName = td1madao_getstr("xxxmagic_%sdelta")
    self.inst.td1madao_magic_hud = self.inst:DoPeriodicTask(0.5, function()
        if self.inst.HUD and not self.inst.HUD.controls.magicbadge then
            if self.inst.td1madao_magic_hud then
                self.inst.td1madao_magic_hud:Cancel()
                self.inst.td1madao_magic_hud = nil
            end
            self.inst.HUD.controls.magicbadge = GetPlayer().HUD.controls.sidepanel:AddChild(MagicBadge(self.inst))
            self.inst.HUD.controls.magicbadge:SetPosition(-180, -105, 0)
            self.inst.HUD.controls.magicbadge.anim:GetAnimState():SetBuild(magicName)
            self.inst.HUD.controls.magicbadge:SetPercent(0)
            self.inst.HUD.controls.magicbadge.inst:ListenForEvent(eventName,
                function(_, data)
                    if not self.inst.components[magicName] then
                        self.inst:AddComponent(magicName)
                    end
                    self.inst.HUD.controls.magicbadge:SetPercent(self.inst.components[magicName]:GetPercent(), self.inst.components[magicName].max)
                    if data.newpercent > data.oldpercent then
                        self.inst.HUD.controls.magicbadge:PulseGreen()
                    elseif data.newpercent < data.oldpercent then
                        self.inst.HUD.controls.magicbadge:PulseRed()
                    end
                end, self.inst)
            if self.inst.components[magicName] then
                self.inst.components[magicName]:DoDelta(0, self.inst.prefab)
            end
        end
    end)
end)


return Td1madao_magic_huder