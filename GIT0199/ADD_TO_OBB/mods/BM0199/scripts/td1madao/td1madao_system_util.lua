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

local td1madao_file_exist_class = Class(function(self) end)

function td1madao_file_exist_class:__call(filepath)
    local filepath = string.gsub(filepath, "^/", "")
    local searchpaths = package.path
    for path in string.gmatch(searchpaths, "([^;]+)") do
        local filename = string.gsub(path, "scripts\\%?%.lua", filepath)
        filename = string.gsub(filename, "\\", "/")
        if not kleifileexists or kleifileexists(filename) then
            return true
        end
    end
    if not kleifileexists or kleifileexists(filepath) then
        return true
    end
    return false
end

td1madao_file_exist = td1madao_file_exist_class()
_G.td1madao_file_exist = td1madao_file_exist

return td1madao_file_exist