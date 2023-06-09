
--精通淬洗升级一条龙 2021年12月28日 qq 103900393 编辑

local 取属性设置为 =1

local 开启指定名字洗=1
local 洗的装备列表 =""



洗的装备列表="|川暮|碧楼|惊心|金翅翎羽|琉璃焰|凶陌圣盔|幻世魔衣|步月|蝶恋|幻世圣巾|幻世圣靴|幻世魔腕|幻世魔肩|幻世手套|噬麟圣裘|沐水天衣|沐水天肩|沐水天靴|沐水天腕|沐水手套|沐水天靴|催雪|步月|妖言|霜晓|醉舞|川暮|凶陌圣甲|蝶恋|横笛|霸王令|冰魄神针|玄魄天裘|轻寒|佛语|横笛|浅浪|川暮|醉舞|轻寒|飞雪|"

-----------------------------------------------------------------------------------------------------------------------------------------------
function 晴天_友情提示(text,...)
	local strCode = string.format(text,...)
	LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【晴天QQ103900393提示】".."#eFF0000".."%-88s"
		DebugListBox_ListBox:AddInfo(str)
		--橙色 #e0000ff#u#g0ceff3
		--蓝色 #e0000ff#g28f1ff
		--#Y
	]], strCode))
end

function 晴天_写角色配置项(AAA, BBB, CCC)
    local 名字= 获取人物信息(12)
    local 路径=string.format("C:\\天龙小蜜\\角色配置\\%s.ini",名字)
	if AAA~=nil and BBB~=nil and CCC~=nil  then
		晴天_友情提示("写角色配置项|"..AAA.."|"..BBB.."|"..CCC);延时(200)
		写配置项(路径,AAA,BBB,CCC);延时(200)
	end
end

function 晴天_读角色配置项(AAA, BBB)
    local 名字= 获取人物信息(12)
    local 路径=string.format("C:\\天龙小蜜\\角色配置\\%s.ini",名字)
    local tem =读配置项(路径,AAA,BBB)
	if tem ~=nil then
		晴天_友情提示(AAA.."|"..BBB.."=="..tem);延时(500)
		else
		return 0
	end
	return tem
end

function  晴天_取身上全部钱()
		local tem = LUA_取返回值(string.format([[ 
			local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
			return selfMoney
			]]))
		return  tonumber(tem)
end	
	
function  晴天_取身上装备持久(aaa)
	local tem = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetEquipDur()
	]], aaa))
		return  tonumber(tem)
end

function  晴天_取身上装备ID(aaa)
	local tem = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetID()
	]], aaa))
	return  tonumber(tem)
end

function 晴天_取身上装备名字(aaa)
	return  LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetName()
	]], aaa))
end






function  晴天_取背包装备等级(index)
local aaa=  LUA_取返回值(string.format([[ 
		return LifeAbility : Get_Equip_Level(%d);
	]], index))
	return tonumber(aaa)
end

function  晴天_取身上武魂生命()--300最大
       if  tonumber(晴天_取身上装备ID(18) )>0 then
			return  到数值(LUA_取返回值(string.format([[ 
		return DataPool:GetKfsData("LIFE")
	]])))
	else
		return -1
    end
end


function 晴天_取背包精通条数(index,属性)
		local tem =LUA_取返回值(string.format([[
			local theAction = EnumAction(%d, "packageitem")
			local tiaoshu=0
			for i= 0,2 do
				local pName, pLevel, pBValue, pPercent, pRValue = theAction:GetEquipAttaProperty(i);
				if string.find(pName, "%s")  then
					tiaoshu=tiaoshu+1	
				end
			end
			return tiaoshu
	]], index,属性), "n")
	return tonumber(tem)
end

--------------------------------------------------------------
function  晴天_取身上武魂生命()--300最大
       if  到数值( 晴天_取身上装备ID(18) )>0 then
			return  到数值(LUA_取返回值(string.format([[ 
		return DataPool:GetKfsData("LIFE")
	]])))
	else
	return -1
    end
end

