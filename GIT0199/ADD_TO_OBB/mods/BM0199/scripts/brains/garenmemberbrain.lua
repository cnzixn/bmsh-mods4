require "behaviours/follow"
require "behaviours/wander"
require "behaviours/attackwall"
require "behaviours/doaction"

local MIN_FOLLOW_DIST = 2
local MAX_FOLLOW_DIST = 15
local TARGET_FOLLOW_DIST = 9
local MAX_WANDER_DIST = 10

local SEE_PLAYER_DIST = 5
local SEE_FOOD_DIST = 10
local MAX_WANDER_DIST = 15
local MAX_CHASE_TIME = 20
local MAX_CHASE_DIST = 25
local RUN_AWAY_DIST = 6
local STOP_RUN_AWAY_DIST = 15
local SEE_WORK_DIST = 5
local SEE_WORK_DIST2 = 10
local pickableAfter = {
    log = true,
    pinecone = true,
    coconut = true,
    jungletreeseed = true,
    palmleaf = true,
    acorn = true,
    flint = true,
    rocks = true,
    goldnugget = true,
    twigs = true,
    cutgrass = true,
    nitre = true,
}
local function surrounder(inst, action)
    if inst.components.follower.leader then
        if action then
            local ba = inst.components.follower.leader:GetBufferedAction()
            if ba and ba.action and (not inst.playerbufferaction or (inst.playerbufferaction ~= ba.action and (ba.action == ACTIONS.CHOP or ba.action == ACTIONS.MINE or ba.action == ACTIONS.PICK))) and action == ba.action then
                inst.playerbufferaction = ba.action
                if inst.playerbufferactiontask then
                    inst.playerbufferactiontask:Cancel()
                    inst.playerbufferactiontask = nil
                end
                inst.playerbufferactiontask = inst:DoTaskInTime(30, function()
                    inst.playerbufferaction = nil
                    if inst.playerbufferactiontask then
                        inst.playerbufferactiontask:Cancel()
                        inst.playerbufferactiontask = nil
                    end
                end)
            end
            if inst.playerbufferaction and action == inst.playerbufferaction then
                return true
            else
                return false
            end
        end
        return true
    end
    local enemy = nil
    enemy = FindEntity(inst, SEE_PLAYER_DIST, function(guy)
        return guy:HasTag("player")
    end)
    return enemy == nil
end

local function GiveAction(inst)
    if inst.sg:HasStateTag("working") then
        return nil
    end
    if inst.components.follower.leader and inst.components.follower.leader:GetDistanceSqToInst(inst) >= MAX_FOLLOW_DIST * MAX_FOLLOW_DIST then
        return nil
    end
    if inst.belongtowhich ~= TUNING.GARENBELONG then
        return nil
    end
    local distances = SEE_WORK_DIST
    if inst.components.follower.leader then
        distances = SEE_WORK_DIST2
    end

    local giveItem = nil
    if not inst.components.inventory.itemslots then
        return nil
    end
    for k = 1, inst.components.inventory.maxslots do
        if inst.components.inventory.itemslots[k] and pickableAfter[inst.components.inventory.itemslots[k].prefab] then
            giveItem = inst.components.inventory.itemslots[k]
            break
        end
    end
    if giveItem and inst.components.follower and inst.components.follower.leader and inst.components.follower.leader.components.inventory
            and inst.components.follower.leader.components.inventory:CanAcceptCount(giveItem, giveItem.components.stackable.stacksize) > 0 then
        return giveItem
    end
    return nil
end

local function StealAction(inst)
    if inst.sg:HasStateTag("working") then
        return nil
    end
    if inst.components.follower.leader and inst.components.follower.leader:GetDistanceSqToInst(inst) >= MAX_FOLLOW_DIST * MAX_FOLLOW_DIST then
        return nil
    end
    if inst.nowisnight and not inst.components.follower.leader then
        return nil
    end
    local distances = SEE_WORK_DIST
    if inst.components.follower.leader and not inst.nowisnight then
        distances = SEE_WORK_DIST2
    end
    if not inst.components.inventory:IsFull() and inst.bufferedaction == nil then
        local target = FindEntity(inst, distances, function(item)
            if item.components.inventoryitem and
                    item.components.inventoryitem.canbepickedup and
                    not item.components.inventoryitem:IsHeld() and
                    item:IsOnValidGround() and
                    not item:HasTag("irreplaceable") and
                    not item:HasTag("nosteal") and
                    pickableAfter[item.prefab] then
                return true
            end
        end)
        if target then
            return target
        end
    end
    return nil
end

