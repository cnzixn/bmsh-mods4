--[[
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- If any question ,Please email me using Chinese to let me distinguish whether it is spam
 -- @Description: undefined
 -- @version 1.0.0
 -- @author td1madao
 -- @email td1madao@163.com
 -- @qq 360810498
 -- @date 16/8/6
 ]]

local postInitCharacter = _G.TD1MADAO_CHAR

local function MaxwellIntro(inst)
    if _G.GetPlayer().prefab == postInitCharacter then
        inst.AnimState:SetBuild(td1madao_getstr("%smaxwell_build"))
        inst.components.maxwelltalker.speeches.SANDBOX_1 =
        {
            appearsound = "dontstarve/maxwell/disappear",
            voice = "dontstarve/maxwell/talk_LP_world3",
            appearanim = "appear",
            idleanim = "idle",
            dialogpreanim = "dialog_pre",
            dialoganim = "dial_loop",
            dialogpostanim = "dialog_pst",
            disappearanim = "disappear",
            disableplayer = true,
            skippable = false,
            {
                string = TUNING.LOLMEMBER.TALK29,
                wait = 2,
                anim = nil,
                sound = nil,
            },
            {
                string = TUNING.LOLMEMBER.TALK30,
                wait = 3.5,
                anim = nil,
                sound = nil,
            },
            {
                string = TUNING.LOLMEMBER.TALK31,
                wait = 3.5,
                anim = nil,
                sound = nil,
            },
            {
                string = TUNING.LOLMEMBER.TALK32,
                wait = 5,
                anim = nil,
                sound = nil,
            },
            {
                string = TUNING.LOLMEMBER.TALK33,
                wait = 3,
                anim = nil,
                sound = nil,
            },
            {
                string = TUNING.LOLMEMBER.TALK34,
                wait = 3,
                anim = nil,
                sound = nil,
            },
            {
                string = TUNING.LOLMEMBER.TALK35,
                wait = 3,
                anim = nil,
                sound = nil,
            },
        }
    end
end

AddPrefabPostInit("maxwellintro", MaxwellIntro)

if td1madao_enableSW() then
    local function WallyIntro(inst)
        if _G.GetPlayer().prefab == postInitCharacter then
            local function TakeOff(inst)
                local bird = td1madao_safespawn("wallyintro_bird")
                bird.Transform:SetPosition(inst:GetPosition():Get())
                bird.Transform:SetRotation(inst.Transform:GetRotation())
                bird.AnimState:PlayAnimation("takeoff_diagonal_pre")
                local toplayer = (GetPlayer():GetPosition() - inst:GetPosition()):Normalize()
                bird.animoverfn = function()
                    bird:RemoveEventCallback("animover", bird.animoverfn)
                    bird.AnimState:PlayAnimation("takeoff_diagonal_loop", true)
                    bird:DoTaskInTime(2, function() bird:Remove() end)
                    bird:DoPeriodicTask(7 * FRAMES, function()
                        bird.SoundEmitter:PlaySound("dontstarve/birds/flyin")
                    end)
                    bird:DoPeriodicTask(0, function()
                        local currentpos = bird:GetPosition()
                        local flightspeed = 7.5
                        local posdelta = Vector3(toplayer.x * flightspeed, flightspeed, toplayer.z * flightspeed) * FRAMES
                        local newpos = currentpos + posdelta
                        bird.Transform:SetPosition(newpos:Get())
                    end)
                end
                bird:ListenForEvent("animover", bird.animoverfn)
                local mast = td1madao_safespawn("wallyintro_shipmast")
                mast.Transform:SetPosition(inst:GetPosition():Get())
                mast.Transform:SetRotation(inst.Transform:GetRotation())

                inst:Remove()
            end

            inst.components.maxwelltalker.speeches.SHIPWRECKED_1 =
            {
                voice = "dontstarve_DLC002/creatures/parrot/chirp",
                idleanim = "idle",
                dialoganim = "speak",
                disappearanim = TakeOff,
                disableplayer = true,
                skippable = false,
                {
                    string = TUNING.LOLMEMBER.TALK29,
                    wait = 2,
                    anim = "idle",
                    pushanim = true,
                    sound = nil,
                },
                {
                    string = TUNING.LOLMEMBER.TALK30,
                    wait = 3.5,
                    anim = nil,
                    sound = nil,
                },
                {
                    string = TUNING.LOLMEMBER.TALK31,
                    wait = 3.5,
                    anim = nil,
                    sound = nil,
                },
                {
                    string = TUNING.LOLMEMBER.TALK32,
                    wait = 5,
                    anim = nil,
                    sound = nil,
                },
                {
                    string = TUNING.LOLMEMBER.TALK33,
                    wait = 3,
                    anim = nil,
                    sound = nil,
                },
                {
                    string = TUNING.LOLMEMBER.TALK34,
                    wait = 3,
                    anim = "idle_peck",
                    pushanim = true,
                    sectionfn = function(inst)
                        inst:ListenForEvent("animover", PlayPecks)
                    end,
                },
                {
                    string = TUNING.LOLMEMBER.TALK35,
                    wait = 3,
                    anim = nil,
                    sound = nil,
                },
            }
        end
    end

    AddPrefabPostInit("wallyintro", WallyIntro)