function 晴天_窗口确定()     --晴天点击确认
	for i=1,3 do
		if  窗口是否出现("MessageBox_Self")==1 then
			LUA_Call(" setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();")
			延时(2000)
		end
	end
end

function 晴天_判断关闭窗口(strWindowName)
	for i=1,3 do
		if 窗口是否出现(strWindowName)==1 then
			LUA_Call(string.format([[
				setmetatable(_G, {__index = %s_Env}) this:Hide()  
			]], strWindowName))  
			延时(1500)
		  end
	end
end

--------------------------------------------------装备相关------------------------------------------------
local SelfEuipList =
{
	[1]  = { name="武器", downIndex=11,  equipIndex=0, equipName="" },    --- 武器
	[2]  = { name="护腕", downIndex=3, equipIndex=14, equipName=""},    --- 护腕
	[3]  = { name="戒指上", downIndex=7,  equipIndex=6,equipName=""  },    --- 戒指（上）
	[4]  = { name="戒指下", downIndex=8,  equipIndex=11, equipName=""},    --- 戒指（下）
	[5]  = { name="护符上", downIndex=9,  equipIndex=12, equipName=""},    --- 护符（上）
	[6]  = { name="护符下", downIndex=10, equipIndex=13, equipName=""},    --- 护符（下）
	[7]  = { name="衣服", downIndex=12,  equipIndex=2,equipName=""  },    --- 衣服
	[8]  = { name="帽子", downIndex=1,  equipIndex=1, equipName="" },    --- 帽子
	[9]  = { name="护肩", downIndex=2, equipIndex=15,equipName="" },    --- 肩膀
	[10] = { name="手套", downIndex=4,  equipIndex=3, equipName="" },    --- 手套
	[11] = { name="腰带", downIndex=5,  equipIndex=5, equipName="" },    --- 腰带
	[12] = { name="鞋子", downIndex=6,  equipIndex=4, equipName="" },    --- 鞋子
	[13] = { name="项链", downIndex=13,  equipIndex=7,equipName=""  },    --- 项链
	[14] = { name="暗器", downIndex=14, equipIndex=17, equipName=""},    --- 暗器
	[15] = { name="龙纹", downIndex=25, equipIndex=19,equipName="" },    --- 龙纹
	[16] = { name="武魂", downIndex="", equipIndex=18,equipName="" },    --- 武魂
	[17] = { name="令牌", downIndex=16, equipIndex=20,equipName="" },    --- 令牌
}

function 晴天_取下装备获取名字(装备位置名称)
	for i =1,#SelfEuipList do
		if SelfEuipList[i].name == 装备位置名称 then
			晴天_友情提示("准备取下装备位置:"..装备位置名称)
				local 装备持久 =晴天_取身上装备持久(SelfEuipList[i].equipIndex)
				if 装备持久 <= 0 then
					晴天_友情提示("装备持久不够,不取下")
					return 0
				end
				if 晴天_取身上装备ID(SelfEuipList[i].equipIndex) <= 0  then
					return 0
				end
				
				for k =1, 5 do	
					if  窗口是否出现("SelfEquip")==1  then
						local  装备名称 = 晴天_取身上装备名字(SelfEuipList[i].equipIndex)
						LUA_Call(string.format([[ setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Equip_Click(%d,0)]], SelfEuipList[i].downIndex))
						延时(2000)
						if  晴天_取身上装备ID(SelfEuipList[i].equipIndex) == 0 then
							晴天_判断关闭窗口("SelfEquip")
							return 装备名称
						end	
					else	
						LUA_Call ("MainMenuBar_SelfEquip_Clicked();");延时(2000)
					end
				end	
				return 0
		end
	end
	屏幕提示("提示错误 取下装备 数组错误")
	延时(2000)
end

function 晴天_取身上装备名字(aaa)
	local tem = LUA_取返回值(string.format([[ 
		local index =%d
		local theaction = EnumAction(index,"equip")
		if theaction then
			local  ID =theaction:GetID(); 
			if tonumber( ID) > 0 then
				local Name = EnumAction(index,"equip"):GetName()
				return  Name
			end	
		end
		return -1
	]], aaa))
	return tostring(tem)
