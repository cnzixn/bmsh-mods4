local assets =
{}

SetSharedLootTable('garenmemberbusinessman',
    {
        { 'goldnugget', 0.20 },
        { 'goldnugget', 0.20 },
        { 'goldnugget', 0.20 },
        { 'goldnugget', 0.20 },
        { 'goldnugget', 0.20 },
    })

local function onsave(inst, data)
    if inst.goods then
        data.goods = inst.goods
    else
        data.goods = {}
    end
end

local function onpreload(inst, data)
    if data.goods then
        inst.goods = data.goods
    else
        inst.goods = {}
    end
end

local function kill_fx(inst)
    if inst then
        if inst.checking then
            inst.checking:Cancel()
            inst.checking = nil
        end
        td1madao_safespawn("explode_small").Transform:SetPosition(inst:GetPosition():Get())
        inst:DoTaskInTime(0, function() inst:Remove() end)
    end
end

local function OnAttacked(inst, data)
    if data.attacker.prefab == 'garen' then
        inst.shutup = true
        inst.components.talker:Say(TUNING.LOLMEMBER.TALK71)
        inst.components.combat:SetTarget(data.attacker)
        inst:DoTaskInTime(6, function()
            if inst and not inst.components.health:IsDead() then
                td1madao_safespawn('krampus').Transform:SetPosition(inst:GetPosition():Get())
                kill_fx(inst)
            end
        end)
    end
end

local function canbeattackedfn(inst, attacker)
    return attacker and attacker == GetPlayer()
end

local function fn(Sim)
    if GetPlayer().businessman == true then
        return td1madao_safespawn('garennil')
    end
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    local shadow = inst.entity:AddDynamicShadow()
    shadow:SetSize(1.5, .75)
    inst.Transform:SetFourFaced()
    inst.getPrize = td1madao_getPrize
    inst.getPrize2 = td1madao_getPrize2
    anim:SetBank("wilson")
    anim:SetBuild("wilson")
    anim:PlayAnimation("idle")
    MakeCharacterPhysics(inst, 50, .5)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    inst:AddComponent("talker")
    inst.AnimState:Hide("HAIR_NOHAT")
    inst.AnimState:Hide("HAIR")
    inst.AnimState:OverrideSymbol("swap_object", "swap_ham_bat", "swap_ham_bat")
    inst.AnimState:OverrideSymbol("swap_hat", "garenhat_poop", "swap_hat")
    inst:AddComponent("locomotor")
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('garenmemberbusinessman')
    inst.components.locomotor.walkspeed = (GetPlayer().components.locomotor.walkspeed or 8) * 0.85
    inst.components.locomotor.runspeed = (GetPlayer().components.locomotor.runspeed or 8) * 0.85
    inst:SetStateGraph("SGgarenmember")
    local brain = require "brains/garenmemberbusinessmanbrain"
    inst:SetBrain(brain)
    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("daytime", function(global, data)
        kill_fx(inst)
    end, GetWorld())
    inst.labelname = inst.entity:AddLabel()
    inst.labelname:SetFontSize(35)
    inst.labelname:SetPos(0, 3.3, 0)
    inst.labelname:SetFont(NUMBERFONT)
    inst.labelname:Enable(true)
    inst.labelname:SetColour(0, 1, 0)
    inst.labelname:SetText(STRINGS.NAMES.GARENMEMBERBUSINESSMAN)
    inst:AddComponent("health")
    inst:AddComponent("knownlocations")
    inst.components.health:SetMaxHealth(75)
    if inst.components.health.SetAbsorptionAmount then
        inst.components.health:SetAbsorptionAmount(0.8)
    else
        inst.components.health.absorb = 0.8
    end
    inst:AddTag("companion")
    inst:AddTag("td1madao_special")
    inst:AddTag("scarytoprey")
    inst:AddTag("mypet")
    inst:AddTag("lolbusiness")
    inst:AddComponent("combat")
    inst.components.combat.canbeattackedfn = canbeattackedfn
    inst.components.combat.hiteffectsymbol = "chest"
    inst.shutup = false
    inst.goods = td1madao_get35()
    inst:AddComponent("inspectable")
    inst.components.inspectable.GetDescription = function(viewer)
        if not inst.shutup then
            td1madao_randomTalk(inst, LOLMEMBERBUSINESSTALK)
        end
        if not GetPlayer().tradeisopen and not inst.shutup then
            GetPlayer().tradeisopen = true
            inst:DoTaskInTime(0.5, function()
                local GarenbusinessScreen = require "screens/garenbusinessscreen"
                TheFrontEnd:PushScreen(GarenbusinessScreen(inst.goods, inst))
            end)
        end
        return STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENMEMBERBUSINESSMAN
    end
    inst:AddComponent("td1madao_perioder_prefab")
    inst.components.td1madao_perioder_prefab:addTask("checking", function()
        if not inst.shutup then
            _G.td1madao_randomTalk(inst, LOLMEMBERBUSINESSTALK)
        end
    end, 8)
    GetPlayer().businessman = true
    if not GetPlayer().businessmanchest and not GetPlayer().businessmanslot then
        inst:DoTaskInTime(1, function()
            local che = td1madao_safespawn("garentreasurechest")
            che.Transform:SetPosition(inst:GetPosition():Get())
            che.businessman = inst

            che = td1madao_safespawn("garenslot_machine")
            local x2, y2, z2 = inst:GetPosition():Get()
            che.Transform:SetPosition(x2 + 6, 0, z2 + 6)
            che.businessman = inst
            che.goods = inst.goods
        end)
    end
    inst.OnSave = onsave
    inst.OnPreLoad = onpreload


    return inst
end

return Prefab("garenmemberbusinessman", fn, assets)
