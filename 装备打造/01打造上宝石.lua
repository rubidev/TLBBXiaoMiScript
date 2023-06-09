开启晴天提示 = 1
开启打孔8级 = 1  --老区打孔配置8级以下都是8级
开启帮会取打孔 = 0

---------------------------------------------------------------------------
神器名字列表 = "雷鸣离火扇|秋水无痕剑|碧海银涛环|奕天破邪杖|天星耀阳环|含光弄影剑|万仞龙渊剑|雷鸣离火扇|碎情雾影环|赤焰九纹刀|斩忧断愁枪|转魂灭魄钩|星移无痕剑|凌霄玉琼弩|炽焰九龙刀|绝情裂影环|忘忧销魂枪|法天辟邪杖|星移月动剑|星云聚日环|灭魂轮回钩|九转龙泉剑|天光流影剑|天雷真火扇|九霄华琼弩|大夏龙雀|大商尘影|大周岚夜|大秦锋镝|大汉弘纲|大晋星痕|大隋凝霜|大唐昆岳|大宋君岑|大燕韵章|大梁辟天|九霄焱阳|洪荒龙舞|达摩一叹|无相绝踪|万世枯荣|太古飘翎|大衍天玄|末世王权|倚天长生|六道黄泉|天影天诛"

装备名字集合 = "金翅翎羽|琉璃焰|凶陌圣盔|幻世魔衣|步月|蝶恋|幻世圣巾|幻世圣靴|幻世魔腕|幻世魔肩|幻世手套|噬麟圣裘|沐水天衣|沐水天肩|沐水天靴|沐水天腕|沐水手套|沐水天靴|催雪|步月|妖言|霜晓|醉舞|川暮|梅花镖|霸王令|御瑶盘|龙纹|梅花镖|断魂镖|凶陌圣甲|蝶恋|横笛|霸王令|冰魄神针|玄魄天裘|轻寒|佛语|横笛|浅浪|川暮|醉舞|轻寒|飞雪|断魂镖"

装备名字集合 = 神器名字列表 .. "|" .. 装备名字集合

装备关键字集合 = "豪侠印"

取出物品("金币", 20000000)
取出物品("3级宝石兑换券|宝石雕琢符3级|宝石镶嵌符|红宝石(3级)|飞瀑之角|落星之箭|纯净绿晶石(3级)|纯净红晶石(3级)|纯净黄晶石(3级)|纯净绿晶石(3级)|纯净蓝晶石(3级)|纯净黄玉(3级)|纯净皓石(3级)|纯净月光石(3级)|纯净碧玺(3级)|纯净蓝晶石(3级)|祖母绿(3级)|紫玉(3级)|")

打孔材料数组 = {
    [1] = { name = "牛角", YBpirce = 8, JINpirce = 10 * 10000, equipName = "" },
    [2] = { name = "竹箭", YBpirce = 16, JINpirce = 10 * 10000, equipName = "" },
    [3] = { name = "牦牛角", YBpirce = 24, JINpirce = 10 * 10000, equipName = "" },
    [4] = { name = "紫竹箭", YBpirce = 32, JINpirce = 10 * 10000, equipName = "" },
    [5] = { name = "玉犀角", YBpirce = 40, JINpirce = 10 * 10000, equipName = "" },
    [6] = { name = "湘妃箭", YBpirce = 48, JINpirce = 30 * 10000, equipName = "" },
    [7] = { name = "浚云之角", YBpirce = 56, JINpirce = 30 * 10000, equipName = "" },
    [8] = { name = "落星之箭", YBpirce = 64, JINpirce = 30 * 10000, equipName = "" },
    [9] = { name = "飞瀑之角", YBpirce = 72, JINpirce = 500 * 10000, equipName = "" },
    [10] = { name = "彩虹之箭", YBpirce = 80, JINpirce = 400 * 10000, equipName = "" },
    [11] = { name = "若水之角", YBpirce = 100, JINpirce = 300 * 10000, equipName = "" },
    [11] = { name = "列阵飞箭", YBpirce = 120, JINpirce = 300 * 10000, equipName = "" },
    [12] = { name = "寒玉精粹", YBpirce = 120, JINpirce = 40 * 10000, equipName = "" },

}

--------------------------------------------------装备相关------------------------------------------------
local SelfEuipList = {
    [1] = { name = "武器", downIndex = 11, equipIndex = 0, equipName = "",
            gem = {
                { "红宝石(4级)", "红宝石·红利(4级)", "红宝石(3级)", "红宝石·红利(3级)" },
                { "" },
                { "纯净&晶石(4级)", "纯净&晶石·红利(4级)", "纯净&晶石(3级)", "纯净&晶石·红利(3级)" },
                { "纯净&晶石(4级)", "纯净&晶石·红利(4级)", "纯净&晶石(3级)", "纯净&晶石·红利(3级)" },
            }
    }, --- 武器
    [2] = { name = "护腕", downIndex = 3, equipIndex = 14, equipName = "" }, --- 护腕
    [3] = { name = "戒指上", downIndex = 7, equipIndex = 6, equipName = "" }, --- 戒指（上）
    [4] = { name = "戒指下", downIndex = 8, equipIndex = 11, equipName = "" }, --- 戒指（下）
    [5] = { name = "护符上", downIndex = 9, equipIndex = 12, equipName = "" }, --- 护符（上）
    [6] = { name = "护符下", downIndex = 10, equipIndex = 13, equipName = "" }, --- 护符（下）
    [7] = { name = "衣服", downIndex = 12, equipIndex = 2, equipName = "" }, --- 衣服
    [8] = { name = "帽子", downIndex = 1, equipIndex = 1, equipName = "" }, --- 帽子
    [9] = { name = "护肩", downIndex = 2, equipIndex = 15, equipName = "" }, --- 肩膀
    [10] = { name = "手套", downIndex = 4, equipIndex = 3, equipName = "" }, --- 手套
    [11] = { name = "腰带", downIndex = 5, equipIndex = 5, equipName = "" }, --- 腰带
    [12] = { name = "鞋子", downIndex = 6, equipIndex = 4, equipName = "" }, --- 鞋子
    [13] = { name = "项链", downIndex = 13, equipIndex = 7, equipName = "" }, --- 项链
    [14] = { name = "暗器", downIndex = 14, equipIndex = 17, equipName = "",
             gem = {
                 { "红宝石(4级)", "红宝石·红利(4级)", "红宝石(3级)", "红宝石·红利(3级)" },
                 { "" },
                 { "纯净&晶石(4级)", "纯净&晶石·红利(4级)", "纯净&晶石(3级)", "纯净&晶石·红利(3级)" },
                 { "纯净&晶石(4级)", "纯净&晶石·红利(4级)", "纯净&晶石(3级)", "纯净&晶石·红利(3级)" },
             }
    }, --- 暗器
    [15] = { name = "龙纹", downIndex = 25, equipIndex = 19, equipName = "", gem = { 体力宝石, 属性宝石, 抗性宝石, 属性宝石 }, },
    [16] = { name = "武魂", downIndex = "", equipIndex = 18, equipName = "" }, --- 武魂
    [17] = { name = "令牌", downIndex = 16, equipIndex = 20, equipName = "" }, --- 令牌
    [18] = { name = "豪侠印", downIndex = "", equipIndex = 21, equipName = "",
             gem = {
                 { "红宝石(4级)", "红宝石·红利(4级)", "红宝石(3级)", "红宝石·红利(3级)" },
                 { "" },
                 { "纯净&晶石(4级)", "纯净&晶石·红利(4级)", "纯净&晶石(3级)", "纯净&晶石·红利(3级)" },
                 { "纯净&晶石(4级)", "纯净&晶石·红利(4级)", "纯净&晶石(3级)", "纯净&晶石·红利(3级)" },
             }
    }, --- 令牌
    [19] = { name = "物品包", downIndex = "", equipIndex = 9, equipName = "" }, --- 令牌
    [20] = { name = "材料包", downIndex = "", equipIndex = 10, equipName = "" }, --- 令牌
}

