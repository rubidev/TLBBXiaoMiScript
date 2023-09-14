--1.判断人物最高属性，历练值够2000
--2，购买顺序高门，投巫，誓江，巾帼。升级1阶10级
--3，四心决都1阶10级后，历练值够1500，按高门，投巫，誓江，巾帼顺序购买30残印。升级5阶。
--4，领悟心决及升级到1阶10级需要大约100交子，从1阶10级升满5阶大约需要600交子
--5，请看第4条后请选择是否使用金币，0不，1是
--6，秘籍数组没有的秘籍，再已有的4个秘籍中修改，最多只能4个


--以下两条方案供选择，如需要方案1不需要动，如需方案2，将方案2下面的--的符号去掉，给方案一的加上符号即可
--【方案1】主堆属性，高门、投巫、誓江、巾帼
是否使用金币 = 1
精品数组 = {
	["冰"] = {{xjName = "高门·冰", CyName  ="高门·冰残印"}, {xjName = "投巫·冰", CyName  ="投巫·冰残印"}, {xjName = "誓江·冰", CyName  = "誓江·冰残印"}, {xjName = "巾帼·冰", CyName  = "巾帼·冰残印"}}, 
	["火"] = {{xjName = "高门·火", CyName  ="高门·火残印"}, {xjName = "投巫·火", CyName  ="投巫·火残印"}, {xjName = "誓江·火", CyName  = "誓江·火残印"}, {xjName = "巾帼·火", CyName  = "巾帼·火残印"}}, 
	["玄"] = {{xjName = "高门·玄", CyName  ="高门·玄残印"}, {xjName = "投巫·玄", CyName  ="投巫·玄残印"}, {xjName = "誓江·玄", CyName  = "誓江·玄残印"}, {xjName = "巾帼·玄", CyName  = "巾帼·玄残印"}}, 
	["毒"] = {{xjName = "高门·毒", CyName  ="高门·毒残印"}, {xjName = "投巫·毒", CyName  ="投巫·毒残印"}, {xjName = "誓江·毒", CyName  = "誓江·毒残印"}, {xjName = "巾帼·毒", CyName  = "巾帼·毒残印"}}, 
}	
秘籍数组 = {{mjName = "投壶问月"},{mjName = "龟寿千年"},{mjName = "青眼有加"},{mjName = "龟鹤延年"}}
精品残印 = "高门·冰残印|投巫·冰残印|誓江·冰残印|巾帼·冰残印|高门·火残印|投巫·火残印|誓江·火残印|巾帼·火残印|高门·玄残印|投巫·玄残印|誓江·玄残印|巾帼·玄残印|高门·毒残印|投巫·毒残印|誓江·毒残印|巾帼·毒残印"


--【方案2】主堆血，高门、投巫、巾帼、伤魂
--是否使用金币 = 1
--精品数组 = {
--	["冰"] = {{xjName = "高门·冰", CyName  ="高门·冰残印"}, {xjName = "投巫·冰", CyName  ="投巫·冰残印"}, {xjName = "巾帼·冰", CyName  = "巾帼·冰残印"},{xjName = "伤魂", CyName  = "伤魂残印"}}, 
--	["火"] = {{xjName = "高门·火", CyName  ="高门·火残印"}, {xjName = "投巫·火", CyName  ="投巫·火残印"}, {xjName = "巾帼·火", CyName  = "巾帼·火残印"},{xjName = "伤魂", CyName  = "伤魂残印"}}, 
--	["玄"] = {{xjName = "高门·玄", CyName  ="高门·玄残印"}, {xjName = "投巫·玄", CyName  ="投巫·玄残印"}, {xjName = "巾帼·玄", CyName  = "巾帼·玄残印"},{xjName = "伤魂", CyName  = "伤魂残印"}}, 
--	["毒"] = {{xjName = "高门·毒", CyName  ="高门·毒残印"}, {xjName = "投巫·毒", CyName  ="投巫·毒残印"}, {xjName = "巾帼·毒", CyName  = "巾帼·毒残印"},{xjName = "伤魂", CyName  = "伤魂残印"}}, 
--}	
--秘籍数组 = {{mjName = "投壶问月"},{mjName = "龟寿千年"},{mjName = "青眼有加"},{mjName = "龟鹤延年"}}
--精品残印 = "高门·冰残印|投巫·冰残印|誓江·冰残印|巾帼·冰残印|高门·火残印|投巫·火残印|誓江·火残印|巾帼·火残印|高门·玄残印|投巫·玄残印|誓江·玄残印|巾帼·玄残印|高门·毒残印|投巫·毒残印|誓江·毒残印|巾帼·毒残印"