end

function 晴天_取身上装备位置名字(装备位置名称)
	for i =1,#SelfEuipList do
		if SelfEuipList[i].name == 装备位置名称 then
			local  装备名称 = 晴天_取身上装备名字(SelfEuipList[i].equipIndex)
			return 装备名称
		end	
	end
end


function 晴天_取身上精通条数(aaa,shuxing)
	local tem=  LUA_取返回值(string.format([[ 
		local index = 0 
		local xuhao=%d
		local JdSX="%s"
		local AttrLevel1,AttrName1,AttrLevel2,AttrName2,AttrLevel3,AttrName3 = DataPool:GetJingTongAttrInfo(xuhao) 
		if string.find(AttrName1,JdSX) then 
			index=index+1
		end
		if string.find(AttrName2,JdSX) then 
			index=index+1
		end	
		if string.find(AttrName3,JdSX) then 
			index=index+1
		end
		return index
		--PushDebugMessage(AttrLevel1..AttrName1..AttrLevel2..AttrName2..AttrLevel3..AttrName3)
	]], aaa,shuxing))
	return tonumber(tem)
end

function 晴天_取身上精通最小等级(aaa,shuxing)
	local tem=  LUA_取返回值(string.format([[ 
		local index = 0 
		local xuhao=%d
		local JdSX="%s"
		local AttrLevel1,AttrName1,AttrLevel2,AttrName2,AttrLevel3,AttrName3 = DataPool:GetJingTongAttrInfo(xuhao) 
		if string.find(AttrName1,JdSX) then 
			if index== 0 then
				index=AttrLevel1
			else
				if AttrLevel1 <index then
					index=AttrLevel1
				end
 			end
		end
		if string.find(AttrName2,JdSX) then 
			if index== 0 then
				index=AttrLevel2
			else
				if AttrLevel2 <index then
					index=AttrLevel2
				end
 			end
		end	
		if string.find(AttrName3,JdSX) then 
			if index== 0 then
				index=AttrLevel3
			else
				if AttrLevel3 <index then
					index=AttrLevel3
				end
 			end
		end
		return index
		--PushDebugMessage(AttrLevel1..AttrName1..AttrLevel2..AttrName2..AttrLevel3..AttrName3)
	]], aaa,shuxing))
	return tonumber(tem)
end

function 晴天_取身上装备位置精通条数(装备位置名称,shuxing)
	local tem = 0
	for i =1,#SelfEuipList do
		if SelfEuipList[i].name == 装备位置名称 then
			tem=晴天_取身上精通条数(SelfEuipList[i].equipIndex,shuxing)
		end	
	end
	return tonumber(tem)
end	

function 晴天_取身上装备位置精通最小等级(装备位置名称,shuxing)
	local tem = 0
	for i =1,#SelfEuipList do
		if SelfEuipList[i].name == 装备位置名称 then
			tem=晴天_取身上精通最小等级(SelfEuipList[i].equipIndex,shuxing)
		end	
	end
	return tonumber(tem)
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
							PushDebugMessage("晴天智能右击物品:"..GetName.."|背包位置:"..i)
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


function 晴天_穿上装备(装备位置名称,装备名称)
     if 装备名称==""  then
		晴天_友情提示("参数错误,晴天_穿上装备")
		晴天_友情提示("参数错误,晴天_穿上装备")
		晴天_友情提示("参数错误,晴天_穿上装备")
		延时(2000)
		return
	end
	
	for i =1,#SelfEuipList do
		if SelfEuipList[i].name == 装备位置名称 then
			for k =1, 5 do
				if  窗口是否出现("SelfEquip")==1  then
					晴天_使用物品(装备名称);延时(2000)
					if  晴天_取身上装备ID(SelfEuipList[i].equipIndex) > 0  then
						晴天_友情提示("晴天成功穿上"..装备名称.."|在位置:"..装备位置名称)
						晴天_判断关闭窗口("SelfEquip")
						break   
					end
				else	
					LUA_Call ("MainMenuBar_SelfEquip_Clicked();");延时(2000)
				end
			end
		end
	end
