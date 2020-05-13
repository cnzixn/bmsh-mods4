local assets =
{
    Asset("ANIM", "anim/pig_king.zip"),
    Asset("SOUND", "sound/pig.fsb"),
}

local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.DynamicShadow:SetSize(10, 5)
    MakeObstaclePhysics(inst, 2, .5)
    inst.AnimState:SetBank("Pig_King")
    inst.AnimState:SetBuild("Pig_King")
    inst.AnimState:PlayAnimation("idle", true)
    inst:AddComponent("talker")
    inst:DoTaskInTime(2, function()
        inst.SoundEmitter:PlaySound("dontstarve/pig/PigKingReject")
        inst.AnimState:PlayAnimation("unimpressed")
        inst.AnimState:PushAnimation("idle", true)
        inst.components.talker:Say(TUNING.LOLPIGKINGSTOMACHACHE[1])
    end)
    inst:DoTaskInTime(5, function()
        inst.SoundEmitter:PlaySound("dontstarve/pig/PigKingReject")
        inst.components.talker:Say(TUNING.LOLPIGKINGSTOMACHACHE[2])
    end)
    inst:DoTaskInTime(8, function()
        inst.SoundEmitter:PlaySound("dontstarve/pig/PigKingReject")
        inst.components.talker:Say(TUNING.LOLPIGKINGSTOMACHACHE[3])
    end)
    inst:DoTaskInTime(11, function()
        inst.AnimState:PlayAnimation("happy")
        inst.AnimState:PushAnimation("idle", true)
        inst.SoundEmitter:PlaySound("dontstarve/pig/PigKingThrowGold")
        inst:DoTaskInTime(1.5, function()
            inst.SoundEmitter:PlaySound("dontstarve/pig/PigKingHappy")
        end)
        inst.Physics:SetMotorVelOverride(0, 5, 0)
        td1madao_setColor(td1madao_deployBelow(inst, "collapse_big"), 1, 1, 0).Transform:SetScale(5, 5, 5)
        inst:DoTaskInTime(1, function()
            td1madao_setColor(td1madao_deployBelow(inst, "collapse_big"), 1, 1, 0).Transform:SetScale(5, 5, 5)
        end)
        inst:DoTaskInTime(2, function()
            td1madao_setColor(td1madao_deployBelow(inst, "collapse_big"), 1, 1, 0).Transform:SetScale(5, 5, 5)
        end)
        local ents = td1madao_findAround(inst, 20)
        local player = GetPlayer()
        for k, v in pairs(ents) do
            if not td1madao_alive(v) and v and v.components.workable and v.components.workable.workleft > 0 then
                td1madao_safespawn("collapse_small").Transform:SetPosition(v:GetPosition():Get())
                v.components.workable:Destroy(player)
            end
        end
        player.components.talker:Say(TUNING.LOLPIGKINGSTOMACHACHE[4])
        td1madao_goto(player, "wakeup")
    end)
    inst:DoTaskInTime(15, function() inst:Remove() end)
    return inst
end

return Prefab("garenpigking", fn, assets)