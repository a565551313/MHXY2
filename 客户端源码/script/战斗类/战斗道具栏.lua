--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-18 19:23:14
--======================================================================--
local 场景类_战斗道具栏 = class()
local require = require
local tp

function 场景类_战斗道具栏:初始化(根)
	self.ID = 104
	self.x = 376
	self.y = 179
	self.xx = 0
	self.yy = 0
	self.注释 = "战斗"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	tp = 根
	local 按钮 = require("script/系统类/按钮")
	local 自适应 = require("script/系统类/自适应")
	self.资源组 = {
		-- [1] = 根.资源:载入('登陆资源.wdf',"网易WDF动画",0xC6D8094C),
		-- [2] = 按钮(根.资源:载入('登陆资源.wdf',"网易WDF动画",0xF11233BB),0,0,4),

		[1] = 自适应.创建(0,1,280,275,3,9),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭
		[3] = 自适应.创建(1,1,276,18,1,3,nil,18),--标题背景

	}
	self.背包按钮={
			[1] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"1"),
			[2] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"2"),
			[3] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"3"),
			[4] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"4"),
			[5] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"5"),
		   }
	self.物品 = {}
	local 格子 = require("script/显示类/物品_格子")
	for i=1,100 do
		self.物品[i] = 格子(0,0,i,"战斗道具_物品")
	end
	self.开始 = 1
	self.结束 = 20
	self.窗口时间 = 0
    self.无法使用={}
	self.获取道具={}
	--zts = tp.字体表.普通字体
end

function 场景类_战斗道具栏:关闭()
	if self.可视 then
		self.可视 = false
		战斗类.战斗指令.道具开关=false
	end
end

function 场景类_战斗道具栏:打开(人物,无法使用)
	if self.可视 then
		self.可视 = false
		战斗类.战斗指令.道具开关=false
		self.获取道具={}
	else
		self.无法使用 = {}
		if 无法使用~=nil then
			self.无法使用 = 无法使用
		end

		if 人物==tp.队伍[1].数字id then
			    self.获取道具 = tp.战斗道具
	    else
	        self.获取道具 = tp.多角色[人物].战斗道具
	    end
		for n=1,100 do
			self.物品[n]:置物品(self.获取道具[n])


		end
		for i=1,#self.无法使用 do
		   if self.物品[self.无法使用[i]]~=nil and self.物品[self.无法使用[i]].物品~=nil then
			self.物品[self.无法使用[i]].禁止使用 = true
		   end
	    end


		self.开始 = 1
		self.结束 = 20
		战斗类.战斗指令.道具开关=true
		self.可视 = true
		tp.运行时间 = tp.运行时间 + 1
	  	self.窗口时间 = tp.运行时间
	end
end

function 场景类_战斗道具栏:更新(dt,x,y)

 self.鼠标=self:检查点(x,y)
end
function 场景类_战斗道具栏:取可用道具(名称,物品,总类)
 	local 加血道具={"金创药","小还丹","千年保心丹","金香玉","五龙丹","翡翠豆腐","佛跳墙","蛇蝎美人","风水混元丹","定神香","十香返生丸","佛光舍利子","九转回魂丹","珍露酒","虎骨酒","女儿红","蛇胆酒","醉生梦死","梅花酒","百味酒","天不老","紫石英","血色茶花","熊胆","鹿茸","六道轮回","凤凰尾","硫磺草","龙之心屑","火凤之睛","四叶花","天青地白","七叶莲","丁香水","月星子","仙狐涎","地狱灵芝","麝香","血珊瑚","餐风饮露","白露为霜","天龙水","孔雀红","紫丹罗","佛手","旋复花","龙须草","百色花","香叶","白玉骨头","鬼切草","灵脂","曼陀罗花"
                   ,"草果","九香虫","水黄莲","山药","八角莲叶","人参"}
 	for n=1,#加血道具 do
     	if 加血道具[n]==名称 then return 5 end
 	end
 	if 名称=="乾坤袋" then
     	return 4
 	end
 	if 总类~=nil and 总类==2000 then
 		return 4
 	end
  	if 名称=="清心咒" or 名称=="乾坤玄火塔" or 名称=="混元伞"  or 名称=="五彩娃娃" or 名称=="苍白纸人" or 名称=="干将莫邪" or 名称=="聚妖铃" then
      	return 5
   	elseif 名称=="惊魂铃" or 名称=="发瘟匣" or 名称=="断线木偶"  or 名称=="摄魂" or 名称=="无魂傀儡" or 名称=="无尘扇" or 名称=="鬼泣"  or 名称=="缚妖索" or 名称=="捆仙绳" or 名称=="摄魂" then
      	return 4
  	end
  	return 0
