

function 晴天_判断关闭窗口(strWindowName)
	if 窗口是否出现(strWindowName)==1 then
		LUA_Call(string.format([[
			setmetatable(_G, {__index = %s_Env}) this:Hide()  
		]], strWindowName))  
		延时(1500)
	  end
end
function 晴天_友情提示(text,...)
	local strCode = string.format(text,...)
	LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【晴天QQ103900393提示】".."#eFF0000".."%-88s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end



function 晴天_取人物属性(分类)  --1是最高属性 2是门派
	local 人物名称,menpai,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()
	if  分类 ==1 then
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
		晴天_友情提示("晴天取人物最高属性攻击:"..属性攻击)
	elseif  分类 == 2 then
		if string.find("唐门|星宿|丐帮", menpai) then
			属性攻击="毒"
		elseif  string.find("逍遥|明教|", menpai) then
			属性攻击="火"
		elseif  string.find("峨嵋|天山|", menpai) then
			属性攻击="冰"
		elseif  string.find("天龙|少林|鬼谷|慕容|武当", menpai) then
			属性攻击="玄"
		end
	else
		return -1
	end
	return 属性攻击
end


function 晴天_取抗性值(index)
		LUA_Call ("MainMenuBar_SelfEquip_Clicked();");延时(1500) -- 人物界面打开
	local tem=  LUA_取返回值(string.format([[ 
			index=%d
			local iIceDefine  		= Player:GetData( "DEFENCECOLD" );
			local iFireDefine 		= Player:GetData( "DEFENCEFIRE" );
			local iThunderDefine	= Player:GetData( "DEFENCELIGHT" );
			local iPoisonDefine		= Player:GetData( "DEFENCEPOISON" );
			
			--不显示负抗性 add by hukai#48117
			if (iIceDefine~=nil and iIceDefine < 0 ) then
				iIceDefine = 0
			end
			if (iFireDefine~=nil and iFireDefine < 0 ) then
				iFireDefine = 0
			end
			if (iThunderDefine~=nil and iThunderDefine < 0 ) then
				iThunderDefine = 0
			end
			if (iPoisonDefine~=nil and iPoisonDefine < 0 ) then
				iPoisonDefine = 0
			end	
			
			if index==1 then
				return iIceDefine
			elseif index==2 then
				return iFireDefine
			elseif index==3 then
				return iThunderDefine
			elseif index==4 then
				return iPoisonDefine
			end
			return -1
		]], index))
	if tem then 	
	return tonumber(tem)	
	end
	return  0
end	




function 晴天_使用物品(物品列表,是否绑定)
	if 是否绑定 ==0 or 是否绑定 == nil then
		tbangding =10
	elseif  是否绑定 ==1 then
		tbangding = 0
	elseif  是否绑定 ==2 then
		tbangding = 1
	end
	for i=0,200 do
		local tem = LUA_取返回值(string.format([[
			local tbangding =tostring("%s")
			local i =%d
			local ttname = "%s"
			local theAction=EnumAction(i,"packageitem")
			if theAction:GetID() ~= 0 then
				local GetName=theAction:GetName()
				local szItemNum =theAction:GetNum();
				local Status=GetItemBindStatus(i);
				if GetName~=nil and GetName ~="" then
					if string.find("|"..ttname.."|","|"..GetName.."|",1,true) then
						if string.find(tbangding,tostring(Status)) then
							PushDebugMessage("右击物品:"..GetName.."|背包位置:"..i)
							return 1
						end	
					end
				end
			end	
			return -1
		]],tbangding, i,物品列表))
  		if tonumber(tem)>= 1 then 
			LUA_Call(string.format([[
				local theAction = EnumAction(%d, "packageitem");
				if theAction:GetID() ~= 0 then
						setmetatable(_G, {__index = Packet_Env});
						local oldid = Packet_Space_Line1_Row1_button:GetActionItem();
						Packet_Space_Line1_Row1_button:SetActionItem(theAction:GetID());
						Packet_Space_Line1_Row1_button:DoAction();
						Packet_Space_Line1_Row1_button:SetActionItem(oldid);
				end
			]],i))
			延时(2000)
			LUA_Call(string.format([[
				setmetatable(_G, {__index = Item_MultiUse_Env});
				local txt=Item_MultiUse_ItemInfo_Text:GetText()
				if txt~="" and string.find("%s",txt,1,true) then
					PushDebugMessage("晴天批量使用物品:"..txt)
					Item_MultiUse_BuyMulti_Clicked()
				end
			]],物品列表))
		end
	end
