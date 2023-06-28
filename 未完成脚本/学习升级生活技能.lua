lifeSkillId = {
    ABILITY_PENGREN = 1, --烹饪技能对应编号
    ABILITY_ZHIYAO = 2, --制药技能对应编号
    ABILITY_XIANGQIAN = 3, --镶嵌技能对应编号
    ABILITY_ZHUZAO = 4, --铸造技能对应编号
    ABILITY_FENGREN = 5, --缝纫技能对应编号
    ABILITY_GONGYI = 6, --工艺制作技能对应编号
    ABILITY_CAIKUANG = 7, --采矿技能对应编号
    ABILITY_CAIYAO = 8, --采药技能对应编号
    ABILITY_DIAOYU = 9, --钓鱼技能对应编号
    ABILITY_ZHONGZHI = 10, --种植技能对应编号
    ABILITY_KAIGUANG = 11, --开光技能对应编号
    ABILITY_SHENGHUOSHU = 12, --圣火术技能对应编号
    ABILITY_NIANGJIU = 13, --酿酒技能对应编号
    ABILITY_XUANBINGSHU = 14, --玄冰术技能对应编号
    ABILITY_ZHIGU = 15, --制蛊技能对应编号
    ABILITY_ZHIDU = 16, --制毒技能对应编号
    ABILITY_ZHIFU = 17, --制符技能对应编号
    ABILITY_LIANDAN = 18, --炼丹技能对应编号
    ABILITY_QIMENDUNJIA = 19, --奇门遁甲技能对应编号
    ABILITY_GONGCHENGXUE = 20, --工程学技能对应编号
    ABILITY_QUGUI = 21, --驱鬼技能对应编号
    ABILITY_WABAO = 22, --挖宝技能对应编号
    ABILITY_PAOSHANG = 23, --跑商技能对应编号
    ABILITY_SHAJIA = 24, --杀价技能对应编号
    ABILITY_REMAI = 25, --热卖技能对应编号
    ABILITY_CAOZUOZHONG = 26, --操作中技能对应编号
    ABILITY_YAOLI = 27, --药理技能对应编号
    ABILITY_YANGSHENGFA = 28, --养生法
    ABILITY_FOFA = 29, --佛法 少林 用于辅助 开光
    ABILITY_CAIHUOSHU = 30, --采火术 明教 用于辅助 圣火术
    ABILITY_LIANHUALUO = 31, --莲花落 丐帮 用于辅助 酿酒
    ABILITY_CAIBINGSHU = 32, --采冰术 天山 用于辅助 玄冰术
    ABILITY_JINGMAIBAIJUE = 33, --经脉百决 大理 用于辅助 制蛊
    ABILITY_YINCHONGSHU = 34, --引虫术 星宿 用于辅助 制毒
    ABILITY_LINGXINSHU = 35, --灵心术 峨嵋 用于辅助 制符
    ABILITY_DAOFA = 36, --道法 武当 用于辅助 炼丹
    ABILITY_LIUYIFENGGU = 37, --六艺风骨 逍遥 用于辅助 奇门遁甲
    ABILITY_QISHU = 38, --骑术
    ABILITY_GPS = 39, --定位
    ABILITY_HUOXUE = 40, --活血
    ABILITY_YANGQI = 41, --养气
    ABILITY_QIANGSHEN = 42, --强身
    ABILITY_JIANTI = 43, --健体
    ABILITY_XIUSHEN = 44, --修身
    ABILITY_SUTI = 45, --塑体
    ABILITY_CAILIAOHECHENG = 49, --材料合成 材料合成
}

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function GetLifeSkillLevel(targetAbilityName)
    local lifeSkillLevel = LUA_取返回值(string.format([[
        local targetAbilityName = "%s"
		local nAbilityNum = GetActionNum("life");
		for i=0, nAbilityNum do
            local theAction = EnumAction(i, "life");
			if theAction:GetID() ~= 0 then
			    local defineID = theAction:GetDefineID()
                local szName = theAction:GetName();  -- 生活技能名字
			    local nAbilityID =	LifeAbility : GetLifeAbility_Number(theAction:GetID());
                local nLevel = Player:GetAbilityInfo(nAbilityID, "level");  -- 生活技能的等级
                local nMaxLevel = Player:GetAbilityInfo(nAbilityID, "maxlevel");  -- 生活技能的最大等级
                local nSkillExp = Player:GetAbilityInfo(nAbilityID, "skillexp");  -- 生活技能当前熟练度
                local szExplain = Player:GetAbilityInfo(nAbilityID, "explain");  -- 生活技能解释
                local nNeedLevel = AbilityTeacher:GetNeedLevel();
                local nNeedSkillExp = AbilityTeacher:GetNeedSkillExp();

                if targetAbilityName == szName then
                    return nLevel
                end
            end
	    end
	    return -1
	]], targetAbilityName))
    return tonumber(lifeSkillLevel)
