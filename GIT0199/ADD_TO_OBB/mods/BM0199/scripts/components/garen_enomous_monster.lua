local Garen_enomous_monster = Class(function(self, inst)
    self.inst = inst
    self.old_monster_size = nil
    self.new_monster_size = nil
    self.old_monster_damage = nil
    self.new_monster_damage = nil
    self.old_monster_attack_range = nil
    self.new_monster_attack_range = nil
    self.old_monster_hit_range = nil
    self.new_monster_hit_range = nil
    self.old_monster_health = nil
    self.new_monster_health = nil
    self.old_monster_mass = nil
    self.new_monster_mass = nil
    self.old_monster_radius = nil
    self.new_monster_radius = nil
    self.loot_times = nil
    self.switch_key = true
    self.final_size = 1
    if inst and inst.components.health and inst.components.health.maxhealth then
        self.current_health = inst.components.health.maxhealth
    else
        self.current_health = 10
    end
    if inst and inst.components.health and inst.components.health.absorb then
        self.absorb = inst.components.health.absorb
    else
        self.absorb = 0
    end
    self.redcolor = math.random()
    self.greencolor = math.random()
    self.bluecolor = math.random()
end)

local function spawnchest(inst)
    inst:DoTaskInTime(3, function()
        inst.SoundEmitter:PlaySound("dontstarve/common/ghost_spawn")
        local chest = td1madao_safespawn("minotaurchest")
        local pos = inst:GetPosition()
        chest.Transform:SetPosition(pos.x, 0, pos.z)
        local fx = td1madao_safespawn("statue_transition_2")
        if fx then
            fx.Transform:SetPosition(inst:GetPosition():Get())
            fx.AnimState:SetScale(1, 2, 1)
        end
        fx = td1madao_safespawn("statue_transition")
        if fx then
            fx.Transform:SetPosition(inst:GetPosition():Get())
            fx.AnimState:SetScale(1, 1.5, 1)
        end
        chest:AddComponent("scenariorunner")
        chest.components.scenariorunner:SetScript("chest_td1madao_epic")
        chest.components.scenariorunner:Run()
    end)
end

function Garen_enomous_monster:Recover()
    if GetPlayer().prefab ~= 'garen' then
        return
    end
    if self.old_monster_size then
        self.inst.Transform:SetScale(self.old_monster_size, self.old_monster_size, self.old_monster_size)
    end
    if self.old_monster_damage then
        self.inst.components.combat.defaultdamage = self.old_monster_damage
    end
    if self.old_monster_attack_range then
        self.inst.components.combat.attackrange = self.old_monster_attack_range
    end
    if self.old_monster_hit_range then
        self.inst.components.combat.hitrange = self.old_monster_hit_range
    end
    if self.old_monster_health then
        self.inst.components.health.maxhealth = self.old_monster_health
    end
    if self.current_health then
        self.inst.components.health.currenthealth = self.current_health
    end
    if self.old_monster_mass then
        self.inst.Physics:SetMass(self.old_monster_mass)
    end
    if self.old_monster_radius then
        self.inst.Physics:SetCapsule(self.old_monster_radius, 1)
    end
    if self.inst.labelname then
        self.inst.labelname:Enable(false)
    end
    self.inst.AnimState:SetMultColour(1, 1, 1, 1)
end

