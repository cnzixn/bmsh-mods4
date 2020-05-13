local assets =
{
    Asset("ANIM", "anim/rskill.zip"),
}

local function kill_fx(inst)
    inst:DoTaskInTime(0.6, function() inst:Remove() end)
end

local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    anim:SetBank("rskill")
    anim:SetBuild("rskill")
    anim:PlayAnimation("rskill_play")
    inst.kill_fx = kill_fx
    inst:DoTaskInTime(5, function() inst:Remove() end)
    return inst
end

return Prefab("rskill", fn, assets)