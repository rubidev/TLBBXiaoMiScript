--铁甲金戈_购买物品表 = {
--	{name="雪芝药散",num=1},
--	{name="武约心决素盒",num=1},
--}


--解密你妈呢 自己不会写?
lua = LUA_取返回值
local 宋辽INFO = {
	{scene="大理",x=235,y=222,npc="方玉拓"},
	{scene="大理",x=223,y=230,npc="司相"},
	{scene="大理",x=255,y=238,npc="齐资"},
	{scene="苏州",x=294,y=241,npc="刘博"},
	{scene="洛阳",x=312,y=235,npc="祝帅"},
}

function GetLevel()
	local level = tonumber(lua("return Player:GetData('LEVEL')"))
	if level>=60 and level<=69 then
		return 1
	elseif level>=70 and level<=79 then
		return 2
	elseif level>=80 and level<=89 then
		return 3
	elseif level>=90 and level<=109 then
		return 4
	elseif level>=110 and level<=119 then
		return 5
	end
	return -1
end

function OpenSongliao()
	local 地图名 = lua("return GetCurrentSceneName()")
	if 地图名~="宋辽战场" and 地图名~="雁门关前哨" then
		local Week = os.date("%A")
		if Week~="Tuesday" and Week~="Thursday" then
			屏幕提示("今天没有宋辽")
			return false
		end
	
		local time = tonumber(lua("return DataPool:GetServerMinuteTime()"))
		if time>213000 then
			屏幕提示("来晚了")
			return false
		end

		local level = GetLevel()
		if level==-1 then
			屏幕提示("等级不符合要求")
			return false
		end
	else
		return true
	end

	while true do
		local 地图名 = lua("return GetCurrentSceneName()")
		if 地图名~="宋辽战场" and 地图名~="雁门关前哨" then
			local level = GetLevel()
			local 信息 = 宋辽INFO[level]

			local NPCEventList = lua([[
				if IsWindowShow("Quest") then
					local a,b,c,d,e =DataPool:GetNPCEventList_Item(0)
					return e
				end
			]])
			if NPCEventList=="#{SLDZ_220216_44}" then
				return false
			end

			跨图寻路(信息.scene,信息.x,信息.y)延时(1000)
			对话NPC(信息.npc)延时(1000)
			NPC二级对话("#{SLDZ_100805_03}")延时(1000)

			对话NPC(信息.npc)延时(1000)
			lua("ContexMenu_LeaveTeam_Clicked()")延时(100)
			lua(string.format([[
				if Target:GetDialogNpcName()=="%s" and DataPool:GetNPCEventList_Num()>0 then
					local a,b,c,d,e =DataPool:GetNPCEventList_Item(1)
					if a~="text" then
						QuestFrameOptionClicked(b,c,d)
					end
				end
			]],信息.npc))	延时(5000)
			等待过图完毕()
		else
			return true
		end
		延时(1000)
	end

end


