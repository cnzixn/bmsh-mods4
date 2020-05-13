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
    Asset("ANIM", "anim/wilson.zip"),
    Asset("ANIM", "anim/player_one_man_band.zip"),
}
local prefabs =
{}

local function OnAttacked(inst, data)
    if data.attacker.prefab == 'garen' then
        inst.hurted = true
        td1madao_removeTask(inst, "unlockTarget")
        inst.unlockTarget = inst:DoTaskInTime(5, function()
            inst.hurted = false
        end)
    end
end

local function canbeattackedfn(inst, attacker)
    return attacker and attacker:HasTag("player")
end

local function fn(inst)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    local shadow = inst.entity:AddDynamicShadow()
    shadow:SetSize(1.5, .75)
    inst:AddTag("td1madao_special")
    inst.Transform:SetFourFaced()
    anim:SetBank("wilson")
    anim:SetBuild("wilson")
    anim:PlayAnimation("idle")
    MakeCharacterPhysics(inst, 50, .5)
    inst:AddComponent("talker")
    inst:AddComponent("locomotor")
    inst:AddComponent("inspectable")
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(150)

    inst.labelname = inst.entity:AddLabel()
    inst.labelname:SetFontSize(35)
    inst.labelname:SetPos(0, 3.3, 0)
    inst.labelname:SetFont(NUMBERFONT)
    inst.labelname:Enable(true)
    inst.labelname:SetColour(0, 1, 0)
    inst.labelname:SetText(STRINGS.NAMES.GARENMENGXIN)
    td1madao_PrefabloopTask(inst, function()
        td1madao_randomTalk(inst, LOLMENGXIN)
    end, 3)

    inst:AddTag("character")
    MakeMediumBurnableCharacter(inst, "pig_torso")
    MakeMediumFreezableCharacter(inst, "pig_torso")
    if td1madao_enableSW() then
        MakePoisonableCharacter(inst)
    end
    inst:AddComponent("combat")
    inst.AnimState:Hide("ARM_carry")
    inst.AnimState:Show("ARM_normal")
    inst:AddComponent("lootdropper")
    inst:SetStateGraph("SGgarenmember")
    inst.components.locomotor.walkspeed = (GetPlayer().components.locomotor.walkspeed or 8) * 1.5
    inst.components.locomotor.runspeed = (GetPlayer().components.locomotor.runspeed or 8) * 1.5
    inst.hurted = false
    inst.components.combat.canbeattackedfn = canbeattackedfn
    inst:ListenForEvent("attacked", OnAttacked)
    local brain = require "brains/garenmengxinbrain"
    inst:SetBrain(brain)
    return inst
end

return Prefab("common/monsters/garenmengxin", fn, assets, prefabs)
