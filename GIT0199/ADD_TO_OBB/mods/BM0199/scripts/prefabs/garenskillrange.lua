local assets =
{
    Asset("ANIM", "anim/garenskillrange.zip"),
}

local function kill_fx(inst)
    if inst then
        inst:DoTaskInTime(0, function() inst:Remove() end)
    end
end

local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    anim:SetBank("garenskillrange")
    anim:SetBuild("garenskillrange")
    anim:PlayAnimation("idle")
    inst.Transform:SetScale(3, 1, 1)
    inst:Hide()
    inst.kill_fx = kill_fx
    inst:DoTaskInTime(3, function() inst:Remove() end)
    return inst
end

return Prefab("garenskillrange", fn, assets)