local assets =
{
    Asset("ANIM", "anim/garenarsenallib.zip"),
    Asset("ATLAS", "images/inventoryimages/garenarsenal.xml"),
    Asset("IMAGE", "images/inventoryimages/garenarsenal.tex"),
    Asset("ATLAS", "images/inventoryimages.xml"),
}

local function addNewWeapin(name)
    if Prefabs[name] then
        local file = string.format("anim/%s.zip", name)
        if td1madao_file_exist(file) then
            table.insert(assets, Asset("ANIM", file))
        end
        file = string.format("anim/swap_%s.zip", name)
        if td1madao_file_exist(file) then
            table.insert(assets, Asset("ANIM", file))
        end
    end
end

addNewWeapin("batbat")
addNewWeapin("ruins_bat")
addNewWeapin("nightmaresword")
addNewWeapin("tentacle_spike")
addNewWeapin("cutlass")
addNewWeapin("ham_bat")
local prefabs =
{}
local tmptal = {
    'redgem',
    'bluegem',
    'purplegem',
    'yellowgem',
    'orangegem',
    'greengem',
}

local function getweaponlevelname(inst)
    local weaponlevel = 1
    for i = 1, 12 do
        if math.random() < 0.6 then
            if weaponlevel > 12 then
                weaponlevel = 12
            end
            return weaponlevel
        end
        weaponlevel = weaponlevel + 1
    end
    if weaponlevel > 12 then
        weaponlevel = 12
    end
    return weaponlevel
end

local function onblink(staff, pos, caster)
    staff.components.finiteuses:Use(15)
end

local function SpawnIceFx(inst, target, targetPos)
    if not inst then return end
    local numFX = math.random(15, 20)
    local pos = inst:GetPosition()
    if not targetPos and target then
        targetPos = target:GetPosition()
    end
    local vec = targetPos - pos
    vec = vec:Normalize()
    local dist = pos:Dist(targetPos)
    local angle = inst:GetAngleToPoint(targetPos:Get())
    for i = 1, numFX do
        inst:DoTaskInTime(math.random() * 0.25, function(inst)
            local fx = td1madao_safespawn('garendeerclops_icespike')
            if fx then
                local x = GetRandomWithVariance(0, 3)
                local z = GetRandomWithVariance(0, 3)
                local offset = (vec * math.random(dist * 0.25, dist)) + Vector3(x, 0, z)
                fx.Transform:SetPosition((offset + pos):Get())
            end
        end)
    end
end

