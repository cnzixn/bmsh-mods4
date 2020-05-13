require "prefabutil"
local assets =
{
    Asset("ANIM", "anim/tent.zip"),
}

SetSharedLootTable('garentent',
    {
        { 'spear', 1.00 },
        { 'armorwood', 1.00 },
        { 'footballhat', 1.00 },
        { 'smallmeat_dried', 1.00 },
        { 'goldnugget', 1.00 },
        { 'purplegem', 0.002 },
        { 'bluegem', 0.010 },
        { 'redgem', 0.010 },
        { 'orangegem', 0.002 },
        { 'yellowgem', 0.002 },
        { 'greengem', 0.002 },
        { 'garensoulball', 0.05 },
        { 'garensoulballwhite', 0.05 },
    })
local function OnDay(inst)
    if inst.components.spawner:IsOccupied() then
        if inst.doortask then
            inst.doortask:Cancel()
            inst.doortask = nil
        end
        inst.doortask = inst:DoTaskInTime(1 + math.random() * 2, function() inst.components.spawner:ReleaseChild() end)
    end
end

local function onhammered(inst, worker)
    if inst:HasTag("fire") and inst.components.burnable then
        inst.components.burnable:Extinguish()
    end
    inst.components.lootdropper:DropLoot()
    td1madao_safespawn("collapse_big").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
    inst:Remove()
end

local function SpawnGuardHound(inst, attacker)
    local prefab = inst.components.childspawner.childname
    local defender = inst.components.childspawner:SpawnChild(attacker, prefab)
    if defender and attacker and defender.components.combat then
        defender.components.combat:SetTarget(attacker)
        defender.components.combat:BlankOutAttacks(1.5 + math.random() * 2)
    end
end

local function onhit(inst, worker)
    if inst.components.childspawner then
        local num_to_release = inst.components.childspawner.childreninside
        for k = 1, num_to_release do
            SpawnGuardHound(inst, worker)
        end
    end
    local attacker = worker
    if attacker then
        inst.components.combat:ShareTarget(attacker, 30, function(dude)
            return dude:HasTag(inst.belongtowhich) and not dude:HasTag("player")
                    and not dude.components.health:IsDead()
                    and (not attacker:HasTag(inst.belongtowhich) and not attacker:HasTag("player"))
        end, 10)
    end
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("idle", true)
    end
end

local function onfinished(inst)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("destroy")
        inst:ListenForEvent("animover", function(inst, data) inst:Remove() end)
        inst.SoundEmitter:PlaySound("dontstarve/common/tent_dis_pre")
        inst.persists = false
        inst:DoTaskInTime(16 * FRAMES, function() inst.SoundEmitter:PlaySound("dontstarve/common/tent_dis_twirl") end)
    end
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", true)
end

local function onsave(inst, data)
    if inst:HasTag("burnt") or inst:HasTag("fire") then
        data.burnt = true
    end
end

local function onload(inst, data)
    if data and data.burnt then
        inst.components.burnable.onburnt(inst)
    end
end

local function fn(Sim)
    local inst = CreateEntity()
    inst.belonger = 'garen'
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst:AddTag("tent")
    inst:AddTag("td1madao_special")
    MakeObstaclePhysics(inst, 1)
    inst:AddTag("structure")
    anim:SetBank("tent")
    anim:SetBuild("tent")
    anim:PlayAnimation("idle", true)
    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("tent.png")
    inst:AddComponent("inspectable")
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('garentent')
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)
    inst:AddComponent("finiteuses")
    inst:AddComponent("combat")
    inst.components.finiteuses:SetMaxUses(TUNING.TENT_USES)
    inst.components.finiteuses:SetUses(TUNING.TENT_USES)
    inst.components.finiteuses:SetOnFinished(onfinished)
    MakeSnowCovered(inst, .01)
    inst:ListenForEvent("onbuilt", onbuilt)
    MakeLargeBurnable(inst, nil, nil, true)
    MakeLargePropagator(inst)
    inst.OnSave = onsave
    inst.OnLoad = onload
    inst.td1madaoCheckCharacter = inst:DoPeriodicTask(2, function()
        if TUNING.LOLLOAD then
            if TUNING.LOLCHAR and TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER')] ~= 0 and not td1madao_creatureOnWater(inst) then
                if GetPlayer().prefab ~= inst.belonger then
                    local inneed = string.gsub(inst.prefab, inst.belonger, GetPlayer().prefab)
                    local result = td1madao_safespawn(inneed)
                    result.Transform:SetPosition(inst.Transform:GetWorldPosition())
                    td1madao_safeRemove(inst)
                end
            else
                td1madao_safeRemove(inst)
            end
            td1madao_removeTask(inst, "td1madaoCheckCharacter")
        end
    end)
    return inst
end

local function fn1(Sim)
    local inst = fn(Sim)
    inst.name = "Demacia Tent"
    inst.AnimState:SetMultColour(0, 0, 1, 1)
    inst:AddComponent("childspawner")
    inst.components.childspawner.childname = TUNING.GARENBELONGNAME
    inst.components.childspawner.spawnoffscreen = false
    inst.belongtowhich = "demaciamem"
    if inst.belongtowhich == TUNING.GARENBELONG then
        inst.components.childspawner:SetRegenPeriod(TUNING.SEG_TIME * 8)
        inst.components.childspawner:SetSpawnPeriod(TUNING.SEG_TIME * 2)
        inst.components.childspawner:SetMaxChildren(1)
    else
        inst.components.childspawner:SetRegenPeriod(TUNING.SEG_TIME * 3)
        inst.components.childspawner:SetSpawnPeriod(TUNING.SEG_TIME * 2)
        inst.components.childspawner:SetMaxChildren(math.random(3, 6))
        inst.components.childspawner:SetRareChild('garenmemberrider', 0.1)
        inst.components.childspawner:SetRareChild('garenwizard', 0.1)
    end
    inst.components.childspawner:StartSpawning()
    return inst
end

local function fn2(Sim)
    local inst = fn(Sim)
    inst.name = "Noxus Tent"
    inst.AnimState:SetMultColour(1, 0, 0, 1)
    inst:AddComponent("childspawner")
    inst.components.childspawner.childname = TUNING.GARENENEMYNAME
    inst.components.childspawner.spawnoffscreen = false
    inst.belongtowhich = "noxusmem"
    if inst.belongtowhich == TUNING.GARENBELONG then
        inst.components.childspawner:SetRegenPeriod(TUNING.SEG_TIME * 8)
        inst.components.childspawner:SetSpawnPeriod(TUNING.SEG_TIME * 2)
        inst.components.childspawner:SetMaxChildren(1)
    else
        inst.components.childspawner:SetRegenPeriod(TUNING.SEG_TIME * 3)
        inst.components.childspawner:SetSpawnPeriod(TUNING.SEG_TIME * 2)
        inst.components.childspawner:SetMaxChildren(math.random(3, 6))
        inst.components.childspawner:SetRareChild('garenmemberrider', 0.1)
        inst.components.childspawner:SetRareChild('garenwizard', 0.1)
    end
    inst.components.childspawner:StartSpawning()
    return inst
end

return Prefab("common/objects/garentent1", fn1, assets),
Prefab("common/objects/garentent2", fn2, assets),
MakePlacer("common/tent_placer", "tent", "tent", "idle")
