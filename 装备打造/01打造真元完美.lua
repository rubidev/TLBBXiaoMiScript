执行功能("[脚本]晴天函数库")
人物等级=tonumber(获取人物信息(26))
if 人物等级<80 then
	return
end

function 晴天_取真元盘眼数量()
	local tem =LUA_取返回值(string.format([[	
			local ZhenYuanActivation_MF={589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600}
			local index = 0
			for i = 1,table.getn(ZhenYuanActivation_MF) do
				if Pneuma:GetMF(ZhenYuanActivation_MF[i]) == 1 then
					index = index + 1
				end
			end
			return index
				]]))		
	return tonumber(tem)		
end

function 全自动启封真元盘眼(index)
	if not index then
		index = 12 
	end
		
	local 开启的数量 =晴天_取真元盘眼数量()
	if 开启的数量 >=index then
		屏幕提示("真元已经开了"..开启的数量)
		延时(2000)
		return
	end	
	跨图寻路("苏州",350,228)
	for i =1,index do
	 local tem =LUA_取返回值(string.format([[
			local ZhenYuanActivation_MF={589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600}
			local ZhenYuanActivation_Mid = 1602
			local ZhenYuanActivation_JiaoZi={
			10,
			15,
			20,
			25,
			30,
			35,
			40,
			45,
			50,
			56,
			61,
			66,
			0,
			}
				function ZhenYuanActivation_GetActiveCount()
					local ac = 0
					for i = 1,table.getn(ZhenYuanActivation_MF) do
						if Pneuma:GetMF(ZhenYuanActivation_MF[i]) == 1 then
							ac = ac + 1
						end
					end
					return ac
				end
				local shuliang =  ZhenYuanActivation_GetActiveCount()
				PushDebugMessage("已经开封全部真元盘眼数量:"..shuliang)
				if shuliang>=12 then
					PushDebugMessage("[晴天] 已经开封全部真元盘眼")
					return 1
				end
				jtt=%d
				local nActive = ZhenYuanActivation_GetActiveCount()
				local needjiaozi = ZhenYuanActivation_JiaoZi[nActive+1]*10000
				PushDebugMessage(needjiaozi)
				local needChip = nActive*30
				if nActive==12 then
					needChip=0
				end
				if Pneuma:GetPneumaChip() < needChip then
					return 2
				end
				if tonumber(DataPool:GetLeftProtectTime()) > 0 then --安全事件
					PushDebugMessage("#{ZYXT_120528_16}")
					return  5
				end
				local playerMoneyPlusJZ = Player:GetData("MONEY_JZ") + Player:GetData("MONEY")
				 if playerMoneyPlusJZ < needjiaozi then
					return 3
				end
				if (Pneuma:GetMF(ZhenYuanActivation_MF[jtt]) ~= 1) then
						Clear_XSCRIPT();
						Set_XSCRIPT_Function_Name("OnActivePneumaSlot");
						Set_XSCRIPT_ScriptID(889903);
						Set_XSCRIPT_Parameter(0,jtt);
						Set_XSCRIPT_ParamCount(1);
						Send_XSCRIPT();
						return 5
				end
	
				]], i), "n",1)
				tem =tonumber(tem)
				if tem == 1 then
					屏幕提示("已经满了")
					return
				elseif tem ==2 then
					屏幕提示("金源不足")
					return
				elseif tem ==3 then
					屏幕提示("金币不足")
					return	
				end
				延时(2000)
		end
end




function 晴天_全自动装备真元()
	for AAA =1,12 do
		local tem =  LUA_取返回值(string.format([[ 
		AAA=%d
		local ZhenYuanActivation_MF={589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600}
		if (Pneuma:GetMF(ZhenYuanActivation_MF[AAA]) ~= 1) then
			PushDebugMessage(AAA.."没有开盘")
			return -1
		end	
		local szName, nLevel, szAdd, nAdd,nNextAdd=Pneuma:GetPneumaAddingInfo(AAA-1)
		if szName =="" then 
			return 1
		end
		return -1
		]],AAA))
		if tonumber(tem)>=1 then
			LUA_取返回值(string.format([[ 
			for k=36,59 do
				local szName, nLevel, szAdd, nAdd,nNextAdd=Pneuma:GetPneumaAddingInfo(k)
				if szName ~="" then 
					PushDebugMessage(szName.."装备在位置:"..AAA)
					SetZhenYuan(%d,k-35)
					return 
				end
			end
			]],AAA))
			延时(1500)
		end
	end
end	


function 晴天_取背包真元数量()
			local tem =LUA_取返回值(string.format([[ 
			n= 0
			for k=36,59 do
				local szName, nLevel, szAdd, nAdd,nNextAdd=Pneuma:GetPneumaAddingInfo(k)
				if szName ~="" then 
					if string.find(szName,"#ccc33cc") then 
						n=n+1 
					end
				end
			end
			return n
			]],AAA))
	return tonumber(tem)
end	


function 晴天_批量使用物品(AAA)
local t={}
for w in string.gmatch(AAA,"([^'|']+)") do        
	table.insert(t,w)
end

for k,v in ipairs(t) do
	if 获取背包物品数量(v)>=1 then
		晴天_友情提示(k..":"..v) 
		右键使用物品(v);延时(1000)
		晴天_窗口确定()		
		延时(1000)
	end
end
end

function 晴天_取出物品右键使用(物品列表)
	取出物品(物品列表)
	晴天_批量使用物品(物品列表)
end

function 晴天_漼解炉(物品列表)

for i=36,59 do
	LUA_Call(string.format([[	
 i=%d
local szName, nLevel, szAdd, nAdd, nNextAdd=Pneuma:GetPneumaAddingInfo(i)
if szName~="" and szName~=nil then
	if string.find("%s",szName) then
		PushDebugMessage("漼解"..szName)
		Pneuma:SmeltPneumaItem(i)
	end
end
	]],i ,物品列表))
	延时(20)
	end
end

--#ccc33cc 紫色
--#c00D000 绿色
--#c2980FF 蓝色 
--#cFFFFFF 白色
--前面的是颜色要加进去

真元集合="|真元·紫血符|真元·紫冰符|真元·紫火符|真元·紫玄符|真元·紫毒符|真元·紫体符|真元·紫御符|真元·紫准符|真元·紫劲符|真元·紫灵符|真元·紫敏符|真元·紫韧符|真元·紫坚符|真元·紫力符|真元·紫暴符|真元·紫定符|真元·紫气符|真元·紫罡符|真元·紫闪符|紫色真元符集|无相秘钥|无相宝匣|"


晴天_取出物品右键使用(真元集合)

for i =1,12 do
	local 真元眼数量 =晴天_取真元盘眼数量()
	if 真元眼数量 < 12 then 
		if 晴天_取背包真元数量()>0 then 	
			取出物品("金币")
			全自动启封真元盘眼(真元眼数量+1)
			晴天_全自动装备真元()
		end
	end
end

--执行功能("[脚本]036接收交易")


存物品("金币")
