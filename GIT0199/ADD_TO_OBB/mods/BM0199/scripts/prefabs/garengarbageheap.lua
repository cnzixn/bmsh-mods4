require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/bonfire.zip"),
}

local prefabs =
{
    "collapse_small",
}

local function OnGetItemFromPlayer(inst, target)
    local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(0, 4.5, 0)
    local nug = td1madao_safespawn(target)
    if nug then
        nug.Transform:SetPosition(pt:Get())
        local down = TheCamera:GetDownVec()
        local angle = math.atan2(down.z, down.x) + (math.random() * 60 - 30) * DEGREES
        local sp = math.random() * 4 + 2
        nug.Physics:SetVel(sp * math.cos(angle), math.random() * 2 + 8, sp * math.sin(angle))
    end
end

local function processon(inst)
    for k, v in pairs(inst.components.container.slots) do
        if v and (v.components.perishable or v.prefab == 'spoiled_food') and math.random() < 0.5 then
            OnGetItemFromPlayer(inst, 'spoiled_food')
            local rm = math.random()
            if rm < 0.2 then
                td1madao_safespawn('spider').Transform:SetPosition(inst.Transform:GetWorldPosition())
            elseif rm < 0.4 then
                td1madao_safespawn('mosquito').Transform:SetPosition(inst.Transform:GetWorldPosition())
            end
        elseif v and v.components.finiteuses and math.random() < 0.1 then
            OnGetItemFromPlayer(inst, 'flint')
        elseif v and v.components.equippable and math.random() < 0.25 then
            if math.random() < 0.5 then
                OnGetItemFromPlayer(inst, 'twigs')
            else
                OnGetItemFromPlayer(inst, 'cutgrass')
            end
        elseif v and v.components.fuel and math.random() < 0.1 then
            OnGetItemFromPlayer(inst, 'charcoal')
        end
    end
    inst.components.container:DestroyContents()
end

local function onopen(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
end

local function onclose(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
    processon(inst)
end

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
    inst:Remove()
end

local slotpos_3x4 = {}

for y = 2.5, -0.5, -1 do
    for x = 0, 2 do
        table.insert(slotpos_3x4, Vector3(75 * x - 75 * 2 + 75, 75 * y - 75 * 2 + 75, 0))
    end
end

local widgetbuttoninfo =
{
    text = STRINGS.GARENDESTORY,
    position = Vector3(0, -165, 0),
    fn = processon,
}

local function itemtest(inst, item, slot)
    return true
end

local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    MakeObstaclePhysics(inst, .3)
    inst:AddTag("structure")
    inst:AddTag("chest")
    inst.AnimState:SetBank("bonfire")
    inst.AnimState:SetBuild("bonfire")
    inst.AnimState:PlayAnimation("off")
    inst:AddComponent("inspectable")
    inst:AddComponent("container")
    inst.components.container.itemtestfn = itemtest
    inst.components.container:SetNumSlots(#slotpos_3x4)
    inst.components.container.widgetslotpos = slotpos_3x4
    inst.components.container.widgetanimbank = "ui_chester_shadow_3x4"
    inst.components.container.widgetanimbuild = "ui_chester_shadow_3x4"
    inst.components.container.widgetpos = Vector3(0, 220, 0)
    inst.components.container.widgetpos_controller = Vector3(0, 220, 0)
    inst.components.container.side_align_tip = 160
    inst.components.container.widgetbuttoninfo = widgetbuttoninfo
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(2)
    inst.components.workable:SetOnFinishCallback(onhammered)
    return inst
end

return Prefab("common/garengarbageheap", fn, assets),
MakePlacer("common/garengarbageheap_placer", "bonfire", "bonfire", "off")
