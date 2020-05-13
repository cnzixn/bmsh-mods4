local ModManager = _G.ModManager
local oldfun = ModManager.RegisterPrefabs
ModManager.ModWranglerCycle_garen = false
modimport("scripts/garenchinesegbk.lua")
modimport("scripts/garenchineseutf8.lua")
ModManager.RegisterPrefabs = function(x, y, ...)
    if not ModManager.ModWranglerCycle_garen then
        ModManager.ModWranglerCycle_garen = true
        modimport("scripts/garenchinesegbk.lua")
        modimport("scripts/garenchineseutf8.lua")
    end
    oldfun(x, y, ...)
end