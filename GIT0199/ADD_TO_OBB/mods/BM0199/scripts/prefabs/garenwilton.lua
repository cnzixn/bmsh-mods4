require "brains/ghostbrain"
require "stategraphs/SGghost"
local assets =
{
    Asset("ANIM", "anim/player_basic.zip"),
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
    Asset("ANIM", "anim/garenwilton.zip"),
    Asset("SOUND", "sound/ghost.fsb"),
}
local prefabs =
{}
local function KeepTargetFn(inst, target)
    return inst.components.combat:CanTarget(target)
            and target:HasTag("player")
            and target.components.health and not target.components.health:IsDead()
end

local function KillerRetarget(inst)
    return FindEntity(inst, 30, function(guy) return guy:HasTag("player") and guy.components.health and not guy.components.health:IsDead() and inst.components.combat:CanTarget(guy) end)
end

local function OnAttacked(inst, data)
    local attacker = data and data.attacker
    if attacker and inst.components.combat:CanTarget(attacker) then
        inst.components.combat:SetTarget(attacker)
    end
end

local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    inst.Transform:SetFourFaced()
    inst.entity:AddPhysics()
    anim:SetBloomEffectHandle("shaders/anim.ksh")
    if IsDLCEnabled(CAPY_DLC) then
        MakeAmphibiousCharacterPhysics(inst, 50, .5)
        MakeInventoryFloatable(inst, "idle", "idle")
    else
        MakeCharacterPhysics(inst, 50, .5)
    end
    local brain = require "brains/garenwiltonbrain"
    inst:SetBrain(brain)
    inst.AnimState:SetBank("wilson")
    inst.AnimState:SetBuild("garenwilton")
    anim:PlayAnimation("idle", true)
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("character")
    inst:AddTag("ghost")
    inst:AddTag(TUNING[td1madao_getupper('%sENEMY')])
    inst:AddTag("noauradamage")
    inst:AddTag("td1madao_special")
    MakeMediumFreezableCharacter(inst)
    MakeMediumBurnableCharacter(inst, "pig_torso")
    inst:AddComponent("locomotor")
    inst:AddComponent("knownlocations")
    inst.components.locomotor.walkspeed = (GetPlayer().components.locomotor.walkspeed or 8) * 0.95
    inst.components.locomotor.runspeed = (GetPlayer().components.locomotor.runspeed or 12) * 0.95
    inst.components.locomotor.directdrive = true
    inst:SetStateGraph("SGgarenwilton")
    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = -TUNING.SANITYAURA_SMALL
    inst:AddComponent("inspectable")
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(250)
    inst:AddComponent("combat")
    inst.components.combat:SetAttackPeriod(0.75)
    inst.components.combat.defaultdamage = 3
    inst.components.combat.playerdamagepercent = TUNING.GHOST_DMG_PLAYER_PERCENT
    inst.components.combat:SetRetargetFunction(2, KillerRetarget)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    inst:AddComponent("aura")
    inst.components.aura.radius = TUNING.GHOST_RADIUS
    inst.components.aura.tickperiod = TUNING.GHOST_DMG_PERIOD
    inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_howl_LP", "howl")
    inst.AnimState:OverrideSymbol("swap_object", "swap_axe", "swap_axe")
    inst:ListenForEvent("attacked", OnAttacked)
    inst.AnimState:Show("ARM_carry")
    inst.AnimState:Hide("ARM_normal")
    if math.random() < 0.5 then
        inst.AnimState:OverrideSymbol("swap_hat", "garenhat_poop", "swap_hat")
    end
    return inst
end

return Prefab("common/monsters/garenwilton", fn, assets, prefabs)
