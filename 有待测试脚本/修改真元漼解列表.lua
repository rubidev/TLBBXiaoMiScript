目标名字关键字 = {}
-- 目标名字关键字 = { "至尊", "君临", "异界侠士"}

杀死敌人秒数 = 5

遍历速度 = 110 -- 尽量不改, 越小越快, 小于110容易掉线, 但是精度越差; 越大越满, 但是精度越好


function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品,必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function StringSplit(str, reps)
    -- 字符串切割
    local resultStrList = {}
    string.gsub(str, '[^' .. reps .. ']+',
            function(w)
                table.insert(resultStrList, w)
            end
    )
    return resultStrList
end

function GetPlayerMaxAttr()
    local attr = LUA_取返回值(string.format([[
    local iIceAttack  		= Player:GetData( "ATTACKCOLD" );
    local iFireAttack 		= Player:GetData( "ATTACKFIRE" );
    local iThunderAttack	= Player:GetData( "ATTACKLIGHT" );
    local iPoisonAttack		= Player:GetData( "ATTACKPOISON" );
    local tt={ iIceAttack, iFireAttack, iThunderAttack,iPoisonAttack}
    if iIceAttack==math.max(unpack(tt)) then
        maxOfT ="bing"
    elseif  iFireAttack==math.max(unpack(tt)) then
        maxOfT ="huo"
    elseif  iThunderAttack==math.max(unpack(tt)) then
        maxOfT ="xuan"
    elseif  iPoisonAttack==math.max(unpack(tt)) then
        maxOfT ="du"
    end
    return maxOfT
    ]]), "s")
    return attr
end

function WritePlayerConfiguration(section, keyName, value)
    local playerName = 获取人物信息(12)
    local configPath = string.format("C:\\天龙小蜜\\角色配置\\%s.ini", playerName)
    if section ~= nil and keyName ~= nil and value ~= nil then
        MentalTip("写角色配置项|" .. section .. "|" .. keyName .. "|" .. value);
        延时(200)
        写配置项(configPath, section, keyName, value);
        延时(200)
    end
end

function ReadPlayerConfiguration(section, keyName)
    local playerName = 获取人物信息(12)
    local configPath = string.format("C:\\天龙小蜜\\角色配置\\%s.ini", playerName)
    local tem = 读配置项(configPath, section, keyName)
    if tem then
        MentalTip(section .. "|" .. keyName .. "==" .. tem);
        延时(500)
    else
        return 0
    end
    return tem
end

-- main ------------------------------------------------------

ZYList = {
    bing='真元·沉冰',
    huo='真元·炽火',
    xuan='真元·印玄',
    du='真元·蛊毒',
}

local CuiJieList = '真元·百炼铁骨|真元·百步穿杨|真元·内劲绵绵|真元·灵慧|真元·迅捷|真元·千转柔筋|真元·坚韧如岳|真元·勇力|真元·暴猛如焰|真元·气定|真元·气贯神庭|真元·外功罡猛|真元·滑不沾衣'

CuiJieList = CuiJieList .. '|[绿色]真元·血涌丹田|[绿色]真元·厚体|[绿色]真元·沉冰|[绿色]真元·炽火|[绿色]真元·印玄|[绿色]真元·蛊毒'

--local tmp = '真元·血涌丹田|真元·沉冰|真元·炽火|真元·印玄|真元·蛊毒|真元·厚体'

local attr = GetPlayerMaxAttr()

for k,v in pairs(ZYList) do
    if k ~= attr then
        CuiJieList = CuiJieList .. '|' .. v
    end
end

WritePlayerConfiguration('真元淬解', '淬解真元', CuiJieList)
