local assets =
{}

local creatures = {
    "beefalo",
    "spiderqueen",
    "warg",
    "koalefant_summer",
    "koalefant_winter"
}

local bank = {
    "beefalo",
    "spider_queen",
    "warg",
    "koalefant",
    "koalefant"
}

local build = {
    "beefalo_build",
    "spider_queen_build",
    "warg_build",
    "koalefant_summer_build",
    "koalefant_winter_build"
}

local SG = {
    "SGBeefalo",
    "SGspiderqueen",
    "SGwarg",
    "SGkoalefant",
    "SGkoalefant"
}

SetSharedLootTable('garenmemberrider',
    {
        { 'meat', 1.00 },
        { 'meat', 1.00 },
        { 'healingsalve', 0.30 },
        { 'bandage', 0.30 },
        { 'goldnugget', 1.00 },
    })

local sounds =
{
    angry = "dontstarve/beefalo/angry",
    attack_whoosh = "dontstarve_DLC002/creatures/OX/attack_whoosh",
    chew = "dontstarve_DLC002/creatures/OX/chew",
    curious = "dontstarve/beefalo/curious",
    death = "dontstarve_DLC002/creatures/OX/death",
    emerge = "dontstarve_DLC002/creatures/seacreature_movement/water_emerge_med",
    grunt = "dontstarve/beefalo/grunt",
    hairgrow_pop = "dontstarve_DLC002/creatures/OX/hairgrow_pop",
    hairgrow_vocal = "dontstarve_DLC002/creatures/OX/hairgrow_vocal",
    mating_call = "dontstarve_DLC002/creatures/OX/mating_call",
    sleep = "dontstarve_DLC002/creatures/OX/sleep",
    submerge = "dontstarve_DLC002/creatures/seacreature_movement/water_submerge_med",
    swish = "dontstarve/beefalo/tail_swish",
    tail_swish = "dontstarve_DLC002/creatures/OX/tail_swish",
    walk = "dontstarve/beefalo/walk",
    walk_land = "dontstarve_DLC002/creatures/OX/walk_land",
    walk_water = "dontstarve_DLC002/creatures/OX/walk_water",
    yell = "dontstarve/beefalo/yell",
}

local function taunt(inst, indicator)
    local player = GetPlayer()
    if player and (GetPlayer().components.td1madao_lol_player_init.peaceDay or 0) > 0 then
        return
    end
    if inst.components.combat and inst.components.combat.target and inst.components.combat.target.prefab == 'garen' then
        local x2, y2, z2 = inst.components.combat.target.Transform:GetWorldPosition()
        local x1, y1, z1 = inst.Transform:GetWorldPosition()
        local dist = math.sqrt((x1 - x2) * (x1 - x2) + (z1 - z2) * (z1 - z2))
        if dist < 10 then
            if indicator then
                GetPlayer().components.combat:SetTarget(inst)
                return
            end
            td1madao_createDamageIndicator(GetPlayer(), STRINGS.LOLTAUNT)
            td1madao_playerPause(2.5)
            td1madao_doPeriodicTask(inst, "td1madao_player_taunt_by_member_rider", function()
                player.components.combat:SetTarget(inst)
            end, 0.1, 2.5, function()
                GetPlayer().components.playercontroller:Enable(true)
                GetPlayer().components.combat:SetTarget(inst)
            end)
        end
    end
end

local function OnAttacked(inst, data)
    local attacker = data and data.attacker
    if attacker == GetPlayer() and (GetPlayer().components.td1madao_lol_player_init.peaceDay or 0) > 0 and inst.belongtowhich ~= GetPlayer().belongtowhich then
        GetPlayer().components.td1madao_lol_player_init.peaceDay = 0
    end
    if attacker and inst.components.combat:CanTarget(attacker) then
        inst.components.combat:SetTarget(attacker)
    end
end

local function KeepTargetFn(inst, target)
    return inst.components.combat:CanTarget(target)
            and target:HasTag(TUNING.GARENBELONG)
            and target.components.health and not target.components.health:IsDead()
end

