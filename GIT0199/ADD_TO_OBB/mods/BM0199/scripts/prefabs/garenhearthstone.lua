local assets =
{
    Asset("ANIM", "anim/garensoulball.zip"),
    Asset("ATLAS", "images/inventoryimages/garenhearthstone.xml"),
    Asset("IMAGE", "images/inventoryimages/garenhearthstone.tex"),
}
local prefabs = {}

local function zf()
    local n = math.random(2) - 1
    if n == 0 then
        n = -1
    end
    return n
end

local function onused(inst)
    local caster = GetPlayer()
    local pt = caster:GetPosition()
    local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 9000, { "lolpytrader" })
    if #ents <= 0 then
        caster.components.talker:Say(TUNING.LOLMEMBER.TALK70)
        return false
    end
    local telepor = nil
    for k, v in pairs(ents) do
        if v.prefab == "researchlab2" then
            telepor = v
            break
        end
    end
    if not telepor then
        for k, v in pairs(ents) do
            telepor = v
            break
        end
    end
    if caster and caster.components.driver and caster.components.driver.vehicle then
        return
    end
    if not telepor then
        caster.components.talker:Say(TUNING.LOLMEMBER.TALK70)
        return false
    end
    local x0, y0, z0 = telepor.Transform:GetWorldPosition()
    local creature = td1madao_safespawn("garenwormhole_shipwrecked_fx")
    local success = false
    for i = 1, 100 do
        local calcx = pt.x - (2 * zf() + math.random(2) * zf())
        local calcy = 0
        local calcz = pt.z - (2 * zf() + math.random(2) * zf())
        if td1madao_isvalidposition(calcx, calcy, calcz, 3) then
            creature.Transform:SetPosition(calcx, calcy, calcz)
            success = true
            break
        end
    end
    if not success then
        if creature then
            creature:Remove()
        end
        if caster and caster.components.talker then
            caster.components.talker:Say(TUNING.LOLMEMBER.TALK72)
        end
        return
    end
    creature.memoryx = x0
    creature.memoryy = y0
    creature.memoryz = z0
    creature.gohome = true
    success = false
    local creature2 = td1madao_safespawn("garenwormhole_shipwrecked_fx")
    for i = 1, 100 do
        local calcx = x0 - (2 * zf() + math.random(2) * zf())
        local calcy = 0
        local calcz = z0 - (2 * zf() + math.random(2) * zf())
        if td1madao_isvalidposition(calcx, calcy, calcz, 3) then
            creature2.Transform:SetPosition(calcx, calcy, calcz)
            success = true
            break
        end
    end
    if not success then
        if creature then
            creature:Remove()
        end
        if creature2 then
            creature2:Remove()
        end
        if caster and caster.components.talker then
            caster.components.talker:Say(TUNING.LOLMEMBER.TALK73)
        end
        return
    end
    creature2.memoryx = pt.x
    creature2.memoryy = pt.y
    creature2.memoryz = pt.z
    creature2.rollback = creature
    creature2.gohome = false
    caster.SoundEmitter:PlaySound("dontstarve/common/staffteleport")
    if caster and caster.components.hunger then
        caster.components.hunger:DoDelta(-35, false, true)
    end
    inst:Remove()
    return true
end

local function onusedTestFn(inst)
    local caster = inst.components.inventoryitem.owner
    return not caster:HasTag("aquatic")
end

local function fn()
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
    td1madao_initQualityAttr({ 0, 1, 1, 1 })
    anim:SetBank("garensoulball")
    anim:SetBuild("garensoulball")
    anim:PlayAnimation("garenhearthstone")
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "garenhearthstone"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/garenhearthstone.xml"

    inst:AddComponent("useableitem")
    inst.components.useableitem:SetCanInteractFn(onusedTestFn)
    inst.components.useableitem:SetOnUseFn(onused)

    return inst
end

return Prefab("common/inventory/garenhearthstone", fn, assets, prefabs)
