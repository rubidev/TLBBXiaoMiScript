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

function 关闭窗口(strWindowName)
      if 窗口是否出现(strWindowName)==1 then
	    LUA_Call(string.format([[
	            setmetatable(_G, {__index = %s_Env}) this:Hide()  
	  ]], strWindowName))  
	  end
end
--------------------------------------------------------------
function  取装备持久(aaa)
return  到数值(LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetEquipDur()
	]], aaa)))
end
function  取装备ID(aaa)
return  LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetID()
	]], aaa))
end

function  取装备名字(aaa)
return  LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetName()
	]], aaa))
end

function  取背包装备等级(index)
local aaa=  LUA_取返回值(string.format([[ 
		return LifeAbility : Get_Equip_Level(%d);
	]], index))
	return tonumber(aaa)
end



function  取身上武魂生命()--300最大
       if  到数值( 取装备ID(18) )>0 then
			return  到数值(LUA_取返回值(string.format([[ 
		return DataPool:GetKfsData("LIFE")
	]])))
	else
	return -1
    end
end


function 晴天穿上装备(装备名称,装备位置名称)
     if 装备名称==""  then
		晴天_屏幕提示("参数错误,晴天穿上装备")
		return
	end
	
	if 获取背包物品数量(装备名称)<=0 then
		晴天_屏幕提示("没有装备无法使用,晴天穿上装备")
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
		装备取下编号="100"
		装备位置=18
		else
			晴天_屏幕提示("请设置好对应的装备名字再使用穿上装备")
			return
	end

     for i=1,5 do
        if 窗口是否出现("SelfEquip") ==0 then
			LUA_Call ("MainMenuBar_SelfEquip_Clicked();")
			延时 (1500)
		end
		if 窗口是否出现("Packet") ==0 then
			LUA_Call ("setmetatable(_G, {__index = Packet_Env});this:Show();")
			延时 (1500)
		end
		关闭窗口("SuperWeaponUpNEW")
	    if 装备位置名称=="武魂" then
			坐骑_下坐骑()
			LUA_Call ("MainMenuBar_SelfEquip_Clicked();")
			右键使用物品(装备名称,1) 
			延时(6000)
		else
			LUA_Call ("MainMenuBar_SelfEquip_Clicked();")
			右键使用物品(装备名称,2) 
			延时(2000)
			右键使用物品(装备名称,2) 
			延时(2000)
		end
		
		装备ID = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetID()
	]], 装备位置))
		
		当前装备名称 = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetName()
	]], 装备位置))

     if tonumber(装备ID)>0 then
		      晴天_友情提示(" 晴天成功穿上"..装备名称.."|在位置:"..装备位置)
              跳出循环   
         end
     end
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
			装备位置=2
			
		--------------------------------------特殊装备
		elseif 装备位置名称=="豪侠印" then
			装备取下编号=""
			装备位置=21
		
		elseif 装备位置名称=="武魂" then
			装备取下编号=""
			装备位置=18
	end
	-------------------------------------------

	local 装备持久 = tonumber( LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetEquipDur()
	]], 装备位置)))
	
	 if 装备位置名称=="武魂" then
	    local 装备持久= 取身上武魂生命()
	 end
	
	if 装备持久<=0 then
		晴天_屏幕提示("装备持久不够,不取下")
		return 0
	end
	
     计次循环 i=1,5 执行
         LUA_Call ("MainMenuBar_SelfEquip_Clicked();")
         延时 (1500)
         如果 窗口是否出现("SelfEquip") ==1 则   
		装备名称 = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetName()
	]], 装备位置))

		if 装备名称=="" then
			晴天_屏幕提示(装备位置名称.."不存在装备")
			return 0
			else
             晴天_友情提示("需要升级的装备:"..装备位置名称.."|"..装备名称)
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
              延时 (1500)
			装备ID = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetID()
	]], 装备位置))
	
              如果 装备ID=="0" 则  --检测脱下装备成功
                   LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseFunction();")      
                   延时(1500)  
                   返回 装备名称
              结束
         结束      
     结束
     LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseFunction();")      
     延时(1500) 
			装备ID = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetID()
	]], 装备位置))
	
     如果 装备ID=="0" 则
          返回 装备名称
     否则  
          返回 0
     结束     
end

神器名字集合="万壑松风扇|雷鸣离火扇|碧海银涛环|碎情雾影环|溶金落日刀||赤焰九纹刀|秋水无痕剑|含光弄影剑|紫阳绝翎弩|凌霄玉琼弩|碧海凌波杖|太虚归星杖||百代鸿光箫|天地乐同箫|"
-------------------------------------------------------------------------------------------
function 晴天_神器炼魂(装备位置名称)
		晴天_屏幕提示("晴天_神器炼魂:"..装备位置名称)
			local 装备名称 = 晴天取下装备获取名字(装备位置名称)
					if string.find (神器名字集合,装备名称) then
							晴天_屏幕提示("晴天_开始神器炼魂")
						跨图寻路("苏州",354,240);延时 (1500)
	  计次循环 i=1,5 执行
         如果 对话NPC("欧治于")==1 则
              NPC二级对话("神器炼魂",0)      --参数1：对话文本  参数2:模糊对话，0表示精确 1表示模糊
              延时 (1500)
              如果 窗口是否出现("SuperWeaponUpNEW")==1 则
                   右键使用物品(装备名称,1)  --参数2为使用次数1次，可省略，默认为1次
                   LUA_Call ("setmetatable(_G, {__index = SuperWeaponUpNEW_Env});SuperWeaponUpNEW_Buttons_Clicked();")
                   延时 (1500)
                   跳出循环
              结束
         否则 
              延时(1000)
         结束
     结束   	
					end
			
			晴天穿上装备(装备名称,装备位置名称);延时(1500)  								
end

 晴天_神器炼魂("武器")