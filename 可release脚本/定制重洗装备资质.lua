装备名字 = "佛语"   -- TODO 每次都需要修改装备名字，只能指定一个装备，可以截取装备名字中的某几个连续字符串

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

function equipIdentify(equipPos)
    -- 装备资质鉴定
    LUA_Call(string.format([[
        local Identify_Item = %d
        Clear_XSCRIPT();
            Set_XSCRIPT_Function_Name("FinishAdjust");
            Set_XSCRIPT_ScriptID(809261);
            Set_XSCRIPT_Parameter(0,Identify_Item);
            Set_XSCRIPT_ParamCount(1);
        Send_XSCRIPT();
    ]], equipPos))
end


function GetOldLagerZiZhi(equipPos)
    local equipBindStatus = LUA_取返回值(string.format([[
        local Identify_Item = %d
        local equipBindStatus = PlayerPackage:GetItemBindStatusByIndex(Identify_Item);
        return equipBindStatus
    ]], equipPos))
    if tonumber(equipBindStatus) ~= 1 then
        MentalTip("当前装备不是已绑定装备, 不重新鉴定资质")
        return 1
    end

    local oldLagerZZ = LUA_取返回值(string.format([[
        Identify_Item = %d
        local g_ZiZhiName = {
            [0] = "外攻资质",
            [1] = "外防资质",
            [2] = "内攻资质",
            [3] = "内防资质",
            [4] = "闪避资质",
            [5] = "命中资质",
        }
        local oldType1,oldValue1,oldType2,oldValue2 = DataPool : GetEquipZiZhi(Identify_Item);
        local oldLagerZiZhi = oldValue1
        if oldType1 ~= nil and oldType2 ~= nil then
            if oldValue2 > oldValue1 then
                oldLagerZiZhi = oldValue2
            end
        elseif oldType1 == nil and oldType1 == nil then
            return -1
        end

        if oldLagerZiZhi == 60 then
            return -1
        end
        return oldLagerZiZhi
    ]], equipPos))

    return tonumber(oldLagerZZ)
end

function GetNewLagerZiZhi(equipPos)
    local newLagerZZ = LUA_取返回值(string.format([[
        local Identify_Item = %d

        local oldType1,oldValue1,oldType2,oldValue2 = DataPool : GetEquipZiZhi(Identify_Item);
        local oldLagerZiZhi = oldValue1
        if oldType1 ~= nil and oldType2 ~= nil then
            if oldValue2 > oldValue1 then
                oldLagerZiZhi = oldValue2
            end
        end

        local str =  DataPool : GetEquipZiZhiRefreshDesc(Identify_Item);
        local type1,value1,type2,value2 = DataPool : GetEquipZiZhiCompare(Identify_Item);

        local newLagerZiZhi = -1
        if oldType1 ~= nil and oldType2 ~= nil then
            newValue1 = oldValue1 + value1
            newValue2 = oldValue2 + value2
            newLagerZiZhi = newValue1
            if newValue2 > newValue1 then
                newLagerZiZhi = newValue2
            end
        elseif type2 == nil then
            newLagerZiZhi = oldValue1 + value1
        end
        return newLagerZiZhi
    ]], equipPos))
    return tonumber(newLagerZZ)
end

function ReIdentityZiZhi()
    -- 点击重新鉴定按钮
    LUA_Call([[
        setmetatable(_G, {__index = IdentifyTwice_Env});IdentifyTwice_Buttons_Clicked();
    ]])
end

function ReplaceZiZhi()
    -- 点击替换
    LUA_Call([[
        setmetatable(_G, {__index = IdentifyTwice_Env});IdentifyTwice_SaveChange_Clicked();
    ]])
end


function equipIdentifyTwice(equipPos)
    local oldLagerZZ = GetOldLagerZiZhi(equipPos)
    if oldLagerZZ == -1 then
        MentalTip("该装备无需重新鉴定资质")
        return -1
    end

    ReIdentityZiZhi()   -- 点击重新鉴定
    延时(500)
    local newLagerZZ = GetNewLagerZiZhi(equipPos)
    MentalTip(string.format("该装备原较大资质:【%d】, 新较大资质:【%d】", oldLagerZZ, newLagerZZ))

    if newLagerZZ > oldLagerZZ then
        MentalTip(string.format("该装备新较大资质【%d】比原较大资质【%d】高, 替换为新资质", newLagerZZ, oldLagerZZ))
        ReplaceZiZhi()   -- 点击 替换
    end
    return 1
end

function GetEquipPos(equipNameList)
    local equipIndex = LUA_取返回值(string.format([[
        local targetItemName = "%s"
        local currNum = DataPool:GetBaseBag_Num();
        for i=1, currNum do
            local theAction,bLocked = PlayerPackage:EnumItem("base", i-1);
            if theAction:GetID() ~= 0 then
                local itemName = theAction:GetName()   -- 物品名字
                if string.find(itemName, targetItemName) then
                    return i
                end
            end
        end
        return -1
    ]], equipNameList))
    return tonumber(equipIndex)
end

function RightClick(equipPos)
    local row = math.floor(tonumber(equipPos) / 10)
    local col = math.floor(tonumber(equipPos) % 10)
    if col == 0 then
        col = 10
    else
        row = row + 1
    end

    -- 右键使用
    LUA_Call(string.format([[setmetatable(_G, {__index = Packet_Env});Packet_ItemBtnClicked(%d,%d);]], row, col))
end

-- Main ------------------------------------------------------------------------------------------------------------
MentalTip(string.format("只有背包金刚砂、金刚锉耗尽,或洗到60%,才退出"))
MentalTip(string.format("只有背包金刚砂、金刚锉耗尽,或洗到60%,才退出"))
MentalTip(string.format("即将重新鉴定装备【%s】", 装备名字))
取出物品("金刚锉|金刚砂")
MoveToPos("苏州", 354, 234)
延时(2000)
对话NPC("欧冶子")
延时(500)
NPC二级对话("重新鉴定装备资质")
延时(1000)
local equipPos = GetEquipPos(装备名字)
if equipPos == -1 then
    MentalTip(string.format("背包中没有装备【%s】", 装备名字))
else
    local equipIndex = equipPos -1
    RightClick(equipPos)
    延时(1000)

    while true do
        if (获取背包物品数量("金刚砂") + 获取背包物品数量("金刚锉")) <= 0 then
            break
        end
        local ret = equipIdentifyTwice(equipIndex)
        if ret == -1 then
            break
        end
        延时(500)
    end
end