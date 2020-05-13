local easing = require("easing")
local XxxMagic = Class(function(self, inst)
    self.inst = inst
    self.max = 100
    self.current = 0
    self.inst:DoPeriodicTask(5, function()
        local add = 0
        if self.inst.blueBuffSaveDay and self.inst.blueBuffSaveDay > 0 then
            add = 4
        end
        self:DoDelta(-1 + add)
    end)
end)

function XxxMagic:DoDelta(val)
    local oldpercent = self.current / self.max
    if self.current < self.max and not val then
        self.current = self.current + 1
    elseif val then
        self.current = self.current + val
        if self.current < 0 then
            self.current = 0
        elseif self.current > self.max then
            self.current = self.max
        end
    end
    self.inst:PushEvent("xxxmagic_garendelta", { oldpercent = oldpercent, newpercent = self.current / self.max })
end

function XxxMagic:GetPercent()
    return self.current / self.max
end

return XxxMagic