-----------------------------------------重要函数以下勿动---------------------------------------
-----------------------------------------重要函数以下勿动---------------------------------------

function 关闭窗口(strWindowName)
	if 窗口是否出现(strWindowName)==1 then
	  LUA_Call(string.format([[
		setmetatable(_G, {__index = %s_Env}) this:Hide()  
	 ]], strWindowName))  
	end
end

function 友情提示(text,...)
	local strCode = string.format(text,...)
	LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		DebugListBox_ListBox:AddInfo("#eaf0c14#Y".."【QQ3707181提示：】%s")
	]], strCode))
end

--======================================================================
-- 通用函数
--======================================================================


function ShanHaiBi()  
	return tonumber(LUA_取返回值("return Player:GetData('SHANHAIBI')"))
end

function GetChipCount(strName)
	return tonumber(LUA_取返回值(string.format([[
		for i = 1, 98 do
			local nXingJuanID = DataPool:LuaFnGetXingJuanID(i - 1)
			if nXingJuanID > 0 then
				local nName = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Name")
				if nName == "%s" then
					PushDebugMessage(nName.. "残印")
					return DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "ChipCount")
				end
			end
		end
	]],strName)))
end

function 获取良精珍周剩余次数()
	local LimitCount = {}
	local tem = LUA_取返回值([[
		local LimitCount = {}
		local limit1, limit2, limit3, _, _, _, _, _, _ = Player:GetData("SHShopLimit")
		local LimitNum, Limit = {120, 40, 8},{limit1, limit2, limit3}
		for i = 1,3 do 
			LimitCount[i] = LimitNum[i] - Limit[i]
		end
		return LimitCount[1] .. "|" .. LimitCount[2] .. "|" .. LimitCount[3]
	]])
	for w in string.gmatch(tem, "([^'|']+)") do        
		table.insert(LimitCount, w)
	end	
	return tonumber(LimitCount[1]),tonumber(LimitCount[2]),tonumber(LimitCount[3])
end

function 批量使用物品(AAA)
	local t={}
	for w in string.gmatch(AAA,"([^'|']+)") do        
		table.insert(t,w)
	end
	for k,v in ipairs(t) do
		--取出物品(v)
		执行功能("自动存仓")
		--[[for i =1, 99 do
			if 获取背包物品数量(v) <=0 then
				break
			end
			友情提示("使用物品:"..k..":"..v) 
			右键使用物品(v);延时(300)
			自动清包();
		end]]
	end
end

function 一键卸下无字谱心诀()
	for i = 1, 4 do 
		LUA_Call(string.format([[
			local i = %d
			local nXingJuanID = DataPool:LuaFnGetActivedXingJuanID(i)
			if nXingJuanID ~= 0 then		
				local nName = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Name")
				PushDebugMessage("你即将卸下心诀[ " .. nName .. " ]")
				Clear_XSCRIPT()
					Set_XSCRIPT_Function_Name("InsertSlot")
					Set_XSCRIPT_ScriptID(888555)
					Set_XSCRIPT_Parameter(0, nXingJuanID)	
					Set_XSCRIPT_Parameter(1, 0)	
					Set_XSCRIPT_Parameter(2, 0)
					Set_XSCRIPT_ParamCount(3)
				Send_XSCRIPT()
			else
				PushDebugMessage("无字谱第[ " .. i .. " ]孔位没有装备心诀")
			end
		]], i))
		延时(1000) 
	end 
