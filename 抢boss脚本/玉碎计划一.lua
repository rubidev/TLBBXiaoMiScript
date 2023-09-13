团长名字 = "′云．"
组团等待时间 = 120   -- 单位秒

BOSS名称 = "莽牯毒蛤"
BOSS坐标X, BOSS坐标Y = 70, 140

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品,必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function judgeInRaid()
    return LUA_取返回值([[return Player:IsInRaid()]])
end

function GetBossInfo()
    if string.find(BOSS名称, "莽牯毒蛤") then
        return "玄武岛"
    elseif string.find(BOSS名称, "冰妖") then
        return "武夷"
    elseif string.find(BOSS名称, "玄击神将") then
        return "苍山"
    elseif string.find(BOSS名称, "冥虚奴") then
        return "草原"
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

function UseTuLingZhuTransmit()
    -- 使用土灵珠传送
    if 获取背包物品数量("土灵珠") > 0 then
        坐骑_下坐骑();

        右键使用物品("土灵珠", 1);   -- 默认使用第一个
        延时(1000)
        if 窗口是否出现("Item_TuDunZhu") == 1 then
            LUA_Call("setmetatable(_G, {__index = Item_TuDunZhu_Env});Item_TuDunZhu_Cancel_Clicked(1);");
            延时(2000)
        end
    end
end

function UseRoleSkills(RoleSkill, skillTarget)
    -- 使用任务技能
    if tonumber(判断技能冷却(RoleSkill)) == 1 then
        SkillID = 获取技能ID(RoleSkill)
        使用技能(SkillID, skillTarget);
        延时(150)
    end
end

function UseRoleSkillAttack(attackTargetID)
    -- 人物组合技能，并使用
    if 门派 == "逍遥" then
        UseRoleSkills("宇越星现", attackTargetID);
        UseRoleSkills("诛仙万象", attackTargetID);
        UseRoleSkills("暗器连击", attackTargetID);
        UseRoleSkills("落英剑", attackTargetID);
    elseif 门派 == "唐门" then
        UseRoleSkills("九天揽月", attackTargetID);
        UseRoleSkills("落日追星", attackTargetID);
        UseRoleSkills("孔雀翎", attackTargetID);
        UseRoleSkills("铁蒺藜", attackTargetID);
        UseRoleSkills("流云矢", attackTargetID);
    elseif 门派 == "丐帮" then
        UseRoleSkills("诛仙万象", attackTargetID);
        UseRoleSkills("暗器连击", attackTargetID);
        UseRoleSkills("暗器投掷", attackTargetID);
        UseRoleSkills("棒打狗头", attackTargetID);
        UseRoleSkills("蟠龙击", attackTargetID);
    elseif 门派 == "鬼谷" then
        UseRoleSkills("万宿辰光", attackTargetID);
        UseRoleSkills("诛仙万象", attackTargetID);
        UseRoleSkills("一气三清", attackTargetID);
        UseRoleSkills("未老先衰", attackTargetID);
        UseRoleSkills("暗器连击", attackTargetID);
        UseRoleSkills("乾坤引", attackTargetID);
    elseif 门派 == "天山" then
        UseRoleSkills("诛仙万象", attackTargetID);
        UseRoleSkills("暗器投掷", attackTargetID);
        UseRoleSkills("洪涛碧浪", attackTargetID);
        UseRoleSkills("阳歌天钧", attackTargetID);
        UseRoleSkills("暗器连击", attackTargetID);
        UseRoleSkills("内劲攻击", attackTargetID);
        UseRoleSkills("雁南飞", attackTargetID);
    elseif 门派 == "峨嵋" then
        UseRoleSkills("混江破崖", attackTargetID);
        UseRoleSkills("诛仙万象", attackTargetID);
        UseRoleSkills("暗器连击", attackTargetID);
        UseRoleSkills("貂蝉拜月", attackTargetID);
    elseif 门派 == "慕容" then
        UseRoleSkills("沌异潮落", attackTargetID);
        UseRoleSkills("诛仙万象", attackTargetID);
    elseif 门派 == "少林" then
        UseRoleSkills("玄印悟佛", attackTargetID);
        UseRoleSkills("诛仙万象", attackTargetID);
    elseif 门派 == "丐帮" then
        UseRoleSkills("地沉陷痕", attackTargetID);
        UseRoleSkills("诛仙万象", attackTargetID);
    elseif 门派 == "桃花岛" then
        UseRoleSkills("良夜游", attackTargetID);
        UseRoleSkills("人之可诛", attackTargetID);
        UseRoleSkills("雅颂之音", attackTargetID);
    elseif 门派 == "绝情谷" then
        UseRoleSkills("诛仙万象", attackTargetID);
    end
end

-- 执行区域 ----------------------------------------------------------------------------------------------------
执行功能("同步游戏时间")
myName = 获取人物信息(12)

if myName == 团长名字 then
    LUA_Call([[setmetatable(_G, {__index = Union_Ensure_Env});Union_Ensure_OnEvent("OPNE_CREATE_RAID_CONFIRM");]])
    延时(2000)
    LUA_Call([[setmetatable(_G, {__index = Union_Ensure_Env});Union_Ensure_ConfirmClick();]])
    延时(1000)

    startTime = os.time()
    while true do
        if os.time() - startTime > 组团等待时间 then
            break
        end
        LUA_Call([[Player:SendAgreeRaidApplication(0);]])
        延时(800)
    end
else
    延时(10000)
    while true do
        if judgeInRaid() == '0' then
            执行功能("申请固定团长")
        else
            break
        end
        延时(1000)
    end
end

BossLocation = GetBossInfo()
if string.find(BOSS名称, "苍山") then
    跨图寻路("洱海", 113, 130)
end
跨图寻路(BossLocation, BOSS坐标X, BOSS坐标Y)

while true do
    local now_x = 获取人物信息(7)
    local now_y = 获取人物信息(8)
    if tonumber(now_x) == tonumber(BOSS坐标X) and tonumber(now_y) == tonumber(BOSS坐标Y) then
        break
    end
    跨图寻路(BossLocation, BOSS坐标X, BOSS坐标Y)
    延时(1000)
end

UseTuLingZhuPositioning()
延时(500)

坐骑_下坐骑()

_, 门派, _, _, _, _, _, _, _ = 获取人物属性()
while true do
    _, 怪物ID, _, _, 目标血量, _, _, _, _, _ = 遍历周围物品(4, BOSS名称, 15)

    if 判断人物死亡() == 1 then
        -- 死亡出窍，自动定位回点捡包，只回点一次，捡完包回城
        死亡出窍()
        出监狱地府()
        延时(1000)
        UseTuLingZhuTransmit()
        延时(2000)
    end

    if 怪物ID > 0 then
        if 目标血量 > 0 then
            UseRoleSkillAttack(怪物ID)
            延时(110)
            UseRoleSkillAttack(怪物ID);
        else
            MentalTip("BOSS怪物死亡, 准备退团!")
            MentalTip("BOSS怪物死亡, 准备退团!")
            MentalTip("BOSS怪物死亡, 准备退团!")
            延时(2000)
            break
        end
    end

    延时(200)  -- 防止发包过快
end

延时(1000)

执行功能("退出团队")
