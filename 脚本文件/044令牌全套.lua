local 令牌名称集合="江湖令|金兰令|聚义令|歃血令|霸王令"
local 令牌名称列表={"江湖令","金兰令","聚义令","歃血令","霸王令"}
local 领取令牌所需帮贡={200,300,400,500,1000}
local 领取宝珠所需帮贡=50

--屏幕提示(令牌名称列表[1])
--屏幕提示(领取令牌所需帮贡[1])
--屏幕提示(ceshi)
------------------------------------------------------------------------------------------------------------
持久度=tonumber(LUA_取返回值("return EnumAction(20,'equip'):GetEquipDur();"))
if 持久度<=  0 then
	屏幕提示("令牌持久度不够不执行任何操作")
	return
end
------------------------------------------------------------------------------------------------------------
取出物品("翡翠心精|唤灵液|天荒晶石")  

function AskGuildDetailInfo()
	if 判断有无帮派()==1 then
			   GuildCity_Name = LUA_取返回值([[
					local CityName = Guild:GetMyGuildDetailInfo("CityName")
					return CityName
			   ]], "s")
	   if GuildCity_Name ~= "-1" then--之前已经打开过帮会界面，并已获取过帮会城市，直接return！
	       return GuildCity_Name
	   end
	   LUA_Call("Guild:AskGuildDetailInfo()")
	   延时(3000)
		 GuildCity_Name = LUA_取返回值([[
				local CityName = Guild:GetMyGuildDetailInfo("CityName")
				return CityName
		   ]], "s")
        延时(2000)
        if 窗口是否出现("NewBangHui_Bhxx") then
	        LUA_Call("setmetatable(_G, {__index = NewBangHui_Bhxx_Env}) NewBangHui_Bhxx_Close()")
	    end
	    return GuildCity_Name
	end
end
帮会名字=AskGuildDetailInfo()
屏幕提示("帮会名字:"..帮会名字)
屏幕提示("帮会名字:"..帮会名字)
屏幕提示("帮会名字:"..帮会名字)

function 关闭窗口(strWindowName)
	if 窗口是否出现(strWindowName)==1 then
	  LUA_Call(string.format([[
		setmetatable(_G, {__index = %s_Env}) this:Hide()  
	 ]], strWindowName))  
	 end
end

function 进入帮会城市()
    for i=1,5 do
        if 获取人物信息(16)~=帮会名字 then
            跨图寻路("洛阳",236,236)
            延时(500)
            对话NPC("范纯仁")
            延时(500)
            NPC二级对话("进入本帮城市") 
            延时(5000) 
            寻路(44,47,1) 
			延时(3000) 
        end
    end
end

function 取下令牌()
     for i=1,5 do
         LUA_Call ("MainMenuBar_SelfEquip_Clicked();")
         延时 (1000)
         if 窗口是否出现("SelfEquip") then   --同组命令 等待窗口出现()
              LUA_Call ("SelfEquip_Equip_Click(16,0);")
              延时 (1000)
              if LUA_取返回值("return EnumAction(20,'equip'):GetID();")=="0" then  --检测脱下装备成功
                   LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseFunction();")      
                   延时(500)  
                   return 1   
              end
         end      
     end
     LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseFunction();")      
     延时(500) 
     if LUA_取返回值("return EnumAction(20,'equip'):GetID();")=="0" then
          return 1   
     else  
          return 0
     end     
end

function 装备令牌(令牌名称)
    屏幕提示("开始装备令牌:"..令牌名称)
     for i=1,5 do
         if 窗口是否出现("EquipLingPai_ShengJie") ==1 then 
	          	关闭窗口("EquipLingPai_ShengJie")
		 elseif 窗口是否出现("EquipLingPai_Star") ==1 then 
				关闭窗口("EquipLingPai_Star")
		 elseif 窗口是否出现("EquipLingPai_OperatingSJ") ==1 then 
				关闭窗口("EquipLingPai_OperatingSJ")				
             else
              右键使用物品(令牌名称,1)     --参数2:为使用次数
         end
         延时(1000)
         if tonumber(LUA_取返回值("return EnumAction(20,'equip'):GetID();"))>0 then  --装备成功
              break   
         end
     end
