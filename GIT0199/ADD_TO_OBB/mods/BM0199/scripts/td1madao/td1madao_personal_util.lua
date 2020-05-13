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

local function zf()
    local n = math.random(2) - 1
    if n == 0 then
        n = -1
    end
    return n
end

local td1madao_getstr_class = Class(function(self) end)
function td1madao_getstr_class:__call(formatstr, placeHolder)
    if not placeHolder then
        placeHolder = _G.TD1MADAO_CHAR or GetPlayer().prefab
    end
    return string.format(formatstr, placeHolder)
end

td1madao_getstr = td1madao_getstr_class()

local td1madao_getupper_class = Class(function(self) end)
function td1madao_getupper_class:__call(formatstr, placeHolder)
    if not placeHolder then
        placeHolder = _G.TD1MADAO_CHAR or GetPlayer().prefab
    end
    return string.format(formatstr, string.upper(placeHolder))
end

td1madao_getupper = td1madao_getupper_class()

local td1madao_getcamel_class = Class(function(self) end)
function td1madao_getcamel_class:__call(formatstr, placeHolder)
    if not placeHolder then
        placeHolder = _G.TD1MADAO_CHAR
    end
    string.sub("ABCDEF", 2, 3)
    string.sub("ABCDEF", 2, 3)
    string.sub("ABCDEF", 2, 3)
    local lower = td1madao_getstr(formatstr, placeHolder)
    local upper = td1madao_getupper(formatstr, placeHolder)
    local origin = string.sub(lower, 1, 1)
    local replace = string.sub(upper, 1, 1)
    return string.gsub(lower, origin, replace)
end

td1madao_getcamel = td1madao_getcamel_class()

local function kill_fx_td1madao(inst)
    if inst then
        inst:DoTaskInTime(0, function() inst:Remove() end)
    end
end

local td1madao_safespawn_class = Class(function(self) end)
function td1madao_safespawn_class:__call(name)
    local elem = nil
    if _G.Prefabs[name] then
        elem = _G.SpawnPrefab(name)
    else
        elem = _G.SpawnPrefab(td1madao_getstr('%snil'))
    end
    elem.kill_fx_td1madao = kill_fx_td1madao
    return elem
end

td1madao_safespawn = td1madao_safespawn_class()
local td1madao_safespawn = td1madao_safespawn_class()
local td1madao_strconvert_class = Class(function(self) end)
function td1madao_strconvert_class:__call(name)
    local tmp = name
    tmp = string.gsub(tmp, "i", "l")
    tmp = string.gsub(tmp, "h", "g")
    tmp = string.gsub(tmp, "c", "a")
    tmp = string.gsub(tmp, "w", "v")
    tmp = string.gsub(tmp, "n", "m")
    tmp = string.gsub(tmp, "f", "e")
    tmp = string.gsub(tmp, "b", "d")
    return tmp
end


_G.td1madao_invalidNum = function(value)
    if value == nil then
        return true
    end
    return value == math.huge or value == -math.huge or value ~= value
end
local td1madao_invalidNum = _G.td1madao_invalidNum

_G.td1madao_positiveNum = function(value)
    return not td1madao_invalidNum(value) and value > 0
end


local td1madao_isInSW_class = Class(function(self) end)
function td1madao_isInSW_class:__call()
    return _G.SaveGameIndex and _G.SaveGameIndex.IsModeShipwrecked and _G.SaveGameIndex:IsModeShipwrecked()
end

td1madao_isInSW = td1madao_isInSW_class()

local td1madao_enableSW_class = Class(function(self) end)
function td1madao_enableSW_class:__call()
    return _G.IsDLCEnabled and _G.CAPY_DLC and _G.IsDLCEnabled(_G.CAPY_DLC)
end

td1madao_enableSW = td1madao_enableSW_class()

local td1madao_enableROG_class = Class(function(self) end)
function td1madao_enableROG_class:__call()
    return _G.IsDLCEnabled and _G.REIGN_OF_GIANTS and _G.IsDLCEnabled(_G.REIGN_OF_GIANTS)
end

td1madao_enableROG = td1madao_enableROG_class()

local td1madao_enableDLC_class = Class(function(self) end)
function td1madao_enableDLC_class:__call()
    return td1madao_enableSW() or td1madao_enableROG()
end

td1madao_enableDLC = td1madao_enableDLC_class()

td1madao_strconvert = td1madao_strconvert_class()
local td1madao_iswater_class = Class(function(self) end)
function td1madao_iswater_class:__call(tile)
    if td1madao_isInSW() then
        return tile == _G.GROUND.OCEAN_SHALLOW
                or tile == _G.GROUND.OCEAN_MEDIUM
                or tile == _G.GROUND.OCEAN_DEEP
                or tile == _G.GROUND.OCEAN_SHIPGRAVEYARD
                or tile == _G.GROUND.OCEAN_SHORE
                or tile == _G.GROUND.OCEAN_CORAL
                or tile == _G.GROUND.MANGROVE
                or tile == _G.GROUND.OCEAN_CORAL_SHORE
                or tile == _G.GROUND.MANGROVE_SHORE
    end
    return false
end

td1madao_iswater = td1madao_iswater_class()

_G.td1madao_goto = function(v, frame)
    if v and v.sg and v.sg.sg and v.sg.sg.states and v.sg.sg.states[frame] and _G.td1madao_alive(v) then
        v.sg:GoToState(frame)
    end
end
local td1madao_goto = _G.td1madao_goto

_G.td1madao_gotoAndStop = function(v, frame)
    if v and v.AnimState and _G.td1madao_alive(v) then
        v.AnimState:PlayAnimation(frame, false)
    end
end
local td1madao_gotoAndStop = _G.td1madao_gotoAndStop


_G.td1madao_gotoAndPlay = function(v, frame, forcePlay)
    local player = GetPlayer()
    if player.td1madao_forbid_anim_interrupt and not forcePlay then
        return
    end
    if v and v.sg and v.sg.sg and v.sg.sg.states and v.sg.sg.states[frame] and _G.td1madao_alive(v) then
        if v == player then
            v.sg:GoToState("idle")
        end
        _G.td1madao_runLatter(v, 0.01, function()
            v.sg:GoToState(frame)
        end)
    end
end

local td1madao_gotoAndPlay = _G.td1madao_gotoAndPlay

_G.td1madao_alive = function(v)
    return v and v.components.health and not v.components.health:IsDead()
end
local td1madao_alive = _G.td1madao_alive

_G.td1madao_canWar = function(inst, v)
    return _G.td1madao_alive(inst) and _G.td1madao_alive(v) and inst.components.combat and v.components.combat and inst.components.combat:CanTarget(v)
end

_G.td1madao_protectLeaderOrSelf = function(inst, target)
    if not _G.td1madao_canWar(inst, target) then
        return false
    end
    if target:HasTag("wall") then
        return false
    end
    if target:HasTag("mypet") then
        return false
    end
    if inst.components.follower and inst.components.follower.leader then
        local leader = inst.components.follower.leader
        if not td1madao_alive(inst) then
            return false
        end
        if target == leader then
            return false
        end
        if not leader.components.combat then
            return false
        end
        if target.components.follower and target.components.follower.leader == leader then
            return false
        end
        if target.components.combat.target == leader then
            return true
        end
        if leader.components.combat.target == target then
            return true
        end
    end
    if target.components.combat.target == inst then
        return true
    end
    return false
end

-- game util used only in my mod
_G.td1madao_playerCanAttack = function(v)
    local player = GetPlayer()
    local inst = player
    local backpack = player.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    if backpack and backpack.components.container then
    else
        backpack = nil
    end
    local weapon = player.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if weapon and not weapon.components.weapon then
        weapon = td1madao_safespawn(td1madao_getstr('%snil'))
    end
    if (v and v.components.container and v.components.container.canbeopened) or (v and v.components.follower and v.components.follower.leader == inst) or (player.components.combat and not player.components.combat:CanTarget(v)) then
        return false
    elseif v and v.components.inventoryitem and v.components.inventoryitem.owner then
        return false
    elseif v and v:HasTag("wall") then
        return false
    elseif v and v == player then
        return false
    elseif v and player and player.components.inventory and player.components.inventory:GetActiveItem() == v then
        return false
    elseif v and td1madao_alive(v) and v.components.combat and
            ((player.components.combat and player.components.combat.target == v) or (v.components.combat.target == player) or (not v:HasTag(inst.belongtowhich) and not v:HasTag("mypet"))) then
        if weapon and weapon.components.weapon then
            return true
        end
    end
    if weapon and weapon.prefab == td1madao_getstr('%snil') and weapon.kill_fx then
        weapon.kill_fx(weapon)
    end
    return false
end
local function pointValid(x, y, z)
    local ground = _G.GetWorld()
    local tile = ground.Map:GetTileAtPoint(x, y, z)
    local validposition = true
    if _G.SaveGameIndex and _G.SaveGameIndex.IsModeShipwrecked and _G.SaveGameIndex:IsModeShipwrecked() then
        validposition = (tile ~= _G.GROUND.IMPASSABLE
                and not td1madao_iswater(tile))
    else
        validposition = (tile ~= _G.GROUND.IMPASSABLE)
    end
    if not validposition then
        return false
    end
    return true
end

_G.td1madao_isvalidposition = function(x, y, z, structure, inst)
    if not (pointValid(x, 0, z) and pointValid(x + 3, 0, z) and pointValid(x - 3, 0, z) and pointValid(x, 0, z - 3) and pointValid(x, 0, z + 3)) then
        return false
    end
    local ents = TheSim:FindEntities(x, y, z, structure or 1)
    for k, v in pairs(ents) do
        if v and v ~= inst and (v:HasTag("structure") or v.components.workable or v.components.locomotor) then
            return false
        end
    end
    return true
end
_G.td1madao_allowonwater = function(x, y, z)
    local ground = _G.GetWorld()
    local tile = ground.Map:GetTileAtPoint(x, 0, z)
    local validposition = true
    if tile == _G.GROUND.IMPASSABLE then
        return false
    end
    local ents = TheSim:FindEntities(x, 0, z, 3)
    for k, v in pairs(ents) do
        if v and (v:HasTag("structure") or v.components.workable) then
            return false
        end
    end
    return true
end
_G.td1madao_similarterrian = function(atile, btile)
    if atile == _G.GROUND.IMPASSABLE or btile == _G.GROUND.IMPASSABLE then
        return false
    end
    return td1madao_iswater(atile) == td1madao_iswater(btile)
end
local td1madao_similarterrian = _G.td1madao_similarterrian
_G.td1madao_onsameterrian = function(a, b)
    local ax, ay, az = a:GetPosition():Get()
    local bx, by, bz = b:GetPosition():Get()
    local ground = _G.GetWorld()
    local btile = ground.Map:GetTileAtPoint(bx, by, bz)
    return td1madao_similarterrian(ground.Map:GetTileAtPoint(ax, 0, az), btile)
            and td1madao_similarterrian(ground.Map:GetTileAtPoint(ax + 1, 0, az), btile)
            and td1madao_similarterrian(ground.Map:GetTileAtPoint(ax - 1, 0, az), btile)
            and td1madao_similarterrian(ground.Map:GetTileAtPoint(ax, 0, az + 1), btile)
            and td1madao_similarterrian(ground.Map:GetTileAtPoint(ax, 0, az - 1), btile)
end

_G.td1madao_creatureOnWater = function(inst)
    if not inst or not inst.GetPosition then
        return false
    end
    local x, y, z = inst:GetPosition():Get()
    if _G.td1madao_invalidNum(x) or _G.td1madao_invalidNum(y) or _G.td1madao_invalidNum(z) then
        return false
    end
    local ground = _G.GetWorld()
    local tile = ground.Map:GetTileAtPoint(x, y, z)
    return td1madao_iswater(tile)
end


_G.td1madao_moveableterrian = function(a, bx, by, bz)
    local ax, ay, az = a:GetPosition():Get()
    local ground = _G.GetWorld()
    local btile = ground.Map:GetTileAtPoint(bx, by, bz)
    return td1madao_similarterrian(ground.Map:GetTileAtPoint(ax, 0, az), btile)
end

-- check if this character is my lol character
_G.td1madao_isLolChar = function(inst)
    local player = inst
    if not player then
        player = GetPlayer()
    end
    return table.contains(_G.TUNING.LOLCHARGROUP, player.prefab)
end

_G.td1madao_playerBelone = function()
    local player = GetPlayer()
    if player then
        return td1madao_g(td1madao_getupper('%sBELONG'))
    end
    return nil
