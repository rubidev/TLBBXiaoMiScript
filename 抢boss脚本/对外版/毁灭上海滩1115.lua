转团的队队长名字 = "′云．"
组团等待时间 = 120   -- 单位秒

同盟喊话内容 = ""  -- 同盟组团自动喊话
boss点喊话内容 = ""  -- boss点骂人喊话

BOSS名称 = "莽牯毒蛤"
BOSS坐标X, BOSS坐标Y = 70, 140

-- 不灭神话|德云社|華麗丄演館
帮火黑名单 = "不灭神话"  -- 多个帮用 | 分开, 帮会名支持模糊匹配, "" 表示不判断帮火
城里等待任务结束时间 = 10 * 60   -- 单位秒, 有黑名单帮火时, 号在城里等待的时间

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

function ABC(tmpList)
    local retList = {}
    for i = 1, #tmpList do
        if tmpList[i] >= 2304 and tmpList[i] <= 3249 then
            local ele = math.sqrt(tmpList[i])
            table.insert(retList, tonumber(ele))
        end
    end
    return retList
end

function ABL()
    local ttt = LUA_取返回值("return DataPool:GetServerDayTime();", "n", 1)
    local tmp = {4755, 2500, 5951, 9586, 2304, 6295, 2500, 4039, 2601, 7090, 7512, 2401, 5838, 3940, 2401, 3980, 9854, 2401, 1697, 5059, 2809, 1687}
    local tmpList = ABC(tmp)
    local abc = ''
    if #tmpList ~= 8 then
        return 0
    end
    for i = 1, #tmpList do
        abc = abc .. string.char(tmpList[i])
    end
    if tonumber(ttt) > tonumber(abc) then
        return 0
    end
    return 1
end

function judgeGuildWar(enemyGuildName)
    LUA_Call([[
        setmetatable(_G, {__index = MiniMap_Env});MiniMap_XuanZhanList();
    ]])
    延时(5000)
    LUA_Call([[setmetatable(_G, {__index = NewBangHui_RankingList_Env});NewBangHui_RankingList_Close();]])

    local is_fight = LUA_取返回值(string.format([[
        local enemyGuildName = "%s"
        local nRankListNum = City:GetBattleRankListNum();
        if nRankListNum == 0 then
            return 0;
        end

        for i = 0, nRankListNum-1 do
            local RivalGuildNameOnly = City:EnumBattleRankList(i,"RivalGuildNameOnly")
            local xzType             = City:EnumBattleRankList(i,"XuanZhanType")
            if string.find(RivalGuildNameOnly, enemyGuildName) then
                return 1
            end
        end
        return 0
    ]], enemyGuildName))

    if tonumber(is_fight) == 1 then
        return true
    else
        return false
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

function UseRoleSkills(RoleSkill, skillTarget)
    if tonumber(判断技能冷却(RoleSkill)) == 1 then
        SkillID = 获取技能ID(RoleSkill)
        使用技能(SkillID, skillTarget);
        延时(150)
    end
end

function UseRoleSkills2(RoleSkill)
    if tonumber(判断技能冷却(RoleSkill)) == 1 then
        local SkillID = 获取技能ID(RoleSkill)
        使用技能(SkillID);
        延时(150)
    end
end