-----------------------------------------------------------------------------------------------------
function 晴天_友情提示(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【晴天QQ103900393提示】".."#eFF0000".."%-88s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
    --延时(300)
end

function 晴天_判断关闭窗口(strWindowName)
    if 窗口是否出现(strWindowName) == 1 then
        LUA_Call(string.format([[
			setmetatable(_G, {__index = %s_Env}) this:Hide()  
		]], strWindowName))
        延时(1500)
    end
end
function 晴天_写角色配置项(AAA, BBB, CCC)
    local 名字 = 获取人物信息(12)
    local 路径 = string.format("C:\\天龙小蜜\\角色配置\\%s.ini", 名字)
    if AAA ~= nil and BBB ~= nil and CCC ~= nil then
        晴天_友情提示("写角色配置项|" .. AAA .. "|" .. BBB .. "|" .. CCC);
        延时(200)
        写配置项(路径, AAA, BBB, CCC);
        延时(200)
    end
end

function 晴天_读角色配置项(AAA, BBB)
    local 名字 = 获取人物信息(12)
    local 路径 = string.format("C:\\天龙小蜜\\角色配置\\%s.ini", 名字)
    local tem = 读配置项(路径, AAA, BBB)
    if tem ~= nil then
        晴天_友情提示(AAA .. "|" .. BBB .. "==" .. tem);
        延时(500)
    else
        return 0
    end
    return tem
end

function 晴天_取人物属性(分类)
    --1是最高属性 2是门派
    local 人物等级 = tonumber(获取人物信息(26))
    local 人物名称, menpai, PID, 远近攻击, 内外攻击, 角色账号, 门派地址, 技能状态, 性别 = 获取人物属性()

    if 分类 == 1 then
        local tem = LUA_取返回值(string.format([[
			local iIceAttack  		= Player:GetData( "ATTACKCOLD" );
			local iFireAttack 		= Player:GetData( "ATTACKFIRE" );
			local iThunderAttack	= Player:GetData( "ATTACKLIGHT" );
			local iPoisonAttack		= Player:GetData( "ATTACKPOISON" );
		local tt={ iIceAttack, iFireAttack, iThunderAttack,iPoisonAttack}
		if iIceAttack==math.max(unpack(tt)) then
			maxOfT ="冰"
		elseif  iFireAttack==math.max(unpack(tt)) then
			maxOfT ="火"
		elseif  iThunderAttack==math.max(unpack(tt)) then
			maxOfT ="玄"
		elseif  iPoisonAttack==math.max(unpack(tt)) then
			maxOfT ="毒"
		end
		return maxOfT 
		]]), "s")
        属性攻击 = tem
        晴天_友情提示("晴天取人物最高属性攻击:" .. 属性攻击)
    elseif 分类 == 2 then
        if string.find("唐门|星宿|丐帮", menpai) then
            属性攻击 = "毒"
        elseif string.find("逍遥|明教|", menpai) then
            属性攻击 = "火"
        elseif string.find("峨嵋|天山|", menpai) then
            属性攻击 = "冰"
        elseif string.find("天龙|少林|鬼谷|慕容|武当", menpai) then
            属性攻击 = "玄"
        end
    else
        return -1
    end
    return tostring(属性攻击)
end

------------------------------------------------------------------------------------------------------------------------------------------------
local 人物等级 = tonumber(获取人物信息(26))
if 人物等级 < 90 then
    人物最高属性 = 晴天_取人物属性(2)
else
    人物最高属性 = 晴天_取人物属性(1)
end

if 人物最高属性 == "冰" then
    属性宝石颜色 = "蓝"
elseif 人物最高属性 == "火" then
    属性宝石颜色 = "红"
elseif 人物最高属性 == "玄" then
    属性宝石颜色 = "黄"
elseif 人物最高属性 == "毒" then
    属性宝石颜色 = "绿"
end

function 晴天_取所有钱()
    所有钱 = 获取人物信息(52) + 获取人物信息(45)
    return 所有钱
end

function 晴天_取身上装备持久(aaa)
    local tem = LUA_取返回值(string.format([[
		return EnumAction(%d,"equip"):GetEquipDur()
	]], aaa))
    return tonumber(tem)
end

function 晴天_取身上装备ID(aaa)
    local tem = LUA_取返回值(string.format([[
		return EnumAction(%d,"equip"):GetID()
	]], aaa))
    return tonumber(tem)
end

function 晴天_取身上装备名字(aaa)
    return LUA_取返回值(string.format([[
		return EnumAction(%d,"equip"):GetName()
	]], aaa))
end

function 晴天_取身上装备等级(aaa)
    local tem = LUA_取返回值(string.format([[
				local  index =%d
				local ID =EnumAction(index,"equip"):GetID()
				if ID > 0 then
					return	DataPool:GetEquipLevel(index)  --装备等级 暗器99了
				end
				return -1
			]], aaa))
    --return LifeAbility:GetWearedEquip_NeedLevel(index) --需要等级
    return tonumber(tem)
end

function 晴天_取身上装备位置等级(装备位置名称)
    for i = 1, #SelfEuipList do
        if SelfEuipList[i].name == 装备位置名称 then
            return 晴天_取身上装备等级(SelfEuipList[i].equipIndex)
        end
    end
end

function 晴天_取身上装备位置名字(装备位置名称)
    for i = 1, #SelfEuipList do
        if SelfEuipList[i].name == 装备位置名称 then
            local 装备名称 = 晴天_取身上装备名字(SelfEuipList[i].equipIndex)
            return 装备名称
        end
    end
end
--------------------------------------------------------------------

function 晴天_取背包装备等级(index)
    local aaa = LUA_取返回值(string.format([[
		return LifeAbility : Get_Equip_Level(%d);
	]], index))
    return tonumber(aaa)
end

function 晴天_取身上武魂生命()
    --300最大
    local tem = LUA_取返回值(string.format([[
		local ID =EnumAction(18,"equip"):GetID()
		if ID > 0 then
			tem= DataPool:GetKfsData("LIFE")
			return tem
		end
		return -1
			]]))
    return tonumber(tem)
end

--晴天_友情提示(晴天_取身上武魂生命())
--延时(30000)

function 晴天_取本周红利购买次数()
    local aaa = LUA_取返回值(string.format([[
			local nMD = math.mod(DataPool:GetPlayerMission_DataRound(1561),10);
			return nMD 
		]]))
    return tonumber(aaa)
end





---------------------------------------------------------必备函数-----------------------------------------------------------------


function 晴天_取下装备获取名字(装备位置名称)
    for i = 1, #SelfEuipList do
        if SelfEuipList[i].name == 装备位置名称 then
            晴天_友情提示("准备取下装备位置:" .. 装备位置名称)
            local 装备持久 = 晴天_取身上装备持久(SelfEuipList[i].equipIndex)
            if 装备位置名称 == "武魂" then
                local 装备持久 = 晴天_取身上武魂生命()
            end

            if tonumber(装备持久) <= 0 then
                --晴天_友情提示("装备持久不够,不取下")
                return 0
            end
            if 晴天_取身上装备ID(SelfEuipList[i].equipIndex) == 0 then
                return 0
            end

            for k = 1, 10 do
                local 装备名称 = 晴天_取身上装备名字(SelfEuipList[i].equipIndex)
                if 窗口是否出现("SelfEquip") ~= 1 then
                    LUA_Call("MainMenuBar_SelfEquip_Clicked();");
                    延时(2000)
                end
                if 装备位置名称 == "豪侠印" then
                    LUA_Call("setmetatable(_G, {__index = Xiulian_Env});Xiulian_JueWei_Page_Switch();");
                    延时(2000)
                    LUA_Call("setmetatable(_G, {__index = SelfJunXian_Env});SelfJunXian_Equip_Clicked(0);");
                    延时(2000)
                    晴天_判断关闭窗口("SelfJunXian")

                elseif 装备位置名称 == "武魂" then
                    晴天_友情提示("存入琉璃焰|御瑶盘|,防止错误")
                    延时(2000)
                    存物品("|琉璃焰|御瑶盘|", 0, 0, 1)

                    LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Wuhun_Switch();")
                    延时(2000)
                    LUA_Call("setmetatable(_G, {__index =  Wuhun_Env});Wuhun_Equip_Clicked(0);")
                    延时(2000)
                    晴天_判断关闭窗口("Wuhun")
                else
                    LUA_Call(string.format([[ setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Equip_Click(%d,0)]], SelfEuipList[i].downIndex))
                end
                延时(3000)
                if 晴天_取身上装备ID(SelfEuipList[i].equipIndex) == 0 then
                    晴天_判断关闭窗口("SelfEquip")
                    return 装备名称
                end
            end
            return 0
        end
    end
end

function 晴天_穿上装备(装备位置名称, 装备名称)
    if 装备名称 == "" then
        晴天_友情提示("参数错误,晴天_穿上装备")
        return
    end
    if 获取背包物品数量(装备名称) <= 0 then
        晴天_友情提示("没有装备无法使用,晴天_穿上装备")
        return
    end
    for i = 1, #SelfEuipList do
        if SelfEuipList[i].name == 装备位置名称 then
            for k = 1, 5 do
                if 装备位置名称 == "武魂" then
                    坐骑_下坐骑()
                    右键使用物品(装备名称);
                    延时(8000)
                else
                    右键使用物品(装备名称);
                    延时(2000)
                end
                if 晴天_取身上装备ID(SelfEuipList[i].equipIndex) > 0 then
                    晴天_友情提示(" 晴天成功穿上" .. 装备名称 .. "|在位置:" .. 装备位置名称)
                    break
                end
            end
        end
    end
    --晴天_友情提示(装备位置名称..":位置错误")
end

----------------------------------------------------------------------------------------------------------------------------
function 晴天_九州商会购买物品(名称, 数量, 单价格, 判断是否有物品, 页面查询, 数量加加)
    if not 数量加加 then
        数量加加 = 1
    end

    if not 页面查询 then
        页面查询 = 9
    end
    for ss = 1, 数量加加 do
        数量 = 数量 + 4
        for qq = 1, 页面查询 do
            屏幕提示(名称)
            if tonumber(判断是否有物品) == 1 then
                if 获取背包物品数量(名称) >= 1 then
                    屏幕提示("背包中有这个物品" .. 名称)
                    return false
                end
            end
            取出物品("金币", 200000)
            if 窗口是否出现("PS_ShopSearch") ~= 1 then
                计次循环
                i = 1, 5
                执行
                跨图寻路("洛阳", 330, 299)
                如果
                对话NPC("乔复盛") == 1
                则
                延时(1000)
                NPC二级对话("查看所有商店")
                延时(1000)
                如果
                窗口是否出现("PS_ShopList") == 1
                则
                LUA_Call([[setmetatable(_G, {__index = PS_ShopList_Env}) PS_ShopList_ChangeTabIndex(3)]])
                延时(1000)
                跳出循环
                结束
                结束
                结束
                --搜索物品
            end

            LUA_Call(string.format([[
         PlayerShop:PacketSend_Search(2 , 2, 1, "%s", %d)		
	]], 名称, qq))
            延时(1500)
            --遍历第一页有没有符合条件的商品
            local tem = LUA_取返回值(string.format([[
	        setmetatable(_G, {__index = PS_ShopSearch_Env})
			for i = 1 ,10 do 
				local theAction = EnumAction( i - 1 , "playershop_cur_page")
				if theAction:GetID() ~= 0 then
					--物品名,店主名,所属商店ID,数量,总价格
					local pName ,pShopName, pShopID ,pCount ,pYB = PlayerShop:GetItemPSInfo( i - 1 )			
					if pName ~= nil and pShopID ~= nil and pCount ~= nil and pYB ~= nil and pCount > 0 then
					    if pName == "%s" and pCount <= %d and pYB/pCount <= %d then
						   PushDebugMessage(pName.."/"..pShopName.."/"..pCount.."/"..pYB)
						   --点击购买后,直接返回
						   PlayerShop:SearchPageBuyItem(i - 1, "item")
						   return true
						end
					end
				end
			end
            return false
	]], 名称, 数量, 单价格), "b")
            延时(1500)
        end
        延时(200)
    end
end




----------------------------------------宝石相关行数---------------------------------



function 晴天_取身上装备孔位数量(index)
    --装备序号
    local tem = LUA_取返回值(string.format([[
		local holeCount  = LifeAbility : GetWearedEquip_HoleCount(%d)
		return  holeCount
	]], index))
    return tonumber(tem)
end

function 晴天_取身上装备位置孔位数量(装备位置名称)
    --装备位置名称
    for i = 1, #SelfEuipList do
        if SelfEuipList[i].name == 装备位置名称 then
            return 晴天_取身上装备孔位数量(SelfEuipList[i].equipIndex, 序号)
        end
    end
end

function 晴天_取身上装备宝石名称(序号, 第几个)
    if not 序号 then
        序号 = 0
    end
    if not 第几个 then
        序号 = 1
    end
    local tem = LUA_取返回值(string.format([[
				index = tonumber(%d)
		xuhao = tonumber(%d)
		local isHaveEquip, gemIndex1, gemIndex2, gemIndex3, gemIndex4  = LifeAbility:SplitWearedEquipGem(index)
		if isHaveEquip == 1 then
			if xuhao == 1 then
				if gemIndex1> 0 then 
					local name=  DataPool:Lua_GetItemNameByIndex(gemIndex1)
					return tostring(name)
				else 
					return tostring("没有宝石")
				end
			elseif xuhao == 2 then
				if gemIndex2> 0 then 
					local name=  DataPool:Lua_GetItemNameByIndex(gemIndex2)
					return tostring(name)
				else 
					return tostring("没有宝石")
				end
			elseif xuhao == 3 then
				if gemIndex3> 0 then 
					local name=  DataPool:Lua_GetItemNameByIndex(gemIndex3)
					return tostring(name)
				else 
					return tostring("没有宝石")
				end
			elseif xuhao == 4 then
				if gemIndex4 > 0 then 
					local name=  DataPool:Lua_GetItemNameByIndex(gemIndex4)
					return tostring(name)
				else 
					return tostring("没有宝石")
				end
			end
		end	
		return  -1
            	]], 序号, 第几个))
    return tostring(tem)
end

function 晴天_取身上装备位置宝石名称(装备位置名称, 序号)
    for i = 1, #SelfEuipList do
        if SelfEuipList[i].name == 装备位置名称 then
            return 晴天_取身上装备宝石名称(SelfEuipList[i].equipIndex, 序号)
        end
    end
end

function 晴天_取背包装备宝石数量(装备名称)
    if 获取背包物品数量(装备名称) > 0 then
        bHave = 获取背包物品位置(装备名称) - 1
    else
        return 5
    end
    local tem = LUA_取返回值(string.format([[
            local gemcount = LifeAbility:GetEquip_GemCount(%d)
				if gemcount==nil then
					return 0
				end
                return gemcount
            	]], bHave))
    return tonumber(tem)
end

function 晴天_取背包装备孔数量(装备名称)
    local bHave = tonumber(获取背包物品位置(装备名称)) - 1
    if bHave < 0 then
        return -1
    end
    local tem = LUA_取返回值(string.format([[
				return LifeAbility:GetEquip_HoleCount(%d)
            	]], bHave))
    return tonumber(tem)
end

function 晴天_自动处理寒玉精粹(材料名字)
    if 材料名字 ~= "寒玉精粹" then
        return
    end
    晴天_九州商会购买物品("寒玉精粹", 1, 100 * 10000, 1, 2)
    if 获取背包物品数量("寒玉精粹") >= 1 then
        屏幕提示("已经有材料 寒玉精粹 跳过任务")
        return
    end
    for i = 1, 9 do
        if 获取背包物品数量("玄天寒玉") < 5 then
            晴天_九州商会购买物品("玄天寒玉", 250, 20000, 1) --晴天_九州商会购买物品("高级忠心技能书", 1, 200000,1)
        end
    end

    while 获取背包物品数量("玄天寒玉") >= 5 do
        跨图寻路("楼兰", 187, 225);
        延时(1500)
        if 对话NPC("史嫂") == 1 then
            NPC二级对话("寒玉合成");
            延时(1500)
            NPC二级对话("我要合成");
            延时(1500)
            LUA_Call("setmetatable(_G, {__index = PlayerPackage_Env});PlayerPackage:PackUpPacket(1);");
            延时(1500)
        end
        if 获取背包物品数量("寒玉精粹") >= 1 then
            return
        end
    end
end

开启打孔8级 = 1
function 晴天_全背包序号自动打孔(序号, 目标孔数)
    for kkk = 1, 19 do
        local 装备等级 = 晴天_取背包装备等级(序号)
        if 装备等级 > 0 then
            打孔等级 = math.ceil(装备等级 / 10)
            if 打孔等级 <= 8 and 开启打孔8级 == 1 then
                --老区配置
                打孔等级 = 8
            end
            背包装备孔数量 = tonumber(LUA_取返回值(string.format([[
					return LifeAbility:GetEquip_HoleCount(%d)
				]], 序号)))
            if 背包装备孔数量 >= 目标孔数 then
                晴天_友情提示("背包位置:%d,孔数量:%d,目标孔数,跳过打孔", 序号, 背包装备孔数量, 目标孔数)
                延时(200)
                return
            end
            if 背包装备孔数量 == 3 then
                打孔等级 = 12
            end
            打孔材料 = 打孔材料数组[打孔等级].name
            打孔价格 = 打孔材料数组[打孔等级].JINpirce
            晴天_友情提示("背包位置:%d|装备等级:%d|装备打孔材料:%s|打孔价格:%d|目标打孔数量:%d", 序号, 装备等级, 打孔材料, 打孔价格, 目标孔数)
            if 获取背包物品数量(打孔材料) > 0 then
                nIndex = 获取背包物品位置(打孔材料) - 1
            else
                晴天_友情提示("打孔材料" .. 打孔材料 .. "不足")
                晴天_自动处理寒玉精粹(打孔材料)
                晴天_九州商会购买物品(打孔材料, 1, 打孔价格, 1, 3, 3)
                nIndex = 获取背包物品位置(打孔材料) - 1
            end
            if not string.find("洛阳|大理|洛阳|楼兰|钱庄", 获取人物信息(16)) then
                晴天_友情提示("不在地图洛阳|大理|洛阳|楼兰|钱庄,装备去洛阳 ")
                延时(1000)
                跨图寻路("洛阳", 280, 322)
            end

            if tonumber(背包装备孔数量) < 3 then
                晴天_友情提示("前三孔打孔")
                LUA_Call(string.format([[
			Clear_XSCRIPT()
			Set_XSCRIPT_Function_Name("StilettoEx_3")
			Set_XSCRIPT_ScriptID(311200)
			Set_XSCRIPT_Parameter(0,%d)--装备位置
			Set_XSCRIPT_Parameter(1,%d)--材料位置
			Set_XSCRIPT_ParamCount(2)
			Send_XSCRIPT()
			]], 序号, nIndex))
            else
                if 打孔材料 == "寒玉精粹" then
                    four = 2
                else
                    four = 1
                end
                LUA_Call(string.format([[
						Clear_XSCRIPT()
					Set_XSCRIPT_Function_Name("StilettoEx_4")
					Set_XSCRIPT_ScriptID(311200)
					Set_XSCRIPT_Parameter(0,%d)
					Set_XSCRIPT_Parameter(1,%d)
					Set_XSCRIPT_Parameter(2,%d)
					Set_XSCRIPT_ParamCount(3)
				Send_XSCRIPT()
						]], 序号, nIndex, four))
            end
        end
        延时(1000)
    end
end

function 晴天_装备自动打孔(装备名称, 打孔材料, 打孔价格, 孔位数量)
    for kkk = 1, 9 do
        local 装备等级 = 晴天_取背包装备等级(获取背包物品位置(装备名称) - 1)
        if 装备等级 > 0 then
            打孔等级 = math.ceil(装备等级 / 10)
            if 打孔等级 <= 8 and 开启打孔8级 == 1 then
                --老区配置
                打孔等级 = 8
            end
            if 晴天_取背包装备孔数量(装备名称) == 3 then
                打孔等级 = 12
            end
            打孔材料 = 打孔材料数组[打孔等级].name
            打孔价格 = 打孔材料数组[打孔等级].JINpirce
            晴天_友情提示(string.format("装备名称:%s|装备等级:%d|装备打孔材料:%s|打孔价格:%d|目标打孔数量:%d", 装备名称, 装备等级, 打孔材料, 打孔价格, 孔位数量))
            延时(3000)

            local 已经打孔的孔数 = 晴天_取背包装备孔数量(装备名称)
            --延时(1000)
            晴天_友情提示(装备名称 .. "已经打孔的孔数:" .. 已经打孔的孔数)
            if 已经打孔的孔数 >= 孔位数量 then
                晴天_友情提示("当前目标孔位数量" .. 孔位数量)
                --延时(1000)
                return
            end
            if 获取背包物品数量(装备名称) > 0 then
                bHave = 获取背包物品位置(装备名称) - 1
            else
                break
            end

            if 获取背包物品数量(打孔材料) > 0 then
                nIndex = 获取背包物品位置(打孔材料) - 1
            else
                晴天_友情提示("打孔材料" .. 打孔材料 .. "不足")
                晴天_自动处理寒玉精粹(打孔材料)
                if 打孔材料 == "落星之箭" and 获取背包物品数量("落星之箭") <= 0 and 开启帮会取打孔 == 1 then
                    执行功能("[脚本][函数库]帮会仓库")
                    晴天_帮会取物("落星之箭", 20)
                    开启帮会取打孔 = 0
                end
                晴天_九州商会购买物品(打孔材料, 1, 打孔价格, 1, 3, 3)

                nIndex = 获取背包物品位置(打孔材料) - 1
            end

            晴天_友情提示(bHave .. nIndex)

            --if not string.find("洛阳|大理|洛阳|楼兰|钱庄",获取人物信息(16) ) then
            --晴天_友情提示("不在地图洛阳|大理|洛阳|楼兰|钱庄,装备去洛阳 ")
            --延时(1000)
            --跨图寻路("洛阳",280,322)
            --end

            跨图寻路("洛阳", 280, 322)

            if tonumber(已经打孔的孔数) < 3 then
                晴天_友情提示("前三孔打孔")
                LUA_Call(string.format([[
        Clear_XSCRIPT()
        Set_XSCRIPT_Function_Name("StilettoEx_3")
        Set_XSCRIPT_ScriptID(311200)
        Set_XSCRIPT_Parameter(0,%d)--装备位置
        Set_XSCRIPT_Parameter(1,%d)--材料位置
        Set_XSCRIPT_ParamCount(2)
        Send_XSCRIPT()
		]], bHave, nIndex))
            else

                if 打孔材料 == "寒玉精粹" then
                    four = 2
                else
                    four = 1
                end
                LUA_Call(string.format([[
				Clear_XSCRIPT()
			Set_XSCRIPT_Function_Name("StilettoEx_4")
			Set_XSCRIPT_ScriptID(311200)
			Set_XSCRIPT_Parameter(0,%d)
			Set_XSCRIPT_Parameter(1,%d)
			Set_XSCRIPT_Parameter(2,%d)
			Set_XSCRIPT_ParamCount(3)
		Send_XSCRIPT()
				]], bHave, nIndex, four))
            end
        end
    end
end

function MessageBoxOK()
    if 窗口是否出现("MessageBox_Self") == 1 then
        晴天_友情提示("MessageBox确定")
        LUA_Call(" setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();")
        延时(1000)
    end
end

function 晴天_检测元宝店名称(序号)
    local tem = LUA_取返回值("setmetatable(_G, {__index = YuanbaoShop_Env})return YuanbaoShop_ItemInfo" .. tostring(序号) .. "_Text:GetText()")
    return tostring(tem)
end

function 晴天_自动购买宝石镶嵌符(绑定购买, 红利购买, 元宝购买)
    晴天_友情提示("全自动购买宝石镶嵌符")
    取出物品("宝石镶嵌符")
    for i = 1, 5 do
        if 获取背包物品数量("宝石镶嵌符") > 0 then
            return
        end
        if 绑定购买 then
            if tonumber(获取人物信息(62)) >= 98 then
                晴天_友情提示("绑定购买宝石镶嵌符")
                if 窗口是否出现("YuanbaoShop") == 0 then
                    LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();");
                    延时(2000)
                end
                LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);");
                延时(2000)
                LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(2);");
                延时(2000)
                if string.find(晴天_检测元宝店名称(1), "宝石镶嵌符") then
                    LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(1);");
                    延时(2000)
                end
                MessageBoxOK()
                延时(2000)
                晴天_判断关闭窗口("YuanbaoShop")
                延时(2000)
                if 获取背包物品数量("宝石镶嵌符") > 0 then
                    return
                end
            end
        end
        if 红利购买 then
            if tonumber(获取人物信息(55)) >= 98 then
                晴天_友情提示("红利购买宝石镶嵌符")
                if 窗口是否出现("YuanbaoShop") == 0 then
                    LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();");
                    延时(2000)
                end
                LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);");
                延时(2000)
                LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(2);");
                延时(2000)
                LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(6);");
                延时(2000)
                if string.find(晴天_检测元宝店名称(1), "宝石镶嵌符") then
                    LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(1);");
                    延时(2000)
                end
                MessageBoxOK()
                晴天_判断关闭窗口("YuanbaoShop")
            end
            if 获取背包物品数量("宝石镶嵌符") > 0 then
                return
            end
        end
        if 元宝购买 then
            if tonumber(获取人物信息(46)) >= 98 then
                if 窗口是否出现("YuanbaoShop") == 0 then
                    LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();");
                    延时(2000)
                end
                LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(0);");
                延时(2000)
                LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(2);");
                延时(2000)
                LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(6);");
                延时(2000)
                LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");
                延时(2000)
                if string.find(晴天_检测元宝店名称(2), "宝石镶嵌符") then
                    LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(2);");
                    延时(2000)
                end
                MessageBoxOK()
                晴天_判断关闭窗口("YuanbaoShop")
            end
            if 获取背包物品数量("宝石镶嵌符") > 0 then
                return
            end
        end
    end