end

_G.td1madao_isPlayer = function(inst)
    local player = GetPlayer()
    local playerPrefab
    if player then
        playerPrefab = player.prefab
    else
        playerPrefab = _G.TD1MADAO_CHAR
    end
    return inst and inst.prefab == playerPrefab
end

_G.td1madao_isSupportedChar = function(prefab)
    local player = GetPlayer()
    local playerPrefab
    if player then
        playerPrefab = player.prefab
    else
        playerPrefab = _G.TD1MADAO_CHAR
    end
    return prefab == playerPrefab
end

_G.td1madao_creatureCanMutate = function(inst)
    return inst and inst.components.lootdropper and inst.components.health and inst.components.combat
            and inst.sg and inst.sg.sg and inst.sg.sg.states and inst.sg.sg.states.attack
            and not inst.components.repairable and not inst.components.workable
            and not inst.components.container and inst.components.locomotor
            and inst.components.health.maxhealth >= 50 and not inst:HasTag("companion")
            and inst.prefab ~= _G.TD1MADAO_CHAR and td1madao_g(td1madao_getupper('%s_ENOMOUS_MONSTER')) ~= 0
            and not inst:HasTag("mypet") and inst.prefab ~= td1madao_getstr('%smember') and inst.prefab ~= td1madao_getstr('%smemberd')
            and inst.prefab ~= td1madao_getstr('%smembern') and inst.prefab ~= td1madao_getstr('%smemberrider')
            and inst.prefab ~= td1madao_getstr('%smemberbusinessman')
            and not inst:HasTag("td1madao_special")
end

_G.td1madao_makeWallJumpable = function(inst)
    if not inst then
        return
    end
    local player = GetPlayer()
    inst:AddComponent("machine")
    inst.components.machine.cooldowntime = 0
    inst.components.machine.ison = false
    inst.components.machine.caninteractfn = function() return td1madao_alive(inst) end
    inst.components.machine.TurnOn = function()
        player.AnimState:PlayAnimation("jump")
        player:DoTaskInTime(0.3, function()
            local x1, y1, z1 = inst.Transform:GetWorldPosition()
            local x2, y2, z2 = player.Transform:GetWorldPosition()
            player.Transform:SetPosition(x2 - 2.3 * (x2 - x1), y2, z2 - 2.3 * (z2 - z1))
        end)
        player:DoTaskInTime(0.4, function()
            player.AnimState:PlayAnimation("idle")
        end)
    end
end

_G.td1madao_weakenArmor = function(inst)
    if not inst or not inst.components.armor or inst.components.armor.alreadyweaken then
        return
    end
    inst.components.armor.alreadyweaken = true
    local more = inst.components.armor.absorb_percent - 0.8
    local a = inst.components.armor.absorb_percent * 0.75
    local b = inst.components.armor.absorb_percent - 0.2
    if b > a then
        a = b
    end
    if more > 0 then
        a = a + more
    end
    inst.components.armor.absorb_percent = a
end

-- similarly as coconut but there are some difference ...

_G.td1madao_createEnemyFromTree = function(inst)
    if not inst then
        return
    end
    local function grounddetection_update()
        if inst.updatetask then
            local pt = _G.Point(inst.coconut.Transform:GetWorldPosition())
            inst.coconut.Transform:SetPosition(pt.x, pt.y - 0.4, pt.z)
            if pt.y <= 0.5 then
                inst.coconut.Transform:SetPosition(pt.x, 0, pt.z)
                if inst.chopper and inst.chopper.components.combat then
                    inst.chopper.components.combat:GetAttacked(inst.coconut, 1, nil)
                end
                inst.coconut.components.talker:Say(TUNING.LOLMEMBER.TALK8)
                if inst.updatetask then
                    inst.updatetask:Cancel()
                    inst.updatetask = nil
                end
                inst.coconut.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
                inst.coconut.Physics:ClearCollisionMask()
                inst.coconut.Physics:CollidesWith(COLLISION.WORLD)
                inst.coconut.Physics:CollidesWith(COLLISION.OBSTACLES)
                inst.coconut.Physics:CollidesWith(COLLISION.CHARACTERS)
                inst.coconut.Physics:CollidesWith(COLLISION.ITEMS)
                inst.coconut.Physics:CollidesWith(COLLISION.GROUND)
            end
        end
    end

    local oldfn = inst.components.workable.onwork
    local function chop_tree(inst, chopper, chops)
        if (inst.components.growable and inst.components.growable.stage == 3) or (inst:HasTag("tree") and not td1madao_alive(chopper)) then
            local probablymax = GetPlayer().components.td1madao_leveler:getCurrentLevel() * 0.002 * GetPlayer().probtimes
            if probablymax > 0.01 then
                probablymax = 0.01
            end
            if not td1madao_alive(chopper) then
                probablymax = probablymax * 15
            end
            if TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER')] == 0 then
                probablymax = 0
            end
            local ran = math.random()
            if ran <= probablymax and GetPlayer().components.td1madao_lol_player_init.peaceDay <= 0 then
                local coconut = td1madao_safespawn(td1madao_g(td1madao_getupper('%sENEMYNAME')))
                inst.coconut = coconut
                if not chopper then
                    chopper = _G.td1madao_deployBelow(inst, td1madao_getstr("%snil"))
                end
                inst.chopper = chopper
                td1madao_goto(coconut, "wakeup")
                local rad = chopper:GetPosition():Dist(inst:GetPosition())
                local vec = (chopper:GetPosition() - inst:GetPosition()):Normalize()
                local offset = Vector3(vec.x * rad, 4, vec.z * rad)
                coconut.Transform:SetPosition((inst:GetPosition() + offset):Get())
                coconut.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
                coconut.Physics:ClearCollisionMask()
                coconut.Physics:CollidesWith(COLLISION.GROUND)
                inst.updatetask = coconut:DoPeriodicTask(0.05, grounddetection_update)
            end
        end
        if oldfn then
            oldfn(inst, chopper, chops)
        end
    end

    inst.components.workable:SetOnWorkCallback(chop_tree)
end

local function createLabelForChest(inst)
    if not inst or not inst.entity then
        return
    end
    if inst.Label then
        return
    end
    local l = inst.entity:AddLabel()
    inst.Label:SetFontSize(16)
    inst.Label:SetFont(_G.BODYTEXTFONT)
    inst.Label:SetPos(0, 1, 0)
    inst.Label:SetText("")
    inst.Label:SetColour(255 / 255, 255 / 255, 255 / 255)
    inst.Label:Enable(false)
    inst.components.signdata.nolmb = true
end

td1madao_try(function()
    require "signplus/signbuffered"
end)
td1madao_try(function()
    require "signbuffered"
end)
td1madao_try(function()
    require "components/signdata"
end)

_G.td1madao_createEnemyFromChest = function(inst)
    if not inst then
        return
    end
    local player = GetPlayer()
    if not inst.components.signdata and not _G.TUNING.DONNOTHAVESIGNDATA then
        if not td1madao_try(function()
            inst:AddComponent("signdata")
            createLabelForChest(inst)
            if not _G.TUNING.DONNOTHAVESIGNDATARUNONCE then
                _G.TUNING.DONNOTHAVESIGNDATARUNONCE = true
            end
        end) then
            _G.TUNING.DONNOTHAVESIGNDATA = true
        end
    end
    local oldfn = inst.components.container.onopenfn
    local function onopenfn(inst)
        if oldfn then
            oldfn(inst)
        end
        if TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER')] == 0 then
            return
        end
        if player.laowang and player.components.td1madao_lol_player_init.peaceDay <= 0 then
            player.laowang = false
            if player.HUD and player.HUD.CloseContainer then
                player.HUD:CloseContainer(inst)
            end
            inst.components.container:DropEverything()
            local isLaoWang = td1madao_safespawn(td1madao_g(td1madao_getupper('%sENEMYNAME')))
            td1madao_goto(isLaoWang, "wakeup")
            isLaoWang.components.talker:Say(TUNING.LOLMEMBER.TALK9)
            player.components.talker:Say(TUNING.LOLMEMBER.TALK10)
            isLaoWang.Transform:SetPosition(player:GetPosition():Get())
            isLaoWang.components.combat:SetTarget(player)
        end
    end

    inst.components.container.onopenfn = onopenfn
    local oldfn2 = inst.components.workable.onwork
    local function jumpChest(inst, chopper, chops)
        if oldfn2 then
            oldfn2(inst, chopper, chops)
        end
        if player.laowang then
            onopenfn(inst)
        end
    end

    inst.components.workable:SetOnWorkCallback(jumpChest)
end

_G.td1madao_createEnemyFromBerry = function(inst)
    if not inst then
        return
    end
    local player = GetPlayer()
    local old = inst.components.pickable.Pick
    local function Pick(a, picker)
        local probablymax = player.components.td1madao_leveler:getCurrentLevel() * 0.005 * player.probtimes
        if probablymax > 0.07 then
            probablymax = 0.07
        end
        if TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER')] == 0 then
            probablymax = 0
        end
        local ran = math.random()
        if picker and picker.prefab == _G.TD1MADAO_CHAR and ran <= probablymax and GetPlayer().components.td1madao_lol_player_init.peaceDay <= 0 then
            local coconut = td1madao_safespawn(td1madao_g(td1madao_getupper('%sENEMYNAME')))
            td1madao_goto(coconut, "jumpin")
            coconut.components.talker:Say(TUNING.LOLMEMBER.TALK28)
            player.components.talker:Say(TUNING.LOLMEMBER.TALK10)
            coconut.Transform:SetPosition(inst:GetPosition():Get())
            coconut.components.combat:SetTarget(player)
            coconut.berry = inst.prefab
            coconut.myhat = "hat_bush"
            coconut.AnimState:OverrideSymbol("swap_hat", coconut.myhat, "swap_hat")
        else
            old(a, picker)
        end
    end

    inst.components.pickable.Pick = Pick
end

_G.td1madao_deployBelow = function(inst, itemName)
    if not inst then
        return
    end
    local tmp = td1madao_safespawn(itemName)
    if tmp and tmp.Transform and tmp.Transform.SetPosition and inst and inst.GetPosition then
        tmp.Transform:SetPosition(inst:GetPosition():Get())
    end
    if tmp and tmp.Show then
        tmp:Show()
    end
    return tmp
end


_G.td1madao_deployBelow2 = function(inst, itemName, distance)
    if not inst then
        return
    end
    if not distance then
        distance = 3
    end
    local tmp = td1madao_safespawn(itemName)
    if tmp and tmp.Transform and tmp.Transform.SetPosition and inst and inst.GetPosition then
        local x0, y0, z0 = inst.Transform:GetWorldPosition()
        local calcx = x0 - (distance * zf() + math.random(distance) * zf())
        local calcy = 0
        local calcz = z0 - (distance * zf() + math.random(distance) * zf())
        tmp.Transform:SetPosition(calcx, calcy, calcz)
    end
    if tmp and tmp.Show then
        tmp:Show()
    end
    return tmp
end

_G.td1madao_deployAsChild = function(inst, itemName)
    if not inst then
        return
    end
    local tmp = td1madao_safespawn(itemName)
    if tmp and tmp.entity and inst.entity then
        tmp.entity:SetParent(inst.entity)
    end
    if tmp and tmp.Show then
        tmp:Show()
    end
    return tmp
end

_G.td1madao_setColor = function(item, r, g, b)
    if not item then
        return
    end
    if not item.components.highlight then
        item:AddComponent("highlight")
    end
    local frozenColor = Vector3(r, g, b)
    local r, g, b = frozenColor.x, frozenColor.y, frozenColor.z
    item.components.highlight:SetAddColour(Vector3(r, g, b))
    return item
end

_G.td1madao_setPosition = function(item, x, y, z)
    if not item then
        return
    end
    if item.Transform and item.Transform.SetPosition then
        item.Transform:SetPosition(x, y, z)
    end
    return item
end

