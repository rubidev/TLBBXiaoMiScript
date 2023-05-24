function 查询珍兽成长率(珍兽名称)
屏幕提示("珍兽查询成长率:"..珍兽名称)
       LUA_Call(string.format([[
	for i=0, 9 do
		if Pet:IsPresent(i) then
					local Petchengzhanglv = Pet : GetGrowRate(i);
                     local PetName=Pet:GetName(i)

                      if PetName==PetDoName then
						if tonumber(Petchengzhanglv) < 500 then
								local hid,lid = Pet:GetGUID(i);
								PushDebugMessage("资质鉴定珍兽成长:"..PetName)
                             Clear_XSCRIPT();
                             Set_XSCRIPT_Function_Name("OnInquiryForGrowRate");
                             Set_XSCRIPT_ScriptID(1050);
                             Set_XSCRIPT_Parameter(0,hid);
                             Set_XSCRIPT_Parameter(1,lid);
                             Set_XSCRIPT_ParamCount(2);
                             Send_XSCRIPT();   
					end
			end
         end
	end	
	]], 珍兽名称))
end

function 珍兽还童(珍兽名称,材料)
		材料位置=获取背包物品位置(材料)-1
       LUA_Call(string.format([[
	
                      local  PetDoName ="%s"
			local nPetCount = Pet : GetPet_Count()
                    -- PushDebugMessage("当前珍兽数量:"..nPetCount )
for i=0, 9 do
		if Pet:IsPresent(i) then
			    local Petchengzhanglv = Pet : GetGrowRate(i);
                             local PetName=Pet:GetName(i)
                 --PushDebugMessage(Petchengzhanglv)
                      if PetName==PetDoName then
							Pet : SkillStudy_Do(2, i, %d)
                      end
					end
	end	
	]], 珍兽名称,材料位置))
end	


--查询珍兽成长率


function 查询所有珍兽成长率()
屏幕提示("查询所有珍兽成长率")
       LUA_Call(string.format([[

for i=0, 9 do
		if Pet:IsPresent(i) then
			    local Petchengzhanglv = Pet : GetGrowRate(i);
                             local PetName=Pet:GetName(i)
                 --PushDebugMessage(Petchengzhanglv)
    
			if tonumber(Petchengzhanglv) < 500 then
                             local hid,lid = Pet:GetGUID(i);
                              PushDebugMessage("资质鉴定珍兽成长:"..PetName)
                             Clear_XSCRIPT();
                             Set_XSCRIPT_Function_Name("OnInquiryForGrowRate");
                             Set_XSCRIPT_ScriptID(1050);
                             Set_XSCRIPT_Parameter(0,hid);
                             Set_XSCRIPT_Parameter(1,lid);
                             Set_XSCRIPT_ParamCount(2);
                             Send_XSCRIPT();   
			end
		end
	end	
	]]))
end






function 放生珍兽(aaaa,bbbb)
local nIndex =  LUA_取返回值(string.format([[

for i=0, 9 do
		if Pet:IsPresent(i) then
    local strName=Pet:GetName(i)
PushDebugMessage(strName)
--成长率
local strTbl = {"普通","优秀","杰出","卓越","完美"};
local Petchengzhanglv = Pet : GetGrowRate(i);
local nGrowLevel = Pet : GetPetGrowLevel(i,tonumber(Petchengzhanglv));
if(nGrowLevel >= 0) then
  nGrowLevel = nGrowLevel + 1;
nGrowLevelname=strTbl[nGrowLevel]
else
nGrowLevelname="未知"
Petchengzhanglv=""
end
--PushDebugMessage(nGrowLevel..nGrowLevelname..strName)
if strName == "%s" and nGrowLevel<= tonumber(%d) then
                  PushDebugMessage("放生珍兽:"..strName.."|成长率"..nGrowLevelname)
                   Pet : Go_Free(i)
end
end
end
        return -1
]], aaaa,bbbb), "n")
return nIndex
end




function 还童珍兽(aaaa,bbbb,材料)
	if 获取背包物品数量(材料)<=0 then
		return -1
	end
	材料位置=获取背包物品位置(材料)-1
	local nIndex =  LUA_取返回值(string.format([[


		for i=0, 10-1 do
		if Pet:IsPresent(i) then
			local strName=Pet:GetName(i)
		--PushDebugMessage(strName)
		--成长率
		local strTbl = {"普通","优秀","杰出","卓越","完美"};
		local Petchengzhanglv = Pet : GetGrowRate(i);
		local nGrowLevel = Pet : GetPetGrowLevel(i,tonumber(Petchengzhanglv));
		if(nGrowLevel >= 0) then
		  nGrowLevel = nGrowLevel + 1;
		nGrowLevelname=strTbl[nGrowLevel]
		else
		nGrowLevelname="未知"
		Petchengzhanglv=""
		end
		--PushDebugMessage(nGrowLevel..nGrowLevelname..strName)
		if strName == "%s" and nGrowLevel < tonumber(%d) then
						  PushDebugMessage("放生珍兽:"..strName.."|成长率        "..nGrowLevelname)
						   Pet : SkillStudy_Do(2, i, %d)
			end
		end
		end
				return -1
	]], aaaa,bbbb,材料位置), "n")
	return nIndex
end




function 自动还童珍兽(aaaa,bbbb,材料)
	for i=1,9999 do
		取出物品("金币")	
		跨图寻路("洛阳",275,297)
		查询所有珍兽成长率()
		延时(700)
		if 还童珍兽(aaaa,bbbb,材料)== -1 then
			break
		end	
		延时(500)
	end
end
--以上程序不要乱动

--以下程序只修改宝宝名称和还童卷轴名称
自动还童珍兽("年兽宝宝",5,"珍兽还童卷轴")




