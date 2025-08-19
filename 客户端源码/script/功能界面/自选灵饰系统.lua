local 自选灵饰系统 = class()

local floor = math.floor
local min = math.min
local tp,zts1,zts2
local xxx = 0
local yyy = 0
local max = 1
local insert = table.insert
local mouseb = 引擎.鼠标弹起
local wz = require("gge文字类")

function 自选灵饰系统:初始化(根)
	self.ID = 152
	--宽高 549 431
	self.文字类=wz
	self.x = 300
	self.y = 150
	self.xx = 0
	self.yy = 0
	self.注释 = "自选灵饰系统"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.状态 = 1
	self.窗口时间 = 0
	tp = 根
	zts2 = tp.字体表.普通字体
	local 资源 = tp.资源
    local 自适应 = tp._自适应
	local 按钮 = tp._按钮
	self.资源组 = {
			[1] = 自适应.创建(0,1,300,275,3,9),
			[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
			[3] = 自适应.创建(1,1,296,18,1,3,nil,18),--标题背景
			[4] = 按钮.创建(自适应.创建(12,4,48,20,1,3),0,0,4,true,true,"确定"),
			[5]= 自适应.创建(3,1,200,18,1,3),
			}

	self.特效下拉 = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true) --子类下拉按钮
	self.特效下拉列表= 根._小型选项栏.创建(自适应.创建(105,1,185,70,3,9),"") --分类选项
	self.基础下拉 = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true) --子类下拉按钮
	self.基础下拉列表= 根._小型选项栏.创建(自适应.创建(105,1,185,50,3,9),"") --分类选项

	self.属性1下拉 = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true) --子类下拉按钮
	self.属性1下拉列表= 根._小型选项栏.创建(自适应.创建(105,1,185,210,3,9),"") --分类选项
	self.属性2下拉 = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true) --子类下拉按钮
	self.属性2下拉列表= 根._小型选项栏.创建(自适应.创建(105,1,185,210,3,9),"") --分类选项
	self.属性3下拉 = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true) --子类下拉按钮
	self.属性3下拉列表= 根._小型选项栏.创建(自适应.创建(105,1,185,210,3,9),"") --分类选项
	self.属性4下拉 = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true) --子类下拉按钮
	self.属性4下拉列表= 根._小型选项栏.创建(自适应.创建(105,1,185,210,3,9),"") --分类选项


	self.基础=""
	self.属性1=""
	self.属性2=""
	self.属性3=""
	self.属性4=""
	self.已选特效=""

	self.装备特效 = {"无级别限制","超级简易","简易"}

	self.灵饰属性={}
	self.灵饰属性.手镯={主属性={"封印命中等级","抵抗封印等级"},副属性={"气血","防御","格挡值","法术防御","气血回复效果","抵抗封印等级","抗法术暴击等级","抗物理暴击等级"}}
	self.灵饰属性.佩饰={主属性={"速度"},副属性={"气血","防御","格挡值","法术防御","气血回复效果","抵抗封印等级","抗法术暴击等级","抗物理暴击等级"}}
	self.灵饰属性.戒指={主属性={"伤害","防御"},副属性={"伤害","速度","固定伤害","法术伤害","治疗能力","狂暴等级","穿刺等级","封印命中等级","法术暴击等级","物理暴击等级","法术伤害结果"}}
	self.灵饰属性.耳饰={主属性={"法术伤害","法术防御"},副属性={"伤害","速度","固定伤害","法术伤害","治疗能力","狂暴等级","穿刺等级","封印命中等级","法术暴击等级","物理暴击等级","法术伤害结果"}}
	self.级别 = 0
	self.部位="手镯"
end

function 自选灵饰系统:打开(数据)

	if self.可视 then
		self.可视 = false
		self.已选特效=""
		self.基础=""
		self.属性1=""
		self.属性2=""
		self.属性3=""
		self.属性4=""

		return
	else
		insert(tp.窗口_,self)
		self.级别= 数据.级别
		self.已选特效=""
		self.基础=""
		self.属性1=""
		self.属性2=""
		self.属性3=""
		self.属性4=""
		if self.特效下拉列表.可视 then
	     	self.特效下拉列表:打开()
	    end
	    if self.基础下拉列表.可视 then
	     	self.基础下拉列表:打开()
	    end
	    if self.属性1下拉列表.可视 then
	     	self.属性1下拉列表:打开()
	    end
	    if self.属性2下拉列表.可视 then
	     	self.属性2下拉列表:打开()
	    end
	    if self.属性3下拉列表.可视 then
	     	self.属性3下拉列表:打开()
	    end
	    if self.属性4下拉列表.可视 then
	     	self.属性4下拉列表:打开()
	    end
	    self.部位="手镯"
	    if 数据.部位~=nil then
	    	self.部位=数据.部位
	    end
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
	end
end