end


function  领取令牌()
if LUA_取返回值("return EnumAction(20,'equip'):GetName();")==""  and  获取背包物品数量(令牌名称集合) ==0 then
if tonumber(获取人物信息(63)) >=100 then
 屏幕提示("当前装备无令牌 ,前往帮会领取")
  进入帮会城市()
  for i=1,5 do
         寻路(44,47) 
	延时(3000)
         if 获取背包物品数量("江湖令") >=1 then
              装备令牌("江湖令")
              延时(2000)
         end
         if LUA_取返回值("return EnumAction(20,'equip'):GetName();")=="江湖令" then
             延时(2000)
             break
        end
         if 对话NPC("孔相如")==1 then
              延时(2000)
              NPC二级对话("获取令牌") 
              延时(2000)
              任务_完成()
              延时(2000)
        end
    end
  end
else
 屏幕提示("已经有令牌 |无需领取")
end

end

function  令牌升阶()
if LUA_取返回值("return EnumAction(20,'equip'):GetName();")==令牌名称列表[5] then
屏幕提示("当前令牌为:"..令牌名称列表[5] .."|无需再进行升阶")
return
end

进入帮会城市()
寻路(44,47,1) 
延时(3000)
for kk=1,4 do
 if LUA_取返回值("return EnumAction(20,'equip'):GetName();")==令牌名称列表[kk] then
	if  tonumber(获取人物信息(63)) >=领取令牌所需帮贡[kk] then
		 屏幕提示("当前令牌为:"..令牌名称列表[kk].."             要升阶的令牌为:"..令牌名称列表[kk+1])
    if 取下令牌()==0 then                     --取下武器，if取下失败thenreturn
          LUA_Call("PushDebugMessage(\"取下令牌失败，放弃升阶!\")")
          return
     end
		  for i=1,5 do
             if 对话NPC("孔相如")==1 then
              延时(2000)
              NPC二级对话("令牌装备升阶") 
              延时(2000)
			         if 窗口是否出现("EquipLingPai_ShengJie") ==1 then
						右键使用物品(令牌名称列表[kk],1)     --参数2:为使用次数
						  延时(2000)
						  LUA_Call ("setmetatable(_G, {__index = EquipLingPai_ShengJie_Env});EquipLingPai_ShengJie_OnOK();")
					     延时(2000)
                         装备令牌(令牌名称列表[kk+1])
						 延时(2000)
					end
					if LUA_取返回值("return EnumAction(20,'equip'):GetName();")==令牌名称列表[kk+1] then
						break
					end
               end
		  end
      end
   end
 end
end

function  获取四象宝珠(name,NPCname,index)
if tonumber(获取人物信息(63)) >=50 then
 屏幕提示("获取四象宝珠:"..NPCname)
  进入帮会城市()
  for i=1,5 do
        寻路(44,47,1)
	延时(3000) 
		if 获取背包物品数量(name) >=1 then
			延时(2000)
			 屏幕提示("背包中有宝珠"..name)
              return
         end
         if 对话NPC("孔相如")==1 then
              延时(2000)
              NPC二级对话("获取四象宝珠") 
              延时(2000)
              NPC二级对话(NPCname) 
              延时(2000)
			  任务_完成(index) 
        end
  end
end
end

function  令牌镶嵌宝珠(LPname,ZBname,index)
		if 获取背包物品数量(LPname) >=1 and  获取背包物品数量(ZBname)  >=1 then
     LPindex=获取背包物品位置(LPname)-1
	 ZBindex =获取背包物品位置(ZBname)-1
		LUA_Call(string.format([[
				Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name( "RL_SetRs" );
				Set_XSCRIPT_ScriptID( 880001 );
				Set_XSCRIPT_Parameter( 0, %d);  
				Set_XSCRIPT_Parameter( 1, %d-1);  
				Set_XSCRIPT_Parameter( 2, %d );         --- 物品背包索引
				Set_XSCRIPT_ParamCount( 3 );
			Send_XSCRIPT();	
		]], LPindex,index,ZBindex))
	else
	屏幕提示("令牌宝珠不齐,无法镶嵌")