end

function 晴天_整理背包(nTheTabIndex)
    if nTheTabIndex == 1 then
        晴天_友情提示("自动整理 <道具栏>")
    elseif nTheTabIndex == 2 then
        晴天_友情提示("自动整理 <材料栏>")
    end
    LUA_Call(string.format("PlayerPackage:PackUpPacket(%d);", nTheTabIndex))
end

function 晴天_兑换红宝石()
    if 获取背包物品数量("红宝石(3级)") > 0 then
        return
    end
    取出物品("3级宝石兑换券")
    if 获取背包物品数量("3级宝石兑换券") > 0 then
        for i = 1, 5 do
            if 获取背包物品数量("3级宝石兑换券") <= 0 then
                晴天_友情提示("3级宝石兑换券不足")
                break
            end
            跨图寻路("钱庄", 68, 44)
            if 对话NPC("钱夫人") == 1 then
                延时(1000)
                NPC二级对话("使用宝石兑换券", 0)
                延时(1000)
                NPC二级对话("使用3级宝石兑换券", 0)
                延时(1000)
                NPC二级对话("红宝石(3级)", 0)
                延时(1000)
                NPC二级对话("同意", 0)
                延时(1000)
            end
            if 获取背包物品数量("红宝石(3级)") > 0 then
                return
            end
        end
    end
