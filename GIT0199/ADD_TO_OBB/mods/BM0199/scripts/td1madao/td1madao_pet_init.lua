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

AddClassPostConstruct("components/health", function(self)
    local original_SetVal = self.SetVal
    self.SetVal = function(self, val, cause)
        original_SetVal(self, val, cause)
        local ent = self.inst
        if ent and (ent.prefab == td1madao_getstr('%ssoulball') or ent.prefab == td1madao_getstr('%ssoulballadvance')) and ent.sealcreature
                and ent.sealcreature ~= 0 and ent.calculateAttribute then
            ent.creaturecurrenthealth = ent.components.health.currenthealth
            ent.calculateAttribute(ent)
        end
    end
end)