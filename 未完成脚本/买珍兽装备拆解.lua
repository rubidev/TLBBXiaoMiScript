function BuyPetEquipPkg()
    跨图寻路("洛阳", 224, 226)
    延时(1000)
    对话NPC("")
    延时(500)
    NPC二级对话("")
    延时(1000)
    LUA_Call([[]])  -- 购买函数
    延时(2000)
    local petEquipCountPkg = tonumber(获取背包物品数量("藏宝图"))

    for i = 1, petEquipCountPkg do
        右键使用物品("")
        延时(100)
    end
end

function PetEquipDepart()
    local g_PetEquipSuitDepartID = {
	70500000,
	70500005,
	70500010,
	70500015,
	70500020,
	70500025,
	70500030,
	70500035,
	70500040,
	70500162,
	70501000,
	70501005,
	70501010,
	70501015,
	70501020,
	70501025,
	70501030,
	70501035,
	70501040,
	70501162,
	70502000,
	70502005,
	70502010,
	70502015,
	70502020,
	70502025,
	70502030,
	70502035,
	70502040,
	70502162,
	70503000,
	70503005,
	70503010,
	70503015,
	70503020,
	70503025,
	70503030,
	70503035,
	70503040,
	70503162,
	70504000,
	70504005,
	70504010,
	70504015,
	70504020,
	70504025,
	70504030,
	70504035,
	70504040,
	70504162}
    跨图寻路("苏州", 1, 2)
    延时(1000)
    对话NPC("")
    延时(500)
    NPC二级对话("")
    延时(1000)
    -- TODO 完善

end

BuyPetEquipPkg()
执行功能("存仓补给")  -- 清理背包
延时(1000)
PetEquipDepart()