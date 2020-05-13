assets =
{
    Asset("ANIM", "anim/phonograph.zip"),
    Asset("SOUND", "sound/maxwell.fsb"),
    Asset("SOUND", "sound/music.fsb"),
    Asset("SOUND", "sound/gramaphone.fsb")
}
local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
    inst:Remove()
end

local function play(inst)
    inst.AnimState:PlayAnimation("play_loop", true)
    inst.SoundEmitter:PlaySound(inst.songToPlay, "ragtime")
    if inst.components.playerprox then
        inst:RemoveComponent("playerprox")
    end
    inst.components.sanityaura.aura = TUNING.SANITYAURA_MED
    inst:PushEvent("turnedon")
end

local function stop(inst)
    inst.AnimState:PlayAnimation("idle")
    inst.SoundEmitter:KillSound("ragtime")
    inst.SoundEmitter:PlaySound("dontstarve/music/gramaphone_end")
    inst.components.sanityaura.aura = 0
    inst:PushEvent("turnedoff")
end

local function fn()
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    MakeObstaclePhysics(inst, 0.1)
    anim:SetBank("phonograph")
    anim:SetBuild("phonograph")
    anim:PlayAnimation("idle")
    inst.songToPlay = "dontstarve/maxwell/ragtime"
    inst:AddTag("maxwellphonograph")
    inst:AddComponent("inspectable")
    inst:AddComponent("machine")
    inst.components.machine.turnonfn = play
    inst.components.machine.turnofffn = stop
    inst:AddComponent("workable")
    inst:AddComponent("lootdropper")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = 0
    return inst
end

return Prefab("common/objects/garenmaxwellphonograph", fn, assets),
MakePlacer("common/garenmaxwellphonograph_placer", "phonograph", "phonograph", "idle")