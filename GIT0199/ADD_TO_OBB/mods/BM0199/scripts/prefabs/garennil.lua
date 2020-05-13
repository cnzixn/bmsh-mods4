local assets =
{}

local function kill_fx(inst)
    if inst then
        inst:DoTaskInTime(0.1, function() inst:Remove() end)
    end
end

local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(10)
    inst.kill_fx = kill_fx
    inst:DoTaskInTime(60, function() inst:Remove() end)
    return inst
end

return Prefab("garennil", fn, assets)