end

function 晴天_兑换属性宝石(宝石名称)

    晴天_友情提示("兑换宝石" .. 宝石名称)
    if 获取背包物品数量(宝石名称) > 0 then
        return
    end
    取出物品("3级宝石兑换券")
    if 获取背包物品数量("3级宝石兑换券") > 0 then
        for i = 1, 5 do
            if 获取背包物品数量("3级宝石兑换券") <= 0 then
                晴天_友情提示("3级宝石兑换券不足")
                break
            end
            跨图寻路("钱庄", 68, 44)
            if 对话NPC("钱夫人") == 1 then
                延时(1000)
                NPC二级对话("使用宝石兑换券", 0)
                延时(1000)
                NPC二级对话("使用3级宝石兑换券", 0)
                延时(1000)
                NPC二级对话(宝石名称)
                延时(1000)
                NPC二级对话("同意", 0)
                延时(1000)
            end
            if 获取背包物品数量(宝石名称) > 0 then
                return
            end
        end
    end
end

function 晴天_许愿果换三级体力(数量)

    晴天_友情提示("许愿果换宝石")
    if not 数量 then
        数量 = 1
    end
    取出物品("红宝石(3级)")
    if 获取背包物品数量("红宝石(3级)") >= 数量 then
        return true
    end
    取出物品("许愿果")
    for i = 1, 20 do
        if 获取背包物品数量("许愿果") >= 20 then
            跨图寻路("苏州", 282, 276);
            延时(1000)
            if 对话NPC("梁道士") == 1 then
                NPC二级对话("许愿果兑换奖励");
                延时(1000)
                NPC二级对话("红宝石", 1);
                延时(1000)
                NPC二级对话("我要兑换");
                延时(2000)
            end
            if 获取背包物品数量("红宝石(3级)") >= 数量 then
                return true
            end
        end
    end
    晴天_兑换红宝石()
    if 获取背包物品数量("红宝石(3级)") >= 数量 then
        return true
    end
    return false