local function onattack_metal(inst, owner, target)
    local summonchance = 0.01
    local ran = math.random()
    if ran > 0.5 and ran < 0.5 + summonchance and target and not target:HasTag("wall") then
        local pt = target:GetPosition()
        local st_pt = FindWalkableOffset(pt or owner:GetPosition(), math.random() * 2 * PI, 2, 3)
        local ore = "goldnugget"
        if math.random() < 0.75 and SaveGameIndex and SaveGameIndex.IsModeShipwrecked and SaveGameIndex:IsModeShipwrecked() then
            ore = "dubloon"
        end
        if math.random() < 0.1 then
            ore = tmptal[math.random(#tmptal)]
        end
        if st_pt then
            st_pt = st_pt + pt
            local st1 = td1madao_safespawn(ore)
            local st2 = td1madao_safespawn("collapse_small")
            st1.Transform:SetPosition(st_pt.x, st_pt.y, st_pt.z)
            st2.Transform:SetPosition(pt.x, pt.y, pt.z)
        end
    end
end

local function onattack_soulballyellow2(inst, owner, target)
    local summonchance = 0.1
    local ran = math.random()
    if ran > 0.5 and ran < 0.5 + summonchance and target then
        local x, y, z = target.Transform:GetWorldPosition()
        local creature = td1madao_safespawn("garendeciduous_root")
        creature.Transform:SetPosition(x, y, z)
    end
end

local function onattack_soulballyellow3(inst, attacker, target)
    local summonchance = 0.1
    local ran = math.random()
    if ran > 0.5 and ran < 0.5 + summonchance and attacker then
        if target.components.freezable then
            target.components.freezable:AddColdness(1)
            target.components.freezable:SpawnShatterFX()
        end
        if target.components.sleeper and target.components.sleeper:IsAsleep() then
            target.components.sleeper:WakeUp()
        end
        if target.components.burnable and target.components.burnable:IsBurning() then
            target.components.burnable:Extinguish()
        end
        if target.components.combat then
            target.components.combat:SuggestTarget(attacker)
            if target.sg and not target.sg:HasStateTag("frozen") and target.sg.sg.states.hit then
                target.sg:GoToState("hit")
                local x, y, z = target.Transform:GetWorldPosition()
                local creature = td1madao_safespawn("garendeerclops_icespike")
                creature.Transform:SetPosition(x, y, z)
            end
        end
    end
end

local function onattack_soulballyellow4(inst, attacker, target)
    local summonchance = 0.35
    local ran = math.random()
    if ran > 0.5 and ran < 0.5 + summonchance and attacker and not target.firefxtask then
        if target and target.components.burnable and target.components.burnable.SpawnFX then
            target.components.burnable:SpawnFX()
        end
        target.components.combat:GetAttacked(attacker, 15)
        target.firefxtask = target:DoTaskInTime(1, function()
            if target and target.components.burnable and target.components.burnable.KillFX then
                target.components.burnable:KillFX()
            end
            if target.firefxtask then
                target.firefxtask:Cancel()
                target.firefxtask = nil
            end
        end)
    end
end

local function onattack_soulballyellow6(inst, attacker, target)
end

local function onattack_soulballyellow7(inst, attacker, target)
    local summonchance = 0.05
    local ran = math.random()
    if ran > 0.5 and ran < 0.5 + summonchance and attacker and not target.firefxtask then
        GetPlayer().SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
        td1madao_safespawn("garenlightning").Transform:SetPosition(target:GetPosition():Get())
        td1madao_safespawn("lightning").Transform:SetPosition(target:GetPosition():Get())
        target.components.combat:GetAttacked(attacker, 60)
    end
end

local function soulballyellow_func2(inst, target)
    if not inst.components.equippable or not inst.components.finiteuses or (inst.components.finiteuses and inst.components.finiteuses.current <= 0) then
        return
    end
    local pos = Vector3(inst.Transform:GetWorldPosition())
    local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, 30)
    for k, v in pairs(ents) do
        if v.components.pickable and v.prefab ~= "flower" and v.prefab ~= "flower_evil" then
            v.components.pickable:Pick(GetPlayer())
        end
        if v.components.crop then
            v.components.crop:Harvest(GetPlayer())
        end
    end
    --    GetPlayer().components.hunger:DoDelta(-50, false, true)
    --    GetPlayer().components.sanity:DoDelta(-30)
    inst.components.finiteuses:Use(50)
end

local function soulballyellow_func6(staff, target, pos)
    if not staff.components.equippable or not staff.components.finiteuses or (staff.components.finiteuses and staff.components.finiteuses.current <= 0) then
        return
    end
    local fx = td1madao_safespawn("garentornado")
    local targetPos
    if target then
        targetPos = target:GetPosition()
    else
        targetPos = pos
    end
    local x, y, z = targetPos:Get()
    GetPlayer():ForceFacePoint(x, y, z)
    fx.Transform:SetPosition(staff:GetPosition():Get())
    fx:ForceFacePoint(x, y, z)
    fx.Physics:SetMotorVelOverride(15, 0, 0)
    fx.Physics:SetCollides(false)
    --    GetPlayer().components.sanity:DoDelta(-10)
    staff.components.finiteuses:Use(25)
end

local function cansoulballyellow2(inst, caster, target)
    if target then
        return not (caster:HasTag("skillq") or caster:HasTag("skillw") or caster:HasTag("skille") or caster:HasTag("skillr")) and not caster:HasTag("qbuffon") and not caster:HasTag("wbuffon") and not caster:HasTag("ebuffon") and not caster:HasTag("rbuffon") and caster.components.hunger.current > 30 and caster.components.sanity.current > 30 and inst.components.equippable and inst.components.finiteuses and inst.components.finiteuses.current > 0
    end
    return false
end

local function soulballyellow_func3(inst, target, pos)
    if not inst.components.equippable or not inst.components.finiteuses or (inst.components.finiteuses and inst.components.finiteuses.current <= 0) then
        return
    end
    SpawnIceFx(inst, target, pos)
    if not pos and target then
        pos = target:GetPosition()
    end
    local x, y, z = pos:Get()
    local ents = TheSim:FindEntities(x, y, z, 10)
    local player = GetPlayer()
    player:ForceFacePoint(x, y, z)
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
                if v.components.freezable then
                    v.components.freezable:AddColdness(4)
                    v.components.freezable:SpawnShatterFX()
                end
            end
        end
    end
    --    GetPlayer().components.hunger:DoDelta(-20, false, true)
    --    GetPlayer().components.sanity:DoDelta(-5)
    inst.components.finiteuses:Use(40)
end

local function cansoulballyellow3(staff, caster, target, pos)
    return not (caster:HasTag("skillq") or caster:HasTag("skillw") or caster:HasTag("skille") or caster:HasTag("skillr")) and not caster:HasTag("qbuffon") and not caster:HasTag("wbuffon") and not caster:HasTag("ebuffon") and not caster:HasTag("rbuffon") and caster.components.hunger.current > 30 and caster.components.sanity.current > 30 and staff.components.equippable and staff.components.finiteuses and staff.components.finiteuses.current > 0
end

local function soulballyellow_func5(inst, target, pos)
    if not inst.components.equippable or not inst.components.finiteuses or (inst.components.finiteuses and inst.components.finiteuses.current <= 0) then
        return
    end
    local x, y, z = inst:GetPosition():Get()
    local fx = td1madao_safespawn("groundpoundring_fx")
    fx.Transform:SetPosition(x, y, z)
    td1madao_safespawn("collapse_small").Transform:SetPosition(x, y, z)
    local ents = TheSim:FindEntities(x, y, z, 3)
    local player = GetPlayer()
    player:ForceFacePoint(x, y, z)
    local backpack = player.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    if backpack and backpack.components.container then
    else
        backpack = nil
    end
    local ruinnum = 0
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
                v.components.combat:GetAttacked(player, 20)
                td1madao_safespawn("collapse_small").Transform:SetPosition(v:GetPosition():Get())
            end
        elseif v and v.components.workable and v.components.workable.workleft > 0
                and player.components.hunger and ruinnum <= 4
        then
            ruinnum = ruinnum + 1
            --            player.components.hunger:DoDelta(-15, false, true)
            td1madao_safespawn("collapse_small").Transform:SetPosition(v:GetPosition():Get())
            v.components.workable:Destroy(player)
        end
    end
    --    GetPlayer().components.sanity:DoDelta(-10)
    inst.components.finiteuses:Use(30)
end

local function cansoulballyellow5(staff, caster, target, pos)
    return not (caster:HasTag("skillq") or caster:HasTag("skillw") or caster:HasTag("skille") or caster:HasTag("skillr")) and not caster:HasTag("qbuffon") and not caster:HasTag("wbuffon") and not caster:HasTag("ebuffon") and not caster:HasTag("rbuffon") and caster.components.hunger.current > 30 and caster.components.sanity.current > 30 and staff.components.equippable and staff.components.finiteuses and staff.components.finiteuses.current > 0
end

local function cansoulballyellow6(staff, caster, target, pos)
    return not (caster:HasTag("skillq") or caster:HasTag("skillw") or caster:HasTag("skille") or caster:HasTag("skillr")) and not caster:HasTag("qbuffon") and not caster:HasTag("wbuffon") and not caster:HasTag("ebuffon") and not caster:HasTag("rbuffon") and caster.components.hunger.current > 30 and caster.components.sanity.current > 30 and staff.components.equippable and staff.components.finiteuses and staff.components.finiteuses.current > 0
end

local function sealinit(inst)
    if inst.soulballyellow == 0 then
        return
    end
    if inst.soulballyellow == 1 then
        if inst.components.weapon then
            inst.components.weapon:SetOnAttack(onattack_metal)
        end
        if not inst.components.tool then
            inst:AddComponent("tool")
        end
        inst.components.tool:SetAction(ACTIONS.CHOP, 1)
        inst.components.finiteuses:SetConsumption(ACTIONS.CHOP, 1)
        inst.components.tool:SetAction(ACTIONS.MINE, 1)
        inst.components.finiteuses:SetConsumption(ACTIONS.MINE, 2)
        inst.components.tool:SetAction(ACTIONS.HAMMER, 1)
        inst.components.finiteuses:SetConsumption(ACTIONS.HAMMER, 2)
        if SaveGameIndex and SaveGameIndex.IsModeShipwrecked and SaveGameIndex:IsModeShipwrecked() then
            inst.components.tool:SetAction(ACTIONS.HACK, 1)
            inst.components.finiteuses:SetConsumption(ACTIONS.HACK, 1)
        end
    elseif inst.soulballyellow == 2 then
        if not inst.components.spellcaster then
            inst:AddComponent("spellcaster")
        end
        inst.components.spellcaster:SetSpellFn(soulballyellow_func2)
        inst.components.spellcaster.canuseontargets = true
        inst.components.spellcaster:SetSpellTestFn(cansoulballyellow2)
        if inst.components.weapon then
            inst.components.weapon:SetOnAttack(onattack_soulballyellow2)
        end
        inst:AddTag("nopunch")
    elseif inst.soulballyellow == 3 then
        if inst.components.weapon then
            inst.components.weapon:SetOnAttack(onattack_soulballyellow3)
        end
        if not inst.components.spellcaster then
            inst:AddComponent("spellcaster")
        end
        inst.components.spellcaster.canuseontargets = true
        inst.components.spellcaster.canusefrominventory = false
        inst.components.spellcaster.canuseonpoint = true
        inst.components.spellcaster.castingstate = "castspell_tornado"
        inst.components.spellcaster.actiontype = "SCIENCE"
        inst.components.spellcaster:SetSpellFn(soulballyellow_func3)
        inst.components.spellcaster:SetSpellTestFn(cansoulballyellow3)
    elseif inst.soulballyellow == 4 then
        if inst.components.weapon then
            inst.components.weapon:SetOnAttack(onattack_soulballyellow4)
        end
    elseif inst.soulballyellow == 5 then
        if not inst.components.spellcaster then
            inst:AddComponent("spellcaster")
        end
        inst.components.spellcaster.canuseontargets = true
        inst.components.spellcaster.canusefrominventory = false
        inst.components.spellcaster.canuseonpoint = true
        inst.components.spellcaster.castingstate = "castspell_tornado"
        inst.components.spellcaster.actiontype = "SCIENCE"
        inst.components.spellcaster:SetSpellFn(soulballyellow_func5)
        inst.components.spellcaster:SetSpellTestFn(cansoulballyellow5)
    elseif inst.soulballyellow == 6 then
        if inst.components.weapon then
            inst.components.weapon:SetOnAttack(onattack_soulballyellow6)
        end
        if not inst.components.spellcaster then
            inst:AddComponent("spellcaster")
        end
        inst.components.spellcaster.canuseontargets = true
        inst.components.spellcaster.canusefrominventory = false
        inst.components.spellcaster.canuseonpoint = true
        inst.components.spellcaster.castingstate = "castspell_tornado"
        inst.components.spellcaster.actiontype = "SCIENCE"
        inst.components.spellcaster:SetSpellFn(soulballyellow_func6)
        inst.components.spellcaster:SetSpellTestFn(cansoulballyellow6)
    elseif inst.soulballyellow == 7 then
        if not inst.components.blinkstaff then
            inst:AddComponent("blinkstaff")
        end
        inst.components.blinkstaff.onblinkfn = onblink
        if not inst.components.reticule then
            inst:AddComponent("reticule")
        end
        local old = inst.components.blinkstaff.CanBlinkToPoint
        inst.components.blinkstaff.CanBlinkToPoint = function(self, pt)
            local caster = GetPlayer()
            local staff = inst
            if inst.components.equippable and inst.components.finiteuses and inst.components.finiteuses.current > 0
                    and not (caster:HasTag("skillq") or caster:HasTag("skillw") or caster:HasTag("skille") or caster:HasTag("skillr")) and not caster:HasTag("qbuffon") and not caster:HasTag("wbuffon") and not caster:HasTag("ebuffon") and not caster:HasTag("rbuffon") and caster.components.hunger.current > 30 and caster.components.sanity.current > 30 and staff.components.equippable and staff.components.finiteuses and staff.components.finiteuses.current > 0
            then
                return old(self, pt)
            end
            return false
        end
        inst.components.reticule.targetfn = function()
            return inst.components.blinkstaff:GetBlinkPoint()
        end
        inst.components.reticule.ease = true
        if inst.components.weapon then
            inst.components.weapon:SetOnAttack(onattack_soulballyellow7)
        end
    end
end

local function addDamage(player, weapon)
    local additiondamage = 0
    if weapon and weapon.proficiency then
        additiondamage = math.floor(weapon.proficiency / 5000)
    end
    if weapon and weapon.components.weapon then
        weapon.components.weapon:SetDamage(weapon.defaultDamage + weapon.gemlevel + additiondamage)
        if weapon.gemlevel > 0 then
            weapon.name = string.format("[%s]%s(+%d)", STRINGS["LOLDL" .. tostring(weapon.damagelevel)], STRINGS.NAMES.GARENWEAPON1, weapon.gemlevel)
        else
            weapon.name = string.format("[%s]%s", STRINGS["LOLDL" .. tostring(weapon.damagelevel)], STRINGS.NAMES.GARENWEAPON1)
        end
        if weapon.soulballyellow ~= 0 then
            weapon.name = string.format("[%s]%s", LOLSYM[weapon.soulballyellow], weapon.name)
        end
        weapon.components.inspectable:SetDescription(string.format(TUNING.LOLMEMBER.TALK69, weapon.defaultDamage + weapon.gemlevel + additiondamage, weapon.bluegem, weapon.yellowgem, weapon.greengem, weapon.purplegem, weapon.orangegem))
    end
end

local function weaponLigth(player, weapon)
    if weapon and weapon.gemlevel >= 10 then
        weapon.Light:SetIntensity(Lerp(0.4, 0.6, weapon.gemlevel / 100))
        weapon.Light:SetRadius(Lerp(3, 5, weapon.gemlevel / 100))
        weapon.Light:SetFalloff(.9)
        if not weapon.Light:IsEnabled() then
            weapon.Light:Enable(true)
        end
    end
end

local function commonfn(weaponname)
    local function onfinished(inst)
        if inst.components.equippable then
            local target = GetPlayer()
            local item = target.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if inst == item then
                target.components.inventory:GiveItem(item)
            end
            inst:RemoveComponent("equippable")
        end
        if GetPlayer().components.combat == 5 then
            GetPlayer().components.combat:SetAreaDamage(0, 0)
        end
    end

    local function onequip(inst, owner)
        local player = GetPlayer()
        player.components.td1madao_attributer:changeWeapon(inst)
        owner.AnimState:OverrideSymbol("swap_object", "garenarsenallib", weaponname .. "/swap_" .. weaponname)
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
        weaponLigth(owner, inst)
        if inst and owner and owner.components.talker and inst.proficiency and inst.proficiency > 0 then
            owner.components.talker:Say(string.format(STRINGS.LOLPROFICIENCY, inst.proficiency))
        end
        if inst.soulballyellow == 5 then
            owner.components.combat:SetAreaDamage(1.5, 0.1)
        end
    end

    local function onunequip(inst, owner)
        local player = GetPlayer()
        player.components.td1madao_attributer:removeWeapon()
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
        if inst.soulballyellow == 5 then
            owner.components.combat:SetAreaDamage(0, 0)
        end
        if inst.Light and inst.Light:IsEnabled() then
            inst.Light:Enable(false)
        end
    end

    local player = GetPlayer()
    local inst = CreateEntity()
    inst.weaponname = weaponname
    inst.supportfueltype = {
        ["purplegem"] = true,
        ["bluegem"] = true,
        ["gemlevel"] = true,
        ["orangegem"] = true,
        ["yellowgem"] = true,
        ["greengem"] = true,
        ["soulballblue"] = true,
        ["soulballyellow"] = true,
        ["lolhammer"] = true,
    }
    inst.sealinit = sealinit
    inst.addDamage = addDamage
    inst.soulballyellow = 0
    inst.gemlevel = 0
    inst.purplegem = 0
    inst.bluegem = 0
    inst.orangegem = 0
    inst.yellowgem = 0
    inst.greengem = 0
    inst.othergemlevelmax = 15
    inst.proficiency = 0
    inst.entity:AddLight()
    inst.Light:SetColour(255 / 255, 255 / 255, 0 / 255)
    inst.Light:Enable(false)
    local function iterator(num)
        if num > math.floor(math.tan(math.tan(0.98))) then
            return math.floor(math.tan(math.tan(0.98)))
        elseif math.random() < math.cos(math.rad(61)) then
            return iterator(num + 1)
        else
            return num
        end
    end

    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    anim:SetBank(weaponname)
    anim:SetBuild("garenarsenallib")
    anim:PlayAnimation("GROUND")
    if td1madao_enableSW() then
        MakeInventoryFloatable(inst, "FLOAT", "GROUND")
    end
    inst:AddTag("sharp")
    inst.weaponfix = 0
    inst:AddComponent("weapon")
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.SPEAR_USES)
    inst.components.finiteuses:SetUses(TUNING.SPEAR_USES)
    inst.components.finiteuses:SetOnFinished(onfinished)
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetOnDroppedFn(function(inst)
        if inst and inst.Light and inst.Light:IsEnabled() then
            inst.Light:Enable(false)
        end
    end)
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.inventoryitem.imagename = weaponname
    inst.components.inventoryitem.atlasname = "images/inventoryimages/garenarsenal.xml"
    inst.damagelevel = getweaponlevelname(inst)
    local function TakeItem(inst)
        if not inst.components.equippable then
            inst:AddComponent("equippable")
            inst.components.equippable:SetOnEquip(onequip)
            inst.components.equippable:SetOnUnequip(onunequip)
        end
        addDamage(player, inst)
        player.components.td1madao_attributer:refresh()
        if inst.gemlevel > 0 then
            inst.name = string.format("[%s]%s(+%d)", STRINGS["LOLDL" .. tostring(inst.damagelevel)], STRINGS.NAMES.GARENWEAPON1, inst.gemlevel)
            if inst.soulballyellow ~= 0 then
                inst.name = string.format("[%s]%s", LOLSYM[inst.soulballyellow], inst.name)
            end
            local hand = player.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if inst.gemlevel >= 10 and hand and hand == inst then
                weaponLigth(player, inst)
            end
        end
    end

    inst[lolconvertor('bcnchfifwfi')] = iterator(1)
    td1madao_showQuality(inst)
    inst.defaultDamage = (0.6 + inst.damagelevel * 0.15) * TUNING.SPEAR_DAMAGE
    inst.components.weapon:SetDamage(inst.defaultDamage)
    inst:AddComponent("tradable")
    if not inst.components.fueled then
        inst:AddComponent("fueled")
    end
    inst.components.fueled.fueltype = "GARENFUEL"
    inst.components.fueled:InitializeFuelLevel(20000000)
    inst.components.fueled.ontakefuelfn = TakeItem
    inst.components.fueled.accepting = true
    inst.components.fueled:StopConsuming()
    inst:AddTag("garenweapon")
    local function onpreload(inst, data)
        if not data then
            data = {}
        end
        if data.weaponname then
            inst.weaponname = data.weaponname
        else
            inst.weaponname = weaponname
        end
        if data.defaultDamage then
            inst.defaultDamage = data.defaultDamage
        else
            inst.defaultDamage = TUNING.SPEAR_DAMAGE * 0.6
        end
        if data.damagelevel then
            inst.damagelevel = data.damagelevel
        else
            inst.damagelevel = math.floor((inst.defaultDamage / TUNING.SPEAR_DAMAGE - 0.6) / 0.15)
            if inst.damagelevel < 1 then
                inst.damagelevel = 1
            end
        end
        if data.gemlevel then
            inst.gemlevel = data.gemlevel
        else
            inst.gemlevel = 0
        end
        if data.proficiency then
            inst.proficiency = data.proficiency
        else
            inst.proficiency = 0
        end
        if data.soulballyellow then
            inst.soulballyellow = data.soulballyellow
        else
            inst.soulballyellow = 0
        end
        if inst.gemlevel > 0 then
            inst.name = string.format("[%s]%s(+%d)", STRINGS["LOLDL" .. tostring(inst.damagelevel)], STRINGS.NAMES.GARENWEAPON1, inst.gemlevel)
        else
            inst.name = string.format("[%s]%s", STRINGS["LOLDL" .. tostring(inst.damagelevel)], STRINGS.NAMES.GARENWEAPON1)
        end
        if inst.soulballyellow ~= 0 then
            inst.name = string.format("[%s]%s", LOLSYM[inst.soulballyellow], inst.name)
        end

        if data.purplegem then
            inst.purplegem = data.purplegem
        else
            inst.purplegem = 0
        end

        if data.bluegem then
            inst.bluegem = data.bluegem
        else
            inst.bluegem = 0
        end

        if data.orangegem then
            inst.orangegem = data.orangegem
        else
            inst.orangegem = 0
        end

        if data.yellowgem then
            inst.yellowgem = data.yellowgem
        else
            inst.yellowgem = 0
        end
        if data.weaponfix then
            inst.weaponfix = data.weaponfix
        else
            inst.weaponfix = 0
        end
        inst.components.finiteuses:SetMaxUses(TUNING.SPEAR_USES + inst.weaponfix * 30)
        if inst.components.finiteuses and inst.components.finiteuses.current and data.fu and not td1madao_invalidNum(data.fu) and type(data.fu) == 'number' and data.fu > 0 then
            inst.components.finiteuses:SetUses(data.fu)
        end
        if data.greengem then
            inst.greengem = data.greengem
        else
            inst.greengem = 0
        end
        if inst.purplegem >= 15 then
            inst.supportfueltype["purplegem"] = false
        end
        if inst.bluegem >= 15 then
            inst.supportfueltype["bluegem"] = false
        end
        if inst.orangegem >= 15 then
            inst.supportfueltype["orangegem"] = false
        end
        if inst.yellowgem >= 15 then
            inst.supportfueltype["yellowgem"] = false
        end
        if inst.greengem >= 15 then
            inst.supportfueltype["greengem"] = false
        end
        if inst.gemlevel >= 30 then
            inst.supportfueltype["gemlevel"] = false
        end
        if inst.soulballyellow == 0 then
            inst.supportfueltype["soulballyellow"] = true
        else
            inst.supportfueltype["soulballyellow"] = false
        end
        addDamage(player, inst)
        sealinit(inst)
        td1madao_showQuality(inst)
    end

    local function onsave(inst, data)
        if inst.weaponname then
            data.weaponname = inst.weaponname
        else
            data.weaponname = weaponname
        end
        if inst.weaponfix then
            data.weaponfix = inst.weaponfix
        else
            data.weaponfix = 0
        end
        if inst.defaultDamage then
            data.defaultDamage = inst.defaultDamage
        else
            data.defaultDamage = TUNING.SPEAR_DAMAGE * 0.6
        end
        if inst.proficiency then
            data.proficiency = inst.proficiency
        else
            data.proficiency = 0
        end
        if inst.gemlevel then
            data.gemlevel = inst.gemlevel
        else
            data.gemlevel = 0
        end
        if inst.damagelevel then
            data.damagelevel = inst.damagelevel
        else
            inst.damagelevel = math.floor((inst.defaultDamage / TUNING.SPEAR_DAMAGE - 0.6) / 0.15)
            if inst.damagelevel < 1 then
                inst.damagelevel = 1
            end
            data.damagelevel = inst.damagelevel
        end
        if inst.purplegem then
            data.purplegem = inst.purplegem
        else
            data.purplegem = 0
        end

        if inst.bluegem then
            data.bluegem = inst.bluegem
        else
            data.bluegem = 0
        end

        if inst.orangegem then
            data.orangegem = inst.orangegem
        else
            data.orangegem = 0
        end
        if inst.soulballyellow then
            data.soulballyellow = inst.soulballyellow
        else
            data.soulballyellow = 0
        end

        if inst.yellowgem then
            data.yellowgem = inst.yellowgem
        else
            data.yellowgem = 0
        end

        if inst.greengem then
            data.greengem = inst.greengem
        else
            data.greengem = 0
        end
        if inst.components.finiteuses and inst.components.finiteuses.current and not td1madao_invalidNum(inst.components.finiteuses.current) then
            data.fu = inst.components.finiteuses.current
        else
            data.fu = 100
        end
    end

    inst.OnSave = onsave
    inst.OnPreLoad = onpreload
    addDamage(player, inst)
    return inst
