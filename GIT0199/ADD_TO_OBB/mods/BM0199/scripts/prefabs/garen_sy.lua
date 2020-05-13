local assets =
{
    Asset("ANIM", "anim/ds_pig_basic.zip"),
    Asset("ANIM", "anim/ds_pig_actions.zip"),
    Asset("ANIM", "anim/ds_pig_attacks.zip"),
    Asset("ANIM", "anim/pig_build.zip"),
    Asset("ANIM", "anim/pigspotted_build.zip"),
    Asset("ANIM", "anim/pig_guard_build.zip"),
    Asset("ANIM", "anim/werepig_build.zip"),
    Asset("ANIM", "anim/werepig_basic.zip"),
    Asset("ANIM", "anim/werepig_actions.zip"),
    Asset("SOUND", "sound/pig.fsb"),
    Asset("ANIM", "anim/staff_projectile.zip"),
    Asset("ANIM", "anim/gunpowder.zip"),
    Asset("ANIM", "anim/explode.zip"),
}
local prefabs =
{
    "explode_small"
}

local loot =
{
    "meat",
    "meat",
    "pigskin",
    "poop",
    "poop",
    "poop",
    "poop",
    "poop",
    "poop",
    "poop",
    "poop",
    "goldnugget",
    "goldnugget",
    "goldnugget",
    "goldnugget",
    "garensoulballblue",
    "garensoulballblue",
    "redgem",
    "bluegem",
}

local function KeepTargetFn(inst, target)
    return td1madao_alive(target) and inst.components.combat:CanTarget(target) and target.prefab ~= "garen_sy" and target.prefab ~= "garen_sy2"
end

local function KillerRetarget(inst)
    return FindEntity(inst, TUNING.PIG_TARGET_DIST,
        function(guy)
            return td1madao_alive(guy) and guy:HasTag("monster")
        end)
end

local function create_lxw(inst, target)
    local a = td1madao_deployBelow(target, "garen_sy_lxw")
    local x, y, z = a:GetPosition():Get()
    if a.Transform then
        a.Transform:SetScale(6, 6, 6)
        a.Transform:SetPosition(x, -7, z)
    end
    inst.components.talker:Say(TUNING.LOLMEMBER.TALK91)
    td1madao_safeRemoveAfter(a, 0.5)
end

local function onattackother(inst, data)
    local v = data.target
    if v then
        create_lxw(inst, v)
    end
end

local SHARE_TARGET_DIST = 30
local MAX_TARGET_SHARES = 5

local function OnAttacked(inst, data)
    local attacker = data.attacker
    --    inst:ClearBufferedAction()
    if td1madao_alive(attacker) and inst.components.combat:CanTarget(attacker) then
        inst.components.combat:SetTarget(attacker)
        if not (attacker:HasTag("pig") and attacker:HasTag("guard")) then
            inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, function(dude) return dude:HasTag("pig") and not dude:HasTag("werepig") end, MAX_TARGET_SHARES)
        end
    end
    if math.random() < 0.5 and not inst.fys then
        inst:DoTaskInTime(0.5, function()
            if not td1madao_alive(inst) then
                return
            end
            td1madao_deployBelow(inst, "small_puff")
            td1madao_deployBelow(inst, "log")
            td1madao_transAround(inst, 8)
            td1madao_deployBelow(inst, "small_puff")
            inst.components.talker:Say(TUNING.LOLMEMBER.TALK92)
        end)
    end
end

