require "prefabutil"
local prefabs = {}
local assets = {}
if td1madao_enableSW() then
    prefabs =
    {
        "rowboat_wake",
        "boat_hit_fx",
        "boat_hit_fx_raft_log",
        "boat_hit_fx_raft_bamboo",
        "boat_hit_fx_rowboat",
        "boat_hit_fx_cargoboat",
        "boat_hit_fx_armoured",
        "flotsam_armoured",
        "flotsam_bamboo",
        "flotsam_cargo",
        "flotsam_lograft",
        "flotsam_rowboat",
        "flotsam_surfboard",
    }
    assets =
    {
        Asset("ANIM", "anim/raft_surfboard_build.zip"),
        Asset("ANIM", "anim/garenduck.zip"),
        Asset("ANIM", "anim/flotsam_rowboat_build.zip"),
        Asset("IMAGE", "images/inventoryimages/garenduck.tex"),
        Asset("ATLAS", "images/inventoryimages/garenduck.xml"),
        Asset("MINIMAP_IMAGE", "garenduckmap"),
        Asset("ANIM", "anim/rowboat_basic.zip"),
        Asset("ANIM", "anim/swap_sail.zip"),
        Asset("ANIM", "anim/swap_lantern_boat.zip"),
        Asset("ANIM", "anim/boat_hud_cargo.zip"),
        Asset("ANIM", "anim/boat_inspect_cargo.zip"),
    }
end

local function gua(inst)
    td1madao_doPeriodicTask(inst, nil, function()
        inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/decidous/drake_run_voice")
    end, 0.3, 4)
end

local function boat_perish(inst)
    if inst.components.drivable.driver then
        local driver = inst.components.drivable.driver
        driver.components.driver:OnDismount(true)
        driver.components.health:Kill("drowning")
        inst.SoundEmitter:PlaySound(inst.sinksound)
        gua(inst)
        inst:Remove()
    end
end

local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("run_loop", true)
    gua(inst)
end

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    td1madao_safespawn("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
    gua(inst)
    inst:Remove()
end

local function onmounted(inst)
    inst:RemoveComponent("workable")
    gua(inst)
end

local function ondismounted(inst)
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)
    gua(inst)
end

local function onopen(inst)
    if inst.components.drivable.driver == nil then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/HUD_boat_inventory_open")
        gua(inst)
    end
end

local function onclose(inst)
    if inst.components.drivable.driver == nil then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/HUD_boat_inventory_close")
        gua(inst)
    end
end

local function setupcontainer(inst, slots, bank, build, inspectslots, inspectbank, inspectbuild, inspectboatbadgepos, inspectboatequiproot)
    inst:AddComponent("container")
    inst.components.container:SetNumSlots(#slots)
    inst.components.container.type = "boat"
    inst.components.container.side_align_tip = -500
    inst.components.container.canbeopened = false
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    inst.components.container.widgetslotpos = slots
    inst.components.container.widgetanimbank = bank
    inst.components.container.widgetanimbuild = build
    inst.components.container.widgetboatbadgepos = Vector3(0, 40, 0)
    inst.components.container.widgetequipslotroot = Vector3(-80, 40, 0)
    local boatwidgetinfo = {}
    boatwidgetinfo.widgetslotpos = inspectslots
    boatwidgetinfo.widgetanimbank = inspectbank
    boatwidgetinfo.widgetanimbuild = inspectbuild
    boatwidgetinfo.widgetboatbadgepos = inspectboatbadgepos
    boatwidgetinfo.widgetpos = Vector3(200, 0, 0)
    boatwidgetinfo.widgetequipslotroot = inspectboatequiproot
    inst.components.container.boatwidgetinfo = boatwidgetinfo
end

local function commonfn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    trans:SetFourFaced()
    inst.no_wet_prefix = true
    inst:AddTag("boat")
    local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddPhysics()
    inst.Physics:SetCylinder(0.25, 2)
    inst:AddComponent("inspectable")
    inst:AddComponent("drivable")
    inst.waveboost = TUNING.WAVEBOOST
    inst.sailmusic = "sailing"
    inst:AddComponent("rowboatwakespawner")
    inst:AddComponent("boathealth")
    inst.components.boathealth:SetDepletedFn(boat_perish)
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)
    inst:AddComponent("lootdropper")
    inst:AddComponent("repairable")
    inst.components.repairable.repairmaterial = "boat"
    inst.components.repairable.onrepaired = function(inst, doer, repair_item)
        if inst.SoundEmitter then
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/boatrepairkit")
            gua(inst)
        end
    end
    inst:ListenForEvent("mounted", onmounted)
    inst:ListenForEvent("dismounted", ondismounted)
    inst:AddComponent("flotsamspawner")
    return inst
end


local function garenduck_fn(sim)
    local inst = commonfn(sim)
    local slotpos = {}
    for i = 6, 1, -1 do
        table.insert(slotpos, Vector3(-13 - (80 * (i + 2)), 40, 0))
    end
    local inspectslotpos = {}
    for y = 1, 3 do
        for x = 0, 1 do
            table.insert(inspectslotpos, Vector3(-40 + (x * 80), 70 + (y * -75), 0))
        end
    end
    setupcontainer(inst, slotpos, "boat_hud_cargo", "boat_hud_cargo", inspectslotpos, "boat_inspect_cargo", "boat_inspect_cargo", { x = 0, y = 155 }, { x = 40, y = 70 })
    inst.components.container.hasboatequipslots = true
    inst.AnimState:SetBank("rowboat")
    inst.AnimState:SetBuild("garenduck")
    inst.AnimState:PlayAnimation("run_loop", true)
    inst.entity:AddMiniMapEntity()
    inst.MiniMapEntity:SetIcon("garenduck.tex")
    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetPriority(5)
    inst.perishtime = (TUNING.ARMOUREDBOAT_PERISHTIME)
    inst.components.boathealth.maxhealth = TUNING.ARMOUREDBOAT_HEALTH
    inst.components.boathealth:SetHealth(TUNING.ARMOUREDBOAT_HEALTH, inst.perishtime)
    inst.landsound = "dontstarve_DLC002/common/boatjump_land_wood"
    inst.sinksound = "dontstarve_DLC002/common/boat_sinking_log_cargo"
    inst.components.boathealth.damagesound = "dontstarve_DLC002/common/boat_damage_cargo"
    inst.components.drivable.sanitydrain = TUNING.CARGOBOAT_SANITY_DRAIN
    inst.components.drivable.runspeed = TUNING.ARMOUREDBOAT_SPEED
    inst.components.drivable.runanimation = "row_loop"
    inst.components.drivable.prerunanimation = "row_pre"
    inst.components.drivable.postrunanimation = "row_pst"
    inst.components.drivable.overridebuild = "garenduck"
    inst.components.drivable.flotsambuild = "flotsam_rowboat_build"
    inst.components.drivable.hitfx = "boat_hit_fx_cargoboat"
    inst.components.drivable.maprevealbonus = TUNING.MAPREVEAL_CARGOBOAT_BONUS
    inst.components.drivable.creaksound = "dontstarve_DLC002/common/boat_creaks_cargo"

    inst.components.flotsamspawner.flotsamprefab = "flotsam_cargo"
    gua(inst)
    return inst
end

return
Prefab("common/objects/garenduck", garenduck_fn, assets, prefabs),
MakePlacer("common/garenduck_placer", "rowboat", "garenduck", "run_loop", false, false, false)