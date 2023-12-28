function MoveToPos(NPCCity, x, y)
    while true do
        跨图寻路(NPCCity, x, y)
        延时(500)
        local myX = 获取人物信息(7)
        local myY = 获取人物信息(8)
        if tonumber(myX) == x and tonumber(myY) == y then
            break
        end
    end
end

取出物品("情诗恋曲")

MoveToPos("洛阳", 230, 345)

LUA_Call([[setmetatable(_G, {__index = MainMenuBar_Env});MainMenuBar_SelfEquip_Clicked();]])
延时(1000)
LUA_Call([[setmetatable(_G, {__index = SelfEquip_Env});Other_Info_Page_Switch();]])
延时(1000)
LUA_Call([[setmetatable(_G, {__index = OtherInfo_Env});this:Hide();]])

consortName = LUA_取返回值([[
	local consortName = SystemSetup:GetPrivateInfo("self","Consort");
	return consortName
]])

屏幕提示("您的配偶是:" .. consortName)

-- consortName = ''   -- 指定用户名字接口

while true do
    物品名称, 物品ID, 物品X坐标, 物品Y坐标, 物品血量, 物品距离, 物品类别, 物品归属, 怪物判断, 头顶标注 = 遍历周围物品(1, consortName, 15, "", 1)
    if 物品ID ~= nil or 物品ID ~= '' then
        选中对象(物品ID)
        延时(1000)
        选中对象(物品ID)
        延时(1000)

        local SHLQCount = 获取背包物品数量("情诗恋曲")

        for i = 1, SHLQCount do
            右键使用物品("情诗恋曲")
            延时(500)
        end

        break
    else
        延时(1000)
    end
end