end

-------------------------------------------------------------------------------------


function 晴天_装备淬炼(装备位置名称,属性,数量)
	local JT_SHUXING=""
    if 属性=="体力" then
		JT_SHUXING="con"
	elseif 属性=="火" then
		JT_SHUXING="attack_fire"
	elseif 属性=="玄" then
		JT_SHUXING="attack_light"
	elseif 属性=="冰" then
		JT_SHUXING="attack_cold"
	elseif 属性=="毒" then
		JT_SHUXING="attack_poison"  
	end
	if 	JT_SHUXING=="" then
		晴天_友情提示("精通淬火,请设置好参数")
		延时(1000)
		return		  
	end
	晴天_友情提示("精通淬火,"..装备位置名称..属性..数量)

	if 开启指定名字洗==1 then
		if not string.find(洗的装备列表,晴天_取身上装备位置名字(装备位置名称)) then
			屏幕提示("没有在列表洗")
			延时(200)
			return
		end	
	end
	
	local 精通条数 =晴天_取身上装备位置精通条数(装备位置名称,JT_SHUXING)
	屏幕提示("你当前的位置:"..装备位置名称.."属性条数:"..精通条数)
	if 精通条数 >= 数量 then
		屏幕提示(数量.."大于跳出")
		延时(200)
		return
	end
	
	local 精通条数=tonumber( 晴天_读角色配置项("精通淬火", 装备位置名称.."精通条数"))
	if 精通条数 >= 数量 then
		return 
	end
	
	--取出物品("离火")
	if 获取背包物品数量("离火")< 15 then
	    晴天_友情提示("离火不够15个 放弃精通淬火")
		return
	end	
	
	if 到数值(获取人物信息(45)+获取人物信息(52)) <3*10000 then
		晴天_友情提示("精通淬火,金币不够")
		return
	end

	跨图寻路("苏州",364,245)

	local 装备名称= 晴天_取下装备获取名字(装备位置名称);延时(2000) 
	晴天_友情提示(装备名称);延时(2000) 
	if 装备名称 == 0 then
        return -1
	else
		LPindex=获取背包物品位置(装备名称)-1	
	end
	
	        for iii=1,999 do
		local tem =LUA_取返回值(string.format([[
	    local index = tonumber(%d)
		
		local equip_level = LifeAbility : Get_Equip_Level(index);
		if equip_level <80 then
				PushDebugMessage("装备等级不够不能淬炼")
					return 2
		end
		
		
		
		local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
		if selfMoney<50000 then
					PushDebugMessage("离火金币不够")
					return 2
		end
		
		
		  --local curTime = OSAPI:GetTickCount()
		  --PushDebugMessage(curTime)

               local theAction = EnumAction(index, "packageitem")
			
			   JT_ABC=tostring("%s") 
			local pName, pLevel, pBValue, pPercent, pRValue = theAction:GetEquipAttaProperty(0);
						 if	string.find(pName, JT_ABC)  then	
								JT_AAA=1
								else
								JT_AAA=0
						end
			local pName, pLevel, pBValue, pPercent, pRValue = theAction:GetEquipAttaProperty(1);		
			 if	string.find(pName, JT_ABC)  then
								JT_BBB=1
				else
								JT_BBB=0
				end
				
			local pName, pLevel, pBValue, pPercent, pRValue = theAction:GetEquipAttaProperty(2);		
			 if	string.find(pName,JT_ABC )  then
								JT_CCC=1
				else
								JT_CCC=0
			end	
			local JT_shuliang=JT_AAA+JT_BBB+JT_CCC
           if  JT_shuliang>=1 then
		   local itemneed=PlayerPackage:CountAvailableItemByIDTable(20700063) 
		    if itemneed < 15 then
				PushDebugMessage("离火不够")
			 return 2
			end
		   end
		
			PushDebugMessage("精通属性序号:"..JT_AAA..JT_BBB..JT_CCC)
				    if JT_AAA+JT_BBB+JT_CCC>=%d then
						PushDebugMessage("精通属性足够数量,不再淬火")
						return 2
					end
					
			Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name("EquipCuiLian");
				Set_XSCRIPT_ScriptID(890088);
				Set_XSCRIPT_Parameter(0,index);
				Set_XSCRIPT_Parameter(1,JT_AAA)
				Set_XSCRIPT_Parameter(2,JT_BBB)
				Set_XSCRIPT_Parameter(3,JT_CCC)
				Set_XSCRIPT_ParamCount(4);
			Send_XSCRIPT();	
		]], LPindex,JT_SHUXING,数量), "d")
		延时(500)
		 if tonumber(tem)==2 then
			break
		 end
		end
		延时(500)
		精通条数 = 晴天_取背包精通条数(LPindex,JT_SHUXING)
		延时(500)
		晴天_写角色配置项("精通淬火", 装备位置名称.."精通条数",精通条数) 
		晴天_穿上装备(装备位置名称,装备名称)
