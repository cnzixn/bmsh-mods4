local assets =
{
    Asset("ANIM", "anim/garensoulball.zip"),
    Asset("ATLAS", "images/inventoryimages/garensoulball.xml"),
    Asset("IMAGE", "images/inventoryimages/garensoulball.tex"),
    Asset("ATLAS", "images/inventoryimages/garensoulball2.xml"),
    Asset("IMAGE", "images/inventoryimages/garensoulball2.tex"),
    Asset("ATLAS", "images/inventoryimages/garensoulball3.xml"),
    Asset("IMAGE", "images/inventoryimages/garensoulball3.tex")
}
local creatures = {
    "deerclops",
    "bearger",
    "spiderqueen",
    "warg",
    "moose",
    "leif",
    "leif_sparse",
}
local bank = {
    "deerclops",
    "bearger",
    "spider_queen",
    "warg",
    "goosemoose",
    "leif",
    "leif",
}
local build = {
    "deerclops_build",
    "bearger_build",
    "spider_queen_build",
    "warg_build",
    "goosemoose_build",
    "leif_build",
    "leif_lumpy_build",
}
local SG = {
    "SGdeerclops",
    "SGbearger",
    "SGspiderqueen",
    "SGwarg",
    "SGmoose",
    "SGLeif",
    "SGLeif",
}
local function resetbuild(inst)
    if inst.creatureprefab == "garensmallboss" then
        local anim = inst.AnimState
        anim:SetBank(bank[inst.creaturenum])
        anim:SetBuild(build[inst.creaturenum])
        inst:SetStateGraph(SG[inst.creaturenum])
    end
end

local function recyclePet(instcreature)
    if instcreature.brain then
        instcreature.brain:Stop()
    end
    instcreature.brain = nil
    instcreature.brainfn = nil
    instcreature:RemoveAllEventCallbacks()
end

local function OnAttacked(instcreature, data)
    if not td1madao_alive(instcreature) then
        recyclePet(instcreature)
        return
    end
    if not data or not data.attacker then
        return
    end
    local attacker = data.attacker
    if not td1madao_isLolChar(data.attacker) and td1madao_canWar(instcreature, attacker) then
        instcreature.components.combat:SetTarget(attacker)
    end
end

local function Retarget(instcreature)
    if not td1madao_alive(instcreature) then
        recyclePet(instcreature)
        return
    end
    local targetDist = TUNING.SPIDER_TARGET_DIST * 5
    return FindEntity(instcreature, targetDist,
        function(guy)
            return td1madao_protectLeaderOrSelf(instcreature, guy)
        end)
end

local function KeepTargetFn(inst, target)
    return td1madao_canWar(inst, target) and not (inst.components.follower and inst.components.follower.leader == target)
end

local prefabs = {}
local function clearRelation(inst, notforce)
    if (not notforce) or (inst and inst.components.inventoryitem and inst.components.inventoryitem.owner ~= nil) then
        local player = GetPlayer()
        if inst and player and player.components.leader then
            local tmpleader = false
            if player.components.leader.followers and player.components.leader.followers[inst] then
                tmpleader = true
            end
            if tmpleader and inst.sealcreature == 0 then
                inst:DoTaskInTime(0.05, function() if inst then
                    player.components.leader:RemoveFollower(inst)
                    if inst and inst.components.follower then
                        inst.components.follower:StopFollowing()
                    end
                    if inst.components.inventoryitem and inst.components.inventoryitem.owner == nil then
                        inst:Remove()
                    end
                end
                end)
            end
            player.components.leader:RemoveFollower(inst)
        end
        if inst and inst.components.follower then
            inst.components.follower:StopFollowing()
        end
    end
end

local function clearFollower(inst, notforce)
    clearRelation(inst, notforce)
    if inst then
        inst:DoTaskInTime(0.3, function()
            clearRelation(inst, notforce)
        end)
    end
end

