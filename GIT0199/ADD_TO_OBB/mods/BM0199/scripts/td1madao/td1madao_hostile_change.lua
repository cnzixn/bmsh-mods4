--[[
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- @Description: change the hostile creature
 -- If any question ,Please email me using Chinese to let me distinguish whether it is spam
 -- @version 1.0.0
 -- @author td1madao
 -- @email td1madao@163.com
 -- @qq 360810498
 -- @date 16/8/6
 ]]
AddPrefabPostInitAny(function(inst)
    if GetPlayer().prefab == _G.TD1MADAO_CHAR then
        if TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER', prefab)] == 0 then
            return
        end
        if _G.td1madao_creatureCanMutate(inst) then
            -- monster become larger
            local avg = inst.components.health.maxhealth * inst.components.combat.defaultdamage * inst.components.combat.playerdamagepercent / 100000
            if td1madao_g(td1madao_getupper('%s_ENOMOUS_MONSTER')) == 2 then
                avg = avg * 2
            end
            --monster drop weapon
            local table_week = td1madao_g(td1madao_getstr('%sweapons'))
            local len = table.getn(table_week)
            for i = 1, #table_week do
                if table_week[i] then
                    inst.components.lootdropper:AddChanceLoot(table_week[i], avg / len)
                end
            end
            -- monster strength
            if inst.components.health.maxhealth <= 10000 then
                local aliveday = GetClock().numcycles
                if aliveday <= 20 then
                    aliveday = 0
                else
                    aliveday = aliveday + GetPlayer().components.td1madao_leveler:getCurrentLevel() * 1
                end
                if aliveday > 500 then
                    aliveday = 500
                end
                if aliveday < 0 then
                    aliveday = 0
                end
                local bcc = 170
                if aliveday < 50 then
                    bcc = 200
                elseif aliveday < 100 then
                    bcc = 170
                elseif aliveday < 150 then
                    bcc = 150
                else
                    bcc = 130
                end
                inst.components.health:SetMaxHealth(inst.components.health.maxhealth * (1 + (aliveday / bcc) * (0.5 + 0.5 * math.random())))
                inst.components.health.currenthealth = inst.components.health.maxhealth
                inst.components.combat:SetDefaultDamage(inst.components.combat.defaultdamage * (1 + aliveday / 1000))
                local times = 1
                if aliveday > 100 and math.random() < 0.5 then
                    if math.random() < 0.5 then
                        times = 2
                    else
                        times = 3
                    end
                end
                local abs = inst.components.health.absorb or 0
                if math.random() < 0.03 then
                    abs = 0.7
                elseif math.random() < 0.1 then
                    abs = 0.005 * times * aliveday + abs
                elseif math.random() < 0.3 then
                    abs = 0.003 * times * aliveday + abs
                    if abs > 0.4 then
                        abs = 0.4
                    end
                elseif math.random() > 0.9 then
                    abs = 0
                else
                    abs = 0.00167 * times * aliveday + abs
                    if abs > 0.6 then
                        abs = 0.6
                    end
                end
                if abs > 0.9 then
                    abs = 0.9
                end
                inst.components.health.absorb = (0.5 + 0.5 * math.random()) * abs
            end
            if inst.components.health.maxhealth <= 1900 then
                if not inst.components[td1madao_getstr('%s_enomous_monster')] then
                    inst:AddComponent(td1madao_getstr('%s_enomous_monster'))
                end
                inst.components[td1madao_getstr('%s_enomous_monster')]:Init()
            end
            -- weaken armors
        elseif inst and inst.components.armor and inst.components.armor.absorb_percent and _G.TUNING.ARMORWOOD_ABSORPTION == 0.8 and not inst.components.armor.alreadyweaken then
            _G.td1madao_weakenArmor(inst)
        end
    end
end)