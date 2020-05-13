require("stategraphs/commonstates")

local events =
{
    CommonHandlers.OnLocomote(true, false),

    EventHandler("attacked", function(inst) if inst.components.health:GetPercent() > 0 then inst.sg:GoToState("hit") end end),
    EventHandler("doattack", function(inst)
        if not inst.components.health:IsDead() then
            inst.sg:GoToState("attack")
        end
    end),
    EventHandler("death", function(inst)
        inst.sg:GoToState("death")
    end),
}

local states =
{
    State {
        name = "death",
        tags = { "busy" },
        onenter = function(inst)
            inst.components.locomotor.directdrive = false
            inst.components.locomotor:Stop()
            inst.AnimState:Hide("swap_arm_carry")
            inst.AnimState:PlayAnimation("death")
        end,
    },

    State {
        name = "idle",
        tags = { "idle", "canrotate" },
        onenter = function(inst, pushanim)
            inst.components.locomotor:Stop()
            local anims = { "idle_loop" }
            local anim = "idle_loop"
            if pushanim then
                for k, v in pairs(anims) do
                    inst.AnimState:PushAnimation(v, k == #anims)
                end
            else
                inst.AnimState:PlayAnimation(anims[1], #anims == 1)
                for k, v in pairs(anims) do
                    if k > 1 then
                        inst.AnimState:PushAnimation(v, k == #anims)
                    end
                end
            end
            inst.sg:SetTimeout(math.random() * 4 + 2)
        end,
    },

    State {
        name = "attack",
        tags = { "attack", "notalking", "abouttoattack", "busy" },
        onenter = function(inst)
            inst.sg.statemem.target = inst.components.combat.target
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("atk")
            if not inst.hittime then
                inst.hittime = 0
            end
            inst.hittime = inst.hittime + 1
            if not inst.protectedtask and inst.hittime > math.random(4) then
                inst.protectedtask = inst:DoTaskInTime(5, function()
                    inst.hittime = 0
                    if inst.protectedtask then
                        inst.protectedtask:Cancel()
                        inst.protectedtask = nil
                    end
                end)
            end
        end,
        timeline =
        {
            TimeEvent(4 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/tentacle/tentacle_attack")
            end),
            TimeEvent(5 * FRAMES, function(inst)
                inst.components.combat:DoAttack(inst.sg.statemem.target)
                inst.sg:RemoveStateTag("abouttoattack")
                inst.sg:RemoveStateTag("busy")
                inst.sg:RemoveStateTag("attack")
            end),
        },
        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

    State {
        name = "run_start",
        tags = { "moving", "running", "canrotate" },
        onenter = function(inst)
            inst.components.locomotor:RunForward()
            inst.AnimState:PlayAnimation("run_pre")
            inst.sg.mem.foosteps = 0
        end,
        onupdate = function(inst)
            inst.components.locomotor:RunForward()
        end,
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("run") end),
        },
        timeline =
        {
            TimeEvent(4 * FRAMES, function(inst)
                PlayFootstep(inst)
            end),
        },
    },

    State {
        name = "run",
        tags = { "moving", "running", "canrotate" },
        onenter = function(inst)
            inst.components.locomotor:RunForward()
            inst.AnimState:PlayAnimation("run_loop")
        end,
        onupdate = function(inst)
            inst.components.locomotor:RunForward()
        end,
        timeline =
        {
            TimeEvent(7 * FRAMES, function(inst)
                inst.sg.mem.foosteps = inst.sg.mem.foosteps + 1
                PlayFootstep(inst, inst.sg.mem.foosteps < 5 and 1 or .6)
            end),
            TimeEvent(15 * FRAMES, function(inst)
                inst.sg.mem.foosteps = inst.sg.mem.foosteps + 1
                PlayFootstep(inst, inst.sg.mem.foosteps < 5 and 1 or .6)
            end),
        },
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("run") end),
        },
    },

    State {
        name = "hit",
        tags = { "busy" },
        onenter = function(inst)
            if not inst.protectedtask2 then
                inst.components.locomotor:Stop()
                inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_girl_howl")
                inst.AnimState:PlayAnimation("hit")
                if not inst.hittime then
                    inst.hittime = 0
                end
                inst.hittime = inst.hittime + 1
                inst.protectedtask2 = inst:DoTaskInTime(1, function()
                    if inst.protectedtask2 then
                        inst.protectedtask2:Cancel()
                        inst.protectedtask2 = nil
                    end
                end)
            end
        end,
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
        timeline =
        {
            TimeEvent(1 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
        },
    },

    State {
        name = "run_stop",
        tags = { "canrotate", "idle" },
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("run_pst")
        end,
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },
}


return StateGraph("garenwilton", states, events, "idle")