end

local function garenaxetype(weaponname)
    local inst = commonfn(weaponname)
    inst.fixeffect = 1.2
    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.CHOP, 1.5)
    inst.components.finiteuses:SetConsumption(ACTIONS.CHOP, 1)
    return inst
end

local function garenspeartype(weaponname)
    local inst = commonfn(weaponname)
    inst.components.weapon:SetRange(1.5)
    inst.period = 1.2
    inst.defaultDamage = math.ceil(inst.defaultDamage * 0.9)
    inst.components.weapon:SetDamage(inst.defaultDamage)
    addDamage(nil, inst)
    return inst
end

local function garenspeartype(weaponname)
    local inst = commonfn(weaponname)
    inst.period = 0.5
    inst.defaultDamage = math.ceil(inst.defaultDamage * 0.55)
    inst.components.weapon:SetDamage(inst.defaultDamage)
    addDamage(nil, inst)
    return inst
end

local function garenhammertype(weaponname)
    local inst = commonfn(weaponname)
    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.HAMMER)
    inst.components.finiteuses:SetConsumption(ACTIONS.HAMMER, 2)
    inst.components.weapon:SetRange(1)
    inst.defaultDamage = math.ceil(inst.defaultDamage * 1.13)
    inst.components.weapon:SetDamage(inst.defaultDamage)
    inst.period = 1.4
    addDamage(nil, inst)
    return inst
