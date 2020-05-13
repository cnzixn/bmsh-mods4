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
local _G = GLOBAL
local thisCharacter = 'garen'
_G.TD1MADAO_CHAR = thisCharacter
modimport("scripts/td1madao/td1madao_init_variable.lua")
modimport("scripts/td1madao/td1madao_init_tuning.lua")
modimport("scripts/td1madao/td1madao_syntactic_sugar.lua")
modimport("scripts/td1madao/td1madao_compatible.lua")
modimport("scripts/td1madao/td1madao_system_util.lua")
modimport("scripts/td1madao/td1madao_lua_extension.lua")
modimport("scripts/td1madao/td1madao_personal_util.lua")
modimport(td1madao_getstr("scripts/td1madao_%s_mod_resource.lua"))
modimport("scripts/td1madao/td1madao_lol_variable.lua")
td1madao_s(td1madao_getupper('%sBELONG'), "demaciamem")
td1madao_s(td1madao_getupper('%sENEMY'), "noxusmem")
td1madao_s(td1madao_getupper('%sBELONGNAME'), td1madao_getstr('%smemberd'))
td1madao_s(td1madao_getupper('%sENEMYNAME'), td1madao_getstr('%smembern'))
_G.TUNING.tdabmadao = { 111, 102, 101, 113, 101, 113, 59, 59, 97, 118, 102, 51, 111, 99, 102, 99, 113 }
_G.TUNING.tdbbmadao = { 106, 118, 118, 114, 117, 60, 49, 49, 105, 107, 118, 48, 113, 117, 101, 106, 107, 112, 99, 48, 112, 103, 118, 49, 118, 102, 52, 111, 99, 102, 99, 113, 49, 102, 103, 111, 113, 49, 116, 99, 121, 49, 111, 99, 117, 118, 103, 116, 49, 39, 117, 48, 108, 117, 113, 112 }
_G.TUNING.DEMACIACHAR[_G.TD1MADAO_CHAR] = true
_G.TUNING.GARENWEAPONNUM = 32
_G.STRINGS.CHARACTER_TITLES.garen = " garen "
_G.STRINGS.CHARACTER_NAMES.garen = "Esc"
_G.STRINGS.CHARACTER_DESCRIPTIONS.garen = " * 4 skills \n* 1 passive ability \n* Demacia...... "
_G.STRINGS.CHARACTER_QUOTES.garen = "\" My heart and sword always for Demacia. \""
table.insert(_G.CHARACTER_GENDERS.MALE, _G.TD1MADAO_CHAR)
modimport(td1madao_getstr("scripts/td1madao_%s_mod_translate.lua"))
modimport(td1madao_getstr("scripts/yiyurecipes%s.lua"))
modimport(td1madao_getstr("scripts/sarirecipes%s.lua"))
modimport(td1madao_getstr("scripts/otherrecipes%s.lua"))
modimport("scripts/td1madao/td1madao_segment.lua")
modimport("scripts/td1madao/td1madao_post_init.lua")
modimport("scripts/td1madao_garen_post_init.lua")
-- different character attack actions are different
local function garenchangeAttack(sg, SHIP)
    if sg and sg.states and sg.states["attack"] then
        local state = sg.states["attack"]
        local old_onenter = state.onenter
        state.onenter = function(inst)
            local weapon = _G.td1madao_getPlayerWeapon()
            if weapon and inst:HasTag("qbuffon") and inst.prefab == 'garen' then
                if SHIP and inst and inst.components.driver and inst.components.driver.vehicle then
                    inst.components.driver.vehicle:Show()
                end
                local target = inst.components.combat.target
                inst:ForceFacePoint(target:GetPosition():Get())
                _G.td1madao_playerPause()
                if SHIP then
                    inst.AnimState:PlayAnimation("jumpboat")
                else
                    inst.AnimState:PlayAnimation("jump")
                end
                inst:DoTaskInTime(.4, function(inst)
                    inst.AnimState:PlayAnimation("atk", false)
                    inst.cancelQEffect(inst)
                end)
                inst:DoTaskInTime(.6, function(inst)
                    _G.td1madao_safeRemoveAfter(_G.td1madao_deployBelow(target, "rskill"), 3)
                    _G.td1madao_safeRemoveAfter(_G.td1madao_deployBelow(target, "sparks"), 3)
                    _G.td1madao_safeRemoveAfter(_G.td1madao_deployBelow(target, "explode_small"), 3)
                    if _G.td1madao_alive(target) then
                        local tmp = _G.td1madao_deployAsChild(target, "garenslience")
                        tmp.Transform:SetScale(1.2, 1.2, 1.2)
                        tmp.Transform:SetPosition(0, 1.5, 0)
                        _G.td1madao_safeRemoveAfter(tmp, 3)
                    end
                    if target and target.components.combat then
                        target.components.combat:BlankOutAttacks(3.5)
                    end
                    inst.components.playercontroller:Enable(true)
                end)
                inst:DoTaskInTime(1.2, function(inst)
                    if SHIP and inst and inst.components.driver and inst.components.driver.vehicle then
                        inst.components.driver.vehicle:Hide()
                    end
                end)
            elseif weapon and weapon:HasTag("garenbowtype") and inst.prefab == 'garen' then
                _G.td1madao_shoot(thisCharacter)
            else
                old_onenter(inst)
            end
        end
    end
end

local animat = {
    "emote_feet",
    "emote_pants",
    "emote_strikepose",
    "emote_waving",
    "emoteXL_annoyed",
    "emoteXL_facepalm",
    "emoteXL_kiss",
    "emoteXL_waving4",
    "emoteXL_loop_dance0",
}
local modname = _M.modname
local function currentVer()
    local version
    _G.td1madao_try(function()
        version = _G.KnownModIndex:LoadModInfo(modname).version
    end)
    return version
