require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/garenslot_machine.zip"),
}

local prefabs =
{}


local function onsave(inst, data)
    if inst.times then
        data.times = inst.times
    else
        data.times = 0
    end
end

local function onpreload(inst, data)
    if data then
        if data.times then
            inst.times = data.times
        else
            inst.times = 0
        end
    end
end

local function kill_fx(inst)
    if inst then
        GetPlayer().businessmanslot = false
        td1madao_safespawn("explode_small").Transform:SetPosition(inst:GetPosition():Get())
        inst:DoTaskInTime(0, function() inst:Remove() end)
    end
end

local function GetVerb(inst)
    return STRINGS.ACTIONS.ACTIVATE.GENERIC
end

local function OnActivate(inst, doer)
    if inst.times >= 3 then
        kill_fx(inst)
        return
    end
    inst.components.activatable.inactive = true
    if inst.businessman then
        local garenslotscreen = require "screens/garenslotscreen"
        TheFrontEnd:PushScreen(garenslotscreen(inst.businessman.goods, inst.businessman, inst))
    end
end

local function onhammered(inst, worker)
    GetPlayer().businessmanslot = false
    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
    inst:Remove()
end

local function fn(Sim)
    local bus = TheSim:FindFirstEntityWithTag("lolbusiness")
    if GetPlayer().businessmanslot == true or not bus then
        return td1madao_safespawn('garennil')
    end
    local inst = CreateEntity()
    inst.times = 0
    inst.businessman = bus
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    MakeObstaclePhysics(inst, 0.8, 1.2)
    anim:SetBank("garenslot_machine")
    anim:SetBuild("garenslot_machine")
    anim:PlayAnimation("idle")
    inst:AddComponent("inspectable")
    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(2)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst:AddComponent("activatable")
    inst.components.activatable.OnActivate = OnActivate
    inst.components.activatable.getverb = GetVerb
    inst.components.activatable.inactive = true
    inst.components.activatable.quickaction = true
    inst:ListenForEvent("daytime", function(global, data)
        inst.times = 3
        inst:DoTaskInTime(15, function() kill_fx(inst) end)
    end, GetWorld())
    GetPlayer().businessmanslot = true

    inst.OnSave = onsave
    inst.OnPreLoad = onpreload

    return inst
end

return Prefab("common/garenslot_machine", fn, assets)