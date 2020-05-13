require "brains/garenporobrain"
require "stategraphs/SGgarenporo"


local assets =
{
    Asset("ANIM", "anim/garenporo_build.zip"),
    Asset("ATLAS", "images/inventoryimages/garenporo.xml"),
    Asset("IMAGE", "images/inventoryimages/garenporo.tex"),
}

local prefabs =
{}

SetSharedLootTable('garenporo', {
    { 'garenporo', 1.00 },
})
local function clearRelation(inst, notforce)
    if (not notforce) or (inst and inst.components.inventoryitem and inst.components.inventoryitem.owner ~= nil) then
        local player = GetPlayer()
        if inst and player and player.components.leader then
            player.components.leader:RemoveFollower(inst)
        end
        if inst and inst.components.follower then
            inst.components.follower:StopFollowing()
        end
    end
end

local function clearFollower(inst, notforce)
    clearRelation(inst, notforce)
    if inst then
        inst:DoTaskInTime(0.3, function()
            clearRelation(inst, notforce)
        end)
    end
end

local function size2(inst)
    local scale = inst.hunger / 2000 + 1
    local scale2 = scale
    if scale2 > 2.5 then
        scale2 = 2.5
    end
    inst.Transform:SetScale(inst.old_monster_size * scale2, inst.old_monster_size * scale2, inst.old_monster_size * scale2)
    inst.components.combat.defaultdamage = inst.old_monster_damage * scale
    inst.components.health.maxhealth = inst.old_monster_health * scale
    inst.Physics:SetMass(inst.old_monster_mass * scale)
end


local function NormalRetarget(inst)
    local targetDist = TUNING.SPIDER_TARGET_DIST * 5
    return FindEntity(inst, targetDist,
        function(guy)
            return td1madao_protectLeaderOrSelf(inst, guy)
        end)
end

local function keeptargetfn(inst, target)
    return td1madao_canWar(inst, target) and not (inst.components.follower and inst.components.follower.leader == target)
end

local WAKE_TO_FOLLOW_DISTANCE = 14
local SLEEP_NEAR_LEADER_DISTANCE = 7

local function ShouldSleep(inst)
    return DefaultSleepTest(inst)
            and inst.components.follower:IsNearLeader(SLEEP_NEAR_LEADER_DISTANCE)
end

local function ShouldWakeUp(inst)
    return DefaultWakeTest(inst) or not inst.components.follower:IsNearLeader(WAKE_TO_FOLLOW_DISTANCE)
end

local function OnAttacked(inst, data)
    if not data or not data.attacker then
        return
    end
    if not td1madao_isLolChar(data.attacker) then
        inst.components.combat:SetTarget(data.attacker)
    else
        local player = GetPlayer()
        if player and player.components.leader then
            player.components.leader:AddFollower(inst)
        end
        if inst.shuttask then
            inst.shuttask:Cancel()
            inst.shuttask = nil
        end
        inst.shuttask = inst:DoTaskInTime(60 * 3, function()
            inst.shuttask:Cancel()
            inst.shuttask = nil
        end)
    end
end

local function StartDay(inst)
    inst.components.sleeper:WakeUp()
end

local function StartNight(inst)
    ShouldSleep(inst)
end

local function create_common(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLightWatcher()
    local shadow = inst.entity:AddDynamicShadow()
    shadow:SetSize(1.5, .5)
    inst.Transform:SetFourFaced()
    inst:AddTag("mypet")
    inst:AddTag("companion")
    inst:AddTag("garenporo")
    inst:AddTag("scarytoprey")
    inst:AddTag("smallcreature")
    inst:AddTag("irreplaceable")

    if IsDLCEnabled(CAPY_DLC) then
        MakeAmphibiousCharacterPhysics(inst, 10, .5)
        MakeInventoryFloatable(inst, "idle", "idle")
    else
        MakeCharacterPhysics(inst, 10, .5)
        inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
        inst.Physics:ClearCollisionMask()
        inst.Physics:CollidesWith(COLLISION.WORLD)
        inst.Physics:CollidesWith(COLLISION.OBSTACLES)
        inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    end
    inst.shuttask = nil
    inst.AnimState:SetBank("hound")
    inst.AnimState:SetBuild("garenporo_build")
    inst.AnimState:PlayAnimation("idle")
    inst:AddComponent("locomotor")
    inst.components.locomotor:SetSlowMultiplier(1)
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = { ignorecreep = true }
    inst:SetStateGraph("SGgarenporo")
    inst:AddComponent("lootdropper")
    inst.components.lootdropper.DropLoot = function(itself, pt)
        itself:SpawnLootPrefab('garenporo', pt)
    end
    inst:AddComponent("follower")
    local player = GetPlayer()
    if player and player.components.leader then
        player.components.leader:AddFollower(inst)
    end
    MakeMediumBurnableCharacter(inst, "body")
    MakeMediumFreezableCharacter(inst, "body")
    inst.components.burnable.flammability = TUNING.SPIDER_FLAMMABILITY
    inst:AddComponent("health")
    inst.components.health.canmurder = false
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "body"
    inst.components.combat:SetKeepTargetFunction(keeptargetfn)
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)
    inst:AddComponent("inspectable")
    local brain = require "brains/garenporobrain"
    inst:SetBrain(brain)
    inst:ListenForEvent("stopfollowing", function(inst) inst.persists = true end)
    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("daytime", function() StartDay(inst) end, GetWorld())
    inst:ListenForEvent("newcombattarget", function(inst, data)
        if data and data.oldtarget == GetPlayer() then
            inst.components.combat:SetTarget(nil)
        end
        if data and data.target == GetPlayer() then
            inst.components.combat:SetTarget(nil)
        end
    end)
    return inst
