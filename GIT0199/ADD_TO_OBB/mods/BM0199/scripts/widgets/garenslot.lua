local ItemSlot = require "widgets/itemslot"
local Garenitem = require "widgets/garenitem"
local Text = require "widgets/text"

local Garenslot = Class(ItemSlot, function(self, name, x, y, z, price, account, caller, notclickable)
    ItemSlot._ctor(self, "images/hud.xml", "inv_slot.tex", GetPlayer())
    local obj = td1madao_safespawn(name)
    self:SetPosition(x, y, z)
    self.avalid = obj.components.inventoryitem ~= nil
    if not self.avalid then
        return
    end
    self.tile = Garenitem(obj)
    self:SetTile(self.tile)
    self.price = price
    self.name = name
    self.caller = caller
    self.account = account
    self.cgarentclick = (notclickable == true)
    self:SetQuantity()
    if obj then
        obj:Remove()
    end
end)

function Garenslot:OnControl(control, down)
    if down and not Garenslot._base.OnControl(self, control, down) and control == CONTROL_ACCEPT then
        if self.cgarentclick then
            return
        end
        local player = GetPlayer()
        local account2 = self.account
        if not account2 then
            account2 = 0
            self.account = 0
        end
        if player.components.td1madao_leveler:moneyEnough(self.price) and account2 > 0 then
            if self.caller then
                for i = 1, #self.caller.goods do
                    if self.caller.goods[i].name == self.name then
                        if self.caller.goods[i].account then
                            player.components.td1madao_leveler:useMoney(self.price)
                            c_give(self.name)
                            if self.caller and self.caller.goods and self.caller.goods[i] and self.caller.goods[i].account then
                                self.caller.goods[i].account = self.caller.goods[i].account - 1
                            end
                            self.account = self.account - 1
                        else
                            self.caller.goods[i].account = 0
                        end
                        self:SetQuantity()
                        break
                    end
                end
            end
        end
    end
end

function Garenslot:SetQuantity()
    if self.cgarentclick then
        return
    end
    if not self.avalid then
        return
    end
    if not self.tile.quantity then
        self.tile.quantity = self:AddChild(Text(NUMBERFONT, 30))
        self.tile.quantity:SetPosition(-1, 0, 0)
        self.tile.quantity:SetHAlign(ANCHOR_LEFT)
    end
    local account2 = self.account
    if not account2 then
        account2 = 0
    end
    self.tile.quantity:SetString("$" .. tostring(self.price) .. "\nX" .. account2)
end


return Garenslot