end




function 晴天_无字谱使用()
	晴天_使用物品("刻木|精品残印集录|还珠·火残印|良品礼扎|名士还礼·良品",2)
	for i =1, 99 do
		屏幕提示("无字谱-投壶问月")
		if 获取背包物品数量("投壶问月") <= 0 then
			晴天_判断关闭窗口("GiveGift")
			break
		end
		跨图寻路("大理",270,116)
		if 对话NPC("名士芙蓉仙子")==1 then
            NPC二级对话("请教投壶问月",0)
			延时(1000)
		end		
	end
	
	for i =1, 99 do
		屏幕提示("无字谱-赠予佛跳墙")
		if 获取背包物品数量("佛跳墙") <= 0 then
			晴天_判断关闭窗口("GiveGift")
			break
		end	
		if 窗口是否出现("GiveGift")== 1 then
			LUA_Call("setmetatable(_G, {__index = GiveGift_Env});GiveGift_GiveOneTime();")	
			延时(1000)
		else
			跨图寻路("大理",174,136)
			if 对话NPC("名士包不同")==1 then
				NPC二级对话("赠予佛跳墙",0)
				延时(1000)
			end		
		end
	end
	----------------------------------------------
	for i =1, 99 do
		屏幕提示("无字谱-赠予金丝冠")
		if 获取背包物品数量("金丝冠") <= 0 then
			晴天_判断关闭窗口("GiveGift")
			break
		end	
		if 窗口是否出现("GiveGift")== 1 then
			LUA_Call("setmetatable(_G, {__index = GiveGift_Env});GiveGift_GiveOneTime();")	
			延时(1000)
		else
			跨图寻路("大理",270,116)
			if 对话NPC("名士芙蓉仙子")==1 then
				NPC二级对话("赠予金丝冠",0)
				延时(1000)
			end		
		end
	end
	--------------------------------
	for i =1, 99 do
		屏幕提示("无字谱-赠予猴儿酿")
		if 获取背包物品数量("猴儿酿") <= 0 then
			晴天_判断关闭窗口("GiveGift")
			break
		end	
		if 窗口是否出现("GiveGift")== 1 then
			LUA_Call("setmetatable(_G, {__index = GiveGift_Env});GiveGift_GiveOneTime();")	
			延时(1000)
		else
			跨图寻路("大理",270,116)
			if 对话NPC("名士芙蓉仙子")==1 then
				NPC二级对话("赠予猴儿酿",0)
				延时(1000)
			end		
		end
	end
end	
----------------------------------------------------------------------------------------------

function 晴天_打开无字谱窗口(index)
	for  i = 1,5 do
		if 窗口是否出现("Rune_Stars") ==1 then
			if index == 1 then
				LUA_Call("setmetatable(_G, {__index = Rune_Stars_Env});Rune_Stars_SubFenYe_Switch(0)")
			elseif index == 2  then
				LUA_Call("setmetatable(_G, {__index = Rune_Stars_Env});Rune_Stars_SubFenYe_Switch(1)")
			elseif index == 3 then
				晴天_友情提示("打开心决强化")
				LUA_Call("setmetatable(_G, {__index = Rune_Stars_Env});Rune_Stars_FenYe_Switch(2)")
				延时(1000)
				LUA_Call("setmetatable(_G, {__index = Rune_Stars_Reel_Env});Rune_Stars_Reel_SubFenYe_Switch(1)")
				延时(1000)
			elseif index == 4 then
				晴天_友情提示("打开心决领悟")
				LUA_Call("setmetatable(_G, {__index = Rune_Stars_Env});Rune_Stars_FenYe_Switch(2)")
				延时(1000)
				LUA_Call("setmetatable(_G, {__index = Rune_Stars_Reel_Env});Rune_Stars_Reel_SubFenYe_Switch(2)")
				延时(1000)	
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



