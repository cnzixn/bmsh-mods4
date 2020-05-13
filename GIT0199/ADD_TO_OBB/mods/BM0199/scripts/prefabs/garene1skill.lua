local assets =
{
    Asset("ANIM", "anim/garene1skill.zip"),
}

local function kill_fx(inst)
    if inst then
        inst:DoTaskInTime(0, function() inst:Remove() end)
    end
end

local function create_garenr(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    anim:SetBank("garene1skill")
    anim:SetBuild("garene1skill")
    anim:PlayAnimation("idle")
    inst.kill_fx = kill_fx
    inst.Transform:SetScale(1.5, 1.5, 1.5)
    MakeCharacterPhysics(inst, 1, .5)
    inst:DoTaskInTime(0.45, function() td1madao_safeRemove(inst) end)
    inst:Hide()
    return inst
end

local function create_garenr2(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    anim:SetMultColour(0.5, 0.5, 0.5, 0)
    anim:SetBank("garene1skill")
    anim:SetBuild("garene1skill")
    anim:PlayAnimation("idle2", true)
    inst.kill_fx = kill_fx
    inst.Transform:SetScale(0.75, 0.75, 0.75)
    MakeCharacterPhysics(inst, 1, .5)
    inst:DoTaskInTime(3, function() td1madao_safeRemove(inst) end)
    inst:Hide()
    return inst
end

local function create_garenr3(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst:AddTag("FX")
    inst:AddTag("NOCLICK")
    anim:SetMultColour(3, 3, 3, 0)
    anim:SetBank("garene1skill")
    anim:SetBuild("garene1skill")
    anim:PlayAnimation("idle3", true)
    inst.kill_fx = kill_fx
    inst.Transform:SetScale(2.5, 1, 2.5)
    inst:Hide()
    anim:SetLayer(LAYER_BACKGROUND)
    anim:SetSortOrder(3)
    anim:SetMultColour(0.5, 0.5, 1, 1)
    td1madao_removeIfNoOwner(inst)
    return inst
end


return Prefab("garene1skill", create_garenr, assets),
Prefab("garene1skill2", create_garenr2, assets),
Prefab("garene1skill3", create_garenr3, assets)