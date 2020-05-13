local assets =
{
    Asset("ANIM", "anim/garensoulball.zip"),
    Asset("ATLAS", "images/inventoryimages/garensoulballblue.xml"),
    Asset("IMAGE", "images/inventoryimages/garensoulballblue.tex"),
}
local prefabs = {}
local function fn()
    local inst = CreateEntity()
    td1madao_initQualityAttr({ 0, 1, 1, 1 })
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
    anim:SetBank("garensoulball")
    anim:SetBuild("garensoulball")
    anim:PlayAnimation("garensoulballblue")
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "garensoulballblue"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/garensoulballblue.xml"
    inst:AddComponent("repairer")
    inst.components.repairer.repairmaterial = "gem"
    inst.components.repairer.workrepairvalue = TUNING.REPAIR_GEMS_WORK
    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = 1
    inst.components.fuel.fueltype = "soulballblue"
    inst.components.fuel:SetOnTakenFn(function(inst, taker)
        if taker and taker:HasTag("garenweapon") then
            local fx2 = td1madao_safespawn("statue_transition")
            if not fx2.components.highlight then
                fx2:AddComponent("highlight")
            end
            fx2.components.highlight:SetAddColour(Vector3(0, 0, 1))
            fx2.Transform:SetScale(2, 2, 2)
            fx2.Transform:SetPosition(inst:GetPosition():Get())
        end
        c_give(taker.prefab)
        taker:Remove()
    end)
    return inst
end

return Prefab("common/inventory/garensoulballblue", fn, assets, prefabs)