end

function GetGuildCityName()
    local myGuildCityName = LUA_取返回值([[
       local guildID, clanID = DataPool:GetGuildClanID()
       local myCityName = Guild:GetMyGuildDetailInfo("CityName")
       PushDebugMessage("myCityName: " .. myCityName)
       return myCityName
   ]])
    return myGuildCityName
end

function BackToBangHui()
    -- 必须打开帮会界面，切换过才能获取帮会信息
    LUA_Call([[setmetatable(_G, {__index = MainMenuBar_Env});MainMenuBar_OnOpenGruidClick();]])
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = NewBangHui_Hygl_Env});NewBangHui_Hygl_Bhxx_Clicked();]])
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = NewBangHui_Bhxx_Env});NewBangHui_Bhxx_Tmxx_Clicked();]])
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = NewBangHui_Tmxx_Env});NewBangHui_Tmxx_Closed();]])

    坐骑_下坐骑()

    local myGuildCityName = GetGuildCityName()

    if tonumber(myGuildCityName) == -1 then
        MentalTip("脚本检索帮会失败, 使用绑定元宝购买定位")
        return
    end

    local inBangHui = 0
    local curCityName = 获取人物信息(16)
    if curCityName == "苏州" then
        坐骑_上坐骑()
        while true do
            跨图寻路("苏州", 322, 264)
            延时(500)
            local myX = 获取人物信息(7)
            local myY = 获取人物信息(8)
            if tonumber(myX) == 322 and tonumber(myY) == 264 then
                break
            end
        end
        延时(1000)
        对话NPC("范纯粹")
    elseif curCityName == "大理" then
        坐骑_上坐骑()
        while true do
            跨图寻路("大理", 179, 121)
            延时(500)
            local myX = 获取人物信息(7)
            local myY = 获取人物信息(8)
            if tonumber(myX) == 179 and tonumber(myY) == 121 then
                break
            end
        end
        延时(1000)
        对话NPC("范纯礼")
    elseif curCityName == "洛阳" then
        坐骑_上坐骑()
        while true do
            跨图寻路("洛阳", 237, 236)
            延时(500)
            local myX = 获取人物信息(7)
            local myY = 获取人物信息(8)
            if tonumber(myX) == 237 and tonumber(myY) == 236 then
                break
            end
        end
        延时(1000)
        对话NPC("范纯仁")
    elseif curCityName == "楼兰" then
        坐骑_上坐骑()
        while true do
            跨图寻路("楼兰", 190, 130)
            延时(500)
            local myX = 获取人物信息(7)
            local myY = 获取人物信息(8)
            if tonumber(myX) == 190 and tonumber(myY) == 130 then
                break
            end
        end
        延时(1000)
        对话NPC("范纯祐")
    elseif curCityName == myGuildCityName then
        inBangHui = 1
        坐骑_上坐骑()
    else
        执行功能("大理回城")
        延时(3000)
        坐骑_上坐骑()
        while true do
            跨图寻路("大理", 179, 121)
            延时(500)
            local myX = 获取人物信息(7)
            local myY = 获取人物信息(8)
            if tonumber(myX) == 179 and tonumber(myY) == 121 then
                break
            end
        end
        延时(3000)
        对话NPC("范纯礼")
    end

    if inBangHui == 0 then
        延时(500)
        NPC二级对话("进入本帮城市")
        等待过图完毕()
        延时(3000)
    end

    while true do
        local curMap = 获取人物信息(16)
        if curMap == myGuildCityName then
            延时(2000)
            break
        end
        延时(1000)
    end
end

