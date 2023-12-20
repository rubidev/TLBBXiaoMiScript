function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品,必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function JudgeHasAgname(Agname)
    -- 判断是否有该称号
    local hasChengHao = LUA_取返回值(string.format([[
        local targetAgname = "%s"
        local nAgnameNum = Player:GetAgnameNum();
        for k=0, nAgnameNum-1 do
            local szAgnameName, _ = Player:EnumAgname(k, "name", 0);
            -- local effect = Player:EnumAgname(k, "effect", 0, 0)
            if string.find(szAgnameName, targetAgname) then
                return 1
            end
        end
        return 0
    ]], Agname))
    return hasChengHao
end

function MoveToNPC(NPCCity, x, y)
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

function Confirm()
    -- TODO
    LUA_Call([[]])
end

function PiaoMiaoFengAgname()
    取出物品("缥缈玄符")
    local AgnameList = { '缥缈之锋芒初现', '缥缈之豪情无双', '缥缈之战无不胜', '缥缈之我意纵横', '缥缈之唯我独尊', '缥缈之独步天下' }
    if tonumber(JudgeHasAgname("缥缈之独步天下")) == 1 then
        MentalTip("您已拥有【缥缈之独步天下】称号, 即将销毁缥缈玄符")
        取出物品("缥缈玄符")
        延时(1000)
        自动清包("缥缈玄符")
    else
        MoveToNPC("楼兰", 193, 224)
        延时(1000)

        for _, agname in pairs(AgnameList) do
            if tonumber(JudgeHasAgname(agname)) ~= 1 then
                对话NPC("程青霜")
                延时(1000)
                NPC二级对话("兑换缥缈峰称号")
                延时(1000)
                NPC二级对话(agname)
                延时(1000)
                Confirm()
            end
        end

    end
end

function BingShengQiZhenAgname()
    local AgnameList = { '侠者仁心', '杀阵行者', '雄才伟略', '先圣遗风', '鬼谷无双' }
    取出物品("征南先锋印")
    if tonumber(JudgeHasAgname("鬼谷无双")) == 1 then
        MentalTip("您已拥有【鬼谷无双】称号, 即将销 征南先锋印")
        取出物品("征南先锋印")
        延时(1000)
        自动清包("征南先锋印")
    else
        MoveToNPC("洛阳", 271, 202)
        延时(1000)

        for _, agname in pairs(AgnameList) do
            if tonumber(JudgeHasAgname(agname)) ~= 1 then
                对话NPC("郭天信")
                延时(1000)
                NPC二级对话("兑换兵圣奇阵称号")  -- TODO
                延时(1000)
                NPC二级对话(agname)
                延时(1000)
                Confirm()
            end
        end
    end
end

function FuDiAgname()
    local AgnameList = { '无量洞天锋芒现', '逍遥仙府武凌云', '琅嬛玉宇纵乾坤', '傲凌天山震九州' }
    取出物品("无崖丹青")
    if tonumber(JudgeHasAgname("傲凌天山震九州")) == 1 then
        MentalTip("您已拥有【鬼谷无双】称号, 即将销 无崖丹青")
        取出物品("无崖丹青")
        延时(1000)
        自动清包("无崖丹青")
    else
        MoveToNPC("大理", 293, 92)
        延时(1000)

        for _, agname in pairs(AgnameList) do
            if tonumber(JudgeHasAgname(agname)) ~= 1 then
                对话NPC("李青萝")
                延时(1000)
                NPC二级对话("兑换琅嬛福地称号")
                延时(1000)
                NPC二级对话(agname)
                延时(1000)
                Confirm()
            end
        end
    end
end

function LaoSanAgname()
    local AgnameList = { '剿匪义士', '破匪侠士', '镇匪英侠', '天下匪见愁' }
    if tonumber(JudgeHasAgname("天下匪见愁")) == 1 then
        MentalTip("您已拥有【天下匪见愁】称号")
    else
        MoveToNPC("苏州", 134, 260)
        延时(1000)

        for _, agname in pairs(AgnameList) do
            if tonumber(JudgeHasAgname(agname)) ~= 1 then
                对话NPC("钱宏宇")
                延时(1000)
                NPC二级对话("领取称号")
                延时(1000)
                NPC二级对话(agname)
                延时(1000)
                Confirm()
            end
        end
    end
end

function FanZeiAgname()
    local AgnameList = { '平贼士兵', '平贼队长', '平贼统领', '荡寇将军', '荡寇元帅' }
    if tonumber(JudgeHasAgname("荡寇元帅")) == 1 then
        MentalTip("您已拥有【荡寇元帅】称号")
    else
        MoveToNPC("洛阳", 296, 243)
        延时(1000)

        for _, agname in pairs(AgnameList) do
            if tonumber(JudgeHasAgname(agname)) ~= 1 then
                对话NPC("钱宏宇")
                延时(1000)
                NPC二级对话("领取称号")
                延时(1000)
                NPC二级对话(agname)
                延时(1000)
                Confirm()
            end
        end
    end
end

function SongLiaoAgname()
    local AgnameList = { '过河卒', '拐脚马', '隔山炮', '纵横車', '国士无双' }
    if tonumber(JudgeHasAgname("国士无双")) == 1 then
        MentalTip("您已拥有【国士无双】称号")
    else
        MoveToNPC("苏州", 192, 144)
        延时(1000)

        for _, agname in pairs(AgnameList) do
            if tonumber(JudgeHasAgname(agname)) ~= 1 then
                对话NPC("刘博")
                延时(1000)
                NPC二级对话("领取称号")  -- TODO
                延时(1000)
                NPC二级对话(agname)
                延时(1000)
                Confirm()
            end
        end
    end
end

function ShuaXingAgname()
    local AgnameList = { '广目天王', '多闻天王', '增长天王', '持国天王' }
    local itemIndex = { 13, 14, 15, 16 }  -- TODO
    if tonumber(JudgeHasAgname("持国天王")) == 1 then
        MentalTip("您已拥有【持国天王】称号")
    else
        MoveToNPC("洛阳", 355, 236)
        延时(1000)

        for index, agname in pairs(AgnameList) do
            if tonumber(JudgeHasAgname(agname)) ~= 1 then
                对话NPC("付云伤")
                延时(1000)
                NPC二级对话("云锦行")
                延时(1000)

                LUA_Call(string.format([[setmetatable(_G, {__index = ActivitySchedule_Shop2_Env});ActivitySchedule_Shop2_Clicked(%d)]], itemIndex[index]))  -- 点击灵兽甲礼盒
                延时(100)
                LUA_Call([[setmetatable(_G, {__index = ActivitySchedule_MBuy2_Env});ActivitySchedule_MBuy2_OK_Clicked();]])  -- 点击购买
            end
        end

        -- TODO
        右键使用物品("称号：")
        右键使用物品("称号：")
        右键使用物品("称号：")
        右键使用物品("称号：")

    end

end

-- main ---------------------------------------------------------------
PiaoMiaoFengAgname()
LaoSanAgname()
FanZeiAgname()
SongLiaoAgname()
BingShengQiZhenAgname()
FuDiAgname()
ShuaXingAgname()
