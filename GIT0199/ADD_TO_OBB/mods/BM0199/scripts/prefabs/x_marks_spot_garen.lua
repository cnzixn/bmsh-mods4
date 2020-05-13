local assets =
{
    Asset("ANIM", "anim/x_marks_spot_garen.zip"),
}

local prefabs =
{}

local function onfinishcallback(inst, worker)
    if worker then
        local td1madao_spot_marks = TUNING.td1madao_spot_marks
        for i = 1, #td1madao_spot_marks do
            local item = td1madao_spot_marks[i][1]
            local ran = td1madao_spot_marks[i][2]
            if math.random() < ran then
                td1madao_deployBelow2(inst, item)
            end
        end
        local player = GetPlayer()
        local money = math.random(300)
        player.components.td1madao_leveler:obtainMoney(money)
        td1madao_createDamageIndicator(player, string.format("money+%s", money), 1, 1, 0)
        local obtainExpFromMember = math.ceil(player.components.td1madao_leveler:getNextLevelExperience() * 0.01)
        player.components.td1madao_leveler:obtainExp(obtainExpFromMember)
        player.components.talker:Say(TUNING.LOLMEMBER.TALK98)
        player:DoTaskInTime(1, function()
            td1madao_createDamageIndicator(player, string.format("exp+%s", obtainExpFromMember), 0, 1, 0)
        end)
        inst:Remove()
    end
end

local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local minimap = inst.entity:AddMiniMapEntity()
    anim:SetBank("x_marks_spot_garen")
    anim:SetBuild("x_marks_spot_garen")
    anim:PlayAnimation("idle")
    anim:SetLayer(LAYER_BACKGROUND)
    anim:SetSortOrder(3)
    inst:AddTag("td1madao_marks_spot")
    inst:AddComponent("inspectable")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetWorkLeft(1)
    inst:AddComponent("lootdropper")
    inst.components.workable:SetOnFinishCallback(onfinishcallback)
    return inst
end

return Prefab("x_marks_spot_garen", fn, assets, prefabs)