end

function 晴天_智能宝石雕琢(GemName, NeedItem)
    跨图寻路("洛阳", 281, 321)
    晴天_友情提示("宝石雕琢:%s ,%s", GemName, NeedItem)
    延时(2000)
    LPindex = 获取背包物品位置(GemName) - 1
    Needindex = 获取背包物品位置(NeedItem) - 1
    if LPindex >= 0 and Needindex >= 0 then
        local tem = LUA_取返回值(string.format([[
		local g_GemItemPos =%d
		local itemcount = PlayerPackage:GetBagItemNum(g_GemItemPos)
		Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name("OnGemCarve");
			Set_XSCRIPT_ScriptID(800117);
			Set_XSCRIPT_Parameter(0,g_GemItemPos);
			Set_XSCRIPT_Parameter(1,%d);
			Set_XSCRIPT_Parameter(2,135);
			Set_XSCRIPT_Parameter(3, 0);
			Set_XSCRIPT_Parameter(4,itemcount);
			Set_XSCRIPT_ParamCount(5);
		Send_XSCRIPT();
		]], LPindex, Needindex), "b")
    end
end

function 晴天_宝石雕琢(GemName)

    --晴天_友情提示("自动处理宝石雕琢符3级")
    if string.find(GemName, "3级") then
        雕琢材料 = "宝石雕琢符3级"
    elseif string.find(GemName, "2级") then
        雕琢材料 = "宝石雕琢符2级"
    end
    if 获取背包物品数量(雕琢材料) <= 0 then
        取出物品(雕琢材料)
        晴天_九州商会购买物品(雕琢材料, 250, 50 * 10000, 1)
    end
    晴天_智能宝石雕琢(GemName, 雕琢材料)
    延时(3000)
    --晴天_写角色配置项("宝石雕琢", "雕琢宝石", index)
    --延时(2000)
    --执行功能("宝石雕琢")
