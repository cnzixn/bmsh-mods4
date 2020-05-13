local assets =
{}

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
        GetPlayer().components.td1madao_lol_player_init.warDay = 20
        GetPlayer().components.td1madao_lol_player_init.peaceDay = 0
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
    if GetPlayer().assador == true then
        return td1madao_safespawn('garennil')
    end
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    local shadow = inst.entity:AddDynamicShadow()
    shadow:SetSize(1.5, .75)
    inst.Transform:SetFourFaced()
    anim:SetBank("wilson")
    anim:SetBuild("wendy")
    anim:PlayAnimation("idle")
    inst.labelname = inst.entity:AddLabel()
    inst.labelname:SetFontSize(35)
    inst.labelname:SetPos(0, 3.3, 0)
    inst.labelname:SetFont(NUMBERFONT)
    inst.labelname:Enable(true)
    inst.kill_fx = kill_fx
    inst.labelname:SetColour(0, 1, 0)
    inst.labelname:SetText(TUNING.LOLMEMBER[TUNING[td1madao_getupper('%sENEMY')]] .. STRINGS.NAMES.GARENMEMBERAMBASSADOR)
    inst.shutup = false
    --    inst.labelname:SetText(TUNING.LOLMEMBER.noxusmem .. STRINGS.NAMES.GARENMEMBERAMBASSADOR)
    MakeCharacterPhysics(inst, 50, .5)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    inst:AddComponent("talker")
    inst.AnimState:Show("HAIR_NOHAT")
    inst.AnimState:Show("HAIR")
    inst.AnimState:OverrideSymbol("swap_hat", "hat_walrus", "swap_hat")
    inst.AnimState:OverrideSymbol("swap_object", "swap_cane", "swap_cane")
    inst.AnimState:OverrideSymbol("swap_body", "swap_krampus_sack", "backpack")
    inst.AnimState:OverrideSymbol("swap_body", "swap_krampus_sack", "swap_body")
    inst:AddComponent("locomotor")
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('garenmemberbusinessman')
    inst.components.locomotor.walkspeed = (GetPlayer().components.locomotor.walkspeed or 8) * 0.85
    inst.components.locomotor.runspeed = (GetPlayer().components.locomotor.runspeed or 8) * 0.85
    inst:SetStateGraph("SGgarenmember")
    local brain = require "brains/garenmemberbusinessmanbrain"
    inst:SetBrain(brain)
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
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "chest"
    inst.shutup = false
    inst:AddComponent("inspectable")
    inst.components.combat.canbeattackedfn = canbeattackedfn

    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("daytime", function(global, data)
        kill_fx(inst)
    end, GetWorld())

    inst.components.inspectable.GetDescription = function(viewer)
        if not inst.shutup then
            inst:DoTaskInTime(0.5, function()
                local GarenmemberambassadorScreen = require "screens/garenmemberambassadorscreen"
                TheFrontEnd:PushScreen(GarenmemberambassadorScreen(inst))
            end)
        end
        return STRINGS.CHARACTERS.GENERIC.DESCRIBE.GARENMEMBERAMBASSADOR
    end

    GetPlayer().assador = true
    return inst
end

return Prefab("garenmemberambassador", fn, assets)