end
function 场景类_战斗道具栏:显示(dt,x,y)
	if not self.可视 then
		return false
	end
	self.焦点 = false
    --if self.鼠标 then



	-- else
	-- 	self.资源组[2].焦点 = 0
	-- 	 for i=1,5 do
	-- 	 	self.背包按钮[i].焦点 = 0
	-- 	 end
	-- end


	self.资源组[1]:显示(self.x,self.y)
	self.资源组[3]:显示(self.x+2,self.y+2)
	self.资源组[2]:显示(self.x + 260,self.y + 2,true)
	self.资源组[2]:更新(x,y)
	if self.资源组[2]:事件判断() then
		self:打开()
	end
	for i=1,5 do
		self.背包按钮[i]:更新1(x,y,self.结束~=i*20)
		self.背包按钮[i]:显示(self.x-15+i*50,self.y+247)
		if self.背包按钮[i]:事件判断() then
			   self.开始=i*20-19
			   self.结束=self.开始+19
		 end
	end
	-- tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	-- zts:置颜色(白色)
	-- zts:置字间距(3)
	-- zts:显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"道具行囊")
	-- zts:置字间距(0)
	tp.物品界面背景_:显示(self.x+13,self.y+30)



	local xx = 0
	local yy = 0
    for n= self.开始, self.结束 do
			  self.物品[n]:置坐标(self.x+13+xx*51,self.y+30+yy*51)
			 if self.物品[n].物品~=nil then
				 if self.物品[n].物品.名称=="乾坤袋"  then
		              self.物品[n]:显示(dt,x,y,self.鼠标)
		         elseif    self.物品[n].物品.总类==1000 and self.物品[n].物品.使用==1 then
		              self.物品[n]:显示(dt,x,y,self.鼠标)
		         elseif  self.物品[n].物品.总类==2000 then
		             	self.物品[n]:显示(dt,x,y,self.鼠标)
		         else

		         	self.物品[n]:显示(dt,x,y,self.鼠标,{1,100})
		         	if self.物品[n].禁止使用 then
		         		tp.物品格子禁止_:显示(self.x+18+xx*51,self.y+36+yy*51)
		         	end

				 end
				if  self.物品[n].焦点 and self.鼠标 and not self.物品[n].禁止使用  then
					tp.提示:道具行囊(x,y,self.物品[n].物品)
					if 引擎.鼠标弹起(左键) and self:取可用道具(self.物品[n].物品.名称,self.物品[n].物品,self.物品[n].物品.总类)~=0 and self.鼠标 then
	                   	   战斗类.战斗指令:设置道具参数(n,self:取可用道具(self.物品[n].物品.名称,self.物品[n].物品,self.物品[n].物品.总类))
	                   	   self:关闭()
	                   	 return
					end
				end
			end
			xx = xx + 1
			if xx>=5 then
				xx = 0
				yy = yy +1
		    end
		end





	if tp.按钮焦点 then
		self.焦点 = true
	end
	if 引擎.鼠标弹起(1)  and not tp.禁止关闭 and self.鼠标 then
		self:打开()
	end
end

function 场景类_战斗道具栏:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		return true
	end
	return false
end

function 场景类_战斗道具栏:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not 引擎.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.场景.战斗.移动窗口 = true
	end
	if self.可视 and self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_战斗道具栏:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_战斗道具栏