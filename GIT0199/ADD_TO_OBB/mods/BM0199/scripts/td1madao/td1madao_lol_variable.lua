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

-- 兼容路牌
td1madao_d('DONNOTHAVESIGNDATA', false)
-- 我做的所有lol人物mod
td1madao_d('LOLALLP', {})
-- 其中属于德玛西亚的(这些人物不会跑到诺克萨斯阵营)
td1madao_d('DEMACIACHAR', {})
-- 其中属于诺克萨斯的(这些人物不会跑到德玛西亚阵营)
td1madao_d('NOXUSCHAR', {})
td1madao_d('LOLCHARGROUP', {})
-- 人物对话
td1madao_d('LOLMEMBER', {})
-- 初始化人物判断
td1madao_d('LOLINIT', true)
td1madao_d('LOLLOAD', false)
td1madao_d('LOLCHAR', false)

table.insert(_G.TUNING.LOLCHARGROUP, _G.TD1MADAO_CHAR)

-- 商品
td1madao_s(td1madao_getupper('%sGOODS'), {})
-- mod config
td1madao_s(td1madao_getupper('%sREBORN'), GetModConfigData("reborn") or 0) -- reborn
td1madao_s(td1madao_getupper('%s_ENOMOUS_MONSTER'), GetModConfigData("difficulty") or 1) -- difficulty
td1madao_s(td1madao_getupper('%s_KEY'), {}) -- hotkey
local key = td1madao_g(td1madao_getupper('%s_KEY'))
key.KEY1 = GetModConfigData("key1") or 116
key.KEY2 = GetModConfigData("key2") or 121
key.KEY3 = GetModConfigData("key3") or 117
key.KEY4 = GetModConfigData("key4") or 105
local duplicated = false
for _1, v1 in pairs(td1madao_g(td1madao_getupper('%s_KEY'))) do
    if duplicated then
        break
    end
    for _2, v2 in pairs(td1madao_g(td1madao_getupper('%s_KEY'))) do
        if _1 ~= _2 and v1 == v2 then
            key.KEY1 = 116
            key.KEY2 = 121
            key.KEY3 = 117
            key.KEY4 = 105
            duplicated = true
            break
        end
    end
end
key.SmartCast = GetModConfigData("SmartCast") or 0 -- smart cast

-- 所有的角色，包括mod人物
td1madao_s(td1madao_getupper('%sALLP'), GetActiveCharacterList())

-- 使用 ModWrangler，即使有mod角色在我后面加载，其资源文件也会被我识别
if not _G.TUNING.LOLCREATURE then
    _G.TUNING.LOLCREATURE = {}
    local ModWrangler = assert(_G.ModWrangler)
    local oldfun = ModWrangler.InitializeModMain
    ModWrangler.InitializeModMain = function(self, modname, env, mainfile)
        local oldaddmod = env.AddModCharacter
        env.AddModCharacter = function(name)
            local file = string.format("anim/%s.zip", name)
            if td1madao_file_exist(file) then
                local result = Asset("ANIM", file)
                table.insert(Assets, result)
                if not table.contains(_G.TUNING.LOLALLP, name) then
                    table.insert(_G.TUNING.LOLALLP, name)
                end
            end
            oldaddmod(name)
        end
        oldfun(self, modname, env, mainfile)
    end
end

table.insert(td1madao_g(td1madao_getupper('%sALLP')), _G.TD1MADAO_CHAR)
for i = 1, table.size(td1madao_g(td1madao_getupper('%sALLP'))) do
    local file = string.format("anim/%s.zip", td1madao_g(td1madao_getupper('%sALLP'))[i])
    if td1madao_g(td1madao_getupper('%sALLP'))[i] and td1madao_file_exist(file) then
        if not table.contains(_G.TUNING.LOLALLP, td1madao_g(td1madao_getupper('%sALLP'))[i]) then
            table.insert(_G.TUNING.LOLALLP, td1madao_g(td1madao_getupper('%sALLP'))[i])
        end
        local result = Asset("ANIM", file)
        table.insert(Assets, result)
    end
end

-- 四格背包
table.insert(_G.EQUIPSLOTS, td1madao_getupper('BACK%s'))
_G.EQUIPSLOTS[td1madao_getupper('BACK%s')] = "back"

local function td1madao_setFn(states, stateName, functionName, Fn)
    for k, v in pairs(states) do
        if (v.name == stateName) then
            v[functionName] = Fn
            break
        end
    end
end

local function td1madao_editStateFn(SGname, stateName, functionName, Fn)
    for k, v in pairs(_G.SGManager.instances) do
        if (k.sg.name == SGname) then
            td1madao_setFn(k.sg.states, stateName, functionName, Fn)
            break
        end
    end
end

local function td1madao_newOnExit(inst)
    inst.components.hunger:SetPercent(2 / 3)
    inst.components.health:Respawn(TUNING.RESURRECT_HEALTH)
    if inst.components.sanity then
        inst.components.sanity:SetPercent(.5)
    end
    local item
    if item then
        item:Remove()
        item.persists = false
    end
    inst.HUD:Show()
    _G.TheCamera:SetDefault()
    inst.components.playercontroller:Enable(true)
    inst.AnimState:ClearOverrideSymbol("FX")
end

_G.td1madao_setFn = td1madao_setFn
_G.td1madao_editStateFn = td1madao_editStateFn
_G.td1madao_newOnExit = td1madao_newOnExit


local attempts = 3
local currentAttempt = 0
function td1madao_SpawnShrine()
    currentAttempt = currentAttempt + 1
    local existingShrine = _G.c_find(td1madao_getstr("%saccomplishment_shrine"))
    if (existingShrine ~= nil) then return false end
    if currentAttempt > attempts then return false end
    local minPos, maxPos
    minPos = 6
    maxPos = 12
    local pigking = _G.c_find("pigking") or _G.c_find("pig_king")
    if not pigking then
        minPos = 2
        maxPos = 4
        pigking = _G.c_find("pighouse")
        if pigking then
            for i = 0, math.random(1, 10) do
                pigking = _G.c_findnext("pighouse")
            end
        else
            pigking = _G.c_find("wildborehouse")
            if pigking then
                for i = 0, math.random(1, 10) do
                    pigking = _G.c_findnext("wildborehouse")
                end
            end
        end
    end
    if (pigking == nil) or (not pigking) then
        td1madao_SpawnShrine()
    end
    local newShrine = td1madao_safespawn(td1madao_getstr("%saccomplishment_shrine"))
    if (newShrine == nil) then
        td1madao_SpawnShrine()
    else
        if pigking then
            local x, y, z = pigking.Transform:GetWorldPosition()
            x = x + math.random(minPos, maxPos)
            z = z + math.random(minPos, maxPos)
            newShrine.Transform:SetPosition(x, y, z)
        end
    end
end

_G.td1madao_SpawnShrine = td1madao_SpawnShrine