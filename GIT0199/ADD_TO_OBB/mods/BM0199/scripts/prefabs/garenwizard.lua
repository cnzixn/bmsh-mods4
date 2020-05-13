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
}
local function setbuild2(inst)
    inst.AnimState:SetBuild(inst.charanm)
end

local function onsave(inst, data)
    if inst.myhat then
        data.myhat = inst.myhat
    end
    if inst.myarmor then
        data.myarmor = inst.myarmor
    end
    if inst.myweapon then
        data.myweapon = inst.myweapon
    end
    if inst.charanm then
        data.charanm = inst.charanm
    end
end

local function onpreload(inst, data)
    if not data then
        return
    end
    if data.myhat then
        inst.myhat = data.myhat
    end
    if data.myarmor then
        inst.myarmor = data.myarmor
    end
    if data.myweapon then
        inst.myweapon = data.myweapon
    end
    if data.charanm then
        inst.charanm = data.charanm
    end
    if Prefabs[inst.charanm] then
        setbuild2(inst)
    else
        inst.charanm = "wilson"
        inst.AnimState:SetBuild("wilson")
    end

    inst.name = string.format("%s%s", TUNING.LOLMEMBER[inst.belongtowhich], STRINGS.NAMES[string.upper(inst.charanm)] or inst.charanm)
    if not (inst.myhat == "hat_flower" or inst.myhat == "hat_earmuffs") then
        inst.AnimState:Show("HAT")
        inst.AnimState:Show("HAT_HAIR")
        inst.AnimState:Hide("HAIR_NOHAT")
        inst.AnimState:Hide("HAIR")
    else
        inst.AnimState:Show("HAIR_NOHAT")
        inst.AnimState:Show("HAIR")
    end
    inst.AnimState:OverrideSymbol("swap_hat", inst.myhat, "swap_hat")
    inst.AnimState:OverrideSymbol("swap_body", inst.myarmor, "swap_body")
    if inst.myweapon == "swap_staffs" then
        inst.AnimState:OverrideSymbol("swap_object", inst.myweapon, "redstaff")
    else
        inst.AnimState:OverrideSymbol("swap_object", inst.myweapon, inst.myweapon)
    end
    inst.labelname:SetText((STRINGS.NAMES[string.upper(inst.charanm)] or inst.charanm) .. '[' .. STRINGS.NAMES.GARENWIZARD .. ']')
end

local function OnAttacked(inst, data)
    local attacker = data and data.attacker
    if attacker == GetPlayer() and (GetPlayer().components.td1madao_lol_player_init.peaceDay or 0) > 0 and inst.belongtowhich ~= GetPlayer().belongtowhich then
        GetPlayer().components.td1madao_lol_player_init.peaceDay = 0
    end
    if td1madao_alive(attacker) then
        inst.hurted = true
        inst.lockEnemy = attacker
        td1madao_removeTask(inst, "unlockTarget")
        inst.unlockTarget = inst:DoTaskInTime(5, function()
            inst.hurted = false
            inst.lockEnemy = nil
        end)
    end
end