local function OnPickup(inst)
    if inst and inst.pleaseDestory then
        inst:DoTaskInTime(0.5, function()
            if inst then
                clearFollower(inst)
                inst:Remove()
            end
        end)
        return
    end
    inst.dropbox = 0
    if inst and inst.components.health then
        inst.creaturecurrenthealth = inst.components.health.currenthealth
        inst.creaturemaxhealth = inst.components.health.maxhealth
    end
    if inst and inst.components.trader then
        inst.components.trader.enabled = false
    end
    if inst and inst.components.health then
        inst.components.health.canmurder = false
    end
    if inst and inst.components.follower then
        local player = GetPlayer()
        if player and player.components.leader then
            player.components.leader:RemoveFollower(inst)
            inst.components.follower.leader = nil
        end
    end
    if inst.brain then
        inst.brain:Stop()
    end
end

local function calculateAttribute(inst)
    inst.creaturemaxhealth = inst.creaturemaxhealthorigin * (inst.creaturelevel * 0.01 + 1)
    inst.creaturedamage = inst.creaturedamageorigin * (inst.creaturelevel * 0.01 + 1)
    if inst.components.health and inst.components.combat then
        inst.creaturecurrenthealth = inst.components.health.currenthealth
        inst.components.health:SetMaxHealth(inst.creaturemaxhealth)
        inst.components.combat.defaultdamage = inst.creaturedamage
        inst.components.health.currenthealth = inst.creaturecurrenthealth
    end
    if not inst.creaturelevel then
        inst.creaturelevel = 0
    end
    if not inst.creaturedamage then
        inst.creaturedamage = 10
    end
    if not inst.creaturemaxhealth then
        inst.creaturemaxhealth = 50
    end
    if not inst.creaturecurrenthealth then
        inst.creaturecurrenthealth = 50
    end
    if not inst.hunger then
        inst.hunger = 0
    end
    if not inst.creaturemaxhealthorigin then
        inst.creaturemaxhealthorigin = 50
    end
    inst.components.inspectable:SetDescription(string.format("level(%s) damage(%s) health(%s/%s) exp(%s/%s)\n\n\n\n ", inst.creaturelevel, inst.creaturedamage, inst.creaturemaxhealth, inst.creaturecurrenthealth, inst.hunger, inst.creaturemaxhealthorigin))
end

local function swap(instcreature, inst)
    inst.sealcreature = instcreature.sealcreature
    inst.creatureprefab = instcreature.creatureprefab
    inst.creaturename = instcreature.creaturename
    inst.creaturecurrenthealth = instcreature.creaturecurrenthealth
    inst.creaturemaxhealth = instcreature.creaturemaxhealth
    inst.creaturemaxhealthorigin = instcreature.creaturemaxhealthorigin
    inst.creaturelevel = instcreature.creaturelevel
    if instcreature.creaturedamage ~= 0 then
        inst.creaturedamage = instcreature.creaturedamage
    else
        inst.creaturedamage = 10
    end
    inst.creaturedamageorigin = instcreature.creaturedamageorigin
    inst.variation = instcreature.variation
    inst.redcolor = instcreature.redcolor
    inst.greencolor = instcreature.greencolor
    inst.bluecolor = instcreature.bluecolor
    inst.hunger = instcreature.hunger
    inst.feedable = instcreature.feedable
end

