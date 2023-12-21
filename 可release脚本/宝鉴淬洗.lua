local GetLuaValue = LUA_取返回值
local Sleep = 延时
local QuestFrameOptionClicked = NPC二级对话


function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品,必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function MoveToNPC(fx, fy, nId, npc_name)
    while true do
        if nId == 获取人物信息(16) and 计算两点距离(fx, fy, 获取人物信息(7), 获取人物信息(8)) < 5 then
            对话NPC(npc_name)
            Sleep(500)
            return
        else
            跨图寻路(nId, fx, fy)
        end
    end
end

function IsWindowShow(name)
    if tonumber(GetLuaValue("if IsWindowShow('" .. name .. "') then return 1 end return 0", "n", 1)) == 1 then
        return true
    end
    return false
end

local tpname = { "鸾金", "云水", "建木", "天火", "息土", }

function WashBaoYu(baoYuIndex, targetRate)
    local num = 获取背包物品数量("玉华灵泉")
    local n2 = tonumber(GetLuaValue("local num=0 for i=1,5 do num=num+Player:GetFiveElements_JadeExtend(" .. baoYuIndex - 1 .. ",Player:GetFiveElements_JadeType(" .. baoYuIndex - 1 .. ",i-1))end return num", "n", 1))
    local n3 = tonumber(GetLuaValue("return Player:GetData('MONEY')+Player:GetData('MONEY_JZ')", "n", 1))
    MentalTip("晴天|当前序号：" .. baoYuIndex .. " 值：" .. n2 .. "%% 材料数量：" .. num .. " 金币：" .. n3)
    while num >= 5 and n2 < targetRate and n3 >= 10000 do
        if IsWindowShow("EquipBaoJian_Wash") and string.find(GetLuaValue("setmetatable(_G, {__index = EquipBaoJian_Wash_Env})return EquipBaoJian_Wash_DragTitle:GetText()", "s", 1), tpname[baoYuIndex]) then
            MentalTip("淬洗操作：" .. tpname[baoYuIndex])
            GetLuaValue(string.format([[
                baoYuIndex = %d
                Clear_XSCRIPT()
                    Set_XSCRIPT_Function_Name('FiveElementsJadeWash')
                    Set_XSCRIPT_ScriptID(880039)
                    Set_XSCRIPT_Parameter(0, baoYuIndex - 1)
                    Set_XSCRIPT_Parameter(1,2)
                    Set_XSCRIPT_ParamCount(2)
                Send_XSCRIPT()
			]], baoYuIndex))
            Sleep(1000)
            GetLuaValue("setmetatable(_G, {__index = WuhunQuest_Env})if this:IsVisible()then WuhunQuest_Bn1Click()end")
        else
            MoveToNPC(113, 200, "凤鸣镇", "杜钏灵")
            QuestFrameOptionClicked("五行宝玉淬洗")
            Sleep(500)
            QuestFrameOptionClicked(tpname[baoYuIndex] .. "宝玉淬洗")
        end
        Sleep(500)
        num = 获取背包物品数量("玉华灵泉")
        n2 = tonumber(GetLuaValue("local num=0 for i=1,5 do num=num+Player:GetFiveElements_JadeExtend(" .. baoYuIndex - 1 .. ",Player:GetFiveElements_JadeType(" .. baoYuIndex - 1 .. ",i-1))end return num", "n", 1))
        n3 = tonumber(GetLuaValue("return Player:GetData('MONEY')+Player:GetData('MONEY_JZ')", "n", 1))
        MentalTip("当前序号：" .. baoYuIndex .. " 值：" .. n2 .. "%% 材料数量：" .. num .. " 金币：" .. n3)
        Sleep(1000)
    end
end

--"鸾金","云水","建木","天火","息土"
function Wash(addRate)
    WashBaoYu(1, addRate)  -- 鸾金
    WashBaoYu(2, addRate)  -- 云水
    WashBaoYu(3, addRate)  -- 建木
    WashBaoYu(4, addRate)  -- 天火
    WashBaoYu(5, addRate)  -- 息土
end

取出物品("玉华灵泉")
取出物品("金币")
存物品("玉华灵泉", 不存物品, 0, 1, 1)
Wash(30)
Wash(45)
Wash(65)
Wash(80)
Wash(100)

存物品("金币")
