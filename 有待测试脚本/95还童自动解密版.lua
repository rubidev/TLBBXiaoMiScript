--[微信TL7665]

微信TL7665_还童设置 = {
    珍兽ID = "00AE70B4",
    天书名称 = "超级珍兽还童天书",
    目标成长 = 4, --0普通 1优秀 2杰出 3卓越 4完美
    完成后还给谁 = "半杯蓝山",
    使用非绑定 = false,
    还童位置 = { "洛阳", 270, 306 },
    运行时间限制 = 60 * 60 * 10,
    没有找到人结束 = 15,
}


local 启动时间 = os.time()

local t = 微信TL7665_还童设置

local file = "C:\\天龙小蜜\\TL7665.ini"

local Name = 获取人物属性()

local function 微信TL7665(...)

    local a = { ... }

    if a == nil then
        return
    end

    local str = "return VX_TL7665('" .. a[1] .. "'"

    for i = 2, #a do

        if type(a[i]) == "string" then

            str = str .. ",'" .. tostring(a[i]) .. "'"

        else

            str = str .. "," .. tostring(a[i])

        end

    end

    str = str .. ");"

    local ret = LUA_取返回值(str)

    if string.find(ret, "return") then

        return loadstring(ret)()

    else

        return ret

    end

end

LUA_取返回值([[
    --你好像那大傻逼 没我养活是不能死

    PushDebugMessage("微信TL7665")

    function retn(...)

        local ret = "return "

        for i=1,table.getn(arg) do

            if type(arg[i])=="number" then

                ret = ret .. tostring(arg[i])

            elseif type(arg[i])=="string" then

                ret = ret .. "'" ..tostring(arg[i]) .. "'"

            elseif type(arg[i])=="nil" then

                ret = ret .. "nil"

            elseif type(arg[i])=="boolean" then

                if arg[i] then

                    ret = ret .. "true"

                else

                    ret = ret .. "false"

                end

            end

            if i~=table.getn(arg) then

                ret = ret .. ","

            end

        end

        return ret

    end

    function VX_TL7665(...)

        if arg[1]=="获取id" then

            for i=0,9 do

                if Pet:IsPresent(i) then

                    local strName,strName2,sex = Pet : GetID(i);

                    if strName2==arg[2] then

                        return retn(i)

                    end

                end

            end

            return retn(-1)

        elseif arg[1]=="放入宝宝" then

            Exchange:AddPet(arg[2]);

        elseif arg[1]=="确定交易" then

            if IsWindowShow("Exchange") then

                setmetatable(_G, {__index = Exchange_Env});

                if Exchange:IsLocked("self")==false then

                    Exchange_Lock_Button_Clicked()

                    return

                end

                if Trade_Accept_Button:GetProperty("Disabled")~="True" then

                    Trade_Accept_Button_Clicked()

                    return

                end

            end

        elseif arg[1]=="对方锁定" then

            return retn(Exchange:IsLocked('other'))

        elseif arg[1]=="交易" then

            Target:SelectThePlayer(arg[2])

            if Target:GetName()==arg[2] then

                Exchange:SendExchangeApply();

            end

            return retn(Target:GetName()==arg[2])

        elseif arg[1]=="还童" then

            local g_selidx = arg[2]

            local g_ItemPos = arg[3]

            local nItemID = PlayerPackage : GetItemTableIndex( g_ItemPos )

            local bRet = 0

            local g_HuanTongCJTS = {30503016,30503017,30503018,30503019,30503020}

            for i=1,table.getn(g_HuanTongCJTS) do

                if (g_HuanTongCJTS[i] == nItemID) then

                    bRet = 1

                end

            end

            if (bRet ~= 1) then

                Pet : SkillStudy_Do(2, g_selidx, g_ItemPos)

            else

                local hid,lid = Pet:GetGUID(g_selidx)

                Clear_XSCRIPT()

                    Set_XSCRIPT_Function_Name("OnPropagate")

                    Set_XSCRIPT_ScriptID(311111)

                    Set_XSCRIPT_Parameter(0,49)

                    Set_XSCRIPT_Parameter(1,hid)

                    Set_XSCRIPT_Parameter(2,lid)

                    Set_XSCRIPT_Parameter(3,0)

                    Set_XSCRIPT_Parameter(4,0)

                    Set_XSCRIPT_Parameter(5,g_ItemPos)

                    Set_XSCRIPT_Parameter(6,0)

                    Set_XSCRIPT_ParamCount(7)

                Send_XSCRIPT();

            end

        elseif arg[1]=="鉴定" then

            local idx = arg[2]

            if not Pet:IsPresent(idx) then

                return

            end

            local hid,lid = Pet:GetGUID(idx)

            Clear_XSCRIPT()

                Set_XSCRIPT_Function_Name('OnInquiryForGrowRate')

                Set_XSCRIPT_ScriptID(1050);

                Set_XSCRIPT_Parameter(0,hid);

                Set_XSCRIPT_Parameter(1,lid);

                Set_XSCRIPT_ParamCount(2);

            Send_XSCRIPT();

        elseif arg[1]=="获取成长" then

            local idx = arg[2]

            if not Pet:IsPresent(idx) then

                return retn(-1)

            end

            return retn(Pet:GetPetGrowLevel(idx,tonumber(Pet:GetGrowRate(idx))))

        elseif arg[1]=="交易请求" then

            return retn(Exchange:IsStillAnyAppInList())

        elseif arg[1]=="打开交易" then

            setmetatable(_G, {__index = MainMenuBar_Env});

            MainMenuBar_Exchange_Clicked();

        end

    end

]])

