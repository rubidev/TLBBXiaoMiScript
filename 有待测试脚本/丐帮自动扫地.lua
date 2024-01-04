skillList = {
    "龙战于野", "横扫乾坤"
}

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

function UseTuLingZhuTransmit()
    -- 使用土灵珠传送
    if 获取背包物品数量("土灵珠") > 0 then
        坐骑_下坐骑();

        右键使用物品("土灵珠", 1);   -- 默认使用第一个
        延时(1000)
        while true do
            if 窗口是否出现("Item_TuDunZhu") == 1 then
                LUA_Call("setmetatable(_G, {__index = Item_TuDunZhu_Env});Item_TuDunZhu_Cancel_Clicked(1);");
                break
            end
            延时(500)
        end
        延时(2000)
    end
end

function GetTLZPos(TLZName, TLZNum)
    return LUA_取返回值(string.format([[
        local currNum = DataPool:GetBaseBag_Num();
        local TLZName = "%s"
        local TLCNum = %d
        local TLZCount = 0
        for i=1, currNum do
            theAction,bLocked = PlayerPackage:EnumItem("base", i-1);  -- szPacketName = "base"、"material"、"quest"
            local sName = theAction:GetName();
            if string.find(TLZName, sName) ~= nil then
                TLZCount = TLZCount + 1
                if TLZCount == TLCNum then
                    return i
                end
            end
        end
        return -1
    ]], TLZName, tonumber(TLZNum)))
end

function UseTuLingZhuPositioning()
    -- 使用土灵珠定位
    -- 定位第1个土灵珠
    if 获取背包物品数量("土灵珠") > 0 then
        右键使用物品("土灵珠", 1);
        延时(1000)
        if 窗口是否出现("Item_TuDunZhu") == 1 then
            LUA_Call("setmetatable(_G, {__index = Item_TuDunZhu_Env});Item_TuDunZhu_OK_Clicked();")
            延时(1000)
            LUA_Call("setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();")
        end
    end
    延时(1000)

    -- 定位第2个土灵珠
    local secondTLZPos = GetTLZPos("土灵珠", 2)
    if tonumber(secondTLZPos) == -1 then
        return
    end

    local row = math.floor(tonumber(secondTLZPos) / 10)
    local col = math.floor(tonumber(secondTLZPos) % 10)
    if col == 0 then
        col = 10
    else
        row = row + 1
    end
    LUA_Call(string.format([[setmetatable(_G, {__index = Packet_Env});Packet_ItemBtnClicked(%d,%d);]], row, col))
    延时(1000)
    if 窗口是否出现("Item_TuDunZhu") == 1 then
        LUA_Call("setmetatable(_G, {__index = Item_TuDunZhu_Env});Item_TuDunZhu_OK_Clicked();")
        延时(1000)
        LUA_Call("setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();")
    end
end

while true do
    if 获取背包物品数量("土灵珠") > 0 then
        UseTuLingZhuPositioning()
    end

    for _, skillName in pairs(skillList) do
        if 判断技能冷却(skillName) == 1 then
            坐骑_下坐骑()
            延时(100)
            local HideSkillID = 获取技能ID(skillName)
            使用技能(HideSkillID)
        end
        延时(200)
    end

    if 判断人物死亡() == 1 then
        LUA_Call([[Player:SendReliveMessage_OutGhost();]])
        出监狱地府()
        出监狱地府()
        if 获取背包物品数量("土灵珠") > 0 then
            UseTuLingZhuTransmit()
            等待过图完毕()
        else
            local pName, pLevel, pMenPai, pHP, pMap, pPosX, pPosY = 组队_获取队员信息(1)
            MoveToPos(pMap, pPosX, pPosY)
        end
    end
end