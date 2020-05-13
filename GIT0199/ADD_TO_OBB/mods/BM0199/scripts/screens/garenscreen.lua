local Screen = require "widgets/screen"
local Button = require "widgets/button"
local AnimButton = require "widgets/animbutton"
local Menu = require "widgets/menu"
local Text = require "widgets/text"
local Image = require "widgets/image"
local UIAnim = require "widgets/uianim"
local Widget = require "widgets/widget"
local PopupDialogScreen = require "screens/popupdialog"
local Grid = require "widgets/oldgrid"
local Spinner = require "widgets/spinner"
local ImageButton = require "widgets/imagebutton"
require "util"
require "strings"
local TextEdit = require "widgets/textedit"
local textfont = UIFONT
local hyra = 7
local hyrb = 4
local hyrc = 3
local hyrd = 6
local hyrar = 1.13
local hyrbr = 0.57
local hyrcr = 0.38
local hyrdr = 0.92
local functiongroup = {}
local constPri = 25000
local ott = 123

local enableDisableOptions = { { text = "hehe", data = false }, { text = "hoho", data = true } }
local function ShowLoading()
    if global_loading_widget then
        global_loading_widget:SetEnabled(true)
    end
end

local function dorestart()
    ShowLoading()
    EnableAllDLC()
    local player = GetPlayer()
    local can_save = player and player:IsValid() and player.components.health and not player.components.health:IsDead()
    local postsavefn = function()
        TheFrontEnd:HideSavingIndicator()
        local player = GetPlayer()
        if player then
            player:PushEvent("quit", {})
        else
            StartNextInstance()
        end
        inGamePlay = false
    end
    local ground = GetWorld()
    assert(ground, "Must have some terrain to get the map info.")
    local level_number = ground.topology.level_number or 1
    local level_type = ground.topology.level_type or "free"
    local day_number = GetClock().numcycles + 1
    if can_save then
        TheFrontEnd:ShowSavingIndicator()
    end
    TheFrontEnd:Fade(false, 1, function()
        if can_save then
            TheSystemService:EnableStorage(true)
            SaveGameIndex:SaveCurrent(postsavefn)
        else
            postsavefn()
        end
    end)
end