end
end

function 令牌全自动镶嵌宝珠()
屏幕提示("令牌全自动镶嵌宝珠需要取下装备判断") 
for uuu=1,4 do
	if tonumber(获取人物信息(45)+获取人物信息(52))<=10*10000 then
		屏幕提示("当前金币少于10J,不能do令牌全自动镶嵌宝珠")
		return
    end
	local 令牌名称=LUA_取返回值("return EnumAction(20,'equip'):GetName();")
     if  取下令牌()==0 then                 --取下武器，if取下失败thenreturn
          屏幕提示("取下令牌失败,停止镶嵌宝珠")
          return
     end
	
       LPindex=获取背包物品位置(令牌名称)-1
	   镶嵌位置 = LUA_取返回值(string.format([[
	    for i=1,4 do
		local nRsID =PlayerPackage:Lua_GetBagItemRl_Rs(%d , i-1)
		if nRsID == -2 then
		PushDebugMessage("未开启:"..i)
		elseif nRsID <= 0 then
		PushDebugMessage("需要镶嵌的位置:"..i)
		return i
		end
		end
        return -1
	]], LPindex), "n")
	
    屏幕提示(镶嵌位置)
     if tonumber(镶嵌位置)==1 then
	 获取四象宝珠("朱雀宝珠·血上限","获取红色朱雀宝珠",0)
	 令牌镶嵌宝珠(令牌名称,"朱雀宝珠·血上限",1)
     end
	 if tonumber(镶嵌位置)==2 then
		local  人物名称,menpai,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()
         if string.find("唐门|星宿|丐帮", menpai) then
		     获取四象宝珠("青龙宝珠·毒攻击","获取绿色青龙宝珠",3)
              延时(2000)
		     令牌镶嵌宝珠(令牌名称,"青龙宝珠·毒攻击",2)
              延时(2000)
         elseif  string.find("逍遥|明教|", menpai) then
	         获取四象宝珠("青龙宝珠·火攻击","获取绿色青龙宝珠",1)
              延时(2000)
	         令牌镶嵌宝珠(令牌名称,"青龙宝珠·火攻击",2)
              延时(2000)
	     elseif  string.find("峨嵋|天山|武当|桃花岛", menpai) then
	         获取四象宝珠("青龙宝珠·冰攻击","获取绿色青龙宝珠",0)
              延时(2000)
	         令牌镶嵌宝珠(令牌名称,"青龙宝珠·冰攻击",2)
              延时(2000)
	     elseif  string.find("天龙|少林|鬼谷|慕容", menpai) then
		     获取四象宝珠("青龙宝珠·玄攻击","获取绿色青龙宝珠",2)
             延时(2000)
		     令牌镶嵌宝珠(令牌名称,"青龙宝珠·玄攻击",2)
            延时(2000)
         end
	 end 
 	 if tonumber(镶嵌位置)==3 then
	 获取四象宝珠("玄武宝珠·毒抗性","获取蓝色玄武宝珠",3)
	              延时(2000)
	 令牌镶嵌宝珠(令牌名称,"玄武宝珠·毒抗性",3)	
	              延时(2000)
	 end
	 if tonumber(镶嵌位置)==4 then
		
	 获取四象宝珠("白虎宝珠·命中","获取黄色白虎宝珠",4)
	              延时(2000)
	 令牌镶嵌宝珠(令牌名称,"白虎宝珠·命中",4)	
	              延时(2000)
	 end
	 延时(3000)
     装备令牌(令牌名称)
	 if tonumber(镶嵌位置)==-1 then
       return
	 end	