end

function 获取已装备心诀信息(i, Val) -- i表示孔位,Val为"Name","Level","Order"
	local tmp = {}
	local tem = LUA_取返回值(string.format([[
		local i = %d
		local nXingJuanID = DataPool:LuaFnGetActivedXingJuanID(i) 			
		local nName = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Name")
		local nLevel = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Level")
		local nOrder = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Order")
		return nName .. "|" .. nLevel .. "|" .. nOrder
	]],i))
	for w in string.gmatch(tem, "([^'|']+)") do        
		table.insert(tmp, w)
	end
	if Val == "Name" then
		return tmp[1]
	elseif Val == "Level" then
		return tonumber(tmp[2])
	elseif Val == "Order" then
		return tonumber(tmp[3])
	end
end

function 取无字谱心决可装备ID()
	local tem = LUA_取返回值(string.format([[
	for idx =1,98 do
		local nXingJuanID = DataPool:LuaFnGetXingJuanID(idx - 1)	
		local nUnLocked = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "UnLocked")
		if nUnLocked == 1 then
			local nLevel = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Level")
			local nSlot = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Slot")
			if nSlot== 0 then
				return nXingJuanID
			end
		end
	end
	return -1
	]])) 
	return tonumber(tem)
end

function 取无字谱秘技可装备ID()
	local tem = LUA_取返回值(string.format([[

	for idx =1,46 do
		local nSkillCardID = DataPool:LuaFnGetSkillCardID(idx - 1)	
		local nUnLocked = DataPool:LuaFnGetSkillCardInfo(nSkillCardID, "UnLocked")
		if nUnLocked == 1 then
			local nLevel = DataPool:LuaFnGetSkillCardInfo(nSkillCardID, "Level")
			local nSlot = DataPool:LuaFnGetSkillCardInfo(nSkillCardID, "Slot")
			if nSlot== 0 then
				return nSkillCardID
			end
		end
	end
	return -1
	]])) 
	return tonumber(tem)	
end

function 装备无字谱(name, pos)
	LUA_Call(string.format([[
		local SetName = "%s"
		local SetSlot = %d
		local xuhao = -1
		local nID = -1
		local nCount = DataPool:LuaFnGetXingJuanListCount()
		for i = 1, nCount - 1 do 
			local nXingJuanID = DataPool:LuaFnGetXingJuanID(i - 1)
			if nXingJuanID > 0 then
				local nName = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Name")
				if SetName == nName then
					xuhao = 1
					nID = nXingJuanID
				end
			end
		end
		local nCount = DataPool:LuaFnGetSkillCardListCount()
		for i = 1, nCount - 1 do 
			local nSkillCardID = DataPool:LuaFnGetSkillCardID(i - 1)	
			if nSkillCardID > 0 then
				local nName = DataPool:LuaFnGetSkillCardInfo(nSkillCardID, "Name")
				if SetName == nName then
					xuhao = 2
					nID = nSkillCardID
				end
			end
		end
		if nID ~= -1 and xuhao ~= -1 then
			Clear_XSCRIPT()
				Set_XSCRIPT_Function_Name("InsertSlot")
				Set_XSCRIPT_ScriptID(888555)
				Set_XSCRIPT_Parameter(0, nID)	
				Set_XSCRIPT_Parameter(1, SetSlot)		--上阵插槽
				Set_XSCRIPT_Parameter(2, xuhao - 1)		--表示0心诀 1技能
				Set_XSCRIPT_ParamCount(3)
			Send_XSCRIPT()
		else 
			if xuhao == 1 then
				PushDebugMessage("没有心诀[ " .. SetName .. " ]无法装备！")
			elseif xuhao == 2 then
				PushDebugMessage("没有秘技[ " .. SetName .. " ]无法装备！")
			end
		end
	]],name, pos))
