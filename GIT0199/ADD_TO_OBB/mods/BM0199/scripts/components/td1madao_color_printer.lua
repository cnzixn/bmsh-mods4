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

local Td1madao_color_printer = Class(function(self, inst)
    self.inst = inst
end)

function Td1madao_color_printer:CollectUseActions(doer, target, actions)
    if target and target:HasTag("structure") then
        table.insert(actions, ACTIONS[td1madao_getupper("%sCOLOR")])
    end
end

return Td1madao_color_printer