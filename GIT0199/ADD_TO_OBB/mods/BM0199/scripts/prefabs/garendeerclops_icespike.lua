local assets =
{
    Asset("ANIM", "anim/garendeerclops_icespike.zip")
}
local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    if IsDLCEnabled and ((REIGN_OF_GIANTS and IsDLCEnabled(REIGN_OF_GIANTS)) or (CAPY_DLC and IsDLCEnabled(CAPY_DLC))) then
        inst.SoundEmitter:PlaySound("dontstarve/creatures/deerclops/ice_large")
    end
    anim:SetBank("garendeerclops_icespike")
    anim:SetBuild("garendeerclops_icespike")
    anim:PlayAnimation("spike" .. math.random(4), false)
    inst:DoTaskInTime(5, function() inst:Remove() end)
    return inst
end

return Prefab("garendeerclops_icespike", fn, assets)
