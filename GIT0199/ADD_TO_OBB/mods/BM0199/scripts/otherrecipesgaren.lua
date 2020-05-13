local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local package = GLOBAL.package
local kleifileexists = GLOBAL.kleifileexists
local select = GLOBAL.select
local RECIPE_GAME_TYPE = GLOBAL.RECIPE_GAME_TYPE

--[[
 -- I borrow something from wharang and musha
 -- I don't write this part my in mod description because this function is for Chinese players who keen on aesthetics
 -- If those authors don not agree with this ,I'll withdraw this function
 -- After all, is someone else's exclusive
 ]]

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

function otherPostInit()
    if _G.Prefabs.musha then
        --matarial
        local bushhat = Ingredient2("bushhat", 1)
        local ruinshat = Ingredient2("ruinshat", 1)
        local armorruins = Ingredient2("armorruins", 1)
        local amulet = Ingredient2("amulet", 1)
        local butterfly10 = Ingredient2("butterfly", 10)
        local butterfly8 = Ingredient2("butterfly", 8)
        local butterfly6 = Ingredient2("butterfly", 6)
        local butterfly4 = Ingredient2("butterfly", 4)
        local bee5 = Ingredient2("bee", 5)
        local bee4 = Ingredient2("bee", 4)
        local papyrus2 = Ingredient2("papyrus", 2)
        local beefaloh = Ingredient2("beefalohat", 1)
        local walrustusk = Ingredient2("walrus_tusk", 2)
        local eyes = Ingredient2("deerclops_eyeball", 2)
        local eye = Ingredient2("deerclops_eyeball", 1)

        local princess = Ingredient2("hat_mprincess", 1)
        addAssert(princess, "images/inventoryimages/hat_mprincess.xml")

        local armoraa = Ingredient2("armor_mushaa", 1)
        addAssert(armoraa, "images/inventoryimages/armor_mushaa.xml")

        local glowdusts = Ingredient2("glowdust", 1)
        addAssert(glowdusts, "images/inventoryimages/glowdust.xml")
        local dust2 = Ingredient2("glowdust", 2)
        addAssert(dust2, "images/inventoryimages/glowdust.xml")
        local dust3 = Ingredient2("glowdust", 3)
        addAssert(dust3, "images/inventoryimages/glowdust.xml")
        local dust4 = Ingredient2("glowdust", 4)
        addAssert(dust4, "images/inventoryimages/glowdust.xml")
        local dust5 = Ingredient2("glowdust", 5)
        addAssert(dust5, "images/inventoryimages/glowdust.xml")
        local dust6 = Ingredient2("glowdust", 6)
        addAssert(dust6, "images/inventoryimages/glowdust.xml")
        local dust10 = Ingredient2("glowdust", 10)
        addAssert(dust10, "images/inventoryimages/glowdust.xml")
        local dust15 = Ingredient2("glowdust", 15)
        addAssert(dust15, "images/inventoryimages/glowdust.xml")
        local dust20 = Ingredient2("glowdust", 20)
        addAssert(dust20, "images/inventoryimages/glowdust.xml")

        local broken = Ingredient2("broken_frosthammer", 1)
        addAssert(broken, "images/inventoryimages/broken_frosthammer.xml")

        local frosta = Ingredient2("frosthammer", 1)
        addAssert(frosta, "images/inventoryimages/frosthammer.xml")

        local meggs = Ingredient2("musha_egg", 1)
        addAssert(meggs, "images/inventoryimages/musha_egg.xml")
        --egg
        local phoenix_egg = Ingredient2("musha_egg", 1)
        addAssert(phoenix_egg, "images/inventoryimages/musha_egg.xml")
        local phoenix_eggs1 = Ingredient2("musha_eggs1", 1)
        addAssert(phoenix_eggs1, "images/inventoryimages/musha_eggs1.xml")
        local phoenix_eggs2 = Ingredient2("musha_eggs2", 1)
        addAssert(phoenix_eggs2, "images/inventoryimages/musha_eggs2.xml")
        local phoenix_eggs3 = Ingredient2("musha_eggs3", 1)
        addAssert(phoenix_eggs3, "images/inventoryimages/musha_eggs3.xml")
        local phoenix_egg1 = Ingredient2("musha_egg1", 1)
        addAssert(phoenix_egg1, "images/inventoryimages/musha_egg1.xml")
        local phoenix_egg2 = Ingredient2("musha_egg2", 1)
        addAssert(phoenix_egg2, "images/inventoryimages/musha_egg2.xml")
        local phoenix_egg3 = Ingredient2("musha_egg3", 1)
        addAssert(phoenix_egg3, "images/inventoryimages/musha_egg3.xml")
        local phoenix_egg8 = Ingredient2("musha_egg8", 1)
        addAssert(phoenix_egg8, "images/inventoryimages/musha_egg8.xml")
        --
        local bladeb = Ingredient2("mushasword_base", 1)
        addAssert(bladeb, "images/inventoryimages/mushasword_base.xml")
        local blade1 = Ingredient2("mushasword", 1)
        addAssert(blade1, "images/inventoryimages/mushasword.xml")
        local blade2 = Ingredient2("mushasword2", 1)
        addAssert(blade2, "images/inventoryimages/mushasword2.xml")
        local blade_f = Ingredient2("mushasword_frost", 1)
        addAssert(blade_f, "images/inventoryimages/mushasword_frost.xml")

        local crystal = Ingredient2("cristal", 1)
        addAssert(crystal, "images/inventoryimages/cristal.xml")
        local crystal2 = Ingredient2("cristal", 2)
        addAssert(crystal2, "images/inventoryimages/cristal.xml")
        local crystal6 = Ingredient2("cristal", 6)
        addAssert(crystal6, "images/inventoryimages/cristal.xml")
        local crystal10 = Ingredient2("cristal", 10)
        addAssert(crystal10, "images/inventoryimages/cristal.xml")

        local player = GLOBAL.GetPlayer()
        if not GLOBAL.SaveGameIndex:IsModeShipwrecked() then
            if true then
                --grass hut
                if true and player.components.poisonable then
                    local musha_hut = RecipeYiyu("musha_hut", { Ingredient2("log", 5), Ingredient2("cutgrass", 6), Ingredient2("rope", 3), }, RECIPETABS.MUSHA, { SCIENCE = 1 }, nil, "musha_hut_placer")
                    addAssert(musha_hut, "images/inventoryimages/musha_hut.xml")
                elseif true and not player.components.poisonable then
                    local musha_hut = RecipeYiyu("musha_hut", { Ingredient2("log", 5), Ingredient2("cutgrass", 6), Ingredient2("rope", 3), }, RECIPETABS.MUSHA, { SCIENCE = 1 }, "musha_hut_placer")
                    addAssert(musha_hut, "images/inventoryimages/musha_hut.xml")
                elseif not true then
                    local musha_hut = RecipeYiyu("musha_hut", { Ingredient2("log", 5), Ingredient2("cutgrass", 6), Ingredient2("rope", 3), }, RECIPETABS.MUSHA, { SCIENCE = 1 }, "musha_hut_placer")
                    addAssert(musha_hut, "images/inventoryimages/musha_hut.xml")
                end
                --dall
                if true and player.components.poisonable then
                    local moontree = RecipeYiyu("moontree", { glowdust10, Ingredient2("livinglog", 30), Ingredient2("purplegem", 12), Ingredient2("orangegem", 2), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "moontree_placer")
                    addAssert(moontree, "images/inventoryimages/moontree.xml")
                elseif true and not player.components.poisonable then
                    local moontree = RecipeYiyu("moontree", { glowdust10, Ingredient2("livinglog", 30), Ingredient2("purplegem", 12), Ingredient2("orangegem", 2), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, "moontree_placer")
                    addAssert(moontree, "images/inventoryimages/moontree.xml")
                elseif not true then
                    local moontree = RecipeYiyu("moontree", { glowdust10, Ingredient2("livinglog", 20), Ingredient2("purplegem", 8), Ingredient2("orangegem", 1), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, "moontree_placer")
                    addAssert(moontree, "images/inventoryimages/moontree.xml")
                end
                --oven
                local musha_oven = RecipeYiyu("musha_oven", { crystal, Ingredient2("rocks", 20), Ingredient2("froglegs", 8), Ingredient2("livinglog", 4), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "musha_oven_placer")
                addAssert(musha_oven, "images/inventoryimages/musha_oven.xml")
                --forge
                if true and player.components.poisonable then
                    local forge_musha = RecipeYiyu("forge_musha", { glowdust10, Ingredient2("gears", 8), Ingredient2("transistor", 8), Ingredient2("livinglog", 12), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "forge_musha_placer")
                    addAssert(forge_musha, "images/inventoryimages/forge_musha.xml")
                elseif true and not player.components.poisonable then
                    local forge_musha = RecipeYiyu("forge_musha", { glowdust10, Ingredient2("gears", 8), Ingredient2("transistor", 8), Ingredient2("livinglog", 12), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, "forge_musha_placer")
                    addAssert(forge_musha, "images/inventoryimages/forge_musha.xml")
                elseif not true then
                    local forge_musha = RecipeYiyu("forge_musha", { glowdust10, Ingredient2("gears", 8), Ingredient2("transistor", 8), Ingredient2("livinglog", 12), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, "forge_musha_placer")
                    addAssert(forge_musha, "images/inventoryimages/forge_musha.xml")
                end
                --tent
                if true and player.components.poisonable then
                    local tent_musha = RecipeYiyu("tent_musha", { dust6, Ingredient2("lightbulb", 20), Ingredient2("papyrus", 10), Ingredient2("twigs", 12), }, RECIPETABS.MUSHA, { SCIENCE = 1 }, nil, "tent_musha_placer")
                    addAssert(tent_musha, "images/inventoryimages/tent_musha.xml")
                elseif true and not player.components.poisonable then
                    local tent_musha = RecipeYiyu("tent_musha", { dust6, Ingredient2("lightbulb", 20), Ingredient2("papyrus", 10), Ingredient2("twigs", 12), }, RECIPETABS.MUSHA, { SCIENCE = 1 }, "tent_musha_placer")
                    addAssert(tent_musha, "images/inventoryimages/tent_musha.xml")
                elseif not true then
                    local tent_musha = RecipeYiyu("tent_musha", { dust6, Ingredient2("lightbulb", 20), Ingredient2("papyrus", 10), Ingredient2("twigs", 12), }, RECIPETABS.MUSHA, { SCIENCE = 1 }, "tent_musha_placer")
                    addAssert(tent_musha, "images/inventoryimages/tent_musha.xml")
                end

                --dust
                local glowdust = RecipeYiyu("glowdust", { Ingredient2("wormlight", 1), Ingredient2("berries", 5) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(glowdust, "images/inventoryimages/glowdust.xml")
                --cristal
                local cristal = RecipeYiyu("cristal", { dust10 }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(cristal, "images/inventoryimages/cristal.xml")
                --flute
                local musha_flute = RecipeYiyu("musha_flute", { dust6, Ingredient2("horn", 1), Ingredient2("spidergland", 60) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_flute, "images/inventoryimages/musha_flute.xml")
                --phoenix weapon
                local mushasword_base = RecipeYiyu("mushasword_base", { Ingredient2("goldnugget", 2), Ingredient2("flint", 3) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(mushasword_base, "images/inventoryimages/mushasword_base.xml")
                --[[ local mushasword = GLOBAL.Recipe( "mushasword", { bladeb, glowdusts, Ingredient2("feather_robin", 8), Ingredient2("goldnugget", 20) }, RECIPETABS.MUSHA, {SCIENCE=0})
addAssert(                mushasword,"images/inventoryimages/mushasword.xml")
                 local mushasword2 = GLOBAL.Recipe( "mushasword2", { blade1,  dust6, Ingredient2("redgem", 10), Ingredient2("goldnugget", 60) }, RECIPETABS.MUSHA, {SCIENCE=1})
addAssert(                mushasword2,"images/inventoryimages/mushasword2.xml")
                 local mushasword3 = GLOBAL.Recipe( "mushasword3", { blade2,  dust10, Ingredient2("redgem", 40), Ingredient2("goldnugget", 80) }, RECIPETABS.MUSHA, {SCIENCE=2})
addAssert(                mushasword3,"images/inventoryimages/mushasword3.xml")]]

                --fire
                local mushasword_fire = RecipeYiyu("mushasword_fire", { bladeb, glowdusts, Ingredient2("redgem", 6) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(mushasword_fire, "images/inventoryimages/mushasword_fire.xml")
                --frost
                local mushasword_frost = RecipeYiyu("mushasword_frost", { bladeb, glowdusts, Ingredient2("bluegem", 6) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(mushasword_frost, "images/inventoryimages/mushasword_frost.xml")
                --hammer
                local frosthammer = RecipeYiyu("frosthammer", { eyes, Ingredient2("livinglog", 15), Ingredient2("bluegem", 30), broken }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(frosthammer, "images/inventoryimages/frosthammer.xml")

                --axe
                local mushasword4 = RecipeYiyu("mushasword4", { Ingredient2("thulecite", 80), Ingredient2("purplegem", 15), Ingredient2("greengem", 12), Ingredient2("nightmarefuel", 40) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(mushasword4, "images/inventoryimages/mushasword4.xml")
                --armor
                local pirateback = RecipeYiyu("pirateback", { broken, armoraa, Ingredient2("goldnugget", 60), Ingredient2("yellowgem", 5) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(pirateback, "images/inventoryimages/pirateback.xml")
                local broken_frosthammer = RecipeYiyu("broken_frosthammer", { butterfly4, Ingredient2("gears", 4), Ingredient2("bluegem", 4) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(broken_frosthammer, "images/inventoryimages/broken_frosthammer.xml")
                local armor_mushaa = RecipeYiyu("armor_mushaa", { amulet, Ingredient2("goldnugget", 24), Ingredient2("thulecite", 6) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(armor_mushaa, "images/inventoryimages/armor_mushaa.xml")
                local frostback = RecipeYiyu("frostback", { broken, butterfly8, Ingredient2("bluegem", 6) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(frostback, "images/inventoryimages/frostback.xml")
                local armor_mushab = RecipeYiyu("armor_mushab", { armoraa, eyes, Ingredient2("greengem", 8), Ingredient2("orangegem", 8), }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(armor_mushab, "images/inventoryimages/armor_mushab.xml")
                --hat
                local hat_mbunny = RecipeYiyu("hat_mbunny", { walrustusk, Ingredient2("dug_grass", 8), Ingredient2("manrabbit_tail", 6), Ingredient2("purplegem", 2) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(hat_mbunny, "images/inventoryimages/hat_mbunny.xml")
                local hat_mprincess = RecipeYiyu("hat_mprincess", { amulet, Ingredient2("goldnugget", 12), Ingredient2("purplegem", 2) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(hat_mprincess, "images/inventoryimages/hat_mprincess.xml")
                local hat_mcrown = RecipeYiyu("hat_mcrown", { princess, Ingredient2("thulecite", 10), Ingredient2("purplegem", 6) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(hat_mcrown, "images/inventoryimages/hat_mcrown.xml")

                if true then
                    local hat_mphoenix = RecipeYiyu("hat_mphoenix", { Ingredient2("dragon_scales", 2), Ingredient2("panflute", 1), Ingredient2("goldnugget", 60), Ingredient2("thulecite", 80) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                    addAssert(hat_mphoenix, "images/inventoryimages/hat_mphoenix.xml")
                elseif not true then
                    local hat_mphoenix = RecipeYiyu("hat_mphoenix", { eyes, Ingredient2("panflute", 1), Ingredient2("goldnugget", 60), Ingredient2("thulecite", 80) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                    addAssert(hat_mphoenix, "images/inventoryimages/hat_mphoenix.xml")
                end

                --egg
                --arong egg
                local musha_egg_arong = RecipeYiyu("musha_egg_arong", { phoenix_egg }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(musha_egg_arong, "images/inventoryimages/musha_egg_arong.xml")
                --phoenix_egg
                local musha_egg = RecipeYiyu("musha_egg", { dust10, Ingredient2("redgem", 60), Ingredient2("bluegem", 40), Ingredient2("greengem", 30) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(musha_egg, "images/inventoryimages/musha_egg.xml")

                local musha_eggs1 = RecipeYiyu("musha_eggs1", { phoenix_egg, Ingredient2("goldnugget", 10) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(musha_eggs1, "images/inventoryimages/musha_eggs1.xml")
                local musha_eggs2 = RecipeYiyu("musha_eggs2", { phoenix_eggs1, Ingredient2("goldnugget", 15) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(musha_eggs2, "images/inventoryimages/musha_eggs2.xml")
                local musha_eggs3 = RecipeYiyu("musha_eggs3", { phoenix_eggs2, Ingredient2("goldnugget", 30) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_eggs3, "images/inventoryimages/musha_eggs3.xml")
                local musha_egg1 = RecipeYiyu("musha_egg1", { phoenix_eggs3, Ingredient2("goldnugget", 45), Ingredient2("purplegem", 1) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg1, "images/inventoryimages/musha_egg1.xml")
                local musha_egg2 = RecipeYiyu("musha_egg2", { phoenix_egg1, Ingredient2("goldnugget", 60), Ingredient2("purplegem", 3) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg2, "images/inventoryimages/musha_egg2.xml")
                local musha_egg3 = RecipeYiyu("musha_egg3", { phoenix_egg2, Ingredient2("goldnugget", 90), Ingredient2("purplegem", 5) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg3, "images/inventoryimages/musha_egg3.xml")
                local musha_egg8 = RecipeYiyu("musha_egg8", { phoenix_egg3, Ingredient2("goldnugget", 150), Ingredient2("purplegem", 8) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg8, "images/inventoryimages/musha_egg8.xml")
                ------------------------------------------------------------------------------------------------------------
            end
            ------------------------------------------------------------------------------------------------------------
            if true then
                --grass hut
                if true and player.components.poisonable then
                    local musha_hut = RecipeYiyu("musha_hut", { Ingredient2("log", 3), Ingredient2("cutgrass", 3), Ingredient2("rope", 2), }, RECIPETABS.MUSHA, { SCIENCE = 1 }, nil, "musha_hut_placer")
                    addAssert(musha_hut, "images/inventoryimages/musha_hut.xml")
                elseif true and not player.components.poisonable then
                    local musha_hut = RecipeYiyu("musha_hut", { Ingredient2("log", 3), Ingredient2("cutgrass", 3), Ingredient2("rope", 2), }, RECIPETABS.MUSHA, { SCIENCE = 1 }, "musha_hut_placer")
                    addAssert(musha_hut, "images/inventoryimages/musha_hut.xml")
                elseif not true then
                    local musha_hut = RecipeYiyu("musha_hut", { Ingredient2("log", 3), Ingredient2("cutgrass", 3), Ingredient2("rope", 2), }, RECIPETABS.MUSHA, { SCIENCE = 1 }, "musha_hut_placer")
                    addAssert(musha_hut, "images/inventoryimages/musha_hut.xml")
                end
                --dall
                if true and player.components.poisonable then
                    local moontree = RecipeYiyu("moontree", { glowdust10, Ingredient2("livinglog", 15), Ingredient2("purplegem", 6), Ingredient2("orangegem", 1), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "moontree_placer")
                    addAssert(moontree, "images/inventoryimages/moontree.xml")
                elseif true and not player.components.poisonable then
                    local moontree = RecipeYiyu("moontree", { glowdust10, Ingredient2("livinglog", 15), Ingredient2("purplegem", 6), Ingredient2("orangegem", 1), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, "moontree_placer")
                    addAssert(moontree, "images/inventoryimages/moontree.xml")
                elseif not true then
                    local moontree = RecipeYiyu("moontree", { glowdust10, Ingredient2("livinglog", 15), Ingredient2("purplegem", 4), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, "moontree_placer")
                    addAssert(moontree, "images/inventoryimages/moontree.xml")
                end
                --oven
                local musha_oven = RecipeYiyu("musha_oven", { crystal, Ingredient2("rocks", 12), Ingredient2("froglegs", 4), Ingredient2("livinglog", 2), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "musha_oven_placer")
                addAssert(musha_oven, "images/inventoryimages/musha_oven.xml")
                --forge
                if true and player.components.poisonable then
                    local forge_musha = RecipeYiyu("forge_musha", { glowdust10, Ingredient2("gears", 4), Ingredient2("transistor", 4), Ingredient2("livinglog", 6), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "forge_musha_placer")
                    addAssert(forge_musha, "images/inventoryimages/forge_musha.xml")
                elseif true and not player.components.poisonable then
                    local forge_musha = RecipeYiyu("forge_musha", { glowdust10, Ingredient2("gears", 4), Ingredient2("transistor", 4), Ingredient2("livinglog", 6), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, "forge_musha_placer")
                    addAssert(forge_musha, "images/inventoryimages/forge_musha.xml")
                elseif not true then
                    local forge_musha = RecipeYiyu("forge_musha", { glowdust10, Ingredient2("gears", 4), Ingredient2("transistor", 4), Ingredient2("livinglog", 6), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, "forge_musha_placer")
                    addAssert(forge_musha, "images/inventoryimages/forge_musha.xml")
                end
                --tent
                if true and player.components.poisonable then
                    local tent_musha = RecipeYiyu("tent_musha", { dust6, Ingredient2("lightbulb", 10), Ingredient2("papyrus", 5), Ingredient2("twigs", 6), }, RECIPETABS.MUSHA, nil, { SCIENCE = 1 }, "tent_musha_placer")
                    addAssert(tent_musha, "images/inventoryimages/tent_musha.xml")
                elseif true and not player.components.poisonable then
                    local tent_musha = RecipeYiyu("tent_musha", { dust6, Ingredient2("lightbulb", 10), Ingredient2("papyrus", 5), Ingredient2("twigs", 6), }, RECIPETABS.MUSHA, { SCIENCE = 1 }, "tent_musha_placer")
                    addAssert(tent_musha, "images/inventoryimages/tent_musha.xml")
                elseif not true then
                    local tent_musha = RecipeYiyu("tent_musha", { dust6, Ingredient2("lightbulb", 10), Ingredient2("papyrus", 5), Ingredient2("twigs", 6), }, RECIPETABS.MUSHA, { SCIENCE = 1 }, "tent_musha_placer")
                    addAssert(tent_musha, "images/inventoryimages/tent_musha.xml")
                end

                --dust
                local glowdust = RecipeYiyu("glowdust", { Ingredient2("wormlight", 1), Ingredient2("berries", 2) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(glowdust, "images/inventoryimages/glowdust.xml")
                --cristal
                local cristal = RecipeYiyu("cristal", { dust6 }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(cristal, "images/inventoryimages/cristal.xml")
                --flute
                local musha_flute = RecipeYiyu("musha_flute", { dust3, Ingredient2("horn", 1), Ingredient2("spidergland", 30) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_flute, "images/inventoryimages/musha_flute.xml")
                --phoenix weapon
                local mushasword_base = RecipeYiyu("mushasword_base", { Ingredient2("goldnugget", 1), Ingredient2("flint", 2) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(mushasword_base, "images/inventoryimages/mushasword_base.xml")
                --[[ local mushasword = GLOBAL.Recipe( "mushasword", { bladeb, glowdusts, Ingredient2("feather_robin", 1), Ingredient2("goldnugget", 5) }, RECIPETABS.MUSHA, {SCIENCE=0})
addAssert(                mushasword,"images/inventoryimages/mushasword.xml")
                 local mushasword2 = GLOBAL.Recipe( "mushasword2", { blade1,  dust3, Ingredient2("redgem", 3), Ingredient2("goldnugget", 10) }, RECIPETABS.MUSHA, {SCIENCE=1})
addAssert(                mushasword2,"images/inventoryimages/mushasword2.xml")
                 local mushasword3 = GLOBAL.Recipe( "mushasword3", { blade2,  dust5, Ingredient2("redgem", 15), Ingredient2("goldnugget", 40) }, RECIPETABS.MUSHA, {SCIENCE=2})
addAssert(                mushasword3,"images/inventoryimages/mushasword3.xml")]]
                --fire
                local mushasword_fire = RecipeYiyu("mushasword_fire", { bladeb, glowdusts, Ingredient2("redgem", 3) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(mushasword_fire, "images/inventoryimages/mushasword_fire.xml")
                --frost
                local mushasword_frost = RecipeYiyu("mushasword_frost", { bladeb, glowdusts, Ingredient2("bluegem", 3) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(mushasword_frost, "images/inventoryimages/mushasword_frost.xml")
                --hammer
                local frosthammer = RecipeYiyu("frosthammer", { eye, Ingredient2("livinglog", 8), Ingredient2("bluegem", 15), broken }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(frosthammer, "images/inventoryimages/frosthammer.xml")
                --axe
                local mushasword4 = RecipeYiyu("mushasword4", { Ingredient2("thulecite", 40), Ingredient2("purplegem", 7), Ingredient2("greengem", 6), Ingredient2("nightmarefuel", 20) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(mushasword4, "images/inventoryimages/mushasword4.xml")
                --armor
                local pirateback = RecipeYiyu("pirateback", { broken, armoraa, Ingredient2("goldnugget", 30), Ingredient2("yellowgem", 3) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(pirateback, "images/inventoryimages/pirateback.xml")
                local broken_frosthammer = RecipeYiyu("broken_frosthammer", { butterfly4, Ingredient2("gears", 2), Ingredient2("bluegem", 3) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(broken_frosthammer, "images/inventoryimages/broken_frosthammer.xml")
                local armor_mushaa = RecipeYiyu("armor_mushaa", { amulet, Ingredient2("goldnugget", 12), Ingredient2("thulecite", 3) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(armor_mushaa, "images/inventoryimages/armor_mushaa.xml")
                local frostback = RecipeYiyu("frostback", { broken, butterfly8, Ingredient2("bluegem", 3) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(frostback, "images/inventoryimages/frostback.xml")
                local armor_mushab = RecipeYiyu("armor_mushab", { armoraa, eye, Ingredient2("greengem", 4), Ingredient2("orangegem", 4) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(armor_mushab, "images/inventoryimages/armor_mushab.xml")
                --hat
                local hat_mbunny = RecipeYiyu("hat_mbunny", { walrustusk, Ingredient2("dug_grass", 4), Ingredient2("manrabbit_tail", 3), Ingredient2("bluegem", 2) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(hat_mbunny, "images/inventoryimages/hat_mbunny.xml")
                local hat_mprincess = RecipeYiyu("hat_mprincess", { amulet, Ingredient2("goldnugget", 6), Ingredient2("purplegem", 1) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(hat_mprincess, "images/inventoryimages/hat_mprincess.xml")
                local hat_mcrown = RecipeYiyu("hat_mcrown", { princess, Ingredient2("thulecite", 5), Ingredient2("purplegem", 3) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(hat_mcrown, "images/inventoryimages/hat_mcrown.xml")
                if true then
                    local hat_mphoenix = RecipeYiyu("hat_mphoenix", { Ingredient2("dragon_scales", 1), Ingredient2("panflute", 1), Ingredient2("goldnugget", 30), Ingredient2("thulecite", 40) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                    addAssert(hat_mphoenix, "images/inventoryimages/hat_mphoenix.xml")
                elseif not true then
                    local hat_mphoenix = RecipeYiyu("hat_mphoenix", { eye, Ingredient2("panflute", 1), Ingredient2("goldnugget", 30), Ingredient2("thulecite", 40) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                    addAssert(hat_mphoenix, "images/inventoryimages/hat_mphoenix.xml")
                end
                --egg
                --arong egg
                local musha_egg_arong = RecipeYiyu("musha_egg_arong", { phoenix_egg }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(musha_egg_arong, "images/inventoryimages/musha_egg_arong.xml")
                --phoenix_egg
                local musha_egg = RecipeYiyu("musha_egg", { dust5, Ingredient2("redgem", 30), Ingredient2("bluegem", 20), Ingredient2("greengem", 15) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(musha_egg, "images/inventoryimages/musha_egg.xml")
                local musha_eggs1 = RecipeYiyu("musha_eggs1", { phoenix_egg, Ingredient2("goldnugget", 5) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(musha_eggs1, "images/inventoryimages/musha_eggs1.xml")
                local musha_eggs2 = RecipeYiyu("musha_eggs2", { phoenix_eggs1, Ingredient2("goldnugget", 7) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(musha_eggs2, "images/inventoryimages/musha_eggs2.xml")
                local musha_eggs3 = RecipeYiyu("musha_eggs3", { phoenix_eggs2, Ingredient2("goldnugget", 15) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_eggs3, "images/inventoryimages/musha_eggs3.xml")
                local musha_egg1 = RecipeYiyu("musha_egg1", { phoenix_eggs3, Ingredient2("goldnugget", 22), Ingredient2("purplegem", 1) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg1, "images/inventoryimages/musha_egg1.xml")
                local musha_egg2 = RecipeYiyu("musha_egg2", { phoenix_egg1, Ingredient2("goldnugget", 30), Ingredient2("purplegem", 3) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg2, "images/inventoryimages/musha_egg2.xml")
                local musha_egg3 = RecipeYiyu("musha_egg3", { phoenix_egg2, Ingredient2("goldnugget", 45), Ingredient2("purplegem", 5) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg3, "images/inventoryimages/musha_egg3.xml")
                local musha_egg8 = RecipeYiyu("musha_egg8", { phoenix_egg3, Ingredient2("goldnugget", 75), Ingredient2("purplegem", 8) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg8, "images/inventoryimages/musha_egg8.xml")
                ------------------------------------------------------------------------------------------------------------
            end
            ------------------------------------------------------------------------------------------------------------
            if true then
                --grass hut
                if true and player.components.poisonable then
                    local musha_hut = RecipeYiyu("musha_hut", { Ingredient2("log", 2), Ingredient2("cutgrass", 2), Ingredient2("rope", 1), }, RECIPETABS.MUSHA, { SCIENCE = 1 }, nil, "musha_hut_placer")
                    addAssert(musha_hut, "images/inventoryimages/musha_hut.xml")
                elseif true and not player.components.poisonable then
                    local musha_hut = RecipeYiyu("musha_hut", { Ingredient2("log", 2), Ingredient2("cutgrass", 2), Ingredient2("rope", 1), }, RECIPETABS.MUSHA, { SCIENCE = 1 }, "musha_hut_placer")
                    addAssert(musha_hut, "images/inventoryimages/musha_hut.xml")
                elseif not true then
                    local musha_hut = RecipeYiyu("musha_hut", { Ingredient2("log", 2), Ingredient2("cutgrass", 2), Ingredient2("rope", 1), }, RECIPETABS.MUSHA, { SCIENCE = 1 }, "musha_hut_placer")
                    addAssert(musha_hut, "images/inventoryimages/musha_hut.xml")
                end
                --dall
                if true and player.components.poisonable then
                    local moontree = RecipeYiyu("moontree", { dust6, Ingredient2("livinglog", 6), Ingredient2("purplegem", 3), Ingredient2("bluegem", 1), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "moontree_placer")
                    addAssert(moontree, "images/inventoryimages/moontree.xml")
                elseif true and not player.components.poisonable then
                    local moontree = RecipeYiyu("moontree", { dust6, Ingredient2("livinglog", 6), Ingredient2("purplegem", 3), Ingredient2("bluegem", 1), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, "moontree_placer")
                    addAssert(moontree, "images/inventoryimages/moontree.xml")
                elseif not true then
                    local moontree = RecipeYiyu("moontree", { dust6, Ingredient2("livinglog", 6), Ingredient2("purplegem", 2), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, "moontree_placer")
                    addAssert(moontree, "images/inventoryimages/moontree.xml")
                end
                --oven
                local musha_oven = RecipeYiyu("musha_oven", { dust6, Ingredient2("rocks", 6), Ingredient2("froglegs", 2), Ingredient2("livinglog", 1), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "musha_oven_placer")
                addAssert(musha_oven, "images/inventoryimages/musha_oven.xml")
                --forge
                if true and player.components.poisonable then
                    local forge_musha = RecipeYiyu("forge_musha", { dust6, Ingredient2("gears", 2), Ingredient2("transistor", 2), Ingredient2("livinglog", 3), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "forge_musha_placer")
                    addAssert(forge_musha, "images/inventoryimages/forge_musha.xml")
                elseif true and not player.components.poisonable then
                    local forge_musha = RecipeYiyu("forge_musha", { dust6, Ingredient2("gears", 2), Ingredient2("transistor", 2), Ingredient2("livinglog", 3), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, "forge_musha_placer")
                    addAssert(forge_musha, "images/inventoryimages/forge_musha.xml")
                elseif not true then
                    local forge_musha = RecipeYiyu("forge_musha", { dust6, Ingredient2("gears", 2), Ingredient2("transistor", 2), Ingredient2("livinglog", 3), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, "forge_musha_placer")
                    addAssert(forge_musha, "images/inventoryimages/forge_musha.xml")
                end
                --tent
                if true and player.components.poisonable then
                    local tent_musha = RecipeYiyu("tent_musha", { dust2, Ingredient2("lightbulb", 5), Ingredient2("papyrus", 2), Ingredient2("twigs", 3), }, RECIPETABS.MUSHA, nil, { SCIENCE = 1 }, "tent_musha_placer")
                    addAssert(tent_musha, "images/inventoryimages/tent_musha.xml")
                elseif true and not player.components.poisonable then
                    local tent_musha = RecipeYiyu("tent_musha", { dust2, Ingredient2("lightbulb", 5), Ingredient2("papyrus", 2), Ingredient2("twigs", 3), }, RECIPETABS.MUSHA, { SCIENCE = 1 }, "tent_musha_placer")
                    addAssert(tent_musha, "images/inventoryimages/tent_musha.xml")
                elseif not true then
                    local tent_musha = RecipeYiyu("tent_musha", { dust2, Ingredient2("lightbulb", 5), Ingredient2("papyrus", 2), Ingredient2("twigs", 3), }, RECIPETABS.MUSHA, { SCIENCE = 1 }, "tent_musha_placer")
                    addAssert(tent_musha, "images/inventoryimages/tent_musha.xml")
                end


                --dust
                local glowdust = RecipeYiyu("glowdust", { Ingredient2("wormlight", 1) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(glowdust, "images/inventoryimages/glowdust.xml")
                --cristal
                local cristal = RecipeYiyu("cristal", { dust4 }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(cristal, "images/inventoryimages/cristal.xml")
                --flute
                local musha_flute = RecipeYiyu("musha_flute", { dust2, Ingredient2("horn", 1), Ingredient2("spidergland", 15) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_flute, "images/inventoryimages/musha_flute.xml")
                --phoenix weapon
                local mushasword_base = RecipeYiyu("mushasword_base", { Ingredient2("flint", 1) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(mushasword_base, "images/inventoryimages/mushasword_base.xml")

                --[[ local mushasword = GLOBAL.Recipe( "mushasword", { bladeb, glowdusts, Ingredient2("feather_robin", 1), Ingredient2("goldnugget", 2) }, RECIPETABS.MUSHA, {SCIENCE=0})
addAssert(                mushasword,"images/inventoryimages/mushasword.xml")
                 local mushasword2 = GLOBAL.Recipe( "mushasword2", { blade1,  dust2, Ingredient2("redgem", 1), Ingredient2("goldnugget", 5) }, RECIPETABS.MUSHA, {SCIENCE=1})
addAssert(                mushasword2,"images/inventoryimages/mushasword2.xml")
                 local mushasword3 = GLOBAL.Recipe( "mushasword3", { blade2,  dust2, Ingredient2("redgem", 7), Ingredient2("goldnugget", 20) }, RECIPETABS.MUSHA, {SCIENCE=2})
addAssert(                mushasword3,"images/inventoryimages/mushasword3.xml")]]
                --fire
                local mushasword_fire = RecipeYiyu("mushasword_fire", { bladeb, glowdusts, Ingredient2("redgem", 1) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(mushasword_fire, "images/inventoryimages/mushasword_fire.xml")
                --frost
                local mushasword_frost = RecipeYiyu("mushasword_frost", { bladeb, glowdusts, Ingredient2("bluegem", 1) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(mushasword_frost, "images/inventoryimages/mushasword_frost.xml")
                --hammer
                local frosthammer = RecipeYiyu("frosthammer", { eye, Ingredient2("livinglog", 4), Ingredient2("bluegem", 7), broken }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(frosthammer, "images/inventoryimages/frosthammer.xml")
                --axe
                local mushasword4 = RecipeYiyu("mushasword4", { Ingredient2("thulecite", 20), Ingredient2("purplegem", 3), Ingredient2("greengem", 3), Ingredient2("nightmarefuel", 10) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(mushasword4, "images/inventoryimages/mushasword4.xml")
                --armor
                local pirateback = RecipeYiyu("pirateback", { broken, armoraa, Ingredient2("goldnugget", 15), Ingredient2("yellowgem", 1) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(pirateback, "images/inventoryimages/pirateback.xml")
                local broken_frosthammer = RecipeYiyu("broken_frosthammer", { butterfly4, Ingredient2("gears", 1), Ingredient2("bluegem", 2) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(broken_frosthammer, "images/inventoryimages/broken_frosthammer.xml")
                local armor_mushaa = RecipeYiyu("armor_mushaa", { amulet, Ingredient2("goldnugget", 6), Ingredient2("thulecite", 1) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(armor_mushaa, "images/inventoryimages/armor_mushaa.xml")
                local frostback = RecipeYiyu("frostback", { broken, butterfly4, Ingredient2("bluegem", 1) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(frostback, "images/inventoryimages/frostback.xml")
                local armor_mushab = RecipeYiyu("armor_mushab", { armoraa, eye, Ingredient2("greengem", 2), Ingredient2("orangegem", 2) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(armor_mushab, "images/inventoryimages/armor_mushab.xml")
                --hat
                local hat_mbunny = RecipeYiyu("hat_mbunny", { Ingredient2("dug_grass", 2), Ingredient2("manrabbit_tail", 1), Ingredient2("bluegem", 1) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(hat_mbunny, "images/inventoryimages/hat_mbunny.xml")
                local hat_mprincess = RecipeYiyu("hat_mprincess", { amulet, Ingredient2("goldnugget", 3) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(hat_mprincess, "images/inventoryimages/hat_mprincess.xml")
                local hat_mcrown = RecipeYiyu("hat_mcrown", { princess, Ingredient2("thulecite", 2), Ingredient2("purplegem", 1) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(hat_mcrown, "images/inventoryimages/hat_mcrown.xml")
                if true then
                    local hat_mphoenix = RecipeYiyu("hat_mphoenix", { Ingredient2("dragon_scales", 1), Ingredient2("panflute", 1), Ingredient2("thulecite", 10) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                    addAssert(hat_mphoenix, "images/inventoryimages/hat_mphoenix.xml")
                elseif not true then
                    local hat_mphoenix = RecipeYiyu("hat_mphoenix", { eye, Ingredient2("panflute", 1), Ingredient2("thulecite", 10) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                    addAssert(hat_mphoenix, "images/inventoryimages/hat_mphoenix.xml")
                end
                --egg
                --arong egg
                local musha_egg_arong = RecipeYiyu("musha_egg_arong", { phoenix_egg }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(musha_egg_arong, "images/inventoryimages/musha_egg_arong.xml")
                --phoenix_egg
                local musha_egg = RecipeYiyu("musha_egg", { dust10, Ingredient2("redgem", 15), Ingredient2("bluegem", 10), Ingredient2("greengem", 7) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(musha_egg, "images/inventoryimages/musha_egg.xml")
                local musha_eggs1 = RecipeYiyu("musha_eggs1", { phoenix_egg, Ingredient2("goldnugget", 2) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(musha_eggs1, "images/inventoryimages/musha_eggs1.xml")
                local musha_eggs2 = RecipeYiyu("musha_eggs2", { phoenix_eggs1, Ingredient2("goldnugget", 3) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(musha_eggs2, "images/inventoryimages/musha_eggs2.xml")
                local musha_eggs3 = RecipeYiyu("musha_eggs3", { phoenix_eggs2, Ingredient2("goldnugget", 7) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_eggs3, "images/inventoryimages/musha_eggs3.xml")
                local musha_egg1 = RecipeYiyu("musha_egg1", { phoenix_eggs3, Ingredient2("goldnugget", 10) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg1, "images/inventoryimages/musha_egg1.xml")
                local musha_egg2 = RecipeYiyu("musha_egg2", { phoenix_egg1, Ingredient2("goldnugget", 15), Ingredient2("purplegem", 1) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg2, "images/inventoryimages/musha_egg2.xml")
                local musha_egg3 = RecipeYiyu("musha_egg3", { phoenix_egg2, Ingredient2("goldnugget", 25), Ingredient2("purplegem", 2) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg3, "images/inventoryimages/musha_egg3.xml")
                local musha_egg8 = RecipeYiyu("musha_egg8", { phoenix_egg3, Ingredient2("goldnugget", 35), Ingredient2("purplegem", 4) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg8, "images/inventoryimages/musha_egg8.xml")
                ------------------------------------------------------------------------------------------------------------
            end


            ------------------------------------------------------
            ------------------------------------------------------
            ------------------------------------------------------
        elseif GLOBAL.SaveGameIndex:IsModeShipwrecked() then
            if true then
                require "recipe"
                require "tuning"

                --boat
                local musha_cargo = RecipeYiyu("musha_cargo", { Ingredient2("livinglog", 10), Ingredient2("boards", 8), Ingredient2("rope", 6), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "musha_cargo_placer", nil, nil, nil, true, 4)
                addAssert(musha_cargo, "images/inventoryimages/musha_cargo.xml")
                local sail_pirate = RecipeYiyu("sail_pirate", { Ingredient2("fabric", 4), Ingredient2("bamboo", 3), Ingredient2("charcoal", 2), }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(sail_pirate, "images/inventoryimages/sail_pirate.xml")
                local cgarenn_musha = RecipeYiyu("cgarenn_musha", { Ingredient2("boatcgarenn", 1), Ingredient2("flowerhat", 1), dust5 }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(cgarenn_musha, "images/inventoryimages/cgarenn_musha.xml")

                --dall
                local moontree = RecipeYiyu("moontree", { glowdust10, Ingredient2("livinglog", 15), Ingredient2("purplegem", 8), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "moontree_placer")
                addAssert(moontree, "images/inventoryimages/moontree.xml")
                --oven
                local musha_oven = RecipeYiyu("musha_oven", { crystal, Ingredient2("limestone", 8), Ingredient2("sand", 8), Ingredient2("livinglog", 3), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "musha_oven_placer")
                addAssert(musha_oven, "images/inventoryimages/musha_oven.xml")
                --forge
                local forge_musha = RecipeYiyu("forge_musha", { glowdust10, Ingredient2("gears", 6), Ingredient2("transistor", 6), Ingredient2("livinglog", 10), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "forge_musha_placer")
                addAssert(forge_musha, "images/inventoryimages/forge_musha.xml")
                --tent
                local tent_musha = RecipeYiyu("tent_musha", { dust6, Ingredient2("boat_lantern", 1), Ingredient2("palmleaf", 20), Ingredient2("bamboo", 10), }, RECIPETABS.MUSHA, { SCIENCE = 1 }, nil, "tent_musha_placer")
                addAssert(tent_musha, "images/inventoryimages/tent_musha.xml")

                --dust

                local glowdust = RecipeYiyu("glowdust", { Ingredient2("wormlight", 1), Ingredient2("berries", 5) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(glowdust, "images/inventoryimages/glowdust.xml")

                --exp
                --[[
                 local exp = GLOBAL.Recipe( "exp", {Ingredient2("goldnugget", 4),}, RECIPETABS.MUSHA, {SCIENCE=0})
addAssert(                    exp,"images/inventoryimages/exp.xml")]]

                --cristal
                local cristal = RecipeYiyu("cristal", { dust10 }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(cristal, "images/inventoryimages/cristal.xml")

                --flute
                local musha_flute = RecipeYiyu("musha_flute", { dust10, Ingredient2("bamboo", 6), Ingredient2("antivenom", 6), Ingredient2("amulet", 2) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_flute, "images/inventoryimages/musha_flute.xml")

                --phoenix weapon

                local mushasword_base = RecipeYiyu("mushasword_base", { Ingredient2("goldnugget", 2), Ingredient2("flint", 3) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(mushasword_base, "images/inventoryimages/mushasword_base.xml")

                --[[ local mushasword = GLOBAL.Recipe( "mushasword", { bladeb, dust3, Ingredient2("goldnugget", 15) }, RECIPETABS.MUSHA, {SCIENCE=0})
addAssert(                mushasword,"images/inventoryimages/mushasword.xml")
                 local mushasword2 = GLOBAL.Recipe( "mushasword2", { blade1,  dust6, Ingredient2("feather_robin", 10), Ingredient2("goldnugget", 30)  }, RECIPETABS.MUSHA, {SCIENCE=1})
addAssert(                mushasword2,"images/inventoryimages/mushasword2.xml")
                 local mushasword3 = GLOBAL.Recipe( "mushasword3", { blade2,  dust15, Ingredient2("redgem", 20), Ingredient2("obsidian", 50) }, RECIPETABS.MUSHA, {SCIENCE=2})
addAssert(                mushasword3,"images/inventoryimages/mushasword3.xml")]]
                --fire
                local mushasword_fire = RecipeYiyu("mushasword_fire", { bladeb, glowdusts, Ingredient2("redgem", 6) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(mushasword_fire, "images/inventoryimages/mushasword_fire.xml")
                --frost
                local mushasword_frost = RecipeYiyu("mushasword_frost", { bladeb, glowdusts, Ingredient2("bluegem", 6) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(mushasword_frost, "images/inventoryimages/mushasword_frost.xml")
                --hammer
                local frosthammer = RecipeYiyu("frosthammer", { broken, Ingredient2("livinglog", 20), Ingredient2("bluegem", 30), broken }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(frosthammer, "images/inventoryimages/frosthammer.xml")
                --axe
                local mushasword4 = RecipeYiyu("mushasword4", { Ingredient2("obsidian", 60), Ingredient2("purplegem", 20), Ingredient2("greengem", 8), }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(mushasword4, "images/inventoryimages/mushasword4.xml")
                --armor
                local pirateback = RecipeYiyu("pirateback", { broken, armoraa, Ingredient2("dragoonheart", 8), Ingredient2("dubloon", 50) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(pirateback, "images/inventoryimages/pirateback.xml")

                local broken_frosthammer = RecipeYiyu("broken_frosthammer", { butterfly4, Ingredient2("gears", 4), Ingredient2("bluegem", 5) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(broken_frosthammer, "images/inventoryimages/broken_frosthammer.xml")

                local armor_mushaa = RecipeYiyu("armor_mushaa", { dust3, Ingredient2("goldnugget", 20), Ingredient2("boneshard", 6) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(armor_mushaa, "images/inventoryimages/armor_mushaa.xml")

                local frostback = RecipeYiyu("frostback", { broken, butterfly8, Ingredient2("bluegem", 6), Ingredient2("gears", 4) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(frostback, "images/inventoryimages/frostback.xml")

                local armor_mushab = RecipeYiyu("armor_mushab", { armoraa, Ingredient2("tigereye", 6), Ingredient2("orangegem", 10), Ingredient2("shark_gills", 12) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(armor_mushab, "images/inventoryimages/armor_mushab.xml")

                --hat

                local hat_mbunny = RecipeYiyu("hat_mbunny", { Ingredient2("blubber", 5), Ingredient2("cutgrass", 20), Ingredient2("purplegem", 2) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(hat_mbunny, "images/inventoryimages/hat_mbunny.xml")

                local hat_mprincess = RecipeYiyu("hat_mprincess", { amulet, Ingredient2("goldnugget", 10), }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(hat_mprincess, "images/inventoryimages/hat_mprincess.xml")

                local hat_mcrown = RecipeYiyu("hat_mcrown", { princess, Ingredient2("goldnugget", 20), Ingredient2("purplegem", 4) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(hat_mcrown, "images/inventoryimages/hat_mcrown.xml")

                local hat_mphoenix = RecipeYiyu("hat_mphoenix", { princess, Ingredient2("obsidian", 60), Ingredient2("yellowgem", 10), Ingredient2("goldnugget", 40), }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(hat_mphoenix, "images/inventoryimages/hat_mphoenix.xml")

                --egg
                --arong egg
                local musha_egg_arong = RecipeYiyu("musha_egg_arong", { phoenix_egg }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(musha_egg_arong, "images/inventoryimages/musha_egg_arong.xml")
                --phoenix_egg
                local musha_egg = RecipeYiyu("musha_egg", { dust10, Ingredient2("redgem", 30), Ingredient2("bluegem", 25), Ingredient2("greengem", 3) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(musha_egg, "images/inventoryimages/musha_egg.xml")


                local musha_eggs1 = RecipeYiyu("musha_eggs1", { phoenix_egg, Ingredient2("goldnugget", 10) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(musha_eggs1, "images/inventoryimages/musha_eggs1.xml")
                local musha_eggs2 = RecipeYiyu("musha_eggs2", { phoenix_eggs1, Ingredient2("goldnugget", 15) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(musha_eggs2, "images/inventoryimages/musha_eggs2.xml")
                local musha_eggs3 = RecipeYiyu("musha_eggs3", { phoenix_eggs2, Ingredient2("goldnugget", 30) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_eggs3, "images/inventoryimages/musha_eggs3.xml")
                local musha_egg1 = RecipeYiyu("musha_egg1", { phoenix_eggs3, Ingredient2("goldnugget", 45), Ingredient2("purplegem", 1) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg1, "images/inventoryimages/musha_egg1.xml")
                local musha_egg2 = RecipeYiyu("musha_egg2", { phoenix_egg1, Ingredient2("goldnugget", 60), Ingredient2("purplegem", 3) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg2, "images/inventoryimages/musha_egg2.xml")
                local musha_egg3 = RecipeYiyu("musha_egg3", { phoenix_egg2, Ingredient2("goldnugget", 90), Ingredient2("purplegem", 5) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg3, "images/inventoryimages/musha_egg3.xml")
                local musha_egg8 = RecipeYiyu("musha_egg8", { phoenix_egg3, Ingredient2("goldnugget", 150), Ingredient2("purplegem", 8) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg8, "images/inventoryimages/musha_egg8.xml")

            elseif true then
                require "recipe"
                require "tuning"

                --boat
                local musha_cargo = RecipeYiyu("musha_cargo", { Ingredient2("livinglog", 5), Ingredient2("boards", 4), Ingredient2("rope", 3), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "musha_cargo_placer", nil, nil, nil, true, 4)
                addAssert(musha_cargo, "images/inventoryimages/musha_cargo.xml")
                local sail_pirate = RecipeYiyu("sail_pirate", { Ingredient2("fabric", 3), Ingredient2("bamboo", 1), Ingredient2("charcoal", 1), }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(sail_pirate, "images/inventoryimages/sail_pirate.xml")
                local cgarenn_musha = RecipeYiyu("cgarenn_musha", { Ingredient2("boatcgarenn", 1), Ingredient2("flowerhat", 1), dust2 }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(cgarenn_musha, "images/inventoryimages/cgarenn_musha.xml")

                local moontree = RecipeYiyu("moontree", { glowdust5, Ingredient2("livinglog", 7), Ingredient2("purplegem", 4), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "moontree_placer")
                addAssert(moontree, "images/inventoryimages/moontree.xml")
                --oven
                local musha_oven = RecipeYiyu("musha_oven", { crystal, Ingredient2("limestone", 4), Ingredient2("sand", 4), Ingredient2("livinglog", 2), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "musha_oven_placer")
                addAssert(musha_oven, "images/inventoryimages/musha_oven.xml")
                --forge
                local forge_musha = RecipeYiyu("forge_musha", { glowdust10, Ingredient2("gears", 3), Ingredient2("transistor", 3), Ingredient2("livinglog", 5), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "forge_musha_placer")
                addAssert(forge_musha, "images/inventoryimages/forge_musha.xml")
                --tent
                local tent_musha = RecipeYiyu("tent_musha", { dust6, Ingredient2("boat_torch", 1), Ingredient2("palmleaf", 10), Ingredient2("bamboo", 8), }, RECIPETABS.MUSHA, { SCIENCE = 1 }, nil, "tent_musha_placer")
                addAssert(tent_musha, "images/inventoryimages/tent_musha.xml")

                --dust

                local glowdust = RecipeYiyu("glowdust", { Ingredient2("wormlight", 1), Ingredient2("berries", 3) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(glowdust, "images/inventoryimages/glowdust.xml")

                --exp
                --[[
                 local exp = GLOBAL.Recipe( "exp", {Ingredient2("goldnugget", 4),}, RECIPETABS.MUSHA, {SCIENCE=0})
addAssert(                    exp,"images/inventoryimages/exp.xml")]]

                --cristal
                local cristal = RecipeYiyu("cristal", { dust6 }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(cristal, "images/inventoryimages/cristal.xml")

                --flute
                local musha_flute = RecipeYiyu("musha_flute", { dust5, Ingredient2("bamboo", 3), Ingredient2("antivenom", 3), Ingredient2("amulet", 1) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_flute, "images/inventoryimages/musha_flute.xml")

                --phoenix weapon

                local mushasword_base = RecipeYiyu("mushasword_base", { Ingredient2("goldnugget", 1), Ingredient2("flint", 2) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(mushasword_base, "images/inventoryimages/mushasword_base.xml")

                --[[ local mushasword = GLOBAL.Recipe( "mushasword", { bladeb, glowdusts, Ingredient2("goldnugget", 7) }, RECIPETABS.MUSHA, {SCIENCE=0})
addAssert(                mushasword,"images/inventoryimages/mushasword.xml")
                 local mushasword2 = GLOBAL.Recipe( "mushasword2", { blade1,  dust3, Ingredient2("feather_robin", 4), Ingredient2("goldnugget", 15)  }, RECIPETABS.MUSHA, {SCIENCE=1})
addAssert(                mushasword2,"images/inventoryimages/mushasword2.xml")
                 local mushasword3 = GLOBAL.Recipe( "mushasword3", { blade2,  dust5, Ingredient2("redgem", 5), Ingredient2("obsidian", 20) }, RECIPETABS.MUSHA, {SCIENCE=2})
addAssert(                mushasword3,"images/inventoryimages/mushasword3.xml")]]
                --fire
                local mushasword_fire = RecipeYiyu("mushasword_fire", { bladeb, glowdusts, Ingredient2("redgem", 3) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(mushasword_fire, "images/inventoryimages/mushasword_fire.xml")
                --frost
                local mushasword_frost = RecipeYiyu("mushasword_frost", { bladeb, glowdusts, Ingredient2("bluegem", 3) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(mushasword_frost, "images/inventoryimages/mushasword_frost.xml")
                --hammer
                local frosthammer = RecipeYiyu("frosthammer", { broken, Ingredient2("livinglog", 10), Ingredient2("bluegem", 6), broken }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(frosthammer, "images/inventoryimages/frosthammer.xml")
                --axe
                local mushasword4 = RecipeYiyu("mushasword4", { Ingredient2("obsidian", 30), Ingredient2("purplegem", 4), Ingredient2("greengem", 4), Ingredient2("obsidian", 6) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(mushasword4, "images/inventoryimages/mushasword4.xml")
                --armor
                local pirateback = RecipeYiyu("pirateback", { broken, armoraa, Ingredient2("dragoonheart", 4), Ingredient2("dubloon", 25) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(pirateback, "images/inventoryimages/pirateback.xml")

                local broken_frosthammer = RecipeYiyu("broken_frosthammer", { butterfly4, Ingredient2("gears", 2), Ingredient2("bluegem", 3) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(broken_frosthammer, "images/inventoryimages/broken_frosthammer.xml")

                local armor_mushaa = RecipeYiyu("armor_mushaa", { glowdusts, Ingredient2("goldnugget", 10), Ingredient2("boneshard", 3) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(armor_mushaa, "images/inventoryimages/armor_mushaa.xml")

                local frostback = RecipeYiyu("frostback", { broken, butterfly4, Ingredient2("bluegem", 2), Ingredient2("gears", 2) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(frostback, "images/inventoryimages/frostback.xml")

                local armor_mushab = RecipeYiyu("armor_mushab", { armoraa, Ingredient2("tigereye", 3), Ingredient2("orangegem", 4), Ingredient2("shark_gills", 6) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(armor_mushab, "images/inventoryimages/armor_mushab.xml")

                --hat

                local hat_mbunny = RecipeYiyu("hat_mbunny", { Ingredient2("blubber", 1), Ingredient2("cutgrass", 10), Ingredient2("purplegem", 1) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(hat_mbunny, "images/inventoryimages/hat_mbunny.xml")

                local hat_mprincess = RecipeYiyu("hat_mprincess", { amulet, Ingredient2("goldnugget", 6) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(hat_mprincess, "images/inventoryimages/hat_mprincess.xml")

                local hat_mcrown = RecipeYiyu("hat_mcrown", { princess, Ingredient2("goldnugget", 8), Ingredient2("purplegem", 3) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(hat_mcrown, "images/inventoryimages/hat_mcrown.xml")

                local hat_mphoenix = RecipeYiyu("hat_mphoenix", { princess, Ingredient2("obsidian", 20), Ingredient2("yellowgem", 3) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(hat_mphoenix, "images/inventoryimages/hat_mphoenix.xml")

                --egg
                --arong egg
                local musha_egg_arong = RecipeYiyu("musha_egg_arong", { phoenix_egg }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(musha_egg_arong, "images/inventoryimages/musha_egg_arong.xml")
                --phoenix_egg
                local musha_egg = RecipeYiyu("musha_egg", { dust10, Ingredient2("redgem", 30), Ingredient2("bluegem", 25), Ingredient2("greengem", 3) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(musha_egg, "images/inventoryimages/musha_egg.xml")


                local musha_eggs1 = RecipeYiyu("musha_eggs1", { phoenix_egg, Ingredient2("goldnugget", 5) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(musha_eggs1, "images/inventoryimages/musha_eggs1.xml")
                local musha_eggs2 = RecipeYiyu("musha_eggs2", { phoenix_eggs1, Ingredient2("goldnugget", 8) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(musha_eggs2, "images/inventoryimages/musha_eggs2.xml")
                local musha_eggs3 = RecipeYiyu("musha_eggs3", { phoenix_eggs2, Ingredient2("goldnugget", 10) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_eggs3, "images/inventoryimages/musha_eggs3.xml")
                local musha_egg1 = RecipeYiyu("musha_egg1", { phoenix_eggs3, Ingredient2("goldnugget", 20), Ingredient2("purplegem", 1) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg1, "images/inventoryimages/musha_egg1.xml")
                local musha_egg2 = RecipeYiyu("musha_egg2", { phoenix_egg1, Ingredient2("goldnugget", 30), Ingredient2("purplegem", 3) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg2, "images/inventoryimages/musha_egg2.xml")
                local musha_egg3 = RecipeYiyu("musha_egg3", { phoenix_egg2, Ingredient2("goldnugget", 45), Ingredient2("purplegem", 5) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg3, "images/inventoryimages/musha_egg3.xml")
                local musha_egg8 = RecipeYiyu("musha_egg8", { phoenix_egg3, Ingredient2("goldnugget", 75), Ingredient2("purplegem", 8) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg8, "images/inventoryimages/musha_egg8.xml")

            elseif true then
                require "recipe"
                require "tuning"

                --boat
                local musha_cargo = RecipeYiyu("musha_cargo", { Ingredient2("livinglog", 2), Ingredient2("boards", 2), Ingredient2("rope", 1), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "musha_cargo_placer", nil, nil, nil, true, 4)
                addAssert(musha_cargo, "images/inventoryimages/musha_cargo.xml")
                local sail_pirate = RecipeYiyu("sail_pirate", { Ingredient2("fabric", 1), Ingredient2("bamboo", 1), Ingredient2("charcoal", 1), }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(sail_pirate, "images/inventoryimages/sail_pirate.xml")
                local cgarenn_musha = RecipeYiyu("cgarenn_musha", { Ingredient2("boatcgarenn", 1), Ingredient2("flowerhat", 1) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(cgarenn_musha, "images/inventoryimages/cgarenn_musha.xml")
                --
                local moontree = RecipeYiyu("moontree", { glowdusts, Ingredient2("livinglog", 3), Ingredient2("purplegem", 2), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "moontree_placer")
                addAssert(moontree, "images/inventoryimages/moontree.xml")
                --oven
                local musha_oven = RecipeYiyu("musha_oven", { glowdusts, Ingredient2("limestone", 2), Ingredient2("sand", 2), Ingredient2("livinglog", 1), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "musha_oven_placer")
                addAssert(musha_oven, "images/inventoryimages/musha_oven.xml")
                --forge
                local forge_musha = RecipeYiyu("forge_musha", { glowdusts, Ingredient2("gears", 1), Ingredient2("transistor", 1), Ingredient2("livinglog", 2), }, RECIPETABS.MUSHA, { SCIENCE = 2 }, nil, "forge_musha_placer")
                addAssert(forge_musha, "images/inventoryimages/forge_musha.xml")
                --tent
                local tent_musha = RecipeYiyu("tent_musha", { glowdusts, Ingredient2("boat_torch", 1), Ingredient2("palmleaf", 5), Ingredient2("bamboo", 2), }, RECIPETABS.MUSHA, { SCIENCE = 1 }, nil, "tent_musha_placer")
                addAssert(tent_musha, "images/inventoryimages/tent_musha.xml")

                --dust

                local glowdust = RecipeYiyu("glowdust", { Ingredient2("wormlight", 1), Ingredient2("berries", 1) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(glowdust, "images/inventoryimages/glowdust.xml")

                --exp
                --[[
                 local exp = GLOBAL.Recipe( "exp", {Ingredient2("goldnugget", 4),}, RECIPETABS.MUSHA, {SCIENCE=0})
addAssert(                    exp,"images/inventoryimages/exp.xml")]]

                --cristal
                local cristal = RecipeYiyu("cristal", { dust4 }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(cristal, "images/inventoryimages/cristal.xml")

                --flute
                local musha_flute = RecipeYiyu("musha_flute", { glowdusts, Ingredient2("bamboo", 1), Ingredient2("antivenom", 1), Ingredient2("amulet", 1) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_flute, "images/inventoryimages/musha_flute.xml")

                --phoenix weapon

                local mushasword_base = RecipeYiyu("mushasword_base", { Ingredient2("flint", 1) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(mushasword_base, "images/inventoryimages/mushasword_base.xml")

                --[[ local mushasword = GLOBAL.Recipe( "mushasword", { bladeb, glowdusts, Ingredient2("goldnugget", 2) }, RECIPETABS.MUSHA, {SCIENCE=0})
addAssert(                mushasword,"images/inventoryimages/mushasword.xml")
                 local mushasword2 = GLOBAL.Recipe( "mushasword2", { blade1,  glowdusts, Ingredient2("feather_robin", 1), Ingredient2("goldnugget", 3)  }, RECIPETABS.MUSHA, {SCIENCE=1})
addAssert(                mushasword2,"images/inventoryimages/mushasword2.xml")
                 local mushasword3 = GLOBAL.Recipe( "mushasword3", { blade2,  glowdusts, Ingredient2("redgem", 1), Ingredient2("obsidian", 3) }, RECIPETABS.MUSHA, {SCIENCE=2})
addAssert(                mushasword3,"images/inventoryimages/mushasword3.xml")
                 local mushasword4 = GLOBAL.Recipe( "mushasword4", { blade2, blade_f, Ingredient2("greengem", 2),  Ingredient2("obsidian", 3) }, RECIPETABS.MUSHA, {SCIENCE=2})
addAssert(                mushasword4,"images/inventoryimages/mushasword4.xml")]]

                --fire
                local mushasword_fire = RecipeYiyu("mushasword_fire", { bladeb, glowdusts, Ingredient2("redgem", 1) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(mushasword_fire, "images/inventoryimages/mushasword_fire.xml")
                --frost
                local mushasword_frost = RecipeYiyu("mushasword_frost", { bladeb, glowdusts, Ingredient2("bluegem", 1) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(mushasword_frost, "images/inventoryimages/mushasword_frost.xml")
                --hammer

                local frosthammer = RecipeYiyu("frosthammer", { broken, Ingredient2("livinglog", 5), Ingredient2("bluegem", 1), broken }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(frosthammer, "images/inventoryimages/frosthammer.xml")

                --armor
                local pirateback = RecipeYiyu("pirateback", { broken, armoraa, Ingredient2("dragoonheart", 2), Ingredient2("dubloon", 12) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(pirateback, "images/inventoryimages/pirateback.xml")

                local broken_frosthammer = RecipeYiyu("broken_frosthammer", { butterfly4, Ingredient2("gears", 1), Ingredient2("bluegem", 1) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(broken_frosthammer, "images/inventoryimages/broken_frosthammer.xml")

                local armor_mushaa = RecipeYiyu("armor_mushaa", { glowdusts, Ingredient2("goldnugget", 5) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(armor_mushaa, "images/inventoryimages/armor_mushaa.xml")

                local frostback = RecipeYiyu("frostback", { broken, Ingredient2("bluegem", 1), Ingredient2("gears", 1) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(frostback, "images/inventoryimages/frostback.xml")

                local armor_mushab = RecipeYiyu("armor_mushab", { armoraa, Ingredient2("orangegem", 1), Ingredient2("purplegem", 2) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(armor_mushab, "images/inventoryimages/armor_mushab.xml")

                --hat

                local hat_mbunny = RecipeYiyu("hat_mbunny", { Ingredient2("cutgrass", 5), Ingredient2("purplegem", 1) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(hat_mbunny, "images/inventoryimages/hat_mbunny.xml")

                local hat_mprincess = RecipeYiyu("hat_mprincess", { amulet, Ingredient2("goldnugget", 3) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(hat_mprincess, "images/inventoryimages/hat_mprincess.xml")

                local hat_mcrown = RecipeYiyu("hat_mcrown", { princess, Ingredient2("goldnugget", 3), Ingredient2("purplegem", 1) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(hat_mcrown, "images/inventoryimages/hat_mcrown.xml")

                local hat_mphoenix = RecipeYiyu("hat_mphoenix", { princess, Ingredient2("obsidian", 5) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(hat_mphoenix, "images/inventoryimages/hat_mphoenix.xml")

                --egg
                --arong egg
                local musha_egg_arong = RecipeYiyu("musha_egg_arong", { phoenix_egg }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(musha_egg_arong, "images/inventoryimages/musha_egg_arong.xml")
                --phoenix_egg
                local musha_egg = RecipeYiyu("musha_egg", { dust10, Ingredient2("redgem", 15), Ingredient2("bluegem", 10), Ingredient2("greengem", 7) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(musha_egg, "images/inventoryimages/musha_egg.xml")
                local musha_eggs1 = RecipeYiyu("musha_eggs1", { phoenix_egg, Ingredient2("goldnugget", 1) }, RECIPETABS.MUSHA, { SCIENCE = 0 })
                addAssert(musha_eggs1, "images/inventoryimages/musha_eggs1.xml")
                local musha_eggs2 = RecipeYiyu("musha_eggs2", { phoenix_eggs1, Ingredient2("goldnugget", 3) }, RECIPETABS.MUSHA, { SCIENCE = 1 })
                addAssert(musha_eggs2, "images/inventoryimages/musha_eggs2.xml")
                local musha_eggs3 = RecipeYiyu("musha_eggs3", { phoenix_eggs2, Ingredient2("goldnugget", 7) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_eggs3, "images/inventoryimages/musha_eggs3.xml")
                local musha_egg1 = RecipeYiyu("musha_egg1", { phoenix_eggs3, Ingredient2("goldnugget", 10) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg1, "images/inventoryimages/musha_egg1.xml")
                local musha_egg2 = RecipeYiyu("musha_egg2", { phoenix_egg1, Ingredient2("goldnugget", 15), Ingredient2("purplegem", 1) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg2, "images/inventoryimages/musha_egg2.xml")
                local musha_egg3 = RecipeYiyu("musha_egg3", { phoenix_egg2, Ingredient2("goldnugget", 25), Ingredient2("purplegem", 2) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg3, "images/inventoryimages/musha_egg3.xml")
                local musha_egg8 = RecipeYiyu("musha_egg8", { phoenix_egg3, Ingredient2("goldnugget", 30), Ingredient2("purplegem", 4) }, RECIPETABS.MUSHA, { SCIENCE = 2 })
                addAssert(musha_egg8, "images/inventoryimages/musha_egg8.xml")
                ------------------------------------------------------------------------------------------------------------
            end
        end
    end
    if _G.Prefabs.wharang then
        if GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) then
            local FirePit_Ghost = RecipeYiyu("firepit_ghost", { Ingredient2("goldnugget", 15), Ingredient2("cutstone", 6), Ingredient2("nitre", 3) }, RECIPETABS.YINYANG, { SCIENCE = 0 }, GLOBAL.RECIPE_GAME_TYPE.COMMON, "firepit_ghost_placer", 2)
            addAssert(FirePit_Ghost, "images/inventoryimages/firepit_ghost.xml")

            local FirePit_Chill = RecipeYiyu("firepit_chill", { Ingredient2("goldnugget", 15), Ingredient2("cutstone", 6), Ingredient2("nitre", 4) }, RECIPETABS.YINYANG, { SCIENCE = 0 }, GLOBAL.RECIPE_GAME_TYPE.COMMON, "firepit_chill_placer", 2)
            addAssert(FirePit_Chill, "images/inventoryimages/firepit_chill.xml")


            local MoonDumplings = RecipeYiyu("moondumplings", { Ingredient2("berries", 4), Ingredient2("seeds_cooked", 3) }, RECIPETABS.YINYANG, { SCIENCE = 0 }, GLOBAL.RECIPE_GAME_TYPE.COMMON)
            addAssert(MoonDumplings, "images/inventoryimages/moondumplings.xml")

            local GumiFan = RecipeYiyu("gumifan", { Ingredient2("handfan", 1, "images/inventoryimages/handfan.xml"), Ingredient2("rope", 2), Ingredient2("goldnugget", 2) }, RECIPETABS.YINYANG, { SCIENCE = 0 }, GLOBAL.RECIPE_GAME_TYPE.COMMON)
            addAssert(GumiFan, "images/inventoryimages/gumifan.xml")

            local SakuraHat = RecipeYiyu("sakurahat", { Ingredient2("petals", 10), Ingredient2("cutgrass", 3) }, RECIPETABS.YINYANG, { SCIENCE = 0 }, GLOBAL.RECIPE_GAME_TYPE.COMMON)
            addAssert(SakuraHat, "images/inventoryimages/sakurahat.xml")
            local FoxMask = RecipeYiyu("foxmask", { Ingredient2("goldnugget", 1), Ingredient2("pigskin", 4), Ingredient2("nightmarefuel", 2) }, RECIPETABS.YINYANG, { SCIENCE = 0 }, GLOBAL.RECIPE_GAME_TYPE.COMMON)
            addAssert(FoxMask, "images/inventoryimages/foxmask.xml")

            local Flute_Flame = RecipeYiyu("flute_flame", { Ingredient2("cutgrass", 5), Ingredient2("feather_robin", 10), Ingredient2("goldnugget", 4) }, RECIPETABS.YINYANG, TECH.SCIENCE_ONE, GLOBAL.RECIPE_GAME_TYPE.COMMON)
            addAssert(Flute_Flame, "images/inventoryimages/flute_flame.xml")
            local Flute_Frost = RecipeYiyu("flute_frost", { Ingredient2("cutgrass", 5), Ingredient2("feather_robin_winter", 5), Ingredient2("goldnugget", 4) }, RECIPETABS.YINYANG, TECH.SCIENCE_ONE, GLOBAL.RECIPE_GAME_TYPE.COMMON)
            addAssert(Flute_Frost, "images/inventoryimages/flute_frost.xml")
            local Flute_Healing = RecipeYiyu("flute_healing", { Ingredient2("cutgrass", 5), Ingredient2("feather_crow", 10), Ingredient2("goldnugget", 4) }, RECIPETABS.YINYANG, TECH.SCIENCE_ONE, GLOBAL.RECIPE_GAME_TYPE.COMMON)
            addAssert(Flute_Healing, "images/inventoryimages/flute_healing.xml")

            local OngGi = RecipeYiyu("gumipot", { Ingredient2("boards", 8), Ingredient2("cutstone", 12) }, RECIPETABS.YINYANG, { SCIENCE = 0 }, GLOBAL.RECIPE_GAME_TYPE.COMMON, "gumipot_placer", .9)
            addAssert(OngGi, "images/inventoryimages/gumipot.xml")
            local AsiaHouse = RecipeYiyu("asiahouse", { Ingredient2("boards", 10), Ingredient2("wall_stone_item", 40), Ingredient2("redgem", 2) }, RECIPETABS.YINYANG, { SCIENCE = 2 }, GLOBAL.RECIPE_GAME_TYPE.COMMON, "asiahouse_placer", 4)
            addAssert(AsiaHouse, "images/inventoryimages/asiahouse.xml")
            local AsiaHouse2 = RecipeYiyu("asiahouse2", { Ingredient2("goldnugget", 4), Ingredient2("wall_wood_item", 40), Ingredient2("bluegem", 2) }, RECIPETABS.YINYANG, { SCIENCE = 2 }, GLOBAL.RECIPE_GAME_TYPE.COMMON, "asiahouse2_placer", 4)
            addAssert(AsiaHouse2, "images/inventoryimages/asiahouse2.xml")

        elseif not GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) then
            local FirePit_Ghost = RecipeYiyu("firepit_ghost", { Ingredient2("goldnugget", 15), Ingredient2("cutstone", 6), Ingredient2("nitre", 3) }, RECIPETABS.YINYANG, { SCIENCE = 0 }, "firepit_ghost_placer", 2)
            addAssert(FirePit_Ghost, "images/inventoryimages/firepit_ghost.xml")
            if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) then
                local FirePit_Chill = RecipeYiyu("firepit_chill", { Ingredient2("goldnugget", 15), Ingredient2("cutstone", 6), Ingredient2("nitre", 4) }, RECIPETABS.YINYANG, { SCIENCE = 0 }, "firepit_chill_placer", 2)
                addAssert(FirePit_Chill, "images/inventoryimages/firepit_chill.xml")
            end

            local MoonDumplings = RecipeYiyu("moondumplings", { Ingredient2("berries", 4), Ingredient2("seeds_cooked", 3) }, RECIPETABS.YINYANG, { SCIENCE = 0 })
            addAssert(MoonDumplings, "images/inventoryimages/moondumplings.xml")

            local GumiFan = RecipeYiyu("gumifan", { Ingredient2("handfan", 1, "images/inventoryimages/handfan.xml"), Ingredient2("rope", 2), Ingredient2("goldnugget", 2) }, RECIPETABS.YINYANG, { SCIENCE = 0 })
            addAssert(GumiFan, "images/inventoryimages/gumifan.xml")

            local SakuraHat = RecipeYiyu("sakurahat", { Ingredient2("petals", 10), Ingredient2("cutgrass", 3) }, RECIPETABS.YINYANG, { SCIENCE = 0 })
            addAssert(SakuraHat, "images/inventoryimages/sakurahat.xml")
            local FoxMask = RecipeYiyu("foxmask", { Ingredient2("goldnugget", 1), Ingredient2("manrabbit_tail", 4), Ingredient2("nightmarefuel", 2) }, RECIPETABS.YINYANG, { SCIENCE = 0 })
            addAssert(FoxMask, "images/inventoryimages/foxmask.xml")

            local Flute_Flame = RecipeYiyu("flute_flame", { Ingredient2("cutreeds", 5), Ingredient2("feather_robin", 10), Ingredient2("goldnugget", 4) }, RECIPETABS.YINYANG, TECH.SCIENCE_ONE)
            addAssert(Flute_Flame, "images/inventoryimages/flute_flame.xml")
            local Flute_Frost = RecipeYiyu("flute_frost", { Ingredient2("cutreeds", 5), Ingredient2("feather_robin_winter", 10), Ingredient2("goldnugget", 4) }, RECIPETABS.YINYANG, TECH.SCIENCE_ONE)
            addAssert(Flute_Frost, "images/inventoryimages/flute_frost.xml")
            local Flute_Healing = RecipeYiyu("flute_healing", { Ingredient2("cutreeds", 5), Ingredient2("feather_crow", 10), Ingredient2("goldnugget", 4) }, RECIPETABS.YINYANG, TECH.SCIENCE_ONE)
            addAssert(Flute_Healing, "images/inventoryimages/flute_healing.xml")

            local AsiaWall = RecipeYiyu("wall_asia_item", { Ingredient2("log", 6), Ingredient2("cutstone", 2) }, RECIPETABS.YINYANG, { SCIENCE = 0 }, nil, nil, nil, 4)
            addAssert(AsiaWall, "images/inventoryimages/wall_asia_item.xml")


            local OngGi = RecipeYiyu("gumipot", { Ingredient2("boards", 8), Ingredient2("cutstone", 12) }, RECIPETABS.YINYANG, { SCIENCE = 0 }, "gumipot_placer", .9)
            addAssert(OngGi, "images/inventoryimages/gumipot.xml")
            local AsiaHouse = RecipeYiyu("asiahouse", { Ingredient2("boards", 10), Ingredient2("wall_stone_item", 40), Ingredient2("redgem", 2) }, RECIPETABS.YINYANG, TECH.ANCIENT_TWO, "asiahouse_placer", 4)
            addAssert(AsiaHouse, "images/inventoryimages/asiahouse.xml")
            local AsiaHouse2 = RecipeYiyu("asiahouse2", { Ingredient2("goldnugget", 4), Ingredient2("wall_wood_item", 40), Ingredient2("bluegem", 2) }, RECIPETABS.YINYANG, TECH.ANCIENT_TWO, "asiahouse2_placer", 4)
            addAssert(AsiaHouse2, "images/inventoryimages/asiahouse2.xml")

            local Turf_Asia = RecipeYiyu("turf_asia", { Ingredient2("beefalowool", 2), Ingredient2("silk", 1) }, RECIPETABS.YINYANG, { SCIENCE = 0 }, nil, nil, nil, 4)
            addAssert(Turf_Asia, "images/inventoryimages/turf_asia.xml")
            local Turf_Orient = RecipeYiyu("turf_orient", { Ingredient2("beefalowool", 2), Ingredient2("silk", 1) }, RECIPETABS.YINYANG, { SCIENCE = 0 }, nil, nil, nil, 4)
            addAssert(Turf_Orient, "images/inventoryimages/turf_orient.xml")
            local Turf_Flame_Rose = RecipeYiyu("turf_flamerose", { Ingredient2("beefalowool", 1), Ingredient2("petals", 3) }, RECIPETABS.YINYANG, { SCIENCE = 0 }, nil, nil, nil, 4)
            addAssert(Turf_Flame_Rose, "images/inventoryimages/turf_flamerose.xml")
        end
    end
end