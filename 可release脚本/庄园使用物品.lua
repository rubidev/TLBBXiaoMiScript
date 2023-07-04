local 人物名称 = 获取人物信息(12)
local 当前所在地图 = 获取人物信息(16)

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

function SaveFurniture()
    LUA_Call([[setmetatable(_G, {__index = BieYe_Mini_Env});BieYe_Mini_Sub(1)]])  -- 打开庭院仓库
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = BieYeFurnitureBank_Env});BieYeFurnitureBank_Buy_Clicked()]])  -- 点击存放
    延时(1000)
    local tmp = LUA_取返回值([[
        local furnitureList = {
            "石桌（1级）", "石桌（2级）", "石桌（3级）", "石桌（4级）", "石桌（5级）",
            "石凳（1级）", "石凳（2级）", "石凳（3级）", "石凳（4级）", "石凳（5级）",
            "青石喷泉（1级）", "青石喷泉（2级）", "青石喷泉（3级）", "青石喷泉（4级）", "青石喷泉（5级）",
            "青石壁（1级）", "青石壁（2级）", "青石壁（3级）", "青石壁（4级）", "青石壁（5级）",
            "庭院灯（1级）", "庭院灯（2级）", "庭院灯（3级）", "庭院灯（4级）", "庭院灯（5级）",
            "青石鼎（1级）", "青石鼎（2级）", "青石鼎（3级）", "青石鼎（4级）", "青石鼎（5级）",
            "太湖石（1级）", "太湖石（2级）", "太湖石（3级）", "太湖石（4级）", "太湖石（5级）",
            "松树（1级）", "松树（2级）", "松树（3级）", "松树（4级）", "松树（5级）",
            "牡丹盆栽（1级）", "牡丹盆栽（2级）", "牡丹盆栽（3级）", "牡丹盆栽（5级）", "牡丹盆栽（5级）",
            "兔子房（1级）", "兔子房（2级）", "兔子房（3级）", "兔子房（4级）", "兔子房（5级）",
            "栏杆（1级）", "栏杆（2级）", "栏杆（3级）", "栏杆（4级）", "栏杆（5级）",
            "月季（1级）", "月季（2级）", "月季（3级）", "月季（4级）", "月季（5级）",
            "架子床（1级）", "架子床（2级）", "架子床（3级）", "架子床（4级）", "架子床（5级）",
            "八仙桌（1级）", "八仙桌（2级）", "八仙桌（3级）", "八仙桌（4级）", "八仙桌（5级）",
            "条案（1级）", "条案（2级）", "条案（3级）", "条案（4级）", "条案（5级）",
            "木几（1级）", "木几（2级）", "木几（3级）", "木几（4级）", "木几（5级）",
            "木椅（1级）", "木椅（2级）", "木椅（3级）", "木椅（4级）", "木椅（5级）",
            "木凳（1级）", "木凳（2级）", "木凳（3级）", "木凳（4级）", "木凳（5级）",
            "木柜架（1级）", "木柜架（2级）", "木柜架（3级）", "木柜架（4级）", "木柜架（5级）",
            "素云屏（1级）", "素云屏（2级）", "素云屏（3级）", "素云屏（4级）", "素云屏（5级）",
            "木灯台（1级）", "木灯台（2级）", "木灯台（3级）", "木灯台（4级）", "木灯台（5级）",
            "盆景（1级）", "盆景（2级）", "盆景（3级）", "盆景（4级）", "盆景（5级）",
            "隔断（1级）", "隔断（2级）", "隔断（3级）", "隔断（4级）", "隔断（5级）",
            "金线毯（1级）", "金线毯（2级）", "金线毯（3级）", "金线毯（4级）", "金线毯（5级）",
        }

        local currNum = DataPool:GetBaseBag_RealMaxNum();
        local pos = ""
        for i=1, currNum do
            local theAction,bLocked = PlayerPackage:EnumItem("base", i-1);
			if theAction:GetID() ~= 0 then
				local sName = theAction:GetName();
				for  k, v in furnitureList do
					if string.find(sName, v) then
						pos = pos .. tostring(i) .. '|'
					end
				end
			end

        end
        return pos
    ]])

    local posList = StringSplit(tmp, "|")
    for k, v in pairs(posList) do
        if v ~= "|" then
            local row = math.floor(tonumber(v) / 10)
            local col = math.floor(tonumber(v) % 10)
            if col == 0 then
                col = 10
            else
                row = row + 1
            end

            LUA_Call(string.format([[
                setmetatable(_G, {__index = Packet_Env});Packet_ItemBtnClicked(%d,%d);
            ]], row, col))

            延时(1000)
            LUA_Call([[setmetatable(_G, {__index = BieYeFurnitureReplenish_Env});BieYeFurnitureReplenish_BuyEvent()]])  -- 点击存放
            延时(3000)
        end
    end
    LUA_Call([[setmetatable(_G, {__index = BieYeFurnitureReplenish_Env});BieYeFurnitureReplenish_OnCloseClicked()]]) -- 关闭
    延时(500)
    LUA_Call([[setmetatable(_G, {__index = BieYeFurnitureBank_Env});BieYeFurnitureBank_Close_Clicked()]]) -- 关闭
end

function 回自己庄园()
    if 当前所在地图 == "大理" then
        跨图寻路("大理", 211, 194)
        延时(2000)
        对话NPC("金五爷")
    elseif 当前所在地图 == "洛阳" then
        跨图寻路("洛阳", 194, 287)
        延时(2000)
        对话NPC("李萱萱")
    elseif 当前所在地图 == "楼兰" then
        跨图寻路("楼兰", 207, 129)
        延时(2000)
        对话NPC("李涟漪")
    else
        跨图寻路("苏州", 200, 284)
        延时(2000)
        对话NPC("李紫熏")
    end

    延时(500)
    NPC二级对话("单人进入庄园")
    延时(2000)

    if 人物名称 == "′星．" then
        屏幕提示("进入配偶的庄园")
        NPC二级对话("进入配偶的庄园")
    elseif 人物名称 == "′露．" then
        屏幕提示("进入配偶的庄园")
        NPC二级对话("进入配偶的庄园")
    else
        屏幕提示("进入我的庄园")
        NPC二级对话("进入我的庄园")
    end

    延时(15000)

    右键使用物品("庄园福运宝箱（5级）", 1)
    右键使用物品("庄园福运宝箱（4级）", 1)
    右键使用物品("庄园福运宝箱（3级）", 1)
    右键使用物品("庄园福运宝箱（2级）", 1)
    右键使用物品("庄园福运宝箱（1级）", 1)
    延时(1000)
    SaveFurniture()

end

回自己庄园()