--执行功能("[脚本]晴天初始化函数库")


取属性设置为 =1
-------------1,按最高属性
-------------2,按特定门派和名字

------------------------------------------------
function  取装备持久(aaa)
return  到数值(LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetEquipDur()
	]], aaa)))
end

function  取装备ID(aaa)
return 到数值(LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetID()
	]], aaa)))
end

function  取装备名字(aaa)
return  LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetName()
	]], aaa))
end

--------------------------------------------------------------
function  取身上武魂生命()--300最大
       if  到数值( 取装备ID(18) )>0 then
			return  到数值(LUA_取返回值(string.format([[ 
		return DataPool:GetKfsData("LIFE")
	]])))
	else
	return -1
    end
end
function 晴天点击确定()
for i=1,3 do
if  窗口是否出现("MessageBox_Self")==1 then
    --屏幕提示("晴天点击确认")
    LUA_Call(" setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();")
	延时(2000)
    end
  end
end

--0=武器 1=耳朵 2=护甲 3=手套 4=鞋子 5=腰带 6=戒指1 7=项链 8=坐骑1 9=行囊 10=格箱 11=戒指2 12=护符1 13=护符2 14=护腕 
--15=护肩 16=时装 17=暗器 18=御瑶盘 19=龙纹 20=帮会令牌 21=侠印

function 晴天穿上装备(装备名称,装备位置名称)
     if 装备名称==""  then
		屏幕提示("参数错误,晴天穿上装备")
		return
	end
	
	if 获取背包物品数量(装备名称)<=0 then
	屏幕提示("没有装备无法使用,晴天穿上装备")
			return
	end	
		
     if 装备位置名称=="左戒指"  then
		装备取下编号=7
		装备位置=6
		elseif 装备位置名称=="右戒指" then
		装备取下编号=8
		装备位置=11
       elseif  装备位置名称=="左护符" then
		装备取下编号=9
		装备位置=12
		elseif 装备位置名称=="右护符" then
		装备取下编号=10
		装备位置=13
       elseif  装备位置名称=="武器" then
		装备取下编号=11
		装备位置=0
		elseif 装备位置名称=="帽子" then
		装备取下编号=1
		装备位置=1
	   elseif 装备位置名称=="护肩" then
		装备取下编号=2
		装备位置=15	
			   elseif 装备位置名称=="护腕" then
		装备取下编号=3
		装备位置=14	
			   elseif 装备位置名称=="手套" then
		装备取下编号=4
		装备位置=3	
			   elseif 装备位置名称=="腰带" then
		装备取下编号=5
		装备位置=5	
					   elseif 装备位置名称=="鞋子" then
		装备取下编号=6
		装备位置=4
		
		elseif 装备位置名称=="衣服" then
		装备取下编号=12
		装备位置=2
			elseif 装备位置名称=="项链" then
		装备取下编号=13
		装备位置=7
		
		elseif 装备位置名称=="暗器" then
		装备取下编号=14
		装备位置=17
		
		elseif 装备位置名称=="龙纹" then
		装备取下编号=25
		装备位置=19
		
		elseif 装备位置名称=="令牌" then
		装备取下编号=16
		装备位置=20
		
		elseif 装备位置名称=="豪侠印" then
		装备取下编号="100"
		装备位置=21
		
		elseif 装备位置名称=="武魂" then
		装备取下编号=""
		装备位置=18
		else
		屏幕提示("请设置好对应的装备名字再使用穿上装备")
		return
	end

     计次循环 i=1,5 执行
	    if 装备位置名称=="武魂" then
		坐骑_下坐骑()
		右键使用物品(装备名称,2) 
         延时(6000)
		else
		右键使用物品(装备名称,2) 
         延时(1000)
		end
		
		装备ID = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetID()
	]], 装备位置))
		
		当前装备名称 = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetName()
	]], 装备位置))

        如果 到数值(装备ID)>0   则
		屏幕提示(" 晴天成功穿上"..装备名称.."|在位置:"..装备位置)
              跳出循环   
         结束
     结束
end



--晴天穿上装备("幻世手套","手套")
--SelfEquip_Equip_Click( 7,0 ); 上面的戒指