local function 分割文本(szFullString, szSeparator)

    if szFullString == nil or szSeparator == nil then

        return

    end

    local nFindStartIndex = 1

    local nSplitIndex = 1

    local nSplitArray = {}

    while true do

        local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)

        if not nFindLastIndex then

            nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))

            break

        end

        nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)

        nFindStartIndex = nFindLastIndex + string.len(szSeparator)

        nSplitIndex = nSplitIndex + 1

    end

    return nSplitArray

end

local function 获取下一个人()

    跨图寻路(unpack(t.还童位置))

    local ret = 获取周围玩家("", 获取人物信息(7), 获取人物信息(8), 1)

    local 周围玩家 = 分割文本(ret, "|")

    if 周围玩家 == nil then

        return "-1"

    end

    for i = 1, #周围玩家 do

        local _name = 周围玩家[i]

        local time = tonumber(读配置项(file, "PetHuantong", _name, "0"))

        if time + 30 >= os.time() then

            return _name

        end

    end

    return "-1"

end

local function 给下一个人()

    local 下一个计次 = 0

    while (os.time() < 启动时间 + t.运行时间限制) do

        跨图寻路(unpack(t.还童位置))

        local id = 微信TL7665("获取id", t.珍兽ID)

        if id == -1 then

            return

        end

        local 下一个 = 获取下一个人()

        if 下一个 == "-1" then

            下一个计次 = 下一个计次 + 1

            屏幕提示("没有找到下一个人 : " .. 下一个计次)

            if 下一个计次 >= t.没有找到人结束 then

                写配置项(file, "成长", t.珍兽ID, "-2")

                存物品(t.天书名称)

                存物品("金币")

                return

            end

            延时(3000)
        else
            for oo = 1, 10 do
                --给下一个人
                if 窗口是否出现("Exchange") ~= 1 then
                    微信TL7665("交易", 下一个)
                    延时(3000)
                else
                    while 窗口是否出现("Exchange") == 1 do
                        微信TL7665("放入宝宝", id)
                        延时(1000)
                        微信TL7665("放入宝宝", id)
                        延时(1000)
                        微信TL7665("确定交易")
                        延时(1000)
                        微信TL7665("确定交易")
                        延时(1000)
                    end

                    break
                end
            end
        end
    end
end

local function 还给第一个人()
    while (os.time() < 启动时间 + t.运行时间限制) do
        local id = 微信TL7665("获取id", t.珍兽ID)

        if id == -1 then
            return
        end

        跨图寻路(unpack(t.还童位置))

        if 窗口是否出现("Exchange") ~= 1 then
            微信TL7665("交易", t.完成后还给谁)
            延时(3000)
        else

            while 窗口是否出现("Exchange") == 1 do
                微信TL7665("放入宝宝", id)
                延时(1000)
                微信TL7665("放入宝宝", id)
                延时(1000)
                微信TL7665("确定交易")
                延时(1000)
                微信TL7665("确定交易")
                延时(1000)
            end
        end
    end
