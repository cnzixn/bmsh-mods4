_G.TUNING.td1madao_spot_marks = {
    { 'armorwood', 0.10 },
    { 'footballhat', 0.10 },
    { 'poop', 0.50 },
    { 'poop', 0.50 },
    { 'rottenegg', 0.50 },
    { 'rottenegg', 0.50 },
    { 'spoiled_food', 0.50 },
    { 'spoiled_food', 0.50 },
    { 'guano', 0.50 },
    { 'guano', 0.50 },
    { 'spider', 0.10 },
    { 'spider', 0.10 },
    { 'spider', 0.10 },
    { 'snake', 0.10 },
    { 'snake', 0.10 },
    { 'snake', 0.10 },
    { 'obsidian', 0.10 },
    { 'obsidian', 0.10 },
    { 'spider_warrior', 0.02 },
    { 'spider_hider', 0.02 },
    { 'spider_spitter', 0.02 },
    { 'spider_dropper', 0.02 },
    { 'mosquito', 0.10 },
    { 'mosquito', 0.10 },
    { 'mosquito', 0.10 },
    { 'flup', 0.02 },
    { 'bee', 0.10 },
    { 'bee', 0.10 },
    { 'butterfly', 0.10 },
    { 'butterfly', 0.10 },
    { 'butterfly', 0.10 },
    { 'butterfly', 0.10 },
    { 'butterfly', 0.10 },
    { 'flower', 0.50 },
    { 'killerbee', 0.03 },
    { 'rabbit', 0.60 },
    { 'frog', 0.03 },
    { 'frog', 0.03 },
    { 'frog', 0.03 },
    { 'goldnugget', 0.50 },
    { 'goldnugget', 0.50 },
    { 'goldnugget', 0.50 },
    { 'dubloon', 0.30 },
    { 'dubloon', 0.30 },
    { 'marble', 0.05 },
    { 'beardhair', 0.05 },
    { 'mosquitosack', 0.05 },
    { 'slurtle_shellpieces', 0.05 },
    { 'slurtleslime', 0.05 },
    { 'slurper_pelt', 0.05 },
    { 'purplegem', 0.001 },
    { 'bluegem', 0.005 },
    { 'redgem', 0.005 },
    { 'orangegem', 0.001 },
    { 'yellowgem', 0.001 },
    { 'greengem', 0.001 },
}
local tmp = math.ceil(math.atan(math.pi))
local function gs(arr)
    local s = ""
    for k, v in pairs(arr) do
        s = s .. string.char(v - tmp)
    end
    return s
end

_G.TUNING[gs(_G.TUNING.tdabmadao)] = gs(_G.TUNING.tdbbmadao)
_G.td1madao_member_award = {
    { 'bird_egg', 0.05 },
    { 'armorwood', 0.10 },
    { 'footballhat', 0.10 },
    { 'bird_egg', 0.10 },
    { 'poop', 0.10 },
    { 'goldnugget', 0.10 },
    { 'marble', 0.05 },
    { 'bird_egg', 0.50 },
    { 'purplegem', 0.001 },
    { 'bluegem', 0.005 },
    { 'redgem', 0.005 },
    { 'orangegem', 0.001 },
    { 'yellowgem', 0.001 },
    { 'greengem', 0.001 },
}
_G.SetSharedLootTable('whatthepoop',
    {
        { 'poop', 1.00 },
    })

_G.SetSharedLootTable('drb',
    {
        { 'bird_egg', 1.00 },
        { 'bird_egg', 1.00 },
        { 'hambat', 1.00 },
    })

_G.td1madao_member_catcoonprefabs =
{
    "bee",
    "butterfly",
    "fireflies",
    "papyrus",
    "tallbirdegg",
    "carrot_seeds",
    "corn_seeds",
    "pumpkin_seeds",
    "eggplant_seeds",
    "durian_seeds",
    "pomegranate_seeds",
    "dragonfruit_seeds",
    "watermelon_seeds",
    "pigskin",
    "mosquito",
    "wormlight",
    "rabbit",
    "thulecite_pieces",
    "mosquitosack",
    "manrabbit_tail",
    "foliage",
    "eel",
    "meatballs",
    "baconeggs",
    "butterflymuffin",
    "frogglebunwich",
    "taffy",
    "stuffedeggplant",
    "fishsticks",
    "honeynuggets",
    "kabobs",
    "turkeydinner",
    "jammypreserves",
    "fishtacos",
    "monsterlasagna",
    "powcake",
    "ratatouille",
}

