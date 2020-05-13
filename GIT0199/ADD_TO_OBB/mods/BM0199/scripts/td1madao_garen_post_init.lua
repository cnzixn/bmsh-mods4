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

local function create_lxw(inst, target)
    local a = _G.td1madao_deployBelow(target, "garen_sy_lxw")
    local x, y, z = a:GetPosition():Get()
    if a.Transform then
        a.Transform:SetScale(6, 6, 6)
        a.Transform:SetPosition(x, -7, z)
    end
    inst.components.talker:Say(TUNING.LOLMEMBER.TALK91)
    local ents = TheSim:FindEntities(x, y, z, 5)
    for k, v in pairs(ents) do
        if _G.td1madao_alive(v) and v ~= GetPlayer() and v.prefab ~= "garen_sy" and v.prefab ~= "garen_sy2" and v ~= target then
            if v:HasTag("pig") and v.components.combat.target ~= inst then
            else
                v.components.combat:GetAttacked(inst, inst.components.combat.defaultdamage)
            end
            if _G.td1madao_alive(v) then
                _G.td1madao_goto(v, "hit")
            end
        elseif not _G.td1madao_alive(v) and v and v.components.workable and v.components.workable.workleft > 0 then
            _G.td1madao_safespawn("collapse_small").Transform:SetPosition(v:GetPosition():Get())
            v.components.workable:Destroy(inst)
        end
    end
    _G.td1madao_safeRemoveAfter(a, 0.5)
end


AddStategraphPostInit("pig", function(sg)
    if sg and sg.states and sg.states.attack then
        local state = sg.states.attack
        local old_onenter = state.onenter
        state.onenter = function(inst)
            if inst.prefab == "garen_sy" or inst.prefab == "garen_sy2" and GetPlayer() and GetPlayer().prefab == "garen" then
                local tar = inst.components.combat.target
                _G.td1madao_runLatter(inst, 0.3, function()
                    if math.random() > 0.5 and tar and tar ~= GetPlayer() then
                        create_lxw(inst, tar)
                    end
                end)
            end
            old_onenter(inst)
        end
    end
end)


local SG = {
    "beefalo",
    "spiderqueen",
    "warg",
    "koalefant",
}

local function spawnNewEnemy(inst)
    if not inst then
        return
    end
    local fx2 = inst.td1madao_createRiderObj
    if fx2 then
        local a = _G.td1madao_safespawn(TUNING.GARENENEMYNAME)
        a.Transform:SetPosition(inst:GetPosition():Get())
        a.sg:GoToState("wakeup")
        a.charanm = fx2.charanm
        a.belongtowhich = fx2.belongtowhich
        a.myhat = fx2.myhat
        a.myarmor = fx2.myarmor
        a.myweapon = fx2.myweapon
        if _G.Prefabs[a.charanm] then
            a.AnimState:SetBuild(a.charanm)
        else
            a.charanm = "wilson"
            a.AnimState:SetBuild("wilson")
        end
        a.labelname:SetText(STRINGS.NAMES[string.upper(a.charanm)] or a.charanm)
        a.components.inspectable:SetDescription(string.format("%s%s", TUNING.LOLMEMBER[a.belongtowhich], STRINGS.NAMES[string.upper(a.charanm)] or a.charanm))
        a.name = string.format("%s%s", TUNING.LOLMEMBER[a.belongtowhich], STRINGS.NAMES[string.upper(a.charanm)] or a.charanm)

        if not (a.myhat == "hat_flower" or a.myhat == "hat_earmuffs") then
            a.AnimState:Show("HAT")
            a.AnimState:Show("HAT_HAIR")
            a.AnimState:Hide("HAIR_NOHAT")
            a.AnimState:Hide("HAIR")
        else
            a.AnimState:Show("HAIR_NOHAT")
            a.AnimState:Show("HAIR")
        end

        a.AnimState:OverrideSymbol("swap_hat", a.myhat, "swap_hat")
        a.AnimState:OverrideSymbol("swap_body", a.myarmor, "swap_body")
        if a.myweapon == "swap_staffs" then
            a.AnimState:OverrideSymbol("swap_object", a.myweapon, "redstaff")
        else
            a.AnimState:OverrideSymbol("swap_object", a.myweapon, a.myweapon)
        end
        if a.myweapon == "swap_blowdart" or a.myweapon == "swap_staffs" then
            a.dart = 0.75
            a.components.locomotor.walkspeed = a.walkspeed * a.dart
            a.components.locomotor.runspeed = a.runspeed * a.dart
            a.components.combat:SetAttackPeriod(a.oldperiod * 2)
            a.components.combat:SetRange(8, 10)
        else
            a.dart = 1
            a.components.locomotor.walkspeed = a.walkspeed * a.dart
            a.components.locomotor.runspeed = a.runspeed * a.dart
            a.components.combat:SetAttackPeriod(a.oldperiod)
            a.components.combat:SetRange(1.5)
        end
    end
    _G.td1madao_safeRemove(inst.td1madao_createRiderObj)
    inst.td1madao_createRiderObj = nil
end

local function sgFunction(sg)
    if sg and sg.states and sg.states.death then
        local state = sg.states.death
        local old_onenter = state.onenter
        state.onenter = function(inst)
            if inst:HasTag("td1madao_special") and GetPlayer() and GetPlayer().prefab == "garen" then
                spawnNewEnemy(inst)
            end
            old_onenter(inst)
        end
    end
end

for i = 1, #SG do
    if SG[i] then
        AddStategraphPostInit(SG[i], sgFunction)
    end
end

