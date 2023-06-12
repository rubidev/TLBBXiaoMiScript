铁甲金戈_购买物品表 = {
    { name = "雪芝药散", num = 1 },
    { name = "真元精珀", num = 2 },
    { name = "至尊强化精华", num = 2 },
}

lua = LUA_取返回值

local songLiaoNPCInfo = {
    { scene = "大理", x = 235, y = 222, npc = "方玉拓" },
    { scene = "大理", x = 223, y = 230, npc = "司相" },
    { scene = "大理", x = 255, y = 238, npc = "齐资" },
    { scene = "苏州", x = 294, y = 241, npc = "刘博" },
    { scene = "洛阳", x = 312, y = 235, npc = "祝帅" },
}

function GetLevel()
    local level = tonumber(lua("return Player:GetData('LEVEL')"))
    if level >= 60 and level <= 69 then
        return 1
    elseif level >= 70 and level <= 79 then
        return 2
    elseif level >= 80 and level <= 89 then
        return 3
    elseif level >= 90 and level <= 109 then
        return 4
    elseif level >= 110 and level <= 119 then
        return 5
    end
    return -1
end

function OpenSongLiao()
    local curMap = lua("return GetCurrentSceneName()")
    if curMap ~= "宋辽战场" and curMap ~= "雁门关前哨" then
        local Week = os.date("%A")
        if Week ~= "Tuesday" and Week ~= "Thursday" then
            屏幕提示("今天没有宋辽")
            return false
        end

        local time = tonumber(lua("return DataPool:GetServerMinuteTime()"))
        if time > 213000 then
            屏幕提示("活动已结束, 来晚了")
            return false
        end

        local level = GetLevel()
        if level == -1 then
            屏幕提示("等级不符合要求")
            return false
        end
    else
        return true
    end

    while true do
        local curMap = lua("return GetCurrentSceneName()")
        if curMap ~= "宋辽战场" and curMap ~= "雁门关前哨" then
            local level = GetLevel()
            local NPCInfo = songLiaoNPCInfo[level]

            local NPCEventList = lua([[
				if IsWindowShow("Quest") then
					local a,b,c,d,e =DataPool:GetNPCEventList_Item(0)
					return e
				end
			]])
            if NPCEventList == "#{SLDZ_220216_44}" then
                return false
            end

            跨图寻路(NPCInfo.scene, NPCInfo.x, NPCInfo.y)
            延时(1000)
            对话NPC(NPCInfo.npc)
            延时(1000)
            NPC二级对话("#{SLDZ_100805_03}")
            延时(1000)

            对话NPC(NPCInfo.npc)
            延时(1000)
            lua("ContexMenu_LeaveTeam_Clicked()")
            延时(100)
            lua(string.format([[
				if Target:GetDialogNpcName()=="%s" and DataPool:GetNPCEventList_Num()>0 then
					local a,b,c,d,e =DataPool:GetNPCEventList_Item(1)
					if a~="text" then
						QuestFrameOptionClicked(b,c,d)
					end
				end
			]], NPCInfo.npc))
            延时(5000)
            等待过图完毕()
        else
            return true
        end
        延时(1000)
    end

end

function UseRoleSkills(RoleSkill, skillTarget)
    -- 使用门派技能
    if tonumber(判断技能冷却(RoleSkill)) == 1 then
        SkillID = 获取技能ID(RoleSkill)
        使用技能(SkillID, skillTarget);
        延时(110)
    end
end

function UseWuHunSkill(skillTarget)
    -- 武魂技能
    local WHSkillID = DataPool:GetKfsSkill(2)
    使用技能(WHSkillID, skillTarget);
    延时(110)
end