end

local loop = {
    "emoteXL_loop_dance0"
}

local function garenchangeIdle(sg)
    if sg and sg.states and sg.states["funnyidle"] then
        local state = sg.states["funnyidle"]
        local old_onenter = state.onenter
        state.onenter = function(inst)
            if math.random() < 0.8 then
                local ani = animat[math.random(#animat)]
                if loop[ani] ~= nil then
                    inst.AnimState:PlayAnimation(ani, true)
                else
                    inst.AnimState:PlayAnimation(ani)
                end
            else
                old_onenter(inst)
            end
        end
    end
end

AddSimPostInit(function(inst)
    if not _G.TUNING.LOLLOAD then
        _G.TUNING.LOLLOAD = true
        _G.TUNING.LOLCHAR = _G.td1madao_isLolChar(inst)
    end
    if inst.prefab == thisCharacter then
        inst.currentVer = currentVer
        modimport(td1madao_getstr("scripts/%schinese.lua", thisCharacter))
        if _G.td1madao_isInSW() then
            table.insert(_G.TUNING.td1madao_spot_marks, { 'frog_poison', 0.02 })
            table.insert(_G.TUNING.td1madao_spot_marks, { 'snake_poison', 0.02 })
        end
        if inst.sg and inst.sg.sg then
            inst:DoTaskInTime(1, function()
                garenchangeAttack(inst.sg.sg, false)
                garenchangeIdle(inst.sg.sg)
            end)
        end
        _G.td1madao_confirmPlayer(thisCharacter)
        _G.td1madao_SpawnShrine()
        if not _G.EQUIPSLOTS.BACK and not _G.EQUIPSLOTS.NECK and not _G.EQUIPSLOTS.PACK then
            _G.td1madao_editStateFn("wilson", "amulet_rebirth", "onexit", _G.td1madao_newOnExit)
        end
        if not inst.started and _G.GetClock().numcycles == 0 then
            modimport(td1madao_getstr("scripts/td1madao_%s_start_inv.lua", thisCharacter))
        end
        modimport(td1madao_getstr("scripts/td1madao_%s_recipes.lua", thisCharacter))
        modimport("scripts/td1madao/td1madao_pet_init.lua")
        modimport("scripts/td1madao/td1madao_hostile_change.lua")
    else
        _G.td1madao_convertMemberType(thisCharacter, inst)
    end
end)

_G.td1madao_initPlayerCast(garenchangeAttack)


--载入garen_Screen界面
local garen_Screen = require "screens/garenscreen"
--载入ImageButton，用于
local ImageButton = require "widgets/imagebutton"
--图片按钮函数
local ImageButtonFn =  function(self)
 if GetPlayer().prefab == "garen" then
   --添加按钮garen_botton，ImageButton里面的图片资源，在原moamain挑一个你喜欢的。
   self.garen_botton = self.sidepanel:AddChild(ImageButton("images/map_icons/garen.xml", "garen.tex","garen.tex"))
   --设置按钮garen_botton的位置
   self.garen_botton:SetPosition(-50, -340, 0)
   --设置按钮garen_botton图标缩放
   self.garen_botton:SetScale( .7, .7, .7)
   --设置按钮garen_botton点击事件
   self.garen_botton:SetOnClick(
        --点击时调用的函数
        function()
        --显示garen_Screen界面
        TheFrontEnd:PushScreen(garen_Screen(self))
        end)
   --重写self:SetHUDSize函数
   local OldSetHUDSize = self.SetHUDSize
   function self:SetHUDSize()
    OldSetHUDSize(self)
    --获取当前hud尺寸
    local scale = GLOBAL.TheFrontEnd:GetHUDScale()
    if scale > 1.4 then
      --设置按钮garen_botton的位置
      self.garen_botton:SetPosition(-65, -345, 0)
    elseif scale <= 1.4 and scale >1.3 then
      self.garen_botton:SetPosition(-60, -380, 0)
    elseif scale <= 1.3 and scale >1.2 then
      self.garen_botton:SetPosition(10, -340, 0)
    elseif scale > 1.1 and scale <= 1.2 then
      self.garen_botton:SetPosition(10, -360, 0)
    elseif scale > 1 and scale <1.1 then
      self.garen_botton:SetPosition(10, -380, 0)
    elseif scale <= 1 then
      self.garen_botton:SetPosition(10, -400, 0)
    end
   end--重写self:SetHUDSize函数结束
  end
end--图片按钮函数结束
--HUD显示和隐藏函数
local HUDshowhide = function(self)
 --重写self:ShowHUD函数
 local OldShowHUD = self.ShowHUD
 function self:ShowHUD()
    OldShowHUD(self)
    --显示按钮garen_botton
    if GetPlayer().prefab == "garen" then
    GetPlayer().HUD.controls.garen_botton:Show()
    end
 end
 --self:HideHUD函数
 local OldHideHUD = self.HideHUD
 function self:HideHUD()
    OldHideHUD(self)
    --隐藏按钮garen_botton
    if GetPlayer().prefab == "garen" then
    GetPlayer().HUD.controls.garen_botton:Hide()
    end
 end
end--HUD显示和隐藏函数结束

--将图片按钮函数添加到"widgets/controls"
AddClassPostConstruct("widgets/controls", ImageButtonFn)
--点击制作栏，hud显示和隐藏
AddClassPostConstruct("widgets/crafttabs",HUDshowhide)
--点击物品栏，hud显示和隐藏
AddClassPostConstruct("widgets/inventorybar",HUDshowhide)
