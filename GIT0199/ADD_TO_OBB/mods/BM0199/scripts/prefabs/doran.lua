local assets =
{
    Asset("ANIM", "anim/doran.zip"),
    Asset("ANIM", "anim/swap_doran.zip"),
    Asset("ATLAS", "images/inventoryimages/doran.xml"),
    Asset("IMAGE", "images/inventoryimages/doran.tex"),
}

local prefabs =
{}


local function addDamage(player, weapon)
    if weapon and weapon.components.weapon then
        weapon.components.weapon:SetDamage(30 + weapon.gemlevel)
        if weapon.gemlevel > 0 then
            weapon.name = string.format("%s(+%d)", STRINGS.NAMES.DORAN, weapon.gemlevel)
        else
            weapon.name = STRINGS.NAMES.DORAN
        end
        weapon.components.inspectable:SetDescription(string.format(TUNING.LOLMEMBER.TALK69, 30 + weapon.gemlevel, weapon.bluegem, weapon.yellowgem, weapon.greengem, weapon.purplegem, weapon.orangegem))
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



local function OnEquip(inst, owner)
    local player = GetPlayer()
    player.components.td1madao_attributer:changeWeapon(inst)
    owner.AnimState:OverrideSymbol("swap_object", "swap_doran", "doran1")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    weaponLigth(owner, inst)
end

local function OnUnequip(inst, owner)
    local player = GetPlayer()
    player.components.td1madao_attributer:removeWeapon()
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    if inst.Light and inst.Light:IsEnabled() then
        inst.Light:Enable(false)
    end
end

local function onfinished(inst)
    inst:Remove()
end

local function fn(colour)
    local player = GetPlayer()
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.supportfueltype = {
        ["purplegem"] = true,
        ["bluegem"] = true,
        ["gemlevel"] = true,
        ["orangegem"] = true,
        ["yellowgem"] = true,
        ["greengem"] = true,
    }
    inst.addDamage = addDamage
    inst.gemlevel = 0
    inst.purplegem = 0
    inst.bluegem = 0
    inst.orangegem = 0
    inst.yellowgem = 0
    inst.greengem = 0
    inst.entity:AddLight()
    inst.Light:SetColour(255 / 255, 255 / 255, 0 / 255)
    inst.Light:Enable(false)
    anim:SetBank("doran")
    anim:SetBuild("doran")
    anim:PlayAnimation("doran1")
    if IsDLCEnabled and CAPY_DLC and IsDLCEnabled(CAPY_DLC) then
        MakeInventoryFloatable(inst, "doran1", "doran1")
    end
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(30)
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetOnDroppedFn(function(inst)
        if inst and inst.Light and inst.Light:IsEnabled() then
            inst.Light:Enable(false)
        end
    end)
    inst.components.inventoryitem.imagename = "doran"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/doran.xml"
    inst:AddComponent("equippable")
    if not inst.components.characterspecific then
        inst:AddComponent("characterspecific")
    end
    inst.components.characterspecific:SetOwner("garen")
    inst.components.inventoryitem.keepondeath = true
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
    addDamage(player, inst)
    local function TakeItem(inst)
        addDamage(player, inst)
        player.components.td1madao_attributer:refresh()
        if inst.gemlevel > 0 then
            inst.name = string.format("%s(+%d)", STRINGS.NAMES.DORAN, inst.gemlevel)
            local hand = player.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if inst.gemlevel >= 10 and hand and hand == inst then
                weaponLigth(player, inst)
            end
        end
    end

    inst.defaultDamage = 30
    if not inst.components.fueled then
        inst:AddComponent("fueled")
    end
    inst.components.fueled.fueltype = "GARENFUEL"
    inst.components.fueled:InitializeFuelLevel(20000000)
    inst.components.fueled.ontakefuelfn = TakeItem
    inst.components.fueled.accepting = true
    inst.components.fueled:StopConsuming()
    inst:AddTag("garenweapon")
    inst:AddComponent("tradable")

    local function onpreload(inst, data)
        if not data then
            data = {}
        end
        if data.gemlevel then
            inst.gemlevel = data.gemlevel
        else
            inst.gemlevel = 0
        end
        if inst.gemlevel > 0 then
            inst.name = string.format("%s(+%d)", STRINGS.NAMES.DORAN, inst.gemlevel)
        else
            inst.name = STRINGS.NAMES.DORAN
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

        if data.greengem then
            inst.greengem = data.greengem
        else
            inst.greengem = 0
        end

        if inst.purplegem >= 10 then
            inst.supportfueltype["purplegem"] = false
        end
        if inst.bluegem >= 10 then
            inst.supportfueltype["bluegem"] = false
        end
        if inst.orangegem >= 10 then
            inst.supportfueltype["orangegem"] = false
        end
        if inst.yellowgem >= 10 then
            inst.supportfueltype["yellowgem"] = false
        end
        if inst.greengem >= 10 then
            inst.supportfueltype["greengem"] = false
        end
        if inst.gemlevel >= 15 then
            inst.supportfueltype["gemlevel"] = false
        end
        addDamage(player, inst)
    end

    local function onsave(inst, data)
        if inst.gemlevel then
            data.gemlevel = inst.gemlevel
        else
            data.gemlevel = 0
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
    end

    inst.OnSave = onsave
    inst.OnPreLoad = onpreload
    inst.gemlevelmax = 15
    return inst
end




return Prefab("common/inventory/doran", fn, assets, prefabs)