end

local gemtable = {
    "purplegem",
    "bluegem",
    "orangegem",
    "yellowgem",
    "greengem",
}

for i = 1, #gemtable do
    if gemtable[i] then
        local gemName = gemtable[i]
        AddPrefabPostInit(gemName, function(inst)
            if GetPlayer().prefab == postInitCharacter then
                if not inst.components.fuel then
                    inst:AddComponent("fuel")
                end
                if not inst.components.td1madao_color_printer then
                    inst:AddComponent("td1madao_color_printer")
                end
                inst.components.fuel.fuelvalue = 1
                inst.components.fuel.fueltype = gemName
                inst.components.fuel:SetOnTakenFn(function(inst, taker)
                    if taker and taker:HasTag(td1madao_getstr("%sweapon", postInitCharacter)) then
                        taker[gemName] = taker[gemName] + 1
                        if taker[gemName] >= (taker.othergemlevelmax or 10) then
                            taker.supportfueltype[gemName] = false
                        end
                    end
                end)
            end
        end)
    end
end
AddPrefabPostInit("redgem", function(inst)
    if GetPlayer().prefab == postInitCharacter then
        if not inst.components.fuel then
            inst:AddComponent("fuel")
        end

        if not inst.components.td1madao_color_printer then
            inst:AddComponent("td1madao_color_printer")
        end

        inst.components.fuel.fuelvalue = 1
        inst.components.fuel.fueltype = "gemlevel"
        inst.components.fuel:SetOnTakenFn(function(inst, taker)
            if taker and taker:HasTag(td1madao_getstr("%sweapon", postInitCharacter)) then
                taker.gemlevel = taker.gemlevel + 1
                taker.addDamage(nil, taker)
                if taker.gemlevel >= (taker.gemlevelmax or 30) then
                    taker.supportfueltype["gemlevel"] = false
                end
            end
        end)
    end
end)

AddPrefabPostInit("mandrakesoup", function(inst)
    if GetPlayer().prefab == postInitCharacter then
        local fun = inst.components.edible.oneaten
        inst.components.edible:SetOnEatenFn(function(inst, eater)
            if fun ~= nil then
                fun(inst, eater)
            end
            GetPlayer().lolattackpoint = 0
            GetPlayer().lolwisepoint = 0
            GetPlayer().lolphysiquepoint = 0
            GetPlayer().lolagilepoint = 0
            GetPlayer().components.td1madao_skill_pointer:getlolpointcanuse()
        end)
    end
end)

