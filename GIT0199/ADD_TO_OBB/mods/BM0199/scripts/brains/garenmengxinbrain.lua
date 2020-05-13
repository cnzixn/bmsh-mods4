require "behaviours/runaway"
require "behaviours/wander"
require "behaviours/doaction"
require "behaviours/follow"

local MIN_FOLLOW_DIST = 5
local TARGET_FOLLOW_DIST = 7
local MAX_FOLLOW_DIST = 10
local RUN_AWAY_DIST = 7
local STOP_RUN_AWAY_DIST = 15

local Garenmengxinbrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

function Garenmengxinbrain:OnStart()
    local root =
    PriorityNode({
        --In combat (with the player)... Should only ever use poop throwing.
        RunAway(self.inst, self.inst.enemywhich or "player", RUN_AWAY_DIST, STOP_RUN_AWAY_DIST, function() return self.inst.hurted end),
        --Following
        Follow(self.inst, function() return not self.inst.hurted and not (self.inst.checkfollow and self.inst.checkfollow()) and not self.inst.lockEnemy and GetPlayer() end, self.inst.MIN_FOLLOW_DIST or MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
        --Doing nothing
        WhileNode(function() return not self.inst.hurted end, "Wander Around Leader",
            Wander(self.inst, function() if not self.inst.hurted and not self.inst.lockEnemy and not (self.inst.checkfollow and self.inst.checkfollow()) then
                return GetPlayer():GetPosition()
            end
            end, MAX_FOLLOW_DIST)),
        Wander(self.inst),
    }, 1)
    self.bt = BT(self.inst, root)
end

return Garenmengxinbrain