local function OnHit(inst, owner, target)
    if target and target.components.health and target.components.combat and target.prefab ~= 'garen'
            and target.components.health.maxhealth <= 500 and target.components.health.currenthealth <= 30
            and target.prefab ~= 'garenmember' and not target:HasTag("demaciamem") and not target:HasTag("noxusmem")
            and not target:HasTag("shadowcreature") and not target.components.transparentonsanity
            and not target:HasTag("companion") and not target:HasTag("mypet") and not target:HasTag("bird")
            and not target.components.occupier and not target.components.repairable and not target.components.workable
            and not target.components.container and target.components.locomotor
            and target.sg and target.sg.sg and target.sg.sg.states and target.sg.sg.states.attack
    then
        inst.sealcreature = 1
        inst.creatureprefab = target.prefab
        inst.creaturenum = target.creaturenum
        inst.creaturename = target.prefab
        inst.creaturemaxhealth = math.ceil(target.components.health.maxhealth * (math.random() * 0.6 + 0.7))
        inst.creaturelevel = 0
        inst.creaturedamage = math.ceil(target.components.combat.defaultdamage * (math.random() * 0.6 + 0.7))
        local matran = math.random()
        if matran >= 0.5 and matran <= 0.6 then
            inst.variation = 1
            inst.redcolor = math.random()
            inst.greencolor = math.random()
            inst.bluecolor = math.random()
            inst.creaturemaxhealth = math.ceil(inst.creaturemaxhealth * (math.random() * 0.5 + 1))
            inst.creaturedamage = math.ceil(inst.creaturedamage * (math.random() * 0.5 + 1))
        else
            inst.variation = 0
        end
        inst.creaturecurrenthealth = inst.creaturemaxhealth
        inst.creaturemaxhealthorigin = inst.creaturemaxhealth
        inst.creaturedamageorigin = inst.creaturedamage

        if inst.components.projectile then
            inst:RemoveComponent("projectile")
        end
        if inst.components.equippable then
            inst:RemoveComponent("equippable")
        end
        if inst.components.weapon then
            inst:RemoveComponent("weapon")
        end
        local fx2 = td1madao_safespawn("statue_transition")
        if not fx2.components.highlight then
            fx2:AddComponent("highlight")
        end
        fx2.components.highlight:SetAddColour(Vector3(0, 1, 0))
        fx2.Transform:SetScale(2, 2, 2)
        fx2.Transform:SetPosition(target:GetPosition():Get())
        owner.components.talker:Say(TUNING.LOLMEMBER.TALK19)
        inst.name = inst.creaturename
        if inst.components.inventoryitem then
            if inst.sealcreature and inst.sealcreature == 0 then
                inst.components.inventoryitem.atlasname = "images/inventoryimages/garensoulball.xml"
                inst.components.inventoryitem.imagename = "garensoulball"
            elseif inst.variation and inst.variation == 0 then
                inst.components.inventoryitem.atlasname = "images/inventoryimages/garensoulball2.xml"
                inst.components.inventoryitem.imagename = "garensoulball2"
            else
                inst.components.inventoryitem.atlasname = "images/inventoryimages/garensoulball3.xml"
                inst.components.inventoryitem.imagename = "garensoulball3"
            end
        end
        if inst.sealcreature ~= 0 then
            calculateAttribute(inst)
        end
        if target.components.follower then
            target.components.follower.leader = nil
            local player = GetPlayer()
            if player and player.components.leader then
                player.components.leader:RemoveFollower(target)
                target.components.follower.leader = nil
            end
        end
        clearFollower(target)
        target:Remove()
    end
end