end	
end

function RsLevelUp(LPindex,toLevel)
	LUA_Call(string.format([[
	local g_RsLevelUp_NeedItem = 38000931
	
local g_RsLevelUp_NeedItem_Num = {
6,6,6,7,7,7,9,9,9,12,12,12,16,16,16,21,21,21,27,27,27,34,34,34,42,42,42,51,51,51,61,61,61,72,72,72,84,84,84,97,97,97,111,111,111,126,126,126,126
}
local m_EquipBagIndex=%d
local toLevel=%d
fo i=1,50  do
for nIndex=1,2 do
local uLevel = PlayerPackage:Lua_GetBagItemRl_RsLevel(m_EquipBagIndex , nIndex - 1)
if toLevel< uLevel then
	Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name( "RsLevelUp_RL" );
			Set_XSCRIPT_ScriptID( 880001 );
			Set_XSCRIPT_Parameter( 0, m_EquipBagIndex);         --- 装备背包索引
			Set_XSCRIPT_Parameter( 1, nIndex - 1);        --- 镶嵌的符石索引
			Set_XSCRIPT_ParamCount( 2 );
	Send_XSCRIPT();	
end
end
end
		]], LPindex,toLevel))	
end


function 令牌宝珠打造与升级()
--取出物品("翡翠心精|唤灵液")  
令牌名称=LUA_取返回值("return EnumAction(20,'equip'):GetName();")
if 获取背包物品数量("翡翠心精")>=50 then
进入帮会城市()
        寻路(44,47,1) 
	延时(5000) 
       if  取下令牌()==0 then                 --取下武器，if取下失败thenreturn
          LUA_Call("PushDebugMessage(\"取下令牌失败，放弃升阶!\")")
          return
      end
    for i=1,5 do
         if 对话NPC("孔相如")==1 then
              延时(3000)
              NPC二级对话("四象宝珠打造与升级") 
              延时(5000)
              右键使用物品(令牌名称,1)

              if 窗口是否出现("EquipLingPai_OperatingSJ")==1 and 获取背包物品数量("翡翠心精")>50  then
                   延时 (1000)
                   右键使用物品(令牌名称,1)
                   延时 (1000)
               for i=1,3 do
                   LUA_Call("setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnActionItemLClicked(1);")
                   延时 (1000)
                  LUA_Call("setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnOkClicked();")
                  LUA_Call("setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnOkClicked();")
                  LUA_Call("setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnOkClicked();")
                   延时 (1000)
                   LUA_Call("setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnActionItemLClicked(2);")
                  LUA_Call("setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnOkClicked();")
                  LUA_Call("setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnOkClicked();")
                  LUA_Call("setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnOkClicked();")
                   延时 (1000)
                   LUA_Call("setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnActionItemLClicked(3);")
                  LUA_Call("setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnOkClicked();")
                  LUA_Call("setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnOkClicked();")
                  LUA_Call("setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnOkClicked();")
                   延时 (1000)
                   LUA_Call("setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnActionItemLClicked(4);")
                  LUA_Call("setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnOkClicked();")
                  LUA_Call("setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnOkClicked();")
                  LUA_Call("setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnOkClicked();")
                end  
                   break
              end
         else 
              延时(1000)
         end
     end  
	 装备令牌(令牌名称)
end	
end

