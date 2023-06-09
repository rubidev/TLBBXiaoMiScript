


function 取出绑定物品(绑定列表)
取出物品(绑定列表)
存物品(绑定列表,不存物品,0,1,1)
end
--------------------------------------------------------------------------------------------------
function PushDebugMessage(AAA)
   屏幕提示(AAA)
end

function Sleep(AAA)
   延时(AAA)
end

-----------------------------------------------

取出绑定物品("金蚕丝|丹青")

---------------------------------------------
function 晴天点击确定()
for i=1,3 do
if  窗口是否出现("MessageBox_Self")==1 then
    --屏幕提示("晴天点击确认")
    LUA_Call(" setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();")
	延时(2000)
end
end
end

function 晴天穿上装备(装备名称,装备位置名称)
     if 装备名称==""  then
		屏幕提示("参数错误,晴天穿上装备")
				屏幕提示("参数错误,晴天穿上装备")
						屏幕提示("参数错误,晴天穿上装备")
		return
	end
	
	if 获取背包物品数量(装备名称)<=0 then
	屏幕提示("没有装备无法使用,晴天穿上装备")
		屏幕提示("没有装备无法使用,晴天穿上装备")
			屏幕提示("没有装备无法使用,晴天穿上装备")
			return
	end	
		
	
     if 装备位置名称=="左戒指"  then
		--装备取下编号=7
		装备位置=6
		elseif 装备位置名称=="右戒指" then
		--装备取下编号=8
		装备位置=11
       elseif  装备位置名称=="左护符" then
		--装备取下编号=9
		装备位置=12
		elseif 装备位置名称=="右护符" then
		--装备取下编号=10
		装备位置=13
       elseif  装备位置名称=="武器" then
		--装备取下编号=0
		装备位置=0
		elseif 装备位置名称=="帽子" then
		--装备取下编号=1
		装备位置=1
	   elseif 装备位置名称=="护肩" then
		--装备取下编号=2
		装备位置=15	
			   elseif 装备位置名称=="护腕" then
		--装备取下编号=3
		装备位置=14	
			   elseif 装备位置名称=="手套" then
		--装备取下编号=4
		装备位置=3	
			   elseif 装备位置名称=="腰带" then
		--装备取下编号=5
		装备位置=5	
					   elseif 装备位置名称=="鞋子" then
		--装备取下编号=6
		装备位置=4
		
		elseif 装备位置名称=="衣服" then
		--装备取下编号=12
		装备位置=2
			elseif 装备位置名称=="项链" then
		--装备取下编号=13
		装备位置=7
		
		elseif 装备位置名称=="暗器" then
		--装备取下编号=14
		装备位置=17
		
		elseif 装备位置名称=="龙纹" then
		--装备取下编号=25
		装备位置=19
		
		elseif 装备位置名称=="令牌" then
		--装备取下编号=16
		装备位置=20
		
		elseif 装备位置名称=="豪侠印" then
		--装备取下编号=""
		装备位置=21
		
		elseif 装备位置名称=="武魂" then
		--装备取下编号=""
		装备位置=18
		else
		屏幕提示("请设置好对应的装备名字再使用穿上装备")
		return
	end

     计次循环 i=1,5 执行
         延时(2000)
		 右键使用物品(装备名称,2) 
         延时(2000)


		装备ID = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetID()
	]], 装备位置))
		
		当前装备名称 = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetName()
	]], 装备位置))

        如果 到数值(装备ID)>0   则--装备成功
		屏幕提示(" 晴天成功穿上"..装备名称.."|在位置:"..装备位置)
              跳出循环   
         结束
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
	-------------------------------------------
		local 装备持久 =到数值( LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetEquipDur()
	]], 装备位置)))
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
		end

              LUA_Call(string.format([[ setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Equip_Click(%d,0)]], 装备取下编号))
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

function 晴天雕纹升级(装备位置名称,等级)
	if 到数值(获取人物信息(45)+获取人物信息(52)) <5*10000 then
			    屏幕提示("精通属性升级,金币不够")
		return
	end
if tonumber(index)==3 then
	需要的数量=9
	elseif tonumber(index)==4 then
	需要的数量=50
		elseif tonumber(index)==5 then
			需要的数量=87
				elseif tonumber(index)==6 then
			需要的数量=165
			else 
				需要的数量=10
