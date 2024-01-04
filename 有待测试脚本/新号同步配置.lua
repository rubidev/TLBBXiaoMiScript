购买鎏金礼匣物品人物名单 = ""
领紫微名单 = ''
寒纹玉买真元名单 = ''
天波府BOSS2定点躲避狂卷八荒名单 = ''
需要重洗令牌扩展属性人物名单 = ''

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

function WritePlayerConfiguration(section, keyName, value)
    local playerName = 获取人物信息(12)
    local configPath = string.format("C:\\天龙小蜜\\角色配置\\%s.ini", playerName)
    if section ~= nil and keyName ~= nil and value ~= nil then
        MentalTip("写角色配置项|" .. section .. "|" .. keyName .. "|" .. value);
        延时(200)
        写配置项(configPath, section, keyName, value);
        延时(200)
    end
end

function ReadPlayerConfiguration(section, keyName)
    local playerName = 获取人物信息(12)
    local configPath = string.format("C:\\天龙小蜜\\角色配置\\%s.ini", playerName)
    local tem = 读配置项(configPath, section, keyName)
    if tem then
        MentalTip(section .. "|" .. keyName .. "==" .. tem);
        延时(500)
    else
        return 0
    end
    return tem
end

function BugZhanGongItem()
    -- 战功商店
    local buyItems = ''

    local HXYLevel = LUA_取返回值([[
		local ActionHXY = EnumAction(21,"equip")
		if ActionHXY and ActionHXY:GetID() ~= 0 then
			local nEquipLevel = DataPool:Lua_GetHXYLevel()
			return  nEquipLevel
		else
			return 0
		end
	]])

    if tonumber(HXYLevel) < 100 then
        if buyItems == '' then
            buyItems = buyItems .. '豪侠勋章'
        else
            buyItems = buyItems .. '|豪侠勋章'
        end
    end

    local effectFullLevel = true
    for i = 0, 6 do
        local effectLevel = LUA_取返回值(string.format([[
            local effectIndex = %d
            local nIndex , iEffectLevel, iCost , iNeedHXYLevel , iValue = DataPool:Lua_GetHXYEffect( effectIndex )
            if nIndex ~= nil then
                return iEffectLevel
            end
            return -1
        ]], i))
        if tonumber(effectLevel) < 20 then
            effectFullLevel = false
            if buyItems == '' then
                buyItems = buyItems .. '御赐令赏'
            else
                buyItems = buyItems .. '|御赐令赏'
            end
            break
        end
    end

    if buyItems == '' then
        buyItems = buyItems .. '金刚锉|润物露'
    else
        buyItems = buyItems .. '|金刚锉|润物露'
    end

    WritePlayerConfiguration('配置', '战功物品', buyItems)
end

function GetInfantSkillMinLevel()
    local minLevel = LUA_取返回值([[
        local minLevel = 9
        for i = 0, 3 do
            local nID, nLevel = Infant:GetInfantSkillInfo(0, i)
            if nID >= 0 then
                if tonumber(nLevel) < minLevel then
                    minLevel = tonumber(nLevel)
                end
            end
        end
        return minLevel
    ]])
    return tonumber(minLevel)
end

function GetInfantCardMinLevel()
    local minLevel = LUA_取返回值([[
        local minLevel = 9
        for i = 0, 5 do
            local nCardYanDuLevel = Infant:GetInfantCardYanDuLevel(0, i)
            if tonumber(nCardYanDuLevel) < minLevel then
                minLevel = tonumber(nCardYanDuLevel)
            end
        end
        return minLevel
    ]])
    return tonumber(minLevel)
end

function GetWuHunGrow()
    local WHGrow = LUA_取返回值([[
        local wuhution = EnumAction(18,"equip")
        local id  = wuhution:GetID();
        if id > 0 then
            return DataPool:GetKfsData("GROW")
        end
        return -1
    ]])
    return tonumber(WHGrow)
end

function GetLingPaiBaoZhuMinLevel()
    local tmp = LUA_取返回值([[
	        local BaoZhuMinLevel = 50
			local nType,BaoZhu1,BaoZhu2,BaoZhu3,BaoZhu4,nQual = DataPool:GetLingPaiInfo()
			if nType> 0 then
			    if tonumber(BaoZhu1) < BaoZhuMinLevel then
			        BaoZhuMinLevel = tonumber(BaoZhu1)
                end

                if tonumber(BaoZhu2) < BaoZhuMinLevel then
			        BaoZhuMinLevel = tonumber(BaoZhu2)
			    end

                if tonumber(BaoZhu3) < BaoZhuMinLevel then
			        BaoZhuMinLevel = tonumber(BaoZhu3)
			    end

                if tonumber(BaoZhu4) < BaoZhuMinLevel then
			        BaoZhuMinLevel = tonumber(BaoZhu4)
			    end

			end
			return BaoZhuMinLevel
	]])
    return tonumber(tmp)
end

function GetWornLingPaiID()
    local wornLingPaiID = LUA_取返回值(string.format([[
        return EnumAction(%d,"equip"):GetID()
    ]], 20))
    return tonumber(wornLingPaiID)
end

