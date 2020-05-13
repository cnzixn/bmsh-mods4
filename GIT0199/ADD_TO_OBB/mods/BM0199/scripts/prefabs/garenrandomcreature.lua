local assets =
{}
local prefabs =
{}
SetSharedLootTable('garenrandomcreature',
    {
        { 'livinglog', 0.1 },
        { 'thulecite_pieces', 0.1 },
        { 'thulecite', 0.05 },
    })
local function KeepTargetFn(inst, target)
    return inst.components.combat:CanTarget(target)
            and target.prefab == 'garen'
            and target.components.health and not target.components.health:IsDead()
end

local function KillerRetarget(inst)
    local player = GetPlayer()
    if player and (GetPlayer().components.td1madao_lol_player_init.peaceDay or 0) > 0 then
        return false
    end
    return FindEntity(inst, 50, function(guy) return guy.prefab == 'garen' and guy.components.health and not guy.components.health:IsDead() and inst.components.combat:CanTarget(guy) end)
end

local function fn(Sim)
    local rm = math.random(5)
    local bui = nil
    local prefabname = 'pigman'
    if rm == 2 then
        bui = "merm_build"
    elseif rm == 3 then
        prefabname = 'bunnyman'
    elseif rm == 4 then
        bui = "walrus_build"
    elseif rm == 5 then
        bui = "pig_guard_build"
    end
    local inst = td1madao_safespawn(prefabname)
    if bui then
        inst.AnimState:SetBuild(bui)
    end
    if inst.components.garen_enomous_monster then
        inst.components.garen_enomous_monster:Recover()
        inst:RemoveComponent("garen_enomous_monster")
    end
    if inst.components.combat then
        inst.components.combat:SetRetargetFunction(2, KillerRetarget)
        inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    end
    inst.specialhat = true
    if inst.components.inventory then
        inst.components.inventory:Equip(td1madao_safespawn("poop"))
        inst.AnimState:Show("hat")
    end
    local aliveday = GetClock().numcycles
    if aliveday > 100 then
        aliveday = 100
    end
    if inst.components.health then
        inst.components.health:SetMaxHealth(TUNING.PIG_HEALTH + aliveday * 2.5)
        inst.components.health.currenthealth = inst.components.health.maxhealth
    end
    local damagem = 1
    if TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER')] == 2 then
        damagem = 2
    end
    if inst.components.combat then
        inst.components.combat:SetDefaultDamage(10 * damagem)
    end
    if inst.components.lootdropper then
        inst:RemoveComponent("lootdropper")
        inst:AddComponent("lootdropper")
        inst.components.lootdropper:SetLoot({})
        inst.components.lootdropper:SetChanceLootTable('garenrandomcreature')
    end
    inst.prefab = 'garenrandomcreature'
    inst:AddTag("hostile")
    if not inst.components.workable then
        inst:AddComponent("workable")
    end
    return inst
end

return Prefab("common/monsters/garenrandomcreature", fn, assets, prefabs)
