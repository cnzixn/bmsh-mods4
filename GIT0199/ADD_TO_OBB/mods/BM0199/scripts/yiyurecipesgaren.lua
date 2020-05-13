local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local package = GLOBAL.package
local kleifileexists = GLOBAL.kleifileexists
local select = GLOBAL.select
local RECIPE_GAME_TYPE = GLOBAL.RECIPE_GAME_TYPE

local function existsYiyu(filepath)
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

local function RecipeYiyu(...)
    local b = select(1, ...)
    if _G.Recipes[b] then
        return {}
    end
    if b and existsYiyu('images/inventoryimages/' .. b .. '.xml') then
        return Recipe(...)
    elseif b and string.find(b, '_') and existsYiyu('images/inventoryimages/' .. string.sub(b, 0, string.find(b, '_') - 1) .. '.xml') then
        return Recipe(...)
    else
        return {}
    end
end

local function addAssert(name, atlas)
    if Assets and name and atlas and td1madao_file_exist(atlas) and not table.contains(Assets, atlas) then
        table.insert(Assets, atlas)
        name.atlas = atlas
    end
end

local function Ingredient2(...)
    local b = select(3, ...)
    if (not b) or (b and existsYiyu(b)) then
        return Ingredient(...)
    else
        local arg1 = select(1, ...)
        local arg2 = select(2, ...)
        return Ingredient(arg1, arg2)
    end
end