AddComponentPostInit("fueled", function(self)
    if GetPlayer().prefab == postInitCharacter then
        function self:CanAcceptFuelItem(item)
            if item and item.components.repairer and item.components.repairer.repairmaterial
                    and item.components.repairer.repairmaterial == "gem"
            then
                return self.accepting and item and item.components.fuel
                        and self.inst.supportfueltype
                        and self.inst.supportfueltype[item.components.fuel.fueltype]
            else
                return self.accepting and item and item.components.fuel and (item.components.fuel.fueltype == self.fueltype or item.components.fuel.fueltype == self.secondaryfueltype)
            end
        end

        local old = self.TakeFuelItem
        function self:TakeFuelItem(item)
            if item and item.components.repairer and item.components.repairer.repairmaterial == "gem" then
                local player = GetPlayer()
                local name = item.prefab
                if name == 'redgem' then
                    name = "gemlevel"
                end
                local level = self.inst[name]
                if not level then
                    level = 0
                end
                local costM = (level + 1) * 213
                local eno = player.components.td1madao_leveler:moneyEnough(costM)
                if not eno or not self:CanAcceptFuelItem(item) then
                    _G.td1madao_runLatter(player, 1, function()
                        local str = string.format(TUNING.LOLMEMBER.TALK96, costM)
                        player.components.talker:Say(str)
                    end)
                    return false
                else
                    player.components.td1madao_leveler:useMoney(costM)
                end
            end
            if old then
                return old(self, item)
            end
            return true
        end
    end
end)
AddComponentPostInit("characterspecific", function(self)
    if GetPlayer().prefab == postInitCharacter then
        function self:SetOwner(name)
            if name and name ~= postInitCharacter then
                name = postInitCharacter
            end
            self.owner = name
        end
    end
end)
local function elemental(inst)
    if GetPlayer().prefab == postInitCharacter then
        if not inst.components.fuel then
            inst:AddComponent("fuel")
        end
        inst.components.fuel.fuelvalue = TUNING.MED_LARGE_FUEL
        inst.components.fuel.fueltype = td1madao_getupper('%sFUEL', postInitCharacter)
        inst.components.fuel:SetOnTakenFn(function(inst, taker)
            if taker and taker.components.finiteuses then
                local fixeffect = 1
                if taker.fixeffect then
                    fixeffect = taker.fixeffect
                end
                taker.components.finiteuses.current = taker.components.finiteuses.current + (15 + GetPlayer().components.td1madao_leveler:getCurrentLevel() * 1.5) * fixeffect
                if taker.components.finiteuses.current > taker.components.finiteuses.total then
                    taker.components.finiteuses.current = taker.components.finiteuses.total
                end
                taker.components.finiteuses:Use(0)
            end
        end)
    end
end

local fixMaterial = {
    "rocks",
    "goldnugget",
    "flint",
    "marble",
    "thulecite_pieces",
    "thulecite",
    "heatrock",
    "nitre",
    "cutstone",
}

for i = 1, #fixMaterial do
    if fixMaterial[i] then
        AddPrefabPostInit(fixMaterial[i], elemental)
    end
end

