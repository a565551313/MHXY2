
local 藏宝阁上架货币 = class()

local floor = math.floor
local zts,tp
local insert = table.insert
function 藏宝阁上架货币:初始化(根)
	self.ID = 117
	self.x = 220
	self.y = 200
	self.xx = 0
	self.yy = 0
	self.注释 = "藏宝阁上架货币"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	local 资源 = 根.资源
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,300,190,3,9),
		[2] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"确定"),
		[3] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"取消"),
		[4] = 自适应.创建(1,1,296,18,1,3,nil,18),
		[6] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[7] = 自适应.创建(3,1,200,18,1,3),
	}

	for i=2,3 do
	    self.资源组[i]:绑定窗口_(117)
	end
	self.资源组[6]:绑定窗口_(117)
	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('藏宝阁上架货币')
	总控件:置可视(true,true)
	self.输入框 = 总控件:创建输入("藏宝阁上架数量输入",0,0,185,16)
	self.输入框:置可视(false,false)
	self.输入框:置光标颜色(-16777216)
	self.输入框:置文字颜色(-16777216)
	self.输入框:置数字模式()
	self.输入框1 = 总控件:创建输入("藏宝阁上架金额输入",0,0,185,16)
	self.输入框1:置可视(false,false)
	self.输入框1:置光标颜色(-16777216)
	self.输入框1:置文字颜色(-16777216)
	self.输入框1:置数字模式()
	self.窗口时间 = 0
	tp = 根
	zts = 根.字体表.普通字体
	self.类型 = ""
	self.数量 = 0
end

function 藏宝阁上架货币:打开(类型,数量)
	if self.可视 then
		self.回调事件 = nil
		self.类型事件 = nil
		self.输入框:置可视(false,false)
		self.可视 = false
	else
		insert(tp.窗口_,self)
        self.类型 = 类型
        self.数量 = 数量
		self.输入框:置可视(true,true)
		self.输入框:置文本("")
		self.输入框1:置可视(true,true)
		self.输入框1:置文本("")
		tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end


function 藏宝阁上架货币:显示(dt,x,y)
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[4]:显示(self.x+2,self.y+2)
	self.资源组[7]:显示(self.x+83,self.y+68)
	self.资源组[7]:显示(self.x+83,self.y+108)
	-- tp.窗口标题背景_:置区域(0,0,72,16)
	-- tp.窗口标题背景_:显示(self.x+105,self.y+3)
	tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-68,self.y+2)
	zts:置颜色(白色)
	zts:置字间距(3)
	zts:显示(self.x+self.资源组[1].宽度/2-38,self.y+2,"上架货币")
    zts:置字间距(0)
	zts:显示(self.x+40,self.y+38,"你当前的"..self.类型.."余额为:"..self.数量)
	zts:显示(self.x+17,self.y+70,"上架数额:")
	zts:显示(self.x+17,self.y+110,"上架价格:")
	self.控件类:更新(dt,x,y)
	self.控件类:显示(dt,x,y)
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y)
	self.资源组[6]:更新(x,y)
	if self.资源组[2]:事件判断() then
		if self.输入框:取文本() == "" or self.输入框1:取文本() == ""  then
			 	tp.常规提示:打开("#Y/输入的数值错误")
		elseif tonumber(self.输入框:取文本()) < 1 or tonumber(self.输入框1:取文本()) < 1 then
				tp.常规提示:打开("#Y/输入的数值错误")
		elseif tonumber(self.输入框:取文本()) > tonumber(self.数量) then
				tp.常规提示:打开("#Y/你的余额没有那么多")
		else
		请求服务(69,{类型=self.类型,文本="上架货币",数量=self.输入框:取文本(),价格=self.输入框1:取文本()})
			self:打开()
		end

	elseif self.资源组[3]:事件判断() then
		self:打开()
		return false
	elseif self.资源组[6]:事件判断() then
		self:打开()
		return false
	end
	self.资源组[2]:显示(self.x+40,self.y+150)
	self.资源组[3]:显示(self.x+205,self.y+150)
	self.资源组[6]:显示(self.x+277,self.y+2)

	self.输入框:置坐标(self.x + 87,self.y + 70)
	self.输入框1:置坐标(self.x + 87,self.y + 110)
	if self.输入框._已碰撞 or self.输入框1._已碰撞 then
		self.焦点 = true
	end
end

function 藏宝阁上架货币:检查点(x,y)
	if self.资源组[1]:是否选中(x,y)  then
		return true
	end
end


function 藏宝阁上架货币:检查点(x,y)
	if self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 藏宝阁上架货币:初始移动(x,y)
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

function 藏宝阁上架货币:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 藏宝阁上架货币