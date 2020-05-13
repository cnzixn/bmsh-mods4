--[[
 -- @Description: init character's recipes
 -- If any question ,Please email me using Chinese to let me distinguish whether it is spam
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- @version 1.0.0
 -- @author td1madao
 -- @email td1madao@163.com
 -- @qq 360810498
 -- @date 16/8/6
 ]]

local garensoulball1 = Ingredient("garensoulball", 1)
garensoulball1.atlas = "images/inventoryimages/garensoulball.xml"
local garensoulballwhite1 = Ingredient("garensoulballwhite", 1)
garensoulballwhite1.atlas = "images/inventoryimages/garensoulballwhite.xml"
local garensoulballblue1 = Ingredient("garensoulballblue", 1)
garensoulballblue1.atlas = "images/inventoryimages/garensoulballblue.xml"
local garensoulballyellow1 = Ingredient("garensoulballyellow", 1)
garensoulballyellow1.atlas = "images/inventoryimages/garensoulballyellow.xml"
local garenmosquitocoils = Recipe("garenmosquitocoils", { Ingredient("beardhair", 3), Ingredient("slurtleslime", 1), Ingredient("cutreeds", 2) }, RECIPETABS.GARENTABS, TECH.NONE)
garenmosquitocoils.atlas = "images/inventoryimages/garenmosquitocoils.xml"
local doran = Recipe("doran", { Ingredient("bluegem", 1), garensoulballblue1 }, RECIPETABS.GARENTABS, TECH.NONE)
doran.atlas = "images/inventoryimages/doran.xml"
local garensoulball = Recipe("garensoulball", { Ingredient("cutreeds", 4), Ingredient("stinger", 8), Ingredient("marble", 2) }, RECIPETABS.GARENTABS, TECH.NONE)
garensoulball.atlas = "images/inventoryimages/garensoulball.xml"
local garensoulballadvance = Recipe("garensoulballadvance", { garensoulball1, Ingredient("greengem", 1) }, RECIPETABS.GARENTABS, TECH.NONE)
garensoulballadvance.atlas = "images/inventoryimages/garensoulballadvance.xml"
local garensoulballwhite = Recipe("garensoulballwhite", { Ingredient("slurtle_shellpieces", 2), Ingredient("mosquitosack", 2), Ingredient("marble", 2) }, RECIPETABS.GARENTABS, TECH.NONE)
garensoulballwhite.atlas = "images/inventoryimages/garensoulballwhite.xml"
local garensoulballblue = Recipe("garensoulballblue", { Ingredient("slurtleslime", 2), Ingredient("beardhair", 2), garensoulballwhite1 }, RECIPETABS.GARENTABS, TECH.NONE)
garensoulballblue.atlas = "images/inventoryimages/garensoulballblue.xml"
local garensoulballyellow = Recipe("garensoulballyellow", { Ingredient("cookedmandrake", 1), garensoulballblue1, garensoulball1 }, RECIPETABS.GARENTABS, TECH.NONE)
garensoulballyellow.atlas = "images/inventoryimages/garensoulballyellow.xml"
local garenhammer = Recipe("garenhammer", { Ingredient("greengem", 1), garensoulballblue1, Ingredient("slurper_pelt", 2) }, RECIPETABS.GARENTABS, TECH.NONE)
garenhammer.atlas = "images/inventoryimages/garenhammer.xml"
local garenhearthstone = Recipe("garenhearthstone", { Ingredient("compass", 1), Ingredient("heatrock", 1), garensoulballwhite1 },
    RECIPETABS.GARENTABS, TECH.NONE)
