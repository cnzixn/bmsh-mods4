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

if not td1madao_try(function()
    local a = _G.RECIPE_GAME_TYPE
end) then
    _G.RECIPE_GAME_TYPE = { SHIPWRECKED = "shipwrecked", ROG = "rog", COMMON = "common", VANILLA = "vanilla", }
end

if not td1madao_try(function()
    local a = _G.CAPY_DLC
end) then
    _G.CAPY_DLC = 0
end

if not td1madao_try(function()
    local a = _G.REIGN_OF_GIANTS
end) then
    _G.REIGN_OF_GIANTS = 0
end

RECIPE_GAME_TYPE = _G.RECIPE_GAME_TYPE
