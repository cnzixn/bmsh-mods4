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

local td1madao_get_class = Class(function(self) end)
local td1madao_set_class = Class(function(self) end)
local td1madao_default_class = Class(function(self) end)

function td1madao_get_class:__call(name)
    return _G.TUNING[name]
end

function td1madao_set_class:__call(name, value)
    _G.TUNING[name] = value
    return value
end

function td1madao_default_class:__call(name, value)
    if not _G.TUNING[name] then
        _G.TUNING[name] = value
    end
    return _G.TUNING[name]
end



td1madao_g = td1madao_get_class()
td1madao_s = td1madao_set_class()
td1madao_d = td1madao_default_class()

_G.td1madao_g = td1madao_g
_G.td1madao_s = td1madao_s
_G.td1madao_d = td1madao_d

return td1madao_g, td1madao_s, td1madao_d