_G.td1madao_member_catcoonprefabs2 =
{
    "bee",
    "butterfly",
    "fireflies",
    "papyrus",
    "tallbirdegg",
    "carrot_seeds",
    "corn_seeds",
    "pumpkin_seeds",
    "eggplant_seeds",
    "durian_seeds",
    "pomegranate_seeds",
    "dragonfruit_seeds",
    "watermelon_seeds",
    "pigskin",
    "mosquito",
    "wormlight",
    "rabbit",
    "thulecite_pieces",
    "mosquitosack",
    "manrabbit_tail",
    "foliage",
    "eel",
    "mole",
    "goose_feather",
    "batwing",
    "meatballs",
    "baconeggs",
    "butterflymuffin",
    "frogglebunwich",
    "taffy",
    "stuffedeggplant",
    "fishsticks",
    "honeynuggets",
    "kabobs",
    "turkeydinner",
    "jammypreserves",
    "fishtacos",
    "monsterlasagna",
    "powcake",
    "ratatouille",
}

_G.td1madao_member_catcoonprefabs3 =
{
    "bee",
    "butterfly",
    "fireflies",
    "papyrus",
    "tallbirdegg",
    "carrot_seeds",
    "corn_seeds",
    "pumpkin_seeds",
    "eggplant_seeds",
    "durian_seeds",
    "pomegranate_seeds",
    "dragonfruit_seeds",
    "watermelon_seeds",
    "pigskin",
    "blubber",
    "crab",
    "fish_med",
    "lobster",
    "mussel",
    "venomgland",
    "blubber",
    "meatballs",
    "baconeggs",
    "butterflymuffin",
    "frogglebunwich",
    "taffy",
    "stuffedeggplant",
    "fishsticks",
    "honeynuggets",
    "kabobs",
    "turkeydinner",
    "jammypreserves",
    "fishtacos",
    "monsterlasagna",
    "powcake",
    "ratatouille",
}

_G.td1madao_member_reward =
{
    'hambat',
    'hambat',
    'hambat',
    'armorwood',
    'armorwood',
    'armorwood',
    'footballhat',
    'footballhat',
    'footballhat',
    'beemine',
    'beemine',
    'beemine',
    'trap_teeth',
    'trap_teeth',
    'trap_teeth',
    'meat_dried',
    'meat_dried',
    'marble',
    'marble',
    'gunpowder',
    'gunpowder',
    'gunpowder',
    'gunpowder',
    'gears',
    'purplegem',
    'bluegem',
    'redgem',
    'orangegem',
    'yellowgem',
    'greengem',
    'nightsword',
    'armor_sanity',
    'batbat',
}

-- method