function UseRoleSkillAttack(attackTargetID)
    坐骑_下坐骑()
    坐骑_下坐骑()

    local 人物名称, 门派, PID, 远近攻击, 内外攻击, 角色账号, 门派地址, 技能状态, 性别 = 获取人物属性()
    if 门派 == "逍遥" then
        UseRoleSkills("溪山行旅", attackTargetID);
        UseRoleSkills("宇越星现", attackTargetID);
        UseRoleSkills("诛仙万象", attackTargetID);
        UseRoleSkills("暗器连击", attackTargetID);
        UseRoleSkills("弹指神功", attackTargetID);
        UseRoleSkills("排山倒海", attackTargetID);
        UseRoleSkills("步步生花", attackTargetID);
        UseRoleSkills("落英剑", attackTargetID);
    elseif 门派 == "唐门" then
        UseRoleSkills("风雷万钧", attackTargetID);
        UseRoleSkills("铁蒺藜", attackTargetID);
        UseRoleSkills("九天揽月", attackTargetID);
        UseRoleSkills("落日追星", attackTargetID);
        UseRoleSkills("孔雀翎", attackTargetID);
        UseRoleSkills("天女散花", attackTargetID);
        UseRoleSkills("万箭齐发", attackTargetID);
        UseRoleSkills("一叶障目", attackTargetID);
        UseRoleSkills("流云矢", attackTargetID);
    elseif 门派 == "鬼谷" then
        UseRoleSkills("万宿辰光", attackTargetID);
        UseRoleSkills("一气三清", attackTargetID);
        UseRoleSkills("未老先衰", attackTargetID);
        UseRoleSkills("荧惑守心", attackTargetID);
        UseRoleSkills("风云反覆", attackTargetID);
        UseRoleSkills("乾坤引", attackTargetID);
    elseif 门派 == "峨嵋" then
        UseRoleSkills("斩情诀", attackTargetID);
        UseRoleSkills("混江破崖", attackTargetID);
        UseRoleSkills("九阴神爪", attackTargetID);
        UseRoleSkills("春花秋月", attackTargetID);
        UseRoleSkills("障眼法", attackTargetID);
        UseRoleSkills("拖泥带水", attackTargetID);
        UseRoleSkills("貂蝉拜月", attackTargetID);
        UseRoleSkills("月落西山", attackTargetID);
    elseif 门派 == "天山" then
        UseRoleSkills("移花接木", attackTargetID);
        UseRoleSkills("暗器投掷", attackTargetID);
        UseRoleSkills("洪涛碧浪", attackTargetID);
        UseRoleSkills("阳歌天钧", attackTargetID);
        UseRoleSkills("凤舞九天", attackTargetID);
        UseRoleSkills("内劲攻击", attackTargetID);
        UseRoleSkills("雁南飞", attackTargetID);
    elseif 门派 == "天龙" then
        UseRoleSkills("指点江山", attackTargetID);
        UseRoleSkills("中冲剑", attackTargetID);
        UseRoleSkills("少泽剑", attackTargetID);
        UseRoleSkills("商阳剑", attackTargetID);
        UseRoleSkills("黄龙怒鸣", attackTargetID);
        UseRoleSkills("万岳朝宗", attackTargetID);
        UseRoleSkills("一阳指", attackTargetID);
        UseRoleSkills("正阳手", attackTargetID);
    elseif 门派 == "武当" then
        UseRoleSkills("仙人指路", attackTargetID);
        UseRoleSkills("玉女穿梭", attackTargetID);
        UseRoleSkills("天外飞仙", attackTargetID);
        UseRoleSkills("宙耀七星", attackTargetID);
        UseRoleSkills("游刃有余", attackTargetID);
        UseRoleSkills("八卦掌", attackTargetID);
    elseif 门派 == "星宿" then
        UseRoleSkills("经脉逆行", attackTargetID);
        UseRoleSkills("荒野幽魂", attackTargetID);
        UseRoleSkills("幽冥神掌", attackTargetID);
        UseRoleSkills("毒蟾功", attackTargetID);
        UseRoleSkills("冰蚕毒掌", attackTargetID);
        UseRoleSkills("化骨绵掌", attackTargetID);
        UseRoleSkills("天地同寿", attackTargetID);
        UseRoleSkills("蓝砂手", attackTargetID);
    elseif 门派 == "少林" then
        UseRoleSkills("玄印悟佛", attackTargetID);
        UseRoleSkills("大力金刚掌", attackTargetID);
        UseRoleSkills("一拍两散", attackTargetID);
        UseRoleSkills("如来神掌", attackTargetID);
        UseRoleSkills("易筋锻骨", attackTargetID);
        UseRoleSkills("伏虎拳", attackTargetID);
    elseif 门派 == "丐帮" then
        UseRoleSkills("见龙在田", attackTargetID);
        UseRoleSkills("地沉陷痕", attackTargetID);
        UseRoleSkills("飞龙在天", attackTargetID);
        UseRoleSkills("亢龙有悔", attackTargetID);
        UseRoleSkills("天下无狗", attackTargetID);
        UseRoleSkills("青龙出水", attackTargetID);
        UseRoleSkills("潜龙勿用", attackTargetID);
        UseRoleSkills("震惊百里", attackTargetID);
        UseRoleSkills("暗器投掷", attackTargetID);
        UseRoleSkills("棒打狗头", attackTargetID);
        UseRoleSkills("蟠龙击", attackTargetID);
    elseif 门派 == "明教" then
        UseRoleSkills("火焰连环斩", attackTargetID);
        UseRoleSkills("纯阳无极", attackTargetID);
        UseRoleSkills("天火燃穹", attackTargetID);
        UseRoleSkills("水淹七军", attackTargetID);
        UseRoleSkills("火烧赤壁", attackTargetID);
        UseRoleSkills("炎龙无双", attackTargetID);
        UseRoleSkills("摧心掌", attackTargetID);
    elseif 门派 == "慕容" then
        UseRoleSkills("凌神式", attackTargetID);
        UseRoleSkills("沌异潮落", attackTargetID);
        UseRoleSkills("气定六合", attackTargetID);
        UseRoleSkills("破天式", attackTargetID);
        UseRoleSkills("横剑疆场", attackTargetID);
        UseRoleSkills("重云掩日", attackTargetID);
        UseRoleSkills("剑锁江山", attackTargetID);
        UseRoleSkills("星河虹吸", attackTargetID);
        UseRoleSkills("柳拂衣", attackTargetID);
    elseif 门派 == "桃花岛" then
        UseRoleSkills("良夜游", attackTargetID);
        UseRoleSkills("人之可诛", attackTargetID);
        UseRoleSkills("日月之明", attackTargetID);
        UseRoleSkills("罪人不怨", attackTargetID);
        UseRoleSkills("六合同风", attackTargetID);
        UseRoleSkills("雅颂之音", attackTargetID);
    elseif 门派 == "绝情谷" then
        UseRoleSkills("荡千军", attackTargetID);
        UseRoleSkills("烈火燎情", attackTargetID);
        UseRoleSkills("指踪悬印", attackTargetID);
        UseRoleSkills("挥斥方遒", attackTargetID);
        UseRoleSkills("刃击千里", attackTargetID);
    end

    -- 武魂攻击技能
    --UseWuHunSkill(attackTargetID)   -- TODO 测试武魂技能是否能用

    -- 人物组合技能，并使用
    UseRoleSkills("诛仙万象", attackTargetID);
    UseRoleSkills("暗器连击", attackTargetID);
    UseRoleSkills("总决式·剑宗", attackTargetID);
    UseRoleSkills("破箭式·剑宗", attackTargetID);
    UseRoleSkills("破气式·剑宗", attackTargetID);