end

local function garenspeartype(weaponname)
    return commonfn(weaponname)
end

local function garenblunttype(weaponname)
    local inst = commonfn(weaponname)
    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.HAMMER)
    inst.components.finiteuses:SetConsumption(ACTIONS.HAMMER, 2)
    inst.defaultDamage = math.ceil(inst.defaultDamage * 1.07)
    inst.components.weapon:SetDamage(inst.defaultDamage)
    inst.period = 1.3
    addDamage(nil, inst)
    return inst
end

local function garenbowtype(weaponname)
    local inst = commonfn(weaponname)
    inst.fixeffect = 0.12
    inst.components.finiteuses:SetMaxUses(TUNING.SPEAR_USES / 10)
    inst.components.finiteuses:SetUses(TUNING.SPEAR_USES / 10)
    inst.period = 3
    inst.defaultDamage = math.ceil(inst.defaultDamage * 1.13)
    inst.components.weapon:SetRange(8, 10)
    inst.components.weapon:SetDamage(inst.defaultDamage)
    addDamage(nil, inst)
    inst:AddTag("garenbowtype")
    return inst
end

local function garenstafftype(weaponname)
    local inst = commonfn(weaponname)
    inst.components.weapon:SetRange(1)
    inst.period = 1.3
    addDamage(nil, inst)
    return inst
