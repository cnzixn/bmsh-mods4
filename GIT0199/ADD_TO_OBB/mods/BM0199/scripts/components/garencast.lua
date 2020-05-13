--[[
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- If any question ,Please email me using Chinese to let me distinguish whether it is spam
 -- @Description: undefined
 -- @version 1.0.0
 -- @author td1madao
 -- @email td1madao@163.com
 -- @qq 360810498
 -- @date 16/8/6
 ]]

-- never use ClearBufferedAction please!!

local Garencast = Class(function(self, inst)
    self.inst = inst
end)
function Garencast:CASTING(pt, caster)
    td1madao_runLatter(caster, 0.3, function()
        td1madao_flush()
    end)
    if not caster then
        return true
    end
    local target = TheInput:GetWorldEntityUnderMouse()
    if self.inst:HasTag("rbuffon") then
        if td1madao_alive(target) then
            self.inst.components.combat:SetTarget(target)
            return true
        end
    end
    return true
end

function Garencast:CANCEL()
    for k, v in pairs(self.inst.components.td1madao_skiller.skillCD) do
        td1madao_cancelSkillTask("listenForTarget" .. k, k)
    end
    td1madao_flush()
    return true
end

return Garencast