end

function UseJiaSuSkill()
    local 人物名称, 门派, PID, 远近攻击, 内外攻击, 角色账号, 门派地址, 技能状态, 性别 = 获取人物属性()
    if 门派 == "唐门" then
        UseRoleSkills("鬼魅随行", attackTargetID);
    elseif 门派 == "鬼谷" then
        UseRoleSkills("扶摇直上", attackTargetID);
    elseif 门派 == "天山" then
        UseRoleSkills("白驹过隙", attackTargetID);
    elseif 门派 == "天龙" then
        UseRoleSkills("衔枚疾走", attackTargetID);
    elseif 门派 == "少林" then
        UseRoleSkills("一苇渡江", attackTargetID);
    elseif 门派 == "丐帮" then
        UseRoleSkills("八步赶蟾", attackTargetID);
    elseif 门派 == "明教" then
        UseRoleSkills("葵花逐日", attackTargetID);
    elseif 门派 == "慕容" then
        UseRoleSkills("陌上行", attackTargetID);
    elseif 门派 == "绝情谷" then
        UseRoleSkills("任云飞", attackTargetID);
    end
end

function StartSongLiao()
    local ZhengRong = lua([[
		local ret, name, score, towerScore, damage, damageAfford, damageDefend, cure, kill, camp = CSongliaoWarData:TSLGetMyScoreData()
		return camp
	]])
    local FangYuTaINFO = {}
    if ZhengRong == "157" then
        -- 角色为辽方阵营，进攻宋方
        FangYuTaINFO = {
            { name = "#{SLDZ_220216_168}", x = 108, y = 230 }, -- 宋的防御塔·一
            { name = "#{SLDZ_220216_167}", x = 160, y = 219 }, -- 宋的防御塔·二
            { name = "#{SLDZ_220216_169}", x = 212, y = 230 }, -- 宋的防御塔·三
            { name = "#{SLDZ_220216_162}", x = 192, y = 243 }, -- 宋的四象塔
            { name = "#{SLDZ_220216_163}", x = 212, y = 268 }, -- 宋的四象塔
            { name = "#{SLDZ_220216_161}", x = 127, y = 243 }, -- 宋的四象塔
            { name = "#{SLDZ_220216_164}", x = 107, y = 268 }, -- 宋的四象塔
            { name = "#{SLDZ_220216_165}", x = 159, y = 291 }, -- 宋帅
        }
    else
        -- 角色为宋方阵营，进攻辽方
        FangYuTaINFO = {
            { name = "#{SLDZ_220216_172}", x = 212, y = 91 },  -- 辽的防御塔·一
            { name = "#{SLDZ_220216_170}", x = 160, y = 96 },  -- 辽的防御塔·二
            { name = "#{SLDZ_220216_171}", x = 108, y = 92 },  -- 辽的防御塔·三
            { name = "#{SLDZ_220216_161}", x = 127, y = 76 },  -- 辽的四象塔
            { name = "#{SLDZ_220216_164}", x = 107, y = 49 },  -- 辽的四象塔
            { name = "#{SLDZ_220216_162}", x = 192, y = 76 },  -- 辽的四象塔
            { name = "#{SLDZ_220216_163}", x = 212, y = 49 },  -- 辽的四象塔
            { name = "#{SLDZ_220216_166}", x = 159, y = 27 },  -- 辽将
        }
    end

    -- 一个一个点跑去打防御塔
    for i = 1, #FangYuTaINFO do
        if lua("return GetCurrentSceneName()") ~= "宋辽战场" then
            return
        end
        等待过图完毕()
        死亡出窍()
        while true do
            -- 循环使用技能打怪
            if lua("return GetCurrentSceneName()") ~= "宋辽战场" then
                break
            end
            等待过图完毕()
            死亡出窍()
            local act = FangYuTaINFO[i]
            UseJiaSuSkill()  -- 使用加速技能
            if i == 2 or i == 3 or i == 4 or i == 5 or i == 7 or i == 8 then
                跨图寻路("宋辽战场", act.x, act.y, 1)  -- 禁用坐骑
            else
                跨图寻路("宋辽战场", act.x, act.y)
                --延时(300)
                --坐骑_下坐骑()
            end

            --延时(300)
            -- 自动捡包()   -- 注释掉，不捡包， 捡包浪费时间
            --local ret = lua(string.format([[
			--	for i=1,2000 do
			--		if SetMainTargetFromList(i ,false, false)==1 then
			--			if Target:GetName()=="%s" then
			--				return i
			--			end
			--		end
			--	end
			--	return -1
			--]], act.name))
            --
            --if ret ~= "-1" then
            --    攻击怪物(tonumber(ret))
            --    延时(800)
            --else
            --    break
            --end

            怪物名称, 怪物ID, 物品X坐标, 物品Y坐标, 目标血量, 物品距离, 物品类别, 物品归属, 怪物判断, 头顶标注 = 遍历周围物品(4, act.name, 5)
            if 目标血量 > 0 then
                UseRoleSkillAttack(怪物ID)
                延时(110)
            else
                break
            end

        end
    end

    -- 宋辽结束，前往离开NPC处，只有赢的一方才执行下面的逻辑，输的一方卡在上方循环中
    if lua("return GetCurrentSceneName()") == "宋辽战场" then
        if ZhengRong == "157" then
            跨图寻路("宋辽战场", 297, 227)
            延时(300)
        else
            跨图寻路("宋辽战场", 21, 88)
            延时(300)
        end

        while lua("return GetCurrentSceneName()") == "宋辽战场" do
            对话NPC("大宋卫兵")
            延时(800)
            对话NPC("大辽卫兵")
            延时(800)
            NPC二级对话("#{SLDZ_100805_37}")
            延时(800)
            NPC二级对话("#{INTERFACE_XML_557}")
            延时(800)
            等待过图完毕()
        end
    end
    while lua("return GetCurrentSceneName()") == "雁门关前哨" do
        屏幕提示("等待结束")
        延时(5000)
        等待过图完毕()
    end