end

local function create_garenporo(Sim)
    local inst = create_common(Sim)
    inst.hunger = 0
    td1madao_initQualityAttr({ 0, 1, 1, 1 })
    inst.components.health:SetMaxHealth(100)
    inst.components.combat:SetDefaultDamage(10)
    inst.components.health:StartRegen(10, 10)
    inst.components.combat:SetAttackPeriod(1)
    inst.components.combat:SetRetargetFunction(3, NormalRetarget)
    inst.components.combat:SetHurtSound("dontstarve/creatures/hound/hurt")
    inst.components.locomotor.walkspeed = TUNING.SPIDER_WALK_SPEED * 1.5 * 2
    inst.components.locomotor.runspeed = TUNING.SPIDER_RUN_SPEED * 1.5 * 2
    inst.Transform:SetScale(0.5, 0.5, 0.5)
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.nobounce = true
    inst.components.inventoryitem.canbepickedup = true
    inst.components.inventoryitem.longpickup = true
    inst.components.inventoryitem.atlasname = "images/inventoryimages/garenporo.xml"
    inst.components.inventoryitem.imagename = "garenporo"
    inst.components.inventoryitem:SetOnDroppedFn(function(inst)
        local player = GetPlayer()
        if player and player.components.leader then
            player.components.leader:AddFollower(inst)
        end
        if inst.components.combat then
            inst.components.combat:SetTarget(nil)
        end
    end)
    inst.components.inventoryitem:SetOnPickupFn(function(inst)
        clearFollower(inst)
        local player = GetPlayer()
        if player and player.components.leader then
            player.components.leader:RemoveFollower(inst)
            inst.components.follower.leader = nil
        end
        if inst.components.combat then
            inst.components.combat:SetTarget(nil)
        end
    end)


    inst:AddTag("nosteal")
    local function OnGetItemFromPlayer(inst, giver, item)
        if item and item.components.edible then
            inst.hunger = inst.hunger + item.components.edible.hungervalue
            size2(inst)
            if inst.shuttask then
                inst.shuttask:Cancel()
                inst.shuttask = nil
            end
            inst.shuttask = inst:DoTaskInTime(60 * 8, function()
                inst.shuttask:Cancel()
                inst.shuttask = nil
            end)
        end
    end

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(function(inst, item)
        return item.components.edible
    end)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader:Enable()

    inst.old_monster_size = inst.Transform:GetScale()
    inst.old_monster_damage = inst.components.combat.defaultdamage
    inst.old_monster_health = inst.components.health.maxhealth
    inst.old_monster_mass = inst.Physics:GetMass()
    inst.old_monster_radius = inst.Physics:GetRadius()
    inst:AddComponent("cookable")
    if not inst.components.characterspecific then
        inst:AddComponent("characterspecific")
    end
    inst.components.characterspecific:SetOwner("garen")
    inst.components.cookable.product = function()
        return "cookedmonstermeat"
    end
    inst.components.cookable:SetOnCookedFn(function()
        inst.SoundEmitter:PlaySound("dontstarve/rabbit/scream_short")
    end)


    local function onsave(inst, data)
        if inst.hunger then
            data.hunger = inst.hunger
        else
            data.hunger = 0
        end
        clearFollower(inst, true)
    end

    local function onpreload(inst, data)
        if not data then
            data = {}
        end
        if data.hunger then
            inst.hunger = data.hunger
        else
            inst.hunger = 0
        end
        size2(inst)
        clearFollower(inst, true)
    end

    inst.OnSave = onsave
    inst.OnPreLoad = onpreload
    clearFollower(inst, true)
    return inst
end



return Prefab("forest/monsters/garenporo", create_garenporo, assets, prefabs)
