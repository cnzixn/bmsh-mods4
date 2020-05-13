--[[
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- @Description: use for init my player
 -- If any question ,Please email me using Chinese to let me distinguish whether it is spam
 -- @version 1.0.0
 -- @author td1madao
 -- @email td1madao@163.com
 -- @qq 360810498
 -- @date 16/8/6
 ]]

-- inst.components.td1madao_leveler:getCurrentExp()
local Td1madao_lol_player = Class(function(self, inst)
    self.inst = inst
    local enomous = td1madao_getupper('%s_ENOMOUS_MONSTER')
    self.inst.killmember = 0
    self.inst.deathtime = 0
    self.inst.alreadydust = false
    self.inst.belongtowhich = TUNING[td1madao_getupper('%sBELONG')]
    self.inst:AddTag(self.inst.belongtowhich)
    self.inst:AddTag("td1madao_special")
    self.inst.changecdtimes = 1
    self.inst.probtimes = 1
    self.inst.money = 0
    self.inst.cdtime = 1
    self.inst.expvaluenum = 0
    self.inst.levelvaluenum = 1
    self.inst.laowang = false
    self.inst.td1madaoSkin = { self.inst.prefab }
    self.peaceDay = 0
    self.warDay = 0

    self.inst.MiniMapEntity:SetIcon(td1madao_getstr("%s.tex"))
    if TUNING[enomous] == 2 then
        self.inst.probtimes = 2
    elseif TUNING[enomous] == 1 then
        self.inst.probtimes = 1
    else
        self.inst.probtimes = 0
    end
    self.inst.dif = 1
    if TUNING[enomous] == 2 then
        self.inst.dif = 0
    end
end)

function Td1madao_lol_player:OnSave()
    return
    {
        peaceDay = self.peaceDay,
        warDay = self.warDay
    }
end

function Td1madao_lol_player:OnLoad(data)
    if data ~= nil then
        if data.peaceDay ~= nil then
            self.peaceDay = data.peaceDay
        else
            self.peaceDay = 0
        end
        if data.warDay ~= nil then
            self.warDay = data.warDay
        else
            self.warDay = 0
        end
    end
end


return Td1madao_lol_player