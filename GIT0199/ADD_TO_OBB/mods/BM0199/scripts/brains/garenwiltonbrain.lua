require "behaviours/wander"
require "behaviours/leash"
require "behaviours/doaction"
require "behaviours/chaseandattack"
require "behaviours/runaway"
local MAX_WANDER_DIST = 10
local RUN_AWAY_DIST = 5
local STOP_RUN_AWAY_DIST = 8
local MAX_CHASE_DIST = 30
local MAX_CHASE_TIME = 15
local function WanderTarget(inst)
    local combat = inst.components.combat
    if combat:ValidateTarget() then
        return Point(inst.components.combat.target.Transform:GetWorldPosition())
    end
    return nil
end

local GarenwiltonBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)
function GarenwiltonBrain:OnStart()
    local root = PriorityNode({
        WhileNode(function()
            if self.inst.protectedtask ~= nil then
                return false
            end
            return self.inst.components.combat.target == nil or not self.inst.components.combat:InCooldown()
        end,
            "AttackMomentarily",
            ChaseAndAttack(self.inst, MAX_CHASE_TIME, MAX_CHASE_DIST)),
        WhileNode(function()
            return self.inst.components.combat.target
        end,
            "Dodge", RunAway(self.inst, function()
                return self.inst.components.combat.target
            end, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST)),
        Wander(self.inst),
    }, 1)
    self.bt = BT(self.inst, root)
end

return GarenwiltonBrain
