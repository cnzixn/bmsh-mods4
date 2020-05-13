require("stategraphs/commonstates")

local actionhandlers =
{
    ActionHandler(ACTIONS.EAT, "eat"),
    ActionHandler(ACTIONS.GOHOME, "eat"),
    ActionHandler(ACTIONS.INVESTIGATE, "investigate"),
}

local events =
{
    EventHandler("attacked", function(inst)
        if not inst.components.health:IsDead() then
            if inst:HasTag("spider_warrior") or inst:HasTag("spider_spitter") then
                if not inst.sg:HasStateTag("attack") then
                    inst.sg:GoToState("hit")
                end
            elseif not inst.sg:HasStateTag("shield") then
                inst.sg:GoToState("hit_stunlock")
            end
        end
    end),
    EventHandler("doattack", function(inst, data)
        if not inst.components.health:IsDead() and not inst.sg:HasStateTag("busy") and data and data.target then
            if inst:HasTag("spider_warrior") and
                    inst:GetDistanceSqToInst(data.target) > TUNING.SPIDER_WARRIOR_MELEE_RANGE * TUNING.SPIDER_WARRIOR_MELEE_RANGE then
                inst.sg:GoToState("warrior_attack", data.target)
            elseif inst:HasTag("spider_spitter") and
                    inst:GetDistanceSqToInst(data.target) > TUNING.SPIDER_SPITTER_MELEE_RANGE * TUNING.SPIDER_SPITTER_MELEE_RANGE then
                inst.sg:GoToState("spitter_attack", data.target)
            else
                inst.sg:GoToState("attack", data.target)
            end
        end
    end),
    EventHandler("death", function(inst) inst.sg:GoToState("death") end),
    CommonHandlers.OnSleep(),
    CommonHandlers.OnLocomote(true, false),
    CommonHandlers.OnFreeze(),
    EventHandler("entershield", function(inst) inst.sg:GoToState("shield") end),
    EventHandler("exitshield", function(inst) inst.sg:GoToState("shield_end") end),
}

local function SoundPath(inst, event)
    return "dontstarve/creatures/hound/" .. event
end

local function SoundPath2(inst, event)
    return "dontstarve/creatures/spider/" .. event
end