end


function 打开无字谱窗口(index)
	for  i = 1,5 do
		if 窗口是否出现("Rune_Stars") ==1 then
			if index == 1 then
				LUA_Call("setmetatable(_G, {__index = Rune_Stars_Env});Rune_Stars_SubFenYe_Switch(0)")
			elseif index == 2  then
				LUA_Call("setmetatable(_G, {__index = Rune_Stars_Env});Rune_Stars_SubFenYe_Switch(1)")
			
			end
			break
		else
			LUA_取返回值(string.format([[
			setmetatable(_G, {__index = PlayerQuicklyEnter_Env});
			PlayerQuicklyEnter_Clicked(65)
			]])) ;延时(2000)	
		end
	end
end

function 归山阁购买(物品名称,数量)
	for  i = 1, 5 do
		if 窗口是否出现("NewDungeon_DaibiShop") == 1 then
			local tem =LUA_取返回值(string.format([[
			TTname ="%s"
			TTnum = %d
			 for i=0,67 do
				local theAction = EnumAction(i, "boothitem")
				local ID = theAction:GetID() 
				if ID~= 0 then
					local  name =  theAction:GetName()
					if TTname == name then
						local nPrice = NpcShop:EnumItemPrice(i) --价格
							local haveTokens = Player:GetData("SHANHAIBI")
						 	local nMaxCanBuyByMoney = math.floor(haveTokens/nPrice)
							if TTnum>=nMaxCanBuyByMoney then
								local num =nMaxCanBuyByMoney
								else
								local  num = TTnum
							end
							NpcShop:BulkBuyItem(i, TTnum, 0)
							return 1
					end
				end
			end
			return -1 	
			]],物品名称,数量))  
			if tonumber(tem) == 1 then
				break
			end			
		else
				跨图寻路("大理",210,53)
				if 对话NPC("沈寒洲")==1 then
					NPC二级对话("归山阁"); 延时(2000)
					LUA_取返回值(string.format([[
			setmetatable(_G, {__index = NewDungeon_DaibiShop_Env});
			NewDungeon_DaibiShop_ChangeShowTab(1);
			]]))  ; 延时(2000)
				else 
				  延时(1000)
				end
		end	
	end	
	LUA_取返回值(string.format([[
		setmetatable(_G, {__index = NewDungeon_DaibiShop_Env});NewDungeon_DaibiShop_CloseClicked();
		]]))   --关闭关山
end	

function 无字谱孔位取心决信息(位置,序号)		
	local tem = LUA_取返回值(string.format([[
				weizhi =%d
				xuhao =%d
				nXingJuanID = DataPool:LuaFnGetActivedXingJuanID(weizhi)	
				--xj_to_slot = DataPool:LuaFnHaveXingJuanToSlot()
				theAction = EnumAction(nXingJuanID,"xingjuan")
				ID = theAction:GetID() 
				if ID> 0 then
					  name = theAction:GetName() 
					else
					  name = 0
				end
				if xuhao == 1 then
					return ID
				elseif xuhao == 2 then
					return name
				elseif xuhao == 3 then
					return	nXingJuanID
				end
				]], 位置,序号))  
	return tem
end	

function 无字谱孔位取秘技信息(位置,序号)		
	local tem = LUA_取返回值(string.format([[
				weizhi =%d
				xuhao =%d
				nXingJuanID = DataPool:LuaFnGetActivedSkillCardID(weizhi)	
				--xj_to_slot = DataPool:LuaFnHaveXingJuanToSlot()
				theAction = EnumAction(nXingJuanID,"xingjuan")
				ID = theAction:GetID() 
				if ID> 0 then
					  name = theAction:GetName() 
					else
					  name = 0
				end
				if xuhao == 1 then
					return ID
				elseif xuhao == 2 then
					return name
				end
				]], 位置,序号))  
		return tem
end	

