local assets =
{
    Asset("ANIM", "anim/garenmosquitocoils.zip"),
    Asset("ATLAS", "images/inventoryimages/garenmosquitocoils.xml"),
    Asset("IMAGE", "images/inventoryimages/garenmosquitocoils.tex")
}

local INTENSITY = .5

local function flicker_stop(inst)
    if inst.flickertask then
        inst.flickertask:Cancel()
        inst.flickertask = nil
    end
end

local function flicker_update(inst)
    local time = GetTime() * 30
    local flicker = (math.sin(time) + math.sin(time + 2) + math.sin(time + 0.7777)) / 2.0 -- range = [-1 , 1]
    flicker = (1.0 + flicker) / 2.0 -- range = 0:1
    inst.Light:SetRadius(1.5 + 0.1 * flicker)
    inst.flickertask = inst:DoTaskInTime(0.1, function() flicker_update(inst) end)
end

local function fade_in(inst)
    inst.components.fader:StopAll()
    inst.Light:Enable(true)
    flicker_stop(inst)
    flicker_update(inst)
    inst.components.fader:Fade(0, INTENSITY, 5 * FRAMES, function(v) inst.Light:SetIntensity(v) end)
end

local function canbeattackedfn(inst, attacker)
    return false
end

local function fade_out(inst)
    inst.components.fader:StopAll()
    flicker_stop(inst)
    inst.components.fader:Fade(INTENSITY, 0, 5 * FRAMES, function(v) inst.Light:SetIntensity(v) end, function() inst.Light:Enable(false) end)
end

local function ondeath(inst)
    inst.components.fader:StopAll()
    inst.Light:Enable(false)
    inst.components.perishable:StopPerishing()
    if not inst:HasTag("rotten") then
        inst.components.lootdropper:SpawnLootPrefab("fireflies")
    end
end

local function onperish(inst)
    inst:AddTag("rotten")
    inst.components.health:Kill()
end

local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    local isday = GetClock():IsDay()
    inst.entity:AddPhysics()
    MakeInventoryPhysics(inst)
    local light = inst.entity:AddLight()
    inst.Light:SetFalloff(1)
    light:SetIntensity(.5)
    inst.Light:SetRadius(1.5)
    light:Enable(false)
    light:SetColour(1, 0, 0)
    inst.AnimState:SetBank("garenmosquitocoils")
    inst.AnimState:SetBuild("garenmosquitocoils")
    inst.AnimState:PlayAnimation("idle")
    inst:AddComponent("fader")
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/garenmosquitocoils.xml"
    inst.components.inventoryitem.imagename = "garenmosquitocoils"
    inst.components.inventoryitem.nobounce = true
    inst:AddComponent("combat")
    inst.components.combat.canbeattackedfn = canbeattackedfn
    inst:AddComponent("health")
    inst.components.health.canmurder = false
    inst:AddComponent("lootdropper")
    inst.components.health:SetMaxHealth(1)
    inst:ListenForEvent("death", ondeath)
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(15 * TUNING.TOTAL_DAY_TIME)
    inst.components.perishable:SetOnPerishFn(onperish)
    inst.components.inventoryitem:SetOnDroppedFn(function(inst)
        inst.components.perishable:StartPerishing()
        td1madao_removeTask(inst, "td1madaokillinsect")
        inst.td1madaokillinsect = inst:DoPeriodicTask(2, function()
            local ents = td1madao_findAround(inst, 15)
            for k, v in pairs(ents) do
                if td1madao_alive(v) and v.prefab == 'mosquito' and v.components.health and v.components.health.Kill then
                    if not v.components.talker then
                        v:AddComponent("talker")
                        v.components.talker:Say(TUNING.LOLMEMBER.TALK99)
                    end
                    v.components.health:Kill()
                end
            end
        end)
        if not GetClock():IsDay() then
            fade_in(inst)
        end
    end)
    inst.components.inventoryitem:SetOnPutInInventoryFn(function(inst)
        td1madao_removeTask(inst, "td1madaokillinsect")
        inst.components.perishable:StopPerishing()
        fade_out(inst)
    end)

    inst:ListenForEvent("daytime", function()
        if not inst.components.inventoryitem.owner and not inst.components.health:IsDead() and not inst:HasTag("rotten") then
            inst:DoTaskInTime(2 + math.random() * 1, function() fade_out(inst) end)
        end
    end, GetWorld())

    inst:ListenForEvent("dusktime", function()
        if not inst.components.inventoryitem.owner and not inst.components.health:IsDead() and not inst:HasTag("rotten") then
            inst:DoTaskInTime(2 + math.random() * 1, function() if not inst.components.inventoryitem.owner then fade_in(inst) end end)
        end
    end, GetWorld())

    if not inst.components.inventoryitem.owner and not isday then
        fade_in(inst)
    end

    return inst
end


return Prefab("common/inventory/garenmosquitocoils", fn, assets)

