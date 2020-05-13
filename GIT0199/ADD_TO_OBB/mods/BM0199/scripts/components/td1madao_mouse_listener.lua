--[[
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- @Description: modify mouse event for skill cast
 -- If any question ,Please email me using Chinese to let me distinguish whether it is spam
 -- @version 1.0.0
 -- @author td1madao
 -- @email td1madao@163.com
 -- @qq 360810498
 -- @date 16/8/6
 ]]

local Td1madao_mouse_listener = Class(function(self, inst)
    self.inst = inst
    local tmp = inst.components.playeractionpicker.DoGetMouseActions
    local new = function(force_target)
        local action, second_action = tmp(force_target)
        local weapon = td1madao_getPlayerWeapon()
        if weapon:HasTag(td1madao_getstr("%sbowtype")) or weapon:HasTag("notweapon") then
            return action, second_action
        end
        local hasBuffonTag = false
        local tag
        for k, v in pairs(inst.components.td1madao_skiller.skillCD) do
            if inst:HasTag(string.format("%sbuffon", k)) and inst[string.format("laterSkill%s", k)] then
                hasBuffonTag = true
                tag = k
                break
            end
        end
        if not hasBuffonTag then
            return action, second_action
        end
        second_action = BufferedAction(inst, nil, ACTIONS[td1madao_getupper('%sCASTCANCEL')])
        local useToPoint = inst[string.format("useToPoint%s", tag)]
        if useToPoint then
            local position = Vector3(TheInput:GetWorldPosition():Get())
            if not td1madao_canMoveTo(inst, position.x, 0, position.z) then
                return action, second_action
            end
        else
            local target = TheInput:GetWorldEntityUnderMouse()
            if not td1madao_alive(target) or target == inst then
                return action, second_action
            end
        end
        action = BufferedAction(inst, nil, ACTIONS[td1madao_getupper('%sCAST')])
        return action, second_action
    end
    inst.components.playeractionpicker.DoGetMouseActions = new
end)

return Td1madao_mouse_listener