function 晴天_取上海比()
	local tem = LUA_取返回值(string.format([[
	local haveTokens = Player:GetData("SHANHAIBI")
	return  haveTokens 
	]])) 
	return tonumber(tem)
end

屏幕提示("你当前的管山币:"..晴天_取上海比())
延时(2000)
function 晴天_取无字谱心决信息(name,xuhao)
	local tem = LUA_取返回值(string.format([[
	TTname ="%s"
	xuhao =%d
	for idx =1,98 do
		local nXingJuanID = DataPool:LuaFnGetXingJuanID(idx - 1)	
		local strName = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Name")
		if strName==TTname then
			if xuhao == 1 then
				return nXingJuanID
			elseif xuhao == 2 then
				return strName
			elseif xuhao == 3 then
				local nUnLocked = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "UnLocked")
				return	nUnLocked
			elseif xuhao == 4 then
				local nLevel = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Level")
				return	nLevel	
			elseif xuhao == 5 then	
				local nOrder = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Order")
				return	nOrder
			end			
		end
	end	
	return -1
	]],name,xuhao)) 
	return tonumber(tem)
end

function 晴天_装备无字谱心决(name,index)
	晴天_打开无字谱窗口(1)
	晴天_友情提示("智能装备[%s]卡槽[%d]",name,index)
	延时(2000)
	LUA_取返回值(string.format([[
	for idx =1,98 do
		local nXingJuanID = DataPool:LuaFnGetXingJuanID(idx - 1)	
		local nUnLocked = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "UnLocked")
		local strName = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Name")
		if nUnLocked == 1 and strName == "%s" then
			local nLevel = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Level")
			local nSlot = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Slot")
			if nSlot== 0 then
				PushDebugMessage(nXingJuanID)
				Clear_XSCRIPT()
					Set_XSCRIPT_Function_Name("InsertSlot")
					Set_XSCRIPT_ScriptID(888555)
					Set_XSCRIPT_Parameter(0, nXingJuanID)	
					Set_XSCRIPT_Parameter(1, %d)
					Set_XSCRIPT_Parameter(2, 0)			
					Set_XSCRIPT_ParamCount(3)
				Send_XSCRIPT()
			end
		end
	end
	]],name,index)) 
end


function 晴天_取无字谱心决可装备ID()
	晴天_打开无字谱窗口(1)
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

function 晴天_取无字谱秘技可装备ID()
	晴天_打开无字谱窗口(2)
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
	晴天_判断关闭窗口("Rune_Stars")
	return tonumber(tem)	
end

function 晴天_无字谱装备功能(ID,功能,序号)
		LUA_Call(string.format([[
		nSkillCardID=%d
		gongneng =%d
		xuhao =%d
		Clear_XSCRIPT()
			Set_XSCRIPT_Function_Name("InsertSlot")
			Set_XSCRIPT_ScriptID(888555)
			Set_XSCRIPT_Parameter(0, nSkillCardID)	
			Set_XSCRIPT_Parameter(1, gongneng)				--参数1  0卸下 1装备 
			Set_XSCRIPT_Parameter(2, xuhao-1)				--参数2  0心决 1技能
			Set_XSCRIPT_ParamCount(3)
		Send_XSCRIPT()
	]],ID,功能,序号))  
end

function 晴天_无字谱孔位取心决信息(位置,序号)		
	晴天_打开无字谱窗口(1)
	local tem = LUA_取返回值(string.format([[
				weizhi =%d
				xuhao =%d
				nXingJuanID = DataPool:LuaFnGetActivedXingJuanID(weizhi)	
				--xj_to_slot = DataPool:LuaFnHaveXingJuanToSlot()
				theAction = EnumAction(nXingJuanID,"xingjuan")
				ID = theAction:GetID() 
				if ID> 0 then
					  name = theAction:GetName() 
						local nLevel = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Level")
					else
					  name = 0
				end
				if xuhao == 1 then
					return ID
				elseif xuhao == 2 then
					return name
				elseif xuhao == 3 then
					return	nXingJuanID
				elseif xuhao == 4 then
					return	nXingJuanID	
				end
				]], 位置,序号))  
				晴天_判断关闭窗口("Rune_Stars")
	return tem
