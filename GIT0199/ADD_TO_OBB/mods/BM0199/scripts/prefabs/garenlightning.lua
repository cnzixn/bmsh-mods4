local assets =
{
    Asset("ANIM", "anim/garenlightning_blue.zip"),
}
local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLight()
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetLightOverride(1)
    inst.Transform:SetScale(1, 1, 1)
    inst.AnimState:SetBank("garenlightning")
    inst.AnimState:SetBuild("garenlightning_blue")
    inst.AnimState:PlayAnimation("anim")
    inst:AddTag("FX")
    inst.persists = false
    inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
    inst:AddComponent("highlight")
    local frozenColor = Vector3(math.random(), math.random(), math.random())
    local r, g, b = frozenColor.x, frozenColor.y, frozenColor.z
    inst.components.highlight:SetAddColour(Vector3(r, g, b))
    inst:ListenForEvent("animover", function() inst:Remove() end)
    inst:DoTaskInTime(10, function()
        inst:Remove()
    end)
    return inst
end

return Prefab("common/garenlightning", fn, assets)