local GarenScreen = Class(Screen, function(self)

    Screen._ctor(self, "Hehe")
    self.active = true
    SetPause(true, "pause")
    self.proot = self:AddChild(Widget("ROOT"))
    self.proot:SetVAnchor(ANCHOR_MIDDLE)
    self.proot:SetHAnchor(ANCHOR_MIDDLE)
    self.proot:SetPosition(0, 0, 0)
    self.proot:SetScaleMode(SCALEMODE_PROPORTIONAL)

    local shield = self.proot:AddChild(Image("images/globalpanels.xml", "panel.tex"))
    shield:SetPosition(0, 0, 0)
    shield:SetSize(800, 900)

    local player = GetPlayer()

    local diff = TUNING.LOLMEMBER.TALK100
    if TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER')] == 2 then
        diff = TUNING.LOLMEMBER.TALK101
    elseif TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER')] == 1 then
        diff = TUNING.LOLMEMBER.TALK102
    end

    local label = self.proot:AddChild(Text(textfont, 40, string.format("%s-%s", STRINGS.TABS.GARENTABS, diff)))
    label:SetPosition(-20, 270, 0)
    label:SetRegionSize(200, 40)
    label:SetHAlign(ANCHOR_MIDDLE)

    self.grid1 = self.proot:AddChild(Grid())
    self.grid1:InitSize(1, 15, 700, -70)
    self.grid1:SetPosition(-180, 230, 0)
    self.grid1:SetScale(0.9, 0.6, 0.9)
    local spinners1 = {}
    table.insert(spinners1, { TUNING.LOLMEMBER.TALK36, function() return player.components.td1madao_leveler:getCurrentLevel() end, "hh", false, nil })
    table.insert(spinners1, { TUNING.LOLMEMBER.TALK37, function() return string.format('%s' .. TUNING.LOLMEMBER.TALK41 .. '/%s' .. TUNING.LOLMEMBER.TALK42, player.killmember, player.deathtime) end, "hh", false, nil })
    table.insert(spinners1, { TUNING.LOLMEMBER.TALK103, function() return string.format('%s%s', TUNING.LOLMEMBER.TALK104, player.finishTaskNum or 0) end, "hh", false, nil })
    table.insert(spinners1, { TUNING.LOLMEMBER.TALK38, function() return string.format("%.0f/%.0f", player.components.health.currenthealth, player.components.health.maxhealth) end, "hh", false, nil })
    table.insert(spinners1, { TUNING.LOLMEMBER.TALK39, function() return string.format("%.0f/%.0f", player.components.hunger.current, player.components.hunger.max) end, "hh", false, nil })
    table.insert(spinners1, { TUNING.LOLMEMBER.TALK40, function() return string.format("%.0f/%.0f", player.components.sanity.current, player.components.sanity.max) end, "hh", false, nil })
    table.insert(spinners1, {
        TUNING.LOLMEMBER.TALK76, function() return "" end, TUNING.LOLMEMBER.TALK76, true, function()
            local player = GetPlayer()
            if player and player.td1madao_rune then
                player:DoTaskInTime(0.3, function()
                    if player and player.td1madao_rune and player.td1madao_rune.components.container then
                        player.td1madao_rune.Transform:SetPosition(player:GetPosition():Get())
                        player.td1madao_rune.components.container:Open(player)
                    end
                end)
                self:Close()
            end
        end, { 1, 0, 0, 1 }
    })
    table.insert(spinners1, {
        TUNING.LOLMEMBER.TALK81, function() return "" end, TUNING.LOLMEMBER.TALK81, true, function()
            local confirm = PopupDialogScreen(TUNING.LOLMEMBER.TALK82, TUNING.LOLMEMBER.TALK82, { { text = TUNING.LOLMEMBER.TALK75, cb = function() TheFrontEnd:PopScreen() end } })
            confirm:SetTitleTextSize(40)
            confirm:SetButtonTextSize(30)
            confirm.title:SetPosition(0, 100, 0)
            confirm.text:SetSize(25)
            confirm.text:SetRegionSize(900, 600)
            confirm.text:SetPosition(150, 60, 0)
            confirm.text:SetHAlign(ANCHOR_LEFT)
            confirm.bg:SetScale(1.7, 1.5, 1.2)
            confirm.menu:SetPosition(0, -100, 0)
            local _x = -250
            local _y = 0
            for key, value in pairs(TUNING.LOLALLP) do
                local pic = "images/selectscreen_portraits/" .. value .. ".xml"
                if td1madao_file_exist(pic) and (not table.contains(_G.TUNING.LOLCHARGROUP, value) or value == GetPlayer().prefab) then
                    local have = false
                    if table.contains(GetPlayer().td1madaoSkin, value) then
                        have = true
                    end
                    local prize = 1
                    for i = 1, #value do
                        prize = prize + string.byte(string.sub(value, i, i)) * ott
                    end
                    prize = prize % constPri + constPri
                    prize = math.ceil(prize / 5)
                    local hehe = confirm.proot:AddChild(ImageButton(pic, value .. ".tex"))
                    hehe:SetPosition(_x, _y, 0)
                    hehe:SetScale(0.6)
                    hehe:SetOnClick(function()
                        if have then
                            if Prefabs[value] then
                                GetPlayer().usingSkin = value
                                if GetPlayer().refreshSkin then
                                    GetPlayer().refreshSkin()
                                end
                                TheFrontEnd:PopScreen()
                            end
                        elseif GetPlayer().components.td1madao_leveler:moneyEnough(prize) then
                            GetPlayer().components.td1madao_leveler:useMoney(prize)
                            table.insert(GetPlayer().td1madaoSkin, value)
                            TheFrontEnd:PopScreen()
                        end
                    end)
                    local textStr
                    if have then
                        textStr = TUNING.LOLMEMBER.TALK84
                    else
                        textStr = TUNING.LOLMEMBER.TALK83 .. prize
                    end
                    local label = hehe:AddChild(Text(textfont, 30, textStr))
                    label:SetPosition(50, _y - 100, 0)
                    label:SetRegionSize(200, 30)
                    label:SetHAlign(ANCHOR_LEFT)
                    if have then
                        label:SetColour(0, 1, 0, 1)
                    else
                        label:SetColour(1, 0, 0, 1)
                    end
                    _x = _x + 100
                end
            end
            TheFrontEnd:PushScreen(confirm)
            function confirm:OnControl(control, down)
                if confirm._base.OnControl(self, control, down) then return true end
                if not down and control == CONTROL_CANCEL then
                    self:Close()
                    return true
                end
                return false
            end
        end, { 1, 0, 0, 1 }
    })
    table.insert(spinners1, { TUNING.LOLMEMBER.TALK43, function() return player.lolattackpoint + td1madao_getRuneAtt(1) + hyra + math.floor(player.components.td1madao_leveler:getCurrentLevel() * hyrar) end, "+", true, function() if player.components.td1madao_skill_pointer:getlolpointcanuse(player) > 0 then player.lolattackpoint = player.lolattackpoint + 1 end end })
    table.insert(spinners1, { TUNING.LOLMEMBER.TALK44, function() return player.lolwisepoint + td1madao_getRuneAtt(2) + hyrb + math.floor(player.components.td1madao_leveler:getCurrentLevel() * hyrbr) end, "+", true, function() if player.components.td1madao_skill_pointer:getlolpointcanuse(player) > 0 then player.lolwisepoint = player.lolwisepoint + 1 end end })
    table.insert(spinners1, { TUNING.LOLMEMBER.TALK45, function() return player.lolagilepoint + td1madao_getRuneAtt(3) + hyrc + math.floor(player.components.td1madao_leveler:getCurrentLevel() * hyrcr) end, "+", true, function() if player.components.td1madao_skill_pointer:getlolpointcanuse(player) > 0 then player.lolagilepoint = player.lolagilepoint + 1 end end })
    table.insert(spinners1, { TUNING.LOLMEMBER.TALK46, function() return player.lolphysiquepoint + td1madao_getRuneAtt(4) + hyrd + math.floor(player.components.td1madao_leveler:getCurrentLevel() * hyrdr) end, "+", true, function() if player.components.td1madao_skill_pointer:getlolpointcanuse(player) > 0 then player.lolphysiquepoint = player.lolphysiquepoint + 1 end end })
    table.insert(spinners1, {
        TUNING.LOLMEMBER.TALK47, function() return player.components.td1madao_skill_pointer:getlolpointcanuse(player) end, TUNING.LOLMEMBER.TALK53, true, function()
            local confirm = PopupDialogScreen(TUNING.LOLMEMBER.TALK67, TUNING.LOLMEMBER.TALK68, { { text = TUNING.LOLMEMBER.TALK54, cb = function() TheFrontEnd:PopScreen() end } })
            confirm:SetTitleTextSize(40)
            confirm:SetButtonTextSize(30)
            confirm.title:SetPosition(0, 100, 0)
            confirm.text:SetSize(25)
            confirm.text:SetRegionSize(900, 600)
            confirm.text:SetPosition(150, 0, 0)
            confirm.text:SetHAlign(ANCHOR_LEFT)
            confirm.bg:SetScale(1.7, 1.5, 1.2)
            confirm.menu:SetPosition(0, -100, 0)
            TheFrontEnd:PushScreen(confirm)
            function confirm:OnControl(control, down)
                if confirm._base.OnControl(self, control, down) then return true end
                if not down and control == CONTROL_CANCEL then
                    self:Close()
                    return true
                end
                return false
            end
        end
    })
    table.insert(spinners1, {
        TUNING.LOLMEMBER.TALK48, function() return "" end, TUNING.LOLMEMBER.TALK49, true, function()
            local confirm = PopupDialogScreen(TUNING.LOLMEMBER.TALK49, TUNING.LOLMEMBER.TALK50, { { text = TUNING.LOLMEMBER.TALK51, cb = function() TheFrontEnd:PopScreen() end } })
            confirm:SetTitleTextSize(40)
            confirm:SetButtonTextSize(30)
            confirm.title:SetPosition(0, 100, 0)
            confirm.text:SetSize(25)
            confirm.text:SetRegionSize(900, 600)
            confirm.text:SetPosition(150, 60, 0)
            confirm.text:SetHAlign(ANCHOR_LEFT)
            confirm.bg:SetScale(1.7, 1.5, 1.2)
            confirm.menu:SetPosition(0, -100, 0)
            local _x = -250
            local _y = 0
            for key, value in pairs(TUNING.NOXUSCHAR) do
                local pic = "images/selectscreen_portraits/" .. key .. ".xml"
                local hehe = confirm.proot:AddChild(ImageButton(pic, key .. ".tex"))
                hehe:SetPosition(_x, _y, 0)
                hehe:SetScale(0.6)
                hehe:SetOnClick(function()
                    GetPlayer().prefab = key
                    GetPlayer().usingSkin = key
                    if not table.contains(GetPlayer().td1madaoSkin, key) then
                        table.insert(GetPlayer().td1madaoSkin, key)
                    end
                    dorestart()
                end)
                _x = _x + 100
            end
            for key, value in pairs(TUNING.DEMACIACHAR) do
                local pic = "images/selectscreen_portraits/" .. key .. ".xml"
                local hehe = confirm.proot:AddChild(ImageButton(pic, key .. ".tex"))
                hehe:SetPosition(_x, _y, 0)
                hehe:SetScale(0.6)
                hehe:SetOnClick(function()
                    GetPlayer().prefab = key
                    GetPlayer().usingSkin = key
                    if not table.contains(GetPlayer().td1madaoSkin, key) then
                        table.insert(GetPlayer().td1madaoSkin, key)
                    end
                    dorestart()
                end)
                _x = _x + 100
            end
            TheFrontEnd:PushScreen(confirm)
            function confirm:OnControl(control, down)
                if confirm._base.OnControl(self, control, down) then return true end
                if not down and control == CONTROL_CANCEL then
                    self:Close()
                    return true
                end
                return false
            end
        end, { 1, 0, 0, 1 }
    })

    for k, v in ipairs(spinners1) do self.grid1:AddItem(self:CreateSpinnerGroup(v[1], v[2], v[3], v[4], v[5], v[6]), 1, k) end
    self.grid2 = self.proot:AddChild(Grid())
    self.grid2:InitSize(1, 15, 700, -70)
    self.grid2:SetPosition(140, 230, 0)
    self.grid2:SetScale(0.9, 0.6, 0.9)
    local spinners2 = {}
    table.insert(spinners2, { TUNING.LOLMEMBER.TALK55, function() return player.components.td1madao_leveler:getCurrentExp() end, "hh", false, nil })
    table.insert(spinners2, { TUNING.LOLMEMBER.TALK65, function() return player.components.td1madao_leveler:getCurrentMoney() end, "hh", false, nil })
    table.insert(spinners2, { TUNING.LOLMEMBER.TALK56, function() return string.format("%.1f%%", player.components.combat.damagemultiplier * 100) end, "hh", false, nil })
    table.insert(spinners2, { TUNING.LOLMEMBER.TALK57, function() return string.format("%.1f%%", (td1madao_playerMagicDamage()) * 100) end, "hh", false, nil })
    table.insert(spinners2, { TUNING.LOLMEMBER.TALK58, function() return string.format("%.1f%%", td1madao_getPlayerRealDamagePercentage() * 100) end, "hh", false, nil })
    table.insert(spinners2, { TUNING.LOLMEMBER.TALK59, function() return string.format("%.1f%%", player.components.health.absorb * 100) end, "hh", false, nil })
    table.insert(spinners2, { TUNING.LOLMEMBER.TALK60, function() return string.format("%.1f%%", player.charcrit * 100) end, "hh", false, nil })
    table.insert(spinners2, { TUNING.LOLMEMBER.TALK61, function() return string.format("%.1f%%", 0.5 / player.components.combat.min_attack_period * 100) end, "hh", false, nil })
    table.insert(spinners2, { TUNING.LOLMEMBER.TALK62, function() return string.format("%.1f%%", player.runspeedback * 100 / 6) end, "hh", false, nil })
    table.insert(spinners2, { "cd:", function() return string.format("%.1f%%", player.cdtime * 100) end, "hh", false, nil })
    table.insert(spinners2, { TUNING.LOLMEMBER.TALK63, function() return string.format("%.1f", player.components.health.regen.amount * 1000) end, "hh", false, nil })
    table.insert(spinners2, { TUNING.LOLMEMBER.TALK64, function() local yztme = player.lolphysiquepoint * 0.009 if yztme > 1 then yztme = 0.9 end return string.format("%.1f%%", (1 - yztme) * 100) end, "hh", false, nil })
    table.insert(spinners2, {
        TUNING.LOLMEMBER.TALK77, function() return "" end, TUNING.LOLMEMBER.TALK77, true, function()
            local confirm = PopupDialogScreen(TUNING.LOLMEMBER.TALK78, TUNING.LOLMEMBER.TALK79, { { text = TUNING.LOLMEMBER.TALK75, cb = function() TheFrontEnd:PopScreen() end }, { text = TUNING.LOLMEMBER.TALK80, cb = function() VisitURL("https://my.oschina.net/tdONEmadao/blog/822517") end } })
            confirm:SetTitleTextSize(40)
            confirm:SetButtonTextSize(30)
            confirm.title:SetPosition(0, 100, 0)
            confirm.text:SetSize(25)
            confirm.text:SetRegionSize(900, 600)
            confirm.text:SetPosition(150, 60, 0)
            confirm.text:SetHAlign(ANCHOR_LEFT)
            confirm.bg:SetScale(1.7, 1.5, 1.2)
            confirm.menu:SetPosition(0, -100, 0)
            local _x = -250
            local _y = 0

            TheFrontEnd:PushScreen(confirm)
            function confirm:OnControl(control, down)
                if confirm._base.OnControl(self, control, down) then return true end
                if not down and control == CONTROL_CANCEL then
                    self:Close()
                    return true
                end
                return false
            end
        end, { 0, 1, 0, 1 }
    })

    table.insert(spinners2, {
        TUNING.LOLMEMBER.TALK105, function() return "" end, TUNING.LOLMEMBER.TALK105, true, function()
            self:Close()
        end
    })

    for k, v in ipairs(spinners2) do self.grid2:AddItem(self:CreateSpinnerGroup(v[1], v[2], v[3], v[4], v[5], v[6]), 1, k) end
end)