end



-- 脚本执行逻辑从这里开始 ------------------------------------------------------------------
执行功能("同步游戏时间")

if not OpenSongLiao() then
    return
end
while true do
    等待过图完毕()
    if lua("return GetCurrentSceneName()") == "雁门关前哨" then
        屏幕提示("等待进入战场")
        延时(5000)
    else
        break
    end
end
if lua("return GetCurrentSceneName()") == "宋辽战场" then
    StartSongLiao()

    -- 宋辽结束, 领取宋辽奖励
    local NPCInfo = songLiaoNPCInfo[GetLevel()]
    跨图寻路(NPCInfo.scene, NPCInfo.x, NPCInfo.y)
    延时(1000)
    对话NPC(NPCInfo.npc)
    延时(1000)
    NPC二级对话("#{SLDZ_100805_03}")
    延时(1000)
end

-- 使用棋子、宋辽奖励
local itemname = { "相（宋）", "車（宋）", "砲（宋）", "炮（辽）", "車（辽）", "将（辽）", "卒（辽）", "象（辽）", "砲（宋）", "砲（宋）", "馬（宋）", "兵（宋）", "帥（宋）", "車（宋）", "車（宋）", "馬（宋）", "仕（宋）", "相（宋）", "兵（宋）", "兵（宋）", "宋辽破竹礼·鹤鸣", "宋辽铩羽礼·鹤鸣", "宋辽破竹礼·鹰扬", "宋辽铩羽礼·鹰扬", "宋辽破竹礼·虎啸", "宋辽铩羽礼·虎啸", "宋辽破竹礼·龙腾", "宋辽铩羽礼·龙腾" }
for i = 1, #itemname do
    local count = 获取背包物品数量(itemname[i])
    for i = 1, count do
        右键使用物品(itemname[i])
        延时(300)
    end