function DownAndGetLingPaiName()
    MentalTip("准备取下令牌:")
    if GetWornLingPaiID() <= 0 then
        return -1
    end

    for k = 1, 5 do
        if 窗口是否出现("SelfEquip") == 1 then
            local LingPaiName = LUA_取返回值(string.format([[
                local index = %d
                local theAction = EnumAction(index,"equip")
                if theAction then
                    local ID = theAction:GetID();
                    if tonumber( ID) > 0 then
                        local Name = EnumAction(index,"equip"):GetName()
                        return Name
                    end
                end
                return -1
            ]], 20))
            LUA_Call(string.format([[ setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Equip_Click(%d,0)]], 16))
            延时(2000)
            local wornLingPaiID = GetWornLingPaiID()
            if wornLingPaiID == 0 then
                晴天_判断关闭窗口("SelfEquip")
                return LingPaiName
            end
        else
            LUA_Call("MainMenuBar_SelfEquip_Clicked();");
            延时(2000)
        end
    end
    return 0
end

function GetLingPaiStar()
    local LingPaiName = DownAndGetLingPaiName()
    local nStarLevel = 8
    if LingPaiName ~= nil and LingPaiName ~= 0 and LingPaiName ~= -1 then
        local LingPaiPos = 获取背包物品位置(LingPaiName)
        nStarLevel = LUA_取返回值(string.format([[
            local m_EquipBagIndex = %d
            local nStarLevel , nStarEffect , strSuccess , nMustSuccessTry ,nNextStarLevel , nNextStarEffect  = PlayerPackage:Lua_GetBagItemRl_StarInfo(m_EquipBagIndex)
            return nStarLevel
        ]], LingPaiPos - 1))
    elseif LingPaiName == -1 then
        nStarLevel = 1
    end
    return nStarLevel
end

function BuyBaiBaoGeItem()
    local playerName = 获取人物信息(12)
    local buyItems = ''


    local LingPaiStar = GetLingPaiStar()
    if LingPaiStar < 8 then
        buyItems = buyItems .. '|唤灵液'
    end

    if string.find(需要重洗令牌扩展属性人物名单, playerName) then
        buyItems = buyItems .. '|天荒晶石'
    end

    buyItems = buyItems .. '|3级棉布|3级秘银'

    local infantSkillMinLevel = GetInfantSkillMinLevel()
    if infantSkillMinLevel < 9 then
        buyItems = buyItems .. '|悟灵珠'
    end

    local infantCardMinLevel = GetInfantCardMinLevel()
    if infantCardMinLevel < 9 then
        buyItems = buyItems .. '|典籍注解'
    end

    local LingPaiBZMinLevel = GetLingPaiBaoZhuMinLevel()
    if LingPaiBZMinLevel < 50 then
        buyItems = buyItems .. '翡翠心精礼包'
    end

    local WHGrow = GetWuHunGrow()
    if WHGrow < 887 then
        buyItems = buyItems .. '|回天神石'
    end

    buyItems = buyItems .. '真元珀|紫府星髓|幻魂丹|虹耀石'

    if WHGrow >= 887 and WHGrow < 900 then
        buyItems = buyItems .. '|回天神石'
    end

    buyItems = buyItems .. '|金刚砂'
    WritePlayerConfiguration('配置', '百宝阁物品', buyItems)
end

function SetXueJiPet()
    local XJPetName = LUA_取返回值([[
        local needYSPetCount = 0
        local petCount = Pet:GetPet_Count()
        local XJPetInfo = ''
        local maxXJPetHP = 0
        local XJPetName = ''
        for petIndex=0, petCount do
            for petSkillIndex = 0, 1 do
                local theSkillAction = Pet:EnumPetSkill( petIndex, petSkillIndex, "petskill");
                if theSkillAction:GetID() ~= nil and theSkillAction:GetID() ~= 0 then
                    local petSkillName = theSkillAction:GetName()
                    local petHP = Pet: GetMaxHP(petIndex)
                    local petName = Pet:GetName(petIndex)
                    if string.find(petSkillName, "血祭") then
                        if tonumber(petHP) > maxXJPetHP then
                            maxXJPetHP = tonumber(petHP)
                            XJPetName = petName
                        end
                    end
                end
            end
        end
        return XJPetName
    ]])

    WritePlayerConfiguration('配置', '血祭宠物', XJPetName)

end