function StartSongliao()
	local 阵容 = lua([[
		local ret, name, score, towerScore, damage, damageAfford, damageDefend, cure, kill, camp = CSongliaoWarData:TSLGetMyScoreData()
		return camp
	]])
	local 防御塔INFO = {}
	if 阵容=="157" then
		防御塔INFO = {
			{name="#{SLDZ_220216_168}",x=108,y=230},
			{name="#{SLDZ_220216_167}",x=160,y=219},
			{name="#{SLDZ_220216_169}",x=212,y=230},
			{name="#{SLDZ_220216_162}",x=192,y=243},
			{name="#{SLDZ_220216_163}",x=212,y=268},
			{name="#{SLDZ_220216_161}",x=127,y=243},
			{name="#{SLDZ_220216_164}",x=107,y=268},
			{name="#{SLDZ_220216_165}",x=159,y=291},
		}
	else
		防御塔INFO = {
			{name="#{SLDZ_220216_172}",x=212,y=91},
			{name="#{SLDZ_220216_170}",x=160,y=96},
			{name="#{SLDZ_220216_171}",x=108,y=92},
			{name="#{SLDZ_220216_161}",x=127,y=76},
			{name="#{SLDZ_220216_164}",x=107,y=49},
			{name="#{SLDZ_220216_162}",x=192,y=76},
			{name="#{SLDZ_220216_163}",x=212,y=49},
			{name="#{SLDZ_220216_166}",x=159,y=27},
		}
	end
	for i=1,#防御塔INFO do
		if lua("return GetCurrentSceneName()")~="宋辽战场" then
			return
		end
		等待过图完毕()
		死亡出窍()
		while true do
			if lua("return GetCurrentSceneName()")~="宋辽战场" then
				break
			end
			等待过图完毕()
			死亡出窍()
			local act = 防御塔INFO[i]
			跨图寻路("宋辽战场",act.x,act.y)延时(300)
			自动捡包()
			local ret = lua(string.format([[
				for i=1,2000 do
					if SetMainTargetFromList(i ,false, false)==1 then
						if Target:GetName()=="%s" then
							return i
						end
					end
				end
				return -1
			]],act.name))
			if ret~="-1" then
				攻击怪物(tonumber(ret)) 延时(800)
			else
				break
			end
		end
	end
	if lua("return GetCurrentSceneName()")=="宋辽战场" then
		if 阵容=="157" then
			跨图寻路("宋辽战场",297,227)延时(300)
		else
			跨图寻路("宋辽战场",21,88)延时(300)
		end

		while lua("return GetCurrentSceneName()")=="宋辽战场" do
			对话NPC("大宋卫兵")延时(800)
			对话NPC("大辽卫兵")延时(800)
			NPC二级对话("#{SLDZ_100805_37}")延时(800)
			NPC二级对话("#{INTERFACE_XML_557}")延时(800)
			等待过图完毕()
		end
	end
	while lua("return GetCurrentSceneName()")=="雁门关前哨" do
		屏幕提示("等待结束")
		延时(5000)
		等待过图完毕()
	end

end


if not OpenSongliao() then
	return
end
while true do
	等待过图完毕()
	if lua("return GetCurrentSceneName()")=="雁门关前哨" then
		屏幕提示("等待进入战场")
		延时(5000)
	else
		break
	end
end
if lua("return GetCurrentSceneName()")=="宋辽战场" then
	StartSongliao()
		
	local 信息 = 宋辽INFO[GetLevel()]
	跨图寻路(信息.scene,信息.x,信息.y)延时(1000)
	对话NPC(信息.npc)延时(1000)
	NPC二级对话("#{SLDZ_100805_03}")延时(1000)
end

--function Buy金戈馆()
--	跨图寻路("洛阳",310,203)延时(1000)
--	对话NPC("周兴逐")延时(1000)
--	NPC二级对话("#{PVPZH_220124_31}")延时(1000)	--铁甲
--	NPC二级对话("#{PVPZH_220124_32}")延时(1000)	--金戈
--end


local itemname = {"相（宋）","車（宋）","砲（宋）","炮（辽）","車（辽）","将（辽）","卒（辽）","象（辽）","砲（宋）","砲（宋）","馬（宋）","兵（宋）","帥（宋）","車（宋）","車（宋）","馬（宋）","仕（宋）","相（宋）","兵（宋）","兵（宋）","宋辽破竹礼·鹤鸣","宋辽铩羽礼·鹤鸣","宋辽破竹礼·鹰扬","宋辽铩羽礼·鹰扬","宋辽破竹礼·虎啸","宋辽铩羽礼·虎啸","宋辽破竹礼·龙腾","宋辽铩羽礼·龙腾"}
for i=1,#itemname do
	local count = 获取背包物品数量(itemname[i])
	for i=1,count do
		右键使用物品(itemname[i])
		延时(300)
	end
end


for k=1,#铁甲金戈_购买物品表 do
	local name = 铁甲金戈_购买物品表[k].name
	local num = 铁甲金戈_购买物品表[k].num
	屏幕提示(name)
	for i=1,num do
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
		]],name,name))
		延时(1000)
	end
end
右键使用物品("雪芝药散")



