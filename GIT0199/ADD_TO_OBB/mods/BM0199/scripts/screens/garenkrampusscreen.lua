require "util"
local Screen = require "widgets/screen"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
local Widget = require "widgets/widget"
local Text = require "widgets/text"
local textfont = UIFONT

GarenkrampusScreen = Class(Screen, function(self, ambassador)
    Screen._ctor(self, "GarenkrampusScreen")
    self.active = true
    self.safeclose = false
    self.ambassador = ambassador
    SetPause(true, "pause")
    self.root = self:AddChild(Widget("ROOT"))
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.itemspanel = self.root:AddChild(Image("images/globalpanels.xml", "panel.tex"))
    self.itemspanel:SetPosition(0, 0, 0)
    self.itemspanel:SetSize(800, 500)
    local label = self.itemspanel:AddChild(Text(textfont, 60, STRINGS.TD1MADAOKRAMPUS_NEGOTIATION))
    label:SetPosition(0, 140, 0)
    label:SetHAlign(ANCHOR_MIDDLE)

    local label2 = self.itemspanel:AddChild(Text(textfont, 20, STRINGS.TD1MADAOKRAMPUS_NEGOTIATION_CONTENT))
    label2:SetPosition(0, 50, 0)
    label2:SetHAlign(ANCHOR_LEFT)

    self.closebutton2 = self.itemspanel:AddChild(ImageButton())
    self.closebutton2:SetText(STRINGS.TD1MADAOAMBASSADOR_AGREE)
    self.closebutton2:SetPosition(-200, -150, 0)
    self.closebutton2:SetScale(0.69)
    self.closebutton2:SetOnClick(function()
        if GetPlayer().components.td1madao_leveler:moneyEnough(500) then
            GetPlayer().components.td1madao_leveler:useMoney(500)
            GetPlayer().components.td1madao_lol_player_init.warDay = 0
            GetPlayer().components.td1madao_lol_player_init.peaceDay = 20
            self.safeclose = true
            self:Close()
            if td1madao_alive(ambassador) then
                local pt = GetPlayer():GetPosition()
                local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 9000, { "td1madao_krampus" })
                for k, v in pairs(ents) do
                    td1madao_safeRemove(v)
                end
                local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 9000, { "td1madao_kiki" })
                for k, v in pairs(ents) do
                    td1madao_safeRemove(v)
                end
            end
        end
    end)
    self.closebutton = self.itemspanel:AddChild(ImageButton())
    self.closebutton:SetText(STRINGS.TD1MADAOAMBASSADOR_REFUSE)
    self.closebutton:SetPosition(200, -150, 0)
    self.closebutton:SetScale(0.69)
    self.closebutton:SetOnClick(function() self:Close() end)
end)

function GarenkrampusScreen:Close()
    if not self.safeclose then
        local pt = GetPlayer():GetPosition()
        local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 9000, { "td1madao_krampus" })
        for k, v in pairs(ents) do
            local temp = td1madao_deployBelow(v, "krampus")
            if temp and temp.components.sleeper then
                temp.components.sleeper.sleeptestfn = function() return false end
            end
            td1madao_safeRemove(v)
        end
        local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 9000, { "td1madao_kiki" })
        for k, v in pairs(ents) do
            local temp = td1madao_deployBelow(v, "monkey")
            if temp and temp.components.sleeper then
                temp.components.sleeper.sleeptestfn = function() return false end
            end
            td1madao_safeRemove(v)
        end
    end
    self.active = false
    SetPause(false)
    TheFrontEnd:PopScreen()
end

function GarenkrampusScreen:OnControl(control, down)
    if GarenkrampusScreen._base.OnControl(self, control, down) then return true end
    if not down and control == CONTROL_CANCEL then
        self:Close()
        return true
    end
    return false
end


return GarenkrampusScreen