function 令牌星级提升()
令牌名称=LUA_取返回值("return EnumAction(20,'equip'):GetName();")
屏幕提示(令牌名称) 
	if 获取背包物品数量("唤灵液")>=1 then
		进入帮会城市()
        寻路(44,47,1) ;延时(3000);
       if  取下令牌()==0 then                 --取下武器，if取下失败thenreturn
          LUA_Call("PushDebugMessage(\"取下令牌失败，放弃升阶!\")")
          return
      end
    for i=1,5 do
         if 对话NPC("孔相如")==1 then
              延时(3000)
              NPC二级对话("令牌星级提升") 
              延时(5000)
              右键使用物品(令牌名称,1)

              if 窗口是否出现("EquipLingPai_Star")==1 and 获取背包物品数量("唤灵液")>=1  then
                   延时 (1000)
                   右键使用物品(令牌名称,1)
                   延时 (1000)
				
               for i=1,获取背包物品数量("唤灵液") do
                   LUA_Call("setmetatable(_G, {__index = EquipLingPai_Star_Env});EquipLingPai_Star_OnOkClicked();")
                   延时 (100)
                   LUA_Call("setmetatable(_G, {__index = EquipLingPai_Star_Env});EquipLingPai_Star_OnOkClicked();")
                   延时 (100)
                   LUA_Call("setmetatable(_G, {__index = EquipLingPai_Star_Env});EquipLingPai_Star_OnOkClicked();")
                   延时 (100)
                   LUA_Call("setmetatable(_G, {__index = EquipLingPai_Star_Env});EquipLingPai_Star_OnOkClicked();")
                end  
                   break
              end
         else 
              延时(1000)
         end
     end  
		 装备令牌(令牌名称)
end	
end




function 令牌扩张属性重铸()
	屏幕提示("令牌扩张属性重铸  需要取下装备判断") 
	if 获取背包物品数量("天荒晶石")>=1 then
		进入帮会城市()
        寻路(44,47,1) 
		延时(5000)
		屏幕提示("do令牌扩张属性重铸") 
	else
		return
	end
    local 令牌名称=LUA_取返回值("return EnumAction(20,'equip'):GetName();")
	延时(2000)
    if  取下令牌()==0 then
        屏幕提示("取下令牌失败，放弃令牌扩张属性重铸")
        return
    end
    LPindex=获取背包物品位置(令牌名称)-1
	屏幕提示(令牌名称..LPindex.."|开始令牌扩张属性重铸")
	for yyy=1,10 do
		LUA_Call(string.format([[
			LPindex=tonumber(%d)
			local nExAttrID111 , nExAttrStr111= PlayerPackage:Lua_GetBagRlExAttr(LPindex, 0)
			if string.find(nExAttrStr111,"maxhp") then
				aaa=1
			else
				aaa=0
			end
			local  nExAttrID222 , nExAttrStr222 = PlayerPackage:Lua_GetBagRlExAttr(LPindex, 1)
			if string.find(nExAttrStr222,"maxhp") then
				bbb=1
			else
				bbb=0
			end

			local  nExAttrID333 , nExAttrStr333 = PlayerPackage:Lua_GetBagRlExAttr(LPindex, 2)
			if string.find(nExAttrStr333,"maxhp") then
				ccc=1
			else
				ccc=0
			end

			PushDebugMessage(aaa..bbb..ccc)

			if aaa+bbb+ccc ==1 then
				PushDebugMessage("已经有1个血上限了需要天荒神石2个")
			elseif  aaa+bbb+ccc ==2 then
				PushDebugMessage("已经有2个血上限了需要天荒神石3个")
			elseif  aaa+bbb+ccc ==3 then
				PushDebugMessage("已经有3个血上限了无需再洗跳出循环")
				return
			end
			--开始重铸
			Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name("RlResetExAttr");
			Set_XSCRIPT_ScriptID(880001);
			Set_XSCRIPT_Parameter(0,LPindex);
			Set_XSCRIPT_Parameter(1,aaa);
			Set_XSCRIPT_Parameter(2,bbb);
			Set_XSCRIPT_Parameter(3,ccc);
			Set_XSCRIPT_Parameter(4,0);
			Set_XSCRIPT_ParamCount(5);
			Send_XSCRIPT();	
		]], LPindex))
		延时(2000)--增加延时等待服务器响应
	end
	装备令牌(令牌名称)
end



领取令牌()
令牌升阶()
令牌全自动镶嵌宝珠()
令牌星级提升()
令牌宝珠打造与升级()
--令牌扩张属性重铸() --指定3血上限
