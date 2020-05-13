local assets =
{
    Asset("ANIM", "anim/garentask.zip"),
}

local function onsave(inst, data)
    inst:Remove()
end

local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    anim:SetBank("garentask")
    anim:SetBuild("garentask")
    anim:PlayAnimation("idle")
    inst.OnSave = onsave
    inst.OnPreLoad = onsave
    return inst
end

return Prefab("garentask", fn, assets)