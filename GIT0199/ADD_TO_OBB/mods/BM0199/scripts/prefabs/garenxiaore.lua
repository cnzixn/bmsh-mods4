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

local function fn(Sim)
    local inst = CreateEntity()
    local bus = TheSim:FindFirstEntityWithTag("td1madao_xiaore")
    if bus then
        return td1madao_safespawn('garennil')
    end
    inst:AddTag("td1madao_xiaore")
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    --    inst.Transform:SetFourFaced()
    inst.entity:AddPhysics()
    MakeCharacterPhysics(inst, 50, .5)
    inst:AddComponent("talker")
    inst:AddComponent("inspectable")
    inst.AnimState:SetBank("wilson")
    inst.AnimState:SetBuild("wickerbottom")
    inst.AnimState:PlayAnimation("death", false)
    inst.labelname = inst.entity:AddLabel()
    inst.labelname:SetFontSize(35)
    inst.labelname:SetPos(0, 3.3, 0)
    inst.labelname:SetFont(NUMBERFONT)
    inst.labelname:Enable(true)
    inst.labelname:SetColour(0, 1, 0)
    inst.labelname:SetText(STRINGS.NAMES.GARENXIAORE)
    td1madao_PrefabloopTask(inst, function()
        td1madao_randomTalk(inst, LOLXIAORETALK)
    end, 4)
    return inst
end

return Prefab("common/monsters/garenxiaore", fn, assets, prefabs)