local function StealAction2(inst)
    if inst.sg:HasStateTag("working") then
        return nil
    end
    if inst.components.follower.leader and inst.components.follower.leader:GetDistanceSqToInst(inst) >= MAX_FOLLOW_DIST * MAX_FOLLOW_DIST then
        return nil
    end
    if inst.nowisnight and not inst.components.follower.leader then
        return nil
    end
    local distances = SEE_WORK_DIST
    if inst.components.follower.leader and not inst.nowisnight then
        distances = SEE_WORK_DIST2
    end
    if not inst.components.inventory:IsFull() and inst.bufferedaction == nil then
        local target = FindEntity(inst, distances, function(item)
            if
            (item.prefab == "grass" or item.prefab == "berrybush" or item.prefab == "berrybush2" or
                    item.prefab == "sapling")
                    and item.components.pickable and item.components.pickable:CanBePicked()
            then
                return true
            end
        end)
        if target then
            return target
        end
    end
    return nil
end

local function HasStateTags(inst, tags)
    for k, v in pairs(tags) do
        if inst.sg:HasStateTag(v) then
            return true
        end
    end
end

local function FindObjectToWorkAction(inst, action)
    if inst.sg:HasStateTag("working") then
        return
    end
    local distances = SEE_WORK_DIST
    if inst.components.follower.leader then
        distances = SEE_WORK_DIST2
    end
    local target = FindEntity(inst, distances, function(item)
        local res = item.components.workable and item.components.workable.action == action and not string.find(item.prefab, 'tent')
                and item.prefab ~= 'pighouse' and item.prefab ~= 'wildborehouse' and item.prefab ~= 'rabbithouse' and item.prefab ~= 'mermhouse'
                and item.prefab ~= 'mermhouse_fisher' and item.prefab ~= 'monkeybarrel' and item.prefab ~= 'primeapebarrel' and item.prefab ~= 'garenaccomplishment_shrine' and item.prefab ~= 'garenmaxwelllight'
        if res then
        end
        return res
    end)
    if target then
        return BufferedAction(inst, target, action)
    end
end

local function FindObjectToWorkAction2(inst, action)
    if inst.sg:HasStateTag("working") then
        return
    end
    local distances = SEE_WORK_DIST * 1.4
    local target = FindEntity(inst, distances, function(item)
        local res = item.components.workable and item.components.workable.action == action and not string.find(item.prefab, 'tent')
                and item.prefab ~= 'pighouse' and item.prefab ~= 'wildborehouse' and item.prefab ~= 'rabbithouse' and item.prefab ~= 'mermhouse'
                and item.prefab ~= 'mermhouse_fisher' and item.prefab ~= 'monkeybarrel' and item.prefab ~= 'primeapebarrel' and item.prefab ~= 'garenaccomplishment_shrine' and item.prefab ~= 'garenmaxwelllight'
        if res then
        end
        return res
    end)
    if target then
        return BufferedAction(inst, target, action)
    end
end

local function KeepWorkingAction(inst, actiontags)
    if inst.components.follower.leader and inst.components.follower.leader:GetDistanceSqToInst(inst) >= MAX_FOLLOW_DIST * MAX_FOLLOW_DIST then
        return false
    end
    local res = not inst.nowisnight
    return res
end

local function StartWorkingCondition(inst, actiontags)
    if inst.components.follower.leader and inst.components.follower.leader:GetDistanceSqToInst(inst) >= MAX_FOLLOW_DIST * MAX_FOLLOW_DIST then
        return false
    end
    local res = not HasStateTags(inst, actiontags) and not inst.nowisnight
    return res
end

local function StartWorkingCondition2(inst, actiontags)
    local res = not HasStateTags(inst, actiontags) and not inst.nowisnight and inst.enemywhich == TUNING.GARENBELONG
    return res
end


local Garenmemberbrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function GetHome(inst)
    if inst.components.follower.leader then
        return nil
    end
    return inst.components.homeseeker and inst.components.homeseeker.home
end

local function GetHomePos(inst)
    local home = GetHome(inst)
    return home and home:GetPosition()
end

local function EatFoodAction(inst)
    local target = nil
    local enemy = nil
    enemy = FindEntity(inst, 20, function(guy)
        return guy:HasTag("player")
    end)
    if enemy then
        return false
    end
    if inst.components.inventory and inst.components.eater then
        target = inst.components.inventory:FindItem(function(item) return inst.components.eater:CanEat(item) end)
    end
    if not target then
        target = FindEntity(inst, 30, function(item) return inst.components.eater:CanEat(item) end)
    end
    if target then
        return target
    end
    return false
end

