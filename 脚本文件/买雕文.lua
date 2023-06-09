
function  购买雕纹(BDYB,LPname,DWname,shuliang)
     if BDYB == "绑定元宝" then
         LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();");延时(1500) -- 打开元宝商店
             LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);");延时(1500)--打开绑定元宝商店
                  LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);");延时(1500)--南北奇货
		 if LPname == "防具雕纹" then
             LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(3);");延时(1500)-- 防具雕纹店
                 if DWname == "手套体力雕纹" then
                     LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(18);");延时(1500) 
                         elseif DWname == "鞋子体力雕纹" then 
                             LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");延时(1500)
                                 LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(14);");延时(1500)
                                     elseif DWname == "腰带体力雕纹" then
                                         LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");延时(1500)
                                             LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");延时(1500)
                                                 LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(2);");延时(1500)
				 end 
		 elseif  LPname == "武具雕纹1" then
		     LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(4);");延时(1500)--	
				 if DWname == "武器冰攻雕纹" then
                    LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(3);");延时(1500) 
			             elseif DWname == "武器火攻雕纹" then
		                     LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(4);");延时(1500) 
			                     elseif DWname == "武器玄攻雕纹" then
                                     LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(5);");延时(1500) 
			                             elseif DWname == "武器毒攻雕纹" then
                                             LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(6);");延时(1500) 
				 
				 elseif DWname == "护腕冰攻雕纹" then
                    LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(17);");延时(1500) 
			             elseif DWname == "护腕火攻雕纹" then
		                     LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(18);");延时(1500) 
			                     elseif DWname == "护腕玄攻雕纹" then
								     LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");延时(1500)
                                         LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(1);");延时(1500) 
			                             elseif DWname == "护腕毒攻雕纹" then
										     LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");延时(1500)
                                                 LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(2);");延时(1500) 
									
		         end 
         elseif  LPname == "武具雕纹2" then
		     LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(5);");延时(1500)--
			     if DWname == "豪侠印体力雕纹" then
                     LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(1);");延时(1500) 
			             elseif DWname == "武魂体力雕纹" then
                             LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(14);");延时(1500)
			                     elseif DWname == "龙纹体力雕纹" then
				                     LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");延时(1500)
                                         LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(1);");延时(1500)
			                                 elseif DWname == "暗器体力雕纹" then
				                                 LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");延时(1500)
                                                     LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(10);");延时(1500)	
			     elseif DWname == "令牌冰攻雕纹" then
                     LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(10);");延时(1500) 
			             elseif DWname == "令牌火攻雕纹" then
                             LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(11);");延时(1500)
			                     elseif DWname == "令牌玄攻雕纹" then
                                     LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(12);");延时(1500)
			                             elseif DWname == "令牌毒攻雕纹" then
                                              LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(13);");延时(1500)	
			 	 elseif DWname == "暗器冰攻雕纹" then
			         LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");延时(1500)
                         LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(6);");延时(1500) 
			                 elseif DWname == "暗器火攻雕纹" then			
                                 LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");延时(1500)
                                     LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(7);");延时(1500) 
			                             elseif DWname == "暗器玄攻雕纹" then
			                                 LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");延时(1500)
                                                 LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(8);");延时(1500) 
			                                         elseif DWname == "暗器毒攻雕纹" then
			                                             LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");延时(1500)
                                                             LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(9);");延时(1500) 
			     elseif DWname == "项链冰攻雕纹" then
			         LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");延时(1500)
                         LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(12);");延时(1500) 
			                 elseif DWname == "项链火攻雕纹" then
			                     LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");延时(1500)
                                     LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(13);");延时(1500) 
			                             elseif DWname == "项链玄攻雕纹" then
			                                 LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");延时(1500)
                                                 LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(14);");延时(1500) 
			                                         elseif DWname == "项链毒攻雕纹" then
			                                             LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");延时(1500)
                                                             LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(15);");延时(1500) 
				 end 
		 end 
	 end 
end 
购买雕纹("绑定元宝","防具雕纹","手套体力雕纹")

	if tonumber (获取人物信息(55)+获取人物信息(62)) < 410 then
	 屏幕提示("您的绑定元宝和红利不足")
         return
end
     取出物品("金币")
if tonumber (获取人物信息(45)) < 500000 then
	 屏幕提示("您的金币不足")
	 return
end
防具雕纹店             setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(3);
武具雕纹店             setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(4);
雕纹加工坊             setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(5);

绑定元宝
元宝商城打开界面       setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();
元宝商城关闭界面       setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_Close();
元宝商店               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(0);
绑定元宝商店           setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);
手套体力雕纹 18 鞋子32  腰带38


         LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();");延时(1500) -- 打开元宝商店
             LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);");延时(1500)--打开绑定元宝商店
                  LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);");延时(1500)--南北奇货
             LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(3);");延时(1500)-- 防具雕纹店