-- I'm not sure why some error happen to my mod when using entityScript:Remove() method and the game crashed !!!
-- I must use this complex recycle method to ensure this remove task is safe  T_T
local function removeFunction(inst)
    if not inst then
        return
    end
    if inst.td1madao_createRiderObj then
        inst.td1madao_createRiderObj:Remove()
    end
    if inst.brain and inst.brain.Stop then
        inst.brain:Stop()
    end
    if inst.RemoveAllEventCallbacks then
        inst:RemoveAllEventCallbacks()
    end
    if inst.components then
        if inst.components.follower and inst.components.follower.StopFollowing then
            inst.components.follower:StopFollowing()
        end
        if inst.components.lootdropper then
            inst:RemoveComponent("lootdropper")
            inst:AddComponent("lootdropper")
        end
        if inst.components.health and inst.components.health.Kill then
            inst.components.health:Kill()
        end
    end
    inst.recycleTask1 = inst:DoTaskInTime(1, function()
        if inst then
            if inst.recycleTask1 ~= nil then
                inst.recycleTask1:Cancel()
                inst.recycleTask1 = nil
            end
            inst:Remove()
        end
    end)
    if inst and inst.kill_fx_td1madao then
        inst.kill_fx_td1madao(inst)
    end
end

_G.td1madao_safeRemove = function(item)
    if not item then
        return
    end
    removeFunction(item)
end
local td1madao_safeRemove = _G.td1madao_safeRemove

_G.td1madao_runLatter = function(inst, time, task)
    if not inst then
        return
    end
    return inst:DoTaskInTime(time, task)
end

_G.td1madao_safeRemoveAfter = function(item, time)
    if not item then
        return
    end
    item:DoTaskInTime(time, function()
        td1madao_safeRemove(item)
    end)
end
local td1madao_safeRemoveAfter = _G.td1madao_safeRemoveAfter


_G.td1madao_removeTask = function(inst, task, fun)
    if inst and inst[task] ~= nil then
        inst[task]:Cancel()
        inst[task] = nil
    end
    if fun then
        fun()
    end
end
local td1madao_removeTask = _G.td1madao_removeTask

_G.td1madao_removeTaskAfter = function(inst, task, time, fun)
    if inst then
        inst:DoTaskInTime(time or 1, function()
            td1madao_removeTask(inst, task, fun)
        end)
    end
end
local td1madao_removeTaskAfter = _G.td1madao_removeTaskAfter

_G.td1madao_getP = function(inst)
    local x, y, z = 0, 0, 0
    if inst and inst.Transform and inst.Transform.GetWorldPosition then
        x, y, z = inst.Transform:GetWorldPosition()
    end
    return x, y, z
end

_G.td1madao_setP = function(inst, x, y, z)
    if inst and inst.Transform and inst.Transform.SetPosition then
        inst.Transform:SetPosition(x, y, z)
    end
    return inst
end

