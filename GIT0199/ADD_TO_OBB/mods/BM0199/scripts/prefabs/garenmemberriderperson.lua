local assets =
{}
local prefabs =
{}

local function fn(Sim)
    local inst = td1madao_safespawn(TUNING.GARENENEMYNAME)
    inst.prefab = 'garenmemberriderperson'
    td1madao_removeIfNoOwner(inst)
    return inst
end

return Prefab("common/monsters/garenmemberriderperson", fn, assets, prefabs)
