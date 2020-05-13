local Image = require "widgets/image"
local Widget = require "widgets/widget"

local Garenitem = Class(Widget, function(self, item)
    Widget._ctor(self, "Garenitem")
    if item.components.inventoryitem == nil then
        return
    end
    self.image = self:AddChild(Image(item.components.inventoryitem:GetAtlas(), item.components.inventoryitem:GetImage()))
end)

return Garenitem
