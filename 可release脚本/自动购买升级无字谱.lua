--1是 其他否
自动穿戴 = 0
先脱光再穿 = 0
心决穿戴 = { "高门·属性", "遣美·属性", "投巫·属性", "巾帼·属性" }
秘技穿戴 = { "龟寿千年", "青眼有加", "投壶问月", "75层秘技" }

--最高属性超过1000按最高 低于1000按设定
_menPaiAttrList = {
    ["少林"] = "玄",
    ["明教"] = "火",
    ["丐帮"] = "毒",
    ["武当"] = "冰",
    ["峨嵋"] = "玄",
    ["星宿"] = "毒",
    ["天龙"] = "玄",
    ["天山"] = "冰",
    ["逍遥"] = "火",
    ["慕容"] = "玄",
    ["唐门"] = "毒",
    ["鬼谷"] = "玄",
    ["桃花岛"] = "冰",
    ["绝情谷"] = "火",
}
心决升级表 = {

    "高门·属性",
    "遣美·属性",
    "投巫·属性",
    "听镜",
    "巾帼·属性",

    --主属性升级完 按顺序升级
    "巾帼·冰",
    "巾帼·火",
    "巾帼·玄",
    "巾帼·毒",
    "伤魂",
    "祯祥",
    "遣美·冰",
    "遣美·火",
    "遣美·玄",
    "遣美·毒",
    "高门·冰",
    "高门·火",
    "高门·玄",
    "高门·毒",
    "投巫·冰",
    "投巫·火",
    "投巫·玄",
    "投巫·毒",
    "捧心·冰",
    "捧心·火",
    "捧心·玄",
    "捧心·毒",
    "誓江·冰",
    "誓江·火",
    "誓江·玄",
    "誓江·毒",
    "还珠·冰",
    "还珠·火",
    "还珠·玄",
    "还珠·毒"
}

g_ID = -1

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
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

function initialWZP(xinJueName)
    local ret = LUA_取返回值(string.format([[
        local name = "%s"
        for i = 1, 98 do
            if DataPool:LuaFnGetXingJuanInfo(i, 'Name') == name then
                g_ID = i
                return g_ID
            end
        end
        return false
    ]], xinJueName))
    if ret == 'false' then
        return false
    else
        g_ID = tonumber(ret)
        return true
    end
end

function multiUseClick()
    LUA_Call([[
        if IsWindowShow("Item_MultiUse") then
            Item_MultiUse_BuyMulti_Clicked()
        end
    ]])
end

function getPlayerMainAttr()
    local mainAttrStr = LUA_取返回值([[
        local a = Player:GetData("ATTACKCOLD");
        local b = Player:GetData("ATTACKFIRE");
        local c = Player:GetData("ATTACKLIGHT");
        local d = Player:GetData("ATTACKPOISON");
        if a > b and a > c and a > d then
            return "冰" .. "|" .. a
        elseif b > a and b > c and b > d then
            return "火" .. "|" .. b
        elseif c > a and c > b and c > d then
            return "玄" .. "|" .. c
        elseif d > a and d > c and d > b then
            return "毒" .. "|" .. d
        else
            return "未知" .. "|" .. "-1"
        end
    ]])
    local mainAttrList = StringSplit(mainAttrStr, '|')
    local mainAttr, attrValue = mainAttrList[1], mainAttrList[2]
    return mainAttr, tonumber(attrValue)
end

function LevelUpXinJue()
    local ret = LUA_取返回值(string.format([[
        local g_ID = %d

        --0结束 1继续升级 2升级下一个
        local jie = -1
        if DataPool:LuaFnGetXingJuanInfo(g_ID, 'UnLocked') == 1 then
            jie = DataPool:LuaFnGetXingJuanInfo(g_ID, 'Order')
        end
        if jie == 5 then
            return 2
        end

        local name = DataPool:LuaFnGetXingJuanInfo(g_ID, 'Name')
        local ji = DataPool:LuaFnGetXingJuanInfo(g_ID, 'Level')
        local Chip = DataPool:LuaFnGetXingJuanInfo(g_ID, 'ChipCount')
        local exp = Player:GetData('XJSTOREEXP')
        local money = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
        local need_exp, need_money, need_Chip = 0, 0, 0

        if jie == -1 then
            if g_ID >= 19 and g_ID <= 36 then
                need_Chip = 40
            elseif g_ID >= 37 and g_ID <= 64 then
                need_Chip = 35
            elseif g_ID >= 65 and g_ID <= 98 then
                need_Chip = 30
            end
        elseif ji == 10 then
            need_Chip, need_money = DataPool:LuaFnGetXingJuanOrderNeed(g_ID, jie + 1)
        else
            need_exp, need_money = DataPool:LuaFnGetXingJuanLevelNeed(g_ID, jie, ji)
        end
        if need_exp > exp then
            PushDebugMessage("【温馨提示】" .. name .. " 心决体悟不足")
            return 0
        elseif need_money > money then
            PushDebugMessage("【温馨提示】" .. name .. " 金币不足")
            return 0
        elseif need_Chip > Chip then
            PushDebugMessage("【温馨提示】" .. name .. " 残印不足")
            return 2
        else
            if jie == -1 then
                Clear_XSCRIPT();
                Set_XSCRIPT_Function_Name("ActiveXingJuan");
                Set_XSCRIPT_ScriptID(888555);
                Set_XSCRIPT_Parameter(0, g_ID);
                Set_XSCRIPT_Parameter(1, 1);
                Set_XSCRIPT_ParamCount(2);
                Send_XSCRIPT();
            elseif ji == 10 then
                Clear_XSCRIPT();
                Set_XSCRIPT_Function_Name("XingJuanLevelUp");
                Set_XSCRIPT_ScriptID(888555);
                Set_XSCRIPT_Parameter(0, g_ID);
                Set_XSCRIPT_Parameter(1, 1);
                Set_XSCRIPT_ParamCount(2);
                Send_XSCRIPT();
            else
                Clear_XSCRIPT();
                Set_XSCRIPT_Function_Name("XingJuanLevelUp");
                Set_XSCRIPT_ScriptID(888555);
                Set_XSCRIPT_Parameter(0, g_ID);
                Set_XSCRIPT_Parameter(1, 0);
                Set_XSCRIPT_ParamCount(2);
                Send_XSCRIPT();
            end
            return 1
        end
    ]], g_ID))
    return tonumber(ret)
