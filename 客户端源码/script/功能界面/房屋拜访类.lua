--======================================================================--
local 场景类_房屋拜访 = class()
local tp,zts,zts1,rwa,zts2,zts3
local mousea = 引擎.鼠标弹起
local insert = table.insert
function 场景类_房屋拜访:初始化(根)
	self.ID = 94
	self.x = 435
	self.y = 178
	self.xx = 0
	self.yy = 0
	self.注释 = "房屋拜访"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	local 资源 = 根.资源
	self.资源组 = {
    [1] = 自适应.创建(0,1,188,100,3,9),
    [2] = 自适应.创建(1,1,180,18,1,3,nil,18),
    [3] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
    [4] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"查找"),
    [5] = 自适应.创建(3,1,140,18,1,3),
	}
	self.窗口时间 = 0
	tp = 根
	zts = tp.字体表.普通字体
	zts1 = tp.字体表.普通字体__
	zts2 = tp.字体表.描边字体
	zts3 = tp.字体表.普通字体__

	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('存款金额总控件')
	总控件:置可视(true,true)
	self.输入框 = 总控件:创建输入("输入",self.x+35,self.y+60,400,16)
	self.输入框:置可视(false,false)
	self.输入框:置限制字数(9)
	self.输入框:置光标颜色(-16777216)
	self.输入框:置文字颜色(-16777216)
	self.输入框:置数字模式()

end

function 场景类_房屋拜访:打开() -- 服饰染色 召唤兽染色
	if self.可视 then
		self.输入框:置可视(false,false)
		self.可视 = false
	else
		insert(tp.窗口_,self)
	    tp.运行时间 = tp.运行时间 + 1
	  	self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end
function 场景类_房屋拜访:显示(dt,x,y)
	self.资源组[3]:更新(x,y)
	self.资源组[4]:更新(x,y)
	self.控件类:更新(dt,x,y)
	if self.资源组[3]:事件判断() then
		self:打开()
	elseif self.资源组[4]:事件判断() then
		请求服务(1506,{房屋ID=self.输入框:取文本()})
		self:打开()
		return
	end
	self.资源组[1]:显示(self.x,self.y)
  	self.资源组[2]:显示(self.x+4,self.y+3)
    self.资源组[3]:显示(self.x+167,self.y+4)
    self.资源组[4]:显示(self.x+72,self.y+77)
    self.资源组[5]:显示(self.x+25,self.y+56)
	self.控件类:显示(x,y)
	self.输入框:置可视(true,true)
end



function 场景类_房屋拜访:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_房屋拜访:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if self.可视 and self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_房屋拜访:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_房屋拜访