local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    local shadow = inst.entity:AddDynamicShadow()
    shadow:SetSize(1.5, .75)
    inst.Transform:SetFourFaced()
    if td1madao_enableSW() then
        MakePoisonableCharacter(inst)
    end
    MakeCharacterPhysics(inst, 50, .5)
    anim:SetBank("pigman")
    inst.AnimState:SetBuild("pig_guard_build")
    inst:AddTag("character")
    inst:AddTag("pig")
    inst:AddTag("scarytoprey")
    inst:AddTag("epic")
    inst:AddTag("td1madao_special")
    inst.fys = false
    inst.labelname = inst.entity:AddLabel()
    inst.labelname:SetFontSize(35)
    inst.labelname:SetPos(0, 3.3, 0)
    inst.labelname:SetFont(NUMBERFONT)
    inst.labelname:Enable(true)
    inst.labelname:SetColour(0, 1, 0)
    inst.labelname:SetText(STRINGS.NAMES.GAREN_SY)
    anim:PlayAnimation("idle_loop")
    inst:AddComponent("talker")
    inst:AddComponent("locomotor")
    inst.components.locomotor.runspeed = TUNING.PIG_RUN_SPEED * 1.1
    inst.components.locomotor.walkspeed = TUNING.PIG_WALK_SPEED * 1.1
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot(loot)
    inst:AddComponent("inventory")
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "pig_torso"
    inst.components.combat:SetAttackPeriod(TUNING.PIG_ATTACK_PERIOD * 0.9)
    inst.components.combat:SetRetargetFunction(1, KillerRetarget)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    inst:AddComponent("health")
    inst:AddComponent("eater")
    inst:AddComponent("named")
    inst:AddComponent("follower")
    inst:AddComponent("sleeper")
    inst:AddComponent("inspectable")
    inst:AddComponent("trader")
    inst:AddComponent("td1madao_perioder_prefab")
    inst.attackrange = inst.components.combat.attackrange
    inst.hitrange = inst.components.combat.hitrange

    inst.components.td1madao_perioder_prefab:addTask("garenSySkill", function()
        local target = inst.components.combat.target

        if inst.fys or not td1madao_alive(target) then
            return
        end
        if math.random() < 0.5 then
            if math.random() > 0.5 then
                if inst.components.combat.hitrange ~= inst.hitrange then
                    return
                end
                inst.components.talker:Say(TUNING.LOLMEMBER.TALK89)
                td1madao_deployBelow(inst, "collapse_big")
                inst.Transform:SetScale(3, 3, 3)
                inst.components.combat:SetDefaultDamage(34 * 6)
                inst.components.combat.attackrange = inst.attackrange * 1 + (3 - 1) * .5
                inst.components.combat.hitrange = inst.hitrange * 1 + (3 - 1) * .5
                td1madao_runLatter(inst, 15, function()
                    td1madao_deployBelow(inst, "collapse_big")
                    inst.Transform:SetScale(1, 1, 1)
                    inst.components.combat:SetDefaultDamage(34 * 3)
                    inst.components.combat.attackrange = inst.attackrange
                    inst.components.combat.hitrange = inst.hitrange
                end)
            else
                inst.components.talker:Say(TUNING.LOLMEMBER.TALK90)
                for i = 1, 6 do
                    td1madao_runLatter(inst, i, function()
                        local item = td1madao_forcespawnAround(inst, "garen_sy2", 4)
                        item.components.combat:SetTarget(target)
                        if item then
                            td1madao_deployBelow(item, "collapse_small")
                        end
                    end)
                end
            end
        end
    end, 20)
    inst.components.td1madao_perioder_prefab:addTask("garenSyTalk", function() td1madao_randomTalk(inst, LOLSYTALK) end, 4)
    inst:ListenForEvent("onattackother", onattackother)
    inst.components.named:SetName(STRINGS.NAMES.GAREN_SY)
    inst.components.health:SetMaxHealth(3000)
    inst.components.combat:SetDefaultDamage(34 * 3)
    inst.components.combat.playerdamagepercent = 1 / 3
    inst.components.combat:SetAttackPeriod(TUNING.PIG_ATTACK_PERIOD)
    inst:AddComponent("knownlocations")
    local brain = require "brains/garensybrain"
    inst:SetBrain(brain)
    --    MakeMediumBurnableCharacter(inst, "pig_torso")
    MakeMediumFreezableCharacter(inst, "pig_torso")
    inst.components.freezable.wearofftime = 1.5
    inst:ListenForEvent("attacked", OnAttacked)
    inst:SetStateGraph("SGpig")
    inst:DoTaskInTime(0.1, function()
        local item = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
        if not item then
            item = td1madao_safespawn("poop")
            inst.components.inventory:Equip(item)
        end
        inst.AnimState:OverrideSymbol("swap_hat", "garenhat_poop", "swap_hat8")
    end)
    td1madao_createRider(inst, "garene1skill3", 0, true)
    td1madao_prefabResponse(inst, TUNING.LOLMEMBER.TALK94, function()
        inst.AnimState:PlayAnimation("idle_angry")
    end)
    return inst
end

local function fn2(Sim)
    local inst = fn(Sim)
    inst.fys = true
    inst.components.health:SetMaxHealth(150)
    inst.components.combat:SetDefaultDamage(10 * 3)
    inst.components.lootdropper:SetLoot({ "poop" })
    td1madao_runLatter(inst, 15, function()
        td1madao_deployBelow(inst, "collapse_small")
        td1madao_safeRemove(inst)
    end)
    return inst
end

local function fn3(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    anim:SetBank("projectile")
    anim:SetBuild("staff_projectile")
    inst.AnimState:PlayAnimation("ice_spin_loop", true)
    inst:Hide()
    anim:SetLayer(LAYER_WORLD)
    anim:SetSortOrder(-1)
    inst:DoTaskInTime(5, function() inst:Remove() end)
    return inst
end


local function OnExplodeFn(inst)
    local pos = Vector3(inst.Transform:GetWorldPosition())
    local explode = SpawnPrefab("explode_small")
    local pos = inst:GetPosition()
    explode.Transform:SetPosition(pos.x, pos.y, pos.z)
    explode.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    explode.AnimState:SetLightOverride(1)
end

local function fn4(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("gunpowder")
    inst.AnimState:SetBuild("gunpowder")
    inst.AnimState:PlayAnimation("idle")
    inst:AddComponent("inspectable")
    MakeSmallBurnable(inst, 3 + math.random() * 3)
    MakeSmallPropagator(inst)
    inst:AddComponent("explosive")
    inst:DoTaskInTime(15, function() td1madao_safeRemove(inst) end)
    inst.components.explosive:SetOnExplodeFn(OnExplodeFn)
    inst.components.explosive.explosivedamage = TUNING.GUNPOWDER_DAMAGE
    return inst
end


return Prefab("common/monsters/garen_sy", fn, assets, prefabs),
Prefab("common/monsters/garen_sy2", fn2, assets, prefabs),
Prefab("common/monsters/garen_sy_lxw", fn3, assets, prefabs),
Prefab("common/monsters/garengunpowder", fn4, assets, prefabs)
