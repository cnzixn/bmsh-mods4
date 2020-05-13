local assets =
{
    Asset("ANIM", "anim/garenwormhole_shipwrecked.zip"),
}

local function onpreload(inst, data)
    if data.memoryx then
        inst.memoryx = data.memoryx
    else
        inst.memoryx = nil
    end
    if data.memoryy then
        inst.memoryy = data.memoryy
    else
        inst.memoryy = nil
    end
    if data.memoryz then
        inst.memoryz = data.memoryz
    else
        inst.memoryz = nil
    end
    if data.gohome then
        inst.gohome = data.gohome
    else
        inst.gohome = nil
    end
end

local function onsave(inst, data)
    if inst.memoryx then
        data.memoryx = inst.memoryx
    else
        data.memoryx = nil
    end
    if inst.memoryy then
        data.memoryy = inst.memoryy
    else
        data.memoryy = nil
    end
    if inst.memoryz then
        data.memoryz = inst.memoryz
    else
        data.memoryz = nil
    end
    if inst.gohome then
        data.gohome = inst.gohome
    else
        data.gohome = false
    end
end

local function GetVerb(inst)
    return STRINGS.ACTIONS.ACTIVATE.GENERIC
end

local function OnActivate(inst)
    local doer = GetPlayer()
    if inst.memoryx and inst.memoryy and inst.memoryz then
        doer.components.talker:Say(GetString(doer.prefab, "ANNOUNCE_WORMHOLE"))
        doer.Transform:SetPosition(inst.memoryx, inst.memoryy, inst.memoryz)
        if not inst.gohome then
            c_give("garenhearthstone")
        end
        if inst.rollback then
            inst.rollback:Remove()
        end
        inst:Remove()
    end
end

local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    anim:SetBank("garenteleporter_worm")
    anim:SetBuild("garenwormhole_shipwrecked")
    anim:PlayAnimation("in")
    anim:PushAnimation("open_loop", true)
    inst:AddComponent("inspectable")
    inst.OnSave = onsave
    inst.OnPreLoad = onpreload

    inst:AddComponent("activatable")
    inst.components.activatable.OnActivate = OnActivate
    inst.components.activatable.inactive = true
    inst.components.activatable.getverb = GetVerb
    inst.components.activatable.quickaction = true

    return inst
end

return Prefab("garenwormhole_shipwrecked_fx", fn, assets)