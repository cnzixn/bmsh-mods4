local Garenpacker = Class(function(self, inst)
    self.inst = inst
    self.canpackfn = nil
    self.garenpackage = nil
end)
function Garenpacker:Hasgarenpackage()
    return self.garenpackage ~= nil
end

function Garenpacker:SetCanPackFn(fn)
    self.canpackfn = fn
end

function Garenpacker.DefaultCanPackTest(target)
    return target
            and target:IsValid()
            and not target:IsInLimbo()
            and not (target:HasTag("teleportato")
            or target:HasTag("irreplaceable")
            or target:HasTag("player")
            or target:HasTag("nonpackable"))
end

function Garenpacker:CanPack(target)
    return self.inst:IsValid()
            and (not target.components
            or not target.components.garenpacker)
            and not self:Hasgarenpackage()
            and self.DefaultCanPackTest(target)
            and (not self.canpackfn or self.canpackfn(target, self.inst))
            and not target:HasTag("FX") and not target.components.circler
end

local function get_name(target, raw_name)
    local name = raw_name or target:GetDisplayName() or (target.components.named and target.components.named.name)
    if not name or name == "MISSING NAME" then return end
    if target.components.stackable then
        local size = target.components.stackable:StackSize()
        if size > 1 then
            name = name .. " x" .. tostring(size)
        end
    end
    return name
end

function Garenpacker:Pack(target)
    if not self:CanPack(target) then
        return false
    end
    self.garenpackage = {
        prefab = target.prefab,
        name = STRINGS.NAMES.GARENPACKAGED .. get_name(target),
    }
    self.garenpackage.data, self.garenpackage.refs = target:GetPersistData()
    target:Remove()
    return true
end

function Garenpacker:GetName()
    return self.garenpackage and self.garenpackage.name
end

local function freshen_refs(self)
    if self.garenpackage and self.garenpackage.refs then
    end
end

function Garenpacker:Unpack(pos)
    if not self.garenpackage then return end
    pos = pos and Game.ToPoint(pos) or self.inst:GetPosition()
    freshen_refs(self)
    local target = td1madao_safespawn(self.garenpackage.prefab)
    if target then
        target.Transform:SetPosition(pos:Get())
        local newents = {}
        if self.garenpackage.refs then
            for _, guid in ipairs(self.garenpackage.refs) do
                newents[guid] = { entity = _G.Ents[guid] }
            end
        end
        target:SetPersistData(self.garenpackage.data, newents)

        local newents2 = newents
        local savedata2 = self.garenpackage.data
        if newents2 and savedata2 and savedata2.childid then
            local child2 = newents2[savedata2.childid]
            if not child2 or not child.entity then
                newents[self.garenpackage.data.childid] = nil
            end
        end
        if newents2 and savedata2 then
            for k, p in pairs(savedata2) do
                local cmp = target.components[k]
                if cmp and cmp.LoadPostPass then
                    local savedata3 = p
                    if savedata3 and savedata3.childrenoutside then
                        for k, v in pairs(savedata3.childrenoutside) do
                            local child = newents2[v]
                            if not (child and child.entity) then
                                newents[v] = nil
                            end
                        end
                    end
                end
            end
        end
        target:LoadPostPass(newents, self.garenpackage.data)
        target.Transform:SetPosition(pos:Get())
        self.garenpackage = nil
        return true
    end
end

function Garenpacker:OnSave()
    if self.garenpackage then
        freshen_refs(self)
        return { garenpackage = self.garenpackage }, self.garenpackage.refs
    end
end

function Garenpacker:OnLoad(data)
    if data and data.garenpackage then
        self.garenpackage = data.garenpackage
    end
end

return Garenpacker