end

local function garenwandtype(weaponname)
    return garenspeartype(weaponname)
end

local function garen1() return garenspeartype("garen1") end

local function garen2() return garenspeartype("garen2") end

local function garen3() return garenblunttype("garen3") end

local function garen4() return garenspeartype("garen4") end

local function garen5() return garenspeartype("garen5") end

local function garen6() return garenblunttype("garen6") end

local function garen7() return garenspeartype("garen7") end

local function garen8() return garenwandtype("garen8") end

local function garen9() return garenwandtype("garen9") end

local function garen10() return garenblunttype("garen10") end

local function garen11() return garenblunttype("garen11") end

local function garen12() return garenwandtype("garen12") end

local function garen13() return garenwandtype("garen13") end

local function garen14() return garenwandtype("garen14") end

local function garen15() return garenspeartype("garen15") end

local function garen16() return garenstafftype("garen16") end

local function garen17() return garenstafftype("garen17") end

local function garen18() return garenstafftype("garen18") end

local function garen19() return garenstafftype("garen19") end

local function garen20() return garenaxetype("garen20") end

local function garen21() return garenaxetype("garenaxe") end

local function garen22() return garenspeartype("garenpike") end

local function garen23() return garenspeartype("garencatsword") end

local function garen24() return garenhammertype("garencth") end

