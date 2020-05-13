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
local MakePlayerCharacter = require "prefabs/player_common"
local assets = {
    Asset("ANIM", "anim/player_basic.zip"),
    Asset("ANIM", "anim/player_idles_shiver.zip"),
    Asset("ANIM", "anim/player_actions.zip"),
    Asset("ANIM", "anim/player_actions_axe.zip"),
    Asset("ANIM", "anim/player_actions_pickaxe.zip"),
    Asset("ANIM", "anim/player_actions_shovel.zip"),
    Asset("ANIM", "anim/player_actions_blowdart.zip"),
    Asset("ANIM", "anim/player_actions_eat.zip"),
    Asset("ANIM", "anim/player_actions_item.zip"),
    Asset("ANIM", "anim/player_actions_uniqueitem.zip"),
    Asset("ANIM", "anim/player_actions_bugnet.zip"),
    Asset("ANIM", "anim/player_actions_fishing.zip"),
    Asset("ANIM", "anim/player_actions_boomerang.zip"),
    Asset("ANIM", "anim/player_bush_hat.zip"),
    Asset("ANIM", "anim/player_attacks.zip"),
    Asset("ANIM", "anim/player_idles.zip"),
    Asset("ANIM", "anim/player_rebirth.zip"),
    Asset("ANIM", "anim/player_jump.zip"),
    Asset("ANIM", "anim/player_amulet_resurrect.zip"),
    Asset("ANIM", "anim/player_teleport.zip"),
    Asset("ANIM", "anim/wilson_fx.zip"),
    Asset("ANIM", "anim/player_one_man_band.zip"),
    Asset("ANIM", "anim/shadow_hands.zip"),
    Asset("SOUND", "sound/sfx.fsb"),
    Asset("SOUND", "sound/wilson.fsb"),
    Asset("ANIM", "anim/garen.zip"),
    Asset("ANIM", "anim/xxxmagic_garen.zip"),
    Asset("ANIM", "anim/garene1.zip"),
    Asset("ANIM", "anim/garene2.zip"),
    Asset("ANIM", "anim/garene3.zip"),
    Asset("ANIM", "anim/garene4.zip"),
    Asset("IMAGE", "images/saveslot_portraits/garen.tex"),
    Asset("ATLAS", "images/saveslot_portraits/garen.xml"),
    Asset("ATLAS", "images/inventoryimages/doran.xml"),
    Asset("IMAGE", "images/inventoryimages/doran.tex"),
}
local prefabs = {}
local start_inv = {
    "garensoulballwhite",
}
local garenAttribute = {
    attackspeedbase = TUNING.WILSON_ATTACK_PERIOD or 0.5,
    walkspeed = TUNING.WILSON_WALK_SPEED or 4,
    runspeed = TUNING.WILSON_RUN_SPEED or 6,
    raise = 1.6,
    hungeryrate = TUNING.WILSON_HUNGER_RATE or 75 / (30 * 16),
    QCD = 8,
    WCD = 24,
    ECD = 13,
    RCD = 160,
    hungeryratespeed = 1.05,
    attack = 1.02,
    defend = 0.05,
    cdtime = 1,
    charhealth = 150,
    charhunger = 120,
    charsanity = 99,
    afraid = 0.5,
    attackspeed = 1.05,
    charspeed = 0.9,
    charcrit = 0.01,
    heal = 0.018,
    attackraise = 0.00375,
    defendraise = 0.003,
    cdtimeraise = 0.005,
    attackspeedraise = 0.0025,
    charspeedraise = 0.0055,
    charcritraise = 0.0015,
    healspeed = 0.00075
}
garenAttribute.charhealthraise = garenAttribute.charhealth * 0.04
garenAttribute.charhungerraise = garenAttribute.charhunger * 0.025
garenAttribute.charsanityraise = garenAttribute.charsanity * 0.02

local function cancelQEffect(player, tmp)
    player.components.td1madao_perioder:removeTask("td1madaoQGaren")
    player.components.locomotor.walkspeed = player.garenWalkSpeed
    player.components.locomotor.runspeed = player.garenRunSpeed
    player:RemoveTag("qbuffon")
    player.td1madaoCastingq = 1
    player.components.td1madao_attributer:refresh()
    td1madao_safeRemove(tmp)
end

