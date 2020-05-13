local assets =
{}


local creatures = {
    "deerclops",
    "bearger",
    "spiderqueen",
    "warg",
    "moose",
    "leif",
    "leif_sparse",
}

local bank = {
    "deerclops",
    "bearger",
    "spider_queen",
    "warg",
    "goosemoose",
    "leif",
    "leif",
}

local build = {
    "deerclops_build",
    "bearger_build",
    "spider_queen_build",
    "warg_build",
    "goosemoose_build",
    "leif_build",
    "leif_lumpy_build",
}

local SG = {
    "SGdeerclops",
    "SGbearger",
    "SGspiderqueen",
    "SGwarg",
    "SGmoose",
    "SGLeif",
    "SGLeif",
}

SetSharedLootTable('garensmallboss',
    {
        { 'meat', 1.00 },
    })

local function onsave(inst, data)
    if inst.creaturenum then
        data.creaturenum = inst.creaturenum
    else
        data.creaturenum = 1
    end
end

local function onpreload(inst, data)
    if data.creaturenum and Prefabs[creatures[data.creaturenum]] then
        inst.creaturenum = data.creaturenum
    else
        inst.creaturenum = 1
    end
    local anim = inst.AnimState
    anim:SetBank(bank[inst.creaturenum])
    anim:SetBuild(build[inst.creaturenum])
    inst:SetStateGraph(SG[inst.creaturenum])
end


local function IsStandState(inst, state)
    return true
end


local function SetStandState(inst, state)
    return "state"
end

local function OnAttacked(inst, data)
    local attacker = data and data.attacker
    if attacker and inst.components.combat:CanTarget(attacker) then
        inst.components.combat:SetTarget(attacker)
    end
end

local function KeepTargetFn(inst, target)
    return inst.components.combat:CanTarget(target)
            and target.components.health and not target.components.health:IsDead()
end

local function create_garensmallboss(Sim)

    local creature = '999-notexist'
    local creaturenum = -1
    repeat
        creaturenum = math.random(#bank)
        creature = creatures[creaturenum]
    until Prefabs[creature]

    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    local shadow = inst.entity:AddDynamicShadow()

    shadow:SetSize(1.5, .75)
    inst.Transform:SetFourFaced()
    MakeCharacterPhysics(inst, 50, .5)
    local s = .5
    inst.Transform:SetScale(s, s, s)
    inst:AddTag("animal")
    inst:AddTag("largecreature")
    inst:AddTag("scarytoprey")

    anim:SetBank(bank[creaturenum])
    anim:SetBuild(build[creaturenum])

    local brain = require "brains/garenwiltonbrain"
    inst:SetBrain(brain)
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('garensmallboss')
    inst:AddComponent("combat")
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(350)
    inst.components.combat:SetAttackPeriod(0.75)
    inst.components.combat:SetDefaultDamage(35)
    inst:AddComponent("inspectable")
    inst:AddComponent("locomotor")
    inst:AddComponent("inventory")
    if IsDLCEnabled and ((CAPY_DLC and IsDLCEnabled(CAPY_DLC)) or (REIGN_OF_GIANTS and IsDLCEnabled(REIGN_OF_GIANTS))) then
        inst:AddComponent("groundpounder")
        inst:AddComponent("timer")
    end
    inst.SetStandState = SetStandState
    inst.IsStandState = IsStandState
    inst:ListenForEvent("attacked", OnAttacked)
    inst.walkspeed = (GetPlayer().components.locomotor.walkspeed or 8) * 0.9
    inst.runspeed = (GetPlayer().components.locomotor.runspeed or 8) * 0.9
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    inst:SetStateGraph(SG[creaturenum])
    inst.entity:AddLight()

    inst.creaturenum = creaturenum
    inst.WorkEntities = function() end

    inst.OnSave = onsave
    inst.OnPreLoad = onpreload

    return inst
end

return Prefab("garensmallboss", create_garensmallboss, assets)