LUA_Call(string.format([[
setmetatable(_G, {__index = MiniMap_Env});
MiniMap_YuanBaoFunc();延时(1000);

setmetatable(_G, {__index = YuanbaoShop_Env});
YuanbaoShop_ChangeTabIndex(1);延时(1000);

setmetatable(_G, {__index = YuanbaoShop_Env});
YuanbaoShop_UpdateList_Bind(4);延时(1000);

setmetatable(_G, {__index = YuanbaoShop_Env});
YuanbaoShop_UpdateShop_Bind(3);
	    
]]))
		 elseif  LPname == "雕纹加工坊" then
		     LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(6);");延时(1500)--
			    for i = 1,
				
				
	
		         end 
end 
end 
购买雕纹(鞋子体力雕纹)
LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_Close();")

 setmetatable(_G, {__index = YuanbaoShop_Env});
					 YuanbaoShop_Close();
					
	例子：1，打开元宝商店 2，选择绑定元宝商店 3，选择珍兽商城 4，购买珍兽滋补丹 5，关闭元宝商店
LUA调用 ("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
等待 (2)
LUA调用 ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
等待 (2)
LUA调用 ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(3);")
等待 (2)
LUA调用 ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(3);")
等待 (2)
LUA调用 ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_Close();")
等待 (2)
信息框 ("LUA脚本演示完毕，关闭信息框自动停止脚本", "", 取角色名称 ())
脚本停止 ()				
					
setmetatable(_G, {__index = MiniMap_Env});
MiniMap_YuanBaoFunc();"

setmetatable(_G, {__index = YuanbaoShop_Env});
YuanbaoShop_ChangeTabIndex(1);

setmetatable(_G, {__index = YuanbaoShop_Env});
YuanbaoShop_UpdateList_Bind(4);

setmetatable(_G, {__index = YuanbaoShop_Env});
YuanbaoShop_UpdateShop_Bind(3);
setmetatable(_G, {__index = YuanbaoShop_Env});
YuanbaoShop_GoodButton_Clicked(4);
			陆续增加中......

LUA调用 ("LUA文本")
    参数：文本型 LUA文本
  返回值：无


LUA调用("setmetatable(_G, {__index = PetEquipSuitUp_Env});PetEquipSuitUp_Buttons_Clicked();")//提升宠物星级 提升星级

LUA调用("setmetatable(_G, {__index = ConfraternitySkillsStudy_Env});Guild_Ability_LevelUp_Click();")//帮会生活技能升级按钮

LUA调用 ("setmetatable(_G, {__index = Bhls_Prize_Env});Bhls_Prize_Ok_Clicked();")//大区赛每周领取奖励按钮

LUA调用 ("setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();")//确定按钮
LUA调用 ("setmetatable(_G, {__index = ZhenYuanNingLian_Env});ZYNL_NingLian_Click();")//凝元
LUA调用 ("setmetatable(_G, {__index = ZhenYuanNingLian_Env});ZYNL_AllNingLian_Click();")//开启一键凝元
LUA调用 ("setmetatable(_G, {__index = XiulianStudy_Env});XiulianStudy_UpJingJie_Clicked();")//提升境界

战功商店
LUA调用 ("setmetatable(_G, {__index = JueweiShop_Env});JueweiShop_BuyItem(0);")//第1件物品
LUA调用 ("setmetatable(_G, {__index = JueweiShop_Env});JueweiShop_BuyItem(1);")//第2件物品....以此类推
LUA调用 ("setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();")//购买确认


例子：1，打开领取每日活跃好礼界面 2，点击1点今日活跃值宝箱 3，关闭领取每日活跃好礼界面
LUA调用 ("setmetatable(_G, {__index = PlayerQuicklyEnter_Env});PlayerQuicklyEnter_Clicked(6);")
等待 (2)
LUA调用 ("setmetatable(_G, {__index = Huoyuehaoli_Env});Huoyuehaoli_PlayHead(1);")
等待 (2)
LUA调用 ("setmetatable(_G, {__index = Huoyuehaoli_Env});Huoyuehaoli_Hide();")
等待 (2)

例子：1打开VIP特权激活界面 2，点击确定激活VIP特权 3，关闭界面
LUA调用 ("setmetatable(_G, {__index = PlayerQuicklyEnter_Env});PlayerQuicklyEnter_Clicked(5);")
等待 (2)
LUA调用 ("setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();")
等待 (2)
LUA调用 ("setmetatable(_G, {__index = VIP_Shop_Env});VIP_Shop_Close();")
信息框 ("VIP特权功能激活完毕", "", 取角色名称 ())
脚本停止 ()

例子：1，打开元宝商店 2，选择绑定元宝商店 3，选择珍兽商城 4，购买珍兽滋补丹 5，关闭元宝商店
LUA调用 ("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
等待 (2)
LUA调用 ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
等待 (2)
LUA调用 ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(3);")
等待 (2)
LUA调用 ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(3);")
等待 (2)
LUA调用 ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_Close();")
等待 (2)
信息框 ("LUA脚本演示完毕，关闭信息框自动停止脚本", "", 取角色名称 ())
脚本停止 ()

例子：1，打开元宝商店 2，选择绑定元宝商店 3，选择南北奇货 4，选择仙丹灵药 5，购买金丹葫芦 6，关闭元宝商店
LUA调用 ("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
等待 (2)
LUA调用 ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
等待 (2)
LUA调用 ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
等待 (2)
LUA调用 ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(1);")
等待 (2)
LUA调用 ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(4);")
等待 (2)
LUA调用 ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_Close();")
等待 (2)
信息框 ("LUA脚本演示完毕，关闭信息框自动停止脚本", "", 取角色名称 ())
脚本停止 ()

打开领取每日活跃好礼   setmetatable(_G, {__index = PlayerQuicklyEnter_Env});PlayerQuicklyEnter_Clicked(5);
关闭领取每日活跃好礼   setmetatable(_G, {__index = Huoyuehaoli_Env});Huoyuehaoli_Hide();
领取每日活跃好礼一     setmetatable(_G, {__index = Huoyuehaoli_Env});Huoyuehaoli_PlayHead(1);
领取每日活跃好礼二     setmetatable(_G, {__index = Huoyuehaoli_Env});Huoyuehaoli_PlayHead(2);
领取每日活跃好礼三     setmetatable(_G, {__index = Huoyuehaoli_Env});Huoyuehaoli_PlayHead(3);
领取每日活跃好礼四     setmetatable(_G, {__index = Huoyuehaoli_Env});Huoyuehaoli_PlayHead(4);

打开领取每周活跃好礼   setmetatable(_G, {__index = PlayerQuicklyEnter_Env});PlayerQuicklyEnter_Clicked(6);
关闭领取每周活跃好礼   setmetatable(_G, {__index = Weekhuoyuehaoli_Env});Weekhuoyuehaoli_Hide();
领取每周活跃好礼一     setmetatable(_G, {__index = Weekhuoyuehaoli_Env});Weekhuoyuehaoli_PlayHead(1);
领取每周活跃好礼二     setmetatable(_G, {__index = Weekhuoyuehaoli_Env});Weekhuoyuehaoli_PlayHead(2);
领取每周活跃好礼三     setmetatable(_G, {__index = Weekhuoyuehaoli_Env});Weekhuoyuehaoli_PlayHead(3);

离火炼炉转运           setmetatable(_G, {__index = TheFireStove_Env});TheFireStove_FireButton_OnClick();
离火炼炉取石           setmetatable(_G, {__index = TheFireStove_Env});TheFireStove_StoneButton_OnClick();


元宝商城打开界面       setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();
元宝商城关闭界面       setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_Close();
元宝商店               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(0);
绑定元宝商店           setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);
炫装商城               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(2);
返卷商店               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(3);
至尊商店               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(4);
红利商店               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);

元宝商店分类：
大卖场                 setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(1);
宝石商城               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(2);
珍兽商城               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(3);
南北奇货               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);
形象广场               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(5);
花舞人间               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(6);
武功秘籍               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(7);
打造图                 setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(8);