function Garenmemberbrain:OnStart()
    local root = PriorityNode({
        WhileNode(function()
            if self.inst.components.combat.target and self.inst.components.combat.target:HasTag(self.inst.belongtowhich) and not self.inst.components.combat.target:HasTag("player") then
                self.inst.components.combat.target = nil
            end
            local enemy = self.inst.components.combat.target
            local dist = 999
            if enemy then
                local x1, y1, z1 = self.inst.Transform:GetWorldPosition()
                local x2, y2, z2 = enemy.Transform:GetWorldPosition()
                if x1 and x2 and z1 and z2 then
                    dist = math.sqrt((x1 - x2) * (x1 - x2) + (z1 - z2) * (z1 - z2))
                end
            end
            return enemy and (self.inst.myweapon == "swap_blowdart" or self.inst.myweapon == "swap_staffs")
                    and dist < 6 and self.inst.hurttime > 8
        end,
            "Dodge", RunAway(self.inst, function()
                return self.inst.components.combat.target
            end, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST)),
        IfNode(function() return self.inst.components.combat.target ~= nil end, "hastarget", AttackWall(self.inst)),
        WhileNode(function()
            if self.inst.components.combat.target and self.inst.components.combat.target:HasTag(self.inst.belongtowhich) and not self.inst.components.combat.target:HasTag("player") then
                self.inst.components.combat.target = nil
            end
            local oldcalculate = self.inst.calculate
            if oldcalculate <= 0 and not self.inst.renewtask then
                self.inst:DoTaskInTime(4, function()
                    self.inst.calculate = math.random(5)
                    if self.inst.renewtask then
                        self.inst.renewtask:Cancel()
                        self.inst.renewtask = nil
                    end
                end)
            end
            return (self.inst.components.combat.target == nil or not self.inst.components.combat:InCooldown()) and oldcalculate > 0
        end,
            "AttackMomentarily",
            ChaseAndAttack(self.inst, 20, 100)),
        WhileNode(function()
            if self.inst.components.combat.target and self.inst.components.combat.target:HasTag(self.inst.belongtowhich) and not self.inst.components.combat.target:HasTag("player") then
                self.inst.components.combat.target = nil
            end
            local enemy = self.inst.components.combat.target
            return enemy
        end,
            "Dodge", RunAway(self.inst, function()
                return self.inst.components.combat.target
            end, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST)),
        WhileNode(function()
            return EatFoodAction(self.inst)
        end, "Eat Food",
            DoAction(self.inst, function()
                local target = EatFoodAction(self.inst)
                local act = BufferedAction(self.inst, target, ACTIONS.EAT)
                act.validfn = function()
                    return not (target.components.inventoryitem and target.components.inventoryitem.owner and target.components.inventoryitem.owner ~= self.inst)
                end
                return act
            end)),
        WhileNode(function()
            return surrounder(self.inst) and StealAction(self.inst) ~= nil
        end, "steal",
            DoAction(self.inst, function()
                return BufferedAction(self.inst, StealAction(self.inst), ACTIONS.PICKUP)
            end)),
        WhileNode(function()
            return surrounder(self.inst, ACTIONS.PICK) and StealAction2(self.inst) ~= nil
        end, "steal2",
            DoAction(self.inst, function()
                return BufferedAction(self.inst, StealAction2(self.inst), ACTIONS.PICK)
            end)),
        WhileNode(function()
            return surrounder(self.inst, ACTIONS.CHOP) and StartWorkingCondition(self.inst, { "chopping", "prechop" }) and
                    KeepWorkingAction(self.inst, { "chopping", "prechop" })
        end, "keep chopping",
            DoAction(self.inst, function()
                return FindObjectToWorkAction(self.inst, ACTIONS.CHOP)
            end)),

        WhileNode(function()
            return surrounder(self.inst, ACTIONS.MINE) and StartWorkingCondition(self.inst, { "mining", "premine" }) and
                    KeepWorkingAction(self.inst, { "mining", "premine" })
        end, "keep mining",
            DoAction(self.inst, function()
                return FindObjectToWorkAction(self.inst, ACTIONS.MINE)
            end)),

        WhileNode(function()
            return surrounder(self.inst, ACTIONS.HAMMER) and StartWorkingCondition2(self.inst, { "hammering", "prehammer" }) and
                    KeepWorkingAction(self.inst, { "hammering", "prehammer" })
        end, "keep hammering",
            DoAction(self.inst, function()
                return FindObjectToWorkAction2(self.inst, ACTIONS.HAMMER)
            end)),

        WhileNode(function()
            return surrounder(self.inst) and GiveAction(self.inst) ~= nil
        end, "give",
            DoAction(self.inst, function()
                local item = GiveAction(self.inst)
                if item then
                    local hasComponent = item.components.tradable
                    if not hasComponent then
                        item:AddComponent("tradable")
                    end
                    local ba = BufferedAction(self.inst, self.inst.components.follower.leader, ACTIONS.GIVE, item)
                    return ba
                end
            end)),

        Follow(self.inst, function()
            return self.inst.components.follower.leader
        end, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
        WhileNode(function() return GetHome(self.inst) end, "HasHome", Wander(self.inst, GetHomePos, 15)),
        Wander(self.inst),
    }, .1)

    self.bt = BT(self.inst, root)
end

return Garenmemberbrain