local function OnGetItemFromPlayer(inst, giver, item)
    if item:HasTag(td1madao_getstr("%sweapon", postInitCharacter)) and item.defaultDamage and item.prefab ~= td1madao_getstr("%ssoulball", postInitCharacter) then
        local number = math.ceil(item.defaultDamage / 15)
        for k = 1, number do
            local matran = math.random()
            local material = 'rocks'
            if matran < 0.2 then
                material = 'rocks'
            elseif matran < 0.4 then
                material = 'flint'
            elseif matran < 0.6 then
                material = 'cutgrass'
            elseif matran < 0.8 then
                material = 'twigs'
            elseif matran < 0.97 then
                material = 'goldnugget'
            elseif matran < 0.975 then
                material = 'redgem'
            elseif matran < 0.98 then
                material = 'bluegem'
            elseif matran < 0.985 then
                material = 'greengem'
            elseif matran < 0.99 then
                material = 'yellowgem'
            elseif matran < 0.995 then
                material = 'orangegem'
            else
                material = 'purplegem'
            end
            local pt = _G.Vector3(inst.Transform:GetWorldPosition()) + _G.Vector3(0, 4.5, 0)
            local nug = _G.td1madao_safespawn(material)
            if nug then
                nug.Transform:SetPosition(pt:Get())
                local down = _G.TheCamera:GetDownVec()
                local angle = math.atan2(down.z, down.x) + (math.random() * 60 - 30) * _G.DEGREES
                local sp = math.random() * 4 + 2
                nug.Physics:SetVel(sp * math.cos(angle), math.random() * 2 + 8, sp * math.sin(angle))
            end
        end
    elseif item.prefab == td1madao_getstr("%ssoulball", postInitCharacter) or item.prefab == td1madao_getstr("%ssoulballadvance", postInitCharacter) then
        local material = item.prefab
        local fx2 = td1madao_safespawn("statue_transition")
        if not fx2.components.highlight then
            fx2:AddComponent("highlight")
        end
        fx2.components.highlight:SetAddColour(Vector3(0, 1, 0))
        fx2.Transform:SetScale(2, 2, 2)
        fx2.Transform:SetPosition(inst:GetPosition():Get())
        local pt = _G.Vector3(inst.Transform:GetWorldPosition()) + _G.Vector3(0, 4.5, 0)
        local nug = _G.td1madao_safespawn(material)
        if nug then
            nug.Transform:SetPosition(pt:Get())
            local down = _G.TheCamera:GetDownVec()
            local angle = math.atan2(down.z, down.x) + (math.random() * 60 - 30) * _G.DEGREES
            local sp = math.random() * 4 + 2
            nug.Physics:SetVel(sp * math.cos(angle), math.random() * 2 + 8, sp * math.sin(angle))
        end
    end
end

local function pytrade(inst)
    if GetPlayer().prefab == postInitCharacter then
        inst:AddTag("lolpytrader")
        inst:AddComponent("trader")
        inst.components.trader:SetAcceptTest(function(inst, item)
            return item:HasTag(td1madao_getstr("%sweapon", postInitCharacter))
        end)
        inst.components.trader.onaccept = OnGetItemFromPlayer
        inst.components.trader:Enable()
        if inst.prefab == "researchlab2" then
            inst:ListenForEvent("daytime", function()
                if math.random() <= 0.01 and _G.td1madao_getDistance(GetPlayer(), inst) < 30 then
                    local pt = inst:GetPosition()
                    local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 200, { "td1madao_krampus" })
                    if #ents <= 0 then
                        local creature = nil
                        for i = 4, 50 do
                            creature = nil
                            creature = _G.td1madao_forcespawnAround(inst, _G.td1madao_getstr("%skrampus"), i)
                            if creature then
                                break
                            end
                        end
                        local creature2 = nil
                        creature = TheSim:FindFirstEntityWithTag("td1madao_krampus")
                        if creature then
                            for j = 1, 8 do
                                for i = 3, 22 do
                                    creature2 = _G.td1madao_forcespawnAround(creature, _G.td1madao_getstr("%smonkey"), i)
                                    if creature2 then
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end, _G.GetWorld())
        end
    end
end

AddPrefabPostInit("researchlab", pytrade)
AddPrefabPostInit("researchlab2", pytrade)

local function pigkingDrop(inst, itemName, target)
    if not target then
        target = GetPlayer()
    end
    local nug = _G.td1madao_safespawn(itemName)
    local pt = _G.Vector3(inst.Transform:GetWorldPosition()) + _G.Vector3(0, 4.5, 0)
    nug.Transform:SetPosition(pt:Get())
    local theta = inst:GetAngleToPoint(target.Transform:GetWorldPosition()) * _G.DEGREES * -1
    local sp = _G.td1madao_getDistance(inst, target)
    if nug.Physics then
        nug.Physics:SetVel(sp * math.cos(theta), math.random() * 2, sp * math.sin(theta))
    end
    return nug