end	

function 晴天_无字谱孔位取秘技信息(位置,序号)		
	晴天_打开无字谱窗口(2)
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
		晴天_判断关闭窗口("Rune_Stars")
		return tem
end	



--屏幕提示(晴天_无字谱孔位取心决信息(1,1)) --取位置1的ID
--屏幕提示(晴天_取无字谱心决可装备ID())		--取可以装备的ID
--屏幕提示(晴天_无字谱孔位取秘技信息(1,1)) 
--屏幕提示(晴天_取无字谱秘技可装备ID()) 





function 晴天_全自动装备无字谱()
	晴天_打开无字谱窗口(2)
	
	for i =1, 4 do
		if tonumber( 晴天_无字谱孔位取心决信息(i,1))	== 0 then
			local ID =晴天_取无字谱心决可装备ID()
			if ID > 0 then
				晴天_友情提示("开始装备[%d]位置[%d]",ID,i)
				晴天_无字谱装备功能(ID,i,1)
				延时(3000)
			end
		end
	end
	延时(3000)
	for i =1, 4 do
		if tonumber( 晴天_无字谱孔位取秘技信息(i,1))	== 0 then
			local ID =晴天_取无字谱秘技可装备ID()
			if ID > 0 then
				晴天_友情提示("开始装备[%d]位置[%d]",ID,i)
				晴天_无字谱装备功能(ID,i,2)
				延时(3000)
			end
		end
	end
	晴天_判断关闭窗口("Rune_Stars")
end

function 晴天_归山阁购买(物品名称,数量)	
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
				if 晴天_取上海比() < 50 then
					晴天_友情提示("上海比少于50")
					break
				end	
				else 
				  延时(1000)
				end
		end	
	end	
	LUA_取返回值(string.format([[
		setmetatable(_G, {__index = NewDungeon_DaibiShop_Env});NewDungeon_DaibiShop_CloseClicked();
		]]))   --关闭关山
end	

function 晴天_心决强化(name)
	晴天_友情提示("心决强化:"..name)
	LUA_取返回值(string.format([[
	for idx =1,98 do
		local nXingJuanID = DataPool:LuaFnGetXingJuanID(idx - 1)	
		local nUnLocked = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "UnLocked")
		if   nUnLocked ==1 then
			local strName = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Name")
			if strName =="%s" then
				local nLevel = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Level")
				local nOrder = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Order")
				PushDebugMessage("当前等级:"..nOrder.."阶"..nLevel)
				if nLevel ==10 then

					Clear_XSCRIPT()
						Set_XSCRIPT_Function_Name("XingJuanLevelUp")
						Set_XSCRIPT_ScriptID(888555)
						Set_XSCRIPT_Parameter(0, nXingJuanID)
						Set_XSCRIPT_Parameter(1, 1)
						Set_XSCRIPT_ParamCount(2)
					Send_XSCRIPT()
					return
				else
					Clear_XSCRIPT()
						Set_XSCRIPT_Function_Name("XingJuanLevelUp")
						Set_XSCRIPT_ScriptID(888555)
						Set_XSCRIPT_Parameter(0, nXingJuanID)
						Set_XSCRIPT_Parameter(1, 0)
						Set_XSCRIPT_ParamCount(2)
					Send_XSCRIPT()
				end
			end
		end
	end	
	]],name))  
	晴天_判断关闭窗口("Rune_Stars")
	延时(1000)
end