local function KillerRetarget(inst)
    local player = GetPlayer()
    return FindEntity(inst, 50, function(guy)
        if player and (GetPlayer().components.td1madao_lol_player_init.peaceDay or 0) > 0 and guy == player then
            return false
        end
        return guy:HasTag(TUNING.GARENBELONG) and guy.components.health and not guy.components.health:IsDead() and inst.components.combat:CanTarget(guy)
    end)
end

local function fn(Sim)
    local creature = '999-notexist'
    local creaturenum = -1
    repeat
        creaturenum = math.random(#bank)
        creature = creatures[creaturenum]
    until Prefabs[creature]
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    local shadow = inst.entity:AddDynamicShadow()
    inst.sounds = sounds
    inst.walksound = sounds.walk_land
    shadow:SetSize(4.5, 2)
    if creature == 'beefalo' and IsDLCEnabled and CAPY_DLC and IsDLCEnabled(CAPY_DLC) then
        inst.Transform:SetSixFaced()
    else
        inst.Transform:SetFourFaced()
    end
    MakeCharacterPhysics(inst, 100, .75)
    inst.belongtowhich = TUNING.GARENENEMY
    inst.enemywhich = TUNING.GARENBELONG
    inst:AddTag(inst.belongtowhich)
    inst:AddTag("hostile")
    inst:AddTag("character")
    inst:AddTag("largecreature")
    inst:AddTag("td1madao_special")
    anim:SetBank(bank[creaturenum])
    anim:SetBuild(build[creaturenum])
    anim:PlayAnimation("idle_loop", true)
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "beefalo_body"
    inst.components.combat:SetRange(2)
    inst:AddComponent("health")
    local clock = GetClock().numcycles
    if clock > 500 then
        clock = 500
    end
    local mh = 200 + (td1madao_getLv() + math.floor(clock / 5)) * 5
    inst.components.health:SetMaxHealth(mh)
    local absor = td1madao_getLv() * 0.022 + 0.6
    if absor > 0.8 then
        absor = 0.8
    end
    if inst.components.health.SetAbsorptionAmount then
        inst.components.health:SetAbsorptionAmount(absor)
    else
        inst.components.health.absorb = absor
    end
    inst.oldperiod = 0.85 - td1madao_getLv() * 0.01
    inst.components.combat:SetAttackPeriod(inst.oldperiod * 3)
    inst.components.combat:SetDefaultDamage(20 + td1madao_getLv() / 3 * 4)
    inst.components.health:StartRegen(1, 10)
    inst.components.combat:SetRetargetFunction(2, KillerRetarget)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    local brain = require "brains/garenwiltonbrain"
    inst:SetBrain(brain)
    inst:AddComponent("td1madao_perioder_prefab")
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('garenmemberrider')
    inst:AddComponent("inspectable")
    MakeLargeBurnableCharacter(inst, "beefalo_body")
    MakeLargeFreezableCharacter(inst, "beefalo_body")
    inst:AddComponent("locomotor")
    inst:ListenForEvent("attacked", OnAttacked)
    inst.walkspeed = (GetPlayer().components.locomotor.walkspeed or 8) * 0.9
    inst.runspeed = (GetPlayer().components.locomotor.runspeed or 8) * 0.9
    local fx2 = td1madao_createRider(inst, "garenmemberriderperson", 3, true)
    if fx2 then
        if fx2.labelname then
            fx2.labelname:SetText(TUNING.LOLMEMBER[inst.belongtowhich] .. STRINGS.NAMES.GARENMEMBERRIDER)
            fx2.labelname:SetPos(0, 5.3, 0)
        end
    end
    inst:DoTaskInTime(2 + math.random(3), function()
        taunt(inst)
        inst.components.td1madao_perioder_prefab:addTask("td1madao_taughTask", function()
            if not td1madao_alive(inst) then
                td1madao_removeTask(inst, "td1madao_taughTask")
            end
            if math.random() < 0.33 then
                taunt(inst)
            end
        end, 15)
    end)
    inst:SetStateGraph(SG[creaturenum])
    if td1madao_enableSW() then
        MakePoisonableCharacter(inst)
    end
    return inst
end

return Prefab("garenmemberrider", fn, assets)