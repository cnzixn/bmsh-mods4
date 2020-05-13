--[[
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- @Description: use for init my player
 -- If any question ,Please email me using Chinese to let me distinguish whether it is spam
 -- @version 1.0.0
 -- @author td1madao
 -- @email td1madao@163.com
 -- @qq 360810498
 -- @date 16/8/6
 ]]

local function randomSpeech(inst)
    inst:DoTaskInTime(5, function()
        td1madao_randomTalk(inst, TUNING.TD1MADAOGAMESKILL)
    end)
end

-- inst.components.td1madao_leveler:getCurrentExp()
local Td1madao_lol_player_ability = Class(function(self, inst)
    self.inst = inst
    local enomous = td1madao_getupper('%s_ENOMOUS_MONSTER')
    self.inst.OnSave = td1madao_characterSave
    self.inst.OnPreLoad = td1madao_characterLoad
    self.inst:ListenForEvent("attacked", td1madao_playerAttackedByCreature)
    self.inst:ListenForEvent("daytime", function(data)
        randomSpeech(self.inst)
        if not self.inst.blueBuffSaveDay then
            self.inst.blueBuffSaveDay = 0
        end
        self.inst.blueBuffSaveDay = self.inst.blueBuffSaveDay - 1
        if self.inst.blueBuffSaveDay and self.inst.blueBuffSaveDay > 0 then
            td1madao_riderShow(self.inst)
        else
            td1madao_riderHide(self.inst)
        end

        local player = GetPlayer()
        player:DoTaskInTime(1, function()
            -- create marks spot
            local pt = player:GetPosition()
            local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 9000, { "td1madao_marks_spot" })
            local num = #ents
            local createNum = 10 - num
            if createNum < 0 then
                createNum = 0
            end
            if createNum > 0 then
                for i = 1, createNum do
                    local a = td1madao_safespawn(td1madao_getstr('x_marks_spot_%s'))
                    local rmp = td1madao_getrandomposition()
                    a.Transform:SetPosition(rmp.x, 0, rmp.z)
                end
            end
        end)

        if self.inst.blueBuffSaveDay < 0 then
            self.inst.blueBuffSaveDay = 0
        end
        self.inst.alreadydust = false
        self.inst.businessman = false
        self.inst.assador = false
        self.inst.businessmanchest = false
        self.inst.businessmanslot = false
        local aliveday = GetClock().numcycles
        if math.floor(aliveday / 15) > self.inst.lolextpoint then
            self.inst.lolextpoint = self.inst.lolextpoint + 1
            self.inst.components.td1madao_skill_pointer:getlolpointcanuse()
        end
        if math.random() < inst.components.td1madao_leveler:getCurrentLevel() * 0.003 * self.inst.probtimes then
            self.inst.laowang = true
        end
        if self.inst.components.td1madao_lol_player_init.warDay and self.inst.components.td1madao_lol_player_init.warDay > 0 then
            self.inst.components.td1madao_lol_player_init.warDay = self.inst.components.td1madao_lol_player_init.warDay - 1
        end
        if self.inst.components.td1madao_lol_player_init.warDay and self.inst.components.td1madao_lol_player_init.peaceDay > 0 then
            self.inst.components.td1madao_lol_player_init.peaceDay = self.inst.components.td1madao_lol_player_init.peaceDay - 1
        end
    end, GetWorld())
    local function randomSymbol()
        local n = math.random(2) - 1
        if n == 0 then
            n = -1
        end
        return n
    end

    local function spawnBusinessMan(other)
        self.inst:DoTaskInTime(5, function()
            if not GetPlayer().alreadydust then
                for i = 1, 100 do
                    local x, y, z = self.inst.Transform:GetWorldPosition()
                    x, y, z = x - (2 * randomSymbol() + math.random(4) * randomSymbol()), y, z - (2 * randomSymbol() + math.random(4) * randomSymbol())
                    if td1madao_isvalidposition(x, y, z) then
                        local creature = td1madao_safespawn(td1madao_getstr(other or "%smemberbusinessman"))
                        creature.Transform:SetPosition(x, y, z)
                        td1madao_safespawn("explode_small").Transform:SetPosition(creature:GetPosition():Get())
                        GetPlayer().businessman = true
                        break
                    end
                end
            end
        end)
    end

    self.inst:ListenForEvent("dusktime", function(global, data)
        randomSpeech(self.inst)
        if GetPlayer().alreadydust then
            return
        end
        if math.random() < 0.2 and (GetPlayer().components.td1madao_lol_player_init.peaceDay or 0) <= 0 and GetPlayer().components.td1madao_lol_player_init.warDay <= 0 then
            spawnBusinessMan("%smemberambassador")
        end
        local alivedayby = GetClock().numcycles
        if alivedayby % 7 == 0 and not GetPlayer().businessman then
            spawnBusinessMan()
        elseif alivedayby < 10 and math.random() < 0.6 and not GetPlayer().businessman then
            spawnBusinessMan()
        elseif math.random() < 0.25 and not GetPlayer().businessman then
            spawnBusinessMan()
        else
        end
        self.inst:DoTaskInTime(6, function()
            GetPlayer().alreadydust = true
        end)
    end, GetWorld())

    self.inst:ListenForEvent("nighttime", function()
        randomSpeech(self.inst)
    end, GetWorld())

    self.inst.components.inventory.CanAcceptCount = td1madao_acceptItemFromMember
end)


return Td1madao_lol_player_ability