local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "garensoulball", "garensoulball")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function OnUnequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function init(inst)
    if inst.creaturename then
        inst.name = inst.creaturename
    end
    if inst.components.inventoryitem then
        if inst.sealcreature and inst.sealcreature == 0 then
            inst.components.inventoryitem.atlasname = "images/inventoryimages/garensoulball.xml"
            inst.components.inventoryitem.imagename = "garensoulball"
        elseif inst.variation and inst.variation == 0 then
            inst.components.inventoryitem.atlasname = "images/inventoryimages/garensoulball2.xml"
            inst.components.inventoryitem.imagename = "garensoulball2"
        else
            inst.components.inventoryitem.atlasname = "images/inventoryimages/garensoulball3.xml"
            inst.components.inventoryitem.imagename = "garensoulball3"
        end
    end
    if inst and inst.sealcreature and inst.sealcreature ~= 0 then
        if inst.components.projectile then
            inst:RemoveComponent("projectile")
        end
        if inst.components.equippable then
            inst:RemoveComponent("equippable")
        end
        if inst.components.weapon then
            inst:RemoveComponent("weapon")
        end
    else
        if not inst.components.projectile then
            inst:AddComponent("projectile")
        end
        if not inst.components.equippable then
            inst:AddComponent("equippable")
        end
        if not inst.components.weapon then
            inst:AddComponent("weapon")
        end
        inst.components.projectile:SetSpeed(20)
        inst.components.projectile:SetCanCatch(false)
        inst.components.projectile:SetHoming(false)

        inst.components.projectile:SetOnMissFn(function(inst, owner, target)
            if owner ~= nil then
                inst.components.projectile:Throw(owner, owner)
            end
        end)

        inst.components.equippable:SetOnEquip(OnEquip)
        inst.components.equippable:SetOnUnequip(OnUnequip)
        inst:AddTag("notweapon")
        inst.components.weapon:SetRange(6, 10)
        inst.components.weapon:SetDamage(0.01)
        inst.components.projectile:SetOnHitFn(OnHit)
    end
end

local function onpreload(inst, data)
    if not data then
        data = {}
    end
    if data.sealcreature then
        inst.sealcreature = data.sealcreature
    else
        inst.sealcreature = 0
    end
    if inst.sealcreature == 0 then
        clearFollower(inst)
        return
    end
    if inst and inst.components.follower then
        local player = GetPlayer()
        if player and player.components.leader then
            player.components.leader:RemoveFollower(inst)
            inst.components.follower.leader = nil
        end
    end
    if inst.brain then
        inst.brain:Stop()
    end
    if data.hunger then
        inst.hunger = data.hunger
    else
        inst.hunger = 0
    end
    if data.feedable then
        inst.feedable = data.feedable
    else
        inst.feedable = false
    end
    if data.creaturenum and Prefabs[creatures[data.creaturenum]] then
        inst.creaturenum = data.creaturenum
    else
        inst.creaturenum = 1
    end
    if data.dropbox then
        inst.dropbox = data.dropbox
    else
        inst.dropbox = 0
    end
    if data.creatureprefab then
        inst.creatureprefab = data.creatureprefab
    else
        inst.creatureprefab = ""
    end
    if data.creaturename then
        inst.creaturename = data.creaturename
    else
        inst.creaturename = "garensoulballadvance"
    end
    inst.name = inst.creaturename
    if data.creaturecurrenthealth then
        inst.creaturecurrenthealth = data.creaturecurrenthealth
    else
        inst.creaturecurrenthealth = 0
    end
    if data.creaturemaxhealth then
        inst.creaturemaxhealth = data.creaturemaxhealth
    else
        inst.creaturemaxhealth = 0
    end
    if data.creaturemaxhealthorigin then
        inst.creaturemaxhealthorigin = data.creaturemaxhealthorigin
    else
        inst.creaturemaxhealthorigin = 0
    end
    if data.creaturelevel then
        inst.creaturelevel = data.creaturelevel
    else
        inst.creaturelevel = 0
    end
    if data.creaturedamage then
        inst.creaturedamage = data.creaturedamage
    else
        inst.creaturedamage = 0
    end
    if data.creaturedamageorigin then
        inst.creaturedamageorigin = data.creaturedamageorigin
    else
        inst.creaturedamageorigin = 0
    end
    if data.variation then
        inst.variation = data.variation
    else
        inst.variation = 0
    end
    if data.redcolor then
        inst.redcolor = data.redcolor
    else
        inst.redcolor = 0
    end
    if data.greencolor then
        inst.greencolor = data.greencolor
    else
        inst.greencolor = 0
    end
    if data.bluecolor then
        inst.bluecolor = data.bluecolor
    else
        inst.bluecolor = 0
    end
    init(inst)
    if inst.sealcreature ~= 0 then
        calculateAttribute(inst)
    end
    if inst.dropbox == 1 then
        inst.generatetask = inst:DoTaskInTime(0.5, function()
            if inst and inst.dropbox == 1 then
                inst.OnDrop(inst)
                if inst and inst.generatetask then
                    inst.generatetask:Cancel()
                    inst.generatetask = nil
                end
                if inst and inst.components.follower then
                    local player = GetPlayer()
                    if player and player.components.leader
                            and inst.components.follower
                            and inst.components.follower.leader
                            and inst.components.follower.leader.components
                            and inst.components.follower.leader.components.leader
                    then
                        player.components.leader:RemoveFollower(inst)
                        inst.components.follower.leader = nil
                    end
                end
                if inst then
                    clearFollower(inst)
                    inst:Remove()
                end
            end
        end)
    end
    clearFollower(inst, true)