function LifeSkillStudyAndLevelUp()
    local needStudyLifeSkill = {
        [1] = { skillName = "铸造", studyLevel = 10, npcMap = "洛阳", ncpName = "耶律大石", posX = 188, posY = 62 },
        [2] = { skillName = "缝纫", studyLevel = 10, npcMap = "大理", ncpName = "木婉清", posX = 105, posY = 135 },
        [3] = { skillName = "工艺", studyLevel = 10, npcMap = "镜湖", ncpName = "阮星竹", posX = 108, posY = 140 },
        [4] = { skillName = "养生", studyLevel = 10, npcMap = "洛阳", ncpName = "蔷薇", posX = 132, posY = 156 },
        [5] = { skillName = "药理", studyLevel = 10, npcMap = "洛阳", ncpName = "白颖明", posX = 136, posY = 169 },
        [6] = { skillName = "养气", studyLevel = 10, npcMap = "-1", ncpName = "穆易", posX = 46, posY = 91 },
        [7] = { skillName = "强身", studyLevel = 10, npcMap = "-1", ncpName = "钱为一", posX = 149, posY = 57 },
        [8] = { skillName = "健体", studyLevel = 10, npcMap = "-1", ncpName = "钱为一", posX = 149, posY = 57 },
        [9] = { skillName = "活血", studyLevel = 10, npcMap = "-1", ncpName = "朱世友", posX = 266, posY = 140 },
        [10] = { skillName = "材料加工", studyLevel = 1, npcMap = "洛阳", ncpName = "冯铸铁", posX = 155, posY = 174 },
        [11] = { skillName = "咫尺天涯", studyLevel = 3, npcMap = "大理", ncpName = "张灵均", posX = 53, posY = 212 },
    }

    for i = 1, #needStudyLifeSkill do
        local studyMap = needStudyLifeSkill[i].npcMap
        local lifeSkillName = needStudyLifeSkill[i].skillName
        local studyLevel = needStudyLifeSkill[i].studyLevel
        local npcName = needStudyLifeSkill[i].ncpName
        local posX = needStudyLifeSkill[i].posX
        local posY = needStudyLifeSkill[i].posY
        local lifeSkillLevel = GetLifeSkillLevel(lifeSkillName)
        if studyMap ~= "-1" then
            if lifeSkillLevel == -1 then
                跨图寻路(studyMap, posX, posY)
                延时(1000)
                对话NPC(npcName)
                延时(1000)
                NPC二级对话("学习", 1)
                延时(1000)
                NPC二级对话("确定")
                延时(500)
            end
            if lifeSkillLevel < studyLevel then
                跨图寻路(studyMap, posX, posY)
                延时(1000)

                if i == 11 then
                    -- 咫尺天涯不会弹出升级窗口
                    for i = 1, studyLevel - lifeSkillLevel do
                        对话NPC(npcName)
                        延时(1000)
                        NPC二级对话("升级", 1)
                        延时(1000)
                        NPC二级对话("确定")
                        延时(100)
                    end
                else
                    对话NPC(npcName)
                    延时(1000)
                    NPC二级对话("升级", 1)
                    延时(1000)
                    for i = 1, studyLevel - lifeSkillLevel do
                        -- TODO
                        LUA_Call([[

                        ]])
                        延时(500)
                    end
                end
            end
        else
            local myGuildCityName = GetGuildCityName()
            if lifeSkillLevel == -1 then
                BackToBangHui()
                while true do
                    跨图寻路(myGuildCityName, posX, posY)
                    延时(500)
                    local myX = 获取人物信息(7)
                    local myY = 获取人物信息(8)
                    if tonumber(myX) == posX and tonumber(myY) == posY then
                        break
                    end
                end
                延时(2000)
                对话NPC(npcName)
                延时(1000)
                NPC二级对话("学习", 1)
                延时(1000)
                NPC二级对话("确定")
                延时(500)
            end
            if lifeSkillLevel < studyLevel then
                BackToBangHui()
                while true do
                    跨图寻路(myGuildCityName, posX, posY)
                    延时(500)
                    local myX = 获取人物信息(7)
                    local myY = 获取人物信息(8)
                    if tonumber(myX) == posX and tonumber(myY) == posY then
                        break
                    end
                end
                延时(2000)
                对话NPC(npcName)
                延时(1000)
                NPC二级对话("升级", 1)
                延时(1000)
                for i = 1, studyLevel - lifeSkillLevel do
                    -- TODO
                    LUA_Call([[

                    ]])
                    延时(500)
                end
            end
        end
    end
end