function GarenScreen:CreateSpinnerGroup(text, fn2, text3, button, fn, color)
    if not color then
        color = { 1, 1, 1, 1 }
    else
        text = "*" .. text
    end
    local label_width = 200
    local group = Widget("SpinnerGroup")
    local textTmp = Text(textfont, 30, text)
    textTmp:SetColour(color[1] or 1, color[2] or 1, color[3] or 1, color[4] or 1)
    local label = group:AddChild(textTmp)
    label:SetPosition(0, 0, 0)
    label:SetRegionSize(label_width, 30)
    label:SetHAlign(ANCHOR_LEFT)
    local label2 = group:AddChild(Text(textfont, 30, fn2()))
    local par2 = 80
    local par3 = 150
    if not string.find(string.upper(STRINGS.NAMES.GRASS), 'GRASS') then
        local par2 = 0
        local par3 = 100
    end
    label2:SetPosition(par2, 0, 0)
    label2:SetRegionSize(label_width, 30)
    label2:SetHAlign(ANCHOR_MIDDLE)
    table.insert(functiongroup, function()
        label2:SetString(fn2())
    end)
    if button then
        local label3 = group:AddChild(Menu(nil, 200, true))
        label3:SetPosition(par3, 0, 0)
        label3:SetScale(0.6)
        label3:SetHRegPoint(ANCHOR_RIGHT)
        if not fn then
            fn = function() end
        end
        label3:AddItem(text3, function()
            fn()
            for i = 1, #functiongroup do
                functiongroup[i]()
            end
        end)
    end
    return group
end

function GarenScreen:Close()
    self.active = false
    SetPause(false)
    TheFrontEnd:PopScreen()
end

function GarenScreen:OnControl(control, down)
    if GarenScreen._base.OnControl(self, control, down) then return true end
    if not down and control == CONTROL_CANCEL then
        self:Close()
        return true
    end
    return false
end


return GarenScreen