local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    MakeCharacterPhysics(inst, 50, .5)
    --    local physics = inst.entity:AddPhysics()
    inst.Transform:SetFourFaced()
    inst.belongtowhich = TUNING.GARENENEMY
    inst:AddTag(inst.belongtowhich)
    inst:AddTag("hostile")
    inst:AddTag("character")
    inst:AddTag("td1madao_special")
    inst.enemywhich = TUNING.GARENBELONG
    inst.AnimState:SetBank("wilson")
    td1madao_randomEnemy(inst)
    inst.myhat = "hat_flower"
    inst.myarmor = "armor_sanity"
    inst.myweapon = "swap_spear"
    inst.checkfollow = function()
        return (GetPlayer().components.td1madao_lol_player_init.peaceDay or 0) > 0
    end
    td1madao_memberRandomHat(inst)
    inst.AnimState:OverrideSymbol("swap_hat", inst.myhat, "swap_hat")
    td1madao_memberRandomArmor(inst)
    inst.AnimState:OverrideSymbol("swap_body", inst.myarmor, "swap_body")
    td1madao_memberRandomWeapon(inst)
    if inst.myweapon == "swap_staffs" then
        inst.AnimState:OverrideSymbol("swap_object", inst.myweapon, "redstaff")
    else
        inst.AnimState:OverrideSymbol("swap_object", inst.myweapon, inst.myweapon)
    end
    inst.AnimState:Show("ARM_carry")
    inst.AnimState:Hide("ARM_normal")
    inst:AddComponent("combat")
    inst:AddComponent("talker")
    inst:AddComponent("locomotor")
    inst.walkspeed = (GetPlayer().components.locomotor.walkspeed or 8) * 0.85
    inst.runspeed = (GetPlayer().components.locomotor.runspeed or 8) * 0.85
    inst.components.locomotor.walkspeed = inst.walkspeed
    inst.components.locomotor.runspeed = inst.runspeed
    inst.components.locomotor.fasteronroad = true
    inst.components.locomotor:SetTriggersCreep(false)
    inst:SetStateGraph("SGgarenmember")
    inst:AddComponent("td1madao_perioder_prefab")
    inst.components.td1madao_perioder_prefab:addTask("magicAttack", function()
        local player = GetPlayer()
        if not player then
            return
        end
        if inst.belongtowhich == player.belongtowhich then
            return
        end
        local target = inst.lockEnemy or player
        if player and (GetPlayer().components.td1madao_lol_player_init.peaceDay or 0) > 0 and target == player then
            return
        end
        if math.random() > 0.33 and td1madao_getDistance(target, inst) < 8 and td1madao_alive(target) and td1madao_alive(inst) then
            local wiltonNum = 0
            local ents = td1madao_findAround(inst, 50)
            for k, v in pairs(ents) do
                if v and v.prefab == "garenwilton" then
                    wiltonNum = wiltonNum + 1
                end
            end
            if math.random() <= 0.2 and wiltonNum < 2 then
                inst.sg:GoToState("book")
                inst:ForceFacePoint(target:GetPosition():Get())
                inst:DoTaskInTime(2, function()
                    if not td1madao_alive(inst) then
                        return
                    end
                    if not td1madao_alive(inst.summenera) then
                        inst.summenera = td1madao_spawnAround(inst, "garenwilton")
                        td1madao_deployBelow(inst.summenera, "statue_transition")
                    end
                    if not td1madao_alive(inst.summenerb) then
                        inst.summenerb = td1madao_spawnAround(inst, "garenwilton")
                        td1madao_deployBelow(inst.summenerb, "statue_transition")
                    end
                end)
            else
                local r = math.random()
                local ent = FindEntity(inst, TUNING.SPIDER_TARGET_DIST * 5, function(guy) return td1madao_alive(guy) and guy.components.combat and guy.components.combat.target == inst end)
                if r < 0.75 and ent then
                    inst.sg:GoToState("trans")
                    inst:DoTaskInTime(0.5, function()
                        if not td1madao_alive(inst) then
                            return
                        end
                        td1madao_deployBelow(inst, "small_puff")
                        td1madao_deployBelow(inst, "small_puff")
                        td1madao_transAround(inst, 10)
                        td1madao_deployBelow(inst, "small_puff")
                    end)
                else
                    inst.sg:GoToState("castspell")
                    inst:ForceFacePoint(target:GetPosition():Get())
                    inst.skillrange = _G.td1madao_deployBelow(target, "garenskillrange")
                    local x, y, z = inst.skillrange:GetPosition():Get()
                    inst:DoTaskInTime(2, function()
                        if not td1madao_alive(inst) or not td1madao_alive(target) then
                            return
                        end
                        if math.random() < 0.5 then
                            td1madao_safespawn("garenlightning").Transform:SetPosition(x, y, z)
                            td1madao_safespawn("lightning").Transform:SetPosition(x, y, z)
                            local ents = TheSim:FindEntities(x, y, z, 4)
                            for k, v in pairs(ents) do
                                if td1madao_alive(v) and not v:HasTag(inst.belongtowhich) and v.components.combat then
                                    v.components.combat:GetAttacked(inst, 40, nil)
                                    td1madao_goto(v, "hit")
                                    td1madao_goto(v, "electrocute")
                                    if v == GetPlayer() and math.random() < 0.2 then
                                        local item
                                        if v.components.inventory then
                                            item = v.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                                        end
                                        if item and item.Physics then
                                            v.components.inventory:DropItem(item)
                                            local x, y, z = item:GetPosition():Get()
                                            y = .1
                                            item.Physics:Teleport(x, y, z)
                                            local hp = v:GetPosition()
                                            local pt = inst:GetPosition()
                                            local vel = (hp - pt):GetNormalized()
                                            local speed = 5 + (math.random() * 2)
                                            local angle = math.atan2(vel.z, vel.x) + (math.random() * 20 - 10) * DEGREES
                                            item.Physics:SetVel(math.cos(angle) * speed, 10, math.sin(angle) * speed)
                                        end
                                    end
                                end
                            end
                        else
                            td1madao_safespawn("garendeerclops_icespike").Transform:SetPosition(x, y, z)
                            local ents = TheSim:FindEntities(x, y, z, 3)
                            for k, v in pairs(ents) do
                                if td1madao_alive(v) and not v:HasTag(inst.belongtowhich) and v.components.combat then
                                    v.components.combat:GetAttacked(inst, 20, nil)
                                    td1madao_goto(v, "hit")
                                    if v.components.freezable then
                                        v.components.freezable:AddColdness(4)
                                        v.components.freezable:SpawnShatterFX()
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end
    end, 2)
    inst.labelname = inst.entity:AddLabel()
    inst.labelname:SetFontSize(35)
    inst.labelname:SetPos(0, 3.3, 0)
    inst.labelname:SetFont(NUMBERFONT)
    inst.labelname:Enable(true)
    if inst.belongtowhich == 'demaciamem' then
        inst.labelname:SetColour(0, 0, 1)
    else
        inst.labelname:SetColour(1, 0, 0)
    end
    inst.labelname:SetText((STRINGS.NAMES[string.upper(inst.charanm)] or inst.charanm) .. '[' .. STRINGS.NAMES.GARENWIZARD .. ']')
    -- todo
    local brain = require "brains/garenmengxinbrain"
    inst:SetBrain(brain)
    -- todo

    inst:AddComponent("health")
    local clock = GetClock().numcycles
    if clock > 500 then
        clock = 500
    end
    local mh = 80 + (td1madao_getLv() + math.floor(clock / 10)) * 2.5
    inst.components.health:SetMaxHealth(mh)
    inst.components.health:StartRegen(1, 15)
    local absor = td1madao_getLv() * 0.16 + 0.4
    if absor > 0.7 then
        absor = 0.7
    end
    if inst.components.health.SetAbsorptionAmount then
        inst.components.health:SetAbsorptionAmount(absor)
    else
        inst.components.health.absorb = absor
    end
    inst:AddComponent("knownlocations")
    inst:AddComponent("lootdropper")
    inst:AddComponent("inspectable")
    inst.OnSave = onsave
    inst.OnPreLoad = onpreload
    inst:ListenForEvent("attacked", OnAttacked)
    MakeMediumFreezableCharacter(inst)
    inst.components.freezable:SetDefaultWearOffTime((TUNING.PLAYER_FREEZE_WEAR_OFF_TIME or 3) / 3)
    if td1madao_enableSW() then
        MakePoisonableCharacter(inst)
    end
    return inst
end

return Prefab("garenwizard", fn, assets)