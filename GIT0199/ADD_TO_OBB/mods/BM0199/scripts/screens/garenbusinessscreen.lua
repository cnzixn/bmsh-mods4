require "util"
local Screen = require "widgets/screen"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
local Widget = require "widgets/widget"
local Text = require "widgets/text"
local textfont = UIFONT

GarenbusinessScreen = Class(Screen, function(self, goods, caller)
    Widget._ctor(self, "GarenbusinessScreen")
    self.root = self:AddChild(Widget("ROOT"))
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.itemspanel = self.root:AddChild(Image("images/globalpanels.xml", "panel.tex"))
    self.itemspanel:SetPosition(0, 0, 0)
    self.itemspanel:SetSize(800, 800)
    local label = self.itemspanel:AddChild(Text(textfont, 40, STRINGS.GARENMEMBERBUSINESSMANTITLE))
    label:SetPosition(-20, 240, 0)
    label:SetHAlign(ANCHOR_MIDDLE)
    local Garenslot = require "widgets/garenslot"
    local slots = self.root:AddChild(Widget("SLOTS"))
    slots:SetPosition(-280, 140, 0)
    local item = 1
    for i = 1, 7 do
        for j = 1, 5 do
            local obj = goods[item]
            if obj ~= nil then
                slots:AddChild(Garenslot(obj.name, (i - 1) * 90, (j - 1) * -90, 0, obj.value, obj.account, caller))
            end
            item = item + 1
        end
    end
    self.closebutton = self.itemspanel:AddChild(ImageButton())
    self.closebutton:SetText(STRINGS.UI.OPTIONS.CLOSE)
    self.closebutton:SetPosition(0, -300, 0)
    self.closebutton:SetScale(0.69)
    self.closebutton:SetOnClick(function() GetPlayer().tradeisopen = false TheFrontEnd:PopScreen() end)
    GetPlayer().tradeisopen = true
end)

return GarenbusinessScreen