function 自选灵饰系统:显示(dt,x,y)

	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
    self.资源组[3]:显示(self.x+2,self.y+2)
    tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	zts2:置字间距(2)
	zts2:置颜色(白色)
	zts2:显示(self.x+self.资源组[1].宽度/2-38,self.y+2,"自选灵饰")
	zts2:置字间距(0)
	self.资源组[2]:更新(x,y)
	self.资源组[2]:显示(self.x+285,self.y+2)
	self.资源组[4]:更新(x,y)
	self.资源组[4]:显示(self.x+130,self.y+240)
	self.基础下拉:更新(x,y)
	self.属性1下拉:更新(x,y)
	self.属性2下拉:更新(x,y)
	self.属性3下拉:更新(x,y)
	self.属性4下拉:更新(x,y)
	self.特效下拉:更新(x,y)
	if self.资源组[2]:事件判断() then
		self:打开()
	elseif self.资源组[4]:事件判断() then
		if self.已选特效== nil or self.已选特效==""  then
			tp.常规提示:打开("#Y/请选择特效")
		else
		  请求服务(3861,{等级=self.级别,特效=self.已选特效,基础=self.基础,属性1=self.属性1,属性2=self.属性2,属性3=self.属性3,属性4=self.属性4})
		  self:打开()
		end

	end
	zts2:显示(self.x+10,self.y+32,"当前部位:  "..self.部位.."    礼包等级: "..self.级别.." 级")
	zts2:显示(self.x+10,self.y+62,"基础属性")
	for i=1,4 do
		zts2:显示(self.x+10,self.y+62+i*30,"附加属性")
	end

	zts2:显示(self.x+10,self.y+212,"选择特效")
	for i=1,6 do
		self.资源组[5]:显示(self.x+75,self.y+60+(i-1)*30)
	end

	self.基础下拉:显示(self.x+257,self.y+62)
	self.属性1下拉:显示(self.x+257,self.y+92)
	self.属性2下拉:显示(self.x+257,self.y+122)
	self.属性3下拉:显示(self.x+257,self.y+152)
	self.属性4下拉:显示(self.x+257,self.y+182)
	self.特效下拉:显示(self.x+257,self.y+212)
	self.基础下拉列表:显示(self.x+75,self.y+80,x,y,true)
	self.属性1下拉列表:显示(self.x+75,self.y+110,x,y,true)
	self.属性2下拉列表:显示(self.x+75,self.y+140,x,y,true)
	self.属性3下拉列表:显示(self.x+75,self.y+170,x,y,true)
	self.属性4下拉列表:显示(self.x+75,self.y+200,x,y,true)
    self.特效下拉列表:显示(self.x+75,self.y+230,x,y,true)


	  zts2:置颜色(黑色)
	  if  self.基础~=nil and   self.基础~="" then
	  	  zts2:显示(self.x+80,self.y+62,self.基础)
	  end
	  for i=1,4 do
		if self["属性"..i]~=nil and   self["属性"..i]~="" then
			zts2:显示(self.x+80,self.y+62+i*30,self["属性"..i])
		end
	  end
	  if  self.已选特效~=nil and   self.已选特效~="" then
	  	  zts2:显示(self.x+80,self.y+212,self.已选特效)
	  end


	 if self.基础下拉:事件判断() then
		self.基础下拉列表:打开(self.灵饰属性[self.部位].主属性)
	 elseif self.属性1下拉:事件判断() then
      	  self.属性1下拉列表:打开(self.灵饰属性[self.部位].副属性)
     elseif self.属性2下拉:事件判断() then
      	  self.属性2下拉列表:打开(self.灵饰属性[self.部位].副属性)
     elseif self.属性3下拉:事件判断() then
      	  self.属性3下拉列表:打开(self.灵饰属性[self.部位].副属性)
     elseif self.属性4下拉:事件判断() then
      	  self.属性4下拉列表:打开(self.灵饰属性[self.部位].副属性)
	 elseif self.特效下拉:事件判断() then
      	  self.特效下拉列表:打开(self.装备特效)
     elseif self.基础下拉列表:事件判断() then
		  self.基础=self.基础下拉列表.弹出事件
		  self.基础下拉列表.弹出事件=nil

     elseif self.属性1下拉列表:事件判断() then
		  self.属性1=self.属性1下拉列表.弹出事件
		  self.属性1下拉列表.弹出事件=nil
     elseif self.属性2下拉列表:事件判断() then
		  self.属性2=self.属性2下拉列表.弹出事件
		  self.属性2下拉列表.弹出事件=nil
     elseif self.属性3下拉列表:事件判断() then
		  self.属性3=self.属性3下拉列表.弹出事件
		  self.属性3下拉列表.弹出事件=nil
	 elseif self.属性4下拉列表:事件判断() then
		  self.属性4=self.属性4下拉列表.弹出事件
		  self.属性4下拉列表.弹出事件=nil
	 elseif self.特效下拉列表:事件判断() then
		  self.已选特效=self.特效下拉列表.弹出事件
		  self.特效下拉列表.弹出事件=nil

	  end







end












function 自选灵饰系统:检查点(x,y)
	if self.资源组[1] ~= nil and  self.资源组[1]:是否选中(x,y) then
		return true
	end
end

function 自选灵饰系统:初始移动(x,y)
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

function 自选灵饰系统:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 自选灵饰系统