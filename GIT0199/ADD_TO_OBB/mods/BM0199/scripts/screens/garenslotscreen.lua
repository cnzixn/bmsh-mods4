require "util"
local Screen = require "widgets/screen"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
local Widget = require "widgets/widget"
local Text = require "widgets/text"
local textfont = UIFONT

GarenslotScreen = Class(Screen, function(self, goods, caller, callermachine)
    Widget._ctor(self, "GarenslotScreen")
    self.root = self:AddChild(Widget("ROOT"))
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.itemspanel = self.root:AddChild(Image("images/globalpanels.xml", "panel.tex"))
    self.itemspanel:SetPosition(0, 0, 0)
    self.itemspanel:SetSize(800, 800)
    self.mycallermachine = callermachine
    self.mygoods = goods

    local Garenslot = require "widgets/garenslot"
    local slots = self.root:AddChild(Widget("SLOTS"))
    slots:SetPosition(-280, 140, 0)
    local item = 1
    local prize = 0
    local itemnumber = 0
    for i = 1, 7 do
        for j = 1, 5 do
            local obj = goods[item]
            if obj ~= nil then
                slots:AddChild(Garenslot(obj.name, (i - 1) * 90, (j - 1) * -90, 0, obj.value, obj.account, caller, true))
                prize = prize + obj.value
                itemnumber = itemnumber + 1
            end
            item = item + 1
        end
    end

    self.yellow = slots:AddChild(Image("images/garenyellow.xml", "garenyellow.tex"))
    self.yellow:SetPosition(0, 0, 0)
    self.yellow:SetSize(80, 80)
    self.yellowarrayx = 0
    self.yellowarrayxper = 90
    self.yellowarrayy = 0
    self.yellowarrayyper = -90
    self.currentposition = 0
    if itemnumber <= 1 then
        itemnumber = 1
    end
    self.totalitemnumber = itemnumber
    local avg = math.ceil(prize / itemnumber)
    if avg > 500 then
        avg = 500
    end
    if avg < 1 then
        avg = 1
    end
    self.avgmoney = avg
    local label = self.itemspanel:AddChild(Text(textfont, 40, string.format(STRINGS.GARENMEMBERBUSINESSMANSLOT, self.avgmoney)))
    label:SetPosition(GetPlayer().x or -20, GetPlayer().y or 240, 0)
    label:SetHAlign(ANCHOR_MIDDLE)
    self.choosebutton = self.itemspanel:AddChild(ImageButton())
    self.choosebutton:SetText(STRINGS.GARENMEMBERBUSINESSMANSLOTYES)
    self.choosebutton:SetPosition(-150, -300, 0)
    self.choosebutton:SetScale(0.69)
    self.choosebutton:SetOnClick(function() self:start() end)
    self.closebutton = self.itemspanel:AddChild(ImageButton())
    self.closebutton:SetText(STRINGS.GARENMEMBERBUSINESSMANSLOTNO)
    self.closebutton:SetPosition(150, -300, 0)
    self.closebutton:SetScale(0.69)
    self.closebutton:SetOnClick(function() GetPlayer().tradeisopen = false
    TheFrontEnd:PopScreen()
    end)
    GetPlayer().tradeisopen = true
end)

local function OnGetItemFromPlayer(inst, target)
    local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(0, 4.5, 0)
    local nug = td1madao_safespawn(target)
    if nug then
        nug.Transform:SetPosition(pt:Get())
        local down = TheCamera:GetDownVec()
        local angle = math.atan2(down.z, down.x) + (math.random() * 60 - 30) * DEGREES
        local sp = math.random() * 4 + 2
        if nug.Physics then
            nug.Physics:SetVel(sp * math.cos(angle), math.random() * 2 + 8, sp * math.sin(angle))
        end
    end
end

function GarenslotScreen:start()
    if self.alreadystart or self.mycallermachine.times >= 3 then
        return
    end
    self.finaltarget = math.random(self.totalitemnumber)
    self.moveslotnumber = self.finaltarget + self.totalitemnumber
    if self.mycallermachine and self.mycallermachine.taskqq then
        self.mycallermachine.taskqq:Cancel()
        self.mycallermachine.taskqq = nil
    end
    self.alreadymove = 0
    self.i = 0
    if not self.mycallermachine then
        GetPlayer().tradeisopen = false
        TheFrontEnd:PopScreen()
        return
    end
    if GetPlayer().components.td1madao_leveler:moneyEnough(self.avgmoney) then
        GetPlayer().components.td1madao_leveler:useMoney(self.avgmoney)
    else
        return
    end
    self.alreadystart = true
    if self.mycallermachine then
        self.mycallermachine.taskqq = self.mycallermachine:DoPeriodicTask(0.1, function()
            if self.alreadymove >= self.moveslotnumber then
                if self.mycallermachine.taskqq then
                    self.mycallermachine.taskqq:Cancel()
                    self.mycallermachine.taskqq = nil
                end
                if self.mycallermachine then
                    self.mycallermachine:DoTaskInTime(2, function()
                        if self.mycallermachine then
                            self.mycallermachine.times = self.mycallermachine.times + 1
                            OnGetItemFromPlayer(self.mycallermachine, self.mygoods[self.finaltarget].name)
                        end
                        if GetPlayer().tradeisopen then
                            self.alreadystart = false
                            GetPlayer().tradeisopen = false
                            TheFrontEnd:PopScreen()
                        end
                    end)
                else
                    self.alreadystart = false
                    GetPlayer().tradeisopen = false
                    TheFrontEnd:PopScreen()
                end
                return
            end
            local movey = (self.i % 35) % 5
            local movex = math.floor((self.i % 35) / 5)
            self.yellow:SetPosition(movex * self.yellowarrayxper, movey * self.yellowarrayyper, 0)
            self.i = self.i + 1
            self.alreadymove = self.alreadymove + 1
        end)
    end
end

return GarenslotScreen