function 晴天取下装备(装备位置名称)
     if 装备位置名称=="左戒指" then
		装备取下编号=7
		装备位置=6
		elseif 装备位置名称=="右戒指" then
		装备取下编号=8
		装备位置=11
       elseif  装备位置名称=="左护符" then
		装备取下编号=9
		装备位置=12
		elseif 装备位置名称=="右护符" then
		装备取下编号=10
		装备位置=13
       elseif  装备位置名称=="武器" then
		装备取下编号=0
		装备位置=0
		elseif 装备位置名称=="帽子" then
		装备取下编号=1
		装备位置=1
	   elseif 装备位置名称=="护肩" then
		装备取下编号=2
		装备位置=15	
			   elseif 装备位置名称=="护腕" then
		装备取下编号=3
		装备位置=14	
			   elseif 装备位置名称=="手套" then
		装备取下编号=4
		装备位置=3	
			   elseif 装备位置名称=="腰带" then
		装备取下编号=5
		装备位置=5	
					   elseif 装备位置名称=="鞋子" then
		装备取下编号=6
		装备位置=4
		
		elseif 装备位置名称=="衣服" then
		装备取下编号=12
		装备位置=2
			elseif 装备位置名称=="项链" then
		装备取下编号=13
		装备位置=7
					elseif 装备位置名称=="暗器" then
		装备取下编号=14
		装备位置=17
		
		elseif 装备位置名称=="龙纹" then
		装备取下编号=25
		装备位置=19
		
		elseif 装备位置名称=="令牌" then
		装备取下编号=16
		装备位置=20
		
		elseif 装备位置名称=="豪侠印" then
		装备取下编号=""
		装备位置=21
		
		elseif 装备位置名称=="武魂" then
		装备取下编号=""
		装备位置=18
	end
	
     计次循环 i=1,5 执行
         LUA_Call ("MainMenuBar_SelfEquip_Clicked();")
         延时 (1000)
         如果 窗口是否出现("SelfEquip") ==1 则   
              LUA_Call(string.format([[ setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Equip_Click(%d,0)]], 装备取下编号))
			
              延时 (1000)
			装备ID = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetID()
	]], 装备位置))
	
              如果 装备ID=="0" 则  --检测脱下装备成功
                   LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseFunction();")      
                   延时(500)  
                   返回 1   
              结束
         结束      
     结束
     LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseFunction();")      
     延时(500) 
			装备ID = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetID()
	]], 装备位置))
	
     如果 装备ID=="0" 则
          返回 1   
     否则  
          返回 0
     结束     
end

function 晴天取下装备获取名字(装备位置名称)
     if 装备位置名称=="左戒指" then
		装备取下编号=7
		装备位置=6
		elseif 装备位置名称=="右戒指" then
		装备取下编号=8
		装备位置=11
       elseif  装备位置名称=="左护符" then
		装备取下编号=9
		装备位置=12
		elseif 装备位置名称=="右护符" then
		装备取下编号=10
		装备位置=13
       elseif  装备位置名称=="武器" then
		装备取下编号=11
		装备位置=0
		elseif 装备位置名称=="帽子" then
		装备取下编号=1
		装备位置=1
	   elseif 装备位置名称=="护肩" then
		装备取下编号=2
		装备位置=15	
			   elseif 装备位置名称=="护腕" then
		装备取下编号=3
		装备位置=14	
			   elseif 装备位置名称=="手套" then
		装备取下编号=4
		装备位置=3	
			   elseif 装备位置名称=="腰带" then
		装备取下编号=5
		装备位置=5	
					   elseif 装备位置名称=="鞋子" then
		装备取下编号=6
		装备位置=4
		
		elseif 装备位置名称=="衣服" then
		装备取下编号=12
		装备位置=2
			elseif 装备位置名称=="项链" then
		装备取下编号=13
		装备位置=7
					elseif 装备位置名称=="暗器" then
		装备取下编号=14
		装备位置=17
		
		elseif 装备位置名称=="龙纹" then
		装备取下编号=25
		装备位置=19
		
		elseif 装备位置名称=="令牌" then
		装备取下编号=16
		装备位置=20
		
		--------------------------------------特殊装备
		elseif 装备位置名称=="豪侠印" then
		装备取下编号=""
		装备位置=21
		
		elseif 装备位置名称=="武魂" then
	     装备取下编号=""
		装备位置=18
	end
	-------------------------------------------

		local 装备持久 =到数值( LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetEquipDur()
	]], 装备位置)))
	
	 if 装备位置名称=="武魂" then
	    local 装备持久= 取身上武魂生命()
	 end
	
	if 装备持久<=0 then
		屏幕提示("装备持久不够,不取下")
		return 0
	end
	
     计次循环 i=1,5 执行
         LUA_Call ("MainMenuBar_SelfEquip_Clicked();")
         延时 (1000)
         如果 窗口是否出现("SelfEquip") 则   
		装备名称 = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetName()
	]], 装备位置))

		if 装备名称=="" then
			屏幕提示(装备位置名称.."不存在装备")
			return 0
			else
             屏幕提示("需要升级的装备:"..装备位置名称.."|"..装备名称)
		end
              if 装备位置名称=="豪侠印" then
				
				 LUA_Call ("setmetatable(_G, {__index = Xiulian_Env});Xiulian_JueWei_Page_Switch();")
				 延时 (2000)
				 LUA_Call ("setmetatable(_G, {__index = SelfJunXian_Env});SelfJunXian_Equip_Clicked(0);")
             	延时 (2000)
				关闭窗口("SelfJunXian")
				elseif 装备位置名称=="武魂" then
				 LUA_Call ("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Wuhun_Switch();")
				 延时 (2000)
				 LUA_Call ("setmetatable(_G, {__index =  Wuhun_Env});Wuhun_Equip_Clicked(0);")
             	延时 (2000)
				关闭窗口("Wuhun")
				else
				 LUA_Call(string.format([[ setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Equip_Click(%d,0)]], 装备取下编号))
			end 
             
              延时 (1000)
			装备ID = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetID()
	]], 装备位置))
	
              如果 装备ID=="0" 则  --检测脱下装备成功
                   LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseFunction();")      
                   延时(500)  
                   返回 装备名称
              结束
         结束      
     结束
     LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseFunction();")      
     延时(500) 
			装备ID = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetID()
	]], 装备位置))
	
     如果 装备ID=="0" 则
          返回 装备名称
     否则  
         
    返回 0
     结束     