end

local function onsave(inst, data)
    if inst and inst.sealcreature == 0 then
        clearFollower(inst)
        return
    end
    if inst and inst.components.follower then
        local player = GetPlayer()
        if player and player.components.leader
                and inst.components.follower
                and inst.components.follower.leader
                and inst.components.follower.leader.components
                and inst.components.follower.leader.components.leader
        then
            player.components.leader:RemoveFollower(inst)
            inst.components.follower.leader = nil
        end
    end
    if inst.brain then
        inst.brain:Stop()
    end
    if inst.hunger then
        data.hunger = inst.hunger
    else
        data.hunger = 0
    end
    if inst.feedable then
        data.feedable = inst.feedable
    else
        data.feedable = false
    end

    if inst.dropbox then
        data.dropbox = inst.dropbox
    else
        data.dropbox = 0
    end
    if inst.creaturenum then
        data.creaturenum = inst.creaturenum
    else
        data.creaturenum = 1
    end
    if inst.sealcreature then
        data.sealcreature = inst.sealcreature
    else
        data.sealcreature = 0
    end
    if inst.creatureprefab then
        data.creatureprefab = inst.creatureprefab
    else
        data.creatureprefab = ""
    end
    if inst.creaturename then
        data.creaturename = inst.creaturename
    else
        data.creaturename = "garensoulballadvance"
    end
    if inst.creaturecurrenthealth and inst.components.health then
        data.creaturecurrenthealth = inst.components.health.currenthealth
    elseif inst.creaturecurrenthealth then
        data.creaturecurrenthealth = inst.creaturecurrenthealth
    else
        data.creaturecurrenthealth = 0
    end
    if inst.creaturemaxhealth then
        data.creaturemaxhealth = inst.creaturemaxhealth
    else
        data.creaturemaxhealth = 0
    end
    if inst.creaturemaxhealthorigin then
        data.creaturemaxhealthorigin = inst.creaturemaxhealthorigin
    else
        data.creaturemaxhealthorigin = 0
    end
    if inst.creaturelevel then
        data.creaturelevel = inst.creaturelevel
    else
        data.creaturelevel = 0
    end
    if inst.creaturedamage then
        data.creaturedamage = inst.creaturedamage
    else
        data.creaturedamage = 0
    end
    if inst.creaturedamageorigin then
        data.creaturedamageorigin = inst.creaturedamageorigin
    else
        data.creaturedamageorigin = 0
    end
    if inst.variation then
        data.variation = inst.variation
    else
        data.variation = 0
    end
    if inst.redcolor then
        data.redcolor = inst.redcolor
    else
        data.redcolor = 0
    end
    if inst.greencolor then
        data.greencolor = inst.greencolor
    else
        data.greencolor = 0
    end
    if inst.bluecolor then
        data.bluecolor = inst.bluecolor
    else
        data.bluecolor = 0
    end
    clearFollower(inst, true)
end

