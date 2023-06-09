	
BOSS名字="九黎战士"
宝宝名字 ="晴天"
--------------------------------------------------------------------	
	
	
	
人物名称,门派,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()
function 晴天_友情提示(text,...)
	local strCode = string.format(text,...)
	LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		DebugListBox_ListBox:AddInfo("#e0000ff#u#g28f1ff".."【晴天友情提示】%s")	--
		--橙色 #e0000ff#u#g0ceff3
		--蓝色 #e0000ff#u#g28f1ff
	]], strCode))
end

-------------------------------------------------------------------------------------------------------

function 召唤宝宝(nIndex)
LUA_Call(string.format([[
          Pet : Go_Fight(%d)		
		]], nIndex), "n");
end

function GetPetIndexbyName(petName)
  local tem= LUA_取返回值(string.format([[
		    local nPetCount = Pet : GetPet_Count();
		    if nPetCount == 0  then
			   return -1
			end
			for k = 0, nPetCount - 1 do
			    local strName,strName2 = Pet:GetName(k)
				if string.find("%s", strName) then
				   return k;
				end
			end			
			return -1			
		]], petName), "n");
	return tonumber(tem)
		
end

function 晴天_检测召唤宝宝(宝宝名字)
if tonumber(获取人物信息(18))<=0  then
	ind = tonumber(GetPetIndexbyName(宝宝名字))
	if ind >=0 then
     召唤宝宝(ind)
      延时(3000)
	else
	屏幕提示("没有这个宝宝"..宝宝名字)
	end
end
end

function Pet_GetHP(nIndex)
     return LUA_取返回值(string.format([[
	            
	            local nIndex = %d
				local intTemp = Pet : GetHP(nIndex)
				local intTemp2 = Pet: GetMaxHP(nIndex)	
                local HP_Percent = intTemp/intTemp2*100			
	            return HP_Percent
	 ]], nIndex), "n")   
end


function Pet_GetHappy(nIndex)
     return LUA_取返回值(string.format("return Pet : GetHappy(%d)", nIndex), "n")
end

function 晴天_获取组队编号()
	人物名称,门派1,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()
	for i=1,6 do
		名称,等级,门派,血量,地图,X坐标,Y坐标=组队_获取队员信息(i)
		if 人物名称== 名称 then
			return i
		end
	end
	return-1
end

function 晴天_检测宝宝加血加快乐(宝宝名字)
local index = tonumber(GetPetIndexbyName(宝宝名字))
	if index >=0 and index ~= nil then
	   if tonumber(Pet_GetHP(index)) <=90 then
		屏幕提示(宝宝名字.."血量少于百分之90自动喂养")
			LUA_Call(string.format([[
          Pet:Feed(%d)		
		]], index), "n");
	end
	if tonumber(Pet_GetHappy(index)) <=90 then
		if  tonumber(Pet_GetHappy(index)) <=60 then
						LUA_Call(string.format([[
          Pet:Feed(%d)		
		]], index), "n");
		end
		屏幕提示(宝宝名字.."快乐少于百分之90自动喂养")
		LUA_Call(string.format([[
          Pet:Dome(%d)		
		]], index), "n");
		延时(200)
	end
end
end

function 晴天_使用土灵珠定位()
	if 获取背包物品数量("土灵珠") > 0 then
		坐骑_下坐骑();延时(1000)
		坐骑_下坐骑();延时(1000)
		右键使用物品("土灵珠",1);延时(3000)
		if 窗口是否出现("Item_TuDunZhu")==1 then
			坐骑_下坐骑();延时(1000)
			LUA_Call("setmetatable(_G, {__index = Item_TuDunZhu_Env});Item_TuDunZhu_Cancel_Clicked(1);") ;延时(3000)
			--LUA_Call("setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();") ;延时(3000)
			--LUA_Call("setmetatable(_G, {__index = Item_TuDunZhu_Env});this:Hide()") ;延时(3000)
			end
		延时(6000)
	end	
end

------------------------------------------------------------------------------------------------------------
function 晴天_更换模式(模式)
	if 模式=="和平" then
		LUA_取返回值("Player:ChangePVPMode(0);","",0);
	elseif 模式=="个人" then
		LUA_取返回值("Player:ChangePVPMode(1);","",0);
	elseif 模式=="组队" then
		LUA_取返回值("Player:ChangePVPMode(3);","",0);
	elseif 模式=="帮会" then
		LUA_取返回值("Player:ChangePVPMode(4);","",0);
	elseif 模式=="善恶" then
		LUA_取返回值("Player:ChangePVPMode(2);","",0);
	end
end
----------------------------------------------------------------------------------------------------------------
function 晴天_凤鸣镇恢复()
	跨图寻路("凤鸣镇",123,172)
	对话NPC("尉迟良飞");延时(3000)       
	NPC二级对话("满状态治疗");延时(3000)       		
	NPC二级对话("是");延时(3000)       
	对话NPC("尉迟良飞");延时(3000)       
	NPC二级对话("给珍兽恢复气血");延时(3000)       		
	NPC二级对话("好的");延时(3000)       
end



function 晴天_使用珍兽技能(位置)   --神佑1 
	if 到数值(获取人物信息(18))~=0 then
		if 位置==1 then
			LUA_Call("MainMenuBar_3_Clicked(1)")
		elseif 位置==2 then
			LUA_Call("MainMenuBar_3_Clicked(2)")
		end
	end
end


