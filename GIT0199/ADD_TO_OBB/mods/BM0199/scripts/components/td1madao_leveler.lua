--[[
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- @Description: character can get exp and ...... money?
 -- If any question ,Please email me using Chinese to let me distinguish whether it is spam
 -- @version 1.0.0
 -- @author td1madao
 -- @email td1madao@163.com
 -- @qq 360810498
 -- @date 16/8/6
 ]]

-- I can not save exp here because old version save file save in character
-- this component only support method T_T

-- inst.components.td1madao_leveler:getCurrentExp()
local Td1madao_leveler = Class(function(self, inst)
    self.inst = inst
    self.baseExp = 15
    self.expRaise = 1.55
end)

-- public
-- inst.components.td1madao_leveler:getCurrentLevel()
function Td1madao_leveler:getCurrentLevel()
    self.inst.levelvaluenum = self.inst.levelvaluenum or 0
    return self.inst.levelvaluenum
end

-- public
-- inst.components.td1madao_leveler:getCurrentExp()
function Td1madao_leveler:getCurrentExp()
    if self:getCurrentLevel() >= 18 then
        self.inst.expvaluenum = 0
    end
    return self.inst.expvaluenum or 0
end

-- public
function Td1madao_leveler:getCurrentMoney()
    return self.inst.money or 0
end

-- public
-- inst.components.td1madao_leveler:obtainMoney()
function Td1madao_leveler:obtainMoney(num)
    local currentMoney = self:getCurrentMoney()
    if td1madao_invalidNum(num) then
        return currentMoney
    end
    currentMoney = currentMoney + num
    self.inst.money = currentMoney
    self:refreshStatus()
    return currentMoney
end

-- public
-- inst.components.td1madao_leveler:moneyEnough()
function Td1madao_leveler:moneyEnough(num)
    return self:getCurrentMoney() >= num
end

-- public
-- inst.components.td1madao_leveler:useMoney()
function Td1madao_leveler:useMoney(num)
    local currentMoney = self:getCurrentMoney()
    if td1madao_invalidNum(num) then
        return currentMoney
    end
    currentMoney = currentMoney - num
    if currentMoney < 0 then
        currentMoney = 0
    end
    self.inst.money = currentMoney
    self:refreshStatus()
    return currentMoney
end

-- public
function Td1madao_leveler:obtainExp(num)
    local currentExp = self:getCurrentExp()
    if td1madao_invalidNum(num) or self:getCurrentLevel() >= 18 then
        self.inst.expvaluenum = 0
        return currentExp
    end
    currentExp = currentExp + num
    self.inst.expvaluenum = currentExp
    if self:canLevelUp() then
        self:levelUp()
    end
    self:refreshStatus()
    return currentExp
end

-- public
-- inst.components.td1madao_leveler:refreshStatus()
function Td1madao_leveler:refreshStatus()
    if self.inst and self.inst.expvalue then
        self.inst.expvalue:SetString(self:getRefreshStr())
        self.inst.levelvalue:SetString(string.format("lv:%d", self:getCurrentLevel()))
    end
end

-- private
function Td1madao_leveler:getNextLevelExperience()
    local needExperience = self.baseExp
    for i = 1, self:getCurrentLevel() - 1 do
        needExperience = math.ceil(needExperience * self.expRaise)
    end
    return needExperience
end

-- private
function Td1madao_leveler:canLevelUp()
    return self:getCurrentExp() >= self:getNextLevelExperience() and self:getCurrentLevel() < 18
end

-- private todo
function Td1madao_leveler:levelUp()
    -- if level up
    local leveluped = false
    local inst = self.inst
    while self:canLevelUp() do
        inst.expvaluenum = inst.expvaluenum - self:getNextLevelExperience()
        self.inst.levelvaluenum = self.inst.levelvaluenum + 1
        leveluped = true
    end
    if leveluped then
        inst.components.td1madao_skill_pointer:getlolpointcanuse()
        inst.components.td1madao_attributer:levelUp()
        local fx2 = td1madao_deployBelow(inst, "statue_transition")
        td1madao_setColor(fx2, 0, .5, 1)
        fx2.Transform:SetScale(2, 2, 2)
        local fx = td1madao_deployBelow(inst, "explode_small")
        td1madao_setColor(fx2, .5, 1, 1)
        fx.Transform:SetScale(2, 2, 2)
    end
end

-- private
function Td1madao_leveler:getRefreshStr()
    return string.format("[exp:%d/%d\t\tmoney:%d]", self:getCurrentExp(), self:getNextLevelExperience(), self:getCurrentMoney())
end

return Td1madao_leveler