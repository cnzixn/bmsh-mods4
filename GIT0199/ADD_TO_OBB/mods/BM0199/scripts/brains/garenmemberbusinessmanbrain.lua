require "behaviours/runaway"
require "behaviours/wander"
require "behaviours/doaction"

local AVOID_DIST = 20
local AVOID_STOP = 50
local NO_TAGS = { "FX", "NOCLICK", "DECOR", "INLIMBO", "stump", "burnt" }

local Garenmemberbusinessmanbrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

function Garenmemberbusinessmanbrain:OnStart()
    local root =
    PriorityNode({
        WhileNode(function() return self.inst.shutup end, "hurt", RunAway(self.inst, "player", AVOID_DIST, AVOID_STOP, nil, nil, NO_TAGS)),
        Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, 10),
    }, 1)
    self.bt = BT(self.inst, root)
end

function Garenmemberbusinessmanbrain:OnInitializationComplete()
    self.inst.components.knownlocations:RememberLocation("home", Point(self.inst.Transform:GetWorldPosition()), true)
end

return Garenmemberbusinessmanbrain