local function OnDrop(inst)
    if inst and inst.pleaseDestory then
        inst:DoTaskInTime(0.5, function()
            if inst then
                clearFollower(inst)
                inst:Remove()
            end
        end)
        return
    end
    local player = GetPlayer()
    if (inst.components.follower and inst.components.follower.leader ~= 'garen') or (player and player.components.leader and player.components.leader:IsFollower(inst)) then
        if inst and inst.components.follower then
            local player = GetPlayer()
            if player and player.components.leader then
                player.components.leader:RemoveFollower(inst)
                inst.components.follower.leader = nil
            end
        end
    end
    if inst and inst.sealcreature and inst.sealcreature ~= 0 then
        local instcreature = td1madao_safespawn(inst.creatureprefab)
        instcreature.creaturenum = inst.creaturenum
        instcreature.creatureprefab = inst.creatureprefab
        resetbuild(instcreature)
        inst.pleaseDestory = true
        local teamattacker = instcreature.components.teamattacker
        instcreature.dropbox = 1
        if instcreature.components.garen_enomous_monster then
            instcreature.components.garen_enomous_monster:Recover()
        end
        local apd = instcreature.components.combat.min_attack_period
        local arg = instcreature.components.combat.attackrange
        local wsd = instcreature.components.locomotor.walkspeed
        local rsd = instcreature.components.locomotor.runspeed
        instcreature:RemoveAllEventCallbacks()
        if instcreature.brain then
            instcreature.brain:Stop()
        end
        instcreature.brain = nil
        instcreature.brainfn = nil
        instcreature.OnSave = onsave
        instcreature.OnPreLoad = onpreload
        instcreature.prefab = 'garensoulballadvance'
        swap(inst, instcreature)
        local mxh = instcreature.creaturemaxhealth
        local dfd = instcreature.creaturedamage
        local cht = instcreature.creaturecurrenthealth
        if mxh > 300 then
            mxh = 300
        end
        if cht > 300 then
            cht = 300
        end
        if dfd > 30 then
            dfd = 30
        end
        local name = instcreature.creaturename
        local tab = {}
        for key, value in pairs(instcreature.components) do
            tab[key] = key
        end
        for key, value in pairs(tab) do
            instcreature:RemoveComponent(key)
        end
        local pt = GetPlayer():GetPosition()
        instcreature.Transform:SetPosition(pt.x + (math.random(3) - math.random(3)), 0, pt.z + (math.random(3) - math.random(3)))
        instcreature:AddComponent("named")
        instcreature.components.named:SetName(string.format("pet %s", name))
        local brain = require "brains/garensoulballbrain"
        instcreature:SetBrain(brain)
        instcreature:AddTag("garenweapon")
        instcreature:AddComponent("inspectable")
        if not instcreature.components.follower then
            instcreature:AddComponent("follower")
        end
        local player = GetPlayer()
        if player and player.components.leader then
            player.components.leader:AddFollower(instcreature)
        end
        instcreature:AddComponent("locomotor")
        if instcreature.components.lootdropper then
            instcreature:RemoveComponent("lootdropper")
        end
        instcreature:AddComponent("lootdropper")
        instcreature.components.lootdropper.GenerateLoot = function() return {} end
        instcreature.components.locomotor.walkspeed = wsd
        instcreature.components.locomotor.runspeed = rsd
        instcreature:AddComponent("health")
        instcreature:AddComponent("tradable")
        instcreature:AddComponent("knownlocations")
        if teamattacker then
            instcreature:AddComponent("teamattacker")
        end
        instcreature.components.health:SetMaxHealth(mxh)
        instcreature.components.health.currenthealth = cht
        instcreature.components.health:StartRegen(1, 10)
        instcreature:AddComponent("combat")
        if inst.creatureprefab == 'ox' or inst.creatureprefab == 'whale_blue' or inst.creatureprefab == 'whale_white' then
            instcreature:AddComponent("tiletracker")
        end
        instcreature:AddComponent("inventoryitem")
        instcreature:AddComponent("inventory")
        instcreature:AddComponent("eater")
        if IsDLCEnabled and ((CAPY_DLC and IsDLCEnabled(CAPY_DLC)) or (REIGN_OF_GIANTS and IsDLCEnabled(REIGN_OF_GIANTS))) then
            instcreature:AddComponent("groundpounder")
            instcreature:AddComponent("timer")
        end
        instcreature:ListenForEvent("death", function()
            if instcreature.components.follower then
                instcreature.components.follower.leader = nil
                local player = GetPlayer()
                if player and player.components.leader then
                    player.components.leader:RemoveFollower(instcreature)
                    instcreature.components.follower.leader = nil
                end
            end
            local creature = td1madao_safespawn("garensoulballadvance")
            creature.Transform:SetPosition(instcreature.Transform:GetWorldPosition())
            creature.bluecolor = instcreature.bluecolor
            creature.creaturecurrenthealth = instcreature.creaturecurrenthealth
            creature.creaturedamage = instcreature.creaturedamage
            creature.creaturedamageorigin = instcreature.creaturedamageorigin
            creature.creaturelevel = instcreature.creaturelevel
            creature.creaturemaxhealth = instcreature.creaturemaxhealth
            creature.creaturemaxhealthorigin = instcreature.creaturemaxhealthorigin
            creature.creaturename = instcreature.creaturename
            creature.creatureprefab = instcreature.creatureprefab
            creature.dropbox = instcreature.dropbox
            creature.feedable = instcreature.feedable
            creature.greencolor = instcreature.greencolor
            creature.hunger = instcreature.hunger
            creature.redcolor = instcreature.redcolor
            creature.sealcreature = instcreature.sealcreature
            creature.variation = instcreature.variation
            creature.creaturenum = instcreature.creaturenum
            creature.creatureprefab = instcreature.creatureprefab
            OnPickup(creature)
        end)
        if instcreature.variation == 1 then
            instcreature.AnimState:SetMultColour(instcreature.redcolor, instcreature.greencolor, instcreature.bluecolor, 1)
        end
        instcreature.components.inventoryitem:SetOnPickupFn(OnPickup)
        instcreature.components.inventoryitem:SetOnDroppedFn(function(inst)
            if inst and inst.pleaseDestory then
                inst:DoTaskInTime(0.5, function()
                    if inst then
                        clearFollower(inst)
                        inst:Remove()
                    end
                end)
                return
            end
            if inst.components.combat then
                inst.components.combat:SetTarget(nil)
            end
            if inst and inst.components.trader then
                inst.components.trader.enabled = true
            end
            if inst and inst.components.health then
                inst.components.health.canmurder = true
            end
            if not inst.components.follower then
                inst:AddComponent("follower")
            end
            local player = GetPlayer()
            if player and player.components.leader then
                player.components.leader:AddFollower(inst)
            end
            if inst.brain then
                inst.brain:Start()
            end
        end)
        instcreature.components.inventoryitem.nobounce = true
        instcreature.components.inventoryitem.canbepickedup = true
        instcreature.components.inventoryitem.longpickup = true
        if instcreature.sealcreature and instcreature.sealcreature == 0 then
            instcreature.components.inventoryitem.atlasname = "images/inventoryimages/garensoulball.xml"
            instcreature.components.inventoryitem.imagename = "garensoulball"
        elseif instcreature.variation and instcreature.variation == 0 then
            instcreature.components.inventoryitem.atlasname = "images/inventoryimages/garensoulball2.xml"
            instcreature.components.inventoryitem.imagename = "garensoulball2"
        else
            instcreature.components.inventoryitem.atlasname = "images/inventoryimages/garensoulball3.xml"
            instcreature.components.inventoryitem.imagename = "garensoulball3"
        end
        instcreature.components.combat.defaultdamage = dfd
        instcreature.components.combat.playerdamagepercent = 0
        instcreature:AddComponent("trader")
        instcreature.components.trader:SetAcceptTest(function(instcreature, item)
            return item.components.edible
        end)
        local function OnGetItemFromPlayer(inst, giver, item)
            if item and item.components.edible then
                if inst.feedable then
                    inst.hunger = inst.hunger + item.components.edible.hungervalue
                    calculateAttribute(inst)
                    if inst.hunger >= inst.creaturemaxhealthorigin then
                        inst.feedable = false
                        inst.hunger = 0
                        inst.creaturelevel = inst.creaturelevel + 1
                        local fx2 = td1madao_safespawn("statue_transition")
                        if not fx2.components.highlight then
                            fx2:AddComponent("highlight")
                        end
                        fx2.components.highlight:SetAddColour(Vector3(0, 1, 0))
                        fx2.Transform:SetScale(2, 2, 2)
                        fx2.Transform:SetPosition(inst:GetPosition():Get())
                    end
                end
                if item.components.edible.healthvalue then
                    inst.components.health:DoDelta(math.abs(item.components.edible.healthvalue) + math.abs(item.components.edible.hungervalue))
                    inst.creaturecurrenthealth = inst.components.health.currenthealth
                end
                calculateAttribute(inst)
            end
        end

        instcreature.components.trader.onaccept = OnGetItemFromPlayer
        instcreature.components.trader:Enable()
        if instcreature:HasTag("monster") then
            instcreature:RemoveTag("monster")
        end
        if instcreature:HasTag("hostile") then
            instcreature:RemoveTag("hostile")
        end
        if not instcreature:HasTag("scarytoprey") then
            instcreature:AddTag("scarytoprey")
        end
        if not instcreature:HasTag("irreplaceable") then
            instcreature:AddTag("irreplaceable")
        end
        if instcreature:HasTag("canbetrapped") then
            instcreature:RemoveTag("canbetrapped")
        end
        instcreature.components.combat:SetRetargetFunction(3, Retarget)
        instcreature.components.combat:SetKeepTargetFunction(KeepTargetFn)
        instcreature:ListenForEvent("attacked", OnAttacked)
        instcreature:ListenForEvent("newcombattarget", function(inst, data)
            if data and data.oldtarget == GetPlayer() then
                inst.components.combat:SetTarget(nil)
            end
            if data and data.target == GetPlayer() then
                inst.components.combat:SetTarget(nil)
            end
        end)
        instcreature:AddTag("companion")
        instcreature:AddTag("mypet")
        instcreature:AddTag("nosteal")
        instcreature.hunger = 0
        instcreature.calculateAttribute = calculateAttribute
        calculateAttribute(instcreature)
        instcreature:ListenForEvent("daytime", function(global, data)
            instcreature.feedable = true
        end, GetWorld())
        clearFollower(inst)
        inst:Remove()
    end