end

function GetNeedBuyCYCount()
    local needBuyCount = LUA_取返回值(string.format([[
        local g_ID = %d
        local name = DataPool:LuaFnGetXingJuanInfo(g_ID, 'Name')
        local Order = 0

        if DataPool:LuaFnGetXingJuanInfo(g_ID, 'UnLocked') ~= 1 then
            Order = -1
        else
            Order = DataPool:LuaFnGetXingJuanInfo(g_ID, 'Order')
        end

        if Order == 5 then
            PushDebugMessage("【" .. name .. "】" .. "已满阶")
            return 0
        end

        local Level = DataPool:LuaFnGetXingJuanInfo(g_ID, 'Level')
        local ChipCount = DataPool:LuaFnGetXingJuanInfo(g_ID, 'ChipCount')
        local EXP = Player:GetData('XJSTOREEXP')
        local SHANHAIBI = Player:GetData('SHANHAIBI')
        local MAXLimit = 0
        local a, b, c, d, e, f, g, h, j = Player:GetData('SHShopLimit')

        if g_ID >= 19 and g_ID <= 36 then
            MAXLimit = 8 - c
        elseif g_ID >= 37 and g_ID <= 64 then
            MAXLimit = 40 - b
        elseif g_ID >= 65 and g_ID <= 98 then
            MAXLimit = 120 - a
        end

        if MAXLimit == 0 then
            return 0
        end

        local price = 0

        local needtab = {}

        if g_ID >= 19 and g_ID <= 36 then
            needtab = { 80, 40, 34, 27, 19, 10 }
            price = 250
        elseif g_ID >= 37 and g_ID <= 64 then
            needtab = { 70, 35, 30, 24, 17, 9 }
            price = 50
        elseif g_ID >= 65 and g_ID <= 98 then
            needtab = { 60, 30, 26, 21, 15, 8 }
            price = 20
        else
            return 0
        end
        local need_chip = needtab[Order + 2]
        local maxbuy = math.floor(SHANHAIBI / price)
        if ChipCount >= need_chip or maxbuy == 0 then
            return 0
        end
        PushDebugMessage("【温馨提示】" .. name .. " 需要[" .. need_chip .."] 单价[" .. price .. "] 限购[" .. MAXLimit .."] 已有[" .. ChipCount .. "]")
        need_chip = need_chip - ChipCount
        if MAXLimit < need_chip then
            need_chip = MAXLimit
        end
        if maxbuy < need_chip then
            need_chip = maxbuy
        end
        PushDebugMessage("【温馨提示】" .. name .. " 最终购买数量[" .. need_chip .. "]")
        return need_chip
    ]], g_ID))
    return tonumber(needBuyCount)
end

function BuyXinJueCY(needBuyCount)
    LUA_取返回值(string.format([[
        local g_ID = %d
        local Num = %d
        local Name = DataPool:LuaFnGetXingJuanInfo(g_ID, 'Name') .. "残印"
        for i = 0, 67 do
            local theAction = EnumAction(i, "boothitem")
            if theAction:GetID() ~= 0 and theAction:GetName() == Name then
                NpcShop:BulkBuyItem(i, Num, 0)
                return
            end
        end
    ]], g_ID, needBuyCount))
end

