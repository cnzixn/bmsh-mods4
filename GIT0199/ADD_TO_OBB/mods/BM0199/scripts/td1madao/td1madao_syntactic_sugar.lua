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

-- imitate java try catch
local td1madao_try_class = Class(function(self) end)

function td1madao_try_class:__call(tryfun)
    local success = true
    GLOBAL.xpcall(tryfun, function() success = false end)
    return success
end

td1madao_try = td1madao_try_class()
_G.td1madao_try = td1madao_try

return td1madao_try