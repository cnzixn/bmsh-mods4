--[[
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- @Description: skill point
 -- If any question ,Please email me using Chinese to let me distinguish whether it is spam
 -- @version 1.0.0
 -- @author td1madao
 -- @email td1madao@163.com
 -- @qq 360810498
 -- @date 16/8/6
 ]]
local Td1madao_skill_pointer = Class(function(self, inst)
    self.inst = inst
end)

-- public
-- inst.components.td1madao_skill_pointer:getlolpointcanuse()
function Td1madao_skill_pointer:getlolpointcanuse()
    local player = self.inst
    if not player.lolextpoint then
        player.lolextpoint = 0
    end
    if not player.lolattackpoint then
        player.lolattackpoint = 0
    end
    if not player.lolwisepoint then
        player.lolwisepoint = 0
    end
    if not player.lolphysiquepoint then
        player.lolphysiquepoint = 0
    end
    if not player.lolagilepoint then
        player.lolagilepoint = 0
    end
    player.lolpointcanuse = player.components.td1madao_leveler:getCurrentLevel() * 5 + player.lolextpoint
            - player.lolattackpoint - player.lolwisepoint - player.lolphysiquepoint - player.lolagilepoint
    while player.lolpointcanuse < 0 do
        if player.lolattackpoint > 0 then
            player.lolattackpoint = player.lolattackpoint - 1
        end
        if player.lolwisepoint > 0 then
            player.lolwisepoint = player.lolwisepoint - 1
        end
        if player.lolphysiquepoint > 0 then
            player.lolphysiquepoint = player.lolphysiquepoint - 1
        end
        if player.lolagilepoint > 0 then
            player.lolagilepoint = player.lolagilepoint - 1
        end
        player.lolpointcanuse = player.components.td1madao_leveler:getCurrentLevel() * 5 + player.lolextpoint
                - player.lolattackpoint - player.lolwisepoint - player.lolphysiquepoint - player.lolagilepoint
    end
    player.components.td1madao_attributer:refresh()
    if player.youCanAddPoint then
        if player.lolpointcanuse > 0 then
            player.youCanAddPoint:Show()
        else
            player.youCanAddPoint:Hide()
        end
    end
    return player.lolpointcanuse
end


return Td1madao_skill_pointer