function 心决升阶(index)	
	local IDDD =tonumber(无字谱孔位取心决信息(index,3))		
	if IDDD > 0 then
        LUA_取返回值(string.format([[
			g_CurrentSelXingJuanID =%d
			Clear_XSCRIPT()
				Set_XSCRIPT_Function_Name("XingJuanLevelUp")
				Set_XSCRIPT_ScriptID(888555)
				Set_XSCRIPT_Parameter(0, g_CurrentSelXingJuanID)
				Set_XSCRIPT_Parameter(1, 1)
				Set_XSCRIPT_ParamCount(2)
			 Send_XSCRIPT()
		]],IDDD))  
		延时(500)
	end
end

function 心决强化(index)	
	local IDDD =tonumber(无字谱孔位取心决信息(index,3))		
	if IDDD > 0 then
		友情提示("心决强化"..IDDD)
		for k = 1,10 do
			LUA_取返回值(string.format([[
			    g_CurrentSelXingJuanID =%d
			    Clear_XSCRIPT()
				    Set_XSCRIPT_Function_Name("XingJuanLevelUp")
				    Set_XSCRIPT_ScriptID(888555)
				    Set_XSCRIPT_Parameter(0, g_CurrentSelXingJuanID)
				    Set_XSCRIPT_Parameter(1, 0)
				    Set_XSCRIPT_ParamCount(2)
			    Send_XSCRIPT()
			]],IDDD))  
			延时(500)
		end 
		心决升阶(index)
	end 
end

function 领悟心决()
	LUA_取返回值(string.format([[
	for i =1,98 do
		local nXingJuanID = DataPool:LuaFnGetXingJuanID(i-1)
		local nUnLocked = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "UnLocked")
		local nLevel = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Level")
		local nSlot = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Slot")
		local nOrder = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Order")
		local nChipCount = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "ChipCount")
		local nActiveNeedChipCount = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "ActiveNeedChipCount")
		local nQuality = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Quality")
		local strName = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Name")
		if nUnLocked ==0 and nChipCount >= nActiveNeedChipCount then
			Clear_XSCRIPT()
				Set_XSCRIPT_Function_Name("ActiveXingJuan")
				Set_XSCRIPT_ScriptID(888555)
				Set_XSCRIPT_Parameter(0, nXingJuanID)
				Set_XSCRIPT_ParamCount(1)
			Send_XSCRIPT()
		end	
	end	
			]]))  
end

function 无字谱装备功能(ID,功能,序号)
		LUA_Call(string.format([[
		
		nSkillCardID=%d
		gongneng =%d
		xuhao =%d
		Clear_XSCRIPT()
			Set_XSCRIPT_Function_Name("InsertSlot")
			Set_XSCRIPT_ScriptID(888555)
			Set_XSCRIPT_Parameter(0, nSkillCardID)	
			Set_XSCRIPT_Parameter(1, gongneng)				--参数2  0卸下 1装备 
			Set_XSCRIPT_Parameter(2, xuhao-1)				--参数2  0心决 1技能
			Set_XSCRIPT_ParamCount(3)
		Send_XSCRIPT()
	]],ID,功能,序号))  
end

