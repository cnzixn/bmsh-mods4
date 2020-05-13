local assets =
{
    Asset("ANIM", "anim/krampus_basic.zip"),
    Asset("ANIM", "anim/krampus_build.zip"),
    Asset("SOUND", "sound/krampus.fsb"),
    Asset("ANIM", "anim/kiki_basic.zip"),
    Asset("ANIM", "anim/kiki_build.zip"),
    Asset("ANIM", "anim/kiki_nightmare_skin.zip"),
    Asset("SOUND", "sound/monkey.fsb"),
}

local prefabs =
{}

local function fn1(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local physics = inst.entity:AddPhysics()
    local sound = inst.entity:AddSoundEmitter()
    local shadow = inst.entity:AddDynamicShadow()
    shadow:SetSize(3, 1)
    inst.Transform:SetFourFaced()
    inst.AnimState:Hide("ARM")
    MakeCharacterPhysics(inst, 10, .5)
    anim:SetBank("krampus")
    anim:SetBuild("krampus_build")
    inst:AddTag("td1madao_krampus")
    anim:PlayAnimation("idle", true)
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.KRAMPUS_HEALTH)
    inst.components.health:SetInvincible(true)
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.KRAMPUS_DAMAGE)
    inst.components.combat.canbeattackedfn = function()
        return false
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("talker")
    inst.labelname = inst.entity:AddLabel()
    inst.labelname:SetFontSize(35)
    inst.labelname:SetPos(0, 3.3, 0)
    inst.labelname:SetFont(NUMBERFONT)
    inst.labelname:Enable(true)
    inst.labelname:SetColour(0, 1, 0)
    inst.labelname:SetText(STRINGS.NAMES.GARENKRAMPUS)
    td1madao_PrefabloopTask(inst, function()
        inst.AnimState:PlayAnimation("taunt")
        inst.AnimState:PushAnimation("idle", true)
        td1madao_randomTalk(inst, TUNING.TD1MADAO_KRAMPUS)
    end, 8)
    inst.switch = false
    td1madao_runLatter(inst, 60, function()
        if not inst.components.playerprox then
            inst:AddComponent("playerprox")
        end
        inst.components.playerprox:SetDist(7, 7)
        inst.switch = false
        inst.components.playerprox:SetOnPlayerNear(function()
            if not inst.switch then
                inst.switch = true
                local garenkrampusscreen = require "screens/garenkrampusscreen"
                TheFrontEnd:PushScreen(garenkrampusscreen(inst))
            end
        end)
    end)
    return inst
end

local animlist = {
    "eat",
    "interact",
}

local function fn2()
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    local shadow = inst.entity:AddDynamicShadow()
    shadow:SetSize(2, 1.25)
    if td1madao_enableSW() then
        inst.Transform:SetSixFaced()
    else
        inst.Transform:SetFourFaced()
    end
    MakeCharacterPhysics(inst, 10, 0.25)
    anim:SetBank("kiki")
    anim:SetBuild("kiki_basic")
    inst:AddTag("td1madao_kiki")
    anim:PlayAnimation("idle_loop", true)
    inst:AddComponent("inspectable")
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(1)
    inst.components.combat.canbeattackedfn = function()
        return false
    end
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.MONKEY_HEALTH)
    inst.components.health:SetInvincible(true)
    td1madao_PrefabloopTask(inst, function()
        inst.AnimState:PlayAnimation(animlist[math.random(#animlist)])
        inst.AnimState:PushAnimation("idle_loop", true)
    end, 2 + math.random(4))
    return inst
end

return Prefab("garenkrampus", fn1, assets, prefabs), Prefab("garenmonkey", fn2, assets, prefabs)