function 晴天_领悟心决()
	晴天_打开无字谱窗口(4)
	晴天_友情提示("领悟下心决开干")
	延时(2000)
	for i =1,98 do
		local tem =	LUA_取返回值(string.format([[
		local i=%d
		local nXingJuanID =-1
		nXingJuanID = DataPool:LuaFnGetXingJuanID(i-1)
		local nUnLocked = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "UnLocked")
		local nLevel = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Level")
		local nSlot = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Slot")
		local nOrder = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Order")
		local nChipCount = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "ChipCount")
		local nActiveNeedChipCount = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "ActiveNeedChipCount")
		local nQuality = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Quality")
		local strName = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Name")
		if nUnLocked ==0 and nChipCount >= nActiveNeedChipCount then
			return nXingJuanID
		end
		return -1	
			]],i))  	
		if  tonumber( tem ) >0 then
				LUA_取返回值(string.format([[
						Clear_XSCRIPT()
				Set_XSCRIPT_Function_Name("ActiveXingJuan")
				Set_XSCRIPT_ScriptID(888555)
				Set_XSCRIPT_Parameter(0, %d)
				Set_XSCRIPT_ParamCount(1)
				Send_XSCRIPT()
					]],tem))  
				延时(2000)	
		end	
	end		
	晴天_判断关闭窗口("Rune_Stars")
end





function 晴天_取心决残印还需数量(name)
	local tem = LUA_取返回值(string.format([[
	for i =1,98 do
		local nXingJuanID = DataPool:LuaFnGetXingJuanID(i-1)
		local strName = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Name")
		if  strName=="%s" then 
			local nUnLocked = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "UnLocked")
			local nLevel = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Level")
			local nSlot = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Slot")
			local nOrder = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Order")
			local nChipCount = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "ChipCount")
			local nActiveNeedChipCount = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "ActiveNeedChipCount")
			local nQuality = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Quality")
			if nActiveNeedChipCount>nChipCount then
				return	nActiveNeedChipCount-nChipCount
			end
		end			
	end	
	return -1
			]],name))  
			return tonumber(tem)
end


function 晴天_取心决残印数量(name)
	local tem = LUA_取返回值(string.format([[
	for i =1,98 do
		local nXingJuanID = DataPool:LuaFnGetXingJuanID(i-1)
		local strName = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Name")
		if  strName=="%s" then 
			local nUnLocked = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "UnLocked")
			local nLevel = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Level")
			local nSlot = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Slot")
			local nOrder = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Order")
			local nChipCount = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "ChipCount")
			local nActiveNeedChipCount = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "ActiveNeedChipCount")
			local nQuality = DataPool:LuaFnGetXingJuanInfo(nXingJuanID, "Quality")
			return	nChipCount
		end			
	end	
	return 0
			]],name))  
			return tonumber(tem)
end



function 晴天_取人物属性(分类)  --1是最高属性 2是门派
	local  人物名称,menpai,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()
	if  分类 ==1 then
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
		晴天_友情提示("晴天取人物最高属性攻击:"..属性攻击)
	elseif  分类 == 2 then
		if string.find("唐门|星宿|丐帮", menpai) then
			属性攻击="毒"
		elseif  string.find("逍遥|明教|", menpai) then
			属性攻击="火"
		elseif  string.find("峨嵋|天山|", menpai) then
			属性攻击="冰"
		elseif  string.find("天龙|少林|鬼谷|慕容|武当", menpai) then
			属性攻击="玄"
		end
	else
		return -1
	end
	return 属性攻击
end

if  晴天_取人物属性(1)=="冰" then
	残印 ="高门·冰残印|投巫·冰残印|誓江·冰残印|听镜残印|望洋残印"
end
if  晴天_取人物属性(1)=="火" then
	残印 ="高门·火残印|投巫·火残印|誓江·火残印|听镜残印|望洋残印"
end
if  晴天_取人物属性(1)=="玄" then
	残印 ="高门·玄残印|投巫·玄残印|誓江·玄残印|听镜残印|望洋残印"
end
if  晴天_取人物属性(1)=="毒" then
	残印 ="高门·毒残印|投巫·毒残印|誓江·毒残印|听镜残印|望洋残印"
end