function yiyuPostInit()
    local crystal1 = Ingredient2("yiyucrystal", 5)
    addAssert(crystal1, "images/inventoryimages/yiyucrystal.xml")
    local crystal2 = Ingredient2("yiyucrystal", 1)
    addAssert(crystal2, "images/inventoryimages/yiyucrystal.xml")
    local darktrident = RecipeYiyu("darktrident", { Ingredient2("twigs", 2), Ingredient2("goldnugget", 2) }, RECIPETABS.YIYUTAB, { SCIENCE = 0 })
    addAssert(darktrident, "images/inventoryimages/darktrident.xml")
    local darktrident1 = Ingredient2("darktrident", 1)
    addAssert(darktrident1, "images/inventoryimages/darktrident.xml")
    local backcity = RecipeYiyu("backcity", { Ingredient2("goldnugget", 2), crystal2 }, RECIPETABS.YIYUTAB, { SCIENCE = 2 })
    addAssert(backcity, "images/inventoryimages/backcity.xml")
    local yiyutrap = RecipeYiyu("yiyutrap", { Ingredient2("goldnugget", 1), crystal2, Ingredient2("houndstooth", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 })
    addAssert(yiyutrap, "images/inventoryimages/yiyutrap.xml")
    local redgem = RecipeYiyu("redgem", { crystal1 }, RECIPETABS.REFINE, { SCIENCE = 0 })
    local bluegem = RecipeYiyu("bluegem", { crystal1 }, RECIPETABS.REFINE, { SCIENCE = 0 })


    if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) then
        rocks = RecipeYiyu("rocks", { Ingredient2("flint", 10) }, RECIPETABS.REFINE, { SCIENCE = 0 }, nil, nil, nil, 10)

        local bonealtar = RecipeYiyu("bonealtar", { Ingredient2("goldnugget", 10), Ingredient2("livinglog", 4), Ingredient2("pigskin", 6) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 }, "bonealtar_placer")
        addAssert(bonealtar, "images/inventoryimages/bonealtar.xml")

        local yiyubbq = RecipeYiyu("yiyubbq", { Ingredient2("cutstone", 2), Ingredient2("charcoal", 2), Ingredient2("rope", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 }, "yiyubbq_placer")
        addAssert(yiyubbq, "images/inventoryimages/yiyubbq.xml")

        local yiyubeebox = RecipeYiyu("yiyubeebox", { Ingredient2("honeycomb", 1), Ingredient2("bee", 5), Ingredient2("boards", 4) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 }, "yiyubeebox_placer")
        addAssert(yiyubeebox, "images/inventoryimages/yiyubeebox.xml")

        local palacelantern = RecipeYiyu("palacelantern", { Ingredient2("livinglog", 4), Ingredient2("cutstone", 4), Ingredient2("purplegem", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 }, "palacelantern_placer")
        addAssert(palacelantern, "images/inventoryimages/palacelantern.xml")

        local ronglu = RecipeYiyu("ronglu", { Ingredient2("livinglog", 4), Ingredient2("cutstone", 2), Ingredient2("purplegem", 5) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 }, "ronglu_placer")
        addAssert(ronglu, "images/inventoryimages/ronglu.xml")

        --local duanzao = RecipeYiyu("duanzao", {Ingredient2("cutstone", 1)}, RECIPETABS.YIYUTAB, {SCIENCE = 1}, nil, "duanzao_placer" )

        local yiyuhouse = RecipeYiyu("yiyuhouse", { Ingredient2("boards", 30), Ingredient2("cutstone", 30), Ingredient2("purplegem", 5) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, "yiyuhouse_placer")
        addAssert(yiyuhouse, "images/inventoryimages/yiyuhouse.xml")

        local yiyusword = RecipeYiyu("yiyusword", { Ingredient2("purplegem", 2), darktrident1, Ingredient2("gears", 2) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 })
        addAssert(yiyusword, "images/inventoryimages/yiyusword.xml")

        local yiyuhuan = RecipeYiyu("yiyuhuan", { Ingredient2("greengem", 2), darktrident1, Ingredient2("purplegem", 5) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 })
        addAssert(yiyuhuan, "images/inventoryimages/yiyuhuan.xml")

        local yiyusack = RecipeYiyu("yiyusack", { Ingredient2("bearger_fur", 1), Ingredient2("gears", 10), Ingredient2("purplegem", 4) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 })
        addAssert(yiyusack, "images/inventoryimages/yiyusack.xml")

        local yiyuhattop = RecipeYiyu("yiyuhattop", { Ingredient2("deerclops_eyeball", 1), Ingredient2("walrushat", 1), Ingredient2("purplegem", 4) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 })
        addAssert(yiyuhattop, "images/inventoryimages/yiyuhattop.xml")

        local yiyu_glass = RecipeYiyu("yiyu_glass", { Ingredient2("dragon_scales", 1), Ingredient2("purplegem", 10) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 })
        addAssert(yiyu_glass, "images/inventoryimages/yiyu_glass.xml")

        local magicflute = RecipeYiyu("magicflute", { Ingredient2("purplegem", 1), Ingredient2("horn", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 })
        addAssert(magicflute, "images/inventoryimages/magicflute.xml")

        local destructionflute = RecipeYiyu("destructionflute", { Ingredient2("glommerwings", 1), Ingredient2("glommerflower", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 })
        addAssert(destructionflute, "images/inventoryimages/destructionflute.xml")

        local snailarmor = RecipeYiyu("snailarmor", { Ingredient2("purplegem", 4), Ingredient2("pigskin", 4), Ingredient2("slurtle_shellpieces", 2) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 })
        addAssert(snailarmor, "images/inventoryimages/snailarmor.xml")

        local writingbrush = RecipeYiyu("writingbrush", { Ingredient2("greengem", 1), Ingredient2("manrabbit_tail", 10), Ingredient2("walrus_tusk", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 })
        addAssert(writingbrush, "images/inventoryimages/writingbrush.xml")

        local gardenershovel = RecipeYiyu("gardenershovel", { Ingredient2("purplegem", 2), Ingredient2("livinglog", 2), Ingredient2("goldnugget", 5) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 })
        addAssert(gardenershovel, "images/inventoryimages/gardenershovel.xml")

        local zijing = RecipeYiyu("zijing", { Ingredient2("purplegem", 1), Ingredient2("thulecite", 2) }, RECIPETABS.REFINE, { SCIENCE = 1 })
        addAssert(zijing, "images/inventoryimages/zijing.xml")

        local turf_yiyu1f = RecipeYiyu("turf_yiyu1f", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(turf_yiyu1f, "images/inventoryimages/turf_yiyu1f.xml")
        local turf_yiyu2f = RecipeYiyu("turf_yiyu2f", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(turf_yiyu2f, "images/inventoryimages/turf_yiyu2f.xml")
        local turf_yiyu3f = RecipeYiyu("turf_yiyu3f", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(turf_yiyu3f, "images/inventoryimages/turf_yiyu3f.xml")
        local turf_yiyua = RecipeYiyu("turf_yiyua", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(turf_yiyua, "images/inventoryimages/turf_yiyua.xml")
        local turf_yiyuc = RecipeYiyu("turf_yiyuc", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(turf_yiyuc, "images/inventoryimages/turf_yiyuc.xml")
        local turf_yiyub = RecipeYiyu("turf_yiyub", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(turf_yiyub, "images/inventoryimages/turf_yiyub.xml")
        local Turf_yiyu1d = RecipeYiyu("turf_yiyu1d", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu1d, "images/inventoryimages/turf_yiyu1d.xml")
        local Turf_yiyu2d = RecipeYiyu("turf_yiyu2d", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu2d, "images/inventoryimages/turf_yiyu2d.xml")
        local Turf_yiyu3d = RecipeYiyu("turf_yiyu3d", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu3d, "images/inventoryimages/turf_yiyu3d.xml")
        local Turf_yiyu4d = RecipeYiyu("turf_yiyu4d", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu4d, "images/inventoryimages/turf_yiyu4d.xml")
        local Turf_yiyu5d = RecipeYiyu("turf_yiyu5d", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu5d, "images/inventoryimages/turf_yiyu5d.xml")
        local Turf_yiyu6d = RecipeYiyu("turf_yiyu6d", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu6d, "images/inventoryimages/turf_yiyu6d.xml")
        local Turf_yiyu7d = RecipeYiyu("turf_yiyu7d", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu7d, "images/inventoryimages/turf_yiyu7d.xml")
        local Turf_yiyu8d = RecipeYiyu("turf_yiyu8d", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu8d, "images/inventoryimages/turf_yiyu8d.xml")
        local Turf_yiyu9d = RecipeYiyu("turf_yiyu9d", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu9d, "images/inventoryimages/turf_yiyu9d.xml")

        --------------------------------------------------------

    elseif not GLOBAL.SaveGameIndex:IsModeShipwrecked() then
        rocks = RecipeYiyu("rocks", { Ingredient2("flint", 10) }, RECIPETABS.REFINE, TECH.NONE, RECIPE_GAME_TYPE.ROG, nil, nil, nil, 10, true)

        local bonealtar = RecipeYiyu("bonealtar", { Ingredient2("goldnugget", 10), Ingredient2("livinglog", 4), Ingredient2("pigskin", 6) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 }, nil, "bonealtar_placer")
        addAssert(bonealtar, "images/inventoryimages/bonealtar.xml")

        local yiyubbq = RecipeYiyu("yiyubbq", { Ingredient2("cutstone", 2), Ingredient2("charcoal", 2), Ingredient2("rope", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 }, nil, "yiyubbq_placer")
        addAssert(yiyubbq, "images/inventoryimages/yiyubbq.xml")

        local yiyubeebox = RecipeYiyu("yiyubeebox", { Ingredient2("honeycomb", 1), Ingredient2("bee", 5), Ingredient2("boards", 4) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 }, nil, "yiyubeebox_placer")
        addAssert(yiyubeebox, "images/inventoryimages/yiyubeebox.xml")

        local palacelantern = RecipeYiyu("palacelantern", { Ingredient2("livinglog", 4), Ingredient2("cutstone", 4), Ingredient2("purplegem", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 }, nil, "palacelantern_placer")
        addAssert(palacelantern, "images/inventoryimages/palacelantern.xml")

        local ronglu = RecipeYiyu("ronglu", { Ingredient2("livinglog", 4), Ingredient2("cutstone", 2), Ingredient2("purplegem", 5) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 }, nil, "ronglu_placer")
        addAssert(ronglu, "images/inventoryimages/ronglu.xml")

        local yiyuhouse = RecipeYiyu("yiyuhouse", { Ingredient2("boards", 30), Ingredient2("cutstone", 30), Ingredient2("purplegem", 5) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, "yiyuhouse_placer")
        addAssert(yiyuhouse, "images/inventoryimages/yiyuhouse.xml")

        local boatrepairkit = RecipeYiyu("boatrepairkit", { Ingredient2("boards", 4), Ingredient2("stinger", 4), Ingredient2("rope", 2) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 }, nil, nil, nil, 1)

        local ryondae_item = RecipeYiyu("ryondae_item", { Ingredient2("greengem", 2), Ingredient2("livinglog", 4), Ingredient2("petals_evil", 9), }, RECIPETABS.YIYUTAB, { SCIENCE = 1 }, nil, nil, nil, 1)
        addAssert(ryondae_item, "images/inventoryimages/ryondae.xml")
        ryondae_item.image = "ryondae.tex"

        local yiyusword = RecipeYiyu("yiyusword", { Ingredient2("purplegem", 2), darktrident1, Ingredient2("gears", 2) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 })
        addAssert(yiyusword, "images/inventoryimages/yiyusword.xml")

        local yiyuhuan = RecipeYiyu("yiyuhuan", { Ingredient2("greengem", 2), darktrident1, Ingredient2("purplegem", 5) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 })
        addAssert(yiyuhuan, "images/inventoryimages/yiyuhuan.xml")

        local yiyusack = RecipeYiyu("yiyusack", { Ingredient2("bearger_fur", 1), Ingredient2("gears", 10), Ingredient2("purplegem", 4) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 })
        addAssert(yiyusack, "images/inventoryimages/yiyusack.xml")

        local yiyuhattop = RecipeYiyu("yiyuhattop", { Ingredient2("deerclops_eyeball", 1), Ingredient2("walrushat", 1), Ingredient2("purplegem", 4) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 })
        addAssert(yiyuhattop, "images/inventoryimages/yiyuhattop.xml")

        local yiyu_glass = RecipeYiyu("yiyu_glass", { Ingredient2("dragon_scales", 1), Ingredient2("purplegem", 10) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 })
        addAssert(yiyu_glass, "images/inventoryimages/yiyu_glass.xml")

        local magicflute = RecipeYiyu("magicflute", { Ingredient2("purplegem", 1), Ingredient2("horn", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 })
        addAssert(magicflute, "images/inventoryimages/magicflute.xml")

        local destructionflute = RecipeYiyu("destructionflute", { Ingredient2("glommerwings", 1), Ingredient2("glommerflower", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 })
        addAssert(destructionflute, "images/inventoryimages/destructionflute.xml")

        local snailarmor = RecipeYiyu("snailarmor", { Ingredient2("purplegem", 4), Ingredient2("pigskin", 4), Ingredient2("slurtle_shellpieces", 2) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 })
        addAssert(snailarmor, "images/inventoryimages/snailarmor.xml")

        local writingbrush = RecipeYiyu("writingbrush", { Ingredient2("greengem", 1), Ingredient2("manrabbit_tail", 10), Ingredient2("walrus_tusk", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 })
        addAssert(writingbrush, "images/inventoryimages/writingbrush.xml")

        local gardenershovel = RecipeYiyu("gardenershovel", { Ingredient2("purplegem", 2), Ingredient2("livinglog", 2), Ingredient2("goldnugget", 5) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 })
        addAssert(gardenershovel, "images/inventoryimages/gardenershovel.xml")

        local zijing = RecipeYiyu("zijing", { Ingredient2("purplegem", 1), Ingredient2("thulecite", 2) }, RECIPETABS.REFINE, { SCIENCE = 1 })
        addAssert(zijing, "images/inventoryimages/zijing.xml")

        local turf_yiyu1f = RecipeYiyu("turf_yiyu1f", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(turf_yiyu1f, "images/inventoryimages/turf_yiyu1f.xml")
        local turf_yiyu2f = RecipeYiyu("turf_yiyu2f", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(turf_yiyu2f, "images/inventoryimages/turf_yiyu2f.xml")
        local turf_yiyu3f = RecipeYiyu("turf_yiyu3f", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(turf_yiyu3f, "images/inventoryimages/turf_yiyu3f.xml")
        local turf_yiyua = RecipeYiyu("turf_yiyua", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(turf_yiyua, "images/inventoryimages/turf_yiyua.xml")
        local turf_yiyuc = RecipeYiyu("turf_yiyuc", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(turf_yiyuc, "images/inventoryimages/turf_yiyuc.xml")
        local turf_yiyub = RecipeYiyu("turf_yiyub", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(turf_yiyub, "images/inventoryimages/turf_yiyub.xml")
        local Turf_yiyu1d = RecipeYiyu("turf_yiyu1d", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu1d, "images/inventoryimages/turf_yiyu1d.xml")
        local Turf_yiyu2d = RecipeYiyu("turf_yiyu2d", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu2d, "images/inventoryimages/turf_yiyu2d.xml")
        local Turf_yiyu3d = RecipeYiyu("turf_yiyu3d", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu3d, "images/inventoryimages/turf_yiyu3d.xml")
        local Turf_yiyu4d = RecipeYiyu("turf_yiyu4d", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu4d, "images/inventoryimages/turf_yiyu4d.xml")
        local Turf_yiyu5d = RecipeYiyu("turf_yiyu5d", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu5d, "images/inventoryimages/turf_yiyu5d.xml")
        local Turf_yiyu6d = RecipeYiyu("turf_yiyu6d", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu6d, "images/inventoryimages/turf_yiyu6d.xml")
        local Turf_yiyu7d = RecipeYiyu("turf_yiyu7d", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu7d, "images/inventoryimages/turf_yiyu7d.xml")
        local Turf_yiyu8d = RecipeYiyu("turf_yiyu8d", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu8d, "images/inventoryimages/turf_yiyu8d.xml")
        local Turf_yiyu9d = RecipeYiyu("turf_yiyu9d", { crystal2, Ingredient2("beefalowool", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu9d, "images/inventoryimages/turf_yiyu9d.xml")

        --------------------------------------------------------

    elseif GLOBAL.SaveGameIndex:IsModeShipwrecked() then
        rocks = RecipeYiyu("rocks", { Ingredient2("flint", 10) }, RECIPETABS.REFINE, TECH.NONE, RECIPE_GAME_TYPE.SHIPWRECKED, nil, nil, nil, 10, true)

        local bonealtar = RecipeYiyu("bonealtar", { Ingredient2("dubloon", 6), Ingredient2("livinglog", 4), Ingredient2("pigskin", 4) }, RECIPETABS.YIYUTAB, TECH.SCIENCE_ONE, RECIPE_GAME_TYPE.SHIPWRECKED, "bonealtar_placer")
        addAssert(bonealtar, "images/inventoryimages/bonealtar.xml")

        local yiyubbq = RecipeYiyu("yiyubbq", { Ingredient2("cutstone", 2), Ingredient2("charcoal", 2), Ingredient2("rope", 1) }, RECIPETABS.YIYUTAB, TECH.SCIENCE_ONE, RECIPE_GAME_TYPE.SHIPWRECKED, "yiyubbq_placer")
        addAssert(yiyubbq, "images/inventoryimages/yiyubbq.xml")

        local yiyubeebox = RecipeYiyu("yiyubeebox", { Ingredient2("honeycomb", 1), Ingredient2("bee", 5), Ingredient2("boards", 4) }, RECIPETABS.YIYUTAB, TECH.SCIENCE_ONE, RECIPE_GAME_TYPE.SHIPWRECKED, "yiyubeebox_placer")
        addAssert(yiyubeebox, "images/inventoryimages/yiyubeebox.xml")

        local palacelantern = RecipeYiyu("palacelantern", { Ingredient2("livinglog", 3), Ingredient2("cutstone", 4), Ingredient2("purplegem", 1) }, RECIPETABS.YIYUTAB, TECH.SCIENCE_ONE, RECIPE_GAME_TYPE.SHIPWRECKED, "palacelantern_placer")
        addAssert(palacelantern, "images/inventoryimages/palacelantern.xml")

        local ronglu = RecipeYiyu("ronglu", { Ingredient2("livinglog", 4), Ingredient2("cutstone", 2), Ingredient2("purplegem", 5) }, RECIPETABS.YIYUTAB, TECH.SCIENCE_ONE, RECIPE_GAME_TYPE.SHIPWRECKED, "ronglu_placer")
        addAssert(ronglu, "images/inventoryimages/ronglu.xml")

        local duanzao = RecipeYiyu("duanzao", { Ingredient2("cutstone", 1) }, RECIPETABS.YIYUTAB, TECH.SCIENCE_ONE, RECIPE_GAME_TYPE.SHIPWRECKED, "duanzao_placer")
        addAssert(duanzao, "images/inventoryimages/duanzao.xml")

        local yiyuhouse = RecipeYiyu("yiyuhouse", { Ingredient2("boards", 30), Ingredient2("cutstone", 30), Ingredient2("purplegem", 3) }, RECIPETABS.YIYUTAB, TECH.SCIENCE_TWO, RECIPE_GAME_TYPE.SHIPWRECKED, "ronglu_placer")
        addAssert(yiyuhouse, "images/inventoryimages/yiyuhouse.xml")

        local ryondae_item = RecipeYiyu("ryondae_item", { Ingredient2("purplegem", 2), Ingredient2("livinglog", 4), Ingredient2("petals_evil", 9), }, RECIPETABS.YIYUTAB, { SCIENCE = 1 }, nil, nil, nil, 1)
        addAssert(ryondae_item, "images/inventoryimages/ryondae.xml")
        ryondae_item.image = "ryondae.tex"

        local yiyusword = RecipeYiyu("yiyusword", { Ingredient2("purplegem", 1), darktrident1, Ingredient2("gears", 2) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 })
        addAssert(yiyusword, "images/inventoryimages/yiyusword.xml")

        local yiyuhuan = RecipeYiyu("yiyuhuan", { Ingredient2("purplegem", 5), darktrident1, Ingredient2("gears", 4) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 })
        addAssert(yiyuhuan, "images/inventoryimages/yiyuhuan.xml")

        local yiyusack = RecipeYiyu("yiyusack", { Ingredient2("seashell", 20), Ingredient2("blubber", 10), Ingredient2("shark_gills", 5) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 })
        addAssert(yiyusack, "images/inventoryimages/yiyusack.xml")

        local yiyuhattop = RecipeYiyu("yiyuhattop", { Ingredient2("magic_seal", 1), Ingredient2("tigereye", 2), Ingredient2("doydoyfeather", 8) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 })
        addAssert(yiyuhattop, "images/inventoryimages/yiyuhattop.xml")

        local yiyu_glass = RecipeYiyu("yiyu_glass", { Ingredient2("purplegem", 8), Ingredient2("obsidian", 20) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 })
        addAssert(yiyu_glass, "images/inventoryimages/yiyu_glass.xml")

        local magicflute = RecipeYiyu("magicflute", { Ingredient2("purplegem", 1), Ingredient2("ox_horn", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 })
        addAssert(magicflute, "images/inventoryimages/magicflute.xml")

        local destructionflute = RecipeYiyu("destructionflute", { crystal1, Ingredient2("coconade", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 })
        addAssert(destructionflute, "images/inventoryimages/destructionflute.xml")

        local snailarmor = RecipeYiyu("snailarmor", { Ingredient2("purplegem", 2), Ingredient2("pigskin", 4), Ingredient2("seashell", 10) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 })
        addAssert(snailarmor, "images/inventoryimages/snailarmor.xml")

        local writingbrush = RecipeYiyu("writingbrush", { Ingredient2("purplegem", 4), Ingredient2("beardhair", 15), Ingredient2("bamboo", 20) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 })
        addAssert(writingbrush, "images/inventoryimages/writingbrush.xml")

        local gardenershovel = RecipeYiyu("gardenershovel", { Ingredient2("purplegem", 2), Ingredient2("livinglog", 2), Ingredient2("goldnugget", 5) }, RECIPETABS.YIYUTAB, { SCIENCE = 1 })
        addAssert(gardenershovel, "images/inventoryimages/gardenershovel.xml")

        local zijing = RecipeYiyu("zijing", { Ingredient2("purplegem", 1), Ingredient2("obsidian", 2) }, RECIPETABS.REFINE, { SCIENCE = 1 })
        addAssert(zijing, "images/inventoryimages/zijing.xml")

        local turf_yiyu1f = RecipeYiyu("turf_yiyu1f", { crystal2, Ingredient2("limestone", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(turf_yiyu1f, "images/inventoryimages/turf_yiyu1f.xml")
        local turf_yiyu2f = RecipeYiyu("turf_yiyu2f", { crystal2, Ingredient2("limestone", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(turf_yiyu2f, "images/inventoryimages/turf_yiyu2f.xml")
        local turf_yiyu3f = RecipeYiyu("turf_yiyu3f", { crystal2, Ingredient2("limestone", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(turf_yiyu3f, "images/inventoryimages/turf_yiyu3f.xml")
        local turf_yiyua = RecipeYiyu("turf_yiyua", { crystal2, Ingredient2("limestone", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(turf_yiyua, "images/inventoryimages/turf_yiyua.xml")
        local turf_yiyuc = RecipeYiyu("turf_yiyuc", { crystal2, Ingredient2("limestone", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(turf_yiyuc, "images/inventoryimages/turf_yiyuc.xml")
        local turf_yiyub = RecipeYiyu("turf_yiyub", { crystal2, Ingredient2("limestone", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(turf_yiyub, "images/inventoryimages/turf_yiyub.xml")
        local Turf_yiyu1d = RecipeYiyu("turf_yiyu1d", { crystal2, Ingredient2("limestone", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu1d, "images/inventoryimages/turf_yiyu1d.xml")
        local Turf_yiyu2d = RecipeYiyu("turf_yiyu2d", { crystal2, Ingredient2("limestone", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu2d, "images/inventoryimages/turf_yiyu2d.xml")
        local Turf_yiyu3d = RecipeYiyu("turf_yiyu3d", { crystal2, Ingredient2("limestone", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu3d, "images/inventoryimages/turf_yiyu3d.xml")
        local Turf_yiyu4d = RecipeYiyu("turf_yiyu4d", { crystal2, Ingredient2("limestone", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu4d, "images/inventoryimages/turf_yiyu4d.xml")
        local Turf_yiyu5d = RecipeYiyu("turf_yiyu5d", { crystal2, Ingredient2("limestone", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu5d, "images/inventoryimages/turf_yiyu5d.xml")
        local Turf_yiyu6d = RecipeYiyu("turf_yiyu6d", { crystal2, Ingredient2("limestone", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu6d, "images/inventoryimages/turf_yiyu6d.xml")
        local Turf_yiyu7d = RecipeYiyu("turf_yiyu7d", { crystal2, Ingredient2("limestone", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu7d, "images/inventoryimages/turf_yiyu7d.xml")
        local Turf_yiyu8d = RecipeYiyu("turf_yiyu8d", { crystal2, Ingredient2("limestone", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu8d, "images/inventoryimages/turf_yiyu8d.xml")
        local Turf_yiyu9d = RecipeYiyu("turf_yiyu9d", { crystal2, Ingredient2("limestone", 1), Ingredient2("goldnugget", 1) }, RECIPETABS.YIYUTAB, { SCIENCE = 2 }, nil, nil, nil, 1)
        addAssert(Turf_yiyu9d, "images/inventoryimages/turf_yiyu9d.xml")
    end
end