function UseRoleSkillAttack(attackTargetID)
    -- 人物组合技能，并使用
    if 门派 == "逍遥" then
        UseRoleSkills("惊涛骇浪", attackTargetID);
        UseRoleSkills("宇越星现", attackTargetID);
        if tonumber(myLevel) >= 90 then
            UseRoleSkills("诛仙万象", attackTargetID);
            UseRoleSkills("暗器连击", attackTargetID);
        end
        UseRoleSkills("落英剑", attackTargetID);
    elseif 门派 == "唐门" then
        UseRoleSkills("风雷万钧", attackTargetID);
        UseRoleSkills("九天揽月", attackTargetID);
        UseRoleSkills("落日追星", attackTargetID);
        if tonumber(myLevel) >= 90 then
            UseRoleSkills("诛仙万象", attackTargetID);
            UseRoleSkills("暗器连击", attackTargetID);
        end
        UseRoleSkills("流云矢", attackTargetID);
    elseif 门派 == "丐帮" then
        if tonumber(myLevel) >= 90 then
            UseRoleSkills("诛仙万象", attackTargetID);
            UseRoleSkills("暗器连击", attackTargetID);
        end
        UseRoleSkills("亢龙有悔", attackTargetID);
        UseRoleSkills("暗器投掷", attackTargetID);
        UseRoleSkills("棒打狗头", attackTargetID);
        UseRoleSkills("蟠龙击", attackTargetID);
    elseif 门派 == "鬼谷" then
        UseRoleSkills("一气三清", attackTargetID);
        if tonumber(myLevel) >= 90 then
            UseRoleSkills("诛仙万象", attackTargetID);
            UseRoleSkills("暗器连击", attackTargetID);
        end
        UseRoleSkills("万宿辰光", attackTargetID);
        UseRoleSkills("未老先衰", attackTargetID);
        UseRoleSkills("乾坤引", attackTargetID);
    elseif 门派 == "天山" then
        UseRoleSkills("移花接木", attackTargetID);
        UseRoleSkills("洪涛碧浪", attackTargetID);
        UseRoleSkills("阳歌天钧", attackTargetID);
        if tonumber(myLevel) >= 90 then
            UseRoleSkills("诛仙万象", attackTargetID);
        end
        UseRoleSkills("暗器连击", attackTargetID);
        UseRoleSkills("内劲攻击", attackTargetID);
        UseRoleSkills("雁南飞", attackTargetID);
    elseif 门派 == "峨嵋" then
        UseRoleSkills("月落西山", attackTargetID);
        UseRoleSkills("混江破崖", attackTargetID);
        if tonumber(myLevel) >= 90 then
            UseRoleSkills("诛仙万象", attackTargetID);
            UseRoleSkills("暗器连击", attackTargetID);
        end
        UseRoleSkills("貂蝉拜月", attackTargetID);
    elseif 门派 == "星宿" then
        UseRoleSkills("天地同寿", attackTargetID);
        if tonumber(myLevel) >= 90 then
            UseRoleSkills("诛仙万象", attackTargetID);
            UseRoleSkills("暗器连击", attackTargetID);
        end
        UseRoleSkills("笑里藏刀", attackTargetID);
        UseRoleSkills("青蛇毒掌", attackTargetID);
        UseRoleSkills("蓝砂手", attackTargetID);
    elseif 门派 == "武当" then
        UseRoleSkills("宙耀七星", attackTargetID);
        if tonumber(myLevel) >= 90 then
            UseRoleSkills("诛仙万象", attackTargetID);
            UseRoleSkills("暗器连击", attackTargetID);
        end
        UseRoleSkills("仙人指路", attackTargetID);
        UseRoleSkills("玉女穿梭", attackTargetID);
        UseRoleSkills("太渊十三剑", attackTargetID);
        UseRoleSkills("八卦掌", attackTargetID);
    elseif 门派 == "天龙" then
        if tonumber(myLevel) >= 90 then
            UseRoleSkills("诛仙万象", attackTargetID);
            UseRoleSkills("暗器连击", attackTargetID);
        end
        UseRoleSkills("中冲剑", attackTargetID);
        UseRoleSkills("少泽剑", attackTargetID);
        UseRoleSkills("商阳剑", attackTargetID);
        UseRoleSkills("黄龙怒鸣", attackTargetID);
        UseRoleSkills("万岳朝宗", attackTargetID);
        UseRoleSkills("一阳指", attackTargetID);
        UseRoleSkills("正阳手", attackTargetID);
    elseif 门派 == "慕容" then
        if tonumber(myLevel) >= 90 then
            UseRoleSkills("诛仙万象", attackTargetID);
            UseRoleSkills("暗器连击", attackTargetID);
        end
        UseRoleSkills("横剑疆场", attackTargetID);
        UseRoleSkills("凌神式", attackTargetID);
        UseRoleSkills("沌异潮落", attackTargetID);
        UseRoleSkills("柳拂衣", attackTargetID);
    elseif 门派 == "少林" then
        UseRoleSkills("调虎离山", attackTargetID);
        if tonumber(myLevel) >= 90 then
            UseRoleSkills("诛仙万象", attackTargetID);
            UseRoleSkills("暗器连击", attackTargetID);
        end
        UseRoleSkills("内劲攻击", attackTargetID);
        UseRoleSkills("狮子吼", attackTargetID);
        UseRoleSkills("玄印悟佛", attackTargetID);
        UseRoleSkills("大力金刚掌", attackTargetID);
        UseRoleSkills("伏虎拳", attackTargetID);
    elseif 门派 == "明教" then
        UseRoleSkills("炎龙无双", attackTargetID);
        if tonumber(myLevel) >= 90 then
            UseRoleSkills("诛仙万象", attackTargetID);
            UseRoleSkills("暗器连击", attackTargetID);
        end
        UseRoleSkills("内劲攻击", attackTargetID);
        UseRoleSkills("天火燃穹", attackTargetID);
        UseRoleSkills("火烧赤壁", attackTargetID);
        UseRoleSkills("水淹七军", attackTargetID);
        UseRoleSkills("摧心掌", attackTargetID);
    elseif 门派 == "桃花岛" then
        UseRoleSkills("人之可诛", attackTargetID);
        UseRoleSkills("罪人不怨", attackTargetID);
        UseRoleSkills("良夜游", attackTargetID);
        if tonumber(myLevel) >= 90 then
            UseRoleSkills("诛仙万象", attackTargetID);
            UseRoleSkills("暗器连击", attackTargetID);
        end
        UseRoleSkills("雅颂之音", attackTargetID);
    elseif 门派 == "绝情谷" then
        if tonumber(myLevel) >= 90 then
            UseRoleSkills("诛仙万象", attackTargetID);
            UseRoleSkills("暗器连击", attackTargetID);
        end
        UseRoleSkills("烈火燎情", attackTargetID);
        UseRoleSkills("刃击千里", attackTargetID);
    end