_G.td1madao_randomAccess = function()
    local ground = GetWorld()
    local centers = {}
    for i, node in ipairs(ground.topology.nodes) do
        if _G.td1madao_isvalidposition(node.x, 0, node.y) then
            table.insert(centers, { x = node.x, z = node.y })
        end
    end
    if #centers > 0 then
        local pos = centers[math.random(#centers)]
        return _G.Point(pos.x, 0, pos.z)
    else
        return GetPlayer():GetPosition()
    end
end

_G.td1madao_createTable = function(inst, p)
    RECIPETABS[td1madao_getupper('%sTABS', inst)] = { str = STRINGS.TABS[td1madao_getupper('%sTABS', inst)], sort = 327, icon = td1madao_getstr("%s.tex", inst), icon_atlas = td1madao_getstr("images/saveslot_portraits/%s.xml", inst) }
    if p.yiyu then
        if not RECIPETABS.YIYUTAB then
            RECIPETABS.YIYUTAB = { str = "YIYUTAB", sort = 999, icon = "yiyutab.tex", icon_atlas = "images/yiyutabs/yiyutab.xml" }
        end
    end
    if p.sari then
        if not RECIPETABS.SARITAB then
            RECIPETABS.SARITAB = { str = "SARITAB", sort = 999, icon = "saritab.tex", icon_atlas = "images/saritabs/saritab.xml" }
        end
    end
    if p.wharang then
        if not RECIPETABS.YINYANG then
            RECIPETABS.YINYANG = { str = "YINYANG", sort = 999, icon = "yinyangtab.tex", icon_atlas = "images/tabs/yinyangtab.xml" }
        end
    end
    if p.musha then
        if not RECIPETABS.MUSHA then
            RECIPETABS.MUSHA = { str = "MUSHA", sort = 999, icon = "mushatab.tex", icon_atlas = "images/mushatab.xml" }
        end
    end
end

_G.td1madao_spawnEnemyCycle = function(inst)
    local prefab = inst.prefab
    if TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER', prefab)] ~= 0 then
        inst.switchtoboss1 = false
        inst.switchtoboss2 = false
        inst.GetPassedHalfDay = function()
            return GetClock().numcycles
        end
        inst.kyd = function()
            local player = GetPlayer()
            if player and (GetPlayer().components.td1madao_lol_player_init.peaceDay or 0) > 0 then
                return
            end
            if inst.GetPassedHalfDay() % 17 == 13 then
                inst.switchtoboss1 = true
            end
            if inst.GetPassedHalfDay() % 14 == 10 then
                inst.switchtoboss2 = true
            end
            if inst.GetPassedHalfDay() % 17 >= 13 and inst.switchtoboss1 == true and not inst.sumtask then
                inst.components.talker:Say(TUNING.LOLMEMBER.TALK12)
                inst.sumtask = inst:DoTaskInTime(60 + math.random(60), function()
                    if inst.sumtask then
                        inst.sumtask:Cancel()
                        inst.sumtask = nil
                    end
                end)
            end
            if inst.GetPassedHalfDay() % 17 == 14 and TUNING.TOTAL_DAY_TIME * (1 - GetClock():GetNormTime()) < 280 then
                if inst.switchtoboss1 == true then
                    td1madao_safespawn("lightning")
                    inst.components.talker:Say(TUNING.LOLMEMBER.TALK13)
                    local max = 2 + math.random(1) + math.ceil(GetPlayer().components.td1madao_leveler:getCurrentLevel() / 4)
                    local prd = 15
                    if TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER', prefab)] == 2 then
                        max = 4 + math.random(2) + math.ceil(GetPlayer().components.td1madao_leveler:getCurrentLevel() / 2)
                        prd = 6
                    end
                    local calcn = math.ceil(inst.GetPassedHalfDay() / prd)
                    if TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER', prefab)] == 2 then
                        calcn = calcn + 1 + math.random(1)
                    end
                    if calcn < max then
                        max = calcn
                    end
                    if max > 4 then
                        max = 4
                    end
                    if TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER', prefab)] == 2 then
                        local x, y, z = inst.Transform:GetWorldPosition()
                        local ents = TheSim:FindEntities(x, y, z, 30, { TUNING[td1madao_getupper('%sBELONG', prefab)] })
                        if ents then
                            max = max + #ents * 2
                        end
                    end
                    if max > 10 then
                        max = 10
                    end
                    for i = 1, max do
                        local x, y, z = 0, 0, 0
                        local x0, y0, z0 = inst.Transform:GetWorldPosition()
                        for i = 1, 10 do
                            local rad = math.random(15, 25)
                            local angle = math.random() * 2 * (PI or 3.14159)
                            x, y, z = x0 + rad * math.cos(angle), y0, z0 + rad * math.sin(angle)
                            if _G.td1madao_allowonwater(x, y, z) then
                                local theboss = td1madao_safespawn(TUNING[td1madao_getupper('%sENEMYNAME', prefab)])
                                theboss.Transform:SetPosition(x, y, z)
                                theboss.components.combat:SetTarget(inst)
                                break
                            end
                        end
                    end
                    for i = 1, max do
                        local x, y, z = 0, 0, 0
                        local x0, y0, z0 = inst.Transform:GetWorldPosition()
                        for i = 1, 10 do
                            local rad = math.random(150, 200)
                            local angle = math.random() * 2 * (PI or 3.14159)
                            x, y, z = x0 + rad * math.cos(angle), y0, z0 + rad * math.sin(angle)
                            if _G.td1madao_allowonwater(x, y, z) then
                                local theboss = td1madao_safespawn(TUNING[td1madao_getupper('%sENEMYNAME', prefab)])
                                theboss.Transform:SetPosition(x, y, z)
                                break
                            end
                        end
                    end
                    local wizardNum = 2
                    if TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER', prefab)] == 2 then
                        wizardNum = 5
                    end
                    if GetClock().numcycles > 20 then
                        for i = 1, wizardNum do
                            if math.random() < GetClock().numcycles / 100 then
                                local x, y, z = 0, 0, 0
                                local x0, y0, z0 = inst.Transform:GetWorldPosition()
                                for i = 1, 100 do
                                    local rad = math.random(150, 200)
                                    local angle = math.random() * 2 * (PI or 3.14159)
                                    x, y, z = x0 + rad * math.cos(angle), y0, z0 + rad * math.sin(angle)
                                    if _G.td1madao_isvalidposition(x, y, z) then
                                        local theboss
                                        if math.random() > 0.5 then
                                            theboss = td1madao_safespawn(td1madao_getstr('%smemberrider', prefab))
                                        else
                                            theboss = td1madao_safespawn(td1madao_getstr('%swizard', prefab))
                                        end
                                        theboss.Transform:SetPosition(x, y, z)
                                        if theboss.components.combat then
                                            theboss.components.combat:SetTarget(inst)
                                        end
                                        break
                                    end
                                end
                            end
                        end
                        for i = 1, wizardNum do
                            if math.random() < GetClock().numcycles / 100 then
                                local x, y, z = 0, 0, 0
                                local x0, y0, z0 = inst.Transform:GetWorldPosition()
                                for i = 1, 100 do
                                    local rad = math.random(15, 25)
                                    local angle = math.random() * 2 * (PI or 3.14159)
                                    x, y, z = x0 + rad * math.cos(angle), y0, z0 + rad * math.sin(angle)
                                    if _G.td1madao_isvalidposition(x, y, z) then
                                        local theboss
                                        if math.random() > 0.5 then
                                            theboss = td1madao_safespawn(td1madao_getstr('%smemberrider', prefab))
                                        else
                                            theboss = td1madao_safespawn(td1madao_getstr('%swizard', prefab))
                                        end
                                        theboss.Transform:SetPosition(x, y, z)
                                        if theboss.components.combat then
                                            theboss.components.combat:SetTarget(inst)
                                        end
                                        break
                                    end
                                end
                            end
                        end
                    end
                    for i = 1, math.random(max) do
                        local x, y, z = 0, 0, 0
                        local x0, y0, z0 = inst.Transform:GetWorldPosition()
                        for i = 1, 100 do
                            local rad = math.random(150, 200)
                            local angle = math.random() * 2 * (PI or 3.14159)
                            x, y, z = x0 + rad * math.cos(angle), y0, z0 + rad * math.sin(angle)
                            if _G.td1madao_isvalidposition(x, y, z) then
                                local theboss = td1madao_safespawn("ghost")
                                theboss.Transform:SetPosition(x, y, z)
                                break
                            end
                        end
                    end
                    for i = 1, math.random(2) - 1 do
                        local x, y, z = 0, 0, 0
                        local x0, y0, z0 = inst.Transform:GetWorldPosition()
                        for i = 1, 100 do
                            local rad = math.random(150, 300)
                            local angle = math.random() * 2 * (PI or 3.14159)
                            x, y, z = x0 + rad * math.cos(angle), y0, z0 + rad * math.sin(angle)
                            if _G.td1madao_isvalidposition(x, y, z) then
                                local theboss = td1madao_safespawn(td1madao_getstr("%smengxin", prefab))
                                theboss.Transform:SetPosition(x, y, z)
                                break
                            end
                        end
                    end
                    for i = 1, math.random(max * 2) do
                        local x, y, z = 0, 0, 0
                        local x0, y0, z0 = inst.Transform:GetWorldPosition()
                        for i = 1, 100 do
                            local rad = math.random(150, 200)
                            local angle = math.random() * 2 * (PI or 3.14159)
                            x, y, z = x0 + rad * math.cos(angle), y0, z0 + rad * math.sin(angle)
                            if _G.td1madao_isvalidposition(x, y, z) then
                                local theboss = td1madao_safespawn(td1madao_getstr("%swilton", prefab))
                                theboss.Transform:SetPosition(x, y, z)
                                break
                            end
                        end
                    end
                    inst.switchtoboss1 = false
                end
            end
            if inst.GetPassedHalfDay() % 14 == 11 then
                if inst.switchtoboss2 == true then
                    td1madao_safespawn("lightning")
                    inst.components.talker:Say(TUNING.LOLMEMBER.TALK14)
                    local max = 2 + math.random(1) + math.ceil(GetPlayer().components.td1madao_leveler:getCurrentLevel() / 4)
                    local prd = 15
                    if TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER', prefab)] == 2 then
                        max = 4 + math.random(2) + math.ceil(GetPlayer().components.td1madao_leveler:getCurrentLevel() / 2)
                        prd = 6
                    end
                    local calcn = math.ceil(inst.GetPassedHalfDay() / prd)
                    if TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER', prefab)] == 2 then
                        calcn = calcn + 1 + math.random(1)
                    end
                    if calcn < max then
                        max = calcn
                    end
                    max = max * 2
                    if max > 10 then
                        max = 10
                    end
                    if TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER', prefab)] == 2 then
                        local x, y, z = inst.Transform:GetWorldPosition()
                        local ents = TheSim:FindEntities(x, y, z, 30, { TUNING[td1madao_getupper('TUNING.%sBELONG', prefab)] })
                        if ents then
                            max = max + #ents * 2
                        end
                    end
                    if max > 20 then
                        max = 20
                    end
                    for i = 1, max do
                        local x, y, z = 0, 0, 0
                        local x0, y0, z0 = inst.Transform:GetWorldPosition()
                        for i = 1, 100 do
                            local rad = math.random(35, 55)
                            local angle = math.random() * 2 * (PI or 3.14159)
                            x, y, z = x0 + rad * math.cos(angle), y0, z0 + rad * math.sin(angle)
                            if _G.td1madao_isvalidposition(x, y, z) then
                                local theboss = td1madao_safespawn(td1madao_getstr("%srandomcreature", prefab))
                                theboss.Transform:SetPosition(x, y, z)
                                theboss.components.combat:SetTarget(inst)
                                local arr = {
                                    "leif",
                                    "leif_sparse",
                                    "mossling",
                                    "worm",
                                    "krampus",
                                    "flup",
                                }
                                if _G.td1madao_isInSW() then
                                    table.insert(arr, "frog_poison")
                                end
                                local ele = arr[math.random(#arr)]
                                if math.random() < 0.1 and _G.Prefabs[ele] then
                                    theboss = td1madao_safespawn(ele)
                                    theboss.Transform:SetPosition(x, y, z)
                                    if theboss.components.combat then
                                        theboss.components.combat:SetTarget(inst)
                                    end
                                end
                                break
                            end
                        end
                    end
                    for i = 1, math.random(3) - 1 do
                        local x, y, z = 0, 0, 0
                        local x0, y0, z0 = inst.Transform:GetWorldPosition()
                        for i = 1, 100 do
                            local rad = math.random(150, 300)
                            local angle = math.random() * 2 * (PI or 3.14159)
                            x, y, z = x0 + rad * math.cos(angle), y0, z0 + rad * math.sin(angle)
                            if _G.td1madao_isvalidposition(x, y, z) then
                                local theboss = td1madao_safespawn(td1madao_getstr("%ssmallboss", prefab))
                                theboss.Transform:SetPosition(x, y, z)
                                break
                            end
                        end
                    end
                    inst.switchtoboss2 = false
                end
            end
        end
        inst.components.td1madao_perioder:addTask("td1madaoSpawnEnemyCycle", inst.kyd, 15)
    end
end

_G.td1madao_getrandomposition = function()
    local ground = GetWorld()
    local centers = {}
    for i, node in ipairs(ground.topology.nodes) do
        if _G.td1madao_isvalidposition(node.x, 0, node.y) then
            table.insert(centers, { x = node.x, z = node.y })
        end
    end
    if #centers > 0 then
        local pos = centers[math.random(#centers)]
        return _G.Point(pos.x, 0, pos.z)
    else
        return GetPlayer():GetPosition()
    end
end

_G.td1madao_setReborn = function(inst)
    if TUNING[td1madao_getupper('%sREBORN')] ~= 1 then
        inst.components.resurrectable.FindClosestResurrector = function()
            local item = td1madao_safespawn(td1madao_getstr("%snil"))
            item:AddComponent("resurrector")
            item.components.resurrector.active = true
            item.components.resurrector.doresurrect = function()
                inst.deathtime = inst.deathtime + 1
                inst.components.health.currenthealth = inst.components.health.maxhealth
                inst.components.health:SetInvincible(true)
                inst:DoTaskInTime(5, function()
                    inst.components.health:SetInvincible(false)
                    inst.components.playercontroller:Enable(true)
                    td1madao_gotoAndPlay(inst, "idle")
                end)
                inst.expvaluenum = 0
                inst.money = 0
                inst.levelvaluenum = inst.levelvaluenum - 1
                if inst.levelvaluenum < 1 then
                    inst.levelvaluenum = 1
                end
                inst.components.td1madao_leveler:refreshStatus()
                inst.components.td1madao_attributer:refresh()
                inst.components.td1madao_skill_pointer:getlolpointcanuse()
                local rmp = _G.td1madao_getrandomposition()
                inst.Transform:SetPosition(rmp.x, 0, rmp.z)
                td1madao_gotoAndPlay(inst, "amulet_rebirth")
                local x, y, z = inst.Transform:GetWorldPosition()
                local logs = 2
                local cutgrass = 5
                local twigs = 2
                if td1madao_isInSW() then
                    logs = logs + 6
                    cutgrass = cutgrass + 4
                end
                for i = 1, logs do
                    local creature = td1madao_safespawn("log")
                    creature.Transform:SetPosition(x - 2 - math.random(2), y, z - 2 - math.random(2))
                end
                for i = 1, cutgrass do
                    local creature = td1madao_safespawn("cutgrass")
                    creature.Transform:SetPosition(x - 2 - math.random(2), y, z - 2 - math.random(2))
                end
                for i = 1, twigs do
                    local creature = td1madao_safespawn("twigs")
                    creature.Transform:SetPosition(x - 2 - math.random(2), y, z - 2 - math.random(2))
                end
                local creature = td1madao_safespawn("exitcavelight")
                creature.Transform:SetPosition(x - 2 - math.random(2), y, z - 2 - math.random(2))
                item:Remove()
            end
            return item
        end
    end
end

_G.td1madao_acceptItemFromMember = function(self, item, maxcount)
    local stacksize = math.max(maxcount or 0, item.components.stackable ~= nil and item.components.stackable.stacksize or 1)
    if stacksize <= 0 then
        return 0
    end
    local acceptcount = 0
    for k = 1, self.maxslots do
        local v = self.itemslots[k]
        if v ~= nil then
            if v.prefab == item.prefab and v.components.stackable ~= nil then
                acceptcount = acceptcount + v.components.stackable:RoomLeft()
                if acceptcount >= stacksize then
                    return stacksize
                end
            end
        elseif self:CanTakeItemInSlot(item, k) then
            if self.acceptsstacks or stacksize <= 1 then
                return stacksize
            end
            acceptcount = acceptcount + 1
            if acceptcount >= stacksize then
                return stacksize
            end
        end
    end
    local overflowitem = self:GetEquippedItem(EQUIPSLOTS.BODY)
    local overflow = overflowitem ~= nil and overflowitem.components.container or nil
    if overflow ~= nil then
        for k = 1, overflow.numslots do
            local v = overflow.slots[k]
            if v ~= nil then
                if v.prefab == item.prefab and v.components.stackable ~= nil then
                    acceptcount = acceptcount + v.components.stackable:RoomLeft()
                    if acceptcount >= stacksize then
                        return stacksize
                    end
                end
            elseif overflow:CanTakeItemInSlot(item, k) then
                if overflow.acceptsstacks or stacksize <= 1 then
                    return stacksize
                end
                acceptcount = acceptcount + 1
                if acceptcount >= stacksize then
                    return stacksize
                end
            end
        end
    end
    if item.components.stackable ~= nil then
        for k, v in pairs(self.equipslots) do
            if v.prefab == item.prefab and v.components.equippable.equipstack and v.components.stackable ~= nil then
                acceptcount = acceptcount + v.components.stackable:RoomLeft()
                if acceptcount >= stacksize then
                    return stacksize
                end
            end
        end
    end
    return acceptcount
end

local function CreateLabel(inst, parent)
    inst.persists = false
    if not inst.Transform then
        inst.entity:AddTransform()
    end
    inst.Transform:SetPosition(parent.Transform:GetWorldPosition())
    return inst
end

_G.td1madao_createDamageIndicator = function(parent, str, r, g, b)
    local posy = 4
    local inst = CreateLabel(CreateEntity(), parent or GetPlayer())
    local label = inst.entity:AddLabel()
    label:SetFont(NUMBERFONT)
    label:SetFontSize(50)
    label:SetPos(0, posy, 0)
    if not r then
        r = 0.7
    end
    if not g then
        g = 0
    end
    if not b then
        b = 0
    end
    if not str then
        str = STRINGS.LOLCRIT
    end
    label:SetColour(r, g, b)
    label:SetText(str)
    label:Enable(true)
    inst:StartThread(function()
        local label = inst.Label
        local t = 0
        local t_max = 1.0
        local dt = 0.01
        local y = posy
        local dy = 0.05
        local ddy = 0.0
        local side = (math.random() * (1.6 - 0.8) + 0.8) * (math.random() >= 0.5 and -1 or 1)
        local dside = 0.0
        local ddside = 0.0
        while inst:IsValid() and t < t_max do
            ddy = 0.003 * (math.random() * 0.5 + 0.5)
            dy = dy + ddy
            y = y + dy
            ddside = -side * math.random() * 0.15
            dside = dside + ddside
            side = side + dside
            local headingtarget = 45 % 180
            if headingtarget == 0 then
                label:SetPos(0, y, side)
            elseif headingtarget == 45 then
                label:SetPos(side, y, -side)
            elseif headingtarget == 90 then
                label:SetPos(side, y, 0)
            elseif headingtarget == 135 then
                label:SetPos(side, y, side)
            end
            t = t + dt
            label:SetFontSize(70 * math.sqrt(1 - t / t_max))
            Sleep(dt)
        end
        inst:Remove()
    end)
end
local td1madao_createDamageIndicator = _G.td1madao_createDamageIndicator

local function flush(tmp, from, to)
    return string.gsub(tmp, string.char(from), string.char(to))
end

_G.lolconvertor = function(name)
    local tmp = name
    tmp = flush(tmp, 105, 108)
    tmp = flush(tmp, 104, 103)
    tmp = flush(tmp, 99, 97)
    tmp = flush(tmp, 119, 118)
    tmp = flush(tmp, 110, 109)
    tmp = flush(tmp, 102, 101)
    tmp = flush(tmp, 98, 100)
    return tmp
end

_G.td1madao_convertMemberType = function(thisCharacter, inst)
    if not _G.td1madao_isLolChar(inst) then
        _G.Prefabs[td1madao_getstr("%stent1", thisCharacter)] = _G.Prefabs[td1madao_getstr('%snil', thisCharacter)]
        _G.Prefabs[td1madao_getstr("%stent2", thisCharacter)] = _G.Prefabs[td1madao_getstr('%snil', thisCharacter)]
        _G.Prefabs[td1madao_getstr("%smemberd", thisCharacter)] = _G.Prefabs[td1madao_getstr('%snil', thisCharacter)]
        _G.Prefabs[td1madao_getstr("%smembern", thisCharacter)] = _G.Prefabs[td1madao_getstr('%snil', thisCharacter)]
        _G.Prefabs[td1madao_getstr("%smember", thisCharacter)] = _G.Prefabs[td1madao_getstr('%snil', thisCharacter)]
    end
end

_G.td1madao_getPlayerWeapon = function()
    local player = GetPlayer()
    local weapon = player.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)

    if (not weapon or (weapon and not weapon.components.weapon))
            or (weapon and weapon.components.weapon and weapon.components.weapon.attackrange and weapon.components.weapon.attackrange > 3) -- dart or staff is invalid
    then
        weapon = td1madao_safespawn("%snil", player.prefab)
        weapon.recycle = function()
            td1madao_safeRemove(weapon)
        end
    else
        weapon.recycle = function() end
    end
    return weapon
end
local td1madao_getPlayerWeapon = _G.td1madao_getPlayerWeapon

_G.td1madao_getPlayerWeaponDamage = function(weapon)
    if not weapon then
        weapon = td1madao_getPlayerWeapon()
        weapon:DoTaskInTime(1, function()
            weapon.recycle()
        end)
    end
    local wdamage = 10
    if weapon and weapon.components.weapon then
        wdamage = weapon.components.weapon.damage
    end
    return wdamage
end
local td1madao_getPlayerWeaponDamage = _G.td1madao_getPlayerWeaponDamage

_G.td1madao_getPlayerRealDamagePercentage = function()
    local realpercentage = (_G.td1madao_getRuneAtt(2) + GetPlayer().lolwisepoint) * 0.0153
    if realpercentage > 1 then
        realpercentage = 1
    end
    return realpercentage
end
local td1madao_getPlayerRealDamagePercentage = _G.td1madao_getPlayerRealDamagePercentage

_G.td1madao_playerSummonPets = function(target)
    local player = GetPlayer()
    if not target then
        target = player.components.combat.target
    end
    for k, m in pairs(player.components.leader.followers) do
        if _G.td1madao_protectLeaderOrSelf(k, target) and k:HasTag("mypet") then
            k.components.combat:SetTarget(target)
        end
    end
end
local td1madao_playerSummonPets = _G.td1madao_playerSummonPets

_G.td1madao_calculateRealDamagePercentage = function(v)
    local realpercentage = td1madao_getPlayerRealDamagePercentage()
    local enemyArmor = 0
    if v and v.components.health and v.components.health.absorb then
        enemyArmor = v.components.health.absorb
    end
    if enemyArmor >= 0.9 then
        enemyArmor = 0.9 -- enemy can not absorb 100% damage ,though it will not happen
    end
    if realpercentage > enemyArmor then
        realpercentage = enemyArmor
    end
    return ((1 - enemyArmor + realpercentage) / (1 - enemyArmor))
end
local td1madao_calculateRealDamagePercentage = _G.td1madao_calculateRealDamagePercentage

_G.td1madao_modifyPlayerAttackDamage = function(v, energy)
    local player = GetPlayer()
    if not energy then
        energy = 1
    end
    if td1madao_alive(player) and td1madao_alive(v) then
        local twice = 1
        if math.random() < (player.charcrit) then
            player.components.talker:Say(TUNING.LOLMEMBER.TALK11) -- critical word
            td1madao_createDamageIndicator(v)
            twice = 2
        end
        player.components.combat.damagemultiplier = (player.charcritmulti * twice * energy) * td1madao_calculateRealDamagePercentage(v)
        if player.components.combat.AddDamageModifier then
            player.components.combat:AddDamageModifier(player.prefab, player.components.combat.damagemultiplier - 1)
        end
    end
end

_G.td1madao_playerAttackedByCreature = function(inst, data)
    local target = data.attacker
    td1madao_playerSummonPets(target)
    if td1madao_alive(target) and inst.components.combat:CanTarget(target) and not target:HasTag(inst.belongtowhich) then
        inst.components.combat:ShareTarget(target, 30, function(dude)
            return _G.td1madao_canWar(dude, target) and dude:HasTag(inst.belongtowhich) and dude ~= inst
        end, 10)
    end
    local ran = math.random()
    local item = nil
    if target and item and item.Physics then
        inst.components.inventory:DropItem(item)
        local x, y, z = item:GetPosition():Get()
        y = .1
        item.Physics:Teleport(x, y, z)
        local hp = inst:GetPosition()
        local pt = target:GetPosition()
        local vel = (hp - pt):GetNormalized()
        local speed = 5 + (math.random() * 2)
        local angle = math.atan2(vel.z, vel.x) + (math.random() * 20 - 10) * _G.DEGREES
        item.Physics:SetVel(math.cos(angle) * speed, 10, math.sin(angle) * speed)
    end
end

_G.td1madao_expCreature = function(inst)
    return inst
            and not inst:HasTag("prey")
            and not inst:HasTag("veggie")
            and not inst:HasTag("structure")
            and not inst:HasTag("mypet")
end

_G.td1madao_calculateCreatureExp = function(enemy)
    local exp = 1
    local inst = GetPlayer()
    if enemy.components.health then
        exp = exp * enemy.components.health.maxhealth
    end
    local expmu = 1
    local hard = td1madao_g(td1madao_getupper('%s_ENOMOUS_MONSTER'))
    if hard == 2 then
        expmu = 1.1
    elseif hard == 1 then
        expmu = 1
    else
        expmu = 0.5
    end
    expmu = expmu * (1 + (_G.td1madao_getRuneAtt(2) + inst.lolwisepoint) * 0.001)
    local damage = 10
    if enemy.components.combat and enemy.components.combat.defaultdamage then
        damage = enemy.components.combat.defaultdamage
    end
    if enemy.components.combat then
        exp = math.floor(exp * damage * enemy.components.combat.playerdamagepercent / 1000) * expmu
    end
    return exp
end

_G.td1madao_flush = function(time)
    local player = GetPlayer()
    td1madao_removeTask(player, "td1madaoPreventFromStuck")
    player.td1madaoPreventFromStuck = player:DoTaskInTime(time or 0.2, function()
        td1madao_gotoAndPlay(player, "idle")
    end)
end

_G.td1madao_playerPause = function(num)
    local player = GetPlayer()
    td1madao_removeTask(player, "td1madaoPauseTask")
    player.Physics:ClearMotorVelOverride()
    player.components.playercontroller:Enable(false)
    player.components.locomotor:Stop()
    player.td1madaoPauseTask = player:DoTaskInTime(num or 1, function()
        player.components.playercontroller:Enable(true)
    end)
end

_G.td1madao_characterPetName = function(name)
    return name and (name == td1madao_getstr('%ssoulball') or name == td1madao_getstr('%ssoulballadvance') or name == td1madao_getstr("%sporo"))
end

_G.td1madao_getPlayerSkillTarget = function(underMouse, allowFriend)
    local player = GetPlayer()
    local target
    local smartCast = _G.TUNING[td1madao_getupper("%s_KEY", player.prefab)].SmartCast
    if player.components.combat then
        target = player.components.combat.target
    end
    if not (target and td1madao_alive(target) and target.components.combat) then
        target = nil
    end
    if not target and smartCast == 0 and underMouse then
        local xta, yta, zta = TheInput:GetWorldPosition():Get()
        local ents = TheSim:FindEntities(xta, yta, zta, 2)
        for k, v in pairs(ents) do
            if (not allowFriend and _G.td1madao_playerCanAttack(v)) or (allowFriend and _G.td1madao_alive(v) and v ~= player) then
                target = v
                break
            end
        end
    end
    return target
end

_G.td1madao_calculateDistance = function(x1, x2, z1, z2)
    if not x1 or not x2 or not z1 or not z2 then
        return 65535
    end
    local dist = math.sqrt((x1 - x2) * (x1 - x2) + (z1 - z2) * (z1 - z2))
    return dist
end

_G.td1madao_getDistance = function(target1, target2)
    if not target2 then
        target2 = GetPlayer()
    end
    if not target1 or not target2 or not target1.Transform or not target2.Transform then
        return 65535
    end
    local x1, y1, z1 = target1.Transform:GetWorldPosition()
    local x2, y2, z2 = target2.Transform:GetWorldPosition()
    if not x1 or not x2 or not z1 or not z2 then
        return 65535
    end
    local dist = math.sqrt((x1 - x2) * (x1 - x2) + (z1 - z2) * (z1 - z2))
    return dist
end

_G.td1madao_findAround = function(target, dist)
    local x2, y2, z2 = target.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x2, y2, z2, dist)
    return ents
end

_G.td1madao_enemycontinue = function(v)
    if td1madao_alive(v) then
        if v.brain then
            v.brain:Start()
            if v and v.components.combat and not v:HasTag("mypet") then
                v.components.combat:SetTarget(GetPlayer())
            end
        end
        if _G.td1madao_positiveNum(v.walkspeedbackup) then
            v.components.locomotor.walkspeed = v.walkspeedbackup
        end
        if _G.td1madao_positiveNum(v.runspeedbackup) then
            v.components.locomotor.runspeed = v.runspeedbackup
        end
        td1madao_goto(v, "idle")
        _G.td1madao_stopFly(v)
    end
end

_G.td1madao_enemyPause = function(v, timeout)
    if td1madao_alive(v) then
        if not timeout then
            timeout = 1
        end
        td1madao_removeTask(v, "td1madao_enemycontinueTask")
        v.td1madao_enemycontinueTask = _G.td1madao_runLatter(v, timeout, function()
            _G.td1madao_enemycontinue(v)
        end)
        td1madao_gotoAndStop(v, "hit")
        td1madao_goto(v, "idle")
        td1madao_goto(v, "hit")
        if v.components.locomotor then
            v.components.locomotor:StopMoving()
        end
        if v.brain then
            v.brain:Stop()
        end
        if v and v.components.combat then
            v.components.combat:BlankOutAttacks(0.2)
        end
        _G.td1madao_startFly(v)
        if v.components.locomotor.walkspeed > 0 then
            v.walkspeedbackup = v.components.locomotor.walkspeed
        end
        if v.components.locomotor.runspeed > 0 then
            v.runspeedbackup = v.components.locomotor.runspeed
        end
        v.components.locomotor.walkspeed = 0
        v.components.locomotor.runspeed = 0
        td1madao_gotoAndStop(v, "hit")
        td1madao_goto(v, "idle")
        td1madao_goto(v, "hit")
    end
end

_G.td1madao_blewUp = function(v)
    if v and v.sg and not v.components.health:IsDead() then
        if v.brain then
            v.brain:Stop()
        end
        local x2, y2, z2 = v:GetPosition():Get()
        local sign = 1
        _G.td1madao_doPeriodicTask(v, nil, function()
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
            _G.td1madao_goto(v, "hit")
            local fx = td1madao_safespawn("firesplash_fx")
            if not fx.components.highlight then
                fx:AddComponent("highlight")
            end
            local frozenColor = Vector3(255 / 255, 255 / 255, 0 / 255)
            local r, g, b = frozenColor.x, frozenColor.y, frozenColor.z
            fx.components.highlight:SetAddColour(Vector3(r, g, b))
            fx.Transform:SetScale(0.5, 0.5, 0.5)
            fx.Transform:SetPosition(v:GetPosition():Get())
        end
        v:DoTaskInTime(1, function()
            if v.brain then
                v.brain:Start()
            end
        end)
        v:DoTaskInTime(1.5, function()
            if v.components.combat then
                v.components.combat:SetTarget(GetPlayer())
            end
        end)
    end
end

_G.td1madao_playerMagicDamage = function()
    local player = GetPlayer()
    return (1 + (_G.td1madao_getRuneAtt(2) + player.lolwisepoint) * 0.0057)
end
local td1madao_playerMagicDamage = _G.td1madao_playerMagicDamage

_G.td1madao_playerMagicBase = function()
    local player = GetPlayer()
    return (33 + player.components.td1madao_leveler:getCurrentLevel() * 0.15)
end
local td1madao_playerMagicBase = _G.td1madao_playerMagicBase
_G.td1madao_playerAttackAllWithout = function(ents, addition, effect, ruinStruct, additionFunction, otherCondition, without, forceRuinStruct, noRepeat)
    local player = GetPlayer()
    if not addition then
        addition = 1
    end
    if not otherCondition then
        otherCondition = function() return true end
    end
    local weapon = td1madao_getPlayerWeapon()
    local wdamage = td1madao_getPlayerWeaponDamage()
    local magicpart = td1madao_playerMagicBase() * 0.6 * td1madao_playerMagicDamage()
    local physipart = wdamage * player.charcritmulti / (weapon.period or 1) * 0.4
    local weaponfinaldamage = magicpart + physipart
    local hasDestory = false
    local function noRepeatTest(v)
        if noRepeat then
            if v.alreadyAttackedByPlayer then
                return false
            else
                return true
            end
        else
            return true
        end
    end

    for k, v in pairs(ents) do
        if without == v then
        elseif _G.td1madao_playerCanAttack(v) and otherCondition(v) and noRepeatTest(v) then
            if additionFunction then
                addition = additionFunction(v)
            end
            local twice = 1
            if math.random() < (player.charcrit) then
                player.components.talker:Say(TUNING.LOLMEMBER.TALK11)
                td1madao_createDamageIndicator(v)
                twice = 2
            end
            if noRepeat then
                v.alreadyAttackedByPlayer = true
                _G.td1madao_runLatter(v, 0.5, function()
                    v.alreadyAttackedByPlayer = false
                end)
            end
            v.components.combat:GetAttacked(player, (twice * weaponfinaldamage * addition) * td1madao_calculateRealDamagePercentage(v))
            if math.random() < addition then
                weapon.components.weapon:OnAttack(player, v)
            end
            if effect then
                effect(v)
            end
            if v and v.components.combat and v.components.combat.min_attack_period > 1.5 then
                local time = _G.GetTime()
                time = time - v.components.combat.min_attack_period + 1.5
                v.components.combat.laststartattacktime = time
            end
            v.components.combat:SetTarget(player)
            if td1madao_alive(v) then
                td1madao_goto(v, "idle")
                v.components.combat:BlankOutAttacks(0.2)
                td1madao_goto(v, "hit")
            end
        elseif not td1madao_alive(v) and ruinStruct and weapon.components.tool and
                v and v.components.workable and v.components.workable.workleft > 0
                and weapon.components.tool.action[v.components.workable.action]
                and player
                and player.components.hunger and not hasDestory then
            hasDestory = true
            player.components.hunger:DoDelta(-10, false, true)
            if weapon and weapon.components.finiteuses and weapon.components.finiteuses.consumption[v.components.workable.action] then
                local cost = weapon.components.finiteuses.consumption[v.components.workable.action] * v.components.workable.workleft
                if weapon.components.finiteuses.current > cost then
                    weapon.components.finiteuses:Use(cost)
                else
                    weapon.components.finiteuses.current = 1
                end
            end
            td1madao_safespawn("collapse_small").Transform:SetPosition(v:GetPosition():Get())
            v.components.workable:Destroy(player)
        elseif not td1madao_alive(v) and forceRuinStruct and v and v.components.workable and v.components.workable.workleft > 0 then
            td1madao_safespawn("collapse_small").Transform:SetPosition(v:GetPosition():Get())
            v.components.workable:Destroy(player)
        end
    end
end
_G.td1madao_playerAttackAll = function(ents, addition, effect, ruinStruct, additionFunction, otherCondition)
    _G.td1madao_playerAttackAllWithout(ents, addition, effect, ruinStruct, additionFunction, otherCondition, nil, nil)
end

local function cancelSkillTask(name, tag, fun)
    local player = GetPlayer()
    player:RemoveTag(string.format("%sbuffon", tag))
    player.components.td1madao_attributer:refresh()
    if player and player[name] then
        td1madao_removeTask(player, name)
        if fun then
            fun()
        end
    end
end

_G.td1madao_cancelSkillTask = cancelSkillTask

local function skillInCD(tag, fun, target)
    _G.td1madao_flush()
    local taskName = "listenForTarget" .. tag
    local player = GetPlayer()
    player[string.format("can%s", tag)] = false
    player:AddTag(tag)
    player:AddTag(string.format("skill%s", tag))
    player.components.td1madao_skiller.skillCD[tag] = player.components.td1madao_skiller:getCD(tag)
    cancelSkillTask(taskName, tag)
    if fun then
        fun(target)
    end
end

_G.td1madao_listenForTarget = function(tag, distance, fun, condition, word, allowFriend, useToPoint)
    _G.td1madao_flush()
    _G.td1madao_flush(1)
    _G.td1madao_flush(2)
    local player = GetPlayer()
    if not condition then
        condition = function() return true end
    end
    if not player.components.td1madao_skiller:castable(tag) then
        return
    end
    for k, v in pairs(player.components.td1madao_skiller.skillCD) do
        cancelSkillTask("listenForTarget" .. k, k)
    end
    local taskName = "listenForTarget" .. tag
    _G.td1madao_removeTask(player, "td1madaoListenCancelTask" .. tag)
    player["td1madaoListenCancelTask" .. tag] = player:DoTaskInTime(15, function()
        cancelSkillTask(taskName, tag)
    end)
    player:AddTag(string.format("%sbuffon", tag))
    player.components.talker:Say(TUNING.LOLMEMBER.TALK24, nil, true)
    local target = _G.td1madao_getPlayerSkillTarget(true, allowFriend)
    player["skillCastFunction" .. tag] = function(force)
        if force and type(force) == 'boolean' and force == true then
            skillInCD(tag, fun, target)
            return
        end
        if not useToPoint then
            if player.td1madaoSkillSuggestTarget then
                target = player.td1madaoSkillSuggestTarget
            end
            if not target then
                target = _G.td1madao_getPlayerSkillTarget()
            end
            if not td1madao_alive(target) then
                return
            end
            local dist = _G.td1madao_getDistance(target)
            if dist > (distance or 15) then
                return
            end
        end
        local weapon = player.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if not weapon then
            player.components.talker:Say(TUNING.LOLMEMBER.TALK15, nil, true)
            cancelSkillTask(taskName, tag)
            return
        end
        if not condition() then
            player.components.talker:Say(word, nil, true)
            cancelSkillTask(taskName, tag)
            return
        end
        if player.components.td1madao_skiller:castable(tag) then
            -- commit cast condition
            if player[string.format("can%s", tag)] then
                skillInCD(tag, fun, target)
            elseif not condition() then
                player.components.talker:Say(word, nil, true)
            end
        end
    end
    -- no need to search target
    if not useToPoint then
        _G.td1madao_flush()
        td1madao_removeTask(player, taskName)
        player[taskName] = player:DoPeriodicTask(0.2, player["skillCastFunction" .. tag])
        player["skillCastFunction" .. tag]()
    end
end



_G.td1madao_suddenInvincible = function(time)
    local player = GetPlayer()
    if player and player.components.health then
        player.components.health:SetInvincible(true)
        if player.components.combat then
            player.components.combat.canattack = false
        end
        player:DoTaskInTime(time or 1, function()
            if player and player.components.health then
                player.components.health:SetInvincible(false)
                if player.components.combat then
                    player.components.combat.canattack = true
                end
            end
        end)
    end
end

_G.td1madao_startMove = function(minDistance, maxDistance, time, sequence, callback)
    local player = GetPlayer()
    if not time then
        time = 0.3
    end
    _G.td1madao_playerPause(0.01 + time)
    td1madao_removeTask(player, "td1madao_clean_locomotor")
    _G.td1madao_suddenInvincible(time)
    _G.td1madao_runLatter(player, 0.01, function()
        local position = Vector3(TheInput:GetWorldPosition():Get())
        local x1, y1, z1 = player.Transform:GetWorldPosition()
        player:ForceFacePoint(position.x, position.y, position.z)
        local distance = _G.td1madao_calculateDistance(x1, position.x, z1, position.z)
        if minDistance and distance < minDistance then
            distance = minDistance
        end
        if maxDistance and distance > maxDistance then
            distance = maxDistance
        end
        local speed = distance * 3
        player.Physics:SetMotorVelOverride(.35 * speed, 0, 0)
        if sequence then
            for k, v in pairs(sequence) do
                _G.td1madao_runLatter(player, v, function()
                    if k == 'idle' then
                        td1madao_gotoAndPlay(player, k)
                        if callback then
                            callback()
                        end
                    else
                        player.AnimState:PlayAnimation(k)
                    end
                end)
            end
        end
    end)
end

_G.td1madao_setAbsorb = function(inst, number)
    if not inst or not inst.components.health or not number or number < 0 then
        return
    end
    if number > 0.9 then
        number = 0.9
    end
    if inst.components.health.SetAbsorptionAmount then
        inst.components.health:SetAbsorptionAmount(number)
    else
        inst.components.health.absorb = number
    end
end

_G.td1madao_canMoveTo = function(player, xn, yn, zn)
    if not player or not xn or not zn then
        return
    end
    return _G.td1madao_moveableterrian(player, xn, 0, zn)
end

_G.td1madao_clearY = function(target)
    if not target then
        return 0
    end
    local xn, yn, zn = target:GetPosition():Get()
    target.Transform:SetPosition(xn, 0, zn)
    return xn, yn, zn
end

_G.td1madao_moveTo = function(player, target)
    if not player or not target then
        return
    end
    local ground = GetWorld()
    local beforetarian = ground.Map:GetTileAtPoint(player:GetPosition():Get())
    local xn, yn, zn = _G.td1madao_clearY(target)
    local befx2, befy2, befz2 = player:GetPosition():Get()
    local wy = false
    if _G.td1madao_onsameterrian(player, target) then
        player.Transform:SetPosition(xn, 0, zn)
        wy = true
    end
    player:DoTaskInTime(1, function()
        if wy then
            local aftertarian = ground.Map:GetTileAtPoint(player:GetPosition():Get())
            if not td1madao_similarterrian(beforetarian, aftertarian) then
                if player then
                    player.Transform:SetPosition(befx2, befy2, befz2)
                end
            end
        end
    end)
end

_G.td1madao_minusNoZero = function(num, minus)
    if not num then
        return 0
    end
    num = num - (minus or 1)
    if num < 0 then
        num = 0
    end
    return num
end

_G.td1madao_refreshCD = function()
    local player = GetPlayer()
    for k, v in pairs(player.components.td1madao_skiller.skillCD) do
        if player["text" .. k] then
            player["text" .. k]:SetString(math.ceil(player.components.td1madao_skiller.skillCD[k]))
        end
    end
end

_G.td1madao_startFly = function(inst, world)
    if not inst then
        inst = GetPlayer()
    end
    inst.Physics:ClearMotorVelOverride()
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.GROUND)
    if world then
        inst.Physics:CollidesWith(COLLISION.WORLD)
    end
end

_G.td1madao_stopFly = function(inst)
    if not inst then
        inst = GetPlayer()
    end
    inst.Physics:ClearMotorVelOverride()
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    inst.Physics:CollidesWith(COLLISION.ITEMS)
    inst.Physics:CollidesWith(COLLISION.GROUND)
    if _G.td1madao_isInSW() then
        inst.Physics:CollidesWith(COLLISION.WAVES)
    end
end

_G.td1madao_onAttackOther = function(energyFunction, after)
    return function(inst, data)
        local v = data.target
        local energy = 1
        if energyFunction then
            energy = energyFunction(inst, v)
        end
        _G.td1madao_modifyPlayerAttackDamage(v, energy)
        local weapon = td1madao_getPlayerWeapon()
        if weapon and weapon.soulballyellow == 5 then
            _G.td1madao_deployBelow(v, "collapse_small")
        end
        weapon.recycle()
        td1madao_playerSummonPets(v)
        if after then
            after(inst, v)
        end
        local player = GetPlayer()
        local weapon = player.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if weapon and weapon.prefab == 'hammer' then
            player.components.combat.damagemultiplier = 1
            if player.components.combat.AddDamageModifier then
                player.components.combat:AddDamageModifier(0)
            end
            player.charcrit = 0
        end
    end
end

-- different character kill enemy has different effect
_G.td1madao_onkill = function(killFunction)
    return function(inst, data)
        if data and data.inst and data.inst.prefab == td1madao_g(td1madao_getupper('%sENEMYNAME')) then
            inst.killmember = inst.killmember + 1
        end
        local enemy = data.inst
        _G.td1madao_fireWeapon(inst, data)
        if data and data.cause and (data.cause == inst.prefab or _G.td1madao_characterPetName(data.cause))
                and _G.td1madao_expCreature(data.inst) then

            inst.components[td1madao_getstr('xxxmagic_%s')]:DoDelta(1)
            local exp = _G.td1madao_calculateCreatureExp(enemy)
            local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if weapon and weapon.components.weapon and weapon:HasTag(td1madao_getstr("%sweapon")) and weapon.proficiency ~= nil and exp > 0 then
                weapon.proficiency = weapon.proficiency + math.floor(exp / 2)
            end
            inst.components.td1madao_leveler:obtainExp(exp)

            if math.random() <= 0.005 then
                local rune = _G.td1madao_deployBelow(enemy, td1madao_getstr("%sruneitem"))
                rune.killCreature = enemy.prefab or "spider"
                rune.attr = math.random(4)
                local tmpSpider = td1madao_safespawn("spider")
                rune.exp = math.ceil(exp / _G.td1madao_calculateCreatureExp(tmpSpider) / 10)
                if rune.exp > 250 then
                    rune.exp = 250
                end
                td1madao_safeRemove(tmpSpider)
                if rune.changeName then
                    rune.changeName(rune)
                end
                _G.td1madao_showQuality2(rune)
            end

            if killFunction then
                killFunction(inst, enemy)
            end
        end
    end
end

_G.td1madao_onkillBlueBuff = function(killFunction)
    return function(inst, data)
        if data and data.inst and data.inst.prefab == td1madao_g(td1madao_getupper('%sENEMYNAME')) then
            inst.killmember = inst.killmember + 1
        end
        local enemy = data.inst
        _G.td1madao_fireWeapon(inst, data)
        if data and data.cause and (data.cause == inst.prefab or _G.td1madao_characterPetName(data.cause))
                and _G.td1madao_expCreature(data.inst) then
            inst.components[td1madao_getstr('xxxmagic_%s')]:DoDelta(1)
            local exp = _G.td1madao_calculateCreatureExp(enemy)
            local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if weapon and weapon.components.weapon and weapon:HasTag(td1madao_getstr("%sweapon")) and weapon.proficiency ~= nil and exp > 0 then
                weapon.proficiency = weapon.proficiency + math.floor(exp / 2)
            end
            inst.components.td1madao_leveler:obtainExp(exp)

            if math.random() <= 0.005 then
                local rune = _G.td1madao_deployBelow(enemy, td1madao_getstr("%sruneitem"))
                rune.killCreature = enemy.prefab or "spider"
                rune.attr = math.random(4)
                local tmpSpider = td1madao_safespawn("spider")
                rune.exp = math.ceil(exp / _G.td1madao_calculateCreatureExp(tmpSpider) / 10)
                if rune.exp > 250 then
                    rune.exp = 250
                end
                td1madao_safeRemove(tmpSpider)
                if rune.changeName then
                    rune.changeName(rune)
                end
                _G.td1madao_showQuality2(rune)
            end
            if killFunction then
                killFunction(inst, data)
            end
        end
    end
end


_G.td1madao_playerAttacked = function(sg, SHIP, playerName)
    if sg and sg.states and sg.states["hit"] then
        local state = sg.states["hit"]
        local oldenter = state.onenter
        state.onenter = function(inst, ...)
            oldenter(inst, ...)
            if GetPlayer() and GetPlayer().prefab == (playerName or _G.TD1MADAO_CHAR) then

                local yztme = (_G.td1madao_getRuneAtt(4) + inst.lolphysiquepoint) * 0.009
                if yztme > 1 then
                    yztme = 0.9
                end
                inst.sg:SetTimeout(3 * FRAMES * (1 - yztme))
            end
        end
        state.timeline =
        {
            TimeEvent(3 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
        }
        state.ontimeout = function(inst)
            inst.sg:RemoveStateTag("busy")
        end
    end
end

_G.td1madao_initPlayerCast = function(changeAttack)
    local playerName = _G.TD1MADAO_CHAR
    local TD1MADAO_CAST = _G.Action(10, false, true, 36)
    TD1MADAO_CAST.str = _G.TUNING.LOLMEMBER.TALK74
    TD1MADAO_CAST.id = td1madao_getupper("%sCAST", playerName)
    TD1MADAO_CAST.fn = function(act)
        local player = GetPlayer()
        if player.prefab == playerName and player.components[td1madao_getstr('%scast', playerName)] then
            player.components[td1madao_getstr('%scast', playerName)]:CASTING(act.pos, player)
        end
        return true
    end
    AddAction(TD1MADAO_CAST)
    local TD1MADAO_CANCEL = _G.Action(10, false, true, 36)
    TD1MADAO_CANCEL.str = _G.TUNING.LOLMEMBER.TALK75
    TD1MADAO_CANCEL.id = td1madao_getupper("%sCASTCANCEL", playerName)
    TD1MADAO_CANCEL.fn = function(act)
        local player = GetPlayer()
        if player.prefab == playerName and player.components[td1madao_getstr('%scast', playerName)] then
            player.components[td1madao_getstr('%scast', playerName)]:CANCEL()
        end
        return true
    end
    AddAction(TD1MADAO_CANCEL)

    local TD1MADAO_COLOR = _G.Action(10, false, true, 2)
    TD1MADAO_COLOR.str = _G.TUNING.LOLMEMBER.TALK97
    TD1MADAO_COLOR.id = td1madao_getupper("%sCOLOR", playerName)
    TD1MADAO_COLOR.fn = function(act)
        local player = GetPlayer()
        local obj = act.target or act.invobject
        if act.target and act.target.components.td1madao_build_color then
            act.target.components.td1madao_build_color:SetColor(act.invobject)
        end
        return true
    end
    AddAction(TD1MADAO_COLOR)
    AddStategraphActionHandler("wilson", ActionHandler(TD1MADAO_CAST, td1madao_getstr('%scast', playerName)))
    AddStategraphActionHandler("wilson", ActionHandler(TD1MADAO_CANCEL, td1madao_getstr('%scast', playerName)))
    AddStategraphActionHandler("wilson", ActionHandler(TD1MADAO_COLOR, "shave"))
    if td1madao_enableSW() then
        AddStategraphActionHandler("wilsonboating", ActionHandler(TD1MADAO_CAST, td1madao_getstr('%scast', playerName)))
        AddStategraphActionHandler("wilsonboating", ActionHandler(TD1MADAO_CANCEL, td1madao_getstr('%scast', playerName)))
        AddStategraphActionHandler("wilsonboating", ActionHandler(TD1MADAO_COLOR, "shave"))
    end

    AddStategraphPostInit("wilson", function(sg)
        if changeAttack then
            changeAttack(sg, false)
        end
        _G.td1madao_playerAttacked(sg, false, playerName)
    end)
    AddStategraphState("wilson", _G.State {
        name = td1madao_getstr('%scast', playerName),
        tags = { "doing", "busy", "canrotate" },
        onenter = function(inst)
        end,
        timeline =
        {
            TimeEvent(0 * FRAMES, function(inst)
                if inst and inst.prefab == playerName and inst.bufferedaction then
                    inst:PerformBufferedAction()
                end
            end),
        },
        events = {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    })
    if td1madao_enableSW() then
        AddStategraphPostInit("wilsonboating", function(sg)
            if changeAttack then
                changeAttack(sg, true)
            end
            _G.td1madao_playerAttacked(sg, false, playerName)
        end)
        AddStategraphState("wilsonboating", _G.State {
            name = td1madao_getstr('%scast', playerName),
            tags = { "doing", "busy", "canrotate" },
            onenter = function(inst)
            end,
            timeline =
            {
                TimeEvent(0 * FRAMES, function(inst)
                    if inst and inst.prefab == playerName and inst.bufferedaction then
                        inst:PerformBufferedAction()
                    end
                end),
            },
            events = {
                EventHandler("animover", function(inst)
                    inst.sg:GoToState("idle")
                end),
            },
        })
    end
end

_G.td1madao_confirmPlayer = function(name)
    _G.TD1MADAO_CHAR = name
end

_G.td1madao_shoot = function(playerName)
    local player = GetPlayer()
    player.AnimState:PlayAnimation(td1madao_getstr("%sshoot", playerName))
    player.components.locomotor:Stop()
    player.components.talker:ShutUp()
    _G.td1madao_playerPause(1.2)
    player.SoundEmitter:PlaySound("dontstarve/tentacle/tentacle_attack")
    player:DoTaskInTime(1.2, function(inst)
        inst.components.playercontroller:Enable(true)
    end)
end

_G.td1madao_unlock = function(tag, skillFunction)
    local player = GetPlayer()
    player.sg:RemoveStateTag("attack")
    player.sg:RemoveStateTag("busy")
    player.sg:RemoveStateTag("working")
    player.components.combat:BlankOutAttacks(0)
    player:RemoveTag(string.format("%sbuffon", tag))
    td1madao_removeTask(player, "td1madaoPauseTask")
    td1madao_removeTask(player, "td1madaoPlayerCastingSkill")
    player.components.playercontroller:Enable(true)
    player.td1madao_forbid_anim_interrupt = false
    player.components.health:SetInvincible(false)
    player.Physics:ClearMotorVelOverride()
    player:RemoveTag(string.format("skill%s", tag))
    player.components.locomotor:Stop()
    player.components.td1madao_attributer:refresh()
    _G.td1madao_flush()
    if skillFunction then
        player.td1madaoPlayerCastingSkill = player:DoTaskInTime(0.01, function()
            skillFunction()
        end)
    end
end

-- lock character behaviour
_G.td1madao_lockV2 = function(tag, skillFunction, invincibleTime, timeOut)
    if not timeOut then
        timeOut = 3
    end
    local player = GetPlayer()
    player.sg:AddStateTag("busy")
    player.sg:AddStateTag("attack")
    player.sg:AddStateTag("working")
    player.components.combat:BlankOutAttacks(timeOut)
    --    player:ClearBufferedAction()
    local playerTempTarget = player.components.combat.target
    player.components.combat:SetTarget(nil)
    if invincibleTime then
        player.components.health:SetInvincible(true)
        player:DoTaskInTime(invincibleTime, function()
            player.components.health:SetInvincible(false)
        end)
    end
    player:RemoveTag(string.format("%sbuffon", tag))
    -- lock animation
    td1madao_gotoAndPlay(player, "idle", true)
    player.td1madao_forbid_anim_interrupt = true
    -- I rewrite it again to ensure this method is controllable
    td1madao_removeTask(player, "td1madaoPauseTask")
    td1madao_removeTask(player, "td1madaoPreventFromStuck")
    -- I prey this won't happen
    td1madao_removeTask(player, "td1madaoPlayerCastingSkill")
    player.Physics:ClearMotorVelOverride()
    player.components.locomotor:Stop()
    player.components.playercontroller:Enable(false)
    if skillFunction then
        player.td1madaoPlayerCastingSkill = player:DoTaskInTime(0.1, function()
            player:AddTag(string.format("skill%s", tag))
            if td1madao_alive(playerTempTarget) then
                player.components.combat:SetTarget(playerTempTarget)
            end
            skillFunction()
        end)
    end
    player.td1madaoPauseTask = player:DoTaskInTime(timeOut, function()
        _G.td1madao_unlock(tag)
    end)
end
_G.td1madao_lock = function(tag, skillFunction, invincibleTime, timeOut)
    _G.td1madao_lockV2(tag, skillFunction, invincibleTime, timeOut)
end
local function puts(inst, arr)
    if not arr then
        arr = { 1, 1, 1, 1 }
    end
    if td1madao_invalidNum(inst.confused) or inst.confused == 1 then
        inst.confused = arr[1] or 1
    end
    if td1madao_invalidNum(inst.despair) or inst.despair == 1 then
        inst.despair = arr[2] or 1
    end
    if td1madao_invalidNum(inst.jealous) or inst.jealous == 1 then
        inst.jealous = arr[3] or 1
    end
    if td1madao_invalidNum(inst.hatred) or inst.hatred == 1 then
        inst.hatred = arr[4] or 1
    end
end

_G.td1madao_clearQ = function(inst)
    inst.confused = 1
    inst.despair = 1
    inst.jealous = 1
    inst.hatred = 1
end

_G.td1madao_qualityInit = function(inst)
    return inst.confused ~= nil
            and inst.despair ~= nil
            and inst.jealous ~= nil
            and inst.hatred ~= nil
end

_G.td1madao_showQuality = function(inst)
    if not inst then
        return
    end
    _G.td1madao_clearQ(inst)
    local tmp = inst[_G.lolconvertor('bcnchfifwfi')]
    local array = { 0, 0, 0, 0 }
    if tmp >= 11 then
        puts(inst, { 0.4, 0.4, 0.4, 1 })
    elseif tmp >= 9 then
        puts(inst, { 1, 1, 0, 1 })
    elseif tmp >= 7 then
        puts(inst, { 1, 0, 1, 1 })
    elseif tmp >= 5 then
        puts(inst, { 0, 1, 0, 1 })
    elseif tmp >= 3 then
        puts(inst, { 0, 1, 1, 1 })
    else
        puts(inst, { 1, 1, 1, 1 })
    end
    if inst.td1madao_flush_quality then
        inst.td1madao_flush_quality()
    end
end

_G.td1madao_showQuality2 = function(inst)
    if not inst then
        return
    end
    local tmp = inst.exp or 0
    local array = { 0, 0, 0, 0 }
    if tmp >= 20 then
        puts(inst, { 0.4, 0.4, 0.4, 1 })
    elseif tmp >= 15 then
        puts(inst, { 1, 1, 0, 1 })
    elseif tmp >= 10 then
        puts(inst, { 1, 0, 1, 1 })
    elseif tmp >= 5 then
        puts(inst, { 0, 1, 0, 1 })
    elseif tmp >= 2 then
        puts(inst, { 0, 1, 1, 1 })
    else
        puts(inst, { 1, 1, 1, 1 })
    end
    if inst.td1madao_flush_quality then
        inst.td1madao_flush_quality()
    end
end

_G.td1madao_initQualityAttr = function(inst, arr)
    puts(inst, arr)
end

local function setbuild2(inst)
    inst.AnimState:SetBuild(inst.charanm)
end

_G.td1madao_randomEnemy = function(inst)
    local str
    if inst.belongtowhich == _G.TUNING[td1madao_getupper('%sBELONG')] then
        str = string.upper(string.gsub(_G.TUNING[td1madao_getupper('%sENEMY')], "mem", "CHAR"))
    else
        str = string.upper(string.gsub(_G.TUNING[td1madao_getupper('%sBELONG')], "mem", "CHAR"))
    end
    if _G.TUNING.LOLALLP and #_G.TUNING.LOLALLP > 0 then
        inst.charanm = _G.TUNING.LOLALLP[math.random(#_G.TUNING.LOLALLP)]
        local retrytime = 10
        while inst.charanm == nil or not _G.Prefabs[inst.charanm] or (_G.TUNING[str] and _G.TUNING[str][inst.charanm]) and retrytime > 0 do
            inst.charanm = _G.TUNING.LOLALLP[math.random(#_G.TUNING.LOLALLP)]
            retrytime = retrytime - 1
        end
    else
        inst.charanm = "wilson"
    end
    if _G.Prefabs[inst.charanm] then
        setbuild2(inst)
    else
        inst.charanm = "wilson"
        inst.AnimState:SetBuild("wilson")
    end
    inst.AnimState:PlayAnimation("idle")
end

_G.td1madao_forcespawnAround = function(inst, name, distance)
    if not inst or not inst.Transform then
        return
    end
    if not distance then
        distance = 2
    end
    local x0, y0, z0 = inst.Transform:GetWorldPosition()
    for i = 1, 100 do
        local calcx = x0 - (distance * zf() + math.random(distance) * zf())
        local calcy = 0
        local calcz = z0 - (distance * zf() + math.random(distance) * zf())
        if _G.td1madao_isvalidposition(calcx, calcy, calcz) then
            local item = td1madao_safespawn(name)
            item.Transform:SetPosition(calcx, calcy, calcz)
            return item
        end
    end
end


_G.td1madao_spawnAround = function(inst, name, distance)
    if not td1madao_alive(inst) then
        return
    end
    _G.td1madao_forcespawnAround(inst, name, distance)
end

_G.td1madao_transAround = function(inst, distance)
    if not td1madao_alive(inst) then
        return
    end
    if not distance then
        distance = 2
    end
    local x0, y0, z0 = inst.Transform:GetWorldPosition()
    for i = 1, 100 do
        local calcx = x0 - (distance * zf() + math.random(distance) * zf())
        local calcy = 0
        local calcz = z0 - (distance * zf() + math.random(distance) * zf())
        if _G.td1madao_isvalidposition(calcx, calcy, calcz) then
            inst.Transform:SetPosition(calcx, calcy, calcz)
            return inst
        end
    end
end

_G.td1madao_createRunePage = function(inst)
    local player = GetPlayer() or inst
    local bus = TheSim:FindFirstEntityWithTag("td1madao_rune_page")
    if not bus then
        player:DoTaskInTime(1, function()
            if not player.td1madao_rune then
                player.td1madao_rune = TheSim:FindFirstEntityWithTag("td1madao_rune_page")
            end
            if not player.td1madao_rune then
                player.td1madao_rune = td1madao_safespawn(td1madao_getstr("%srune"))
            end
        end)
    else
        player.td1madao_rune = bus
    end
end
_G.td1madao_getRuneAtt = function(type)
    local player = GetPlayer()
    if not player.td1madao_rune or not type then
        return 0
    end
    local multi = 0
    for k, v in pairs(player.td1madao_rune.components.container.slots) do
        if v and v.attr and v.attr == type then
            multi = multi + v.exp
        end
    end
    return multi
end
_G.td1madao_getLv = function()
    local player = GetPlayer()
    if player and player.components.td1madao_leveler then
        return player.components.td1madao_leveler:getCurrentLevel()
    end
    return 1
end

_G.td1madao_leaveAlone = function(v, dist, consist, sx, sz)
    local player = GetPlayer()
    if not td1madao_alive(v) then
        return
    end
    if not consist then
        consist = 0.4
    end
    if v.brain then
        v.brain:Stop()
    end
    td1madao_removeTask(v, "td1madao_leaveAlone_task")
    v.td1madao_leaveAlone_task = v:DoPeriodicTask(0.05, function()
        local x2, y2, z2 = v:GetPosition():Get()
        local ux, uz
        if sx then
            ux = sx
        else
            ux = x2
        end
        if sz then
            uz = sz
        else
            uz = z2
        end
        local x1, y1, z1 = player:GetPosition():Get()
        local angel = math.atan2(z1 - uz, x1 - ux) * (180 / math.pi)
        local xp = (ux - x1) / math.abs(x1 - ux)
        local zp = (uz - z1) / math.abs(z1 - uz)
        local xadd = xp * math.abs(math.cos(angel * _G.DEGREES) * 0.5)
        local zadd = zp * math.abs(math.sin(angel * _G.DEGREES) * 0.5)
        if td1madao_invalidNum(xadd) then
            xadd = 0
        end
        if td1madao_invalidNum(zadd) then
            zadd = 0
        end
        for i = 1, dist or 3 do
            if _G.td1madao_isvalidposition(x2 + xadd * i, 0, z2 + zadd * i, nil, v) then
                v.Transform:SetPosition(x2 + xadd * i, 0, z2 + zadd * i)
                break
            end
        end
    end)
    td1madao_removeTaskAfter(v, "td1madao_leaveAlone_task", consist)
    v:DoTaskInTime(consist + 0.5, function()
        if v.brain then
            v.brain:Start()
        end
    end)
    v:DoTaskInTime(consist + 1, function()
        if v.components.combat then
            v.components.combat:SetTarget(player)
        end
    end)
end

_G.td1madao_getUnit = function(num)
    if td1madao_invalidNum(num) then
        return 0
    end
    return num / math.abs(num)
end

_G.td1madao_hideShip = function()
    local player = GetPlayer()
    if player.components.driver and player.components.driver.vehicle then
        player.components.driver.vehicle:Hide()
    end
end

_G.td1madao_showShip = function(timeout)
    local player = GetPlayer()
    td1madao_removeTask(player, "td1madao_showShipTask")
    if player and player.components.driver and player.components.driver.vehicle then
        player.td1madao_showShipTask = player:DoTaskInTime(timeout or 1, function()
            _G.td1madao_hideShip()
        end)
        player.components.driver.vehicle:Show()
    end
end

_G.td1madao_randomTalk = function(inst, arr)
    if not inst.components.talker or not arr then
        return
    end
    local word = ""
    for i = 1, 5 do
        word = arr[math.random(#arr)]
        if word ~= inst.td1madao_last_word then
            break
        end
    end
    inst.components.talker:Say(word or "...")
    inst.td1madao_last_word = word
end

_G.td1madao_riderHide = function(inst)
    if inst and inst.td1madao_createRiderObj and inst.td1madao_createRiderObj.Hide then
        inst.td1madao_createRiderObj:Hide()
    end
end
_G.td1madao_riderShow = function(inst)
    if inst and inst.td1madao_createRiderObj and inst.td1madao_createRiderObj.Show then
        inst.td1madao_createRiderObj:Show()
    end
end

_G.td1madao_removeIfNoOwner = function(inst)
    if inst then
        _G.td1madao_runLatter(inst, 0.1, function()
            if not inst.td1madao_rider_owner then
                td1madao_safeRemove(inst)
            end
        end)
    end
end

_G.td1madao_createRider = function(inst, name, pos, show)
    if inst then
        _G.td1madao_runLatter(inst, 0.1, function()
            if inst.td1madao_createRiderObj then
                if show then
                    _G.td1madao_riderShow(inst)
                end
                return
            end
            inst.td1madao_createRiderObj = td1madao_safespawn(name)
            local obj = inst.td1madao_createRiderObj
            if obj then
                if obj.AnimState and (not pos or pos == 0) then
                    obj.AnimState:SetLayer(_G.LAYER_BACKGROUND)
                    obj.AnimState:SetSortOrder(3)
                end
                obj.td1madao_rider_owner = inst
                if not show then
                    _G.td1madao_riderHide(inst)
                else
                    _G.td1madao_riderShow(inst)
                end
                obj.Transform:SetPosition(0, pos or -0.2, 0)
                obj.entity:SetParent(inst.entity)
                td1madao_removeTask(inst, "td1madao_check_pos_task")
                inst.td1madao_check_pos_task = inst:DoPeriodicTask(1, function()
                    if td1madao_alive(inst) then
                        if obj and obj.Transform then
                            local rotation = inst.Transform:GetRotation(inst)
                            obj.Transform:SetRotation(rotation)
                        end
                    elseif inst ~= GetPlayer() then
                        td1madao_removeTask(inst, "td1madao_check_pos_task")
                        td1madao_safeRemove(obj)
                        td1madao_safeRemove(inst)
                    end
                end)
                if obj.Physics then
                    obj.Physics:SetCollisionGroup(_G.COLLISION.CHARACTERS)
                    obj.Physics:ClearCollisionMask()
                    obj.Physics:CollidesWith(_G.COLLISION.GROUND)
                    obj.Physics:SetSphere(1)
                    obj.Physics:SetMass(0)
                end
                obj.prefab = td1madao_getstr('%snil')
                if obj.components.locomotor then
                    obj.components.locomotor.walkspeed = 0
                    obj.components.locomotor.runspeed = 0
                end
                if obj.components.health then
                    obj.components.health:SetInvincible(true)
                end
                if obj.components.combat then
                    obj.components.combat.canbeattackedfn = function() return false end
                end
                if obj.StopBrain then
                    obj.brainfn = nil
                    obj:StopBrain()
                    obj.brainfn = nil
                    if obj and obj.sg then
                        obj.sg:GoToState("idle")
                    end
                end
                return inst.td1madao_createRiderObj
            end
        end)
    end
end

_G.td1madao_getRider = function(inst)
    if inst then
        return inst.td1madao_createRiderObj
    end
end

_G.td1madao_doPeriodicTask = function(inst, name, fun, period, clean, cleanFn)
    if not name then
        if not inst.td1madao_doPeriodicTask_task_adder then
            inst.td1madao_doPeriodicTask_task_adder = 0
        end
        name = "td1madao_doPeriodicTask_task_adder" .. tostring(inst.td1madao_doPeriodicTask_task_adder)
        inst.td1madao_doPeriodicTask_task_adder = inst.td1madao_doPeriodicTask_task_adder + 1
    end
    if inst and name then
        td1madao_removeTask(inst, name)
        td1madao_removeTask(inst, name .. "Cleaner")
        inst[name] = inst:DoPeriodicTask(period or 1, fun)
        inst[name .. "Cleaner"] = inst:DoTaskInTime(clean or 1, function()
            if cleanFn then
                cleanFn()
            end
            td1madao_removeTask(inst, name)
            td1madao_removeTask(inst, name .. "Cleaner")
        end)
    end
end

local function removePrefabLoopTask(inst)
    td1madao_removeTask(inst, "td1madao_PrefabloopTask_tag")
end

_G.td1madao_PrefabloopTask = function(inst, fun, period)
    if inst and not inst.components.playerprox then
        removePrefabLoopTask(inst)
        if not inst.components.playerprox then
            inst:AddComponent("playerprox")
        end
        inst.components.playerprox:SetDist(30, 30)
        inst.components.playerprox:SetOnPlayerNear(function()
            removePrefabLoopTask(inst)
            inst.td1madao_PrefabloopTask_tag = inst:DoPeriodicTask(period or 1, fun)
        end)
        inst.components.playerprox:SetOnPlayerFar(removePrefabLoopTask)
    end
end

_G.td1madao_prefabResponse = function(inst, response, fun)
    if inst and inst.components.inspectable then
        inst.components.inspectable.GetDescription = function(viewer)
            if fun then
                fun()
            end
            if not inst.components.talker then
                inst:AddComponent("talker")
            end
            inst.components.talker:Say(response)
            return STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper(inst.prefab)]
        end
    end
end

_G.td1madao_getstr = td1madao_getstr
_G.td1madao_getupper = td1madao_getupper
_G.td1madao_getcamel = td1madao_getcamel
_G.td1madao_safespawn = td1madao_safespawn
_G.td1madao_strconvert = td1madao_strconvert
_G.td1madao_iswater = td1madao_iswater
_G.td1madao_isInSW = td1madao_isInSW
_G.td1madao_enableSW = td1madao_enableSW
_G.td1madao_enableROG = td1madao_enableROG
_G.td1madao_enableDLC = td1madao_enableDLC

return td1madao_getstr,
td1madao_getupper,
td1madao_getcamel,
td1madao_safespawn,
td1madao_strconvert,
td1madao_iswater,
td1madao_isInSW,
td1madao_enableSW,
td1madao_enableROG,
td1madao_enableDLC