function 晴天_使用技能(门派,技能名称,目标ID)
	if 门派=="逍遥" then
		if tonumber(判断技能冷却(技能名称))==1 then
			技能ID=获取技能ID(技能名称)
			使用技能(技能ID,目标ID);延时(500) 
		end

	elseif 门派=="鬼谷" then
		if tonumber(判断技能冷却(技能名称))==1 then
			技能ID=获取技能ID(技能名称)
			使用技能(技能ID,目标ID);延时(500) 
		end
		
	elseif 门派=="鬼谷" then
		if tonumber(判断技能冷却(技能名称))==1 then
			技能ID=获取技能ID(技能名称)
			使用技能(技能ID,目标ID);延时(500) 
		end		
		
	elseif 门派=="唐门" then
		if tonumber(判断技能冷却(技能名称))==1 then
			技能ID=获取技能ID(技能名称)
			使用技能(技能ID,目标ID);延时(500) 
		end		
		
	elseif 门派=="桃花岛" then
		if tonumber(判断技能冷却(技能名称))==1 then
			技能ID=获取技能ID(技能名称)
			使用技能(技能ID,目标ID);延时(500) 
		end				
	end
end

function 晴天_技能组攻击(目标ID)
	晴天_使用技能("逍遥","溪山行旅",目标ID);
	晴天_使用技能("逍遥","弹指神功",目标ID);	
	晴天_使用技能("逍遥","潇湘夜雨",目标ID);	
	晴天_使用技能("星宿","天地同寿",目标ID);
	晴天_使用技能("星宿","一日丧命散",目标ID);
	晴天_使用技能("唐门","万箭齐发",目标ID);
	晴天_使用技能("桃花岛","人之可诛",目标ID);
	晴天_使用技能("峨媚","拖泥带水",目标ID);
	晴天_使用技能("鬼谷","太上忘情",目标ID);
end

--使用物品("土灵珠")

function 服务器时间()
	local curTime = LUA_取返回值([[local curTime = DataPool:GetServerMinuteTime();
		    local temp = math.floor(curTime/10000)
    local curHour = math.mod(temp, 100)
    temp = math.mod(curTime, 10000)
    local curMin = math.floor(temp/100)
	str=tostring(curHour)..":"..tostring(curMin)
	return  str
	]], "s", 1)
   local cursec=string.sub(LUA_取返回值("return DataPool:GetServerMinuteTime();", "n", 1),7,-1)  
   local curmiao=string.sub(LUA_取返回值("return DataPool:GetServerMinuteTime();", "n", 1),5,-1)  
   str=tostring(curTime)..":"..cursec..curmiao
return  str
end

-----------------------------------------------------------------------------------------------
晴天_检测宝宝加血加快乐(宝宝名字)
晴天_检测召唤宝宝(宝宝名字)
执行功能("同步游戏时间")

晴天_友情提示(服务器时间())
跨图寻路("玄海",141,210)
坐骑_下坐骑()

	倒计时开始时间 = os.time()
	while true do
		快速怪物ID=遍历周围怪物(1,BOSS名字,15.5)
		while 快速怪物ID> 0 do
			晴天_技能组攻击(快速怪物ID);
			攻击怪物(快速怪物ID);
			local 怪物名称,怪物ID,物品X坐标,物品Y坐标,目标血量,物品距离,物品类别,物品归属,怪物判断,头顶标注=遍历周围物品(4,BOSS名字,15.5,ID顾虑,模糊名称,名称过滤)
			 if 怪物ID == 快速怪物ID  then
				if  tonumber(目标血量) > 0 then
					攻击怪物(快速怪物ID);
					else
					自动捡包();
					延时(500);
					break
				end
			end
			延时(200);
			自动捡包();
		end
		
		
       
		if string.find("23:26:57|",服务器时间()) then
				晴天_使用珍兽技能(2)
			end
	if string.find("23:26:57|16:4:57|16:9:57|16:14:57|16:19:57|19:59:57|20:4:57|20:9:57|20:14:57|20:19:57",服务器时间()) then
		晴天_更换模式("组队")
		if 门派=="逍遥" then
				晴天_友情提示("惊涛骇浪")
				惊涛骇浪技能ID=获取技能ID("惊涛骇浪")
				使用技能(惊涛骇浪技能ID)
			end
			if 门派=="峨嵋" then
				晴天_友情提示("月落西山")
				月落西山技能ID=获取技能ID("月落西山")
				使用技能(月落西山技能ID)
			end
			if 门派=="武当" then
				晴天_友情提示("七星聚首")
				七星聚首技能ID=获取技能ID("七星聚首")
				使用技能(七星聚首技能ID)
			end
			if 门派=="丐帮" then	
				晴天_友情提示("横扫乾坤")
				横扫乾坤技能ID=获取技能ID("横扫乾坤")
				使用技能(横扫乾坤技能ID)
			end
			if 门派=="唐门" then	
				万剑齐发技能ID=获取技能ID("万剑齐发")
				使用技能(万剑齐发技能ID)
			end
			if 门派=="天龙" then	
				三阳开泰技能ID=获取技能ID("三阳开泰")
				使用技能(三阳开泰技能ID)
			end
	end
			
			if string.find("23:26:57|16:4:57|16:9:57|16:14:57|16:19:57|19:59:57|20:4:57|20:9:57|20:14:57|20:19:57",服务器时间()) then
				晴天_使用珍兽技能(2)
			end
		
		倒计时=tonumber(os.time() - 倒计时开始时间)
		晴天_友情提示("晴天打boss计时:"..倒计时.."|总共300秒跳出任务...等待设定时间-查看背包是否有定位做飞机")
		if  倒计时 > 300 then 
			自动捡包();延时(500)
			晴天_友情提示("九黎BOSS时间到啦,回凤鸣镇")
			break
		end
		延时(200);
    end
	
晴天_更换模式("和平")
晴天_凤鸣镇恢复()


	