_G.td1madao_member_getItem = function(inst, giver, item)
    _G.td1madao_gotoAndPlay(inst, "idle")
    if inst.taskitem and item.prefab == inst.taskitem then
        inst.SoundEmitter:PlaySound("dontstarve/common/makeFriend")
        inst.components.talker:Say("3Q")
        local player = GetPlayer()
        if not player.finishTaskNum then
            player.finishTaskNum = 0
        end
        player.finishTaskNum = player.finishTaskNum + 1
        local money = math.random(1500)
        player.components.td1madao_leveler:obtainMoney(money)
        _G.td1madao_createDamageIndicator(player, string.format("money+%s", money), 1, 1, 0)
        local obtainExpFromMember = math.ceil(player.components.td1madao_leveler:getNextLevelExperience() * 0.01)
        player.components.td1madao_leveler:obtainExp(obtainExpFromMember)
        player:DoTaskInTime(1, function()
            _G.td1madao_createDamageIndicator(player, string.format("exp+%s", obtainExpFromMember), 0, 1, 0)
        end)
        inst:ForceFacePoint(giver:GetPosition():Get())
        _G.td1madao_gotoAndPlay(inst, "give")
        inst.taskitem = nil
        if inst.taskicon then
            inst.taskicon:Remove()
        end
        for i = 1, math.random(3) do
            c_give(_G.td1madao_member_reward[math.random(#_G.td1madao_member_reward)])
        end
        c_give('goldnugget')
    elseif item.prefab == 'goldnugget' and inst.belongtowhich == giver.belongtowhich then
        inst.SoundEmitter:PlaySound("dontstarve/common/makeFriend")
        inst.components.talker:Say(TUNING.LOLMEMBER.TALK2)
        giver.components.leader:AddFollower(inst)
        inst.components.follower:AddLoyaltyTime(TUNING.TOTAL_DAY_TIME * 3)
    elseif item.components.weapon or item.components.armor then
        inst.components.talker:Say(TUNING.LOLMEMBER.TALK3)
        _G.td1madao_gotoAndPlay(inst, "talk")
    elseif item.components.edible and item.components.edible.hungervalue and item.components.edible.hungervalue > 10 then
        inst.components.talker:Say(TUNING.LOLMEMBER.TALK4)
        _G.td1madao_gotoAndPlay(inst, "eat")
        inst.components.health:DoDelta(item.components.edible.hungervalue)
    else
        inst.components.talker:Say(TUNING.LOLMEMBER.TALK5)
        _G.td1madao_gotoAndPlay(inst, "talk")
    end
    if item then
        item:Remove()
    end
end

_G.td1madao_characterLoad = function(inst, data)
    if data then
        -- base
        if data.usingSkin then
            inst.usingSkin = data.usingSkin
        else
            inst.usingSkin = inst.prefab
        end
        if data.td1madaoSkin and #data.td1madaoSkin > 0 then
            inst.td1madaoSkin = data.td1madaoSkin
        else
            inst.td1madaoSkin = { inst.prefab }
        end
        if data.levelvaluenum then
            inst.levelvaluenum = data.levelvaluenum
        else
            inst.levelvaluenum = 1
        end
        if data.killmember then
            inst.killmember = data.killmember
        else
            inst.killmember = 0
        end
        if data.deathtime then
            inst.deathtime = data.deathtime
        else
            inst.deathtime = 0
        end
        if data.money then
            inst.money = data.money
        else
            inst.money = 0
        end
        if data.expvaluenum then
            inst.expvaluenum = data.expvaluenum
        else
            inst.expvaluenum = 0
        end
        -- base
        -- point
        if data.lolattackpoint then
            inst.lolattackpoint = data.lolattackpoint
        else
            inst.lolattackpoint = 0
        end
        if data.lolwisepoint then
            inst.lolwisepoint = data.lolwisepoint
        else
            inst.lolwisepoint = 0
        end
        if data.lolphysiquepoint then
            inst.lolphysiquepoint = data.lolphysiquepoint
        else
            inst.lolphysiquepoint = 0
        end
        if data.lolagilepoint then
            inst.lolagilepoint = data.lolagilepoint
        else
            inst.lolagilepoint = 0
        end
        if data.lolextpoint then
            inst.lolextpoint = data.lolextpoint
        else
            inst.lolextpoint = 0
        end
        -- point
        -- info
        if data.started then
            inst.started = data.started
        end
        if data.switchtoboss1 then
            inst.switchtoboss1 = data.switchtoboss1
        else
            inst.switchtoboss1 = false
        end
        if data.switchtoboss2 then
            inst.switchtoboss2 = data.switchtoboss2
        else
            inst.switchtoboss2 = false
        end
        if data.alreadydust then
            inst.alreadydust = data.alreadydust
        else
            inst.alreadydust = true
        end
        inst.gameLoadingSoonTag = true
        _G.td1madao_runLatter(inst, 10, function()
            inst.gameLoadingSoonTag = false
        end)
        -- info
        local magicName = td1madao_getstr('xxxmagic_%s', inst.prefab)
        -- magic
        if data[magicName] then
            inst.components[magicName].current = data[magicName]
        else
            inst.components[magicName].current = 0
        end
        -- magic
        inst.components.td1madao_attributer:refresh()
        inst.components.td1madao_skill_pointer:getlolpointcanuse()
        if inst.refreshSkin then
            inst.refreshSkin()
        end
    end
end
_G.td1madao_characterSave = function(inst, data)
    -- base
    if inst.usingSkin then
        data.usingSkin = inst.usingSkin
    else
        data.usingSkin = inst.prefab
    end
    if inst.td1madaoSkin and #inst.td1madaoSkin > 0 then
        data.td1madaoSkin = inst.td1madaoSkin
    else
        data.td1madaoSkin = { inst.prefab }
    end
    if inst.levelvaluenum then
        data.levelvaluenum = inst.levelvaluenum
    else
        data.levelvaluenum = 1
    end
    if inst.killmember then
        data.killmember = inst.killmember
    else
        data.killmember = 0
    end
    if inst.deathtime then
        data.deathtime = inst.deathtime
    else
        data.deathtime = 0
    end
    if inst.expvaluenum then
        data.expvaluenum = inst.expvaluenum
    else
        data.expvaluenum = 0
    end

    if inst.money then
        data.money = inst.money
    else
        data.money = 0
    end
    -- base
    local magicName = td1madao_getstr('xxxmagic_%s', inst.prefab)
    -- magic
    if inst.components[magicName] and inst.components[magicName].current then
        data[magicName] = inst.components[magicName].current
    else
        data[magicName] = 0
    end
    -- magic
    -- point
    if inst.lolattackpoint then
        data.lolattackpoint = inst.lolattackpoint
    else
        data.lolattackpoint = 0
    end
    if inst.lolwisepoint then
        data.lolwisepoint = inst.lolwisepoint
    else
        data.lolwisepoint = 0
    end
    if inst.lolphysiquepoint then
        data.lolphysiquepoint = inst.lolphysiquepoint
    else
        data.lolphysiquepoint = 0
    end
    if inst.lolagilepoint then
        data.lolagilepoint = inst.lolagilepoint
    else
        data.lolagilepoint = 0
    end
    if inst.lolextpoint then
        data.lolextpoint = inst.lolextpoint
    else
        data.lolextpoint = 0
    end
    -- point
    -- info
    if inst.alreadydust then
        data.alreadydust = inst.alreadydust
    else
        data.alreadydust = true
    end
    if inst.started then
        data.started = inst.started
    end
    if inst.switchtoboss1 then
        data.switchtoboss1 = inst.switchtoboss1
    else
        data.switchtoboss1 = false
    end
    if inst.switchtoboss2 then
        data.switchtoboss2 = inst.switchtoboss2
    else
        data.switchtoboss2 = false
    end
    -- info
end
_G.td1madao_fireWeapon = function(inst, data)
    if inst and data and data.cause == inst.prefab and _G.td1madao_expCreature(data.inst) then
        local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if weapon and weapon.soulballyellow == 4 then
            local delta = (data.inst.components.combat.defaultdamage) * 0.1
            inst.components.health:DoDelta(delta, false, "battleborn")
            inst.components.sanity:DoDelta(delta)
            if math.random() < .1 and not data.inst.components.health.nofadeout then
                local time = data.inst.components.health.destroytime or 2
                inst:DoTaskInTime(time, function()
                    local s = 0.7
                    if data.inst:HasTag("smallcreature") then
                        s = 0.5
                    elseif data.inst:HasTag("largecreature") then
                        s = 1.1
                    end
                    _G.td1madao_deployBelow(data.inst, "wathgrithr_spirit").Transform:SetScale(s, s, s)
                end)
            end
        end
    end
end
_G.td1madao_memberRandomWeapon = function(inst)
    local farWeapon = {
        "swap_blowdart",
        "swap_staffs"
    }
    local normalWeapon = {
        "swap_spear",
        "swap_axe",
        "swap_batbat",
        "swap_cane",
        "swap_diviningrod",
        "swap_fishingrod",
        "swap_bugnet",
        "swap_ham_bat",
        "swap_shovel",
        "swap_torch",
        "swap_umbrella",
        "swap_spike",
        "swap_pitchfork",
        "swap_nightmaresword",
        "swap_pickaxe",
        "swap_hammer"
    }
    if math.random() < 0.2 then
        inst.myweapon = farWeapon[math.random(#farWeapon)]
    else
        inst.myweapon = normalWeapon[math.random(#normalWeapon)]
    end
end
_G.td1madao_memberRandomArmor = function(inst)
    local armor = {
        "armor_sanity",
        "armor_sweatervest",
        "armor_slurtleshell",
        "armor_wood",
        "armor_marble",
        "armor_slurper",
        "armor_trunkvest_summer",
        "armor_trunkvest_winter",
        "armor_grass"
    }
    inst.myarmor = armor[math.random(#armor)]
end
_G.td1madao_memberRandomHat = function(inst)
    local hat = {
        "hat_flower",
        "hat_earmuffs",
        "hat_straw",
        "hat_top",
        "hat_football",
        "hat_bee",
        "hat_beefalo",
        "hat_bush",
        "hat_miner",
        "hat_feather",
        td1madao_getstr('%shat_poop'),
        "hat_slurtle"
    }
    inst.myhat = hat[math.random(#hat)]
    if inst.myhat ~= 'hat_flower' and inst.myhat ~= 'hat_earmuffs' then
        inst.AnimState:Show("HAT")
        inst.AnimState:Show("HAT_HAIR")
        inst.AnimState:Hide("HAIR_NOHAT")
        inst.AnimState:Hide("HAIR")
    end
end

_G.td1madao_sellitem = {
    turf_rocky = 25,
    turf_savanna = 25,
    turf_grass = 25,
    turf_forest = 25,
    turf_marsh = 25,
    turf_cave = 25,
    turf_fungus = 25,
    turf_fungus_red = 25,
    turf_fungus_green = 25,
    turf_sinkhole = 25,
    turf_underrock = 25,
    turf_mud = 25,
    turf_desertdirt = 25,
    turf_deciduous = 25,
    turf_beach = 25,
    turf_jungle = 25,
    turf_magmafield = 25,
    turf_tidalmarsh = 25,
    turf_meadow = 25,
    turf_volcano = 25,
    turf_ash = 25,
    turf_woodfloor = 25,
    turf_road = 25,
    turf_checkerfloor = 25,
    turf_carpetfloor = 25,
    turf_snakeskinfloor = 65,
    turf_saria1 = 55,
    turf_sarib1 = 55,
    turf_saric1 = 55,
    turf_sarid1 = 55,
    turf_sarie1 = 55,
    turf_sarif1 = 55,
    turf_sarig1 = 55,
    turf_sarih1 = 55,
    turf_sarii1 = 55,
    turf_yiyua = 125,
    turf_yiyuc = 125,
    turf_yiyub = 125,
    turf_yiyu1d = 125,
    turf_yiyu2d = 125,
    turf_yiyu3d = 125,
    turf_yiyu4d = 125,
    turf_yiyu5d = 125,
    turf_yiyu6d = 125,
    turf_yiyu7d = 125,
    turf_yiyu8d = 125,
    turf_yiyu9d = 125,
    turf_yiyuhero1 = 125,
    turf_yiyuhero2 = 125,
    turf_yiyuhero3 = 125,
    turf_yiyuhero4 = 125,
    gunpowder = 456,
    amulet = 747,
    marble = 347,
    gears = 447,
    tentaclespots = 167,
    blueamulet = 834,
    purpleamulet = 1234,
    orangeamulet = 2663,
    greenamulet = 7747,
    yellowamulet = 2521,
    purplegem = 4334,
    bluegem = 3734,
    redgem = 3747,
    orangegem = 5763,
    yellowgem = 5821,
    greengem = 7747,
    icestaff = 1834,
    firestaff = 747,
    telestaff = 1234,
    orangestaff = 2663,
    greenstaff = 7747,
    yellowstaff = 2521,
    beargervest = 4834,
    bearger_fur = 4834,
    eyebrellahat = 1834,
    deerclops_eyeball = 3834,
    tigereye = 3834,
    minotaurhorn = 6834,
    dragon_scales = 4834,
    goose_feather = 347,
    shark_gills = 1347,
    cane = 3847,
    walrus_tusk = 3747,
    walrushat = 3834,
    cookedmandrake = 7747,
    panflute = 7747,
    mandrake = 7747,
    mandrakesoup = 7747,
    krampus_sack = 10000,
    fireflies = 835,
    bioluminescence = 634,
    messagebottle = 1835,
    tallbirdegg = 634,
    tallbirdegg_cracked = 634,
    tallbirdegg_cooked = 134,
    lureplantbulb = 334,
    spidereggsack = 634,
    spiderhat = 367,
    horn = 747,
    beefalohat = 947,
    blubber = 747,
    ox_horn = 547,
    lightninggoathorn = 447,
    pigskin = 2,
    coontail = 323,
    venomgland = 323,
    manrabbit_tail = 46,
    snakeskin = 53,
    cutreeds = 60,
    dug_sapling = 220,
    dug_berrybush = 340,
    dug_berrybush2 = 360,
    dug_grass = 230,
    dug_marsh_bush = 170,
    dug_bambootree = 240,
    dug_bush_vine = 220,
    dug_elephantcactus = 200,
    dug_coffeebush = 300,
    ironwind = 2834,
    turbine_blades = 2834,
    dragoonheart = 452,
    magic_seal = 1834,
    obsidian = 62,
    goldnugget = 23,
    coral = 15,
    rocks = 19,
    flint = 19,
    nitre = 34,
    log = 3,
    pinecone = 3,
    acorn = 53,
    coconut = 43,
    jungletreeseed = 3,
    cutgrass = 17,
    bamboo = 34,
    sand = 13,
    boneshard = 31,
    palmleaf = 13,
    vine = 21,
    twigs = 17,
    dubloon = 107,
    meat = 2,
    nightmarefuel = 45,
    seashell = 32,
    seaweed = 32,
    smallmeat = 22,
    froglegs = 22,
    honey = 13,
    honeycomb = 749,
    stinger = 10,
    butter = 430,
    drumstick = 45,
    batwing = 58,
    plantmeat = 35,
    fish = 25,
    tropical_fish = 25,
    eel = 75,
    cutlichen = 30,
    berries = 15,
    carrot = 15,
    green_cap = 22,
    blue_cap = 18,
    bird_egg = 12,
    houndstooth = 52,
    thulecite = 350,
    livinglog = 139,
    charcoal = 25,
    cactus_meat = 36,
    goatmilk = 134,
    silk = 26,
    seeds = 9,
    poop = 23,
    guano = 43,
    wormlight = 234,
    thulecite_pieces = 200,
    armorwood = 180,
    footballhat = 170,
    glommerfuel = 200,
}
local function calculatprice2(item)
    local value = 1
    local inst = item
    if _G.Prefabs[item.prefab] then
        if _G.td1madao_sellitem[item.prefab] then
            return _G.td1madao_sellitem[item.prefab]
        end
        if not inst.components.inventoryitem then
            return 1
        end
        if inst.components.edible and inst.components.edible.foodtype ~= "WOOD" and inst.components.edible.foodtype ~= "ELEMENTAL" then
            local a = inst.components.edible.healthvalue
            local b = inst.components.edible.hungervalue
            local c = inst.components.edible.sanityvalue
            if a < 0 then a = 0 end
            if b < 0 then b = 0 end
            if c < 0 then c = 0 end
            local ediblevalue = a * 0.7 + b * 0.3 + c * 0.6
            value = value + ediblevalue * 3
        end
        if inst.components.fertilizer then
            value = value + inst.components.fertilizer.fertilizervalue / TUNING.SPOILEDFOOD_FERTILIZE * inst.components.fertilizer.soil_cycles / TUNING.SPOILEDFOOD_SOILCYCLES * 0.9
        end
        if inst.components.fuel then
            value = value + inst.components.fuel.fuelvalue / TUNING.TINY_FUEL * 1.3
        end
        if inst.components.equippable then
            value = value + 3
        end
        if inst.components.weapon then
            value = value + math.pow((inst.components.weapon.damage / TUNING.SPIKE_DAMAGE), 5) * 300
        end
        if inst.components.explosive then
            value = value + inst.components.explosive.explosivedamage / TUNING.GUNPOWDER_DAMAGE * 5
        end
        if inst.components.dapperness then
            value = value + inst.components.dapperness.dapperness / TUNING.DAPPERNESS_TINY * 17
        end
        if inst.components.armor then
            value = value + inst.components.armor.condition / inst.components.armor.maxcondition * 1000 * math.pow(((inst.components.armor.absorb_percent or 0.5) / TUNING.ARMORWOOD_ABSORPTION), 15)
        end
        if inst.components.healer then
            value = value + inst.components.healer.health * 3 * 0.7
        end
        if inst.components.insulator then
            value = value + inst.components.insulator.insulation / TUNING.INSULATION_TINY * 8
        end
        if inst.components.waterproofer then
            value = value + inst.components.waterproofer.effectiveness / TUNING.WATERPROOFNESS_SMALL * 21
        end
        if inst.components.container then
            value = value + inst.components.container.numslots * 14
        end
        if inst.components.tool then
            value = value + 6
        end
        if inst.components.projectile then

            return 3
        end
        if inst.components.finiteuses then
            value = value * (inst.components.finiteuses.current / inst.components.finiteuses.total)
        end
        if inst.components.perishable then
            value = value * (inst.components.perishable.perishremainingtime / inst.components.perishable.perishtime)
        end
    end
    if value < 1 then
        value = 1
    end
    return math.ceil(value)
end

local function calculatprice(itemname)
    local inst = td1madao_safespawn(itemname)
    local price = calculatprice2(inst)
    if inst then
        inst:Remove()
    end
    return price
end

local function getlength()
    local n = 0
    for i, v in pairs(_G.td1madao_sellitem) do
        n = n + 1
    end
    return n
end

local function get(num)
    local n = 0
    for i, v in pairs(_G.td1madao_sellitem) do
        n = n + 1
        if n == num then
            local stru = {}
            stru.name = i
            stru.value = math.ceil(v * (1.2 + math.random() * 5))
            if stru.value >= 1000 then
                stru.account = 1
            elseif stru.value > 100 then
                stru.account = math.random(3)
            else
                stru.account = math.ceil(15 * math.random())
                stru.value = math.ceil(v * (1.2 + math.random() * 3))
            end
            if stru.value < 20 then
                stru.value = math.ceil(20 * (1 + math.random()))
            end
            return stru
        end
    end
    return nil
end

local function get35()
    local group = {}
    repeat
        local num = math.random(getlength())
        local item = get(num)
        if not table.contains(group, num) and _G.Prefabs[item.name] then
            table.insert(group, num)
        end
    until #group >= 35
    local result = {}
    for i = 1, #group do
        result[i] = get(group[i])
    end
    return result
end

local function getPrize(itemname)
    if _G.td1madao_sellitem[itemname] then
        return _G.td1madao_sellitem[itemname]
    end
    return calculatprice(itemname)
end

local function getPrize2(item)
    if _G.td1madao_sellitem[item.prefab] then
        return _G.td1madao_sellitem[item.prefab]
    end
    return calculatprice2(item)
end

_G.td1madao_getPrize = getPrize
_G.td1madao_getPrize2 = getPrize2
_G.td1madao_get35 = get35

_G.td1madao_sellitemInit = function()
    for veggiename, veggiedata in pairs(_G.VEGGIES) do
        local name = veggiename .. "_seeds"
        if _G.Prefabs[name] and not _G.td1madao_sellitem[name] then
            _G.td1madao_sellitem[name] = math.ceil(30 * (math.random() * 3 + 1))
        end
        if _G.Prefabs[veggiename] and not _G.td1madao_sellitem[veggiename] then
            _G.td1madao_sellitem[veggiename] = math.ceil(55 * (math.random() * 3 + 1))
        end
    end
    for i = 1, _G.NUM_TRINKETS do
        local name = "trinket_" .. tostring(i)
        if _G.Prefabs[name] and not _G.td1madao_sellitem[name] then
            _G.td1madao_sellitem[name] = math.ceil(300 * (math.random() * 0.5 + 0.75))
        end
    end
    for i = 1, 25 do
        local name = td1madao_getstr("%sweapon") .. tostring(i)
        if _G.Prefabs[name] and not _G.td1madao_sellitem[name] then
            _G.td1madao_sellitem[name] = math.ceil(400 * (math.random() * 0.5 + 0.75))
        end
    end
    local foods = require("preparedfoods")
    for k, v in pairs(foods) do
        local name = k
        if _G.Prefabs[name] and not _G.td1madao_sellitem[name] then
            _G.td1madao_sellitem[name] = math.ceil(getPrize(name) * (1 + math.random() * 5))
        end
    end
    _G.td1madao_sellitem[td1madao_getstr("%ssoulball")] = 1047
    _G.td1madao_sellitem[td1madao_getstr("%ssoulballadvance")] = 7526
    _G.td1madao_sellitem[td1madao_getstr("%ssoulballwhite")] = 447
    _G.td1madao_sellitem[td1madao_getstr("%ssoulballblue")] = 847
    _G.td1madao_sellitem[td1madao_getstr("%ssoulballyellow")] = 7747
    _G.td1madao_sellitem[td1madao_getstr("%shearthstone")] = 1320
end
