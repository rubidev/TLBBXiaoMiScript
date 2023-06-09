----------------------------师门装备种类太多自己手动安装--------------------------------------

--------------------------------------------------------------------------------------------------------------
LUA_Call(string.format([[
setmetatable(_G, {__index = Friend_Env});
Friend_JianghuRelation();
setmetatable(_G, {__index = NewFriend_Jiebai_Env});
NewFriend_Jiebai_Switch(1)
setmetatable(_G, {__index = NewFriend_ST_Env});
NewFriend_ST_YQClick(2)
setmetatable(_G, {__index = NewFriend_ST_Env});
NewFriend_ST_YQClick(1)
setmetatable(_G, {__index = NewFriend_STCZ_Env});
NewFriend_STCZ_OnEvent("OPEN_NEWFRIEND_STCZ");
]]))
延时(500)
LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});")
延时(500)
if tonumber(获取人物信息(26))>=20  then
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_CONTENT_ASK(2);");延时(500) --卷1
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(1)");延时(500)
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(2)");延时(500)
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(3)");延时(500)
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(4)");延时(500)
右键使用物品("皮制囊");延时(500)
右键使用物品("师徒经验丹（20级）",2);延时(5000)
自动清包("珍兽舍利子|恩师手册")
end

if tonumber(获取人物信息(26))>=30  then
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_CONTENT_ASK(3);");延时(500) --卷2
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(1)");延时(500)
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(2)");延时(500)
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(3)");延时(500)
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(4)");延时(500)
右键使用物品("紫檀箱");延时(500)
右键使用物品("师徒经验丹（20级）",2);延时(5000)
自动清包("珍兽舍利子|恩师手册")
end
if tonumber(获取人物信息(26))>=40  then
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_CONTENT_ASK(4);");延时(500) --卷3
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(1)");延时(500)
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(2)");延时(500)
          --LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(3)");延时(500)
          --LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(4)");延时(500)
右键使用物品("变异珍兽蛋：老虎");延时(500)
右键使用物品("师徒经验丹（20级）",2);延时(500)
自动清包("珍兽舍利子|恩师手册")
end
if tonumber(获取人物信息(26))>=50  then
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_CONTENT_ASK(5);");延时(500) --卷4
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(1)");延时(500)
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(2)");延时(500)
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(3)");延时(500)
          --LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(4)");延时(500)
end
if tonumber(获取人物信息(26))>=60  then
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_CONTENT_ASK(6);");延时(500) --卷5
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(1)");延时(500)
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(2)");延时(500)
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(3)");延时(500)
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(4)");延时(500)
end
--[[if tonumber(获取人物信息(26))>=70  then
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_CONTENT_ASK(7);");延时(500) --卷6
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(1)");延时(500)
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(2)");延时(500)
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(3)");延时(500)
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(4)");延时(500)

end]]
if tonumber(获取人物信息(26))>=80  then
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_CONTENT_ASK(8);");延时(500) --卷7
          --LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(1)");延时(500)
          --LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(2)");延时(500)
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(3)");延时(500)
          LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(4)");延时(500)
右键使用物品("释灵液",2);延时(500)
右键使用物品("真元珀",1);延时(500)
自动清包()	
end
if tonumber(获取人物信息(26))>=90  then
          --LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_CONTENT_ASK(9);");延时(500) --卷8
          --LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(1)");延时(500)
          --LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(2)");延时(500)
          --LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(3)");延时(500)
          --LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Reward_Flag(4)");延时(500)
	
end
LUA_Call ("setmetatable(_G, {__index = NewFriend_STCZ_Env});NewFriend_STCZ_Close()");延时(1000)
LUA_Call ("setmetatable(_G, {__index = NewFriend_ST_Env});this:Hide()");延时(1000)