end



function 晴天_精通升级(装备位置名称,属性,等级)

	if tonumber(等级) >= 30 and  tonumber(等级) < 40  then
		需要材料数量=14
	elseif tonumber(等级) >= 20 and  tonumber(等级) < 30  then
		需要材料数量=12
	elseif tonumber(等级) >=1 and  tonumber(等级) < 10  then
		需要材料数量=1		
	elseif tonumber(等级) >=10 and  tonumber(等级) < 20  then
		需要材料数量=6
	elseif tonumber(等级) >=40 and  tonumber(等级) < 50  then
		需要材料数量=16
	elseif tonumber(等级) >=50 and  tonumber(等级) < 60  then
		需要材料数量=18
	elseif tonumber(等级) >=60 and  tonumber(等级) < 70  then
		需要材料数量=20
	elseif tonumber(等级) >=70 and  tonumber(等级) < 80  then
		需要材料数量=22
	elseif tonumber(等级) >=80 and  tonumber(等级) < 90  then
		需要材料数量=24
	elseif tonumber(等级) >=90 and  tonumber(等级) < 100  then
		需要材料数量=25
	else
		 需要材料数量=20
	end


	if 获取背包物品数量("精金石")< 需要材料数量 then
	    屏幕提示(装备位置名称.."|装备提升精通目标等级:"..等级.."|精金石不够"..需要材料数量.."|跳过升级")
		return
	end	
	
	if 到数值(获取人物信息(45)+获取人物信息(52)) <5*10000 then
			    屏幕提示("精通属性升级,金币不够")
		return
	end	
	
