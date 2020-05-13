local assets =
{
    Asset("ANIM", "anim/garenslience.zip"),
}

local function kill_fx(inst)
    inst:Remove()
end

local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    anim:SetBank("garenslience")
    anim:SetBuild("garenslience")
    anim:PlayAnimation("idle")
    inst.kill_fx = kill_fx
    inst:DoTaskInTime(3, function() inst:Remove() end)
    return inst
end

return Prefab("garenslience", fn, assets)