end

function 晴天_红利购买宝石(宝石名称)
    if 宝石名称 == "黄晶石·红利(3级)" then
        index = 3
    elseif 宝石名称 == "蓝晶石·红利(3级)" then
        index = 4
    elseif 宝石名称 == "红晶石·红利(3级)" then
        index = 5
    elseif 宝石名称 == "绿晶石·红利(3级)" then
        index = 6
    elseif 宝石名称 == "碧玺·红利(3级)" then
        index = 10
    else
        index = 10
    end
    if 获取背包物品数量(宝石名称) >= 1 then
        return
    end

    if tonumber(获取人物信息(55)) >= 210 then
        晴天_友情提示("红利购买宝石:" .. 宝石名称)
        if 窗口是否出现("YuanbaoShop") == 0 then
            LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();");
            延时(2000)
        end
        LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);");
        延时(2000)
        LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(5);");
        延时(2000)
        LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(1);");
        延时(2000)
        LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");
        延时(2000)
        --晴天_友情提示(晴天_检测元宝店名称(index))

        if 晴天_检测元宝店名称(index) == 宝石名称 then
            LUA_Call(string.format("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(%d);", index));
            延时(2000)
        end
        MessageBoxOK()
        晴天_判断关闭窗口("YuanbaoShop")
    end

end
function 晴天_自动处理宝石(宝石名称)
    晴天_友情提示("自动处理宝石" .. 宝石名称)
    取出物品(宝石名称)
    if 获取背包物品数量(宝石名称) >= 1 then
        return
    end

    local 宝石名称雕琢前 = string.gsub(宝石名称, "纯净", "")
    取出物品(宝石名称雕琢前 .. "|3级宝石兑换券|4级宝石兑换券")
    --晴天_友情提示(宝石名称雕琢前)
    --延时(5000)

    if 获取背包物品数量(宝石名称雕琢前) >= 1 then
        晴天_宝石雕琢(宝石名称雕琢前)
        延时(5000)
        if 获取背包物品数量(宝石名称) >= 1 then
            return
        end
    end

    if 宝石名称 == "红宝石(4级)" then
        取出物品(宝石名称)
        if 获取背包物品数量(宝石名称) <= 0 then
            return
        end
    end
    --延时(30000)
    if 宝石名称 == "红宝石(3级)" then
        if 晴天_许愿果换三级体力() then
            return
        else
            return
        end
    end

    if string.find(宝石名称雕琢前, "红利") and string.find(宝石名称雕琢前, "3级") then
        --晴天_友情提示("333");
        --延时(6000)

        if 晴天_取本周红利购买次数() >= 2 or tonumber(获取人物信息(55)) < 210 then
            --晴天_友情提示("5555")
            --延时(60000)
            return
        end

        晴天_红利购买宝石(宝石名称雕琢前)

        if 获取背包物品数量(宝石名称雕琢前) >= 1 then
            晴天_宝石雕琢(宝石名称雕琢前)
            取出物品(宝石名称)
        else
            return
        end
    end

    if string.find(宝石名称雕琢前, "晶石") and string.find(宝石名称雕琢前, "3级") then
        if 获取背包物品数量(宝石名称雕琢前) >= 1 then
            晴天_宝石雕琢(宝石名称雕琢前)
            取出物品(宝石名称)
            return
        end
        if 获取背包物品数量(宝石名称雕琢前) <= 0 then
            if 获取背包物品数量("3级宝石兑换券") >= 1 then
                晴天_兑换属性宝石(宝石名称雕琢前)
                晴天_宝石雕琢(宝石名称雕琢前)
                取出物品(宝石名称)
                return
            end
        end
    end

end

function 晴天_装备上宝石(装备名称, 宝石名称, 宝石位置)
    晴天_友情提示(宝石名称)
    晴天_自动处理宝石(宝石名称)
    local bIndex = 获取背包物品位置(宝石名称) - 1
    晴天_友情提示(bIndex)
    --延时(1000)

    if not bIndex or bIndex < 0 then
        return -1
    end


    --跨图寻路("洛阳",282,321)

    if 获取背包物品数量(装备名称) > 0 then
        bHave = 获取背包物品位置(装备名称) - 1
        晴天_友情提示("装备位置" .. bHave)
    else
        return -1
    end

    if 获取背包物品数量("宝石镶嵌符") > 0 then
        nIndex = 获取背包物品位置("宝石镶嵌符") - 1
    else
        晴天_自动购买宝石镶嵌符(true, true);
        延时(2000)
        nIndex = 获取背包物品位置("宝石镶嵌符") - 1
    end

    晴天_友情提示("宝石镶嵌符" .. nIndex)

    装备空位的数量 = 晴天_取背包装备孔数量(装备名称)
    if 装备空位的数量 < 宝石位置 then
        return
    end
    取出物品("金币")
    LUA_Call(string.format([[
		g_EnchaseEx_Gem_pos=%d
		g_EnchaseEx_Equip_pos=%d
		g_EnchaseEx_Material_pos=%d
		g_EnchaseEx_Gem_hole=%d
		if g_EnchaseEx_Gem_hole > 0 and g_EnchaseEx_Gem_hole < 4 then
		Clear_XSCRIPT()
			Set_XSCRIPT_Function_Name("EnchaseEx_3")
			Set_XSCRIPT_ScriptID(701614)
			Set_XSCRIPT_Parameter(0,g_EnchaseEx_Gem_pos)
			Set_XSCRIPT_Parameter(1,g_EnchaseEx_Equip_pos)
			Set_XSCRIPT_Parameter(2,g_EnchaseEx_Material_pos)
			Set_XSCRIPT_Parameter(3,-1)
			Set_XSCRIPT_Parameter(4,g_EnchaseEx_Gem_hole-1)
			Set_XSCRIPT_ParamCount(5)
		Send_XSCRIPT()
	elseif g_EnchaseEx_Gem_hole == 4 then
		Clear_XSCRIPT()
			Set_XSCRIPT_Function_Name("EnchaseEx_4")
			Set_XSCRIPT_ScriptID(701614)
			Set_XSCRIPT_Parameter(0,g_EnchaseEx_Gem_pos)
			Set_XSCRIPT_Parameter(1,g_EnchaseEx_Equip_pos)
			Set_XSCRIPT_Parameter(2,g_EnchaseEx_Material_pos)
			Set_XSCRIPT_Parameter(3,-1)
			Set_XSCRIPT_Parameter(4,3)
			Set_XSCRIPT_ParamCount(5)
		Send_XSCRIPT()
	end
	
		]], bIndex, bHave, nIndex, 宝石位置))
end

