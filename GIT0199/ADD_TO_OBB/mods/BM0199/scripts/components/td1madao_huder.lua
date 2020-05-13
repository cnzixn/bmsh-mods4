--[[
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- @Description: my character has a skill bar hud
 -- If any question ,Please email me using Chinese to let me distinguish whether it is spam
 -- @version 1.0.0
 -- @author td1madao
 -- @email td1madao@163.com
 -- @qq 360810498
 -- @date 16/8/6
 ]]

local Text = require "widgets/text"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
-- inst.components.td1madao_leveler:getCurrentExp()
local Td1madao_huder = Class(function(self, inst)
    self.inst = inst
end)
function Td1madao_huder:AddScreen(screen)
    self.inst:DoTaskInTime(0, function()
        local player = self.inst
        local skillBar = td1madao_getstr('jinenglan_%s')
        local skillBarXml = td1madao_getstr("images/jinenglan_%s.xml")
        local skillBarTex = td1madao_getstr("jinenglan_%s.tex")
        local playerStatusXml = td1madao_getstr("images/selectscreen_portraits/%s.xml")
        local playerTex = td1madao_getstr("%s.tex")
        local playerStatusXml2 = td1madao_getstr("images/%s2.xml")
        local playerTex2 = td1madao_getstr("%s2.tex")
        if player and self.inst.HUD then
            local td1madao_global_widget = player.HUD.under_root:AddChild((require "widgets/widget")("td1madao_global_widget"))
            td1madao_global_widget:MoveToBack()
            td1madao_global_widget:SetScaleMode(SCALEMODE_PROPORTIONAL)
            player.td1madao_global_widget = td1madao_global_widget
            self.inst.HUD[skillBar] = player.td1madao_global_widget:AddChild(Image(skillBarXml, skillBarTex))
            self.inst.HUD[skillBar]:SetVRegPoint(ANCHOR_MIDDLE)
        self.inst.HUD[skillBar]:SetHRegPoint(ANCHOR_MIDDLE)
        self.inst.HUD[skillBar]:SetVAnchor(ANCHOR_MIDDLE)
        self.inst.HUD[skillBar]:SetHAnchor(ANCHOR_MIDDLE)
        --self.inst.HUD[skillBar]:SetScaleMode(SCALEMODE_FIXEDSCREEN_NONDYNAMIC)
        local screenx,screeny = TheSim:GetScreenSize()
        local scalex,scaley
        if screenx>screeny then
         scalex,scaley = screenx/1920,screeny/1080
        else
         scalex,scaley = screenx/1080,screeny/1920
        end
        local scalexy = math.max(scalex,scaley)
        self.inst.HUD[skillBar]:SetScale(2.5*scalexy)--(2.5,2,2)
        self.inst.HUD[skillBar]:SetPosition(0*scalex , -220*scaley , 0)
        
        self.inst.levelvalue = self.inst.HUD[skillBar]:AddChild(Text(BODYTEXTFONT, 40))
            self.inst.levelvalue:SetPosition(0, 65, 0)
            self.inst.levelvalue:SetColour(0.5, 0, 0, 1)
            self.inst.levelvalue:SetScale(.6)
            
           
            local diff = TUNING.LOLMEMBER.TALK100
            if TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER')] == 2 then
                diff = TUNING.LOLMEMBER.TALK101
            elseif TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER')] == 1 then
                diff = TUNING.LOLMEMBER.TALK102
            end
            player.HUD.controls.garen_botton:SetTooltip(string.format("%s-%s", STRINGS.TABS[td1madao_getupper('%sTABS')], diff))
            
            self.inst.chartips = self.inst.HUD[skillBar]:AddChild(Text(BODYTEXTFONT, 20))
            self.inst.chartips:SetPosition(0, 35, 0)
            self.inst.chartips:SetColour(0.5, 0, 0, 1)
            self.inst.chartips:SetScale(.6)
            self.inst.chartips:SetString(string.format("%s\n%s", STRINGS.TABS[td1madao_getupper('%sTABS')], diff))
            
            local qpz = player.HUD.controls.garen_botton:AddChild(Image(playerStatusXml2, playerTex2))
            qpz:SetPosition(17, 100, 0)
            qpz:SetScale(0.9)
            qpz:Hide()
            
            self.inst.youCanAddPoint = qpz
            self.inst.components.td1madao_skill_pointer:getlolpointcanuse()
            self.inst.expvalue = self.inst.HUD[skillBar]:AddChild(Text(BODYTEXTFONT, 25))
            self.inst.expvalue:SetPosition(0, 35, 0)
            self.inst.expvalue:SetColour(0, 0.5, 0, 1)
            self.inst.expvalue:SetScale(.6)
        end
        self.inst.components.td1madao_leveler:refreshStatus()
    end)
end

return Td1madao_huder


