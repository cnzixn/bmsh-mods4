local assets =
{
    Asset("ANIM", "anim/garenpackage.zip"),
    Asset("ATLAS", "images/inventoryimages/garenpackage.xml"),
    Asset("IMAGE", "images/inventoryimages/garenpackage.tex"),
}

local function do_unpack(inst)
    if inst.components.garenpacker:Unpack() then
        inst:Remove()
    end
end

local function get_name(inst)
    local basename = inst.components.garenpacker:GetName()
    if basename then
        return basename
    else
        return "unknown package"
    end
end

local function fn(Sim, iteminside)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
    inst.Transform:SetScale(1.5, 1.5, 1.5)
    inst.AnimState:SetBank("garenpackage")
    inst.AnimState:SetBuild("garenpackage")
    inst.AnimState:PlayAnimation("idle")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.nobounce = false
    inst.components.inventoryitem.atlasname = "images/inventoryimages/garenpackage.xml"
    inst:AddComponent("inspectable")
    inst:AddComponent("garenpacker")
    inst:AddComponent("deployable")
    local deployable = inst.components.deployable
    deployable.ondeploy = do_unpack
    inst.displaynamefn = get_name
    return inst
end

return Prefab("common/inventory/garenpackage", fn, assets),
MakePlacer("common/inventory/garenpackage_placer", "garenpackage", "garenpackage", "idle", false, false, true, 3)