function main()
    local playerName = 获取人物信息(12)
    WritePlayerConfiguration('配置', '自动存钱', '1')
    WritePlayerConfiguration('配置', '人物血量', '90')
    WritePlayerConfiguration('配置', '人物蓝量', '10')
    WritePlayerConfiguration('配置', '清心普善咒', '1')
    WritePlayerConfiguration('配置', '高级加血', '1')
    WritePlayerConfiguration('配置', '队伍加血', '1')
    WritePlayerConfiguration('配置', '团队加血', '1')
    WritePlayerConfiguration('配置', '解除畅游加', '1')
    if string.find(购买鎏金礼匣物品人物名单, playerName) then
        WritePlayerConfiguration('配置', '鎏金礼匣购买物品', '鎏金礼匣购买物品=无|金蚕丝|真元珀')
    end
    WritePlayerConfiguration('配置', 'F11屏蔽', '1')
    WritePlayerConfiguration('配置', 'F12屏蔽', '1')
    WritePlayerConfiguration('配置', '自动吃真元', '1')
    WritePlayerConfiguration('配置', '帮战不出地府', '1')
    WritePlayerConfiguration('配置', '交五行法帖', '1')
    WritePlayerConfiguration('配置', '领取玫瑰', '1')
    WritePlayerConfiguration('配置', '领取花种', '1')
    WritePlayerConfiguration('配置', '离火炼炉', '1')
    WritePlayerConfiguration('配置', '幸运快三', '1')
    WritePlayerConfiguration('配置', '太湖许愿', '0')  -- TODO
    WritePlayerConfiguration('配置', '每日签到', '1')
    WritePlayerConfiguration('配置', '签到领奖', '1')
    WritePlayerConfiguration('配置', '补领释灵浆', '0')
    WritePlayerConfiguration('配置', '上缴战魂玉', '0')
    WritePlayerConfiguration('配置', '领取战功', '1')
    BugZhanGongItem()
    WritePlayerConfiguration('配置', '畅游加领奖', '1')
    WritePlayerConfiguration('配置', '师徒心连心', '0')
    WritePlayerConfiguration('配置', '百变脸谱', '0')
    WritePlayerConfiguration('配置', '苏州血脉觉醒', '0')
    WritePlayerConfiguration('配置', '百宝阁购物', '0')
    BuyBaiBaoGeItem()
    WritePlayerConfiguration('配置', '自动开宝箱', '1')
    WritePlayerConfiguration('配置', '打图环数', '50')
    WritePlayerConfiguration('配置', '挖图加血', '50')
    WritePlayerConfiguration('配置', '副本存仓补给', '0')
    SetXueJiPet()

    WritePlayerConfiguration('物资数据', '卖NPC物品', '[勾][类]奇物|[勾]山海金币|[勾]元丰通宝|[勾]元丰重宝|[勾]活跃金币|[勾]财富金币|[勾]熊猫金币|[勾]鸿福金币|[勾]巢氏古器皿|[勾]签名足球|[勾]少室山古币|通用鉴定符10级|古旧的钱币|镇海刀|绵制囊|玄衣残铁|鸿运金币|鉴定书10级|鉴定卷轴10级|鉴定符10级|机关枢纽|天机枢纽')
    WritePlayerConfiguration('物资数据', '绑定销毁', '[勾]绛紫仙露|登高折萸图|功力丹|五毒珠·元阳|五毒珠·魂武|五毒珠·星眸|缀龙石·元|缀龙石·暴|缀龙石·伤|地煞强化精华|千淬神玉|上品少阳丹|百淬神玉|神魂液|玄天寒玉|玉龙髓|龙纹玉灵|铸纹血玉|典籍残页|玄昊玉|寒冰星屑|龙纹|神亦石|精铁碎片|灵鹫石')
    WritePlayerConfiguration('物资数据', '强制销毁', '[勾][类]初级肉类|[勾][类]中级肉类|[勾][类]高级肉类|[勾][类]初级皮毛|[勾][类]中级皮毛|[勾][类]高级皮毛|[勾][类]铸造类材|[勾][类]制药材料|[勾][类]缝纫类材|[勾][类]工艺材料|[勾][类]刀组类|[勾][类]箫剑类|[勾][类]单短类|[勾][类]双短类|[勾][类]环类|[勾][类]扇类|[勾][类]枪棒类|[勾][类]刀斧类|[勾][类]弩类|[勾][类]长杖类|[勾][类]帽子|[勾][类]护肩|[勾][类]手套|[勾][类]腰带|[勾][类]戒指|[勾][类]护符|[勾][类]衣服|[勾][类]项链|[勾][类]护腕|[勾][类]鞋|[勾]精铁矿石|[勾]粗制棉布|[勾]长生草|[勾]灵兽环|[勾]灵兽饰|[勾]灵兽甲|[勾]灵兽爪|[勾]灵兽面|[类]技能书|[类]鬼市材料|[类]鬼市道具|低级宝石熔炼符|雪拥蓝关·移穴1级|横剑疆场·知1级|冰魂技能书|高级聚毒|万灵石1级|高级释玄|高级凝冰|高级沸血|冰天雪地技能书|翡翠双冬蹄膀食谱|九阴神爪·知1级|西子捧心·知1级|枪棒打造图6级|福降令|香菇滑鸡食谱|动作：江湖我行|烈火咒技能书|坐骑：鹜影雕|玄魂技能书|火魂技能书|玄兽技能书|冰精技能书|火烧赤壁·知1级|葵花点穴手·解1级|麻辣鸭胗食谱|万箭齐发·知1级|一筐苹果|坐骑：如意虎|大力金刚掌·知1级|中冲剑·护壁1级|一拍两散·风行1级|高级灵动技能书|黄油鲅鱼食谱|火灵技能书|灵狸帽图样|高级虚弱|挥斥方遒·附1级|雪泥鸿爪·调息1级|弹指神功·知1级|棒打狗头·解1级|高级伪装技能书|连珠腐尸毒·知1级|高级肉墙技能书|高级重生技能书|寒冰咒技能书|血毒咒技能书|五雷轰顶技能书|玄兵石|玄兵石碎片|玄雷咒技能书|双短打造图6级|双短打造图7级|连击技能书|高级共生技能书|高级灵气技能书|高级猛击技能书|解穴|高级神佑技能书|高级识破技能书|高级冰爆技能书|高级血爆技能书|高级韧筋|肉墙技能书|碗仔翅食谱|核桃鸡丁食谱|高级凝神技能书|高级借力技能书|痛击技能书|高级反击技能书|高级反震技能书|高级打怒技能书|高级忠心技能书|高级瞬影技能书|高级附身技能书|高级强身技能书|高级嗜血技能书|识破技能书|反击技能书|高级移魂技能书|冰爆技能书|玄云盔图样|低级刻铭符|凶陌圣靴图样|鱼香碎白肉食谱|万灵石5级|仙人指路·知1级|噬麟玄手图样|软绸衣图样|烤肉盖饭食谱|凶陌圣掌图样|海带牛肉汤食谱|幻世圣巾图样|轻灵|枪棒打造图4级|万灵石7级|结义酒|扇打造图7级|盐煎肉食谱|高级破绽|冰花球|洒脱|山椒醉鸡翅食谱|幻世魔腕图样|凶陌圣盔图样|清醒|高级铁骨|万灵石6级|幻世魔肩图样|幻世圣靴图样|高级摔绊|木耳猪肉片食谱|单短打造图4级|血祭技能书|干炸鲫鱼食谱|噬麟圣冠图样|双短打造图2级|星河虹吸·疾1级|刀斧打造图7级|仙侣情缘图样|奶油煎饼食谱|武器力量雕纹图样|暗器定力雕纹图样|幻世手套图样|要诀：天下无狗|步月图样|动作：七夕情侣|聚毒|地夕护手图样|刀斧打造图4级|粉墨人生图样|黄金战甲图样|法魂技能书|枪棒打造图7级|摔绊|神佑技能书|暗夜百合图样|高级吸气技能书|川肉丝食谱|水鸭润肺汤食谱|刀斧打造图6级|双短打造图4级|刀斧打造图5级|释玄|灵鹫石|双短打造图3级|环打造图3级|凝冰|沸血|单短打造图5级|扇打造图6级|佛语图样|段誉语嫣图样|精准|百变如意：呼延豹|环打造图6级|扇打造图2级|疾闪|未央图样|固元|打怒技能书|治疗技能书|噬麟圣裘图样|鸾凤和鸣图样|环打造图5级|双短打造图5级|噬麟圣履图样|暗器：石灰包|瞬影技能书|灵动技能书|焚焰|铁骨|吸气技能书|大行囊|凝神技能书|反震技能书|灵气技能书|枪棒打造图2级|浚云之角|拼命技能书|龙渊图样|斩关图样|扇打造图5级|飞雪图样|借力技能书|高级宝石熔炼符|大格箱|憨厚技能书|血色战甲图样|凤雏图样|高级治疗技能书|韧筋|榆木箱|蛮力技能书|苗域风情图样|女真氏服图样|苍龙图样|嗜血技能书|吉祥戒指图样|单短打造图6级|单短打造图3级|扇打造图3级|狡猾技能书|刀斧打造图2级|蝶恋图样|猛击技能书|血爆技能书|百淬神玉|迟钝技能书|单短打造图7级|忠心技能书|破绽|枪棒打造图5级|环打造图2级|武器灵气雕纹图样|强身技能书|百战图样|切韵|幻世魔衣图样|动作：野蛮女友|凶陌圣甲图样|明目|衣服打造图7级|帽子打造图7级|护腕打造图7级|鞋子打造图7级|护符打造图7级|戒指打造图7级|项链打造图7级|腰带打造图7级|护肩打造图7级|手套打造图7级|衣服打造图6级|帽子打造图6级|护腕打造图6级|鞋子打造图6级|护符打造图6级|戒指打造图6级|项链打造图6级|腰带打造图6级|护肩打造图6级|手套打造图6级|衣服打造图5级|帽子打造图5级|护腕打造图5级|鞋子打造图5级|护符打造图5级|戒指打造图5级|项链打造图5级|腰带打造图5级|护肩打造图5级|手套打造图5级|衣服打造图4级|帽子打造图4级|护腕打造图4级|鞋子打造图4级|护符打造图4级|戒指打造图4级|项链打造图4级|腰带打造图4级|护肩打造图4级|手套打造图4级|衣服打造图3级|帽子打造图3级|护腕打造图3级|鞋子打造图3级|护符打造图3级|戒指打造图3级|项链打造图3级|腰带打造图3级|护肩打造图3级|手套打造图3级|衣服打造图2级|帽子打造图2级|护腕打造图2级|鞋子打造图2级|护符打造图2级|戒指打造图2级|项链打造图2级|腰带打造图2级|护肩打造图2级|手套打造图2级|衣服打造图1级|帽子打造图1级|护腕打造图1级|鞋子打造图1级|护符打造图1级|戒指打造图1级|项链打造图1级|腰带打造图1级|护肩打造图1级|手套打造图1级|湘妃箭|暗器：散功钉|移魂技能书|虚弱|伪装技能书|共生技能书|绵制囊|碧玉护腕|沙参银耳粥|重阳糕|虎骨膏|百露箱|百果养生粥|蓝牡丹|珍兽幻化丹碎片|川贝百合粥|绿豆糕|芝麻饼|油钱|锦色炒饭|烤玉米|油面筋|神定丸|回心丹|生地麦冬粥|手套身法雕纹图样|眼镜蛇|银环蛇|首乌|藿香|回神草|流云膏|蝎子|行血散|活血散|百脉散|百花丸|金创药|清心散|仙丹阴阳|仙丹寒烟|仙丹辉月|魂冰珠（1级）|金环蛇|蜘蛛|毒蜂|蜈蚣|蟾蜍|贝叶经残片|紫竹箭|玉犀角|大蒜|八角|翡翠矿石|香菇菜包|芭蕉咸饭|苕糕|糯米糕|杏仁酥|清明粑|碧玉戒指|灵魂碎片·橙|玄昊玉|寒冰星屑|长生草|赤霞仙露|绛紫仙露|夜光杯|不老膏|秘银矿石|夏蝉|楠木箱|千佛莲灯|扇打造图4级|枪棒打造图3级|暗器：小石子|暗器：迷魂烟|暗器：绊马索|珍兽蛋：英招|灵兽丹·虚（1级）|附身技能书|要诀：落马箭|百变如意：慕容复|百变如意：岳老三|百变如意：云中鹤|环打造图4级|怪物相册|重生技能书|珍兽换颜丹|灵魂碎片·黄|祝福毛笔|妖符：变羊|易容丹：冰块|暗器：捆仙绳|环打造图7级|刀斧打造图3级|灵药：疾行丸|熔金粉|染料3级|单短打造图10级|龙魂玉|单短打造图2级|全真行功要诀|康乃馨|丝线3级|忘无石|宝石雕琢符1级|竹箭|扇打造图10级|双短打造图10级|环打造图10级|刀斧打造图10级|牦牛角|易容丹：雪人|枪棒打造图10级|水牢令牌|万灵石4级|黑暗牙齿|采香丸|鹿茸丹|兰沁护腕|粉皮|试炼令牌|煎饼|辽阵情报|窝窝头|玉龙髓|水晶丸子|妖兽丹|风丹|云吞面|延寿膏|弥道尺|绛麻衣|棉僧衣|锦绸衣|绢丝衣|哭丧棒|雁翎刀|松纹剑|娥眉刺|灵鳌步|一苇渡江|草上飞|水上漂|青铜令|黄铜戒|翠玉佩|白珍珠|黄鬃马|褐鬃马|黑鬃马|云鬃马|太祖长拳|天山折梅手|大理剑诀|美女拳法|稀世珍宝图|蜜枣丸|苏合香豆粥|波斯羊腿|豆蔻丹|回梦石|七窍丸')
    WritePlayerConfiguration('物资数据', '绑定卖出', '[勾][类]鉴定符|[勾][类]鉴定书|[勾][类]鉴定卷轴|山海金币|古旧的钱币|武运金币|五彩晶石|破碎的晶片|秘籍残页|巢氏古器皿|悲酥清风解药|机关枢纽|天机枢纽|云侠币')
    WritePlayerConfiguration('物资数据', '存入锦囊', '武魂延寿丹|新莽神符7级|回天神石|3级宝石碎片兑换券|润物露|低级宝石合成符')
    WritePlayerConfiguration('物资数据', '天机取出', '[类]鬼市材料|[类]鬼市道具|[类]心诀道具|玄兵石|玄兵石碎片|足太阴脉运功典藏|黄纸|唤灵液|翡翠心精|征南先锋印|上品少阳丹|五毒珠·元阳|五毒珠·魂武|五毒珠·星眸|雅韵古匣·珍品|督脉运功典藏|归山令|藏金券|巢氏古器皿|鉴定卷轴10级|鉴定书10级|鉴定符10级')
    WritePlayerConfiguration('物资数据', '使用物品', '雪芝药散|归宁澄心华盒|静心雅盒|砥砺奋战礼包|表情包：哞哞牛|100绑定元宝|200绑定元宝')

    WritePlayerConfiguration('组队', '燕子坞最低', '6')
    WritePlayerConfiguration('组队', '凤鸣最低', '6')
    WritePlayerConfiguration('组队', '三神最低', '6')
    WritePlayerConfiguration('组队', '少室山最低', '6')
    WritePlayerConfiguration('组队', '缥缈峰最低', '6')
    WritePlayerConfiguration('组队', '老三环最低', '6')
    WritePlayerConfiguration('组队', '四绝最低', '6')
    WritePlayerConfiguration('组队', '刷棋最低', '6')
    WritePlayerConfiguration('组队', '琅嬛福地', '6')
    WritePlayerConfiguration('组队', '蹴鞠踢球', '6')
    WritePlayerConfiguration('组队', '观山海', '6')
    WritePlayerConfiguration('组队', '兵圣最低', '12')
    WritePlayerConfiguration('组队', '天波府最低', '12')

    WritePlayerConfiguration('跟随', '走收费传送', '1')

    WritePlayerConfiguration('副本', '模式副本', '四绝庄|燕子坞|三环(老)|缥缈峰|天龙幻境')
    WritePlayerConfiguration('燕子坞', '躲大群', '0')
    WritePlayerConfiguration('燕子坞', '死亡等待', '1')
    WritePlayerConfiguration('缥缈峰', '跑位模式', '2')
    WritePlayerConfiguration('缥缈峰', '自动神佑', '0')
    WritePlayerConfiguration('三神幻境', '等待救活', '1')
    WritePlayerConfiguration('四绝庄', '等待救活', '1')

    WritePlayerConfiguration('日常', '换勾天彩', '1')
    WritePlayerConfiguration('日常', '开活跃礼包', '1')
    WritePlayerConfiguration('日常', '礼物类型', '九天玉碎')
    WritePlayerConfiguration('日常', '领修武之约', '1')
    if string.find(领紫微名单, playerName) then
        WritePlayerConfiguration('日常', '领紫薇奖励', '1')
    end
    WritePlayerConfiguration('日常', '兑换历练值', '0')
    WritePlayerConfiguration('日常', '寒纹玉购买', '0')
    if string.find(寒纹玉买真元名单, playerName) then
        WritePlayerConfiguration('日常', '寒纹玉商品', '瑶华璧|超级珍兽还童天书|紫府星髓|紫色真元符集')
    else
        WritePlayerConfiguration('日常', '寒纹玉商品', '瑶华璧|超级珍兽还童天书|紫府星髓')
    end
    WritePlayerConfiguration('日常', '素云锦购买', '0')
    WritePlayerConfiguration('日常', '素云锦商品', '武魂延寿丹')
    WritePlayerConfiguration('日常', '物锦华袋礼物', '瑶华壁')
    WritePlayerConfiguration('日常', '琼楼送花', '0')

    WritePlayerConfiguration('刷马', '走收费传送', '1')
    WritePlayerConfiguration('刷马', '定位回城', '1')
    WritePlayerConfiguration('刷马', '只捡所需', '1')
    WritePlayerConfiguration('刷马', '回城组队', '1')
    WritePlayerConfiguration('刷马', '退出跟随', '1')
    WritePlayerConfiguration('刷马', '自动存仓', '0')
    WritePlayerConfiguration('刷马', '补给宠粮', '0')
    WritePlayerConfiguration('刷马', '自动踢人', '0')
    WritePlayerConfiguration('刷马', '等待队员时间', '20')
    WritePlayerConfiguration('刷马', '失效时间', '2')
    WritePlayerConfiguration('刷马', '等包延时', '2')
    WritePlayerConfiguration('刷马', '优先杀低血', '1')

    WritePlayerConfiguration('打图挖图', '买做定位', '1')
    WritePlayerConfiguration('打图挖图', '定位回城', '1')

    WritePlayerConfiguration('百花缘', '任务环数', '20')

    WritePlayerConfiguration('任务', '惩凶打图次数', '50')

    WritePlayerConfiguration('九黎余孽', '任务NPC', '')
    WritePlayerConfiguration('九黎余孽', '打怪X', '182')
    WritePlayerConfiguration('九黎余孽', '打怪Y', '156')

    WritePlayerConfiguration('寻影九黎', '设置', '九黎虎牙将军*103*84|九黎镇护将军*107*31|九黎安远将军*183*39|可疑的炎黄英灵*72*43|可疑的不灭祭司*77*124|可疑的蛮荒战魂*203*212|可疑的深海幼鲨*47*47|可疑的赤炎豹*60*51|可疑的紫魂魈*188*83|可疑的巨螯蟹*160*96|可疑的雷麟兽*212*53|可疑的通天岩怪*122*193|可疑的海岸灵龟*129*150|可疑的百瘴狸*208*168')

    WritePlayerConfiguration('杯酒尽江湖', '自己喝酒', '1')
    WritePlayerConfiguration('杯酒尽江湖', '队伍斟酒', '1')
    WritePlayerConfiguration('杯酒尽江湖', '时间', '3')

    -- TODO
    WritePlayerConfiguration('自动交易', '交易物品', '三鲜卷|糍粑|叶儿粑|筒仔糕|桃酥|冰灵散|霸王丸|天眼丹|阴月散|珍兽还童卷轴|轻身散|鹤羽丹|天香膏|龙牙散|衣服打造图10级|帽子打造图10级|护腕打造图10级|鞋子打造图10级|护符打造图10级|戒指打造图10级|项链打造图10级|腰带打造图10级|护肩打造图10级|手套打造图10级|绿晶石(1级)|红晶石(1级)|蓝晶石(1级)|黄晶石(1级)|红宝石(1级)|绿宝石(1级)|黄宝石(1级)|黑宝石(1级)|蓝宝石(1级)|变石(1级)|虎眼石(1级)|猫眼石(1级)|祖母绿(1级)|皓石(1级)|紫玉(1级)|碧玺(1级)|黄玉(1级)|月光石(1级)|石榴石(1级)|尖晶石(1级)|丹青|高级珍兽还童卷轴|落星之箭|果仁豆皮|红豆饭|一品粥|米纸饼|花生汤圆|酸辣鱼片|四喜丸子|鱼香茄饼|酒蒸鸡|龙纹玉灵|灵鹫石|麟木箭|五毒珠·元阳|五毒珠·魂武|五毒珠·星眸|释灵浆|释玄|焚焰|聚毒|凝冰|精准|疾闪|高级释玄|高级焚焰|高级聚毒|高级凝冰|高级精准|高级疾闪|连击技能书|高级连击技能书|高级痛击技能书|血毒万里技能书|烈火燎原技能书|玄兽技能书|冰魂技能书|冰天雪地技能书|五雷轰顶技能书|寒冰咒技能书|烈火咒技能书|血毒咒技能书|玄雷咒技能书|火灵技能书|冰精技能书|毒魂技能书|毒蛊技能书|高级血祭技能书|咆哮技能书|净化技能书|净云水|铸纹血玉|棉布碎片|秘银碎片|精铁碎片|沸血|低级宝石合成符|彩虹之箭|飞瀑之角|花生|缀龙石·元|缀龙石·伤|缀龙石·暴|武魂灵珠|高级沸血|豪侠印体力雕纹图样|低级刻铭符|地煞强化精华|要诀：百炼焠刃|要诀：苦昼短|新莽神符2级|高级血爆技能书|高级神佑技能书|高级肉墙技能书|月落西山·明1级|天外飞仙·护体1级|七星聚首·护体1级|溪山行旅·精准1级|要诀：清心普善咒|缀梦灵石|要诀：仙风道骨|要诀：天地明灭|八阵图·调息1级|同生共死·解1级|溪山行旅·化解1级|月落西山·盲1级|陶然一醉·护体1级|紫金石|元宝票')
    WritePlayerConfiguration('自动交易', '接受地图', '苏州')
    WritePlayerConfiguration('自动交易', '接受X', '211')
    WritePlayerConfiguration('自动交易', '接受Y', '288')
    WritePlayerConfiguration('自动交易', '老板地图', '苏州')
    WritePlayerConfiguration('自动交易', '老板X', '211')
    WritePlayerConfiguration('自动交易', '老板Y', '288')
    WritePlayerConfiguration('自动交易', '老板名称', '樱╭ァ小染')  -- TODO
    WritePlayerConfiguration('自动交易', '保留金', '5')
    WritePlayerConfiguration('自动交易', '保留元宝', '0')
    WritePlayerConfiguration('自动交易', '完成地图', '苏州')
    WritePlayerConfiguration('自动交易', '完成X', '211')
    WritePlayerConfiguration('自动交易', '完成Y', '288')
    WritePlayerConfiguration('自动交易', '交易失败', '等待处理')
    WritePlayerConfiguration('自动交易', '交易限时', '9999')
    WritePlayerConfiguration('自动交易', '道具栏不够', '自动存仓')
    WritePlayerConfiguration('自动交易', '材料栏不够', '自动存仓')
    WritePlayerConfiguration('自动交易', '等待时间', '30')
    WritePlayerConfiguration('自动交易', '等待超时', '继续等待')
    WritePlayerConfiguration('自动交易', '发送间隔', '20秒')

    WritePlayerConfiguration('自动抢购', '赛鲁班', '护符打造图10级|戒指打造图10级')
    WritePlayerConfiguration('自动抢购', '范大成', '紫玉|红晶石|蓝晶石|黄晶石|绿晶石|虎眼石|变石|猫眼石')
    WritePlayerConfiguration('自动抢购', '朱超重', '红宝石|黄晶石|蓝晶石|红晶石|绿晶石|蓝宝石|绿宝石|紫玉|祖母绿|黄玉|皓石|月光石|碧玺|猫眼石|虎眼石|黄宝石|变石|石榴石|尖晶石|黑宝石')
    WritePlayerConfiguration('自动抢购', '包世商', '红宝石|黄晶石|蓝晶石|红晶石|绿晶石|蓝宝石|绿宝石|紫玉|祖母绿|黄玉|皓石|月光石|碧玺|猫眼石|虎眼石|黄宝石|变石|石榴石|尖晶石|黑宝石')
    WritePlayerConfiguration('自动抢购', '郎夫人', '红宝石|绿宝石|祖母绿|碧玺|皓石|月光石|黄玉|猫眼石|虎眼石|黄宝石|变石|石榴石|尖晶石|黑宝石')
    WritePlayerConfiguration('自动抢购', '步青云', '红宝石|黄晶石|蓝晶石|红晶石|绿晶石|蓝宝石|绿宝石|紫玉|祖母绿|黄玉|皓石|月光石|碧玺|猫眼石|虎眼石|黄宝石|变石|石榴石|尖晶石|黑宝石')
    WritePlayerConfiguration('自动抢购', '李乐施', '护符打造图10级|戒指打造图10级')
    WritePlayerConfiguration('自动抢购', '抢购间隔', '110')

    WritePlayerConfiguration('兵圣', '低血等待', '0')
    WritePlayerConfiguration('兵圣', '死亡立即出窍', '0')
    WritePlayerConfiguration('兵圣', '强攻BOSS', '0')
    WritePlayerConfiguration('兵圣', '等待血量低于开打', '0')
    WritePlayerConfiguration('兵圣', '困难模式', '1')
    WritePlayerConfiguration('兵圣', '石堆模式', '1')
    WritePlayerConfiguration('兵圣', '调整团队', '0')
    WritePlayerConfiguration('兵圣', '站位模式', '1')
    WritePlayerConfiguration('兵圣', '优先打石堆', '1')

    WritePlayerConfiguration('少室山', '慕容博状态', '4')

    WritePlayerConfiguration('定位设置', '制作定位', '1')
    WritePlayerConfiguration('定位设置', '制作张数', '3')
    WritePlayerConfiguration('定位设置', '黄纸金', '0')
    WritePlayerConfiguration('定位设置', '黄纸银', '0')
    WritePlayerConfiguration('定位设置', '黄纸铜', '0')
    WritePlayerConfiguration('定位设置', '购买定位', '')

    WritePlayerConfiguration('打架', '定位方式', '跟随队长团长')
    WritePlayerConfiguration('打架', '跟随范围', '2')
    WritePlayerConfiguration('打架', '用土灵珠', '1')
    WritePlayerConfiguration('打架', '随时定位', '1')
    WritePlayerConfiguration('打架', '跟随优先', '1')
    WritePlayerConfiguration('打架', '跨图跟随', '1')
    WritePlayerConfiguration('打架', '攻击目标', '1*0|2*0|3*0|4*0|5*0')
    WritePlayerConfiguration('打架', '攻击顺序', '1*0|2*0|3*0')
    WritePlayerConfiguration('打架', '死亡等待', '0')
    WritePlayerConfiguration('打架', '校场回蓝', '1')
    WritePlayerConfiguration('打架', '出地府', '凤鸣镇')
    WritePlayerConfiguration('打架', '自动月落红名', '1')
    WritePlayerConfiguration('打架', '血量低于', '70')

    WritePlayerConfiguration('简易打怪', '怪物名称', '贾川|千年冰魄|冰妖|无敌飞天猫|玄击金刚|玄击神将|秋三十娘|金裳|袁公子|王君|白岑|孟昧|孙立者|彭侯|白冥启|冥虚奴|闪电狗|企鹅王|木桶伯|吸血蝙蝠|啮魂蜥蜴|霜影|利爪邪鹰|噬心鬼豹|斯羽|南海混江小龙|东海混江小龙|西海混江小龙|北海混江小龙|混江龙|莽牯毒蛤')
    WritePlayerConfiguration('简易打怪', '打怪模式', '1')
    WritePlayerConfiguration('简易打怪', '跟随队长', '1')
    WritePlayerConfiguration('简易打怪', '土灵珠定位', '1')
    WritePlayerConfiguration('简易打怪', '土灵珠回点', '1')
    WritePlayerConfiguration('简易打怪', '跟随距离', '1')
    WritePlayerConfiguration('简易打怪', '死亡不出窍', '0')

    WritePlayerConfiguration('夜探天波府', 'BOSS1定点站位', '0')
    WritePlayerConfiguration('夜探天波府', 'BOSS2不躲横冲直撞', '0')
    WritePlayerConfiguration('夜探天波府', 'BOSS2不躲怒鳄袭沙', '0')
    if string.find(天波府BOSS2定点躲避狂卷八荒名单, playerName) then
        WritePlayerConfiguration('夜探天波府', 'BOSS2定点躲避狂卷八荒', '1')
    else
        WritePlayerConfiguration('夜探天波府', 'BOSS2定点躲避狂卷八荒', '0')
    end
    WritePlayerConfiguration('夜探天波府', 'BOSS4分散站位', '1')
    WritePlayerConfiguration('夜探天波府', '等待救活', '1')

    WritePlayerConfiguration('聚灵谷', '不打雷锁', '0')
    WritePlayerConfiguration('聚灵谷', '副本次数', '8')
    WritePlayerConfiguration('聚灵谷', '打怪地图', '1')
    WritePlayerConfiguration('聚灵谷', '雪海沧龙', '0')
    WritePlayerConfiguration('聚灵谷', '剧毒乌犍', '0')
    WritePlayerConfiguration('聚灵谷', '玄雷宝驹', '0')
    WritePlayerConfiguration('聚灵谷', '赤焰黑虎', '0')
    WritePlayerConfiguration('聚灵谷', '等待集合加血加状态', '1')

    WritePlayerConfiguration('心诀升级', '心诀', '准星·火|巾帼·火|高门·火|投巫·火|枕戈|刺心·火|巾帼·冰|巾帼·玄|巾帼·毒|伤魂|祯祥|遣美·冰|遣美·火|遣美·玄|遣美·毒|高门·冰|高门·玄|高门·毒|投巫·冰|投巫·玄|投巫·毒|捧心·冰|捧心·火|捧心·玄|捧心·毒|誓江·冰|誓江·火|誓江·玄|誓江·毒|还珠·冰|还珠·火|还珠·玄|还珠·毒|呼庙|泣玉|听镜|坐啸|当垆|燕然|望洋|刻木|捷对|断机|泛湖|涌泉|吐屑|尹京|让梨|辩日|云梯|黄雀|止啼|悲扇|青衫|折巾|落帽|咏絮|体轻|七步|川上|非次|渡江|泣岐|刺心·冰|刺心·玄|刺心·毒|奇骨·冰|奇骨·火|奇骨·玄|奇骨·毒|大千·冰|大千·火|大千·玄|大千·毒|心眼·冰|心眼·火|心眼·玄|心眼·毒|神伏|诛心·冰|诛心·火|诛心·玄|诛心·毒|灵运·冰|灵运·火|灵运·玄|灵运·毒|准星·冰|准星·玄|准星·毒|昏雨|掷水|姑射|博望|拜幕|负鼎|持节|三味')
    WritePlayerConfiguration('秘技升级', '秘技', '秘技=烈火灼心|四面楚歌|青眼有加|龟寿千年|重耳纵火|投壶问月|大江之势|越王破吴|诛清君侧|百二秦关|鼎湖龙吟|避守孤城|汴和抱玉|桃源避难|春风江南|攻守兼备|刺血书经|直捣黄龙|易水萧萧|图穷匕现|鹤顶为丹|三尺冰冻|铁锁横江|妇人之毒|临渊履冰|文姬思乡|羿妻窃药|昭君落雁|药石之力|反戈一击|冰蚕语寒|火鼠言热|黄金铸台|安禅破毒|盔甲护心|随侯获珠|步袜生尘|东山高卧|冰雪交加|裹步不前|魏武持刀|三刀入梦|周王一怒|飞燕轻姿|兵甲护塞|龟鹤延年')

    WritePlayerConfiguration('队伍自动状态', '地图', '洛阳')
    WritePlayerConfiguration('队伍自动状态', 'X', '185')
    WritePlayerConfiguration('队伍自动状态', 'Y', '336')
    WritePlayerConfiguration('队伍自动状态', '等待时长', '3')

end

-- main ------------------------------------------------------------------------------------
main()