require "prefabutil"

local assets =
{
    Asset("INV_IMAGE", "accomplishment_shrine"),
}

local prefabs =
{
    "firework_fx",
    "multifirework_fx"
}

local enemy =
{
    TUNING.GARENENEMYNAME,
    "garenrandomcreature",
}

local talkthing =
{
    "go on",
    "try once more",
    "good",
    "sounds changed",
    "do not stop",
    "nice",
    "need more",
}

local award =
{
    'purplegem',
    'bluegem',
    'redgem',
    'orangegem',
    'yellowgem',
    'greengem',
    'goldnugget',
    'thulecite',
    'amulet',
    'blueamulet',
    'purpleamulet',
    'firestaff',
    'icestaff',
    'telestaff',
    'orangeamulet',
    'yellowamulet',
    'greenamulet',
    'orangestaff',
    'yellowstaff',
    'greenstaff',
    "garenweapon1",
    "garenweapon2",
    "garenweapon3",
    "garenweapon4",
    "garenweapon5",
    "garenweapon6",
    "garenweapon7",
    "garenweapon8",
    "garenweapon9",
    "garenweapon10",
    "garenweapon11",
    "garenweapon12",
    "garenweapon13",
    "garenweapon14",
    "garenweapon15",
    "garenweapon16",
    "garenweapon17",
    "garenweapon18",
    "garenweapon19",
    "garenweapon20",
    "garenweapon21",
    "garenweapon22",
    "garenweapon23",
    "garenweapon24",
    "garenweapon25",
    "garenweapon26",
}
local function OnGetItemFromPlayer(inst, target)
    local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(0, 4.5, 0)
    local nug = td1madao_safespawn(target)
    if nug then
        nug.Transform:SetPosition(pt:Get())
        local down = TheCamera:GetDownVec()
        local angle = math.atan2(down.z, down.x) + (math.random() * 60 - 30) * DEGREES
        local sp = math.random() * 4 + 2
        if nug.Physics then
            nug.Physics:SetVel(sp * math.cos(angle), math.random() * 2 + 8, sp * math.sin(angle))
        end
    end
end

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    td1madao_safespawn("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_metal")
    inst:Remove()
end

local clicks_per_step = 6
local anim_steps = 29
local total_clicks = clicks_per_step * anim_steps

local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("hit")
    inst:DoTaskInTime(13 / 30, function()
        inst.AnimState:SetPercent("active", inst.clicks / total_clicks)
    end)
end

local function GetVerb(inst)
    return STRINGS.ACTIONS.ACTIVATE.ACCOMPLISH
end


local function dospinanim(inst, startp, endp)
    if not inst.task then

        local target_percent = endp or inst.clicks / total_clicks
        local start_percent = startp or (inst.clicks - 1) / total_clicks
        local percent = start_percent
        local dt = 1 / 30

        local percent_speed = (inst.clicks % clicks_per_step) / (clicks_per_step - 1)

        local slow = 5
        local fast = 2

        local percent_change_rate = (percent_speed * slow + (1 - percent_speed) * fast) / 2



        local looped = (startp and endp) and true or false

        inst.task = inst:DoPeriodicTask(dt, function()
            percent = percent + dt * percent_change_rate
            if looped and percent > target_percent then
                percent = target_percent
                inst.task:Cancel()
                inst.task = nil
                inst.components.activatable.inactive = true
            else
                if percent >= 1 then
                    looped = true
                    percent = 0
                end
            end

            inst.AnimState:SetPercent("active", percent)
        end)
    end
end

