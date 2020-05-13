local assets =
{
    Asset("ANIM", "anim/garentree_leaf_spike.zip")
}
local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddPhysics()
    inst.Physics:SetCylinder(0.25, 2)
    inst.Transform:SetFourFaced()
    inst.AnimState:SetBank("garentree_leaf_spike")
    inst.AnimState:SetBuild("garentree_leaf_spike")
    inst.entity:AddSoundEmitter()
    inst.target = GetPlayer().components.combat.target
    inst:AddComponent("combat")
    inst.components.combat:SetAreaDamage(TUNING.DECID_MONSTER_ROOT_ATTACK_RADIUS or 3.7)
    inst.components.combat:SetDefaultDamage(TUNING.DECID_MONSTER_DAMAGE or 30)
    inst.components.combat.canbeattackedfn = function(inst) return false end
    local ivt = inst.components.combat.IsValidTarget
    inst.components.combat.IsValidTarget = function(s, target)
        if target and (target:HasTag("mypet") or target == GetPlayer() or (target.components.follower and target.components.follower.leader == GetPlayer())) then
            return false
        end
        return ivt(s, target)
    end
    inst.AnimState:PlayAnimation("ground_loop")
    inst.AnimState:PushAnimation("up", false)
    inst.AnimState:PushAnimation("idle", false)
    inst.AnimState:PushAnimation("atk", false)
    inst.AnimState:PushAnimation("down", false)
    inst:DoTaskInTime(29 * FRAMES, function(inst)
        if not inst.target then
            inst.target = GetPlayer().components.combat.target
        end
        if inst.target then
            inst:FacePoint(inst.target.Transform:GetWorldPosition())
        end
    end)
    inst:DoTaskInTime(55 * FRAMES, function(inst) inst.components.combat:DoAttack() end)

    inst:DoTaskInTime(70 * FRAMES, function(inst) inst:Remove() end)
    return inst
end

return Prefab("garendeciduous_root", fn, assets)
