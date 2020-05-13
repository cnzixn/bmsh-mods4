local assets =
{
    Asset("ANIM", "anim/player_basic.zip"),
    Asset("ANIM", "anim/garensari.zip"),
    Asset("ANIM", "anim/garenyiyu.zip"),
    Asset("ANIM", "anim/swap_garensaricatsword.zip"),
    Asset("ANIM", "anim/swap_garenyiyusword.zip"),
    Asset("ANIM", "anim/player_idles_shiver.zip"),
    Asset("ANIM", "anim/player_actions.zip"),
    Asset("ANIM", "anim/player_actions_axe.zip"),
    Asset("ANIM", "anim/player_actions_pickaxe.zip"),
    Asset("ANIM", "anim/player_actions_shovel.zip"),
    Asset("ANIM", "anim/player_actions_blowdart.zip"),
    Asset("ANIM", "anim/player_actions_eat.zip"),
    Asset("ANIM", "anim/player_actions_item.zip"),
    Asset("ANIM", "anim/player_actions_uniqueitem.zip"),
    Asset("ANIM", "anim/player_actions_bugnet.zip"),
    Asset("ANIM", "anim/player_actions_fishing.zip"),
    Asset("ANIM", "anim/player_actions_boomerang.zip"),
    Asset("ANIM", "anim/player_bush_hat.zip"),
    Asset("ANIM", "anim/player_attacks.zip"),
    Asset("ANIM", "anim/player_idles.zip"),
    Asset("ANIM", "anim/player_rebirth.zip"),
    Asset("ANIM", "anim/player_jump.zip"),
    Asset("ANIM", "anim/player_amulet_resurrect.zip"),
    Asset("ANIM", "anim/player_teleport.zip"),
    Asset("ANIM", "anim/wilson_fx.zip"),
    Asset("ANIM", "anim/player_one_man_band.zip"),
}
local prefabs =
{}
local function KeepTargetFn(inst, target)
    return inst.components.combat:CanTarget(target)
            and target:HasTag(inst.killtarget)
            and target.components.health and not target.components.health:IsDead()
end


local function onsave(inst, data)
    if inst.prefab2 then
        data.prefab2 = inst.prefab2
    end
    if inst.killtarget then
        data.killtarget = inst.killtarget
    end
end

local function onpreload(inst, data)
    if not data then
        return
    end
    if data.prefab2 then
        inst.prefab2 = data.prefab2
    end
    if data.killtarget then
        inst.killtarget = data.killtarget
    end
    inst.sbu(inst)
end

local function KillerRetarget(inst)
    return FindEntity(inst, 30, function(guy) return guy:HasTag(inst.killtarget) and guy.components.health and not guy.components.health:IsDead() and inst.components.combat:CanTarget(guy) end)
end

local function OnAttacked(inst, data)
    local attacker = data and data.attacker
    if attacker and inst.components.combat:CanTarget(attacker) then
        inst.components.combat:SetTarget(attacker)
    end
    if attacker == GetPlayer() then
        inst.killtarget = 'player'
        inst.components.talker:Say(TUNING.LOLMEMBER.TALK87)
        inst.components.combat:ShareTarget(attacker, 30, function(dude)
            local booleanVal = dude:HasTag("modchar")
            if booleanVal then
                dude.killtarget = 'player'
            end
            return booleanVal
        end, 30)
    end
end

local function sbu(inst, str)
    inst.AnimState:SetBuild(str or inst.prefab2)
    if inst.prefab2 == 'garensari' then
        inst.AnimState:OverrideSymbol("swap_object", "swap_garensaricatsword", "swap_saricatsword")
    elseif inst.prefab2 == 'garenyiyu' then
        inst.AnimState:OverrideSymbol("swap_object", "swap_garenyiyusword", "swap_yiyusword")
    end
end

local function fn(Sim)
    local inst = CreateEntity()
    inst.killtarget = 'modchar'
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    inst.Transform:SetFourFaced()
    inst.entity:AddPhysics()
    inst.sbu = sbu
    MakeCharacterPhysics(inst, 50, .5)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    local brain = require "brains/garenwiltonbrain"
    inst:SetBrain(brain)
    inst:AddComponent("talker")
    inst.AnimState:SetBank("wilson")
    inst.AnimState:SetBuild("garenwilton")
    anim:PlayAnimation("idle", true)
    inst:AddTag("modchar")
    inst:AddTag("td1madao_special")
    inst:AddComponent("locomotor")
    inst:AddComponent("knownlocations")

    td1madao_PrefabloopTask(inst, function()
        if td1madao_alive(inst) then
            local tempTarget = inst.components.combat.target
            if td1madao_alive(tempTarget) then
                if tempTarget == GetPlayer() then
                    inst.components.talker:Say(TUNING.LOLMEMBER.TALK88)
                elseif tempTarget.prefab2 then
                    if tempTarget.prefab2 == 'garensari' then
                        inst.components.talker:Say(TUNING.LOLMEMBER.TALK85)
                    elseif tempTarget.prefab2 == 'garenyiyu' then
                        inst.components.talker:Say(TUNING.LOLMEMBER.TALK86)
                    end
                end
            end
        else
            td1madao_removeTask(inst, "tmpTask")
        end
    end, 3 + math.random(2))
    inst.components.locomotor.walkspeed = (GetPlayer().components.locomotor.walkspeed or 8) * 0.95
    inst.components.locomotor.runspeed = (GetPlayer().components.locomotor.runspeed or 12) * 0.95
    inst:SetStateGraph("SGgarenwilton")
    inst:AddComponent("inspectable")
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(150)
    inst:AddComponent("combat")
    inst.components.combat:SetAttackPeriod(0.75)
    inst.components.combat.defaultdamage = 10
    if inst.components.health.SetAbsorptionAmount then
        inst.components.health:SetAbsorptionAmount(0.8)
    else
        inst.components.health.absorb = 0.8
    end
    MakeMediumBurnableCharacter(inst, "pig_torso")
    MakeMediumFreezableCharacter(inst, "pig_torso")
    if td1madao_enableSW() then
        MakePoisonableCharacter(inst)
    end

    inst:AddTag("character")
    inst.components.combat.playerdamagepercent = TUNING.GHOST_DMG_PLAYER_PERCENT
    inst.components.combat:SetRetargetFunction(2, KillerRetarget)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    inst.AnimState:OverrideSymbol("swap_object", "swap_ham_bat", "swap_ham_bat")
    inst:ListenForEvent("attacked", OnAttacked)
    inst.AnimState:Show("ARM_carry")
    inst.AnimState:Hide("ARM_normal")
    inst.AnimState:OverrideSymbol("swap_hat", "garenhat_poop", "swap_hat")
    inst.OnSave = onsave
    inst.OnPreLoad = onpreload
    td1madao_prefabResponse(inst, TUNING.LOLMEMBER.TALK93)
    return inst
end

return Prefab("common/monsters/garenmodchar", fn, assets, prefabs)