function 晴天_领悟购买心决(name)
	for i =1, 8 do
		if 晴天_取无字谱心决信息(name,3) ==1 then  --存在就神级 没有就兑换1 
			local 阶级= 晴天_取无字谱心决信息(name,5)
			if tonumber(阶级)	>= 5 then
				屏幕提示("阶级5啦不升级啦")
				延时(2000)
				return
			end	
			晴天_友情提示("领悟购买心决%s",name)
			for kkk = 1,20 do
				晴天_心决强化(name)
                延时(500)
			end
			if 	晴天_取无字谱心决信息(name,4)	==10 then 
				local 阶级= 晴天_取无字谱心决信息(name,5)
				if 阶级>=5 then
					break
				end	
				晴天_友情提示("%s阶级%d",name,阶级)
				if 阶级 == 0 then
					需要总数 = 5
				elseif 阶级 == 1 then
					需要总数 = 6
				elseif 阶级 == 2 then
					需要总数 = 7
				elseif 阶级 == 3 then
					需要总数 = 8
				elseif 阶级 == 4 then	
					需要总数 = 9
				elseif 阶级 == 5 then	
					需要总数 = 10
				end
			local 目前数量 =晴天_取心决残印数量(name)
			延时(1000)
			if 目前数量>= 需要总数 then
				晴天_心决强化(name)
			else
				屏幕提示(需要总数-目前数量)
				晴天_归山阁购买(name.."残印",需要总数-目前数量)
				延时(2000)
				晴天_使用物品(name.."残印")
				end
			end
		else
			local 上海比购买最大 =math.floor(晴天_取上海比()/50)
			local 还需要数量=  晴天_取心决残印还需数量(name) 
			local 还需要数量 =math.min(上海比购买最大,还需要数量)
			if 还需要数量>0 then 
				延时(5000)
				晴天_归山阁购买(name.."残印",还需要数量)
				晴天_使用物品(name.."残印")
				延时(2500)
			else 
				break
			end
		end
	end	
end

---------------------------------------------------------------------------------小2021年10月17日

执行功能("无字谱任务")
晴天_打开无字谱窗口(1)
晴天_领悟心决()
if tonumber(获取人物信息(26))<90 then
if  晴天_取人物属性(1)=="冰" then
晴天_装备无字谱心决("望洋",1)
延时(2000)
晴天_装备无字谱心决("高门·冰",2)
延时(2000)

晴天_领悟购买心决("望洋")
延时(2000)
晴天_领悟购买心决("高门·冰")
延时(2000)

for i=1,3 do
晴天_领悟心决()
延时(2000)
晴天_装备无字谱心决("望洋",1)
延时(2000)
晴天_装备无字谱心决("高门·冰",2)
延时(2000)
晴天_装备无字谱心决("伤魂",3)
延时(2000)
晴天_装备无字谱心决("枕戈",4)
延时(2000)
end
end


if  晴天_取人物属性(1)=="火" then
晴天_装备无字谱心决("望洋",1)
延时(2000)
晴天_装备无字谱心决("高门·火",2)
延时(2000)

晴天_领悟购买心决("望洋")
延时(2000)
晴天_领悟购买心决("高门·火")
延时(2000)

for i=1,3 do
晴天_领悟心决()
延时(2000)
晴天_装备无字谱心决("望洋",1)
延时(2000)
晴天_装备无字谱心决("高门·火",2)
延时(2000)
晴天_装备无字谱心决("伤魂",3)
延时(2000)
晴天_装备无字谱心决("枕戈",4)
延时(2000)
end
end


if  晴天_取人物属性(1)=="玄" then
晴天_装备无字谱心决("望洋",1)
延时(2000)
晴天_装备无字谱心决("高门·玄",2)
延时(2000)

晴天_领悟购买心决("望洋")
延时(2000)
晴天_领悟购买心决("高门·玄")
延时(2000)

for i=1,3 do
晴天_领悟心决()
延时(2000)
晴天_装备无字谱心决("望洋",1)
延时(2000)
晴天_装备无字谱心决("高门·玄",2)
延时(2000)
晴天_装备无字谱心决("伤魂",3)
延时(2000)
晴天_装备无字谱心决("枕戈",4)
延时(2000)
end
end