--金币判断

    if 属性=="体力" then
		JT_SHUXING="con"
	elseif 属性=="火" then
		JT_SHUXING="attack_fire"
	elseif 属性=="玄" then
		JT_SHUXING="attack_light"
	elseif 属性=="冰" then
		JT_SHUXING="attack_cold"
	elseif 属性=="毒" then
		JT_SHUXING="attack_poison"
	else
	   屏幕提示("精通属性升级,请设置好参数")
		return		    
	end
	屏幕提示("装备萃取的属性为:"..属性)
	local 精通最小等级=晴天_取身上装备位置精通最小等级(装备位置名称,JT_SHUXING)
	屏幕提示(精通最小等级)
	if 精通最小等级>等级 or 精通最小等级== 0 then
			屏幕提示("没有精通或者等级过大")
		return
	end	
	跨图寻路("苏州",364,245)

    local 装备名称= 晴天_取下装备获取名字(装备位置名称)
    if 装备名称==0 then
        return
    end
	
	local  LPindex=获取背包物品位置(装备名称)-1
	屏幕提示("待精通升级的背包序号:"..LPindex)
	if LPindex<0 then
		return
	end
	
    for iii=1,999 do
		屏幕提示(iii)
		local tem =LUA_取返回值(string.format([[
	    local index = tonumber(%d)
		local JT_ABC=tostring("%s") 
	    local nlevel= tonumber(%d)
		local equip_level = LifeAbility : Get_Equip_Level(index);
		if equip_level <80 then
				PushDebugMessage("装备等级不够不能淬炼")
				return 2
		end
		------------------
		local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
		if selfMoney<50000 then
					PushDebugMessage("精通属性升级金币不够")
					return 2
		end
		------------------------------
            local theAction = EnumAction(index, "packageitem")
			local JT_XUHAO=-1
			for kkk=0,2 do
			local pName, pLevel, pBValue, pPercent, pRValue = theAction:GetEquipAttaProperty(kkk);
			    if(pLevel ~= nil and pLevel > 0) then
						 if	string.find(pName, JT_ABC)  then	
								if tonumber(pLevel) < nlevel  then
									JT_XUHAO= kkk+1
									JT_MQDJ=pLevel
								end
						end
					else
					PushDebugMessage("装备没有淬炼 无法升级")
					break	
				end		
			end		
			--PushDebugMessage("装备有属性对应位置:"..JT_XUHAO)
			
			if tonumber(JT_XUHAO)==-1 then
					return 2	
            end		
				
		   local itemneed= PlayerPackage:CountAvailableItemByIDTable(20700055)
		
		   if tonumber(JT_MQDJ) >= 30 and  tonumber(JT_MQDJ) < 40  then
			JT_XYJJS=14
		elseif tonumber(JT_MQDJ) >= 20 and  tonumber(JT_MQDJ) < 30  then
				JT_XYJJS=12
				elseif tonumber(JT_MQDJ) >=1 and  tonumber(JT_MQDJ) < 10  then
				JT_XYJJS=1		
				elseif tonumber(JT_MQDJ) >=10 and  tonumber(JT_MQDJ) < 20  then
				JT_XYJJS=6
								elseif tonumber(JT_MQDJ) >=40 and  tonumber(JT_MQDJ) < 50  then
				JT_XYJJS=16
								elseif tonumber(JT_MQDJ) >=50 and  tonumber(JT_MQDJ) < 60  then
				JT_XYJJS=18
								elseif tonumber(JT_MQDJ) >=60 and  tonumber(JT_MQDJ) < 70  then
				JT_XYJJS=20
												elseif tonumber(JT_MQDJ) >=70 and  tonumber(JT_MQDJ) < 80  then
				JT_XYJJS=22
												elseif tonumber(JT_MQDJ) >=80 and  tonumber(JT_MQDJ) < 90  then
				JT_XYJJS=24
												elseif tonumber(JT_MQDJ) >=90 and  tonumber(JT_MQDJ) < 100  then
				JT_XYJJS=25
				else
				 JT_XYJJS=20
				end
				
			--PushDebugMessage("需要精金石:"..JT_XYJJS)
			if itemneed < JT_XYJJS then
				PushDebugMessage("精金石:不够")
				return 2
		    end
				Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name("EquipLevelupAtta");
				Set_XSCRIPT_ScriptID(890088);
				Set_XSCRIPT_Parameter(0,index); 
				Set_XSCRIPT_Parameter(1, tonumber(JT_XUHAO));
				Set_XSCRIPT_Parameter(2, 0);
				Set_XSCRIPT_ParamCount(3);
				Send_XSCRIPT();
		]], LPindex,JT_SHUXING,等级))
		--屏幕提示(tem)
		延时(1000)
		 if tonumber(tem)==2 then
			break
		 end
	end
	晴天_穿上装备(装备位置名称,装备名称)
end


local  人物名称,menpai,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()
if  取属性设置为 == 1 then
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
晴天_友情提示("属性攻击:"..属性攻击)
end

if  取属性设置为 == 2 then
if string.find("唐门|星宿|丐帮", menpai) then
属性攻击="毒"
elseif  string.find("逍遥|明教|", menpai) then
属性攻击="火"
elseif  string.find("峨嵋|天山|", menpai) then
属性攻击="冰"
elseif  string.find("天龙|少林|鬼谷|慕容|武当", menpai) then
属性攻击="玄"
end

