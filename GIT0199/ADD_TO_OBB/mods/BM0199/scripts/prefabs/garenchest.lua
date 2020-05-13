require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/ui_chest_3x3.zip"),
    Asset("ANIM", "anim/pandoras_chest.zip"),
    Asset("ANIM", "anim/skull_chest.zip"),
}

local chests = {
    skull_chest = {
        bank = "skull_chest",
        build = "skull_chest",
    },
    pandoras_chest = {
        bank = "pandoras_chest",
        build = "pandoras_chest",
    },
}


local function onopen(inst)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("open")
        inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
    end
end

local function onclose(inst)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("close")
        inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
    end
end

local function onhammered(inst, worker)
    if inst:HasTag("fire") and inst.components.burnable then
        inst.components.burnable:Extinguish()
    end
    inst.components.lootdropper:DropLoot()
    if inst.components.container then inst.components.container:DropEverything() end
    td1madao_safespawn("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
    inst:Remove()
end

local function onhit(inst, worker)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("closed", false)
        if inst.components.container then
            inst.components.container:DropEverything()
            inst.components.container:Close()
        end
    end
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("closed", false)
end

local function onsave(inst, data)
    if inst:HasTag("burnt") or inst:HasTag("fire") then
        data.burnt = true
    end
end

local function onload(inst, data)
    if data and data.burnt then
        inst.components.burnable.onburnt(inst)
    end
end

local slotpos = {}

for y = 2.5, -0.5, -1 do
    for x = 0, 2 do
        table.insert(slotpos, Vector3(75 * x - 75 * 2 + 75, 75 * y - 75 * 2 + 75, 0))
    end
end

local function chest(style)
    local fn = function(Sim)
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        local minimap = inst.entity:AddMiniMapEntity()

        minimap:SetIcon("garen" .. style .. ".tex")


        inst:AddTag("structure")
        inst:AddTag("chest")
        inst.AnimState:SetBank(chests[style].bank)
        inst.AnimState:SetBuild(chests[style].build)
        inst.AnimState:PlayAnimation("closed")

        inst:AddComponent("inspectable")
        inst:AddComponent("container")
        inst.components.container:SetNumSlots(#slotpos)

        inst.components.container.onopenfn = onopen
        inst.components.container.onclosefn = onclose

        inst.components.container.widgetslotpos = slotpos
        inst.components.container.widgetanimbank = "ui_chester_shadow_3x4"
        inst.components.container.widgetanimbuild = "ui_chester_shadow_3x4"
        inst.components.container.widgetpos = Vector3(0, 200, 0)
        inst.components.container.side_align_tip = 160

        inst:AddComponent("lootdropper")
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(2)
        inst.components.workable:SetOnFinishCallback(onhammered)
        inst.components.workable:SetOnWorkCallback(onhit)

        inst:ListenForEvent("onbuilt", onbuilt)
        MakeSnowCovered(inst, .01)
        if IsDLCEnabled and CAPY_DLC and (IsDLCEnabled(CAPY_DLC) or IsDLCEnabled(REIGN_OF_GIANTS)) then
            MakeSmallBurnable(inst, nil, nil, true)
            MakeSmallPropagator(inst)
            inst.OnSave = onsave
            inst.OnLoad = onload
        end
        return inst
    end
    return fn
end

return Prefab("common/garenskullchest", chest("skull_chest"), assets),
MakePlacer("common/garenskullchest_placer", "chest", "skull_chest", "closed"),
Prefab("common/garenpandoras_chest", chest("pandoras_chest"), assets),
MakePlacer("common/garenpandoras_chest_placer", "chest", "pandoras_chest", "closed")