元宝商店打造图分类：
刀斧和枪棒             setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(1);
单短和双短             setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(2);
购买第一个打造图       setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(1);
购买第二个打造图       setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(2);


绑定元宝商店分类：
大卖场                 setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(1);
宝石商城               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(2);
珍兽商城               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(3);
南北奇货               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);

绑定元宝商店-南北奇货分类：(元宝商店的分类和这个同样字符)
仙丹灵药               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(1);
奇珍异宝               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(2);
防具雕纹店             setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(3);
武具雕纹店             setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(4);
雕纹加工坊             setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(5);

绑定元宝商店-珍兽商城-购买物品：（序号从1开始，可能以后会更新序号）
地灵丹                 setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(1);
小灵丹                 setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(2);
珍兽滋补丹             setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(3);
珍兽回春丹             setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(4);
珍兽延年丹             setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(5);

绑定元宝商店-南北奇货-仙丹灵药-购买物品：（序号从1开始，可能以后会更新序号）
天灵丹                 setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(1);
小洗髓丹               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(2);
大洗髓丹               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(3);
金丹葫芦               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(4);
玉液净瓶               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(5);
仙丹葫芦               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(6);
仙露净瓶               setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(7);

商店后一页             setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();

红利商店：购买方法和其他购买方法一样
红利大卖场             setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(1);
红利宝石店             setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(2);
红利珍兽店             setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(3);
红利奇货店             setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);


		