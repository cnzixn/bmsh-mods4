local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local package = GLOBAL.package
local kleifileexists = GLOBAL.kleifileexists
local select = GLOBAL.select
local RECIPE_GAME_TYPE = GLOBAL.RECIPE_GAME_TYPE

local function existsSari(filepath)
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

local function RecipeSari(...)
    local b = select(1, ...)
    if _G.Recipes[b] then
        return {}
    end
    if b and existsSari('images/inventoryimages/' .. b .. '.xml') then
        return Recipe(...)
    elseif b and string.find(b, '_') and existsSari('images/inventoryimages/' .. string.sub(b, 0, string.find(b, '_') - 1) .. '.xml')
            and b ~= 'saricatsword_cat'
    then
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
    if (not b) or (b and existsSari(b)) then
        return Ingredient(...)
    else
        local arg1 = select(1, ...)
        local arg2 = select(2, ...)
        return Ingredient(arg1, arg2)
    end
end

function sariPostInit()

    if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) then --- -单开巨人国
    ---- 地毯1
    local turf_saria1 = RecipeSari("turf_saria1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_saria1, "images/inventoryimages/turf_saria1.xml")
    --- -地毯2
    local turf_sarib1 = RecipeSari("turf_sarib1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarib1, "images/inventoryimages/turf_sarib1.xml")
    --- -地毯3
    local turf_saric1 = RecipeSari("turf_saric1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_saric1, "images/inventoryimages/turf_saric1.xml")
    --- -地毯4
    local turf_sarid1 = RecipeSari("turf_sarid1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarid1, "images/inventoryimages/turf_sarid1.xml")
    --- -地毯5
    local turf_sarie1 = RecipeSari("turf_sarie1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarie1, "images/inventoryimages/turf_sarie1.xml")
    --- -地毯6
    local turf_sarif1 = RecipeSari("turf_sarif1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarif1, "images/inventoryimages/turf_sarif1.xml")
    --- -地毯7
    local turf_sarig1 = RecipeSari("turf_sarig1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarig1, "images/inventoryimages/turf_sarig1.xml")
    --- -地毯8
    local turf_sarih1 = RecipeSari("turf_sarih1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarih1, "images/inventoryimages/turf_sarih1.xml")
    --- -地毯9
    local turf_sarii1 = RecipeSari("turf_sarii1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarii1, "images/inventoryimages/turf_sarii1.xml")
    --- -猫尾巴
    local coontail = RecipeSari("coontail", { Ingredient2("rope", 1), Ingredient2("petals", 1) }, GLOBAL.RECIPETABS.SARITAB, { SCIENCE = 0 }, nil, nil, nil, 1)
    --- -旧钟图纸
    local bell_blueprint = RecipeSari("bell_blueprint", { Ingredient2("papyrus", 2), Ingredient2("purplegem", 1), Ingredient2("orangegem", 1), Ingredient2("yellowgem", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(bell_blueprint, "images/inventoryimages/bell_blueprint.xml")
    bell_blueprint.image = "bell_blueprint.tex"
    --- -中空树屋
    local catcoonden = RecipeSari("catcoonden",
        {
            Ingredient2("coontail", 2),
            Ingredient2("log", 4),
        },
        GLOBAL.RECIPETABS.SARITAB, { SCIENCE = 1 }, "catcoonden_placer", 2)
    addAssert(catcoonden, "images/inventoryimages/catcoonden.xml")
    catcoonden.image = "catcoonden.tex"
    --- -鸟笼
    local saribirdcage = RecipeSari("saribirdcage",
        {
            Ingredient2("coontail", 2),
            Ingredient2("charcoal", 6),
            Ingredient2("papyrus", 2),
        },
        GLOBAL.RECIPETABS.SARITAB, { SCIENCE = 1 }, "saribirdcage_placer", 2.5)
    addAssert(saribirdcage, "images/inventoryimages/saribirdcage.xml")
    saribirdcage.image = "saribirdcage.tex"
    --- -粉色箱子
    local saritreasurechest = RecipeSari("saritreasurechest",
        {
            Ingredient2("boards", 3),
            Ingredient2("petals", 1),
        },
        GLOBAL.RECIPETABS.SARITAB, { SCIENCE = 1 }, "saritreasurechest_placer", 1)
    addAssert(saritreasurechest, "images/inventoryimages/saritreasurechest.xml")
    saritreasurechest.image = "saritreasurechest.tex"
    --- -粉色帽子
    local sarihattop = RecipeSari("sarihattop",
        {
            Ingredient2("coontail", 2),
            Ingredient2("spidergland", 3),
            Ingredient2("silk", 3)
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE)
    addAssert(sarihattop, "images/inventoryimages/sarihattop.xml")
    --- -魔法帽子
    local sarimagicalhats = RecipeSari("sarimagicalhats",
        {
            Ingredient2("rabbit", 9),
            Ingredient2("tophat", 1),
            Ingredient2("gears", 2)
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE)
    addAssert(sarimagicalhats, "images/inventoryimages/sarimagicalhats.xml")
    --- -猫包
    local saribackpack = RecipeSari("saribackpack",
        {
            Ingredient2("coontail", 8),
            Ingredient2("livinglog", 8),
            Ingredient2("purplegem", 2)
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE)
    addAssert(saribackpack, "images/inventoryimages/saribackpack.xml")
    --- -猫长剑
    local saricatsword_cat = RecipeSari("saricatsword_cat",
        {
            Ingredient2("coontail", 9),
            Ingredient2("nitre", 9),
            Ingredient2("transistor", 9)
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE)
    addAssert(saricatsword_cat, "images/inventoryimages/saricatsword_cat.xml")
    --- -小花伞
    local sariftumbrella = RecipeSari("sariftumbrella",
        {
            Ingredient2("twigs", 2),
            Ingredient2("silk", 4),
            Ingredient2("coontail", 2)
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE)
    addAssert(sariftumbrella, "images/inventoryimages/sariftumbrella.xml")
    --- -巨锤
    local saricth = RecipeSari("saricth",
        {
            Ingredient2("hammer", 1),
            Ingredient2("goldnugget", 1),
            Ingredient2("cutstone", 2)
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE)
    addAssert(saricth, "images/inventoryimages/saricth.xml")
    ---------------------------------------------------------------------------------------
    elseif not GLOBAL.SaveGameIndex:IsModeShipwrecked() then --- -包含海难的巨人国
    ---- 地毯1
    local turf_saria1 = RecipeSari("turf_saria1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_saria1, "images/inventoryimages/turf_saria1.xml")
    --- -地毯2
    local turf_sarib1 = RecipeSari("turf_sarib1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarib1, "images/inventoryimages/turf_sarib1.xml")
    --- -地毯3
    local turf_saric1 = RecipeSari("turf_saric1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_saric1, "images/inventoryimages/turf_saric1.xml")
    --- -地毯4
    local turf_sarid1 = RecipeSari("turf_sarid1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarid1, "images/inventoryimages/turf_sarid1.xml")
    --- -地毯5
    local turf_sarie1 = RecipeSari("turf_sarie1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarie1, "images/inventoryimages/turf_sarie1.xml")
    --- -地毯6
    local turf_sarif1 = RecipeSari("turf_sarif1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarif1, "images/inventoryimages/turf_sarif1.xml")
    --- -地毯7
    local turf_sarig1 = RecipeSari("turf_sarig1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarig1, "images/inventoryimages/turf_sarig1.xml")
    --- -地毯8
    local turf_sarih1 = RecipeSari("turf_sarih1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarih1, "images/inventoryimages/turf_sarih1.xml")
    --- -地毯9
    local turf_sarii1 = RecipeSari("turf_sarii1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarii1, "images/inventoryimages/turf_sarii1.xml")
    --- -猫尾巴
    local coontail = RecipeSari("coontail", { Ingredient2("rope", 1), Ingredient2("petals", 1) }, GLOBAL.RECIPETABS.SARITAB, { SCIENCE = 0 }, nil, nil, nil, 1)
    --- -旧钟图纸
    local bell_blueprint = RecipeSari("bell_blueprint", { Ingredient2("papyrus", 2), Ingredient2("purplegem", 1), Ingredient2("orangegem", 1), Ingredient2("yellowgem", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(bell_blueprint, "images/inventoryimages/bell_blueprint.xml")
    bell_blueprint.image = "bell_blueprint.tex"
    --- -中空树屋
    local catcoonden = RecipeSari("catcoonden",
        {
            Ingredient2("coontail", 2),
            Ingredient2("log", 4),
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE, GLOBAL.RECIPE_GAME_TYPE.COMMON, "catcoonden_placer", 2)
    addAssert(catcoonden, "images/inventoryimages/catcoonden.xml")
    catcoonden.image = "catcoonden.tex"
    --- -鸟笼
    local saribirdcage = RecipeSari("saribirdcage",
        {
            Ingredient2("coontail", 2),
            Ingredient2("charcoal", 6),
            Ingredient2("papyrus", 2),
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE, GLOBAL.RECIPE_GAME_TYPE.COMMON, "saribirdcage_placer", 2.5)
    addAssert(saribirdcage, "images/inventoryimages/saribirdcage.xml")
    saribirdcage.image = "saribirdcage.tex"
    --- -粉色箱子
    local saritreasurechest = RecipeSari("saritreasurechest",
        {
            Ingredient2("boards", 3),
            Ingredient2("petals", 1),
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE, GLOBAL.RECIPE_GAME_TYPE.COMMON, "saritreasurechest_placer", 1)
    addAssert(saritreasurechest, "images/inventoryimages/saritreasurechest.xml")
    saritreasurechest.image = "saritreasurechest.tex"
    --- -粉色帽子
    local sarihattop = RecipeSari("sarihattop",
        {
            Ingredient2("coontail", 2),
            Ingredient2("spidergland", 3),
            Ingredient2("silk", 3)
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE)
    addAssert(sarihattop, "images/inventoryimages/sarihattop.xml")
    --- -魔法帽子
    local sarimagicalhats = RecipeSari("sarimagicalhats",
        {
            Ingredient2("rabbit", 9),
            Ingredient2("tophat", 1),
            Ingredient2("gears", 2)
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE)
    addAssert(sarimagicalhats, "images/inventoryimages/sarimagicalhats.xml")
    --- -猫包
    local saribackpack = RecipeSari("saribackpack",
        {
            Ingredient2("coontail", 8),
            Ingredient2("livinglog", 8),
            Ingredient2("purplegem", 2)
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE)
    addAssert(saribackpack, "images/inventoryimages/saribackpack.xml")
    --- -猫长剑
    local saricatsword_cat = RecipeSari("saricatsword_cat",
        {
            Ingredient2("coontail", 9),
            Ingredient2("nitre", 9),
            Ingredient2("transistor", 9)
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE)
    addAssert(saricatsword_cat, "images/inventoryimages/saricatsword_cat.xml")
    --- -小花伞
    local sariftumbrella = RecipeSari("sariftumbrella",
        {
            Ingredient2("twigs", 2),
            Ingredient2("silk", 4),
            Ingredient2("coontail", 2)
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE)
    addAssert(sariftumbrella, "images/inventoryimages/sariftumbrella.xml")
    --- -巨锤
    local saricth = RecipeSari("saricth",
        {
            Ingredient2("hammer", 1),
            Ingredient2("goldnugget", 1),
            Ingredient2("cutstone", 2)
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE)
    addAssert(saricth, "images/inventoryimages/saricth.xml")
    ---------------------------------------------------------------------------------------
    elseif GLOBAL.SaveGameIndex:IsModeShipwrecked() then --- -海难
    ---- 地毯1
    local turf_saria1 = RecipeSari("turf_saria1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_saria1, "images/inventoryimages/turf_saria1.xml")
    --- -地毯2
    local turf_sarib1 = RecipeSari("turf_sarib1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarib1, "images/inventoryimages/turf_sarib1.xml")
    --- -地毯3
    local turf_saric1 = RecipeSari("turf_saric1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_saric1, "images/inventoryimages/turf_saric1.xml")
    --- -地毯4
    local turf_sarid1 = RecipeSari("turf_sarid1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarid1, "images/inventoryimages/turf_sarid1.xml")
    --- -地毯5
    local turf_sarie1 = RecipeSari("turf_sarie1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarie1, "images/inventoryimages/turf_sarie1.xml")
    --- -地毯6
    local turf_sarif1 = RecipeSari("turf_sarif1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarif1, "images/inventoryimages/turf_sarif1.xml")
    --- -地毯7
    local turf_sarig1 = RecipeSari("turf_sarig1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarig1, "images/inventoryimages/turf_sarig1.xml")
    --- -地毯8
    local turf_sarih1 = RecipeSari("turf_sarih1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarih1, "images/inventoryimages/turf_sarih1.xml")
    --- -地毯9
    local turf_sarii1 = RecipeSari("turf_sarii1", { crystal2, Ingredient2("beefalowool", 2), Ingredient2("goldnugget", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(turf_sarii1, "images/inventoryimages/turf_sarii1.xml")
    --- -猫尾巴
    local coontail = RecipeSari("coontail", { Ingredient2("rope", 1), Ingredient2("petals", 1) }, GLOBAL.RECIPETABS.SARITAB, { SCIENCE = 0 }, nil, nil, nil, 1)
    --- -旧钟图纸
    local bell_blueprint = RecipeSari("bell_blueprint", { Ingredient2("papyrus", 2), Ingredient2("purplegem", 1), Ingredient2("orangegem", 1), Ingredient2("yellowgem", 1) }, RECIPETABS.SARITAB, { SCIENCE = 2 }, nil, nil, nil, 1)
    addAssert(bell_blueprint, "images/inventoryimages/bell_blueprint.xml")
    bell_blueprint.image = "bell_blueprint.tex"
    --- -中空树屋
    local catcoonden = RecipeSari("catcoonden",
        {
            Ingredient2("coontail", 2),
            Ingredient2("log", 4),
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE, GLOBAL.RECIPE_GAME_TYPE.COMMON, "catcoonden_placer", 2)
    addAssert(catcoonden, "images/inventoryimages/catcoonden.xml")
    catcoonden.image = "catcoonden.tex"
    --- -鸟笼
    local saribirdcage = RecipeSari("saribirdcage",
        {
            Ingredient2("coontail", 2),
            Ingredient2("charcoal", 6),
            Ingredient2("papyrus", 2),
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE, GLOBAL.RECIPE_GAME_TYPE.COMMON, "saribirdcage_placer", 2.5)
    addAssert(saribirdcage, "images/inventoryimages/saribirdcage.xml")
    saribirdcage.image = "saribirdcage.tex"
    --- -粉色箱子
    local saritreasurechest = RecipeSari("saritreasurechest",
        {
            Ingredient2("boards", 3),
            Ingredient2("petals", 1),
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE, GLOBAL.RECIPE_GAME_TYPE.COMMON, "saritreasurechest_placer", 1)
    addAssert(saritreasurechest, "images/inventoryimages/saritreasurechest.xml")
    saritreasurechest.image = "saritreasurechest.tex"
    --- -粉色帽子
    local sarihattop = RecipeSari("sarihattop",
        {
            Ingredient2("rabbit", 9),
            Ingredient2("tophat", 1),
            Ingredient2("gears", 2)
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE)
    addAssert(sarihattop, "images/inventoryimages/sarihattop.xml")
    --- -魔法帽子
    local sarimagicalhats = RecipeSari("sarimagicalhats",
        {
            Ingredient2("rabbit", 9),
            Ingredient2("spidergland", 3),
            Ingredient2("silk", 3)
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE)
    addAssert(sarimagicalhats, "images/inventoryimages/sarimagicalhats.xml")
    --- -猫包
    local saribackpack = RecipeSari("saribackpack",
        {
            Ingredient2("coontail", 8),
            Ingredient2("fabric", 6),
            Ingredient2("purplegem", 2)
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE)
    addAssert(saribackpack, "images/inventoryimages/saribackpack.xml")
    --- -猫长剑
    local saricatsword_cat = RecipeSari("saricatsword_cat",
        {
            Ingredient2("coontail", 9),
            Ingredient2("boneshard", 9),
            Ingredient2("limestone", 9)
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE)
    addAssert(saricatsword_cat, "images/inventoryimages/saricatsword_cat.xml")
    --- -小花伞
    local sariftumbrella = RecipeSari("sariftumbrella",
        {
            Ingredient2("twigs", 2),
            Ingredient2("fabric", 2),
            Ingredient2("coontail", 2)
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE)
    addAssert(sariftumbrella, "images/inventoryimages/sariftumbrella.xml")
    --- -巨锤
    local saricth = RecipeSari("saricth",
        {
            Ingredient2("hammer", 1),
            Ingredient2("goldnugget", 1),
            Ingredient2("cutstone", 2)
        },
        GLOBAL.RECIPETABS.SARITAB, GLOBAL.TECH.SCIENCE_ONE)
    addAssert(saricth, "images/inventoryimages/saricth.xml")
    end
end