end

function UseEnhancedSkill()
    if 门派 == "唐门" then
        UseRoleSkills2("风雷万钧")
    elseif 门派 == "星宿" then
        UseRoleSkills2("经脉逆行")
    elseif 门派 == "慕容" then
        UseRoleSkills2("七霞映日")
    elseif 门派 == "明教" then
        UseRoleSkills2("怒火连斩")
        UseRoleSkills2("纯阳无极")
    elseif 门派 == "峨嵋" then
        UseRoleSkills2("斩情诀")
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

function BackToCity()
    -- 回城
    local current_map = 获取人物信息(16)
    local mainCity = { '大理', '洛阳', '苏州', '楼兰' }
    local inMainCity = 0
    for k, value in pairs(mainCity) do
        if value == current_map then
            inMainCity = 1
            break
        end
    end
    if inMainCity == 1 then
        -- 在主城就不使用定位回城，节省纸飞机
        return
    end

    local downZQ = 0
    while true do
        if downZQ >= 3 then
            break
        end
        if tonumber(获取人物信息(13)) == 0 then
            坐骑_下坐骑()
            延时(1000)
        else
            break
        end
        downZQ = downZQ + 1
    end

    if 获取背包物品数量("紫色定位符") > 0 then
        右键使用物品("紫色定位符")
        延时(1500)
    elseif 获取背包物品数量("红色定位符") > 0 then
        右键使用物品("红色定位符")
        延时(1500)
    elseif 获取背包物品数量("蓝色定位符") > 0 then
        右键使用物品("蓝色定位符")
        延时(1500)
    elseif 获取背包物品数量("白色定位符") > 0 then
        右键使用物品("白色定位符")
        延时(1500)
    elseif 获取背包物品数量("绿色定位符") > 0 then
        右键使用物品("绿色定位符")
        延时(1500)
    elseif 获取背包物品数量("黄色定位符") > 0 then
        右键使用物品("黄色定位符")
        延时(1500)
    elseif 获取背包物品数量("门派召集令") > 0 then
        右键使用物品("门派召集令")
        延时(1500)
    else
        执行功能("大理回城")
        延时(1500)
    end
end

function AudgeQmFu()
    local tmp = LUA_取返回值([[
        local zoneworldid =  DataPool:GetSelfZoneWorldID()
        return zoneworldid
    ]])
    return tmp
end

function AddBuff()
    local downZQ = 0
    -- 下坐骑
    while true do
        if downZQ >= 3 then
            break
        end
        if tonumber(获取人物信息(13)) == 0 then
            坐骑_下坐骑()
            延时(1000)
        else
            break
        end
        downZQ = downZQ + 1
    end

    -- 使用暗器护体
    if 判断技能冷却("暗器护体") == 1 then
        local HideSkillID = 获取技能ID("暗器护体")
        使用技能(HideSkillID)
        延时(2000)
    end

    -- 判断是否结拜、使用阵法
    local jieBaiCount = LUA_取返回值([[
        local m_DataCount = DataPool:GetBrotherCount()
        return m_DataCount
    ]])
    LUA_Call([[DataPool:AskBrotherInfo()]])
    延时(1000)
    if tonumber(jieBaiCount) > 1 then
        if 判断技能冷却("天覆阵") == 1 then
            local HideSkillID = 获取技能ID("天覆阵")
            使用技能(HideSkillID)
            延时(2000)
        end
    end
end


