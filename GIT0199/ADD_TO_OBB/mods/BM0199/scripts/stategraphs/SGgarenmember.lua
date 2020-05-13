require("stategraphs/commonstates")

local actionhandlers =
{
    ActionHandler(ACTIONS.HAMMER,
        function(inst)
            if not inst.sg:HasStateTag("prehammer") then
                if inst.sg:HasStateTag("hammering") then
                    return "hammer"
                else
                    return "hammer_start"
                end
            end
        end),
    ActionHandler(ACTIONS.CHOP,
        function(inst)
            if not inst.sg:HasStateTag("prechop") then
                if inst.sg:HasStateTag("chopping") then
                    return "chop"
                else
                    return "chop_start"
                end
            end
        end),
    ActionHandler(ACTIONS.MINE,
        function(inst)
            if not inst.sg:HasStateTag("premine") then
                if inst.sg:HasStateTag("mining") then
                    return "mine"
                else
                    return "mine_start"
                end
            end
        end),
    ActionHandler(ACTIONS.PICKUP, "dolongaction"),
    ActionHandler(ACTIONS.GIVE, "give"),
    ActionHandler(ACTIONS.PICK, "dolongaction"),
    ActionHandler(ACTIONS.EAT, "quickeat"),
}

local function DoTalkSound(inst)
    if table.contains(CHARACTER_GENDERS.FEMALE, inst.charanm) then
        inst.SoundEmitter:PlaySound("dontstarve/characters/willow/talk_LP", "talk")
    else
        inst.SoundEmitter:PlaySound("dontstarve/characters/wilson/talk_LP", "talk")
    end
    return true
end


