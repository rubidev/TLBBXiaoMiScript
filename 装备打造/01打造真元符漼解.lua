

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
				if if this:IsVisible() then
					local txt=Item_MultiUse_ItemInfo_Text:GetText()
					if string.find("%s",txt,1,true) then
						Item_MultiUse_BuyMulti_Clicked()
					end
				end
			]],物品列表))
		end
	end
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


function 晴天_真元漼解保留(颜色,保留物品列表)
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

---------------------------------------------------------------------------------------------


local 真元集合="|真元·紫血符|真元·紫冰符|真元·紫火符|真元·紫玄符|真元·紫毒符|真元·紫体符|真元·紫御符|真元·紫准符|真元·紫劲符|真元·紫灵符|真元·紫敏符|真元·紫韧符|真元·紫坚符|真元·紫力符|真元·紫暴符|真元·紫定符|真元·紫气符|真元·紫罡符|真元·紫闪符|紫色真元符集|无相秘钥|无相宝匣|"

local 背包身上东西漼解="#cFFFFFF真元·血涌丹田|#cFFFFFF真元·沉冰|#cFFFFFF真元·炽火|#cFFFFFF真元·印玄|#cFFFFFF真元·蛊毒|#cFFFFFF真元·厚体|#cFFFFFF真元·百炼铁骨|#cFFFFFF真元·百步穿杨|#cFFFFFF真元·内劲绵绵|#cFFFFFF真元·灵慧|#cFFFFFF真元·迅捷|#cFFFFFF真元·千转柔筋|#cFFFFFF真元·坚韧如岳|#cFFFFFF真元·勇力|#cFFFFFF真元·暴猛如焰|#cFFFFFF真元·气定|#cFFFFFF真元·气贯神庭|#cFFFFFF真元·外功罡猛|#cFFFFFF真元·滑不沾衣|#c00D000真元·血涌丹田|#c00D000真元·沉冰|#c00D000真元·炽火|#c00D000真元·印玄|#c00D000真元·蛊毒|#c00D000真元·厚体|#c00D000真元·百炼铁骨|#c00D000真元·百步穿杨|#c00D000真元·内劲绵绵|#c00D000真元·灵慧|#c00D000真元·迅捷|#c00D000真元·千转柔筋|#c00D000真元·坚韧如岳|#c00D000真元·勇力|#c00D000真元·暴猛如焰|#c00D000真元·气定|#c00D000真元·气贯神庭|#c00D000真元·外功罡猛|#c00D000真元·滑不沾衣|#c2980FF真元·血涌丹田|#c2980FF真元·沉冰|#c2980FF真元·炽火|#c2980FF真元·印玄|#c2980FF真元·蛊毒|#c2980FF真元·厚体|#c2980FF真元·百炼铁骨|#c2980FF真元·百步穿杨|#c2980FF真元·内劲绵绵|#c2980FF真元·灵慧|#c2980FF真元·迅捷|#c2980FF真元·千转柔筋|#c2980FF真元·坚韧如岳|#c2980FF真元·勇力|#c2980FF真元·暴猛如焰|#c2980FF真元·气定|#c2980FF真元·气贯神庭|#c2980FF真元·外功罡猛|#c2980FF真元·滑不沾衣|#ccc33cc真元·百炼铁骨|#ccc33cc真元·百步穿杨|#ccc33cc真元·内劲绵绵|#ccc33cc真元·灵慧|#ccc33cc真元·迅捷|#ccc33cc真元·千转柔筋|#ccc33cc真元·坚韧如岳|#ccc33cc真元·勇力|#ccc33cc真元·暴猛如焰|#ccc33cc真元·气定|#ccc33cc真元·气贯神庭|#ccc33cc真元·外功罡猛|#ccc33cc真元·滑不沾衣|"


local 保留真元="真元·"..属性真元.."|".."魂元·"..属性真元.."|".."魂元·血涌丹田|真元·血涌丹田|真元·厚体|魂元·厚体|"

--真元保留物品列表 =string.gsub(真元保留物品列表,"%[蓝色%]","#c2980FF")
--真元保留物品列表 =string.gsub(真元保留物品列表,"%[紫色%]","#ccc33cc")
--屏幕提示(真元保留物品列表)
--延时(30000)
--真元保留物品列表 =真元保留物品列表.."|"..string.gsub(真元保留物品列表,"真","魂")
--#ccc33cc 紫色
--#c00D000 绿色
--#c2980FF 蓝色 
--#cFFFFFF 白色
--前面的是颜色要加进去
--szName=string.gsub(szName, "#ccc33cc", "[紫色]")
------------------------------------------------------------------------------------------------------------------------------------------------------



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
---1是白色 2绿色 3绿色 4紫色 5橙色
--参数2 为空者 这个颜色 全部销毁
晴天_真元漼解保留(1)
晴天_真元漼解保留(2)
晴天_真元漼解保留(3,保留真元)
晴天_真元漼解保留(4,保留真元)
取出物品(真元集合)
晴天_使用物品(真元集合)

--晴天_真元漼解炉(4,真元保留物品列表)

--晴天_取出物品右键使用(真元集合)


--晴天_取出物品右键使用(真元集合)
--晴天_漼解炉(背包身上东西漼解,2)