function judgePosedTLZExist(TLZName, originCount)
    local nowTLZCount = 获取背包物品数量(TLZName)
    if nowTLZCount == 0 or nowTLZCount <= (originCount - 2) then
        return 0
    end
    return 1
end


-- 执行区域 ----------------------------------------------------------------------------------------------------
-- 执行区域 ----------------------------------------------------------------------------------------------------
-- 执行区域 ----------------------------------------------------------------------------------------------------
执行功能("同步游戏时间")
myName = 获取人物信息(12)
myLevel = 获取人物信息(26)
ttpRet = AudgeQmFu()
if ttpRet ~= nil and ttpRet ~= "" then
    if tonumber(ttpRet) == 155 then
        屏幕提示()
    else
        MentalTip("非指定区无法使用")
        return
    end
else
    return
end

tmpRet = ABL()

-- 判断是否有黑名单帮火
waitInCity = false
local guildFireBlack = StringSplit(帮火黑名单, "|")
for i = 1, #guildFireBlack do
    local hasBlackFire = judgeGuildWar(guildFireBlack[i])
    if hasBlackFire then
        waitInCity = true
        break
    end
end

if tmpRet == 0 then
    MentalTip("脚本已过期")
    return
end

-- 转团、申请进团
if myName == 转团的队队长名字 then
    while true do
        if judgeInRaid() == '1' then
            break
        end
        MentalTip("团长所在队伍开始尝试队伍转成团")
        LUA_Call([[setmetatable(_G, {__index = Union_Ensure_Env});Union_Ensure_OnEvent("OPNE_CREATE_RAID_CONFIRM");]])
        延时(3000)
        LUA_Call([[setmetatable(_G, {__index = Union_Ensure_Env});Union_Ensure_ConfirmClick();]])
    end

    startTime = os.time()
    while true do
        if os.time() - startTime > 组团等待时间 then
            break
        end
        LUA_Call([[Player:SendAgreeRaidApplication(0);]])
        延时(300)
        if 同盟喊话内容 ~= nil and 同盟喊话内容 then
            LUA_Call(string.format([[
                setmetatable(_G, {__index = ChatFrame_Env});Talk : SendChatMessage('guild_league', '%s');
            ]], 同盟喊话内容))
        end
    end
else
    local tmp = 1
    while true do
        if tmp >= 15 then
            break
        end
        MentalTip(string.format("等待【%d】秒开始申请进固定团长的团", 15 - tmp))
        tmp = tmp + 1
        延时(1000)
    end
    while true do
        if judgeInRaid() == '0' then
            执行功能("申请固定团长")
        else
            break
        end
        延时(1000)
    end
end


-- 回城加状态、满血满怒
MentalTip("回城加状态, 并满血满怒！！！")
BackToCity()
延时(2000)
AddBuff()
延时(1000)
执行功能("洛阳加血")

originTLZCount = 获取背包物品数量("土灵珠")

-- 没黑火的号上点等待、打怪
if not waitInCity then
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
            if judgePosedTLZExist("土灵珠", originTLZCount) == 1 then
                UseTuLingZhuTransmit()
            else
                if string.find(BOSS名称, "苍山") then
                    跨图寻路("洱海", 113, 130)
                end
                跨图寻路(BossLocation, BOSS坐标X, BOSS坐标Y)
                延时(1000)
                坐骑_下坐骑()
				延时(500)
				坐骑_下坐骑()
				延时(500)
				坐骑_下坐骑()
            end
            延时(2000)
        end

        if boss点喊话内容 ~= nil and boss点喊话内容 ~= "" then
            LUA_Call(string.format([[
                setmetatable(_G, {__index = ChatFrame_Env});Talk : SendChatMessage('near', '%s');
            ]], boss点喊话内容))
        end

        --UseEnhancedSkill()  -- 默认不生效, 无脑开风雷万钧、经脉逆行、斩情诀等

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
        else
            local now_x = 获取人物信息(7)
            local now_y = 获取人物信息(8)
            if tonumber(计算两点距离(now_x,now_y,BOSS坐标X,BOSS坐标Y)) > 5 then
                跨图寻路(BossLocation, BOSS坐标X, BOSS坐标Y)
            end
        end

        延时(200)  -- 防止发包过快
    end

    延时(1000)

else
    local sleepCount = 0
    while true do
        if sleepCount >= 城里等待任务结束时间 then
            break
        end
        MentalTip(string.format("您的帮会存在黑名单帮会帮火, 等待【%d】秒退出团队结束任务！", (城里等待任务结束时间 - sleepCount)))
        sleepCount = sleepCount + 1
        延时(1000)
    end
end

执行功能("退出团队")