local fn = function(inst)
    inst.refreshSkin = function()
        if inst.usingSkin then
            inst.AnimState:SetBuild(inst.usingSkin)
        end
    end
    inst.refreshSkin()
    td1madao_createRunePage(inst)
    inst.cancelQEffect = cancelQEffect
    td1madao_confirmPlayer("garen")
    td1madao_sellitemInit()
    inst:AddComponent("td1madao_lol_player_init")
    inst:AddComponent("td1madao_perioder")
    inst:AddComponent("xxxmagic_garen")
    inst:AddComponent("td1madao_leveler")
    inst:AddComponent("td1madao_skill_pointer")
    inst:AddComponent("td1madao_attributer")
    inst.components.td1madao_attributer:setAttribute(garenAttribute)
    inst:AddComponent("td1madao_huder")
    inst:AddComponent("td1madao_skiller")
    inst:AddComponent("td1madao_magic_huder")
    inst:AddComponent("td1madao_lol_player_ability")
    inst.components.td1madao_skill_pointer:getlolpointcanuse()
    td1madao_spawnEnemyCycle(inst)
    td1madao_createTable(inst.prefab, Prefabs)
    td1madao_setReborn(inst)
    inst.soundsname = "wolfgang"
    inst.qskilleffect = function(inst)
        local player = inst
        player:RemoveTag("skillq")
        if math.random() < 0.3 then
            player.components.talker:Say(TUNING.LOLMEMBER.TALK22, nil, true)
        end
        player.td1madaoCastingq = 0
        local tmp = td1madao_setColor(td1madao_deployAsChild(player, "staffcastfx"), 1, 1, 0)
        tmp.Transform:SetScale(0.5, 0.5, 0.5)
        td1madao_safeRemoveAfter(tmp, 5)
        tmp = td1madao_setColor(td1madao_deployAsChild(player, "forcefieldfx"), 1, 1, 0)
        tmp.Transform:SetScale(0.3, 0.3, 0.3)
        player:AddTag("qbuffon")
        player.garenWalkSpeed = player.components.locomotor.walkspeed
        player.garenRunSpeed = player.components.locomotor.runspeed
        player.components.td1madao_perioder:addTask("td1madaoQGaren", function()
            player.components.locomotor.walkspeed = player.garenWalkSpeed * 1.5
            player.components.locomotor.runspeed = player.garenRunSpeed * 1.5
        end, 1)
        player:DoTaskInTime(5, function()
            cancelQEffect(player, tmp)
        end)
    end
    inst.wskilleffect = function(inst)
        local player = inst
        if math.random() < 0.3 then
            player.components.talker:Say(TUNING.LOLMEMBER.TALK23, nil, true)
        end
        td1madao_safeRemoveAfter(td1madao_setColor(td1madao_deployAsChild(player, "forcefieldfx"), 1, 1, 0), 1)
        td1madao_safeRemoveAfter(td1madao_setColor(td1madao_deployAsChild(player, "moose_nest_fx"), 1, 1, 0), 1)
        player:RemoveTag("skillw")
        player.components.td1madao_perioder:addTask("td1madaoWGaren", function()
            td1madao_setAbsorb(player, player.absorb + 0.3)
        end, 1)
        player:DoTaskInTime(6, function()
            player.components.td1madao_perioder:removeTask("td1madaoWGaren")
            player.components.td1madao_attributer:refresh()
        end)
    end
    inst.eskilleffect = function(inst)
        local player = inst
        td1madao_lock("e", function()
            td1madao_gotoAndPlay(player, "terraform", true)
            local time = 0
            player:DoTaskInTime(.5, function()
                player.components.playercontroller:Enable(true)
                td1madao_startFly(player, true)
                local garenEEffect = td1madao_deployAsChild(player, "garentornado2")
                td1madao_safeRemoveAfter(garenEEffect, 3)
                garenEEffect.AnimState:SetMultColour(0.5, 0.5, 0.5, 0)
                player.garenEAttack = player:DoPeriodicTask(0.5, function()
                    local ents = td1madao_findAround(player, 4 * (1 + (td1madao_getRuneAtt(1) + player.lolattackpoint) * 0.0007))
                    td1madao_playerAttackAll(ents, 0.7, nil, true)
                end)
                player.garenETask = player:DoPeriodicTask(0.01, function()
                    time = time + 1
                    time = time % 4
                    if time == 0 then
                        time = 4
                    end
                    if td1madao_alive(player) then
                        player.AnimState:PlayAnimation("garene" .. time, true)
                    end
                end)
                td1madao_removeTaskAfter(player, "garenETask", 3, function() td1madao_gotoAndPlay("idle") end)
                td1madao_removeTaskAfter(player, "garenEAttack", 3)
                player:DoTaskInTime(3, function()
                    td1madao_unlock("e")
                    td1madao_stopFly(player)
                    local weapon = td1madao_getPlayerWeapon()
                    if weapon.components.tool and weapon.components.finiteuses then
                        weapon.components.finiteuses:Use(1)
                    end
                end)
            end)
        end)
    end
    inst.rskilleffect = function()
        local player = GetPlayer()
        if player.components.td1madao_skiller.skillCD.r > 0 then
            return
        end
        player:AddTag("rbuffon")
        td1madao_listenForTarget("r", 10, function(target)
            td1madao_lock("r", function()
                player:ForceFacePoint(target:GetPosition():Get())
                td1madao_gotoAndPlay(player, "terraform", true)
                player:DoTaskInTime(1, function()
                    td1madao_safeRemoveAfter(td1madao_deployBelow(target, "exitcavelight"), 3)
                    local garenRSkill = td1madao_deployBelow(target, "rskill")
                    garenRSkill.Transform:SetScale(2, 2, 2)
                    td1madao_safeRemoveAfter(garenRSkill, 3)
                    td1madao_safeRemoveAfter(td1madao_deployBelow(target, "lightning"), 3)
                    td1madao_playerAttackAll({ target }, 7)
                    td1madao_unlock("r")
                end)
            end, 0.2)
        end)
    end
    td1madao_runLatter(inst, 0.5, function()
        if inst.blueBuffSaveDay and inst.blueBuffSaveDay > 0 then
            td1madao_riderShow(inst)
        end
        inst.components.td1madao_skiller:addSkill("q", TUNING.GAREN_KEY.KEY1, inst.qskilleffect, -30, 0, nil, nil)
        inst.components.td1madao_skiller:addSkill("w", TUNING.GAREN_KEY.KEY2, inst.wskilleffect, -7, 0, nil, nil)
        inst.components.td1madao_skiller:addSkill("e", TUNING.GAREN_KEY.KEY3, inst.eskilleffect, 16, 0, nil, nil)
        inst.components.td1madao_skiller:addSkill("r", TUNING.GAREN_KEY.KEY4, inst.rskilleffect, 40, 0, nil, nil, true)
        td1madao_runLatter(inst, 30, function()
            inst.components.td1madao_global_buffer_saver:once()
        end)
        td1madao_runLatter(inst, 60 * 3, function()
            inst.components.td1madao_global_buffer_saver:loop()
        end)
    end)
    inst.components.td1madao_perioder:addTask("td1madaoPassiveGaren", function()
        local player = inst
        local ents = td1madao_findAround(player, 15)
        for k, v in pairs(ents) do
            if v and ((v.components.combat and v.components.combat == player) or (v:HasTag("hostile"))) then
                return
            end
        end
        if player and player.components.combat and player.components.combat.target then
            return
        end
        player.components.health:DoDelta(player.components.health.maxhealth * 0.002)
    end, 10)
    inst:ListenForEvent("entity_death", function(wrld, data) td1madao_onkillBlueBuff(function(inst2, data)
        local enemy = data.inst
        if data and data.cause == 'garen' and enemy and enemy.prefab == 'garen_sy' then
            inst.blueBuffSaveDay = 3
            td1madao_riderShow(inst)
        end
    end)(inst, data)
    end, GetWorld())
    td1madao_createRider(inst, "garene1skill3", 0)
    inst.blueBuffSaveDay = 0
    inst:ListenForEvent("onattackother", td1madao_onAttackOther(function(inst, v)
        if inst:HasTag("qbuffon") then
            return 1.5
        end
        return 1
    end))
    inst.components.td1madao_attributer:refresh()
    inst.components.td1madao_huder:AddScreen(require "screens/garenscreen")
    inst:AddComponent("garencast")
    inst:AddComponent("td1madao_mouse_listener")
    inst:AddComponent("td1madao_global_buffer_saver")
end

return MakePlayerCharacter("garen", prefabs, assets, fn, start_inv)