if  晴天_取人物属性(1)=="毒" then
晴天_装备无字谱心决("望洋",1)
延时(2000)
晴天_装备无字谱心决("高门·毒",2)
延时(2000)

晴天_领悟购买心决("望洋")
延时(2000)
晴天_领悟购买心决("高门·毒")
延时(2000)

for i=1,3 do
晴天_领悟心决()
延时(2000)
晴天_装备无字谱心决("望洋",1)
延时(2000)
晴天_装备无字谱心决("高门·毒",2)
延时(2000)
晴天_装备无字谱心决("伤魂",3)
延时(2000)
晴天_装备无字谱心决("枕戈",4)
延时(2000)
end
end
end
---------------------------------------------------------------------------------大

if tonumber(获取人物信息(26))>=90 then

if  晴天_取人物属性(1)=="冰" then
晴天_装备无字谱心决("高门·冰",1)
延时(2000)
if tonumber(获取人物信息(26))>=100 then
晴天_装备无字谱心决("听镜",2)
延时(2000)
elseif tonumber(获取人物信息(26))<100 then
晴天_装备无字谱心决("望洋",2)
延时(2000)
end
晴天_装备无字谱心决("投巫·冰",3)
延时(2000)
晴天_装备无字谱心决("誓江·冰",4)
延时(2000)


晴天_领悟购买心决("高门·冰")
延时(2000)
if tonumber(获取人物信息(26))>=100 then
晴天_领悟购买心决("听镜")
延时(2000)
elseif tonumber(获取人物信息(26))<100 then
晴天_领悟购买心决("望洋")
延时(2000)
end
晴天_领悟购买心决("投巫·冰")
延时(2000)
晴天_领悟购买心决("誓江·冰")
延时(2000)



for i=1,2 do
晴天_领悟心决()
延时(2000)
晴天_装备无字谱心决("高门·冰",1)
延时(2000)
if tonumber(获取人物信息(26))>=100 then
晴天_装备无字谱心决("听镜",2)
延时(2000)
elseif tonumber(获取人物信息(26))<100 then
晴天_装备无字谱心决("望洋",2)
延时(2000)
end
晴天_装备无字谱心决("投巫·冰",3)
延时(2000)
晴天_装备无字谱心决("誓江·冰",4)
延时(2000)
晴天_装备无字谱心决("伤魂",2)
延时(2000)
晴天_装备无字谱心决("枕戈",2)
延时(2000)
for i=1,10 do
晴天_心决强化("伤魂")
延时(1000)
晴天_心决强化("枕戈")
延时(1000)
end
end
end


if  晴天_取人物属性(1)=="火" then
晴天_装备无字谱心决("高门·火",1)
延时(2000)
if tonumber(获取人物信息(26))>=100 then
晴天_装备无字谱心决("听镜",2)
延时(2000)
elseif tonumber(获取人物信息(26))<100 then
晴天_装备无字谱心决("望洋",2)
延时(2000)
end
晴天_装备无字谱心决("投巫·火",3)
延时(2000)
晴天_装备无字谱心决("誓江·火",4)
延时(2000)


晴天_领悟购买心决("高门·火")
延时(2000)
if tonumber(获取人物信息(26))>=100 then
晴天_领悟购买心决("听镜")
延时(2000)
elseif tonumber(获取人物信息(26))<100 then
晴天_领悟购买心决("望洋")
延时(2000)
end
晴天_领悟购买心决("投巫·火")
延时(2000)
晴天_领悟购买心决("誓江·火")
延时(2000)