local function OnActivate(inst, doer)
    local old_clicks = inst.clicks
    inst.clicks = inst.clicks + 1
    if inst.clicks < total_clicks then

        inst.SoundEmitter:PlaySound("dontstarve/common/shrine/shrine_click", "click")
        inst.SoundEmitter:SetParameter("click", "click", (inst.clicks - 1) % clicks_per_step)

        if inst.clicks % clicks_per_step == 0 then
            doer:PushEvent("accomplishment")
            inst.AnimState:PlayAnimation("reward")
            GetPlayer().components.talker:Say(TUNING.LOLMEMBER.TALK16)
            local x0, y0, z0 = GetPlayer().Transform:GetWorldPosition()
            local creature = nil
            inst:DoTaskInTime(1.5, function()
                GetPlayer().components.talker:Say("~!@#$%^&*()")
                for i = 1, 1 do
                    for i = 1, 100 do
                        local rad = math.random(7, 15)
                        local angle = math.random() * 2 * PI
                        local x, y, z = x0 + rad * math.cos(angle), y0, z0 + rad * math.sin(angle)
                        if td1madao_isvalidposition(x, y, z) then
                            local friend = td1madao_safespawn('garenmemberd')
                            friend.components.talker:Say(TUNING.LOLMEMBER.TALK17)
                            friend.Transform:SetPosition(x, y, z)
                            td1madao_safespawn("collapse_small").Transform:SetPosition(x, y, z)
                            break
                        end
                    end
                end
            end)
            inst:DoTaskInTime(4, function()
                GetPlayer().components.talker:Say(TUNING.LOLMEMBER.TALK10)
                for i = 1, 2 + math.random(8) do
                    for i = 1, 100 do
                        local rad = math.random(7, 15)
                        local angle = math.random() * 2 * PI
                        local x, y, z = x0 + rad * math.cos(angle), y0, z0 + rad * math.sin(angle)
                        if td1madao_isvalidposition(x, y, z) then
                            td1madao_safespawn(enemy[math.random(#enemy)]).Transform:SetPosition(x, y, z)
                            td1madao_safespawn("collapse_small").Transform:SetPosition(x, y, z)
                            break
                        end
                    end
                end
            end)
            OnGetItemFromPlayer(inst, award[math.random(#award)])
            GetPlayer().components.sanity:DoDelta(-math.random(50))
            td1madao_safespawn("firework_fx").Transform:SetPosition(inst.Transform:GetWorldPosition())
            inst:DoTaskInTime(35 / 30, function() dospinanim(inst, 0, (inst.clicks + 1) / total_clicks) end)
        else
            td1madao_randomTalk(GetPlayer(), talkthing)
            dospinanim(inst)
        end
    else
        doer:PushEvent("accomplishment_done")
        td1madao_safespawn("multifirework_fx").Transform:SetPosition(inst.Transform:GetWorldPosition())
        inst.AnimState:PlayAnimation("done")
        inst.AnimState:PushAnimation("done_pst", false)
        if old_clicks < total_clicks then
            TheGameService:AwardAchievement("achievement_10")
        end
        inst.SoundEmitter:PlaySound("dontstarve/common/shrine/shrine_final")
        inst:DoTaskInTime(2.5, function() inst.components.activatable.inactive = true end)
    end
end

local function onbuilt(inst)
    TheGameService:AwardAchievement("achievement_9")
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", true)
end

local function OnSave(inst, data)
    data.clicks = inst.clicks
end

local function OnLoad(inst, data)
    if data then
        inst.clicks = data.clicks or inst.clicks

        if inst.clicks >= total_clicks then
        else
            inst.AnimState:SetPercent("active", inst.clicks / total_clicks)
        end
    end
end

local assets =
{
    Asset("ANIM", "anim/accomplishment_shrine.zip"),
}

local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("accomplishment_shrine.png")

    MakeObstaclePhysics(inst, .4)

    anim:SetBank("accomplishment_shrine")
    anim:SetBuild("accomplishment_shrine")
    anim:PlayAnimation("idle", true)

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

    inst:AddComponent("activatable")
    inst.components.activatable.OnActivate = OnActivate
    inst.components.activatable.getverb = GetVerb
    inst.components.activatable.inactive = true
    inst.components.activatable.quickaction = true

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    inst.clicks = 0
    inst:ListenForEvent("onbuilt", onbuilt)
    return inst
end

return Prefab("common/objects/garenaccomplishment_shrine", fn, assets, prefabs),
MakePlacer("common/garenaccomplishment_shrine_placer", "accomplishment_shrine", "accomplishment_shrine", "idle")


