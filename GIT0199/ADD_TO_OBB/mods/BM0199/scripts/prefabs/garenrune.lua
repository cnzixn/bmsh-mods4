local assets =
{}

local function itemtest(inst, item, slot)
    return item and item:HasTag("td1madao_rune")
end


local function processon(inst)
    inst.components.container:Close()
end


local widgetbuttoninfo =
{
    text = TUNING.LOLMEMBER.TALK75,
    position = Vector3(0, -165, 0),
    fn = processon,
}

local slotpos = {}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 80, 0))
    end
end

local function fn(Sim)
    if GetPlayer().td1madao_rune_page == true then
        return td1madao_safespawn('garennil')
    end
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    inst:AddComponent("container")
    inst:AddTag("td1madao_rune_page")
    inst.components.container.itemtestfn = itemtest
    inst.components.container:SetNumSlots(#slotpos)
    inst.components.container.widgetslotpos = slotpos
    inst.components.container.widgetanimbank = "ui_chest_3x3"
    inst.components.container.widgetanimbuild = "ui_chest_3x3"
    inst.components.container.widgetpos = Vector3(0, 200, 0)
    inst.components.container.side_align_tip = 160
    inst.components.container.widgetbuttoninfo = widgetbuttoninfo
    GetPlayer().td1madao_rune_page = true
    return inst
end

return Prefab("garenrune", fn, assets)