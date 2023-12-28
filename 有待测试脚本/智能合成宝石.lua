合成4级 = 0

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品,必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

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

function StringSplit(str, reps)
    -- 字符串切割
    local resultStrList = {}
    string.gsub(str, '[^' .. reps .. ']+',
            function(w)
                table.insert(resultStrList, w)
            end
    )
    return resultStrList
end

function PackUpPacket(nTheTabIndex)
    if nTheTabIndex == 1 then
        MentalTip("自动整理 <道具栏>")
    elseif nTheTabIndex == 2 then
        MentalTip("自动整理 <材料栏>")
    end
    LUA_Call(string.format("PlayerPackage:PackUpPacket(%d);", nTheTabIndex))
end

function GemCarve(GemName, NeedItemName)
    MoveToPos("洛阳", 281, 321)
    MentalTip("宝石雕琢:%s ,%s", GemName, NeedItemName)
    延时(2000)
    local LPindex = 获取背包物品位置(GemName) - 1
    local Needindex = 获取背包物品位置(NeedItemName) - 1
    if LPindex >= 0 and Needindex >= 0 then
        local tem = LUA_取返回值(string.format([[
		local g_GemItemPos =%d
		local itemcount = PlayerPackage:GetBagItemNum(g_GemItemPos)
		Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name("OnGemCarve");
			Set_XSCRIPT_ScriptID(800117);
			Set_XSCRIPT_Parameter(0,g_GemItemPos);
			Set_XSCRIPT_Parameter(1,%d);
			Set_XSCRIPT_Parameter(2,135);
			Set_XSCRIPT_Parameter(3, 0);
			Set_XSCRIPT_Parameter(4,itemcount);
			Set_XSCRIPT_ParamCount(5);
		Send_XSCRIPT();
		]], LPindex, Needindex), "b")
    end
end

function Compose(gemIndex, HCFIndex)
    -- TODO
    local nSel = 0   -- 0：五合一    1：四合一    2：三合一
    LUA_取返回值(string.format([[
        g_GemTableIndex = %d
        g_ItemBagIndex = %d
        nSel = 0  -- 0
        LifeAbility:Do_Combine(g_GemTableIndex, g_ItemBagIndex, nSel, 100)
    ]], gemIndex, HCFIndex, nSel))
end

function GemCompose2Three(gemName)
    local twoGemNum = 获取背包物品数量('2级' .. gemName)
    local oneGemNum = 获取背包物品数量('1级' .. gemName)

    -- 用2级合成3级
    local needTwo2Three = 5 - twoGemNum
    local needOne2Two = needTwo2Three * 5

    if oneGemNum < needOne2Two then
        MentalTip(string.format([[1级%s数量不足, 退出]], gemName))
        return
    end

    -- 补齐 2 -> 3 缺少的2级
    for i = 1, needTwo2Three do
        local gemIndex = tonumber(获取背包物品位置('1级' .. gemName))
        local HCFIndex = tonumber(获取背包物品位置('低级宝石合成符'))
        Compose(gemIndex, HCFIndex)
        延时(500)
    end

    延时(2000)

    -- 用1级合成2级，多于25个才合成
    oneGemNum = 获取背包物品数量('1级' .. gemName)
    local canComposeNum = math.floor(oneGemNum / 25)
    for i = 1, canComposeNum do
        local gemIndex = tonumber(获取背包物品位置('1级' .. gemName))
        local HCFIndex = tonumber(获取背包物品位置('低级宝石合成符'))
        Compose(gemIndex, HCFIndex)
        PackUpPacket(2)
        延时(1000)
    end

    -- 用2级合成3级
    twoGemNum = 获取背包物品数量('2级' .. gemName)
    canComposeNum = math.floor(twoGemNum / 5)
    for i = 1, canComposeNum do
        local gemIndex = tonumber(获取背包物品位置('2级' .. gemName))
        local HCFIndex = tonumber(获取背包物品位置('低级宝石合成符'))
        Compose(gemIndex, HCFIndex)
        PackUpPacket(2)
        延时(1000)
    end

end

function GemCompose2Four(gemName)
    -- 3级合成4级
    local canComposeNum = math.floor(twoGemNum / 5)
    for i = 1, canComposeNum do
        local gemIndex = tonumber(获取背包物品位置('3级' .. gemName))
        local HCFIndex = tonumber(获取背包物品位置('低级宝石合成符'))
        Compose(gemIndex, HCFIndex)
        PackUpPacket(2)
        延时(1000)
    end
end

function main(gemName)
    GemCompose2Three(gemName)

    local DJFCount = 获取背包物品数量('宝石雕琢符3级')
    local gemCount = 获取背包物品数量('3级' .. gemName)

    if DJFCount > 0 and gemCount > 0 then
        for i= 1, math.min(DJFCount, gemCount) do
            GemCarve('3级' .. gemName, '宝石雕琢符3级')
            延时(500)
        end
    end

    if 合成4级 == 1 then
        if string.find('蓝晶石|红晶石|黄晶石|绿晶石|皓石|月光石|黄玉|碧玺', gemName) then
            gemName = '纯净' .. gemName
        end

        GemCompose2Four(gemName)
    end


end



-- main -------------------------------------------------------------------------------------------------------------

取出物品('低级宝石合成符|宝石雕琢符3级|宝石雕琢符4级|1级红宝石|2级红宝石|3级红宝石|4级红宝石|1级蓝晶石|2级蓝晶石|3级蓝晶石|4级蓝晶石|1级红晶石|2级红晶石|3级红晶石|4级红晶石|1级黄晶石|2级黄晶石|3级黄晶石|4级黄晶石|1级绿晶石|2级绿晶石|3级绿晶石|4级绿晶石|1级皓石|2级皓石|3级皓石|1级月光石|2级月光石|3级月光石|1级黄玉|2级黄玉|3级黄玉|1级碧玺|2级碧玺|3级碧玺|1级绿宝石|2级绿宝石|3级绿宝石|4级绿宝石|1级祖母绿|2级祖母绿|3级祖母绿|4级祖母绿')
取出物品("金币")

存物品("1级红宝石|1级蓝晶石|1级红晶石|1级黄晶石|1级绿晶石|1级皓石|1级月光石|1级黄玉|1级碧玺|1级绿宝石|1级祖母绿", 不存物品, 0, 1, 1)
存物品("1级红宝石|1级蓝晶石|1级红晶石|1级黄晶石|1级绿晶石|1级皓石|1级月光石|1级黄玉|1级碧玺|1级绿宝石|1级祖母绿", 不存物品, 0, 1, 1)
存物品("1级红宝石|1级蓝晶石|1级红晶石|1级黄晶石|1级绿晶石|1级皓石|1级月光石|1级黄玉|1级碧玺|1级绿宝石|1级祖母绿", 不存物品, 0, 1, 1)

属性宝石 = '1级蓝晶石|2级蓝晶石|3级蓝晶石|4级蓝晶石|1级红晶石|2级红晶石|3级红晶石|4级红晶石|1级黄晶石|2级黄晶石|3级黄晶石|4级黄晶石|1级绿晶石|2级绿晶石|3级绿晶石|4级绿晶石'

main()

