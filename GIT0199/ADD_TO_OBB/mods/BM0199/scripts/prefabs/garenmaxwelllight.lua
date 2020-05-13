require "prefabutil"
require "scheduler"
require "simutil"
require "behaviours/doaction"

assets =
{
    Asset("SOUND", "sound/common.fsb"),
    Asset("ANIM", "anim/maxwell_torch.zip"),
}
local prefabs =
{
    "pigtorch_flame",
}

local function onfar(inst)
    if inst.components.fueled.currentfuel ~= 0 then
        inst.components.fueled.currentfuel = 0
        inst.components.burnable:Extinguish()
        if inst.components.cooker then
            inst:RemoveComponent("cooker")
        end
    end
end

local function onnear(inst)
    if not GetClock():IsDay() then
        inst.components.fueled:InitializeFuelLevel(3)
        inst.components.fueled.currentfuel = 65535
        inst.components.burnable:Ignite()
        inst.components.burnable:SetFXLevel(3, 1)
        if not inst.components.cooker then
            inst:AddComponent("cooker")
        end
    elseif inst.components.fueled.currentfuel ~= 0 then
        onfar(inst)
    end
end

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
    inst:Remove()
end

local function fn()
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    MakeObstaclePhysics(inst, 0.33)
    inst:AddComponent("inspectable")
    inst:AddComponent("burnable")
    inst.components.burnable:AddBurnFX("pigtorch_flame", Vector3(0, 45, 0), "fire_marker")
    inst:AddComponent("fueled")
    inst.components.fueled.accepting = false
    inst.components.fueled.maxfuel = 600
    inst.components.fueled:SetSections(4)
    anim:SetBank("maxwell_torch")
    anim:SetBuild("maxwell_torch")
    anim:PlayAnimation("idle", true)
    inst:AddTag("campfire")
    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("garenmaxwelllight.tex")
    inst:AddTag("structure")
    inst:AddComponent("lootdropper")

    if not inst.components.characterspecific then
        inst:AddComponent("characterspecific")
    end
    inst.components.characterspecific:SetOwner("garen")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(15, 15)
    inst.components.playerprox:SetOnPlayerNear(onnear)
    inst.components.playerprox:SetOnPlayerFar(onfar)
    inst.components.fueled:InitializeFuelLevel(3)
    inst:ListenForEvent("dusktime", function(global, data)
        local player = GetPlayer()
        local distsq = player:GetDistanceSqToInst(inst)
        if distsq < 20 * 20 then
            onnear(inst)
        end
    end, GetWorld())
    inst:ListenForEvent("daytime", function(global, data)
        onfar(inst)
    end, GetWorld())


    inst:ListenForEvent("entitysleep", function()
        if SaveGameIndex and SaveGameIndex.IsModeShipwrecked and SaveGameIndex:IsModeShipwrecked() then
            local pos = Vector3(inst.Transform:GetWorldPosition())
            local start_angle = math.random() * PI * 2
            local rad = 0.5
            if inst.Physics then
                rad = rad + inst.Physics:GetRadius()
            end
            local offset = FindWalkableOffset(pos, start_angle, rad, 8, false)
            local isCursorWet = inst:GetIsOnWater(inst.Transform:GetWorldPosition())
            local invalidpos = offset == nil or isCursorWet
            if invalidpos then
                inst:Remove()
                return
            end
        end
    end)






    return inst
end

return Prefab("common/garenmaxwelllight", fn, assets, prefabs),
MakePlacer("common/garenmaxwelllight_placer", "maxwell_torch", "maxwell_torch", "idle")