local states =
{
    State {
        name = "death",
        tags = { "busy" },
        onenter = function(inst)
            inst.SoundEmitter:PlaySound(SoundPath(inst, "die"))
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            RemovePhysicsColliders(inst)
            inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))
        end,
    },

    State {
        name = "premoving",
        tags = { "moving", "canrotate" },
        onenter = function(inst)
            inst.components.locomotor:WalkForward()
            inst.AnimState:PlayAnimation("walk_pre")
        end,
        timeline =
        {
            TimeEvent(3 * FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath2(inst, "walk_spider")) end),
        },
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("moving") end),
        },
    },

    State {
        name = "moving",
        tags = { "moving", "canrotate" },
        onenter = function(inst)
            inst.components.locomotor:RunForward()
            inst.AnimState:PushAnimation("walk_loop")
        end,
        timeline =
        {
            TimeEvent(0 * FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath2(inst, "walk_spider")) end),
            TimeEvent(3 * FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath2(inst, "walk_spider")) end),
            TimeEvent(7 * FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath2(inst, "walk_spider")) end),
            TimeEvent(12 * FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath2(inst, "walk_spider")) end),
        },
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("moving") end),
        },
    },


    State {
        name = "idle",
        tags = { "idle", "canrotate" },
        ontimeout = function(inst)
            inst.sg:GoToState("taunt")
        end,
        onenter = function(inst, start_anim)
            inst.Physics:Stop()
            local animname = "idle"
            if math.random() < .3 then
                inst.sg:SetTimeout(math.random() * 2 + 2)
            end

            if inst.LightWatcher:GetLightValue() > 1 then
                inst.AnimState:PlayAnimation("hit")
                inst.AnimState:PushAnimation("idle", true)
            else
                if start_anim then
                    inst.AnimState:PlayAnimation(start_anim)
                    inst.AnimState:PushAnimation("idle", true)
                else
                    inst.AnimState:PlayAnimation("idle", true)
                end
            end
        end,
    },

    State {
        name = "eat",
        tags = { "busy" },
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("atk_pre")
            inst.AnimState:PushAnimation("atk", false)
        end,
        events =
        {
            EventHandler("animover", function(inst)
                if inst:PerformBufferedAction() then
                    inst.sg:GoToState("eat_loop")
                else
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },


    State {
        name = "born",
        tags = { "busy" },
        onenter = function(inst)
            inst.AnimState:PlayAnimation("taunt")
        end,
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State {
        name = "eat_loop",
        tags = { "busy" },
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("atk_pre")
            inst.AnimState:PushAnimation("atk", true)
            inst.sg:SetTimeout(1 + math.random() * 1)
        end,
        ontimeout = function(inst)
            inst.sg:GoToState("idle")
        end,
    },

    State {
        name = "taunt",
        tags = { "busy" },
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("taunt")
            if not inst.shuttask then
                inst.SoundEmitter:PlaySound("dontstarve/creatures/hound/mound_LP")
            end
        end,
        timeline =
        {
            TimeEvent(13 * FRAMES, function(inst) if not inst.shuttask then inst.SoundEmitter:PlaySound("dontstarve/creatures/hound/bark") end end),
            TimeEvent(24 * FRAMES, function(inst) if not inst.shuttask then inst.SoundEmitter:PlaySound("dontstarve/creatures/hound/bark") end end),
        },
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State {
        name = "investigate",
        tags = { "busy" },
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("taunt")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/hound/mound_LP")
        end,
        events =
        {
            EventHandler("animover", function(inst)
                inst:PerformBufferedAction()
                inst.sg:GoToState("idle")
            end),
        },
    },

    State {
        name = "attack",
        tags = { "attack", "busy" },
        onenter = function(inst, target)
            inst.sg.statemem.target = target
            inst.Physics:Stop()
            inst.components.combat:StartAttack()
            inst.AnimState:PlayAnimation("atk_pre")
            inst.AnimState:PushAnimation("atk", true)
        end,
        timeline =
        {
            TimeEvent(10 * FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/hound/attack") end),
            TimeEvent(12 * FRAMES, function(inst) inst.components.combat:DoAttack(inst.sg.statemem.target) end),
        },
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State {
        name = "warrior_attack",
        tags = { "attack", "canrotate", "busy", "jumping" },
        onenter = function(inst, target)
            inst.components.locomotor:Stop()
            inst.components.locomotor:EnableGroundSpeedMultiplier(false)

            inst.components.combat:StartAttack()

            inst.AnimState:PlayAnimation("warrior_atk")
            inst.sg.statemem.target = target
        end,
        onexit = function(inst)
            inst.components.locomotor:Stop()
            inst.components.locomotor:EnableGroundSpeedMultiplier(true)
        end,
        timeline =
        {
            TimeEvent(0 * FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath(inst, "attack_grunt")) end),
            TimeEvent(0 * FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath(inst, "Jump")) end),
            TimeEvent(8 * FRAMES, function(inst) inst.Physics:SetMotorVelOverride(20, 0, 0) end),
            TimeEvent(9 * FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/hound/bark") end),
            TimeEvent(19 * FRAMES, function(inst) inst.components.combat:DoAttack(inst.sg.statemem.target) end),
            TimeEvent(20 * FRAMES,
                function(inst)
                    inst.Physics:ClearMotorVelOverride()
                    inst.components.locomotor:Stop()
                end),
        },
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("taunt") end),
        },
    },

    State {
        name = "spitter_attack",
        tags = { "attack", "canrotate", "busy", "spitting" },
        onenter = function(inst, target)
            if inst.weapon and inst.components.inventory then
                inst.components.inventory:Equip(inst.weapon)
            end
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("spit")
        end,
        onexit = function(inst)
            if inst.components.inventory then
                inst.components.inventory:Unequip(EQUIPSLOTS.HANDS)
            end
        end,
        timeline =
        {
            TimeEvent(7 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound(SoundPath2(inst, "spit_web"))
            end),

            TimeEvent(21 * FRAMES, function(inst) inst.components.combat:DoAttack()
            inst.SoundEmitter:PlaySound(SoundPath2(inst, "spit_voice"))
            end),
        },
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("taunt") end),
        },
    },

    State {
        name = "hit",
        onenter = function(inst)
            inst.AnimState:PlayAnimation("hit")
            inst.Physics:Stop()
        end,
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State {
        name = "hit_stunlock",
        tags = { "busy" },
        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/hound/hurt")
            inst.AnimState:PlayAnimation("hit")
            inst.Physics:Stop()
        end,
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State {
        name = "shield",
        tags = { "busy", "shield" },
        onenter = function(inst)
            inst.components.health:SetAbsorbAmount(TUNING.SPIDER_HIDER_SHELL_ABSORB)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("hide")
            inst.AnimState:PushAnimation("hide_loop")
        end,
        onexit = function(inst)
            inst.components.health:SetAbsorbAmount(0)
        end,
    },

    State {
        name = "shield_end",
        tags = { "busy", "shield" },
        onenter = function(inst)
            inst.AnimState:PlayAnimation("unhide")
        end,
        events =
        {
            EventHandler("animqueueover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State {
        name = "dropper_enter",
        tags = { "busy" },
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("enter")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/hound/descend")
        end,
        events =
        {
            EventHandler("animqueueover", function(inst) inst.sg:GoToState("taunt") end),
        },
    },
}

CommonStates.AddSleepStates(states,
    {
        starttimeline = {},
        sleeptimeline =
        {
            TimeEvent(35 * FRAMES, function(inst) if inst.components.follower.leader and inst.components.follower.leader.components.leader.numfollowers > 0 and math.random() < 0.25 + 0.5 / inst.components.follower.leader.components.leader.numfollowers then end end),
        },
        waketimeline = {
            TimeEvent(0 * FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath(inst, "wakeUp")) end),
        },
    })

CommonStates.AddRunStates(states,
    {
        runtimeline = {
            TimeEvent(0, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/hound/growl") end),
            TimeEvent(0 * FRAMES, PlayFootstep),
            TimeEvent(4 * FRAMES, PlayFootstep),
        },
    })
CommonStates.AddFrozenStates(states)

return StateGraph("garenporo", states, events, "idle", actionhandlers)