end

local function fn()
    local inst = CreateEntity()
    inst.sealcreature = 0
    td1madao_initQualityAttr({ 0, 1, 0, 1 })
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    if IsDLCEnabled and CAPY_DLC and IsDLCEnabled(CAPY_DLC) then
        MakeInventoryFloatable(inst, "idle_water", "idle")
    end
    anim:SetBank("garensoulball")
    anim:SetBuild("garensoulball")
    anim:PlayAnimation("idle")
    if not inst.components.follower then
        inst:AddComponent("follower")
    end
    local player = GetPlayer()
    if player and player.components.leader then
        player.components.leader:AddFollower(inst)
    end
    if inst.brain then
        inst.brain:Stop()
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetOnPickupFn(OnPickup)
    inst:AddComponent("tradable")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/garensoulball.xml"
    inst.components.inventoryitem.imagename = "garensoulballadvance"
    inst.OnSave = onsave
    inst.OnPreLoad = onpreload
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop)
    inst:AddTag("garenweapon")
    inst:AddTag("nosteal")
    inst.feedable = true
    inst.OnDrop = OnDrop
    inst:ListenForEvent("daytime", function(global, data)
        inst.feedable = true
    end, GetWorld())
    init(inst)
    clearFollower(inst, true)
    return inst
end

return Prefab("common/inventory/garensoulballadvance", fn, assets, prefabs)
