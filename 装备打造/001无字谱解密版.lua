--1是 其他否
开始之前取钱 = 1
自动穿戴 = 1
先脱光再穿 = 1
结束后存金币 = 1
心决穿戴 = { "高门·属性", "遣美·属性", "投巫·属性", "巾帼·属性" }
秘技穿戴 = { "龟寿千年", "青眼有加", "投壶问月", "75层秘技" }

--最高属性超过1000按最高 低于1000按设定
_主属性 = {
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
升级表 = {

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
    "还珠·毒",
    "呼庙",
    "泣玉",
    "听镜",
    "坐啸",
    "当垆",
    "燕然",
    "望洋",
    "川上",
    "刻木",
    "捷对",
    "昏雨",
    "七步",
    "掷水",
    "姑射",
    "断机",
    "咏絮",
    "泛湖",
    "涌泉",
    "博望",
    "拜幕",
    "非次",
    "负鼎",
    "渡江",
    "持节",
    "三味",
    "泣岐",
    "吐屑",
    "尹京",
    "让梨",
    "辩日",
    "云梯",
    "黄雀",
    "体轻",
    "止啼",
    "悲扇",
    "青衫",
    "折巾",
    "落帽",
}

--微信[TL7665]

--23年3月30日



if 判断通过安全验证()~=1 then

    屏幕提示("没解锁")

    return

end

LUA_取返回值([[


function retn(...)
    local ret = "return "
    for i = 1, table.getn(arg) do
        if type(arg[i]) == "number" then
            ret = ret .. tostring(arg[i])
        elseif type(arg[i]) == "string" then
            ret = ret .. "'" .. tostring(arg[i]) .. "'"
        elseif type(arg[i]) == "nil" then
            ret = ret .. "nil"
        elseif type(arg[i]) == "boolean" then
            if arg[i] then
                ret = ret .. "true"
            else
                ret = ret .. "false"
            end
        end

        if i ~= table.getn(arg) then
            ret = ret .. ","
        end
    end

    return ret
end

local function PushDebugMessageEx(str)
    PushDebugMessage(string.format("%-99s", str))
end

local g_ID = -1

function VX_TL7665(...)
    if arg[1] == "初始化" then
        local name = arg[2]
        for o = 1, 98 do
            if DataPool:LuaFnGetXingJuanInfo(o, 'Name') == name then
                g_ID = o
                return retn(true)
            end
        end
        return retn(false)
    elseif arg[1] == "批量使用" then
        if IsWindowShow("Item_MultiUse") then
            Item_MultiUse_BuyMulti_Clicked()
        end
    elseif arg[1] == "获取主属性" then
        local a = Player:GetData("ATTACKCOLD");
        local b = Player:GetData("ATTACKFIRE");
        local c = Player:GetData("ATTACKLIGHT");
        local d = Player:GetData("ATTACKPOISON");
        if a > b and a > c and a > d then
            return retn("冰", a)
        elseif b > a and b > c and b > d then
            return retn("火", b)
        elseif c > a and c > b and c > d then
            return retn("玄", c)
        elseif d > a and d > c and d > b then
            return retn("毒", d)
        else
            return retn("未知", -1)
        end
    elseif arg[1] == "升级" then
        --0结束 1继续升级 2升级下一个
        local jie = -1
        if DataPool:LuaFnGetXingJuanInfo(g_ID, 'UnLocked') == 1 then
            jie = DataPool:LuaFnGetXingJuanInfo(g_ID, 'Order')
        end
        if jie == 5 then
            return retn(2)
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
            PushDebugMessageEx(string.format("【微信TL7665】  %-12s 体悟不足", name))
            return retn(0)
        elseif need_money > money then
            PushDebugMessageEx(string.format("【微信TL7665】  %-12s 金币不足", name))
            return retn(0)
        elseif need_Chip > Chip then
            PushDebugMessageEx(string.format("【微信TL7665】  %-12s 残印不足", name))
            return retn(2)
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
            return retn(1)
        end
    elseif arg[1] == "需要购买数量" then
        local name = DataPool:LuaFnGetXingJuanInfo(g_ID, 'Name')
        local Order = 0

        if DataPool:LuaFnGetXingJuanInfo(g_ID, 'UnLocked') ~= 1 then
            Order = -1
        else
            Order = DataPool:LuaFnGetXingJuanInfo(g_ID, 'Order')
        end

        if Order == 5 then
            PushDebugMessageEx(string.format("【微信TL7665】  %-12s 已满阶", name))
            return retn(0)
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
            return retn(0)
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
            return retn(0)
        end
        local need_chip = needtab[Order + 2]
        local maxbuy = math.floor(SHANHAIBI / price)
        if ChipCount >= need_chip or maxbuy == 0 then
            return retn(0)
        end
        PushDebugMessageEx(string.format("【微信TL7665】  %-12s 需要[%d] 单价[%d] 限购[%d] 已有[%d]", name, need_chip, price, MAXLimit, ChipCount))
        need_chip = need_chip - ChipCount
        if MAXLimit < need_chip then
            need_chip = MAXLimit
        end
        if maxbuy < need_chip then
            need_chip = maxbuy
        end
        PushDebugMessageEx(string.format("【微信TL7665】  %-12s 最终购买数量[%d]", name, need_chip))
        return retn(need_chip)
    elseif arg[1] == "购买" then
        local Num = arg[2]
        local Name = DataPool:LuaFnGetXingJuanInfo(g_ID, 'Name') .. "残印"
        for i = 0, 67 do
            local theAction = EnumAction(i, "boothitem")
            if theAction:GetID() ~= 0 and theAction:GetName() == Name then
                NpcShop:BulkBuyItem(i, Num, 0)
                return
            end
        end
    elseif arg[1] == "脱光" then
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
    elseif arg[1] == "穿戴" then
        local Name, wz = arg[2], arg[3]
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
    end
end


]])

local function 微信TL7665(...)

    local a = {...}

    if a==nil then return end

    local str = "return VX_TL7665('"..a[1].."'"

    for i=2,#a do
        if type(a[i])=="string" then
            str = str .. ",'" .. tostring(a[i]) .. "'"
        else
            str = str .. "," .. tostring(a[i])
        end
    end

    str = str .. ");"

    local ret = LUA_取返回值(str)

    if ret and string.find(ret,"return") then
        return loadstring(ret)()
    else
        return ret
    end

end



local function 吃残印(Name)

    if 获取背包物品数量(Name.."残印")~=0 then

        右键使用物品(Name.."残印") 延时(1000)

        微信TL7665("批量使用") 延时(1000)

    end

end

local function StartUP(Name)

    吃残印(Name)

    if 微信TL7665("初始化",Name) then

        local Num = 微信TL7665("需要购买数量")

        if Num>0 then

            if 窗口是否出现("NewDungeon_DaibiShop")~=1 then

                跨图寻路("大理", 212, 52) 延时(500)

                对话NPC("沈寒洲") 延时(1000)

                NPC二级对话("归山阁") 延时(1000)

            end

            微信TL7665("购买",Num) 延时(1500)

            吃残印(Name)

        end

        while true do

            local ret = 微信TL7665("升级")

            if ret==0 then

                return false

            elseif ret==2 then

                return true

            end

            延时(300)

        end

    else

        屏幕提示(Name.."失败")

        return true

    end

end

local 人物名称,门派 = 获取人物属性()

local 门派主属性 = _主属性[门派]

local 主属性,值 = 微信TL7665("获取主属性")

if 值<1000 then

    if 门派主属性 then

        主属性 = 门派主属性

        屏幕提示("最高属性不足1000点 根据门派优先升级"..主属性)

    end

end

屏幕提示("主属性 : "..主属性) 延时(1000)

if 开始之前取钱==1 then

    取出物品("金币")

end

取出物品("精品心决集录|珍品心决集录|良品心决集录")

local 集录 = {

    "精品心决集录",

    "珍品心决集录",

    "良品心决集录",

}

for i=1,#集录 do

    if 获取背包物品数量(集录[i])~=0 then
        右键使用物品(集录[i]) 延时(1000)
        微信TL7665("批量使用") 延时(1000)
    end
end

for i=1,#升级表 do
    local Name = 升级表[i]
    if string.find(Name,"属性") then
        Name = string.gsub(Name,"属性",主属性)
    end

    if StartUP(Name)==false then
        break
    end
    延时(300)

end

if 自动穿戴==1 then
    if 先脱光再穿==1 then
        微信TL7665("脱光")延时(1000)
    end

    for i=1,4 do
        local Name = 心决穿戴[i]
        if Name then
            if string.find(Name,"属性") then
                Name = string.gsub(Name,"属性",主属性)
            end
            微信TL7665("穿戴",Name,i) 延时(300)
        end

        local Name = 秘技穿戴[i]
        if Name then
            if Name=="75层秘技" then
                if 主属性=="冰" then
                    Name = "三尺冰冻"
                elseif 主属性=="火" then
                    Name = "烈火灼心"
                elseif 主属性=="玄" then
                    Name = "铁锁横江"
                elseif 主属性=="毒" then
                    Name = "妇人之毒"
                end
            end
            微信TL7665("穿戴",Name,i) 延时(300)
        end
    end
end

if 结束后存金币==1 then
    存物品("金币")
end