人物名称,门派,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()
local tem =LUA_取返回值(string.format([[
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
属性攻击=tem
	
function 精品无字谱安装()	
    打开无字谱窗口(1)
    友情提示("优先取人物最高属性攻击:"..属性攻击.."无字谱心决安装")
	for i = 1,4 do
		友情提示("开始装备"..精品数组[属性攻击][i].xjName.."位置"..i)
        装备无字谱(精品数组[属性攻击][i].xjName, i)
		延时(3000)
	end   
end

function 安装条件外可装备无字谱()
    打开无字谱窗口(1)
	for i = 1,4 do		
	    if 获取已装备心诀信息(i, "Name") ~= 精品数组[属性攻击][i].xjName  then 
		    local ID = 取无字谱心决可装备ID()
			if ID > 0 then
				友情提示("开始装备[%d]位置[%d]",ID,i)
				无字谱装备功能(ID,i,1)
				延时(3000)
		    end
		end 
	end 
	
	打开无字谱窗口(2)   
	for i =1, 4 do
		友情提示("开始装备"..秘籍数组[i].mjName.."位置"..i)
        装备无字谱(秘籍数组[i].mjName, i)
		延时(2000)
	end
end 

function 检测已有无字谱强化()
    打开无字谱窗口(1)
    if ShanHaiBi() < 1750 then
	    友情提示("你只有"..ShanHaiBi().."历练值,跳过强化无字谱任务")
	    延时(2000)
	    友情提示("你只有"..ShanHaiBi().."历练值,跳过强化无字谱任务")
	    延时(2000)
	    友情提示("你只有"..ShanHaiBi().."历练值,跳过强化无字谱任务")
	    延时(2000)
	    return
    end 

    if 到数值(获取人物信息(45)+获取人物信息(52)) < 700*10000 then
		友情提示("金币不足强化无字谱到5阶0级")
		return
	end 
	
	local Lpcs,Jpcs,Zpsc = 获取良精珍周剩余次数()
	if 到数值(Jpcs) < 35 then
		友情提示("你本周剩下的购买精品的次数不够升级一套完整的良品无字谱")
		return
	end
	
	--一键卸下无字谱心诀()
	--延时(2000)
	--精品无字谱安装()
	--延时(2000)
	--安装条件外可装备无字谱()
    
	for i = 1,4 do
		打开无字谱窗口(1)
		local Lpcs,Jpcs,Zpsc = 获取良精珍周剩余次数()
		if  到数值(Jpcs) < 35 then
			友情提示("你本周购买精品次数已达上限，请下周再来")
			break 
		end
		
	    if 获取已装备心诀信息(i, "Name") == 精品数组[属性攻击][i].xjName  then 
		    --while 到数值(获取已装备心诀信息(i,"Order"))~= 5 and 到数值(获取已装备心诀信息(i,"Level"))~= 0 do 
			while true do
			    if 到数值(获取已装备心诀信息(i,"Order"))== 5 and 到数值(获取已装备心诀信息(i,"Level"))== 0 then 
					友情提示("你的"..获取已装备心诀信息(i, "Name").."已经"..获取已装备心诀信息(i,"Order").."阶"..获取已装备心诀信息(i,"Level").."级")
					break
				end
			    if 到数值(获取已装备心诀信息(i,"Order"))== 0 then 
					local  mun = GetChipCount(精品数组[属性攻击][i].xjName)
					友情提示("现有"..精品数组[属性攻击][i].CyName..mun.."个")
				    延时(1000)
				    归山阁购买(精品数组[属性攻击][i].CyName,35- mun)--0
					延时(1000)
				    批量使用物品(精品残印)
					延时(1000)
					for kkk = 1, 5 do 
						心决强化(i)
					end
				elseif 到数值(获取已装备心诀信息(i,"Order"))== 1 then 
				    local  mun = GetChipCount(精品数组[属性攻击][i].xjName)
					友情提示("现有"..精品数组[属性攻击][i].CyName..mun.."个")
				    延时(1000)
				    归山阁购买(精品数组[属性攻击][i].CyName,30- mun)--1
					延时(1000)
				    批量使用物品(精品残印)
					延时(1000)
					for kkk = 1, 5 do 
						心决强化(i)
					end
				elseif 	到数值(获取已装备心诀信息(i,"Order"))== 2 then 
				    local  mun = GetChipCount(精品数组[属性攻击][i].xjName)
					友情提示("现有"..精品数组[属性攻击][i].CyName..mun.."个")
				    归山阁购买(精品数组[属性攻击][i].CyName,35- mun)--2
					延时(1000)
				    批量使用物品(精品残印)
					延时(1000)
					for kkk = 1, 5 do 
						心决强化(i)
					end
				elseif 	到数值(获取已装备心诀信息(i,"Order"))== 3 then 
				    local  mun = GetChipCount(精品数组[属性攻击][i].xjName)
					友情提示("现有"..精品数组[属性攻击][i].CyName..mun.."个")
				    延时(1000)
				    归山阁购买(精品数组[属性攻击][i].CyName,17- mun)--3
					延时(1000)
				    批量使用物品(精品残印)
					延时(1000)
					for kkk = 1, 5 do 
						心决强化(i)
					end
				elseif 到数值(获取已装备心诀信息(i,"Order"))== 4 then 
				    local  mun = GetChipCount(精品数组[属性攻击][i].xjName)
					友情提示("现有"..精品数组[属性攻击][i].CyName..mun.."个")
				    延时(1000)
				    归山阁购买(精品数组[属性攻击][i].CyName,9- mun)--4
					延时(1000)
				    批量使用物品(精品残印)
					延时(1000)
					for kkk = 1, 5 do 
						心决强化(i)
					end
				end 
			end
		end 
	end  
end

function 购买领悟强化无字谱()
    if ShanHaiBi() < 2000 then
	    友情提示("你只有"..ShanHaiBi().."历练值,跳过购买无字谱任务")
	    延时(2000)
	    友情提示("你只有"..ShanHaiBi().."历练值,跳过购买无字谱任务")
	    延时(2000)
	    友情提示("你只有"..ShanHaiBi().."历练值,跳过购买无字谱任务")
	    延时(2000)
	    return
    end 
	
	if 到数值(获取人物信息(45)+获取人物信息(52)) <100*10000 then
		友情提示("金币不足购买及升级无字谱到1阶10级")
		return
	end 
	
	local Lpcs,Jpcs,Zpsc = 获取良精珍周剩余次数()
	if 到数值(Jpcs) < 40 then
		友情提示("你本周剩下的购买精品的次数不够升级一套完整的良品无字谱")
		return
	end
		
	一键卸下无字谱心诀()
	延时(2000)
	精品无字谱安装()
	延时(2000)

	for i = 1,4 do		
	    if 获取已装备心诀信息(i, "Name") ~= 精品数组[属性攻击][i].xjName  then 
			local Lpcs,Jpcs,Zpsc = 获取良精珍周剩余次数()
			if  到数值(Jpcs) < 40 then
			    友情提示("你本周购买精品次数已达上限，请下周再来")
				break 
			end 
			    延时(1000)
		        友情提示("没有"..精品数组[属性攻击][i].xjName.."心决，现在就去购买")
		        归山阁购买(精品数组[属性攻击][i].CyName,40)
		        延时(1000)
	            批量使用物品(精品残印)
		        延时(1000)
		        领悟心决()
		        延时(1000)
			    装备无字谱(精品数组[属性攻击][i].xjName, i)
			    延时(1000)
			--while 到数值(获取已装备心诀信息(i,"Order"))~= 1 and 到数值(获取已装备心诀信息(i,"Level"))~= 10 do 
			--while true do 
		        for tt = 1,5  do
					if 到数值(获取已装备心诀信息(i,"Order"))== 1 and 到数值(获取已装备心诀信息(i,"Level"))== 10 then
						break  
					end 
					if 到数值(获取已装备心诀信息(i,"Order"))== 2 and 到数值(获取已装备心诀信息(i,"Level"))== 0 then
						break  
					end
		            心决强化(i)
				end 
			--end 
		end 
	end 
	延时(1000)
	安装条件外可装备无字谱()
end

if 是否使用金币 == 否 then
	友情提示("你选择了不使用金币升级无字谱，现在存仓金币")
	存物品("金币")
elseif 是否使用金币 == 是 then
	友情提示("你选择了使用金币升级无字谱，现在取出金币")
	取出物品("金币")
end 


购买领悟强化无字谱()
检测已有无字谱强化()
关闭窗口("Rune_Stars")



