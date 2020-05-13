require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/treasure_chest.zip"),
    Asset("ANIM", "anim/ui_chest_3x2.zip"),
}

local chests = {
    treasure_chest = {
        bank = "chest",
        build = "treasure_chest",
    },
}

local slotpos_3x4 = {}

for y = 2.5, -0.5, -1 do
    for x = 0, 2 do
        table.insert(slotpos_3x4, Vector3(75 * x - 75 * 2 + 75, 75 * y - 75 * 2 + 75, 0))
    end
end

function processon(inst)
    if inst.businessman and inst.businessman.getPrize then
        local totalmoney = 0
        for k, v in pairs(inst.components.container.slots) do
            local number = 1
            if v.components.stackable then
                number = v.components.stackable.stacksize
            end
            local resultPrice = inst.businessman.getPrize2(v)
            if resultPrice > 500 then
                resultPrice = resultPrice / 2
            end
            if resultPrice > 200 then
                resultPrice = resultPrice / 2
            end
            if resultPrice > 800 then
                resultPrice = 800
            end
            totalmoney = totalmoney + resultPrice * number
        end
        GetPlayer().components.td1madao_leveler:obtainMoney(totalmoney)
        inst.components.container:DestroyContents()
    end
end

local widgetbuttoninfo =
{
    text = STRINGS.GARENSELL,
    position = Vector3(0, -165, 0),
    fn = processon,
}

local function kill_fx(inst)
    if inst then
        GetPlayer().businessmanchest = false
        inst.components.container:DropEverything()
        td1madao_safespawn("explode_small").Transform:SetPosition(inst:GetPosition():Get())
        inst:DoTaskInTime(0, function() inst:Remove() end)
    end
end


local function onopen(inst)
    inst.AnimState:PlayAnimation("open")
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
end

local function onclose(inst)
    inst.AnimState:PlayAnimation("close")
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
end

local function onhammered(inst, worker)
    GetPlayer().businessmanchest = false
    inst.components.lootdropper:DropLoot()
    inst.components.container:DropEverything()
    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
    inst:Remove()
end

local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("hit")
    inst.components.container:DropEverything()
    inst.AnimState:PushAnimation("closed", false)
    inst.components.container:Close()
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("closed", false)
end

local slotpos = {}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 80, 0))
    end
end

local function chest(style)
    local fn = function(Sim)

        local bus = TheSim:FindFirstEntityWithTag("lolbusiness")
        if GetPlayer().businessmanchest == true or not bus then
            return td1madao_safespawn('garennil')
        end
        local inst = CreateEntity()
        inst.businessman = bus
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        local minimap = inst.entity:AddMiniMapEntity()
        minimap:SetIcon(style .. ".tex")
        inst:AddTag("structure")
        inst.AnimState:SetBank(chests[style].bank)
        inst.AnimState:SetBuild(chests[style].build)
        inst.AnimState:PlayAnimation("closed")
        inst:AddComponent("inspectable")
        inst:AddComponent("container")
        inst.components.container:SetNumSlots(#slotpos_3x4)
        inst.components.container.onopenfn = onopen
        inst.components.container.onclosefn = onclose

        inst.components.container.widgetslotpos = slotpos_3x4
        inst.components.container.widgetanimbank = "ui_chester_shadow_3x4"
        inst.components.container.widgetanimbuild = "ui_chester_shadow_3x4"
        inst.components.container.widgetpos = Vector3(0, 220, 0)
        inst.components.container.widgetpos_controller = Vector3(0, 220, 0)
        inst.components.container.side_align_tip = 160
        inst.components.container.widgetbuttoninfo = widgetbuttoninfo
        inst:DoTaskInTime(0.5, function()
            inst.labelname = inst.entity:AddLabel()
            inst.labelname:SetFontSize(35)
            inst.labelname:SetPos(0, 3.3, 0)
            inst.labelname:SetFont(NUMBERFONT)
            inst.labelname:Enable(true)
            inst.labelname:SetColour(0, 1, 0)
            inst.labelname:SetText(STRINGS.NAMES.GARENTREASURECHEST)
        end)
        inst:AddComponent("lootdropper")
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(2)
        inst.components.workable:SetOnFinishCallback(onhammered)
        inst.components.workable:SetOnWorkCallback(onhit)

        inst:ListenForEvent("onbuilt", onbuilt)

        inst:ListenForEvent("daytime", function(global, data)
            kill_fx(inst)
        end, GetWorld())

        MakeSnowCovered(inst, .01)

        GetPlayer().businessmanchest = true

        return inst
    end
    return fn
end

return Prefab("common/garentreasurechest", chest("treasure_chest"), assets)