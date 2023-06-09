function 购买储物柜()

if 获取人物信息(16) =="大理" then

           跨图寻路("大理",217,177)
			延时(500)
             对话NPC("吕伙计")
              延时 (3000)
              NPC二级对话("购买新的储物箱")
              延时 (3000)
               LUA_Call(" setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();")
				延时(2000)

elseif 获取人物信息(16) =="苏州"  then

跨图寻路("苏州",191,277)
			延时(500)
         对话NPC("曹伙计")
              延时 (3000)
              NPC二级对话("购买新的储物箱")
              延时 (3000)
               LUA_Call(" setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();")
				延时(2000)

elseif 获取人物信息(16) == "洛阳"  then

跨图寻路("苏州",183,298)
			延时(500)
            对话NPC("陈先生")
              延时 (3000)
              NPC二级对话("购买新的储物箱")
              延时 (3000)
               LUA_Call(" setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();")
				延时(2000)
			
		   end
      end

执行功能("大理回城")
购买储物柜()
购买储物柜()
购买储物柜()