end


-- 购买东西
for k = 1, #铁甲金戈_购买物品表 do
    local name = 铁甲金戈_购买物品表[k].name
    local num = 铁甲金戈_购买物品表[k].num
    屏幕提示("购买" .. name .. " " .. tostring(num) .. "个")
    for i = 1, num do
        lua(string.format([[
			local info= GetPVPShopData(1,1,16)
			for i=1,16 do
				if info[i].itemid>0 and info[i].itemname=="%s" then
					Clear_XSCRIPT()
						Set_XSCRIPT_Function_Name("BuyItem");
						Set_XSCRIPT_ScriptID(888969);
						Set_XSCRIPT_Parameter(0,266);
						Set_XSCRIPT_Parameter(1,1);
						Set_XSCRIPT_Parameter(2,info[i].itemid);
						Set_XSCRIPT_Parameter(3,1);
						Set_XSCRIPT_Parameter(4,1);
						Set_XSCRIPT_ParamCount(5);
					Send_XSCRIPT()
					return
				end
			end

			local info= GetPVPShopData(2,1,16)
			for i=1,16 do
				if info[i].itemid>0 and info[i].itemname=="%s" then
					PushDebugMessage(info[i].itemname)
					Clear_XSCRIPT()
						Set_XSCRIPT_Function_Name("BuyItem");
						Set_XSCRIPT_ScriptID(888969);
						Set_XSCRIPT_Parameter(0,266);
						Set_XSCRIPT_Parameter(1,1);
						Set_XSCRIPT_Parameter(2,info[i].itemid);
						Set_XSCRIPT_Parameter(3,1);
						Set_XSCRIPT_Parameter(4,2);
						Set_XSCRIPT_ParamCount(5);
					Send_XSCRIPT()
					return
				end
			end
		]], name, name))
        延时(1000)
    end
end

右键使用物品("雪芝药散")
延时(1000)
右键使用物品("真元")