end
-------------------------------------------------------------------------------------

function 晴天装备淬炼(装备位置名称,属性,数量)
		
	if 获取背包物品数量("离火")< 15 then
	    屏幕提示("离火不够15个 放弃精通淬火")
		return
	end	
	if 到数值(获取人物信息(45)+获取人物信息(52)) <3*10000 then
			    屏幕提示("精通淬火,金币不够")
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
				    屏幕提示("精通淬火,请设置好参数")
	return		    
	end
	屏幕提示("装备萃取的属性为:"..属性)
	跨图寻路("苏州",364,245)
	
	
      LPname= 晴天取下装备获取名字(装备位置名称)

        if LPname==0 then
             return
         end
		      屏幕提示("装备位置名称:"..LPname)
     LPindex=获取背包物品位置(LPname)-1
	     屏幕提示(LPindex)
	if LPindex<0 then
		    return
	end


		
        for iii=1,50 do

		
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
		
			PushDebugMessage(JT_AAA..JT_BBB..JT_CCC)
				    if JT_AAA+JT_BBB+JT_CCC>=%d then
						PushDebugMessage("精通属性足够数量,不再淬火")
						return 2
					end
					
			Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name("EquipCuiLian");
				Set_XSCRIPT_ScriptID(890088);
				Set_XSCRIPT_Parameter(0,%d);
				Set_XSCRIPT_Parameter(1,JT_AAA)
				Set_XSCRIPT_Parameter(2,JT_BBB)
				Set_XSCRIPT_Parameter(3,JT_CCC)
				Set_XSCRIPT_ParamCount(4);
			Send_XSCRIPT();	
		]], LPindex,JT_SHUXING,数量,LPindex), "d")
		屏幕提示(tem)
		延时(3000)
		 if tonumber(tem)==2 then
			跳出循环
		 end
		end
		
		晴天穿上装备(LPname,装备位置名称)
		晴天穿上装备(LPname,装备位置名称)
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
屏幕提示("属性攻击:"..属性攻击)
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
--屏幕提示("属性攻击:"..属性攻击)
end


function  晴天_全自动淬炼(index)
取出物品("离火")
存物品("离火",不存物品,0,1,1)
if 获取背包物品数量("离火")< 15 then
	    屏幕提示("离火不够15个 放弃精通淬火")
		return
end	
	
if string.find("峨嵋", menpai) then
晴天装备淬炼("腰带","体力",index)
晴天装备淬炼("护肩","体力",index)
晴天装备淬炼("手套","体力",index)
晴天装备淬炼("鞋子","体力",index)
晴天装备淬炼("帽子","体力",index)
晴天装备淬炼("衣服","体力",index)

--晴天装备淬炼("左戒指",属性攻击,index) 
--晴天装备淬炼("右戒指",属性攻击,index) 
--晴天装备淬炼("左护符",属性攻击,index) 
--晴天装备淬炼("右护符",属性攻击,index) 
--晴天装备淬炼("护腕",属性攻击,index) 
--晴天装备淬炼("项链",属性攻击,index) 

else 
晴天装备淬炼("左戒指",属性攻击,index) 
晴天装备淬炼("右戒指",属性攻击,index) 
晴天装备淬炼("左护符",属性攻击,index) 
晴天装备淬炼("右护符",属性攻击,index) 
晴天装备淬炼("护腕",属性攻击,index) 
晴天装备淬炼("项链",属性攻击,index) 

--晴天装备淬炼("腰带","体力",index)
--晴天装备淬炼("护肩","体力",index)
--晴天装备淬炼("手套","体力",index)
--晴天装备淬炼("鞋子","体力",index)
--晴天装备淬炼("帽子","体力",index)
--晴天装备淬炼("衣服","体力",index)
end
存物品("离火")
end

晴天_全自动淬炼(1) --属性条数
晴天_全自动淬炼(2)
晴天_全自动淬炼(3)