function 晴天_装备位置自动打孔(装备位置, 孔位数量)
    --晴天_友情提示(string.format("打孔[%s]材料[%s]价格[%d]位置[%d]",装备位置,打孔材料,打孔价格,孔位数量))

    装备等级 = 晴天_取身上装备位置等级(装备位置)
    if 装备等级 > 0 then
        打孔等级 = math.ceil(装备等级 / 10)
        if 打孔等级 <= 8 and 开启打孔8级 == 1 then
            --老区配置
            打孔等级 = 8
        end
        if 晴天_取身上装备位置孔位数量(装备位置) == 3 then
            打孔等级 = 12
        end
        打孔材料 = 打孔材料数组[打孔等级].name
        打孔价格 = 打孔材料数组[打孔等级].JINpirce

        晴天_友情提示(string.format("装备位置名称:%s|装备等级:%d|装备打孔材料:%s|打孔价格:%d|目标打孔数量:%d", 装备位置, 装备等级, 打孔材料, 打孔价格, 孔位数量))
        --延时(30000)
    else
        return
    end

    for i = 1, 4 do
        if 晴天_取身上装备位置孔位数量(装备位置) >= 孔位数量 then
            return true
        end
        取出物品("金币")
        取出物品(打孔材料)
        if 获取背包物品数量(打孔材料) >= 1 then

            晴天_友情提示("有打孔了")
        else
            if tonumber(获取人物信息(45)) < 打孔价格 then
                晴天_友情提示("打孔[%s]材料[%s]价格[%d]位置[%d],金币不足跳过任务", 装备位置, 打孔材料, 打孔价格, 孔位数量)
                延时(2000)
                return false
            end
        end


        --跨图寻路("洛阳",282,321)
        待执行装备名称 = 晴天_取下装备获取名字(装备位置)

        if 待执行装备名称 == "" or 待执行装备名称 == nil or 待执行装备名称 == 0 then
            return false
        end

        晴天_装备自动打孔(待执行装备名称, 打孔材料, 打孔价格, 孔位数量)
        晴天_穿上装备(装备位置, 待执行装备名称)
        --延时(1000)
    end
end

function 晴天_自动打宝石(装备位置名称, 宝石名字, 孔位数量, 宝石位置序号)
    local 宝石位置名称 = 晴天_取身上装备位置宝石名称(装备位置名称, 宝石位置序号)
    晴天_友情提示("自动打宝石装备位置[%s]宝石名称[%s]孔位数量[%d]宝石位置序号[%d]", 装备位置名称, 宝石名字, 孔位数量, 宝石位置序号)
    --延时(3000)
    --晴天_友情提示("装备位置名称"..宝石位置名称)
    if 宝石位置名称 ~= "没有宝石" and 宝石位置名称 ~= "-1" then
        晴天_友情提示("该位置已经有宝石啦,跳过任务")
        延时(200)
        return
    end
    取出物品("宝石镶嵌符")
    if 获取背包物品数量("宝石镶嵌符") <= 0 then
        if tonumber(获取人物信息(62)) < 98 and tonumber(获取人物信息(55)) < 98 then
            晴天_友情提示("提早处理宝石镶嵌符,没有跳过任务")
            return
        end
    end

    晴天_装备位置自动打孔(装备位置名称, 孔位数量)
    if 晴天_取身上装备位置孔位数量(装备位置名称) < 孔位数量 then
        --晴天_友情提示("222"..宝石名字)
        --延时(3000)
        return
    end

    晴天_自动处理宝石(宝石名字)
    --延时(3000)
    if 获取背包物品数量(宝石名字) <= 0 then
        晴天_友情提示("自动打宝石背包中没有宝石" .. 宝石名字)
        延时(30)
        return
    end

    待执行装备名称 = 晴天_取下装备获取名字(装备位置名称)
    延时(1500)
    if 待执行装备名称 == "" or 待执行装备名称 == nil then
        return
    end

    LPindex = 获取背包物品位置(待执行装备名称) - 1
    晴天_友情提示("待打孔的背包序号:" .. LPindex)
    if LPindex < 0 then
        return
    end

    if 晴天_装备上宝石(待执行装备名称, 宝石名字, 孔位数量) == -1 then
        晴天_穿上装备(装备位置名称, 待执行装备名称)
    end
    延时(3000)
    晴天_穿上装备(装备位置名称, 待执行装备名称)
end

function IsInTable(value, tbl)

    for k, v in ipairs(tbl) do
        if v == value then
            return 1;
        end
    end
    return -1;
end

function 晴天_智能打宝石(装备位置名称, gem, 宝石位置综合)
    if not 宝石位置综合 then
        宝石位置综合 = "1234"
    end
    local 装备名称 = 晴天_取身上装备位置名字(装备位置名称)
    if string.find(装备名字集合, 装备名称) or string.find(装备名称, 装备关键字集合) then
        --晴天_友情提示(装备名称)
    else
        晴天_友情提示(装备名称 .. "|不在设定名字中,跳过任务")
        --延时(10)
        return
    end

    if 晴天_取身上装备位置宝石名称(装备位置名称, 1) == "-1" then
        晴天_友情提示(装备位置名称 .. "没有装备")
        --延时(10)
        return
    end

    for KK = 1, 4 do
        宝石数组 = gem[KK]
        if type(宝石数组) ~= "table" then
            return
        end
        for i = 1, 4 do
            local 宝石位置名称 = 晴天_取身上装备位置宝石名称(装备位置名称, i)
            if 宝石位置名称 == "没有宝石" then
                if string.find(宝石位置综合, "1") and i == 1 and IsInTable(晴天_取身上装备位置宝石名称(装备位置名称, 2), 宝石数组) == -1 and IsInTable(晴天_取身上装备位置宝石名称(装备位置名称, 3), 宝石数组) == -1 then
                    for m = 1, #宝石数组 do
                        --晴天_友情提示(宝石数组[m])
                        --延时(3000)
                        晴天_自动打宝石(装备位置名称, 宝石数组[m], 1, 1)

                    end
                end
                if string.find(宝石位置综合, "2") and i == 2 and IsInTable(晴天_取身上装备位置宝石名称(装备位置名称, 1), 宝石数组) == -1 and IsInTable(晴天_取身上装备位置宝石名称(装备位置名称, 3), 宝石数组) == -1 then
                    for m = 1, #宝石数组 do
                        --晴天_友情提示(宝石数组[m])
                        --延时(3000)
                        晴天_自动打宝石(装备位置名称, 宝石数组[m], 2, 2)
                    end
                end
                if string.find(宝石位置综合, "3") and i == 3 and IsInTable(晴天_取身上装备位置宝石名称(装备位置名称, 1), 宝石数组) == -1 and IsInTable(晴天_取身上装备位置宝石名称(装备位置名称, 2), 宝石数组) == -1 then
                    for m = 1, #宝石数组 do
                        --晴天_友情提示("1111")
                        --晴天_友情提示(宝石数组[m])
                        --延时(300)
                        晴天_自动打宝石(装备位置名称, 宝石数组[m], 3, 3)
                    end
                end
                if string.find(宝石位置综合, "4") and i == 4 and KK == 4 then
                    for m = 1, #宝石数组 do
                        --晴天_友情提示("1111")
                        --晴天_友情提示(宝石数组[m])
                        --延时(300)
                        晴天_自动打宝石(装备位置名称, 宝石数组[m], 4, 4)
                    end
                end
            end
        end
    end
end

------------------------------------------------------------------------------------------------------------------------

属性宝石 = string.gsub("纯净&晶石(3级)", "&", 属性宝石颜色)

--"红宝石·红利(3级)"
镶嵌石头表 = {
    { "红宝石(4级)", "红宝石(3级)", "红宝石(5级)" },
    { "纯净&晶石(4级)", "纯净&晶石(3级)", "纯净&晶石·红利(3级)", "纯净&晶石(2级)", "纯净&晶石·红利(4级)" },
    { "纯净碧玺(3级)", "纯净碧玺·红利(3级)", },
    { "纯净&晶石(4级)", "纯净&晶石(3级)", "纯净&晶石·红利(3级)", },
}

攻击石头表 = {
    { "纯净&晶石(4级)", "纯净&晶石(3级)", "纯净&晶石·红利(3级)", "纯净&晶石(2级)", },
    { "紫玉(4级)", "紫玉(3级)", "紫玉·红利(3级)", },
    { "纯净&晶石(4级)", "纯净&晶石(3级)", "纯净&晶石·红利(3级)", },
    { "纯净&晶石(4级)", "纯净&晶石(3级)", "纯净&晶石·红利(3级)", },
}

