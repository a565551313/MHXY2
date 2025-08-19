
local 给予类 = class()
local tp,zts
local insert = table.insert
local xxx = 0
local yyy = 0
local sts = {"单价","数量","总额","现金"}

local mouseb = 引擎.鼠标弹起

function 给予类:初始化(根)
   self.ID = 50
	self.x = 166
	self.y = 78
	self.xx = 0
	self.yy = 0
	self.注释 = "给予类"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口时间 = 0
	tp = 根
  	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('给予总控件')
	总控件:置可视(true,true)
	self.输入框 = 总控件:创建输入("银两输入",0,0,100,14)
	self.输入框:置可视(false,false)
	self.输入框:置限制字数(12)
	self.输入框:置数字模式()
	self.输入框:屏蔽快捷键(true)
	self.输入框:置光标颜色(-16777216)
	self.输入框:置文字颜色(-65536)
	zts= tp.字体表.普通字体
end

function 给予类:打开(数据,名称,等级,类型)
	if self.可视 then
		self.可视 = false
		self.输入框:置可视(false,false)
		self.资源组 = nil
		self.物品 = nil
		self.背包按钮 = nil
		return
	else
		insert(tp.窗口_,self)
		local 按钮 = tp._按钮
		local 自适应 = tp._自适应
		local 资源 = tp.资源
		self.资源组 = {
			[1] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"给予"),
			[2] = 资源:载入(wdf配置.."/pic/给予界面.png", "图片"),
			[3] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"取消"),

		}
	self.背包按钮={
		[1] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"1"),
		[2] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"2"),
		[3] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"3"),
		[4] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"4"),
		[5] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"5"),
	   }
	  self.开始=1
	  self.结束=20
	  for i=1,5 do
	  	self.背包按钮[i]:置偏移(-2,-2)
	  end

		self.物品={}
		for i=1,100 do
			self.物品[i] = tp._物品格子.创建(0,0,i,"给予_物品")
		end
		local wp = tp._物品
		for q=1,100 do
			self.物品[q]:置物品(tp.道具列表[q])
			self.物品[q].格子=nil
		end
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.对象名称=名称
	    self.对象等级=等级
	    self.对象类型=类型
	    self.格子={}
	    self.输入框:置可视(true,true)
	    self.输入框:置文本("0")
	end
end
function 给予类:更新(dt) end

function 给予类:设置物品(id)
	local 编号=0
	for n=1,3 do
		if not self.格子[n] and 编号==0 then 编号=n end
	end
	if 编号==0 then
		self.物品[self.格子[1]].格子=nil
		self.格子[1]=id
		self.物品[self.格子[1]].格子=1
	else
		self.格子[编号]=id
		self.物品[self.格子[编号]].格子=1
	end
end

function 给予类:显示(dt,x,y)
	self.焦点=false
    self.资源组[2]:显示(self.x,self.y)
	self.资源组[1]:显示(self.x+58,self.y+242)
	self.资源组[3]:显示(self.x+145,self.y+242)
	self.输入框:置坐标(self.x + 91,self.y + 214)
	tp.字体表.下拉字体:置颜色(白色):显示(self.x+215,self.y+3," 给 予")
	self.资源组[1]:更新(x,y)
	self.资源组[3]:更新(x,y)
	local xz = 0
	for i=1,5 do
	   self.背包按钮[i]:更新(x,y,self.结束~=i*20)
       self.背包按钮[i]:显示(self.x+190+i*50,self.y+242)
       if self.背包按钮[i]:事件判断() then
       	  self.结束=i*20
       	  self.开始=self.结束-19
       end
	end


	if self.资源组[3]:事件判断() then
		self:打开()
		return
	elseif self.资源组[1]:事件判断() then
		请求服务(3715,{格子=self.格子,银子=self.输入框:取文本()})
		self:打开()
		return
	end
	-- self.资源组[2]:显示(355+self.x,263+self.y)
	local xx = 0
	local yy = 0
	for i=self.开始,self.结束 do
		if self.物品[i].格子==nil then
			self.物品[i]:置坐标(self.x + xx * 51 + 223,self.y + yy * 51 + 28)
			self.物品[i]:显示(dt,x,y,self.鼠标)
			if self.物品[i].焦点 and not tp.消息栏焦点 then
				if self.物品[i].物品 ~= nil then
					tp.提示:道具行囊(x,y,self.物品[i].物品)
					if 引擎.鼠标弹起(左键) then
						if self.物品[i]~=nil and self.物品[i].加锁~=nil and self.物品[i].加锁 then
							tp.常规提示:打开("#Y/该物品已加锁,请先解锁")
							return
						end
						self:设置物品(i)
					end
				end
				self.焦点 = true
			end
		end
		-- print(self.物品[i].模型)
		--table.print(self.物品[i])
		xx = xx + 1
		if xx == 5 then
			xx = 0
			yy = yy + 1
		end
	end
  	zts:置颜色(取金钱颜色(tp.金钱))
	zts:显示(self.x + 91,self.y + 186,tp.金钱)
	--字体:显示(self.x + 91,self.y + 160,self.对象等级)
	tp.字体表.下拉字体:置颜色(白色):显示(self.x + 18,self.y + 40,self.对象类型..":  "..self.对象名称)
	self.控件类:更新(dt,x,y)
	if self.输入框._已碰撞 then
		self.焦点 = true
	end
	self.控件类:显示(x,y)
	for n=1,3 do
		if self.格子[n]~=nil then
			self.物品[self.格子[n]]:置坐标(self.x+1 + n*68-63+13 ,self.y + 79)
			self.物品[self.格子[n]]:显示(dt,x,y,self.鼠标)
			zts:置颜色(黑色):显示(self.x+21+n*68-63+13,self.y+146,self.物品[self.格子[n]].物品.数量 or "1")
			zts:置颜色(白色)
			if self.物品[self.格子[n]].焦点 and not tp.消息栏焦点 then
				if self.物品[self.格子[n]].物品 ~= nil then
					tp.提示:道具行囊(x,y,self.物品[self.格子[n]].物品)
					if 引擎.鼠标弹起(左键) then
						self.物品[self.格子[n]].格子=nil
						self.格子[n]=nil
					end
				end
				self.焦点 = true
			end
		end
	end
end

function 给予类:检查点(x,y)
	if self.可视 and self.资源组~=nil and self.资源组[2]:是否选中(x,y)  then
		return true
	else
		return false
	end
end

function 给予类:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 给予类:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 给予类