function Garen_enomous_monster:Init()
    if GetPlayer().prefab ~= 'garen' then
        return
    end
    if self.switch_key then
        local multi_times = math.random()
        local rate = 0.0075
        if TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER')] == 2 then
            rate = 0.015
        end
        local base = rate
        local player = GetPlayer()
        if player and player.components.td1madao_leveler:getCurrentLevel() then
            base = player.components.td1madao_leveler:getCurrentLevel() * base
        end
        self.redcolor = math.random()
        self.greencolor = math.random()
        self.bluecolor = math.random()
        self.current_health = self.inst.components.health.currenthealth
        self.old_monster_size = self.inst.Transform:GetScale()
        self.old_monster_damage = self.inst.components.combat.defaultdamage
        self.old_monster_attack_range = self.inst.components.combat.attackrange
        self.old_monster_hit_range = self.inst.components.combat.hitrange
        self.old_monster_health = self.inst.components.health.maxhealth
        self.old_monster_mass = self.inst.Physics:GetMass()
        self.old_monster_radius = self.inst.Physics:GetRadius()
        self.type = 1
        local basic_times
        local damage_multi
        local range_multi
        local health_multi
        local mass_multi
        local radius_multi
        local loot_multi
        if multi_times > (1 - base) / 2 and multi_times < (1 - base) / 2 + 0.33 * base then
            basic_times = 1.25
            loot_multi = 1
        elseif multi_times > (1 - base) / 2 + 0.33 * base and multi_times < (1 - base) / 2 + 0.66 * base then
            basic_times = 1.5
            loot_multi = 2
            self.inst:AddTag("sbs")
            self.type = 2
        elseif multi_times > (1 - base) / 2 + 0.66 * base and multi_times < (1 - base) / 2 + 0.99 * base then
            basic_times = 1.75
            loot_multi = 2
            self.inst:AddTag("sbs")
            self.type = 2
        elseif math.random() < 0.005 then
            basic_times = 2
            loot_multi = 4 + math.random(4)
            if TUNING[td1madao_getupper('%s_ENOMOUS_MONSTER')] == 2 then
                basic_times = basic_times + math.random(3)
                loot_multi = loot_multi + math.random(2)
            end
            self.inst:AddTag("epic")
            self.type = 3
        else
            basic_times = 1
            loot_multi = 1
        end
        if math.random() < 0.75 and not self.inst:HasTag("epic") and not self.inst:HasTag("sbs") then
            self.redcolor = 1
            self.greencolor = 1
            self.bluecolor = 1
        end
        self.final_size = loot_multi
        health_multi = 1 + (basic_times - 1) * 3
        self.new_monster_health = self.old_monster_health * health_multi
        self.current_health = self.new_monster_health
        self.loot_times = loot_multi - 1
        self.switch_key = false
        if basic_times > 2 then
            basic_times = 2
        end
        damage_multi = 1 + (basic_times - 1) * 0.75
        self.new_monster_damage = self.old_monster_damage * damage_multi
        radius_multi = 1 + (basic_times - 1) * .75
        mass_multi = basic_times * basic_times * basic_times
        range_multi = 1 + (basic_times - 1) * .5
        self.new_monster_size = self.old_monster_size * basic_times
        self.new_monster_attack_range = self.old_monster_attack_range * range_multi
        self.new_monster_hit_range = self.old_monster_hit_range * range_multi
        self.new_monster_mass = self.old_monster_mass * mass_multi
        self.new_monster_radius = self.old_monster_radius * radius_multi
        self:ChangeMonsterAttributes()
        if self.inst and self.inst.components.health and self.inst.components.health.absorb then
            self.absorb = self.inst.components.health.absorb
        else
            self.absorb = 0
        end
    end
end

function Garen_enomous_monster:ChangeMonsterAttributes()
    if GetPlayer().prefab ~= 'garen' then
        return
    end
    if self.loot_times > 1 then
        self.inst:AddTag("epic")
    end
    self.inst.Transform:SetScale(self.new_monster_size, self.new_monster_size, self.new_monster_size)
    self.inst.components.combat.defaultdamage = self.new_monster_damage
    self.inst.components.combat.attackrange = self.new_monster_attack_range
    self.inst.components.combat.hitrange = self.new_monster_hit_range
    self.inst.components.health.maxhealth = self.new_monster_health
    self.inst.components.health.currenthealth = self.current_health
    if self and self.inst and self.inst:HasTag("epic") then
        local added = self.inst.components.health.maxhealth
        self.inst.components.health.maxhealth = self.new_monster_health + 2000 + (math.random(3) - 1) * 500
        added = self.inst.components.health.maxhealth - added
        self.inst.components.health.currenthealth = self.inst.components.health.currenthealth + added
        self.redcolor = math.random()
        self.greencolor = math.random()
        self.bluecolor = math.random()
        if self and self.inst then
            self.inst:DoTaskInTime(1, function()
                if self.inst.entity and self.inst.entity.AddLabel then
                    self.inst.labelname = self.inst.entity:AddLabel()
                    if self.inst.labelname then
                        self.inst.labelname:SetFontSize(35)
                        self.inst.labelname:SetPos(0, 3.3, 0)
                        self.inst.labelname:SetFont(NUMBERFONT)
                        self.inst.labelname:Enable(true)
                        self.inst.labelname:SetColour(1, 1, 0)
                        self.inst.labelname:SetText(string.format("%s%s", STRINGS.LOLENOMOUS, self.inst.name or STRINGS.NAMES[string.upper(self.inst.prefab)] or self.inst.prefab))
                    end
                end
            end)
        end
    end
    self.inst.Physics:SetMass(self.new_monster_mass)
    self.inst.AnimState:SetMultColour(self.redcolor, self.greencolor, self.bluecolor, 1)
    self.inst.Physics:SetCapsule(self.new_monster_radius, 1)
    self.inst:ListenForEvent("death", function()
        if self.loot_times >= 1 then
            for k = 1, self.loot_times do
                if self.inst.components.lootdropper then
                    self.inst.components.lootdropper:DropLoot(Vector3(self.inst.Transform:GetWorldPosition()))
                end
            end
        end
        if self.inst:HasTag("epic") then
            spawnchest(self.inst)
        end
    end)
end