function wear(xinJueName, index)
    LUA_取返回值(string.format([[
        local Name, wz = "%s", "%s"
        for o = 1, 98 do
            if DataPool:LuaFnGetXingJuanInfo(o, 'Name') == Name then
                Clear_XSCRIPT();
                Set_XSCRIPT_Function_Name("InsertSlot");
                Set_XSCRIPT_ScriptID(888555);
                Set_XSCRIPT_Parameter(0, o);
                Set_XSCRIPT_Parameter(1, wz);
                Set_XSCRIPT_Parameter(2, 0);
                Set_XSCRIPT_ParamCount(3);
                Send_XSCRIPT();
                return
            end
        end
        for i = 1, 46 do
            if DataPool:LuaFnGetSkillCardInfo(i, "Level") ~= 0 then
                if DataPool:LuaFnGetSkillCardInfo(i, "Name") == Name then
                    Clear_XSCRIPT();
                    Set_XSCRIPT_Function_Name("InsertSlot");
                    Set_XSCRIPT_ScriptID(888555);
                    Set_XSCRIPT_Parameter(0, i);
                    Set_XSCRIPT_Parameter(1, wz);
                    Set_XSCRIPT_Parameter(2, 1);
                    Set_XSCRIPT_ParamCount(3);
                    Send_XSCRIPT();
                    return
                end
            end
        end
    ]], xinJueName, index))

end

function DownAllXinJue()
    LUA_Call([[
        for i = 1, 4 do
            local a = DataPool:LuaFnGetActivedXingJuanID(i)
            if a ~= 0 then
                Clear_XSCRIPT();
                Set_XSCRIPT_Function_Name("InsertSlot");
                Set_XSCRIPT_ScriptID(888555);
                Set_XSCRIPT_Parameter(0, a);
                Set_XSCRIPT_Parameter(1, 0);
                Set_XSCRIPT_Parameter(2, 0);
                Set_XSCRIPT_ParamCount(3);
                Send_XSCRIPT();
            end
        end
    ]])
end

function useXinJueCY(xinJueCYName)
    if 获取背包物品数量(xinJueCYName .. "残印") ~= 0 then
        右键使用物品(xinJueCYName .. "残印")
        延时(1000)
        multiUseClick()
        延时(1000)
    end
end

function StartUP(xinJueName)
    useXinJueCY(xinJueName)

    if initialWZP(xinJueName) then
        local needBuyCYCount = GetNeedBuyCYCount()

        if needBuyCYCount > 0 then
            if 窗口是否出现("NewDungeon_DaibiShop") ~= 1 then
                跨图寻路("大理", 212, 52)
                延时(500)
                对话NPC("沈寒洲")
                延时(1000)
                NPC二级对话("归山阁")
                延时(1000)
            end

            BuyXinJueCY(needBuyCYCount)
            延时(1500)

            useXinJueCY(xinJueName)

        end

        while true do
            local ret = LevelUpXinJue()
            if ret == 0 then
                return false
            elseif ret == 2 then
                return true
            end
            延时(300)
        end

    else
        MentalTip(xinJueName .. "失败")
        return true
    end
end



-- 主函数, 执行区域 -----------------------------------------------------------------------------------------

if 判断通过安全验证() ~= 1 then
    屏幕提示("没解锁, 请先解锁")
    return
end

local _, menPai = 获取人物属性()

local menPaiAttr = _menPaiAttrList[menPai]

local myMainAttr, myMainAttrVal = getPlayerMainAttr()

if myMainAttrVal < 1000 then
    if menPaiAttr then
        myMainAttr = menPaiAttr
        MentalTip("最高属性不足1000点, 根据门派优先升级" .. myMainAttr)
    end
end
MentalTip(string.format("您的主属性是: %s", myMainAttr))

取出物品("金币")

取出物品("精品心决集录|珍品心决集录|良品心决集录")

local xinJueJiLu = {
    "精品心决集录",
    "珍品心决集录",
    "良品心决集录",
}

for i = 1, #xinJueJiLu do
    if 获取背包物品数量(xinJueJiLu[i]) ~= 0 then
        右键使用物品(xinJueJiLu[i])
        延时(1000)
        multiUseClick()
        延时(1000)
    end
end

for i = 1, #心决升级表 do
    local xinJueName = 心决升级表[i]
    if string.find(xinJueName, "属性") then
        xinJueName = string.gsub(xinJueName, "属性", myMainAttr)
    end

    if StartUP(xinJueName) == false then
        break
    end
    延时(300)

end

if 自动穿戴 == 1 then
    if 先脱光再穿 == 1 then
        DownAllXinJue()
        延时(1000)
    end

    for i = 1, 4 do
        local wearXinJueName = 心决穿戴[i]
        if wearXinJueName then
            if string.find(wearXinJueName, "属性") then
                wearXinJueName = string.gsub(wearXinJueName, "属性", myMainAttr)
            end
            wear(wearXinJueName, i)
            延时(300)
        end

        local wearMJName = 秘技穿戴[i]
        if wearMJName then
            if wearMJName == "75层秘技" then
                if myMainAttr == "冰" then
                    wearMJName = "三尺冰冻"
                elseif myMainAttr == "火" then
                    wearMJName = "烈火灼心"
                elseif myMainAttr == "玄" then
                    wearMJName = "铁锁横江"
                elseif myMainAttr == "毒" then
                    wearMJName = "妇人之毒"
                end
            end
            wear(Name, i)
            延时(300)
        end
    end
end

存物品("金币")