local  毒主属性名称 = "111|aaa|"
local  火主属性名称 = "111|aaa|"
local  冰主属性名称 = "111|aaa|"
local  玄主属性名称 = "111|aaa|"

if string.find(毒主属性名称, 人物名称) then
属性攻击="毒"
elseif  string.find(火主属性名称, 人物名称) then
属性攻击="火"
elseif  string.find(冰主属性名称, 人物名称) then
属性攻击="冰"
elseif  string.find(玄主属性名称, 人物名称) then
属性攻击="玄"
end
--晴天_友情提示("属性攻击:"..属性攻击)
end


function  晴天_全自动淬炼(index)
	if 晴天_取身上全部钱() < 50000 then
		晴天_友情提示("金币不够放弃精通淬火")
		return
	end	
	if index == 1 then
		离火数量 = 10
	end
	if index == 2 then
		离火数量 = 15
	end
	if index == 3 then
		离火数量 = 20
	end

	if 获取背包物品数量("离火")	< 离火数量 then
			晴天_友情提示("离火不够放弃精通淬火")
			return
	end	

	if string.find("峨嵋", menpai) then
		晴天_装备淬炼("腰带","体力",index)
		晴天_装备淬炼("护肩","体力",index)
		晴天_装备淬炼("手套","体力",index)
		晴天_装备淬炼("鞋子","体力",index)
		晴天_装备淬炼("帽子","体力",index)
		晴天_装备淬炼("衣服","体力",index)

		晴天_装备淬炼("戒指上",属性攻击,index) 
		晴天_装备淬炼("戒指下",属性攻击,index) 
		晴天_装备淬炼("护符上",属性攻击,index) 
		晴天_装备淬炼("护符下",属性攻击,index) 
		晴天_装备淬炼("护腕",属性攻击,index) 
		晴天_装备淬炼("项链",属性攻击,index) 
	else 
		晴天_装备淬炼("戒指上",属性攻击,index) 
		晴天_装备淬炼("戒指下",属性攻击,index) 
		晴天_装备淬炼("护符上",属性攻击,index) 
		晴天_装备淬炼("护符下",属性攻击,index) 
		晴天_装备淬炼("护腕",属性攻击,index) 
		晴天_装备淬炼("项链",属性攻击,index) 
		晴天_装备淬炼("腰带","体力",index)
		晴天_装备淬炼("护肩","体力",index)
		晴天_装备淬炼("手套","体力",index)
		晴天_装备淬炼("鞋子","体力",index)
		晴天_装备淬炼("帽子","体力",index)
		晴天_装备淬炼("衣服","体力",index)
	end
end


function  晴天_精通智能升级(index)
	屏幕提示("晴天_精通智能升级:  "..index)
	屏幕提示("晴天_精通智能升级:  "..index)
	屏幕提示("晴天_精通智能升级:  "..index)
	取出物品("精金石")
	if 获取背包物品数量("精金石")< 12 then
		屏幕提示("精通属性升级不够15个 放弃精通属性升级")
		存物品("精金石")
		return
	end	

	晴天_精通升级("护符上",属性攻击,index)
	晴天_精通升级("护符下",属性攻击,index)
	晴天_精通升级("戒指上",属性攻击,index)
	晴天_精通升级("戒指下",属性攻击,index)
	晴天_精通升级("护腕",属性攻击,index)
	晴天_精通升级("项链",属性攻击,index)

	晴天_精通升级("腰带","体力",index)
	晴天_精通升级("护肩","体力",index)
	晴天_精通升级("手套","体力",index)
	晴天_精通升级("鞋子","体力",index)
	晴天_精通升级("帽子","体力",index)
	晴天_精通升级("衣服","体力",index)
	存物品("精金石")
end
---------------------------------------------------------------------------------------------
取出物品("金币",999999)
取出物品("离火")
存物品("离火",不存物品,0,1,1)
晴天_全自动淬炼(1) --属性条数
晴天_全自动淬炼(2)
晴天_全自动淬炼(3)
存物品("离火")