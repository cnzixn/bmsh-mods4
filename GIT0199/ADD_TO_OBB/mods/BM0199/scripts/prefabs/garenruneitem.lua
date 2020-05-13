local assets =
{
    Asset("ANIM", "anim/garenruneitem.zip"),
    Asset("ATLAS", "images/inventoryimages/garenruneitem.xml"),
    Asset("IMAGE", "images/inventoryimages/garenruneitem.tex")
}

local function changeName(inst)
    inst.name = string.format("[%s][%s+%s]%s", (STRINGS.NAMES[string.upper(inst.killCreature)] or inst.killCreature), (TUNING.LOLMEMBER["TALK" .. tostring(inst.attr + 42)]), inst.exp, STRINGS.NAMES.GARENRUNEITEM)
end

local function onsave(inst, data)
    if inst.killCreature then
        data.killCreature = inst.killCreature
    else
        data.killCreature = "spider"
    end
    if inst.attr then
        data.attr = inst.attr
    else
        data.attr = 1
    end
    if inst.exp then
        data.exp = inst.exp
    else
        data.exp = 1
    end
end

local function onpreload(inst, data)
    if not data then
        data = {}
    end
    if data.killCreature then
        inst.killCreature = data.killCreature
    else
        inst.killCreature = "spider"
    end
    if data.attr then
        inst.attr = data.attr
    else
        inst.attr = 1
    end
    if data.exp then
        inst.exp = data.exp
    else
        inst.exp = 1
    end
    changeName(inst)
    td1madao_showQuality2(inst)
end



local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("garenruneitem")
    inst.AnimState:SetBuild("garenruneitem")
    inst.AnimState:PlayAnimation("idle")
    inst:AddComponent("inspectable")
    inst:AddTag("td1madao_rune")
    inst.killCreature = "spider"
    inst.attr = 1 -- 1,2,3,4
    inst.exp = 1
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/garenruneitem.xml"
    inst.components.inventoryitem.imagename = "garenruneitem"
    inst.changeName = changeName
    inst.OnSave = onsave
    inst.OnPreLoad = onpreload
    changeName(inst)
    td1madao_showQuality2(inst)
    return inst
end

return Prefab("common/inventory/garenruneitem", fn, assets)