end
if 获取背包物品数量("金蚕丝")< 需要的数量 then
	    屏幕提示("精通属性升级不够 放弃精通属性升级")
		return
end

	屏幕提示("自动前往洛阳装备雕纹升级")
	跨图寻路("洛阳",318,313)
	
      LPname= 晴天取下装备获取名字(装备位置名称)
	     延时(2000) 
        if LPname==0 then
             return
         end

	  屏幕提示("装备位置名称:"..LPname)
     LPindex=获取背包物品位置(LPname)-1
	     屏幕提示("待精通升级的背包序号:"..LPindex)
	if LPindex<0 then
		    return
	end

local tem =LUA_取返回值(string.format([[
      
		local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
		if selfMoney<50000 then
					PushDebugMessage("精通属性升级金币不够")
					return 2
		end
		
	    local index = tonumber(%d)
	    local todwlevel= tonumber(%d)	
		local IsHaveDiaowen = LifeAbility:IsEquipHaveDiaowen(index)
	    local IsHaveDiaowenEx = LifeAbility:IsEquipHaveDiaowenEx(index)
		if  tonumber(IsHaveDiaowen)~=1 then
				PushDebugMessage("装备没有雕纹")
				return 2
		end
		
			local dwId,dwlevel = LifeAbility:GetEquitDiaowenID(index)
			local dwIdEx,dwlevelEx = LifeAbility:GetEquitDiaowenIDEx(index)
			
         if dwlevel>=todwlevel then
				PushDebugMessage("雕纹已经够设置等级:"..todwlevel)
				return 2
          end
		
Clear_XSCRIPT()
Set_XSCRIPT_Function_Name("DoEquipDWLevelUp")
Set_XSCRIPT_ScriptID(809272)
Set_XSCRIPT_Parameter(0, index) --背包的序号
Set_XSCRIPT_Parameter(1, todwlevel)  --第一个雕纹要升级的等级
Set_XSCRIPT_Parameter(2, 0) --第二个雕纹要升级的等级
Set_XSCRIPT_Parameter(3, 0)  --0代表不提示直接用 1代表有提示
Set_XSCRIPT_ParamCount(4)
Send_XSCRIPT()
			
			

		]], LPindex,等级),"n")


 晴天穿上装备(LPname,装备位置名称)

end

local  aaaaa,menpai,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()

function  晴天全自动雕纹升级(index)
屏幕提示("晴天雕纹升级:  "..index)
屏幕提示("晴天雕纹升级:  "..index)
屏幕提示("晴天雕纹升级:  "..index)
if tonumber(index)==3 then
	需要的数量=9
	elseif tonumber(index)==4 then
	需要的数量=50
		elseif tonumber(index)==5 then
			需要的数量=87
				elseif tonumber(index)==6 then
			需要的数量=165
			else 
				需要的数量=10
end
if 获取背包物品数量("金蚕丝")< 需要的数量 then
	    屏幕提示("精通属性升级不够 放弃精通属性升级")
		return
end

if string.find("峨嵋", menpai) then
晴天雕纹升级("腰带",index)
晴天雕纹升级("护肩",index)
晴天雕纹升级("手套",index)
晴天雕纹升级("鞋子",index)
晴天雕纹升级("帽子",index)
晴天雕纹升级("衣服",index)

晴天雕纹升级("左护符",index)
晴天雕纹升级("右护符",index)
晴天雕纹升级("左戒指",index)
晴天雕纹升级("右戒指",index)
晴天雕纹升级("护腕",index)
晴天雕纹升级("项链",index)
else 

晴天雕纹升级("左护符",index)
晴天雕纹升级("右护符",index)
晴天雕纹升级("左戒指",index)
晴天雕纹升级("右戒指",index)
晴天雕纹升级("护腕",index)
晴天雕纹升级("项链",index)

晴天雕纹升级("腰带",index)
晴天雕纹升级("护肩",index)
晴天雕纹升级("手套",index)
晴天雕纹升级("鞋子",index)
晴天雕纹升级("帽子",index)
晴天雕纹升级("衣服",index)
end

end
 晴天全自动雕纹升级(4)
 晴天全自动雕纹升级(5)
 晴天全自动雕纹升级(6)