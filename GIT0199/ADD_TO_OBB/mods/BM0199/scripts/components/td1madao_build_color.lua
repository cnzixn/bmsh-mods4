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

local Td1madao_build_color = Class(function(self, inst)
    self.inst = inst
    self.redcolor = 1
    self.greencolor = 1
    self.bluecolor = 1
end)

function Td1madao_build_color:OnSave()
    return
    {
        redcolor = self.redcolor,
        greencolor = self.greencolor,
        bluecolor = self.bluecolor
    }
end

function Td1madao_build_color:OnLoad(data)
    if data == nil then
        return
    end
    if data ~= nil then
        if data.redcolor ~= nil then
            self.redcolor = data.redcolor
        else
            self.redcolor = 1
        end
        if data.greencolor ~= nil then
            self.greencolor = data.greencolor
        else
            self.greencolor = 1
        end
        if data.bluecolor ~= nil then
            self.bluecolor = data.bluecolor
        else
            self.bluecolor = 1
        end
        self:Work()
    end
end

function Td1madao_build_color:Work()
    local inst = self.inst
    if inst and inst.AnimState and inst.AnimState.SetMultColour then
        inst.AnimState:SetMultColour(self.redcolor or 1, self.greencolor or 1, self.bluecolor or 1, 1)
    end
end

function Td1madao_build_color:SetColor(gem)
    local inst = self.inst
    if inst and gem then
        if gem.prefab == "redgem" then
            self.redcolor = 1
            self.greencolor = 0
            self.bluecolor = 0
        elseif gem.prefab == "greengem" then
            self.redcolor = 0
            self.greencolor = 1
            self.bluecolor = 0
        elseif gem.prefab == "bluegem" then
            self.redcolor = 0
            self.greencolor = 0
            self.bluecolor = 1
        elseif gem.prefab == "yellowgem" then
            self.redcolor = 1
            self.greencolor = 1
            self.bluecolor = 0
        elseif gem.prefab == "orangegem" then
            self.redcolor = 255 / 255
            self.greencolor = 160 / 255
            self.bluecolor = 122 / 255
        elseif gem.prefab == "purplegem" then
            self.redcolor = 1
            self.greencolor = 0
            self.bluecolor = 1
        end
        td1madao_safeRemove(gem)
        self:Work()
    end
end

return Td1madao_build_color