local events =
{
    CommonHandlers.OnLocomote(true, false),
    EventHandler("doattack",
        function(inst, data)
            if not inst.components.health:IsDead() then
                inst.sg:GoToState("attack", data.target)
                if data.target and data.target.components.combat and data.target:HasTag("wall") and inst.belongtowhich ~= TUNING.GARENBELONG then
                    inst.components.talker:Say(TUNING.LOLMEMBER.TALK18)
                    data.target.components.combat:GetAttacked(inst, 75)
                end
            end
        end),
    EventHandler("death", function(inst)
        inst.components.talker:Say(TUNING.LOLMEMBER.TALK20)
        inst.sg:GoToState("death")
        if inst.fx then
            if inst.fx.task then
                inst.fx.task:Cancel()
                inst.fx.task = nil
            end
            inst.fx:Remove()
            inst.fx = nil
        end
    end),

    EventHandler("attacked", function(inst, data)
        if not inst.hitTime then
            inst.hitTime = 0
        end
        if inst and not inst.protectTask then
            if td1madao_alive(inst) then
                inst.sg:GoToState("hit")
            end
            inst.hitTime = inst.hitTime + 1
            if inst.hitTime >= 2 then
                inst.protectTask = inst:DoTaskInTime(3, function()
                    if inst then
                        inst.hitTime = 0
                        td1madao_removeTask(inst, "protectTask")
                    end
                end)
            end
        else
            inst.hitTime = 0
        end
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
            inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))
            local x, y, z = inst.Transform:GetWorldPosition()
            if not inst.onwater and GetPlayer().prefab == 'garen' then
                local calc = math.random()
                if calc < 0.2 then
                    td1madao_safespawn("skeleton").Transform:SetPosition(x, y, z)
                elseif calc < 0.3 then
                    td1madao_safespawn("ghost").Transform:SetPosition(x, y, z)
                elseif calc < 0.4 then
                    td1madao_safespawn("garenwilton").Transform:SetPosition(x, y, z)
                end
            end
            if inst.berry then
                td1madao_safespawn("berries").Transform:SetPosition(x, y, z)
            end
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
        name = "quickeat",
        tags = { "busy" },
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("quick_eat")
        end,
        timeline =
        {
            TimeEvent(12 * FRAMES, function(inst)
                inst:PerformBufferedAction()
                inst.sg:RemoveStateTag("busy")
            end),
        },
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
        onexit = function(inst)
            inst.SoundEmitter:KillSound("eating")
        end,
    },

    State {
        name = "attack",
        tags = { "attack", "notalking", "abouttoattack", "busy" },
        onenter = function(inst)
            inst.sg.statemem.target = inst.components.combat.target
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
            if inst.myweapon == "swap_blowdart" then
                inst.AnimState:PlayAnimation("dart")
            else
                inst.AnimState:PlayAnimation("atk")
            end
        end,
        timeline =
        {
            TimeEvent(4 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/tentacle/tentacle_attack")
            end),
            TimeEvent(8 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("abouttoattack")
                inst.components.combat:DoAttack(inst.sg.statemem.target)
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
            if inst.onwater then
                inst.AnimState:PlayAnimation("row_pre")
            else
                inst.AnimState:PlayAnimation("run_pre")
            end
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
            if inst.onwater then
                inst.AnimState:PlayAnimation("row_loop")
            else
                inst.AnimState:PlayAnimation("run_loop")
            end
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

    State {
        name = "hit",
        tags = { "busy" },
        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/hit")
            if table.contains(CHARACTER_GENDERS.FEMALE, inst.charanm) then
                inst.SoundEmitter:PlaySound("dontstarve/characters/willow/hurt")
            else
                inst.SoundEmitter:PlaySound("dontstarve/characters/wilson/hurt")
            end

            inst.AnimState:PlayAnimation("hit")
            inst:ClearBufferedAction()
            inst.components.locomotor:Stop()
        end,
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
        timeline =
        {
            TimeEvent(0.5 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
                if inst and inst.trappers and inst.components.health and inst.components.health.currenthealth < 50
                        and inst.belongtowhich ~= TUNING.GARENBELONG
                then
                    inst.trappers = false
                    inst.sg:GoToState("doshortaction")
                    td1madao_safespawn("trap_teeth_maxwell").Transform:SetPosition(inst:GetPosition():Get())
                end
            end),
        },
    },

    State {
        name = "talk",
        tags = { "idle", "talking" },
        onenter = function(inst, noanim)
            if not noanim then
                inst.AnimState:PlayAnimation("dial_loop", true)
            end
            DoTalkSound(inst)
            inst.sg:SetTimeout(1.5 + math.random() * .5)
        end,
        ontimeout = function(inst)
            inst.sg:GoToState("idle")
        end,
        events =
        {
            EventHandler("donetalking", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
        onexit = function(inst)
            inst.SoundEmitter:KillSound("talk")
        end,
    },

    State {
        name = "wakeup",
        tags = { "busy" },
        onenter = function(inst)
            inst.AnimState:PlayAnimation("wakeup")
        end,
        onexit = function(inst)
        end,
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
        timeline =
        {
            TimeEvent(80 * FRAMES, function(inst)
                if inst.components.combat then
                    inst.components.combat:SetTarget(GetPlayer())
                end
                if inst.components.talker then
                    inst.components.talker:Say(TUNING.LOLMEMBER.TALK28)
                end
                inst.sg:RemoveStateTag("busy")
            end),
        },
    },

    State {
        name = "eat",
        tags = { "busy" },
        onenter = function(inst, feed)
            inst.components.locomotor:Stop()
            inst.SoundEmitter:PlaySound("dontstarve/wilson/eat", "eating")
            inst.AnimState:PlayAnimation("eat")
        end,
        timeline =
        {
            TimeEvent(12 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
                inst.sg:RemoveStateTag("pausepredict")
            end),
        },
        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
        onexit = function(inst)
            inst.SoundEmitter:KillSound("eating")
        end,
    },

    State {
        name = "give",
        tags = { "doing", "busy", "working" },
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("give")
        end,
        timeline =
        {
            TimeEvent(13 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
        },
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State {
        name = "jumpin",
        tags = { "busy" },
        onenter = function(inst)
            inst.AnimState:PlayAnimation("jump")
            inst:DoTaskInTime(3, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt", "bodyfall")
                inst.AnimState:PlayAnimation("idle")
            end)
        end,
        timeline =
        {
            TimeEvent(15 * FRAMES, function(inst)
                inst.components.combat:SetTarget(GetPlayer())
                if inst.components.talker then
                    inst.components.talker:Say(TUNING.LOLMEMBER.TALK28)
                end
                inst.sg:RemoveStateTag("busy")
            end),
        },
        onexit = function(inst)
        end,
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State {
        name = "doshortaction",
        tags = { "doing", "busy", "working" },
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("pickup")
            inst.sg:SetTimeout(6 * FRAMES)
        end,
        timeline =
        {
            TimeEvent(4 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(10 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("doing")
                inst.sg:AddStateTag("idle")
            end),
        },
        ontimeout = function(inst)
            inst:PerformBufferedAction()
        end,
        events =
        {
            EventHandler("animover", function(inst) if inst.AnimState:AnimDone() then inst.sg:GoToState("idle") end end),
        },
    },

    State {
        name = "dolongaction",
        tags = { "doing", "busy", "working" },
        timeline =
        {
            TimeEvent(4 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
        },
        onenter = function(inst, timeout)

            inst.sg:SetTimeout(timeout or 1)
            inst.components.locomotor:Stop()
            inst.SoundEmitter:PlaySound("dontstarve/wilson/make_trap", "make")

            inst.AnimState:PlayAnimation("build_pre")
            inst.AnimState:PushAnimation("build_loop", true)
        end,
        ontimeout = function(inst)
            inst.AnimState:PlayAnimation("build_pst")
            inst.sg:GoToState("idle", false)
            inst:PerformBufferedAction()
        end,
        onexit = function(inst)
            inst.SoundEmitter:KillSound("make")
        end,
    },

    State {
        name = "chop_start",
        tags = { "prechop", "chopping", "working" },
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("chop_pre")
        end,
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("chop") end),
        },
    },

    State {
        name = "chop",
        tags = { "prechop", "chopping", "working" },
        onenter = function(inst)
            inst.AnimState:PlayAnimation("chop_loop")
        end,
        timeline =
        {
            TimeEvent(5 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),

            TimeEvent(9 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("prechop")
            end),

            TimeEvent(16 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("chopping")
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
        name = "mine_start",
        tags = { "premine", "working" },
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("pickaxe_pre")
        end,
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("mine") end),
        },
    },

    State {
        name = "mine",
        tags = { "premine", "mining", "working" },
        onenter = function(inst)
            inst.AnimState:PlayAnimation("pickaxe_loop")
        end,
        timeline =
        {
            TimeEvent(9 * FRAMES, function(inst)
                inst:PerformBufferedAction()
                inst.sg:RemoveStateTag("premine")
                inst.SoundEmitter:PlaySound("dontstarve/wilson/use_pick_rock")
            end),
        },
        events =
        {
            EventHandler("animover", function(inst)
                inst.AnimState:PlayAnimation("pickaxe_pst")
                inst.sg:GoToState("idle", true)
            end),
        },
    },

    State {
        name = "hammer_start",
        tags = { "prehammer", "working" },
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("pickaxe_pre")
        end,
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("hammer") end),
        },
    },

    State {
        name = "castspell",
        tags = { "doing", "busy", "canrotate" },
        onenter = function(inst)
            inst.AnimState:PlayAnimation("staff")
            inst.components.locomotor:Stop()
            inst.stafffx = td1madao_deployBelow(inst, "staffcastfx")
        end,
        onexit = function(inst)
            td1madao_safeRemove(inst.stafffx)
        end,
        timeline =
        {
            TimeEvent(13 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/use_gemstaff")
            end),
            TimeEvent(0 * FRAMES, function(inst)
                inst.stafflight = td1madao_deployBelow(inst, "staff_castinglight")
            end),
        },
        events = {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

    State {
        name = "trans",
        tags = { "doing", "busy", "canrotate" },
        onenter = function(inst)
            inst.AnimState:PlayAnimation("atk")
            inst.components.locomotor:Stop()
        end,
        timeline =
        {
            TimeEvent(12 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
                inst.sg:RemoveStateTag("busy")
            end),
        },
        events = {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },


    State {
        name = "book",
        tags = { "doing", "busy", "canrotate" },
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("book")
            inst.AnimState:OverrideSymbol("book_open", "player_actions_uniqueitem", "book_open")
            inst.AnimState:OverrideSymbol("book_closed", "player_actions_uniqueitem", "book_closed")
            inst.AnimState:OverrideSymbol("book_open_pages", "player_actions_uniqueitem", "book_open_pages")
            inst.AnimState:Show("ARM_normal")
            inst.SoundEmitter:PlaySound("dontstarve/common/use_book")
        end,
        onexit = function(inst)
            inst.AnimState:Show("ARM_carry")
            inst.AnimState:Hide("ARM_normal")
            if inst.myweapon == "swap_staffs" then
                inst.AnimState:OverrideSymbol("swap_object", inst.myweapon, "redstaff")
            else
                inst.AnimState:OverrideSymbol("swap_object", inst.myweapon, inst.myweapon)
            end
            td1madao_safeRemove(inst.removeLatetr)
        end,
        timeline =
        {
            TimeEvent(0, function(inst)
                inst.removeLatetr = td1madao_deployBelow(inst, "book_fx")
            end),

            TimeEvent(58 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/book_spell")
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
        name = "hammer",
        tags = { "prehammer", "hammering", "working" },
        onenter = function(inst)
            inst.AnimState:PlayAnimation("pickaxe_loop")
        end,
        timeline =
        {
            TimeEvent(9 * FRAMES, function(inst)
                inst:PerformBufferedAction()
                inst.sg:RemoveStateTag("prehammer")
                inst.SoundEmitter:PlaySound("dontstarve/wilson/hit")
            end),
        },
        events =
        {
            EventHandler("animover", function(inst)
                inst.AnimState:PlayAnimation("pickaxe_pst")
                inst.sg:GoToState("idle", true)
            end),
        },
    },
}


return StateGraph("SGgarenmember", states, events, "idle", actionhandlers)

