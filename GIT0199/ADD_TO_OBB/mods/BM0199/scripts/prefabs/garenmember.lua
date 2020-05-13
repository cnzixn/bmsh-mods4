local assets =
{
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
}
SetSharedLootTable('garenmember', td1madao_member_award)

local function kill_fx(inst)
    if inst then
        inst:DoTaskInTime(0, function() if inst then inst:Remove() end end)
    end
end

local function showtask(inst)
    if inst.taskitem ~= nil and inst.belongtowhich == TUNING.GARENBELONG then
        inst.taskicon = td1madao_safespawn("garentask")
        inst.taskicon.Transform:SetPosition(0, 2.5, 0)
        inst.taskicon.Transform:SetScale(1.2, 1.2, 1.2)
        inst.taskicon.entity:SetParent(inst.entity)
    end
end

local function createTask(inst)
    if inst.taskitem == nil and inst.belongtowhich == TUNING.GARENBELONG then
        if SaveGameIndex and SaveGameIndex.IsModeShipwrecked and SaveGameIndex:IsModeShipwrecked() then
            inst.taskitem = td1madao_member_catcoonprefabs3[math.random(#td1madao_member_catcoonprefabs3)]
        elseif Prefabs.catcoon then
            inst.taskitem = td1madao_member_catcoonprefabs2[math.random(#td1madao_member_catcoonprefabs2)]
        else
            inst.taskitem = td1madao_member_catcoonprefabs[math.random(#td1madao_member_catcoonprefabs)]
        end
    end
    showtask(inst)
end

local function setbuild2(inst)
    inst.AnimState:SetBuild(inst.charanm)
end

local function daytimefn(inst)
    inst.AnimState:OverrideSymbol("swap_object", "swap_lantern", "swap_lantern_on")
    inst.Light:Enable(false)
    inst.nowisnight = false
    if inst.myweapon == "swap_staffs" then
        inst.AnimState:OverrideSymbol("swap_object", inst.myweapon, "redstaff")
    else
        inst.AnimState:OverrideSymbol("swap_object", inst.myweapon, inst.myweapon)
    end
end

local function dusktimefn(inst)
    inst.AnimState:OverrideSymbol("swap_object", "swap_lantern", "swap_lantern_on")
    inst.nowisnight = true
    inst.Light:Enable(true)
    inst.Light:SetRadius(1)
    inst.Light:SetFalloff(.4)
    inst.Light:SetIntensity(.4)
    inst.Light:SetColour(235 / 255, 121 / 255, 12 / 255)
end

local function hideShip(inst)
    if not td1madao_alive(inst) then
        return
    end
    td1madao_riderHide(inst)
end

local function showShip(inst)
    if not td1madao_alive(inst) then
        return
    end
    td1madao_riderShow(inst)
end

local function changeShipDirection(inst)
    if not td1madao_alive(inst) then
        return
    end
    if inst.td1madao_createRiderObj and inst.td1madao_createRiderObj.Transform then
        inst.td1madao_createRiderObj.Transform:SetRotation(inst.Transform:GetRotation(inst))
    end
end

local function OnWaterChange(inst, onwater)
    inst.onwater = onwater
    if not onwater then
        hideShip(inst)
    else
        showShip(inst)
        changeShipDirection(inst)
    end
end

local function attackableTarget(inst, v)
    return td1madao_canWar(inst, v) and not (v:HasTag(inst.belongtowhich) and not v:HasTag("player"))
end

local function summonTarget(inst, enemy, dude)
    return td1madao_canWar(inst, enemy) and td1madao_alive(dude) and not dude:HasTag("player") and dude:HasTag(inst.belongtowhich)
end


local function OnAttacked(inst, data)
    local attacker = data and data.attacker
    if attackableTarget(inst, attacker) then
        if attacker == GetPlayer() and (GetPlayer().components.td1madao_lol_player_init.peaceDay or 0) > 0 and inst.belongtowhich ~= GetPlayer().belongtowhich then
            GetPlayer().components.td1madao_lol_player_init.peaceDay = 0
        end
        inst.components.combat:SetTarget(attacker)
        local x1, y1, z1 = inst.Transform:GetWorldPosition()
        local x2, y2, z2 = attacker.Transform:GetWorldPosition()
        local dist = math.sqrt((x1 - x2) * (x1 - x2) + (z1 - z2) * (z1 - z2))
        if inst.calculate > 0 and dist < 3 then
            inst.calculate = inst.calculate - 1
            inst.hurttime = inst.hurttime + 1
        end
        inst.components.combat:ShareTarget(attacker, 30, function(dude)
            return summonTarget(inst, attacker, dude)
        end, 100)
    end
end

local function onsave(inst, data)
    if inst.fx then
        if inst.fx.task then
            inst.fx.task:Cancel()
            inst.fx.task = nil
        end
        inst.fx:Remove()
        inst.fx = nil
    end

    if inst.trappers then
        data.trappers = inst.trappers
    else
        data.trappers = false
    end
    if inst.berry then
        data.berry = inst.berry
    end
    if inst.taskitem then
        data.taskitem = inst.taskitem
    end
    if inst.belongtowhich then
        data.belongtowhich = inst.belongtowhich
    end
    if inst.enemywhich then
        data.enemywhich = inst.enemywhich
    end
    if inst.myhat then
        data.myhat = inst.myhat
    end
    if inst.myarmor then
        data.myarmor = inst.myarmor
    end
    if inst.myweapon then
        data.myweapon = inst.myweapon
    end
    if inst.charanm then
        data.charanm = inst.charanm
    end
end

local function onpreload(inst, data)
    if not data then
        return
    end
    if data.belongtowhich then
        inst.belongtowhich = data.belongtowhich
    end
    if data.berry then
        inst.berry = data.berry
    end
    if data.taskitem then
        inst.taskitem = data.taskitem
    end
    if data.enemywhich then
        inst.enemywhich = data.enemywhich
    end
    if data.myhat then
        inst.myhat = data.myhat
    end
    if data.myarmor then
        inst.myarmor = data.myarmor
    end
    if data.myweapon then
        inst.myweapon = data.myweapon
    end
    if data.charanm then
        inst.charanm = data.charanm
    end
    if Prefabs[inst.charanm] then
        setbuild2(inst)
    else
        inst.charanm = "wilson"
        inst.AnimState:SetBuild("wilson")
    end
    if data.trappers then
        inst.trappers = data.trappers
    else
        inst.trappers = false
    end
    inst:RemoveTag('demaciamem')
    inst:RemoveTag('noxusmem')
    inst:AddTag(inst.belongtowhich)
    inst:RemoveTag("companion")
    inst:RemoveTag("hostile")
    inst.components.locomotor.directdrive = false
    if inst.belongtowhich == (td1madao_playerBelone() or TUNING.GARENBELONG) then
        inst:AddTag("companion")
    else
        inst:AddTag("hostile")
        inst:AddTag("character")
        if math.random() < 0.05 then
            inst.components.locomotor.directdrive = true
        end
    end
    if inst.belongtowhich == 'demaciamem' then
        inst.labelname:SetColour(0, 0, 1)
    else
        inst.labelname:SetColour(1, 0, 0)
    end
    inst.components.inspectable:SetDescription(string.format("%s%s", TUNING.LOLMEMBER[inst.belongtowhich], STRINGS.NAMES[string.upper(inst.charanm)] or inst.charanm))
    inst.name = string.format("%s%s", TUNING.LOLMEMBER[inst.belongtowhich], STRINGS.NAMES[string.upper(inst.charanm)] or inst.charanm)
    if not (inst.myhat == "hat_flower" or inst.myhat == "hat_earmuffs") then
        inst.AnimState:Show("HAT")
        inst.AnimState:Show("HAT_HAIR")
        inst.AnimState:Hide("HAIR_NOHAT")
        inst.AnimState:Hide("HAIR")
    else
        inst.AnimState:Show("HAIR_NOHAT")
        inst.AnimState:Show("HAIR")
    end
    inst.AnimState:OverrideSymbol("swap_hat", inst.myhat, "swap_hat")
    inst.AnimState:OverrideSymbol("swap_body", inst.myarmor, "swap_body")
    if inst.myweapon == "swap_staffs" then
        inst.AnimState:OverrideSymbol("swap_object", inst.myweapon, "redstaff")
    else
        inst.AnimState:OverrideSymbol("swap_object", inst.myweapon, inst.myweapon)
    end
    if inst.myweapon == "swap_blowdart" or inst.myweapon == "swap_staffs" then
        inst.dart = 0.75
        inst.components.locomotor.walkspeed = inst.walkspeed * inst.dart
        inst.components.locomotor.runspeed = inst.runspeed * inst.dart
        inst.components.combat:SetAttackPeriod(inst.oldperiod * 2)
        inst.components.combat:SetRange(8, 10)
    else
        inst.dart = 1
        inst.components.locomotor.walkspeed = inst.walkspeed * inst.dart
        inst.components.locomotor.runspeed = inst.runspeed * inst.dart
        inst.components.combat:SetAttackPeriod(inst.oldperiod)
        inst.components.combat:SetRange(1.5)
    end

    if inst.dart == 0.75 then
        inst.labelname:SetText((STRINGS.NAMES[string.upper(inst.charanm)] or inst.charanm) .. '[ADC]')
    else
        inst.labelname:SetText(STRINGS.NAMES[string.upper(inst.charanm)] or inst.charanm)
    end

    local time = GetClock().phase
    if time == "dusk" or time == "night" then
        dusktimefn(inst)
    else
        daytimefn(inst)
    end
    inst:RemoveComponent("lootdropper")
    inst:AddComponent("lootdropper")
    if inst.belongtowhich ~= TUNING.GARENBELONG then
        inst.components.lootdropper:SetChanceLootTable('garenmember')
        inst.components.trader.enabled = false
        if math.random() < 0.05 then
            inst.components.lootdropper:SetChanceLootTable('whatthepoop')
        elseif math.random() < 0.075 then
            inst.components.lootdropper:SetChanceLootTable('drb')
        end
    else
        inst.components.trader.enabled = true
    end
    showtask(inst)
end

local function RetargetFn(inst)
    local invader = FindEntity(inst, 15, function(guy)
        if td1madao_canWar(inst, guy) and inst.components.follower and inst.components.follower.leader then
            return td1madao_protectLeaderOrSelf(inst, guy)
        end
        local player = GetPlayer()
        if player and (GetPlayer().components.td1madao_lol_player_init.peaceDay or 0) > 0 and guy == player then
            return false
        end
        local final = td1madao_canWar(inst, guy) and (guy:HasTag(inst.enemywhich))
        if final and math.random() < 0.3 and guy:HasTag("player") and guy:HasTag(inst.enemywhich) then
            inst.components.talker:Say(TUNING.LOLMEMBER.TALK7)
        end
        return final
    end)
    return invader
end

local function KeepTargetFn(inst, target)
    local home = inst.components.homeseeker and inst.components.homeseeker.home
    if home and not inst.components.follower.leader and not inst.components.health:IsDead() then
        return home:GetDistanceSqToInst(target) < 100 * 100
                and home:GetDistanceSqToInst(inst) < 100 * 100
    end
    return td1madao_canWar(inst, target)
end

local function fn(inst)
    inst.belonger = 'garen'
    if math.random() < 0.1 then
        inst.trappers = true
    else
        inst.trappers = false
    end
    inst.fx = nil
    inst.kill_fx = kill_fx
    inst:AddTag("scarytoprey")
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    --    local physics = inst.entity:AddPhysics()
    local sound = inst.entity:AddSoundEmitter()
    local shadow = inst.entity:AddDynamicShadow()
    shadow:SetSize(1.5, .75)
    inst.Transform:SetFourFaced()
    if td1madao_enableSW() then
        MakePoisonableCharacter(inst)
    end
    inst.hurttime = 0
    inst:AddComponent("td1madao_perioder_prefab")
    if td1madao_isInSW() then
        MakeAmphibiousCharacterPhysics(inst, 50, .5)
        MakeInventoryFloatable(inst, "idle", "idle")
        td1madao_createRider(inst, "garenrowboat")
        inst.components.td1madao_perioder_prefab:addTask("td1madaoCheckOnWater", function()
            OnWaterChange(inst, td1madao_creatureOnWater(inst))
        end, 1)
    else
        MakeCharacterPhysics(inst, 50, .5)
        inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
        inst.Physics:ClearCollisionMask()
        inst.Physics:CollidesWith(COLLISION.WORLD)
        inst.Physics:CollidesWith(COLLISION.OBSTACLES)
        inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    end
    inst.components.td1madao_perioder_prefab:addTask("td1madaoLegalBB", function()
        if not inst:HasTag("hostile") and not inst.components.combat.target then
            td1madao_randomTalk(inst, TUNING.TD1MADAOGAMESKILL)
        end
    end, 15)
    inst.AnimState:SetBank("wilson")
    inst.labelname = inst.entity:AddLabel()
    inst.labelname:SetFontSize(35)
    inst.labelname:SetPos(0, 3.3, 0)
    inst.labelname:SetFont(NUMBERFONT)
    inst.labelname:Enable(true)
    td1madao_randomEnemy(inst)
    inst.myhat = "hat_flower"
    inst.myarmor = "armor_sanity"
    inst.myweapon = "swap_spear"
    td1madao_memberRandomHat(inst)
    inst.AnimState:OverrideSymbol("swap_hat", inst.myhat, "swap_hat")
    td1madao_memberRandomArmor(inst)
    inst.AnimState:OverrideSymbol("swap_body", inst.myarmor, "swap_body")
    td1madao_memberRandomWeapon(inst)
    if inst.myweapon == "swap_staffs" then
        inst.AnimState:OverrideSymbol("swap_object", inst.myweapon, "redstaff")
    else
        inst.AnimState:OverrideSymbol("swap_object", inst.myweapon, inst.myweapon)
    end
    inst.AnimState:Show("ARM_carry")
    inst.AnimState:Hide("ARM_normal")
    inst.entity:AddSoundEmitter()
    inst.dart = 1
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(15 + td1madao_getLv())
    inst.oldperiod = 0.85 - td1madao_getLv() * 0.01
    inst.components.combat:SetAttackPeriod(inst.oldperiod)
    if inst.myweapon == "swap_blowdart" or inst.myweapon == "swap_staffs" then
        inst.dart = 0.75
        inst.components.combat:SetAttackPeriod(inst.oldperiod * 2)
        inst.components.combat:SetRange(8, 10)
    else
        inst.components.combat:SetRange(1.5)
    end
    inst:AddComponent("eater")
    inst.components.eater:SetOmnivore()
    inst.components.eater:SetCanEatHorrible()
    inst.components.eater.strongstomach = true
    inst:AddComponent("locomotor")
    inst.walkspeed = (GetPlayer().components.locomotor.walkspeed or 8) * 0.85
    inst.runspeed = (GetPlayer().components.locomotor.runspeed or 8) * 0.85
    inst.components.locomotor.walkspeed = inst.walkspeed * inst.dart
    inst.components.locomotor.runspeed = inst.runspeed * inst.dart
    inst.components.locomotor.fasteronroad = true
    inst.components.locomotor:SetTriggersCreep(false)
    inst:SetStateGraph("SGgarenmember")
    local brain = require "brains/garenmemberbrain"
    inst:SetBrain(brain)
    inst.calculate = 3
    inst.renewtask = nil
    inst:AddComponent("health")
    local clock = GetClock().numcycles
    if clock > 500 then
        clock = 500
    end
    local mh = 100 + (td1madao_getLv() + math.floor(clock / 5)) * 2.5
    inst.components.health:SetMaxHealth(mh)
    inst.components.health:StartRegen(1, 10)
    inst.components.health.fire_damage_scale = 1
    local absor = td1madao_getLv() * 0.02 + 0.5
    if absor > 0.8 then
        absor = 0.8
    end
    if inst.components.health.SetAbsorptionAmount then
        inst.components.health:SetAbsorptionAmount(absor)
    else
        inst.components.health.absorb = absor
    end
    inst:AddComponent("knownlocations")
    inst:AddComponent("inventory")
    inst:AddComponent("talker")
    inst:AddComponent("follower")
    inst.components.follower.maxfollowtime = TUNING.TOTAL_DAY_TIME * 6
    inst.components.combat.hiteffectsymbol = "torso"
    inst.components.combat:SetRetargetFunction(2, RetargetFn)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    inst:AddComponent("lootdropper")
    if inst.belongtowhich ~= TUNING.GARENBELONG then
        inst.components.lootdropper:SetChanceLootTable('garenmember')
        if math.random() < 0.05 then
            inst.components.lootdropper:SetChanceLootTable('whatthepoop')
        elseif math.random() < 0.075 then
            inst.components.lootdropper:SetChanceLootTable('drb')
        end
    end
    local light = inst.entity:AddLight()
    inst.Light:Enable(false)
    inst.taskitem = nil
    inst.taskicon = nil
    inst:ListenForEvent("daytime", function(global, data)
        daytimefn(inst)
        if inst.belongtowhich == TUNING.GARENBELONG and not inst.taskitem and math.random() < 0.15 then
            createTask(inst)
        end
    end, GetWorld())
    inst:ListenForEvent("dusktime", function(global, data)
        dusktimefn(inst)
    end, GetWorld())
    local time = GetClock().phase
    if time == "dusk" or time == "night" then
        dusktimefn(inst)
    else
        daytimefn(inst)
    end
    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(function()
        return true
    end)
    inst.components.trader.onaccept = td1madao_member_getItem
    if inst.belongtowhich ~= TUNING.GARENBELONG then
        inst.components.trader.enabled = false
    else
        inst.components.trader.enabled = true
    end
    inst:AddComponent("inspectable")
    local old = inst.components.inspectable.GetDescription
    inst.components.inspectable.GetDescription = function(viewer)
        if inst.belongtowhich == TUNING.GARENBELONG then
            if td1madao_alive(inst) then
                inst.sg:GoToState("idle")
                if inst.taskitem then
                    inst.components.talker:Say(string.format(TUNING.LOLMEMBER.TALK, STRINGS.NAMES[string.upper(inst.taskitem)]))
                else
                    td1madao_randomTalk(inst, LOLMEMBERTALK)
                end
                inst.sg:GoToState("talk")
            end
        end
        return old(viewer or GetPlayer())
    end
    inst.components.inspectable:SetDescription(string.format("%s%s", TUNING.LOLMEMBER[inst.belongtowhich], STRINGS.NAMES[string.upper(inst.charanm)] or inst.charanm))
    inst.name = string.format("%s%s", TUNING.LOLMEMBER[inst.belongtowhich], STRINGS.NAMES[string.upper(inst.charanm)] or inst.charanm)
    inst:AddTag(inst.belongtowhich)
    inst:AddTag("td1madao_special")
    inst.components.locomotor.directdrive = false
    if inst.belongtowhich == (td1madao_playerBelone() or TUNING.GARENBELONG) then
        inst:AddTag("companion")
    else
        inst:AddTag("hostile")
        inst:AddTag("character")
        if math.random() < 0.05 then
            inst.components.locomotor.directdrive = true
        end
    end
    if inst.belongtowhich == 'demaciamem' then
        inst.labelname:SetColour(0, 0, 1)
    else
        inst.labelname:SetColour(1, 0, 0)
    end
    if inst.dart == 0.75 then
        inst.labelname:SetText((STRINGS.NAMES[string.upper(inst.charanm)] or inst.charanm) .. '[ADC]')
    else
        inst.labelname:SetText(STRINGS.NAMES[string.upper(inst.charanm)] or inst.charanm)
    end
    local function onattackother(inst, data)
        local v = data.target
        if v and inst.components.combat and v.components.health and not v.components.health:IsDead()
                and inst.calculate > 0 then
            inst.calculate = inst.calculate - 1
            if math.random() < 0.5 then
                inst.hurttime = 0
            end
        end
    end

    inst:ListenForEvent("onattackother", onattackother)
    inst:ListenForEvent("attacked", OnAttacked)
    inst.OnSave = onsave
    inst.OnPreLoad = onpreload
    showtask(inst)
    inst.td1madaoCheckCharacter = inst:DoPeriodicTask(2, function()
        if TUNING.LOLLOAD then
            if TUNING.LOLCHAR and TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER')] ~= 0 then
                if GetPlayer().prefab ~= inst.belonger then
                    local inneed = string.gsub(inst.prefab, inst.belonger, GetPlayer().prefab)
                    local result = td1madao_safespawn(inneed)
                    result.Transform:SetPosition(inst.Transform:GetWorldPosition())
                    td1madao_safeRemove(inst)
                end
            else
                td1madao_safeRemove(inst)
            end
            inst.components.td1madao_perioder_prefab:removeTask("td1madaoCheckCharacter")
        end
    end)
    MakeMediumFreezableCharacter(inst)
    inst.components.freezable:SetShatterFXLevel(1)
    inst.components.freezable:SetDefaultWearOffTime(TUNING.PLAYER_FREEZE_WEAR_OFF_TIME or 3)
    return inst
end

local function whiter()
    local inst = CreateEntity()
    local rm = math.random()
    if rm < 0.5 then
        inst.belongtowhich = "demaciamem"
        inst.enemywhich = "noxusmem"
    else
        inst.belongtowhich = "noxusmem"
        inst.enemywhich = "demaciamem"
    end
    fn(inst)
    return inst
end

local function whited()
    local inst = CreateEntity()
    inst.belongtowhich = "demaciamem"
    inst.enemywhich = "noxusmem"
    fn(inst)
    return inst
end

local function whiten()
    local inst = CreateEntity()
    inst.belongtowhich = "noxusmem"
    inst.enemywhich = "demaciamem"
    fn(inst)
    return inst
end


return Prefab("garenmember", whiter, assets),
Prefab(TUNING.GARENBELONGNAME, whited, assets),
Prefab(TUNING.GARENENEMYNAME, whiten, assets)