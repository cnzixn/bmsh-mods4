require "util"
local Screen = require "widgets/screen"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
local Widget = require "widgets/widget"
local Text = require "widgets/text"
local textfont = UIFONT

GarenmemberambassadorScreen = Class(Screen, function(self, ambassador)
    Screen._ctor(self, "GarenmemberambassadorScreen")
    self.active = true
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
    local label = self.itemspanel:AddChild(Text(textfont, 60, STRINGS.TD1MADAOAMBASSADOR_NEGOTIATION))
    label:SetPosition(0, 140, 0)
    label:SetHAlign(ANCHOR_MIDDLE)

    local label2 = self.itemspanel:AddChild(Text(textfont, 20, string.format(STRINGS.TD1MADAOAMBASSADOR_NEGOTIATION_CONTENT, TUNING.LOLMEMBER[TUNING[td1madao_getupper('%sENEMY')]], TUNING.LOLMEMBER[TUNING[td1madao_getupper('%sENEMY')]], TUNING.LOLMEMBER[TUNING[td1madao_getupper('%sENEMY')]], TUNING.LOLMEMBER[TUNING[td1madao_getupper('%sENEMY')]])))
    label2:SetPosition(0, 50, 0)
    label2:SetHAlign(ANCHOR_LEFT)

    self.closebutton2 = self.itemspanel:AddChild(ImageButton())
    self.closebutton2:SetText(STRINGS.TD1MADAOAMBASSADOR_AGREE)
    self.closebutton2:SetPosition(-200, -150, 0)
    self.closebutton2:SetScale(0.69)
    self.closebutton2:SetOnClick(function()
        if GetPlayer().components.td1madao_leveler:moneyEnough(5000) then
            GetPlayer().components.td1madao_leveler:useMoney(5000)
            GetPlayer().components.td1madao_lol_player_init.warDay = 0
            GetPlayer().components.td1madao_lol_player_init.peaceDay = 20
            self:Close()
            if td1madao_alive(ambassador) then
                ambassador:DoTaskInTime(0.5, function()
                    if td1madao_alive(ambassador) and ambassador.kill_fx then
                        ambassador.kill_fx(ambassador)
                    end
                end)
            end
        end
    end)

    self.closebutton = self.itemspanel:AddChild(ImageButton())
    self.closebutton:SetText(STRINGS.TD1MADAOAMBASSADOR_WAIT)
    self.closebutton:SetPosition(200, -150, 0)
    self.closebutton:SetScale(0.69)
    self.closebutton:SetOnClick(function() self:Close() end)
end)

function GarenmemberambassadorScreen:Close()
    self.active = false
    SetPause(false)
    TheFrontEnd:PopScreen()
end

function GarenmemberambassadorScreen:OnControl(control, down)
    if GarenmemberambassadorScreen._base.OnControl(self, control, down) then return true end
    if not down and control == CONTROL_CANCEL then
        self:Close()
        return true
    end
    return false
end


return GarenmemberambassadorScreen