garenhearthstone.atlas = "images/inventoryimages/garenhearthstone.xml"
local garenporo = Recipe("garenporo", { garensoulball1, Ingredient("stinger", 40), Ingredient("mandrake", 1) }, RECIPETABS.GARENTABS, TECH.NONE)
garenporo.atlas = "images/inventoryimages/garenporo.xml"
if GLOBAL.SaveGameIndex and GLOBAL.SaveGameIndex.IsModeShipwrecked and GLOBAL.SaveGameIndex:IsModeShipwrecked() then
    local garenduck = Recipe("garenduck", { Ingredient("boards", 6), Ingredient("goldnugget", 5), Ingredient("snakeskin", 10) }, RECIPETABS.GARENTABS, { SCIENCE = 0 }, nil, "garenduck_placer", nil, nil, nil, true, 4)
    garenduck.atlas = "images/inventoryimages/garenduck.xml"
end
local garenmaxwelllight = Recipe("garenmaxwelllight", { Ingredient("fireflies", 6), Ingredient("butter", 2), Ingredient("marble", 4) },
    RECIPETABS.GARENTABS, TECH.NONE)
garenmaxwelllight.placer = "garenmaxwelllight_placer"
garenmaxwelllight.atlas = "images/inventoryimages/garenmaxwelllight.xml"
local garenmaxwellphonograph = Recipe("garenmaxwellphonograph", { Ingredient("onemanband", 2), Ingredient("panflute", 2), Ingredient("gears", 5) },
    RECIPETABS.GARENTABS, TECH.NONE)
garenmaxwellphonograph.placer = "garenmaxwellphonograph_placer"
garenmaxwellphonograph.atlas = "images/inventoryimages/garenmaxwellphonograph.xml"
local garenaccomplishment_shrine = Recipe("garenaccomplishment_shrine", { Ingredient("goldnugget", 10), Ingredient("marble", 3), Ingredient("gears", 6) },
    RECIPETABS.GARENTABS, TECH.NONE)
garenaccomplishment_shrine.placer = "garenaccomplishment_shrine_placer"
garenaccomplishment_shrine.atlas = "images/inventoryimages/garenaccomplishment_shrine.xml"
local garengarbageheap = Recipe("garengarbageheap", { Ingredient("spoiled_food", 5), Ingredient("charcoal", 1), Ingredient("cutgrass", 2) },
    RECIPETABS.GARENTABS, TECH.NONE)
garengarbageheap.placer = "garengarbageheap_placer"
garengarbageheap.atlas = "images/inventoryimages/garengarbageheap.xml"
local garenskullchest = Recipe("garenskullchest", { Ingredient("boards", 4), Ingredient("log", 1), Ingredient("goldnugget", 1) },
    RECIPETABS.GARENTABS, TECH.NONE)
garenskullchest.placer = "garenskullchest_placer"
garenskullchest.atlas = "images/inventoryimages/garenskullchest.xml"
garenskullchest.min_spacing = 1
local garenpandoras_chest = Recipe("garenpandoras_chest", { Ingredient("boards", 4), Ingredient("log", 1), Ingredient("goldnugget", 1) },
    RECIPETABS.GARENTABS, TECH.NONE)
garenpandoras_chest.min_spacing = 1
garenpandoras_chest.placer = "garenpandoras_chest_placer"
garenpandoras_chest.atlas = "images/inventoryimages/garenpandoras_chest.xml"
local function addRecipe(name, weapon)
    if _G.Prefabs[name] then
        local temp = Recipe(weapon, { Ingredient("bluegem", 1), Ingredient("goldnugget", 3), garensoulballwhite1 }, RECIPETABS.GARENTABS, TECH.NONE)
        temp.image = name .. ".tex"
    end
end

addRecipe("batbat", "garenweapon27")
addRecipe("nightsword", "garenweapon28")
addRecipe("tentaclespike", "garenweapon29")
addRecipe("ruins_bat", "garenweapon30")
addRecipe("cutlass", "garenweapon31")
addRecipe("hambat", "garenweapon32")

if _G.Prefabs.sari then
    sariPostInit()
end
if _G.Prefabs.yiyu then
    yiyuPostInit()
end
otherPostInit()