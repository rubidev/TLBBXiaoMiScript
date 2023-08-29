取出物品("诗情恋曲")

跨图寻路("苏州", 222, 235)
延时(2000)

consortName = LUA_取返回值([[
	local consortName = SystemSetup:GetPrivateInfo("self","Consort");
	return consortName
]])

-- consortName = ''   -- 指定用户名字接口

while true do
    物品名称, 物品ID, 物品X坐标, 物品Y坐标, 物品血量, 物品距离, 物品类别, 物品归属, 怪物判断, 头顶标注 = 遍历周围物品(1, consortName, 15, "", 1)
    if 物品ID ~= nil or 物品ID ~= '' then
        选中对象(物品ID)
        延时(1000)
        选中对象(物品ID)
        延时(1000)

        local SHLQCount = 获取背包物品数量("诗情恋曲")

        for i = 1, SHLQCount do
            右键使用物品("诗情恋曲")
            延时(500)
        end

        break
    else
        延时(1000)
    end
end