for i=1,2 do
晴天_领悟心决()
延时(2000)
晴天_装备无字谱心决("高门·火",1)
延时(2000)
if tonumber(获取人物信息(26))>=100 then
晴天_装备无字谱心决("听镜",2)
延时(2000)
elseif tonumber(获取人物信息(26))<100 then
晴天_装备无字谱心决("望洋",2)
延时(2000)
end
晴天_装备无字谱心决("投巫·火",3)
延时(2000)
晴天_装备无字谱心决("誓江·火",4)
延时(2000)
晴天_装备无字谱心决("伤魂",2)
延时(2000)
晴天_装备无字谱心决("枕戈",2)
延时(2000)
for i=1,10 do
晴天_心决强化("伤魂")
延时(1000)
晴天_心决强化("枕戈")
延时(1000)
end
end
end



if  晴天_取人物属性(1)=="玄" then
晴天_装备无字谱心决("高门·玄",1)
延时(2000)
if tonumber(获取人物信息(26))>=100 then
晴天_装备无字谱心决("听镜",2)
延时(2000)
elseif tonumber(获取人物信息(26))<100 then
晴天_装备无字谱心决("望洋",2)
延时(2000)
end
晴天_装备无字谱心决("投巫·玄",3)
延时(2000)
晴天_装备无字谱心决("誓江·玄",4)
延时(2000)


晴天_领悟购买心决("高门·玄")
延时(2000)
if tonumber(获取人物信息(26))>=100 then
晴天_领悟购买心决("听镜")
延时(2000)
elseif tonumber(获取人物信息(26))<100 then
晴天_领悟购买心决("望洋")
延时(2000)
end
晴天_领悟购买心决("投巫·玄")
延时(2000)
晴天_领悟购买心决("誓江·玄")
延时(2000)


for i=1,2 do
晴天_领悟心决()
延时(2000)
晴天_装备无字谱心决("高门·玄",1)
延时(2000)
if tonumber(获取人物信息(26))>=100 then
晴天_装备无字谱心决("听镜",2)
延时(2000)
elseif tonumber(获取人物信息(26))<100 then
晴天_装备无字谱心决("望洋",2)
延时(2000)
end
晴天_装备无字谱心决("投巫·玄",3)
延时(2000)
晴天_装备无字谱心决("誓江·玄",4)
延时(2000)
晴天_装备无字谱心决("伤魂",2)
延时(2000)
晴天_装备无字谱心决("枕戈",2)
延时(2000)
for i=1,10 do
晴天_心决强化("伤魂")
延时(1000)
晴天_心决强化("枕戈")
延时(1000)
end
end
end


if  晴天_取人物属性(1)=="毒" then
晴天_装备无字谱心决("高门·毒",1)
延时(2000)
if tonumber(获取人物信息(26))>=100 then
晴天_装备无字谱心决("听镜",2)
延时(2000)
elseif tonumber(获取人物信息(26))<100 then
晴天_装备无字谱心决("望洋",2)
延时(2000)
end
晴天_装备无字谱心决("投巫·毒",3)
延时(2000)
晴天_装备无字谱心决("誓江·毒",4)
延时(2000)


晴天_领悟购买心决("高门·毒")
延时(2000)
if tonumber(获取人物信息(26))>=100 then
晴天_领悟购买心决("听镜")
延时(2000)
elseif tonumber(获取人物信息(26))<100 then
晴天_领悟购买心决("望洋")
延时(2000)
end
晴天_领悟购买心决("投巫·毒")
延时(2000)
晴天_领悟购买心决("誓江·毒")
延时(2000)


for i=1,2 do
晴天_领悟心决()
延时(2000)
晴天_装备无字谱心决("高门·毒",1)
延时(2000)
if tonumber(获取人物信息(26))>=100 then
晴天_装备无字谱心决("听镜",2)
延时(2000)
elseif tonumber(获取人物信息(26))<100 then
晴天_装备无字谱心决("望洋",2)
延时(2000)
end
晴天_装备无字谱心决("投巫·毒",3)
延时(2000)
晴天_装备无字谱心决("誓江·毒",4)
延时(2000)
晴天_装备无字谱心决("伤魂",2)
延时(2000)
晴天_装备无字谱心决("枕戈",2)
延时(2000)
for i=1,10 do
晴天_心决强化("伤魂")
延时(1000)
晴天_心决强化("枕戈")
延时(1000)
end
end
end
end
--晴天_无字谱使用()



