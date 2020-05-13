local assets =
{
    Asset("ANIM", "anim/garensoulball.zip"),
    Asset("ATLAS", "images/inventoryimages/garenhammer.xml"),
    Asset("IMAGE", "images/inventoryimages/garenhammer.tex"),
}
local prefabs = {}
local function fn()
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
    anim:SetBank("garensoulball")
    anim:SetBuild("garensoulball")
    anim:PlayAnimation("garenhammer")
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "garenhammer"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/garenhammer.xml"
    inst:AddComponent("repairer")
    inst.components.repairer.repairmaterial = "gem"
    inst.components.repairer.workrepairvalue = TUNING.REPAIR_GEMS_WORK
    inst:AddComponent("fuel")
    td1madao_initQualityAttr({ 0, 1, 0, 1 })
    inst.components.fuel.fuelvalue = 1
    inst.components.fuel.fueltype = "lolhammer"
    inst.components.fuel:SetOnTakenFn(function(inst, taker)
        if taker and taker:HasTag("garenweapon") then
            local fx2 = td1madao_safespawn("statue_transition")
            if not fx2.components.highlight then
                fx2:AddComponent("highlight")
            end
            fx2.components.highlight:SetAddColour(Vector3(0, 0, 1))
            fx2.Transform:SetScale(2, 2, 2)
            fx2.Transform:SetPosition(inst:GetPosition():Get())
            if taker.weaponfix ~= nil then
                taker.weaponfix = taker.weaponfix + 1
                if taker.components.finiteuses then
                    taker.components.finiteuses:SetMaxUses(TUNING.SPEAR_USES + taker.weaponfix * 30)
                    taker.components.finiteuses.current = taker.components.finiteuses.total
                end
            end
        end
    end)
    return inst
end

return Prefab("common/inventory/garenhammer", fn, assets, prefabs)