end

local otherItem = {
    "poop"
}
local gp = _G.td1madao_getstr('%sgunpowder')
table.insert(otherItem, gp)
local function pigkingDropOrAttack(inst, isTrade, target, item)
    inst.AnimState:PlayAnimation("cointoss")
    inst.AnimState:PushAnimation("happy")
    inst.AnimState:PushAnimation("idle", true)
    inst:DoTaskInTime(20 / 30, function()
        inst.SoundEmitter:PlaySound("dontstarve/pig/PigKingThrowGold")
        if isTrade and item and item.components.tradable then
            if _G.LOLPIGKING and math.random() < 0.3 then
                _G.td1madao_randomTalk(inst, _G.LOLPIGKING)
            end
            for k = 1, item.components.tradable.goldvalue do
                pigkingDrop(inst, "goldnugget", target)
                if math.random() < 0.25 then
                    local nug = pigkingDrop(inst, otherItem[math.random(#otherItem)], target)
                    if nug and nug.components.explosive and nug.components.explosive.OnIgnite then
                        nug.components.explosive:OnIgnite()
                    end
                    if nug and nug.components.burnable and nug.components.burnable.Ignite then
                        nug.components.burnable:Ignite()
                    end
                end
            end
        else
            _G.td1madao_randomTalk(inst, _G.LOLPIGKINGATTACK)
            local nug = pigkingDrop(inst, _G.td1madao_getstr('%sgunpowder'), target)
            if not target.pigkingDropTime then
                target.pigkingDropTime = 0
            end
            target.pigkingDropTime = target.pigkingDropTime + 1
            if nug.components.explosive and nug.components.explosive.OnIgnite then
                nug.components.explosive:OnIgnite()
            end
            if nug.components.burnable and nug.components.burnable.Ignite then
                nug.components.burnable:Ignite()
            end
        end
    end)
    inst:DoTaskInTime(1.5, function()
        inst.SoundEmitter:PlaySound("dontstarve/pig/PigKingHappy")
    end)
    inst.happy = true
    if inst.endhappytask then
        inst.endhappytask:Cancel()
    end
    inst.endhappytask = inst:DoTaskInTime(5, function()
        inst.happy = false
        inst.endhappytask = nil
    end)
end

AddPrefabPostInit("pigking", function(inst)
    local sy_name = _G.td1madao_getstr('%s_sy')
    if GetPlayer().prefab == postInitCharacter and TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER')] ~= 0 then
        inst:AddComponent("talker")
        inst:AddComponent("combat")
        inst:AddComponent("health")
        inst:AddTag("largecreature")
        inst:AddTag("pig")
        inst:AddTag("td1madao_special")
        inst.components.combat:SetDefaultDamage(1)
        inst.components.health:SetMaxHealth(65535)
        inst.components.health:SetInvincible(true)
        inst.components.combat.canbeattackedfn = function()
            return false
        end
        inst.components.trader.onaccept = function(inst, giver, item)
            if math.random() <= 0.01 then
                inst:DoTaskInTime(8, function()
                    _G.td1madao_deployBelow(inst, _G.td1madao_getstr('%spigking'))
                    local rmp = _G.td1madao_getrandomposition()
                    inst.Transform:SetPosition(rmp.x, 0, rmp.z)
                end)
            else
                if item.components.tradable.goldvalue > 0 then
                    inst.components.combat.target = nil
                    pigkingDropOrAttack(inst, true, GetPlayer(), item)
                end
            end
        end
        inst:AddComponent("fueled")
        inst.components.fueled.maxfuel = 65535
        inst.components.fueled.sections = 65535
        inst.components.fueled.currentfuel = 65535
        if _G.Prefabs[sy_name] then
            inst:AddComponent("spawner")
            inst.components.spawner:SetOnlySpawnOffscreen(true)
            inst.components.spawner:Configure(sy_name, TUNING.TOTAL_DAY_TIME * 5)
        end
        inst:AddComponent("td1madao_perioder_prefab")
        _G.td1madao_prefabResponse(inst, TUNING.LOLMEMBER.TALK95, function()
            inst.SoundEmitter:PlaySound("dontstarve/pig/PigKingReject")
            inst.AnimState:PlayAnimation("unimpressed")
            inst.AnimState:PushAnimation("idle", true)
            inst.happy = false
        end)
        inst.components.td1madao_perioder_prefab:addTask("td1madaoPigkingAttack", function()
            local target = inst.components.combat.target
            if target and target:HasTag("pig") then
                inst.components.combat.target = nil
                target = nil
            end
            if not target then
                return
            end
            local distance = _G.td1madao_getDistance(inst, target)
            if distance > 20 then
                target.pigkingDropTime = 0
                inst.components.combat.target = nil
            elseif distance < 15 and target then
                if not target.pigkingDropTime then
                    target.pigkingDropTime = 0
                end
                if target.pigkingDropTime > 6 then
                    target.pigkingDropTime = 0
                    inst.components.combat.target = nil
                else
                    pigkingDropOrAttack(inst, false, target)
                end
            end
        end, 2)
        inst.components.td1madao_perioder_prefab:addTask("td1madaoPigkingTalk", function()
            if not inst.components.combat.target then
                _G.td1madao_randomTalk(inst, _G.LOLPIGKING)
            end
        end, 6)
    end
end)

local mos_structure = {
    "cookpot",
    "icebox"
}

local function ReturnChildren(inst)
    for k, child in pairs(inst.components.childspawner.childrenoutside) do
        if child.components.homeseeker then
            child.components.homeseeker:GoHome()
        end
        child:PushEvent("gohome")
    end
end

local function mos_structuretMethod(inst)
    if GetPlayer().prefab == postInitCharacter and TUNING[_G.td1madao_getupper('%s_ENOMOUS_MONSTER')] ~= 0 and math.random() < 0.3 then
        inst:AddComponent("childspawner")
        inst.components.childspawner:SetRegenPeriod(TUNING.POND_REGEN_TIME)
        inst.components.childspawner:SetSpawnPeriod(TUNING.POND_SPAWN_TIME)
        inst.components.childspawner:SetMaxChildren(1)
        inst.components.childspawner:StartRegen()
        inst.components.childspawner.childname = "mosquito"
        inst.components.childspawner:SetRareChild("killerbee", 0.2)
        inst:ListenForEvent("dusktime", function()
            inst.components.childspawner:StartSpawning()
        end, _G.GetWorld())
        inst:ListenForEvent("daytime", function()
            ReturnChildren(inst)
            inst.components.childspawner:StopSpawning()
            ReturnChildren(inst)
        end, _G.GetWorld())
    end
end

for i = 1, #mos_structure do
    if mos_structure[i] then
        AddPrefabPostInit(mos_structure[i], mos_structuretMethod)
    end
end

local function onequippoop(inst, owner, fname_override)
    if owner.specialhat then
        owner.AnimState:OverrideSymbol("swap_hat", td1madao_getstr("%shat_poop", postInitCharacter), "swap_hat" .. math.random(7))
    else
        owner.AnimState:OverrideSymbol("swap_hat", td1madao_getstr("%shat_poop", postInitCharacter), "swap_hat")
    end
    owner.AnimState:Show("HAT")
    owner.AnimState:Show("HAT_HAIR")
    owner.AnimState:Hide("HAIR_NOHAT")
    owner.AnimState:Hide("HAIR")
    if owner:HasTag("player") then
        owner.AnimState:Hide("HEAD")
        owner.AnimState:Show("HEAD_HAIR")
    end
end

local function onunequippoop(inst, owner)
    owner.AnimState:Hide("HAT")
    owner.AnimState:Hide("HAT_HAIR")
    owner.AnimState:Show("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")
    if owner:HasTag("player") then
        owner.AnimState:Show("HEAD")
        owner.AnimState:Hide("HEAD_HAIR")
    end
end


AddPrefabPostInit("nightlight", function(inst)
    if GetPlayer().prefab == postInitCharacter then
        inst:AddComponent("childspawner")
        inst.components.childspawner.childname = TUNING[td1madao_getupper('%sBELONGNAME')]
        inst.components.childspawner.spawnoffscreen = false
        inst.belongtowhich = TUNING[td1madao_getupper('%sBELONG')]
        inst.components.childspawner:SetRegenPeriod(TUNING.SEG_TIME * 16)
        inst.components.childspawner:SetSpawnPeriod(TUNING.SEG_TIME * 4)
        inst.components.childspawner:SetMaxChildren(1)
        inst.components.childspawner:StartSpawning()
    end
end)

AddPrefabPostInit("poop", function(inst)
    if GetPlayer().prefab == postInitCharacter then
        inst:AddComponent("tradable")
        inst:AddComponent("equippable")
        inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
        inst.components.equippable:SetOnEquip(onequippoop)
        inst.components.equippable:SetOnUnequip(onunequippoop)
    end
end)

AddPrefabPostInit("minotaurchest", function(inst)
    if GetPlayer().prefab == postInitCharacter and inst then
        if inst.components.container then
            inst.components.container:DropEverything()
        end
        _G.td1madao_safeRemoveAfter(inst, 30)
    end
end)
local poopCreature = {
    "pigman",
    "merm",
    "bunnyman",
    "wildbore",
    "perd",
    "primeape",
    "monkey",
}

local poopHatMethod = function(inst)
    local ran = math.random()
    local item = nil
    if inst and inst.components.inventory then
        item = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    end
    if inst and ran < 0.5 and not item and GetPlayer() and GetPlayer().prefab == postInitCharacter then
        inst.components.inventory:Equip(td1madao_safespawn("poop"))
        inst.AnimState:Show("hat")
    end
end

for i = 1, #poopCreature do
    if poopCreature[i] then
        AddPrefabPostInit(poopCreature[i], poopHatMethod)
    end
end

-- back pack slot
AddClassPostConstruct("screens/playerhud", function(self)
    local oldfn = self.SetMainCharacter
    if GetPlayer().prefab == postInitCharacter and not _G.EQUIPSLOTS.BACK and not _G.EQUIPSLOTS.NECK and not _G.EQUIPSLOTS.PACK then
        function self:SetMainCharacter(maincharacter)
            oldfn(self, maincharacter)
            self.controls.inv:AddEquipSlot(_G.EQUIPSLOTS[td1madao_getupper('BACK%s')], td1madao_getstr("images/newslots%s.xml", postInitCharacter), "back.tex")
            self.controls.inv.bg:SetScale(1.2, 1, 1.2)
            local bp = maincharacter.components.inventory:GetEquippedItem(_G.EQUIPSLOTS[td1madao_getupper('BACK%s')])
            if bp and bp.components.container then
                bp.components.container:Close()
                bp.components.container:Open(maincharacter)
            end
        end
    end
end)

AddComponentPostInit("inventory", function(component, inst)
    if GetPlayer().prefab == postInitCharacter and not _G.EQUIPSLOTS.BACK and not _G.EQUIPSLOTS.NECK and not _G.EQUIPSLOTS.PACK then
        inst.components.inventory.numequipslots = 4
    end
end)

AddClassPostConstruct("widgets/itemtile", function(self, invitem)
    function self:UpdateTooltip()
        local str = self:GetDescriptionString()
        self:SetTooltip(str)
        if self.item then
            self.item:DoTaskInTime(0.1, function()
                local player = GetPlayer()
                if not self.SetTooltipColour then return end
                if self.item and player and player.prefab == postInitCharacter then
                    if self.item.confused == nil then
                        self.item.confused = 1
                    end
                    if self.item.despair == nil then
                        self.item.despair = 1
                    end
                    if self.item.jealous == nil then
                        self.item.jealous = 1
                    end
                    if self.item.hatred == nil then
                        self.item.hatred = 1
                    end
                    self.item.td1madao_flush_quality = function()
                        if self.SetTooltipColour then
                            self:SetTooltipColour(self.item.confused, self.item.despair, self.item.jealous, self.item.hatred)
                        end
                    end
                    self.item.td1madao_flush_quality()
                end
            end)
        end
    end
end)

AddPrefabPostInitAny(function(inst)
    local player = GetPlayer()
    if inst and inst:HasTag("structure") and not inst:HasTag("td1madao_special") and not inst.components.td1madao_build_color then
        inst:AddComponent("td1madao_build_color")
    end
    if _G.td1madao_creatureCanMutate(inst) then
        if not inst.components[td1madao_getstr('%s_enomous_monster')] then
            inst:AddComponent(td1madao_getstr('%s_enomous_monster'))
        end
    elseif inst:HasTag("wall") and player and player.prefab == postInitCharacter then
        _G.td1madao_makeWallJumpable(inst)
    elseif player and player.prefab == postInitCharacter and inst and inst.components.armor and inst.components.armor.absorb_percent and _G.TUNING.ARMORWOOD_ABSORPTION == 0.8 and not inst.components.armor.alreadyweaken then
        _G.td1madao_weakenArmor(inst)
    elseif player and player.prefab == postInitCharacter and inst and inst.components.container
            and inst.components.equippable and inst.components.inventoryitem and not _G.EQUIPSLOTS.BACK and not _G.EQUIPSLOTS.NECK and not _G.EQUIPSLOTS.PACK then
        inst.components.equippable.equipslot = _G.EQUIPSLOTS[td1madao_getupper('BACK%s')]
    elseif player and player.prefab == postInitCharacter and inst.components.workable and inst:HasTag("tree")
            and not inst:HasTag("stump") and inst.components.workable.SetOnWorkCallback and inst.components.workable.action == ACTIONS.CHOP then
        _G.td1madao_createEnemyFromTree(inst)
    elseif player and player.prefab == postInitCharacter and inst.components.workable and
            inst.components.container and inst.components.lootdropper and inst:HasTag("structure") then
        _G.td1madao_createEnemyFromChest(inst)
    elseif player and player.prefab == postInitCharacter and
            (inst.prefab == 'berrybush' or inst.prefab == 'berrybush2' or inst.prefab == 'dug_coffeebush') and inst.components.pickable then
        _G.td1madao_createEnemyFromBerry(inst)
    end
    if player and player.prefab == postInitCharacter and inst and not _G.td1madao_qualityInit(inst) then
        if inst then
            if _G.td1madao_getPrize2(inst) >= 7000 then
                _G.td1madao_initQualityAttr(inst, { 0.4, 0.4, 0.4, 1 })
            elseif _G.td1madao_getPrize2(inst) >= 5000 then
                _G.td1madao_initQualityAttr(inst, { 1, 1, 0, 1 })
            elseif _G.td1madao_getPrize2(inst) >= 1000 then
                _G.td1madao_initQualityAttr(inst, { 1, 0, 1, 1 })
            elseif _G.td1madao_getPrize2(inst) >= 500 then
                _G.td1madao_initQualityAttr(inst, { 0, 1, 0, 1 })
            elseif _G.td1madao_getPrize2(inst) >= 200 then
                _G.td1madao_initQualityAttr(inst, { 0, 1, 1, 1 })
            end
            if inst.td1madao_flush_quality then
                inst.td1madao_flush_quality()
            end
        end
    end
end)