local function garen25() return garenbowtype("garenfeatherbow") end

local function garen26() return garenstafftype("garenwhitewand") end

local function selfmake(name, name2, name4)
    local temp = garenspeartype("garen1")
    local function onequip(inst, owner)
        owner.AnimState:OverrideSymbol("swap_object", name, name)
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
    end

    MakeInventoryPhysics(temp)
    if td1madao_enableSW() then
        MakeInventoryFloatable(temp, "idle_water", "idle")
    end
    local name3 = string.gsub(name, "swap_", "")
    temp.AnimState:SetBank(name3)
    if name4 == nil then
        name4 = name3
    end
    temp.AnimState:SetBuild(name4)
    temp.AnimState:PlayAnimation("idle")
    temp.components.inventoryitem.imagename = nil
    temp.components.inventoryitem.atlasname = nil
    temp.components.inventoryitem:ChangeImageName(name2)
    temp.components.equippable:SetOnEquip(onequip)
    return temp
end

local function garen27() return selfmake("swap_batbat", "batbat") end

local function garen28() return selfmake("swap_nightmaresword", "nightsword") end

local function garen29() return selfmake("swap_spike", "tentaclespike", "tentacle_spike") end

local function garen30() return selfmake("swap_ruins_bat", "ruins_bat") end