function 晴天_转换数组(镶嵌石头表, 属性宝石颜色)
    for n = 1, #镶嵌石头表 do
        if type(镶嵌石头表[n]) == "table" then
            for k = 1, #镶嵌石头表[n] do
                镶嵌石头表[n][k] = string.gsub(镶嵌石头表[n][k], "&", 属性宝石颜色)
                --晴天_友情提示("第"..n.."个宝石数组:"..镶嵌石头表[n][k])
                --延时(1000)
            end
        else
            镶嵌石头表[n] = string.gsub(镶嵌石头表[n], "&", 属性宝石颜色)
            晴天_友情提示(n .. 镶嵌石头表[n])
            --延时(3000)
        end
    end
    return 镶嵌石头表
end

镶嵌石头表 = 晴天_转换数组(镶嵌石头表, 属性宝石颜色)
攻击石头表 = 晴天_转换数组(攻击石头表, 属性宝石颜色)

人物名称, 门派, PID, 远近攻击, 内外攻击, 角色账号, 门派地址, 技能状态, 性别 = 获取人物属性()

function 晴天_取身上武魂信息(index)
    if not index then
        index = 1
    end
    local tem = LUA_取返回值(string.format([[
		 index=%d
		 tem = -1
		wuhution=EnumAction(18,"equip")
		local id  =wuhution:GetID();
		if  id > 0 then
			if index == 1 then
				tem = 	DataPool:GetKfsData("NAME")
			elseif index == 2 then	
				 tem = DataPool:GetKfsData("EXTRALEVEL")  --合成等级
			elseif index == 3 then
				 tem =DataPool:GetKfsData("LEVEL");  --等级
			elseif index == 4 then
				 tem =DataPool:GetKfsData("LIFE");  --寿命		
			elseif index == 5 then
				 tem =LifeAbility:GetWearedEquip_HoleCount(18); --打孔数量
			elseif index == 6 then
				 tem =DataPool:GetKfsData("EXP");  --当前经验
			elseif index == 7 then
				 tem =DataPool:GetKfsData("NEEDEXP");  --最大经验				
			elseif index == 8 then	  --属性攻击
					tem =""
					for i=1,10 do
						local iText , iValue = DataPool:GetKfsFixAttrEx(i - 1)		
						if iText ~= nil and iText ~= "" and iValue ~= nil and iValue > 0  then
							tem =tem..iText.."|"
						end		
					end
			end

		end	--ID 
			return tem
		]], index))
    return tem
end

local 人物当前等级 = tonumber(获取人物信息(26))
if 人物当前等级 < 98 then
    LUA_Call(string.format([[
	        Clear_XSCRIPT()
			Set_XSCRIPT_Function_Name("GetBonus")  --脚本接口
			Set_XSCRIPT_ScriptID(290099) --脚本编号 g_CurrentSelect
			Set_XSCRIPT_Parameter(0,tonumber(4))
			Set_XSCRIPT_ParamCount(1)
		Send_XSCRIPT()
	  ]]))
    延时(2000)
    LUA_Call(string.format([[
	        Clear_XSCRIPT()
			Set_XSCRIPT_Function_Name("GetBonus")  --脚本接口
			Set_XSCRIPT_ScriptID(290099) --脚本编号 g_CurrentSelect
			Set_XSCRIPT_Parameter(0,tonumber(5))
			Set_XSCRIPT_ParamCount(1)
		Send_XSCRIPT()
	  ]]))
    延时(2000)
end

晴天_装备位置自动打孔("暗器", 3)
晴天_装备位置自动打孔("令牌", 3)
晴天_装备位置自动打孔("龙纹", 3)
if string.find(tostring(晴天_取身上武魂信息(8)), "毒抗性") then
    --晴天_装备位置自动打孔("武魂",3)
end

if 人物当前等级 >= 98 then
    晴天_智能打宝石("武器", 攻击石头表, "1")
end

----------------------------------------------------------------------
if 门派 == "峨嵋" then
    晴天_智能打宝石("暗器", 镶嵌石头表, "1234")
    晴天_智能打宝石("令牌", 镶嵌石头表, "1234")
    晴天_智能打宝石("龙纹", 镶嵌石头表, "1234")
    --晴天_智能打宝石("武魂",镶嵌石头表,"1")

    晴天_智能打宝石("豪侠印", 镶嵌石头表, "124")

    晴天_智能打宝石("暗器", 镶嵌石头表, "124")
    晴天_智能打宝石("令牌", 镶嵌石头表, "124")
    晴天_智能打宝石("龙纹", 镶嵌石头表, "124")
    晴天_智能打宝石("武魂", 镶嵌石头表, "124")

    晴天_智能打宝石("衣服", 镶嵌石头表, "1")
    晴天_智能打宝石("护肩", 镶嵌石头表, "1")
    晴天_智能打宝石("手套", 镶嵌石头表, "1")
    晴天_智能打宝石("鞋子", 镶嵌石头表, "1")
    晴天_智能打宝石("腰带", 镶嵌石头表, "1")
    晴天_智能打宝石("帽子", 镶嵌石头表, "1")
    晴天_智能打宝石("项链", 镶嵌石头表, "1")

    晴天_智能打宝石("豪侠印", 镶嵌石头表, "124")
    晴天_智能打宝石("暗器", 镶嵌石头表, "1234")
    晴天_智能打宝石("令牌", 镶嵌石头表, "1234")
    晴天_智能打宝石("武魂", 镶嵌石头表, "1234")
    晴天_智能打宝石("龙纹", 镶嵌石头表, "1234")
    晴天_智能打宝石("豪侠印", 镶嵌石头表, "1234")

    晴天_智能打宝石("护腕", 攻击石头表, "1")

    晴天_智能打宝石("戒指下", 攻击石头表, "1")
    晴天_智能打宝石("戒指上", 攻击石头表, "1")
    晴天_智能打宝石("护符下", 攻击石头表, "1")
    晴天_智能打宝石("护符上", 攻击石头表, "1")
else

    晴天_智能打宝石("暗器", 镶嵌石头表, "1234")
    晴天_智能打宝石("龙纹", 镶嵌石头表, "1234")
    晴天_智能打宝石("令牌", 镶嵌石头表, "1234")
    --晴天_智能打宝石("武魂",镶嵌石头表,"1")
    晴天_智能打宝石("豪侠印", 镶嵌石头表, "1")

    晴天_智能打宝石("暗器", 镶嵌石头表, "1234")
    晴天_智能打宝石("令牌", 镶嵌石头表, "124")
    晴天_智能打宝石("龙纹", 镶嵌石头表, "124")
    晴天_智能打宝石("武魂", 镶嵌石头表, "124")
    晴天_智能打宝石("豪侠印", 镶嵌石头表, "124")

    晴天_智能打宝石("戒指下", 攻击石头表, "1")
    晴天_智能打宝石("戒指上", 攻击石头表, "1")
    晴天_智能打宝石("护符下", 攻击石头表, "1")
    晴天_智能打宝石("护符上", 攻击石头表, "1")

    晴天_智能打宝石("衣服", 镶嵌石头表, "1")
    晴天_智能打宝石("护肩", 镶嵌石头表, "1")
    晴天_智能打宝石("手套", 镶嵌石头表, "1")
    晴天_智能打宝石("鞋子", 镶嵌石头表, "1")
    晴天_智能打宝石("腰带", 镶嵌石头表, "1")
    晴天_智能打宝石("帽子", 镶嵌石头表, "1")
    晴天_智能打宝石("项链", 镶嵌石头表, "1")

    晴天_智能打宝石("暗器", 镶嵌石头表, "1234")
    晴天_智能打宝石("令牌", 镶嵌石头表, "1234")
    晴天_智能打宝石("武魂", 镶嵌石头表, "1234")
    晴天_智能打宝石("龙纹", 镶嵌石头表, "1234")
    晴天_智能打宝石("豪侠印", 镶嵌石头表, "1234")
end


















