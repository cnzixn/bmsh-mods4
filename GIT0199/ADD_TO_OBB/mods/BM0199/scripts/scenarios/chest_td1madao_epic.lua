chestfunctions = require("scenarios/chestfunctions")


local function OnCreate(inst, scenariorunner)
    local items =
    {
        {
            item = td1madao_getstr("%sruneitem"),
            chance = 0.8,
            initfn = function(rune)
                local arr = {
                    "butterfly",
                    "rabbit",
                    "perd",
                    "firehound",
                    "bee",
                    "frog",
                    "robin",
                    "robin_winter",
                    "crow",
                    "mandrake",
                }
                rune.killCreature = arr[math.random(#arr)]
                rune.attr = math.random(4)
                local tmpSpider = td1madao_safespawn("spider")
                rune.exp = 1
                td1madao_safeRemove(tmpSpider)
                if rune.changeName then
                    rune.changeName(rune)
                end
                td1madao_showQuality2(rune)
            end
        },
        {
            item = td1madao_getstr("%ssoulballwhite"),
            count = math.random(1, 2),
            chance = 0.5,
        },
        {
            item = "poop",
            count = math.random(1, 20),
            chance = 0.5,
        },
    }
    chestfunctions.AddChestItems(inst, items)
end

return
{
    OnCreate = OnCreate
}
