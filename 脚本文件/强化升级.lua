
LUA_Call("setmetatable(_G, {__index =EquipStrengthen_Env});EquipStrengthen_Buttons_Close();")

取出物品("天罡强化精华")  

if 获取背包物品数量("天罡强化精华")>0 then
跨图寻路("洛阳",306,290)
延时(500)
令牌名称=LUA_取返回值("return EnumAction(20,'equip'):GetName();")
延时(500)
屏幕提示(令牌名称) 
LUA_Call("MainMenuBar_SelfEquip_Clicked();")
延时(500)
LUA_Call("SelfEquip_Equip_Click(16,0);")
    计次循环 i=1,5 执行
         如果 对话NPC("风胡子")==1 则
              延时(3000)
              NPC二级对话("装备强化") 
              延时(3000)
              NPC二级对话("使用强化道具强化装备") 
              延时(3000)
              如果 窗口是否出现("EquipStrengthen")==1 and 获取背包物品数量("天罡强化精华")>=1  则
                   延时 (1000)
                   右键使用物品(令牌名称,1)
                   延时 (1000)
               计次循环 i=1,5 执行
                   LUA_Call("setmetatable(_G, {__index = EquipStrengthen_Env});EquipStrengthen_Buttons_Clicked();")
                   延时 (100)
                结束  
                   跳出循环
              结束
         否则 
              延时(1000)
         结束
     结束  
end	




计次循环 i=1,5 执行
         如果 窗口是否出现("EquipStrengthen") ==1 则 
              LUA_Call("setmetatable(_G, {__index =EquipStrengthen_Env});EquipStrengthen_OnCloseClicked();")
         否则
              跨图寻路("洛阳",346,248)    --跑开让窗口自动关闭
              延时(1000)
              右键使用物品(令牌名称,1)    --参数2:为使用次数
         结束
         延时(1000)
         如果 到数值(LUA_取返回值("return EnumAction(20,'equip'):GetID();"))>0 则  --装备成功
              跳出循环   
         结束
结束	