end

local id = 微信TL7665("获取id", t.珍兽ID)

if (id ~= -1) then
    local 成长 = 微信TL7665("获取成长", id)
    写配置项(file, "成长", t.珍兽ID, tostring(成长))
end

取出物品("金币")

取出物品(t.天书名称)

if t.使用非绑定 == false then
    屏幕提示("不使用可交易的" .. t.天书名称 .. "，存入仓库中。")
    存物品(t.天书名称, nil, 0, 1, 1)
    --参数1：可不填  参数2：可不填 参数3：1、只存绑定 0、不检测 参数4：1、只存不绑 0、不检测 参数5:1、禁止自动存钱
end

while (os.time() < 启动时间 + t.运行时间限制) do
    local id = 微信TL7665("获取id", t.珍兽ID)

    if (id == -1) then
        跨图寻路(unpack(t.还童位置))
        local 成长 = tonumber(读配置项(file, "成长", t.珍兽ID, "0"))
        if 成长 then
            屏幕提示("当前成长率 : " .. 成长)
            if 成长 >= t.目标成长 then
                屏幕提示("成长率已达到要求 结束运行")
                break
            end
        end

        local money = 获取人物信息(45) + 获取人物信息(52)
        if money < 10000 then
            屏幕提示("金币不足 结束运行")
            break
        end

        if 获取背包物品数量(t.天书名称) == 0 then
            屏幕提示("没有天书 结束运行")
            break
        end

        写配置项(file, "PetHuantong", Name, os.time())

        if 微信TL7665("交易请求") then
            微信TL7665("打开交易")
            延时(1200)
            while 窗口是否出现("Exchange") == 1 do
                if 微信TL7665("对方锁定") then
                    延时(1000)
                    微信TL7665("确定交易")
                    延时(1000)
                    微信TL7665("确定交易")
                    延时(1000)
                end
            end
        else
            屏幕提示("珍兽不在我身上 等待交易")
        end
    else
        local money = 获取人物信息(45) + 获取人物信息(52)
        local 成长 = 微信TL7665("获取成长", id)
        写配置项(file, "成长", t.珍兽ID, tostring(成长))

        if 成长 == -1 then
            if money < 10000 then
                屏幕提示("金币不足 给下一个人")
                写配置项(file, "PetHuantong", Name, "0")
                给下一个人()
                break
            end

            微信TL7665("鉴定", id)
            延时(1200)

        elseif 成长 >= t.目标成长 then
            屏幕提示("成长率已达到要求 还给第一个人")
            还给第一个人()
            break
        else
            if money < 10000 then
                屏幕提示("金币不足 给下一个人")
                写配置项(file, "PetHuantong", Name, "0")
                给下一个人()
                break
            end

            if 获取背包物品数量(t.天书名称) == 0 then
                屏幕提示("没有天书 给下一个人")
                写配置项(file, "PetHuantong", Name, "0")
                给下一个人()
                break
            end

            微信TL7665("还童", id, 获取背包物品位置(t.天书名称) - 1)
            延时(1200)

        end
    end
    延时(1000)
end

延时(3000)

while (os.time() < 启动时间 + t.运行时间限制) and Name == t.完成后还给谁 do
    local id = 微信TL7665("获取id", t.珍兽ID)
    if id ~= -1 then
        return
    end

    跨图寻路(unpack(t.还童位置))

    local 成长 = tonumber(读配置项(file, "成长", t.珍兽ID, "0"))

    if 成长 then
        屏幕提示("当前成长率 : " .. 成长)
        if 成长 >= t.目标成长 then
            跨图寻路(unpack(t.还童位置))
            if 微信TL7665("交易请求") then
                微信TL7665("打开交易")
                延时(1200)
                while 窗口是否出现("Exchange") == 1 do
                    if 微信TL7665("对方锁定") then
                        延时(1000)
                        微信TL7665("确定交易")
                        延时(1000)
                        微信TL7665("确定交易")
                        延时(1000)
                    end
                end
            else
                屏幕提示("洗好了 等待珍兽归位")
            end

        elseif 成长 == -2 then
            屏幕提示("没洗出来 不用等了 结束")
            break
        end
    else
        break
    end

    延时(1000)
end

存物品(t.天书名称)

存物品("金币")