local function garen31() return selfmake("swap_cutlass", "cutlass") end

local function garen32() return selfmake("swap_ham_bat", "hambat") end

return
Prefab("common/inventory/garenweapon1", garen1, assets, prefabs),
Prefab("common/inventory/garenweapon2", garen2, assets, prefabs),
Prefab("common/inventory/garenweapon3", garen3, assets, prefabs),
Prefab("common/inventory/garenweapon4", garen4, assets, prefabs),
Prefab("common/inventory/garenweapon5", garen5, assets, prefabs),
Prefab("common/inventory/garenweapon6", garen6, assets, prefabs),
Prefab("common/inventory/garenweapon7", garen7, assets, prefabs),
Prefab("common/inventory/garenweapon8", garen8, assets, prefabs),
Prefab("common/inventory/garenweapon9", garen9, assets, prefabs),
Prefab("common/inventory/garenweapon10", garen10, assets, prefabs),
Prefab("common/inventory/garenweapon11", garen11, assets, prefabs),
Prefab("common/inventory/garenweapon12", garen12, assets, prefabs),
Prefab("common/inventory/garenweapon13", garen13, assets, prefabs),
Prefab("common/inventory/garenweapon14", garen14, assets, prefabs),
Prefab("common/inventory/garenweapon15", garen15, assets, prefabs),
Prefab("common/inventory/garenweapon16", garen16, assets, prefabs),
Prefab("common/inventory/garenweapon17", garen17, assets, prefabs),
Prefab("common/inventory/garenweapon18", garen18, assets, prefabs),
Prefab("common/inventory/garenweapon19", garen19, assets, prefabs),
Prefab("common/inventory/garenweapon20", garen20, assets, prefabs),
Prefab("common/inventory/garenweapon21", garen21, assets, prefabs),
Prefab("common/inventory/garenweapon22", garen22, assets, prefabs),
Prefab("common/inventory/garenweapon23", garen23, assets, prefabs),
Prefab("common/inventory/garenweapon24", garen24, assets, prefabs),
Prefab("common/inventory/garenweapon25", garen25, assets, prefabs),
Prefab("common/inventory/garenweapon26", garen26, assets, prefabs),
Prefab("common/inventory/garenweapon27", garen27, assets, prefabs),
Prefab("common/inventory/garenweapon28", garen28, assets, prefabs),
Prefab("common/inventory/garenweapon29", garen29, assets, prefabs),
Prefab("common/inventory/garenweapon30", garen30, assets, prefabs),
Prefab("common/inventory/garenweapon31", garen31, assets, prefabs),
Prefab("common/inventory/garenweapon32", garen32, assets, prefabs)