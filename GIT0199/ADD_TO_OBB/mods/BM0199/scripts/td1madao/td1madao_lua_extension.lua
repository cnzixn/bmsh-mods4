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

-- lua size symbol ('#') is not accuracy when there is a 'nil' in the middle of a table
if not table.size then
    table.size = function(arr)
        local size = 0
        if arr ~= nil then
            for k, v in pairs(arr) do
                if k and k > size then
                    size = k
                end
            end
        end
        if #arr > size then
            size = #arr
        end
        return size
    end
end