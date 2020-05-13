local assets =
{
    Asset("ANIM", "anim/garentornado.zip"),
}
local function fn()
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    anim:SetBank("garentornado")
    anim:SetBuild("garentornado")
    anim:PlayAnimation("tornado_pre")
    anim:PushAnimation("tornado_loop")
    if IsDLCEnabled and ((REIGN_OF_GIANTS and IsDLCEnabled(REIGN_OF_GIANTS)) or (CAPY_DLC and IsDLCEnabled(CAPY_DLC))) then
        sound:PlaySound("dontstarve_DLC001/common/tornado", "spinLoop")
    end
    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)
    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = 9 * 0.33
    inst.components.locomotor.runspeed = 9
    td1madao_doPeriodicTask(inst, nil, function()
        local x, y, z = inst:GetPosition():Get()
        local ents = TheSim:FindEntities(x, y, z, 2)
        local player = GetPlayer()
        local caster = player
        local backpack = player.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
        if backpack and backpack.components.container then
        else
            backpack = nil
        end
        for k, v in pairs(ents) do
            if v and (v:HasTag('mypet') or v:HasTag(player.belongtowhich) and (v.components.combat and v.components.combat.target ~= inst))
                    or (v and v.components.container and v.components.container.canbeopened)
                    or (v and v.components.follower and v.components.follower.leader == player) or (v.components.combat and v.components.health and player.components.combat and not player.components.combat:CanTarget(v))
            then
            elseif v and v.components.combat and v.components.health and not v.components.health:IsDead() and v ~= player
                    and player.components.inventory and not player.components.inventory:GetItemSlot(v)
                    and player.components.inventory:GetActiveItem() ~= v
            then
                if backpack and backpack.components.container:GetItemSlot(v) then
                else
                    v.components.combat:GetAttacked(player, 15)
                    if v.sg and not v.components.health:IsDead() then
                        if v.brain then
                            v.brain:Stop()
                        end
                        local x2, y2, z2 = v:GetPosition():Get()
                        local sign = 1

                        td1madao_doPeriodicTask(v, nil, function()
                            local x3, y3, z3 = v:GetPosition():Get()
                            v.Transform:SetPosition(x2, y3 + 0.7 * sign, z2)
                        end, 0.05, 0.6, function()
                            v.Transform:SetPosition(x2, 0, z2)
                        end)
                        v:DoTaskInTime(0.3, function()
                            sign = -1
                        end)
                        v.components.combat:BlankOutAttacks(1)
                        if v.components.combat then
                            v.components.combat:SetTarget(nil)
                        end
                        if v.sg and v.sg.sg and v.sg.sg.states and v.sg.sg.states.hit and not v.components.health:IsDead() then
                            v.sg:GoToState("hit")
                        end
                        v:DoTaskInTime(1, function()
                            if v.brain then
                                v.brain:Start()
                            end
                        end)
                        v:DoTaskInTime(1.5, function()
                            if v.components.combat then
                                v.components.combat:SetTarget(caster)
                            end
                        end)
                    end
                end
            elseif v and v.components.workable and v.components.workable.workleft > 0
                    and player.components.hunger
            then
                td1madao_safespawn("collapse_small").Transform:SetPosition(v:GetPosition():Get())
                v.components.workable:Destroy(player)
            end
        end
    end, 0.2, 3, function()
        inst:Remove()
    end)
    return inst
end

local function fn2()
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    anim:SetBank("garentornado")
    anim:SetBuild("garentornado")
    anim:PlayAnimation("tornado_pre")
    anim:PushAnimation("tornado_loop")
    if IsDLCEnabled and ((REIGN_OF_GIANTS and IsDLCEnabled(REIGN_OF_GIANTS)) or (CAPY_DLC and IsDLCEnabled(CAPY_DLC))) then
        sound:PlaySound("dontstarve_DLC001/common/tornado", "spinLoop")
    end
    inst:DoTaskInTime(3, function() inst:Remove() end)
    return inst
end


return Prefab("garentornado", fn, assets),
Prefab("garentornado2", fn2, assets)