function Garen_enomous_monster:OnSave()
    return
    {
        switch_key = self.switch_key,
        old_monster_size = self.old_monster_size,
        new_monster_size = self.new_monster_size,
        old_monster_damage = self.old_monster_damage,
        new_monster_damage = self.new_monster_damage,
        old_monster_attack_range = self.old_monster_attack_range,
        new_monster_attack_range = self.new_monster_attack_range,
        old_monster_hit_range = self.old_monster_hit_range,
        new_monster_hit_range = self.new_monster_hit_range,
        old_monster_health = self.old_monster_health,
        new_monster_health = self.new_monster_health,
        old_monster_mass = self.old_monster_mass,
        new_monster_mass = self.new_monster_mass,
        old_monster_radius = self.old_monster_radius,
        new_monster_radius = self.new_monster_radius,
        loot_times = self.loot_times,
        final_size = self.final_size,
        current_health = self.current_health,
        redcolor = self.redcolor,
        greencolor = self.greencolor,
        bluecolor = self.bluecolor,
        absorb = self.absorb,
        type = self.type
    }
end

function Garen_enomous_monster:OnLoad(data)
    if data == nil or GetPlayer().prefab ~= 'garen' then
        return
    end
    if data ~= nil then
        if data.switch_key ~= nil and not data.switch_key then
            self.switch_key = data.switch_key
        end
        if data.type ~= nil then
            self.type = data.type
        else
            self.type = 1
        end
        if data.redcolor ~= nil then
            self.redcolor = data.redcolor
        else
            self.redcolor = math.random()
        end
        if data.greencolor ~= nil then
            self.greencolor = data.greencolor
        else
            self.greencolor = math.random()
        end
        if data.absorb ~= nil then
            self.absorb = data.absorb
            if self.inst and self.inst.components.health and self.inst.components.health.absorb then
                self.inst.components.health.absorb = self.absorb
            end
        else
            self.absorb = 0
        end
        if data.bluecolor ~= nil then
            self.bluecolor = data.bluecolor
        else
            self.bluecolor = math.random()
        end

        if data.current_health ~= nil then
            self.current_health = data.current_health
        else
            self.current_health = 10
        end
        if data.final_size ~= nil then
            self.final_size = data.final_size
        else
            self.final_size = 1
        end
        if data.old_monster_size ~= nil then
            self.old_monster_size = data.old_monster_size
        else
            self.old_monster_size = self.inst.Transform:GetScale()
        end
        if data.new_monster_size ~= nil then
            self.new_monster_size = data.new_monster_size
        else
            self.new_monster_size = self.inst.Transform:GetScale()
        end
        if data.old_monster_damage ~= nil then
            self.old_monster_damage = data.old_monster_damage
        else
            self.old_monster_damage = self.inst.components.combat.defaultdamage
        end
        if data.new_monster_damage ~= nil then
            self.new_monster_damage = data.new_monster_damage
        else
            self.new_monster_damage = self.inst.components.combat.defaultdamage
        end
        if data.old_monster_attack_range ~= nil then
            self.old_monster_attack_range = data.old_monster_attack_range
        else
            self.old_monster_attack_range = self.inst.components.combat.attackrange
        end
        if data.new_monster_attack_range ~= nil then
            self.new_monster_attack_range = data.new_monster_attack_range
        else
            self.new_monster_attack_range = self.inst.components.combat.attackrange
        end
        if data.old_monster_hit_range ~= nil then
            self.old_monster_hit_range = data.old_monster_hit_range
        else
            self.old_monster_hit_range = self.inst.components.combat.hitrange
        end
        if data.new_monster_hit_range ~= nil then
            self.new_monster_hit_range = data.new_monster_hit_range
        else
            self.new_monster_hit_range = self.inst.components.combat.hitrange
        end
        if data.old_monster_health ~= nil then
            self.old_monster_health = data.old_monster_health
        else
            self.old_monster_health = self.inst.components.health.maxhealth
        end
        if data.new_monster_health ~= nil then
            self.new_monster_health = data.new_monster_health
        else
            self.new_monster_health = self.inst.components.health.maxhealth
        end
        if data.old_monster_mass ~= nil then
            self.old_monster_mass = data.old_monster_mass
        else
            self.old_monster_mass = self.inst.Physics:GetMass()
        end
        if data.new_monster_mass ~= nil then
            self.new_monster_mass = data.new_monster_mass
        else
            self.new_monster_mass = self.inst.Physics:GetMass()
        end
        if data.old_monster_radius ~= nil then
            self.old_monster_radius = data.old_monster_radius
        else
            self.old_monster_radius = self.inst.Physics:GetRadius()
        end
        if data.new_monster_radius ~= nil then
            self.new_monster_radius = data.new_monster_radius
        else
            self.new_monster_radius = self.inst.Physics:GetRadius()
        end
        if data.loot_times ~= nil then
            self.loot_times = data.loot_times
        else
            self.loot_times = 0
        end
        self:ChangeMonsterAttributes()
    end
end

return Garen_enomous_monster