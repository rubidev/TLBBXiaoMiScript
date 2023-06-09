function 晴天_取人物属性(index)
	local 属性=""
	local  人物名称,menpai,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()
	if  index == 1 then
		属性 =LUA_取返回值(string.format([[
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
	elseif  index == 2 then
		if string.find("唐门|星宿|丐帮", menpai) then
			属性="毒"
		elseif  string.find("逍遥|明教|", menpai) then
			属性="火"
		elseif  string.find("峨嵋|天山|", menpai) then
			属性="冰"
		elseif  string.find("天龙|少林|鬼谷|慕容|武当", menpai) then
			属性="玄"
		end
	elseif index == 3 then
		local  毒主属性名称 = "111|aaa|"
		local  火主属性名称 = "111|aaa|"
		local  冰主属性名称 = "111|aaa|"
		local  玄主属性名称 = "111|aaa|"
		if string.find(毒主属性名称, 人物名称) then
			属性="毒"
		elseif  string.find(火主属性名称, 人物名称) then
			属性="火"
		elseif  string.find(冰主属性名称, 人物名称) then
			属性="冰"
		elseif  string.find(玄主属性名称, 人物名称) then
			属性="玄"
		end
	end	
	return 属性
end



local maxAttack=晴天_取人物属性(1)
if maxAttack=="" then
	return 
end	
if maxAttack =="冰" then
	属性真元="沉冰"
elseif maxAttack =="火" then
	属性真元="炽火"
elseif maxAttack =="玄" then
	属性真元="印玄"
elseif maxAttack =="毒" then
	属性真元="蛊毒"				
end

local zhenyuan={
	{"真元·血涌丹田"},
	{"真元·"..属性真元},
	{"真元·"..属性真元},
	{"真元·厚体"},		
	{"真元·"..属性真元},
	{"真元·"..属性真元},
	{"真元·血涌丹田"},
	{"真元·厚体"},	
	{"真元·厚体"},	
	{"真元·厚体"},	
	{"真元·厚体"},	
	{"真元·厚体"},
}


function 晴天_取真元装备信息(序号,编号)
		local tem =LUA_取返回值(string.format([[	
		local i=%d-1
		local bianhao=%d
		local index=0
		local szName, nLevel, szAdd, nAdd, nNextAdd=Pneuma:GetPneumaAddingInfo(i)
		if szName~="" and szName~=nil then
			if string.find(szName,"#cFFFFFF",1,true) then 
				index =1 
				szName=string.gsub(szName, "#cFFFFFF", "")
			elseif string.find(szName,"#c00D000",1,true) then 
				index =2
				szName=string.gsub(szName, "#c00D000", "")
			elseif string.find(szName,"#c2980FF") then 
				index =3
				szName=string.gsub(szName, "#c2980FF", "")
			elseif string.find(szName,"#ccc33cc",1,true)  then 
				index =4
				szName=string.gsub(szName, "#ccc33cc", "")		
			elseif string.find(szName,"#cFF6600",1,true)  then 
				index =5
				szName=string.gsub(szName, "#cFF6600", "")		
			end
			if bianhao ==1 then
				return index
			elseif bianhao ==2 then
				return szName
			end
		end
		return -1
		]],序号,编号))
	return tem
end

function 晴天_比对真元()
	local str=""
	for i =1,# zhenyuan do
		for kk=1,5 do
			local 真元颜色等级 = tonumber(晴天_取真元装备信息(i,1))
			local 真元名字 = tostring(晴天_取真元装备信息(i,2))
			if 真元颜色等级<=kk then
				--屏幕提示("当前真元颜色等级"..真元颜色等级.."<="..kk)
				local 真元=zhenyuan[i][1] 
				local 魂元=string.gsub(真元, "真", "魂")
				local 合集 =真元.."|"..魂元
				if not string.find(合集,真元名字,1,true) then
					if not string.find(str,合集,1,true) then
						str=str.."|"..合集
					end	
				end	
			end
		end
	end	
	return 	str
end	



function 晴天_取真元装备信息2()
	for i=1,12 do
		local tem =LUA_取返回值(string.format([[	
		local i=%d-1
		local index=0
		local szName, nLevel, szAdd, nAdd, nNextAdd=Pneuma:GetPneumaAddingInfo(i)
		if szName~="" and szName~=nil then
			if string.find(szName,"#cFFFFFF",1,true) then 
				index =1 
				szName=string.gsub(szName, "#cFFFFFF", "")
			elseif string.find(szName,"#c00D000",1,true) then 
				index =2
				szName=string.gsub(szName, "#c00D000", "")
			elseif string.find(szName,"#c2980FF") then 
				index =3
				szName=string.gsub(szName, "#c2980FF", "")
			elseif string.find(szName,"#ccc33cc",1,true)  then 
				index =4
				szName=string.gsub(szName, "#ccc33cc", "")		
			elseif string.find(szName,"#cFF6600",1,true)  then 
				index =5
				szName=string.gsub(szName, "#cFF6600", "")		
			end
			PushDebugMessage("位置:".."颜色"..index.."|序号"..i..szName)
			return 1
		end
		return -1
		]],i))
		if tonumber(tem) ==  1 then
			延时(3000)
		end
	end	
end

function 晴天_使用物品(物品列表,是否绑定)
	if 是否绑定 ==0 or 是否绑定 == nil then
		tbangding =10
	elseif  是否绑定 ==1 then
		tbangding = 0
	elseif  是否绑定 ==2 then
		tbangding = 1
	end
	for i=0,199 do
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
			延时(1000)
		end
	end
end




function 快捷真元()
	跨图寻路("苏州",350,228)
	LUA_Call(string.format([[ 
	local nChip =Pneuma:GetPneumaExp()
		Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name("QuickOnceNingYuanClk");
			Set_XSCRIPT_ScriptID(889902);
			Set_XSCRIPT_Parameter(0, 1);--1234
			Set_XSCRIPT_ParamCount(1);
		Send_XSCRIPT();
	]]))
end

function  晴天_取元晶数量()
	local tem = LUA_取返回值(string.format([[ 
			return Pneuma:GetPneumaExp()
	]], aaa))
	return  tonumber(tem)
end

function  晴天_取真元精粹数量()
	local tem = LUA_取返回值(string.format([[ 
		return Pneuma:GetPneumaChip()
	]], aaa))
	return  tonumber(tem)
end

function 晴天_真元凝聚()
	LUA_Call(string.format([[ 
		Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name("ApplyNiangLian");
			Set_XSCRIPT_ScriptID(889902);
			Set_XSCRIPT_Parameter(0, -1);
			Set_XSCRIPT_ParamCount(1);
		Send_XSCRIPT();
		]]))
end

function  晴天_取凝元背包剩余数量()
	local tem = LUA_取返回值(string.format([[ 
		local nSpace=Pneuma:GetSmeltBag_SpaceCount()	
		return nSpace
	]], aaa))
	return  tonumber(tem)
end

---1 颜色 保留
function 晴天_真元凝元保留(index)
	local tem = LUA_取返回值(string.format([[ 
		Pneuma:SmeltAllItem_WithCuijie(%d)	
	]], index))
end
	



	

function 晴天_真元升级(index)
	跨图寻路("苏州",350,228)
      LUA_Call(string.format([[ 
	BBB=tonumber(%d)
	PushDebugMessage("晴天全自动升级真元等级:"..BBB)
		for i=0,11 do
		local nChip =Pneuma:GetPneumaExp()
		--PushDebugMessage(nChip)
		local theAction,bLocked = Pneuma:EnumPneumaItem("pneuma", i)
		local AAid= theAction:GetID() 
		local needExp = Pneuma:GetPneumaProperty(i,6)--需要元晶
		--PushDebugMessage(needExp)
		local curLevel = Pneuma:GetPneumaItemProperty(0,6)
		local szName, nLevel, szAdd, nAdd,nNextAdd=Pneuma:GetPneumaAddingInfo(i)
		--PushDebugMessage(curLevel )
		if AAid >0 then 
			 if  nChip >needExp  then
				if BBB>nLevel   then
		Clear_XSCRIPT();
		Set_XSCRIPT_Function_Name("OnUpgradeClicked");
		Set_XSCRIPT_ScriptID(889900);
		Set_XSCRIPT_Parameter(0,i);--序号
		Set_XSCRIPT_ParamCount(1);
		Send_XSCRIPT();
		end
		end
		end
		end
	]], index))
end


function 晴天_凝元淬解(颜色,保留物品列表)
	if not 颜色 then
		颜色 = 1
	end	
	if not 保留物品列表 then
		保留物品列表 =""
	end	
	for i=0,23 do
		local tem =LUA_取返回值(string.format([[	
		local i=72+%d
		local yanse =%d
		blwp ="%s"	
		local szName, nLevel, szAdd, nAdd, nNextAdd=Pneuma:GetPneumaAddingInfo(i)
		if szName~="" and szName~=nil then
			if string.find(szName,"#cFFFFFF",1,true) then 
				index =1 
				szName=string.gsub(szName, "#cFFFFFF", "")
			elseif string.find(szName,"#c00D000",1,true) then 
				index =2
				szName=string.gsub(szName, "#c00D000", "")
			elseif string.find(szName,"#c2980FF") then 
				index =3
				szName=string.gsub(szName, "#c2980FF", "")
			elseif string.find(szName,"#ccc33cc",1,true)  then 
				index =4
				szName=string.gsub(szName, "#ccc33cc", "")		
			elseif string.find(szName,"#cFF6600",1,true)  then 
				index =5
				szName=string.gsub(szName, "#cFF6600", "")		
			end
			--PushDebugMessage(szName)
			if  index== yanse then  
				if blwp=="" then
					return 1
				end
				if  not string.find(blwp,szName,1,true) then
					PushDebugMessage("淬解"..szName..i)
					return 1
				else
					PushDebugMessage("不处理:"..szName..i)
					return 2
				end
			end
		end
		return -1
		]],i ,颜色,保留物品列表))
		if tonumber(tem) == 1 then
			LUA_取返回值(string.format([[	
				Pneuma:SmeltPneumaItem(72+%d)
				]],i))			
				--延时(200)
		elseif tonumber(tem) == 2 then
			
		end
	end
end


function 晴天_真元放入背包(颜色,保留物品列表)
	if not 颜色 then
		颜色 = 1
	end	
	if not 保留物品列表 then
		保留物品列表 =""
	end	
	for i=0,23 do
		local tem =LUA_取返回值(string.format([[	
		local i=72+%d
		local yanse =%d
		blwp ="%s"	
		local szName, nLevel, szAdd, nAdd, nNextAdd=Pneuma:GetPneumaAddingInfo(i)
		if szName~="" and szName~=nil then
			if string.find(szName,"#cFFFFFF",1,true) then 
				index =1 
				szName=string.gsub(szName, "#cFFFFFF", "")
			elseif string.find(szName,"#c00D000",1,true) then 
				index =2
				szName=string.gsub(szName, "#c00D000", "")
			elseif string.find(szName,"#c2980FF") then 
				index =3
				szName=string.gsub(szName, "#c2980FF", "")
			elseif string.find(szName,"#ccc33cc",1,true)  then 
				index =4
				szName=string.gsub(szName, "#ccc33cc", "")		
			elseif string.find(szName,"#cFF6600",1,true)  then 
				index =5
				szName=string.gsub(szName, "#cFF6600", "")		
			end
			--PushDebugMessage(szName)
			if  index== yanse then  
				if blwp=="" then
					return 1
				end
				if  string.find(blwp,szName,1,true) then
					PushDebugMessage("放入背包"..szName..i)
					return 1
				else
					PushDebugMessage("不处理:"..szName..i)
					return 2
				end
			end
		end
		return -1
		]],i ,颜色,保留物品列表))
		if tonumber(tem) == 1 then
			LUA_取返回值(string.format([[	
				Pneuma:PickPneumaUpToBag(%d)
				]],i))			
				延时(1000)
		elseif tonumber(tem) == 2 then
				--LUA_取返回值(string.format([[	
				--Pneuma:SmeltPneumaItem(72+%d)
				--]],i))			
				--延时(1000)
		end
	end
end




function 晴天_真元智能凝聚(aa)
	跨图寻路("苏州",350,228)
	for i =1,99999 do
		local 真元精粹数量= 晴天_取真元精粹数量()
		if 真元精粹数量 <20 then
			屏幕提示("真元精粹数量不足")
			延时()
			break
		end
		晴天_真元凝聚()
		if 晴天_取凝元背包剩余数量() <1 then
			晴天_真元放入背包(3,aa)
			晴天_真元放入背包(4)
			晴天_真元放入背包(5)
			晴天_凝元淬解(1)
			晴天_凝元淬解(2)
			晴天_凝元淬解(3,aa)
		end
	end
	晴天_真元放入背包(3,aa)
	晴天_真元放入背包(4)
	晴天_真元放入背包(5)
	晴天_凝元淬解(1)
	晴天_凝元淬解(2)
	晴天_凝元淬解(3,aa)
end








function 晴天_漼解真元(物品列表)
	for i=36,59 do
		local tem =LUA_取返回值(string.format([[	
		 i=%d
		wupin = "%s"
		local szName, nLevel, szAdd, nAdd, nNextAdd=Pneuma:GetPneumaAddingInfo(i)
		if szName~="" and szName~=nil then
			szName=string.gsub(szName, "#cFFFFFF", "[白色]")
			szName=string.gsub(szName, "#c00D000", "[绿色]")
			szName=string.gsub(szName, "#c2980FF", "[蓝色]")
			szName=string.gsub(szName, "#ccc33cc", "[紫色]")
			szName=string.gsub(szName, "#cFF6600", "[橙色]")
			PushDebugMessage(szName)
			if string.find("|"..wupin.."|","|"..szName.."|",1,true) then
				PushDebugMessage("漼解"..szName.."|序号:"..i)
				return 1
			end
		end
		return -1
		]],i ,物品列表))
		if tonumber(tem) == 1 then
			LUA_取返回值(string.format([[	
				Pneuma:SmeltPneumaItem(%d)
			]],i))			
			延时(1000)	
		end
	end
end





function 晴天_真元漼解炉(颜色,保留物品列表)
	if not 颜色 then
		颜色 = 1
	end	
	if not 保留物品列表 then
		保留物品列表 =""
	end	
	for i=36,59 do
		local tem =LUA_取返回值(string.format([[	
		local i=%d
		local yanse =%d
		blwp ="%s"	
		local szName, nLevel, szAdd, nAdd, nNextAdd=Pneuma:GetPneumaAddingInfo(i)
		if szName~="" and szName~=nil then
			if string.find(szName,"#cFFFFFF",1,true) then 
				index =1 
				szName=string.gsub(szName, "#cFFFFFF", "")
			elseif string.find(szName,"#c00D000",1,true) then 
				index =2
				szName=string.gsub(szName, "#c00D000", "")
			elseif string.find(szName,"#c2980FF") then 
				index =3
				szName=string.gsub(szName, "#c2980FF", "")
			elseif string.find(szName,"#ccc33cc",1,true)  then 
				index =4
				szName=string.gsub(szName, "#ccc33cc", "")		
			elseif string.find(szName,"#cFF6600",1,true)  then 
				index =5
				szName=string.gsub(szName, "#cFF6600", "")		
			end
			--PushDebugMessage(szName)

				
			
			if  index== yanse then  
				if blwp=="" then
					return 1
				end
				if  not string.find(blwp,szName,1,true) then
					PushDebugMessage("漼解"..szName)
					return 1
				else
					PushDebugMessage("不处理:"..szName)
					return 2
				end
			end
		end
		return -1
		]],i ,颜色,保留物品列表))
		if tonumber(tem) == 1 then
			LUA_取返回值(string.format([[	
				Pneuma:SmeltPneumaItem(%d)
				]],i))			
				延时(1000)
		elseif tonumber(tem) == 2 then
			延时(1000)		
		end
	end
end


--------------------------------------------------------------------------------------

屏幕提示("智能真元开始")

local 保留真元=晴天_比对真元()
local 真元集合="|真元·紫血符|真元·紫冰符|真元·紫火符|真元·紫玄符|真元·紫毒符|真元·紫体符|真元·紫御符|真元·紫准符|真元·紫劲符|真元·紫灵符|真元·紫敏符|真元·紫韧符|真元·紫坚符|真元·紫力符|真元·紫暴符|真元·紫定符|真元·紫气符|真元·紫罡符|真元·紫闪符|紫色真元符集|无相秘钥|无相宝匣|"

function 需要保留蓝色以上()
	for k= 1, 3 do
		晴天_真元漼解炉(1)
		晴天_真元漼解炉(2)
		晴天_真元漼解炉(3,保留真元)
		--晴天_真元漼解炉(4,保留真元)
		取出物品(真元集合)
		晴天_使用物品(真元集合)
	end

	晴天_真元智能凝聚(保留真元)
	晴天_凝元淬解(1)
	晴天_凝元淬解(2)
	晴天_凝元淬解(3,保留真元)

	晴天_真元智能凝聚()
	晴天_真元放入背包(3,保留真元)
	晴天_真元放入背包(4)
	晴天_真元放入背包(5)


	晴天_真元升级(3)
	晴天_真元升级(4)
	晴天_真元升级(5)
	晴天_真元升级(6)
end



 需要保留蓝色以上()