local assets = {}
if td1madao_enableSW() then
    assets =
    {
        Asset("ANIM", "anim/rowboat_basic.zip"),
        Asset("ANIM", "anim/rowboat_build.zip"),
        Asset("ANIM", "anim/swap_sail.zip"),
        Asset("ANIM", "anim/swap_lantern_boat.zip"),
        Asset("ANIM", "anim/boat_hud_row.zip"),
        Asset("ANIM", "anim/boat_inspect_row.zip"),
        Asset("ANIM", "anim/flotsam_rowboat_build.zip"),
    }
end
local prefabs = {}
local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.Transform:SetFourFaced()
    anim:SetBank("rowboat")
    anim:SetBuild("rowboat_build")
    anim:PlayAnimation("run_loop", true)
    td1madao_removeIfNoOwner(inst)
    return inst
end

return Prefab("common/monsters/garenrowboat", fn, assets, prefabs)
