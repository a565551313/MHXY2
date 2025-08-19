--======================================================================--
-- @作者: GGE研究群: 34211 9466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:26:01
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所有资源
--======================================================================--
local 物品密码 = class()
local tp,zts,zts1,zts2,zts3
local insert = table.insert
function 物品密码:初始化(根)
	self.ID = 130
	self.x = 200
	self.y = 100
	self.xx = 0
	self.yy = 0
	self.注释 = "物品密码设置"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,260,372,3,9),
		[2] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"确认"),
		[3] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"取消"),
		[4] = 自适应.创建(3,1,140,18,1,3),--背景框
		[5] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭

		[15] = 自适应.创建(1,1,256,18,1,3,nil,18),--标题背景
		}
	self.窗口时间 = 0
	tp = 根
	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('物品密码设置总控件')
	总控件:置可视(true,true)
	self.输入框 = 总控件:创建输入("物品密码设置输入",0,0,125,14)
	self.输入框:置可视(false,false)
	self.输入框:置限制字数(12)
	self.输入框:置文本("")
	self.输入框:屏蔽快捷键(true)
	self.输入框:置光标颜色(-16777216)
	self.输入框:置文字颜色(-16777216)
	self.输入框m = 总控件:创建输入("确认物品密码设置输入",0,0,125,14)
	self.输入框m:置可视(false,false)
	self.输入框m:置限制字数(12)
	self.输入框m:置文本("")
	self.输入框m:屏蔽快捷键(true)
	self.输入框m:置光标颜色(-16777216)
	self.输入框m:置文字颜色(-16777216)
	zts2 = tp.字体表.描边字体
	zts3 = tp.字体表.普通字体__
	zts1 = tp.字体表.描边字体
	self.字体 = tp.字体表.普通字体
end

function 物品密码:打开()
	if self.可视 then
		self.选中人物 = 0
		self.可视 = false
		self.输入框:置可视(false,false)
		self.输入框m:置可视(false,false)
	else
		insert(tp.窗口_,self)
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
		self.输入框:置可视(true,true)
		self.输入框:置文本("")
		self.输入框m:置可视(true,true)
		self.输入框m:置文本("")
	end
end

function 物品密码:显示(dt,x,y)
	self.焦点=false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[15]:显示(self.x+2,self.y+2)

	tp.窗口标题背景_[4]:显示(self.x+70,self.y+2)
	zts1:置字间距(1)
	zts1:显示(self.x+85,self.y+1,"密码设置")
	zts1:置字间距(0)
	self.资源组[5]:更新(x,y)
	self.资源组[5]:显示(self.x+233,self.y+2)
	self.字体:置颜色(白色):显示(self.x+26,self.y+45,"请用右边的软键盘入您物品锁密\n码的前3位,剩余的位数请用键盘\n输入。\n(建议您设置的物品锁密码尽量由\n数字和英文字母搭配而成)")
	if self.输入框._已碰撞 or self.输入框m._已碰撞 then
		self.焦点 = true
	end
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y)
	self.资源组[2]:显示(self.x+55,self.y+330)
	self.资源组[3]:显示(self.x+140,self.y+330)
	self.控件类:更新(dt,x,y)
	self.字体:置颜色(白色):显示(self.x+26,self.y+133,"设置密码")
	self.字体:置颜色(白色):显示(self.x+26,self.y+155,"确认密码")
	self.资源组[4]:显示(self.x + 95,self.y + 130)
	self.资源组[4]:显示(self.x + 95,self.y + 155)
	self.输入框:置坐标(self.x + 105,self.y + 133)
	self.输入框m:置坐标(self.x + 105,self.y + 158)
	self.控件类:显示(x,y)
	self.字体:置颜色(白色):显示(self.x+26,self.y+188,"请输入加锁密码。 ")
	self.字体:置颜色(黄色):显示(self.x+26,self.y+188,"                 密码由a-z的小\n写英文字母、 0-9的数字组成, ")
	self.字体:置颜色(白色):显示(self.x+222,self.y+203,"长")
	self.字体:置颜色(白色):显示(self.x+26,self.y+217,"度不得少于4个或超过12个字符。\n加锁的召唤兽不允许使用系统赋予\n的名字。例如狼、 蛤蟆精,地狱战\n神之类。设置密码一次需要消耗20\n点体力。")
	if self.资源组[5]:事件判断() or self.资源组[3]:事件判断() then
		self:打开()
	elseif self.资源组[2]:事件判断() then
		if self.输入框:取文本()=="" then
			tp.常规提示:打开("#Y你还没有填写密码呢！")
		elseif string.len(self.输入框:取文本())>12 then
			tp.常规提示:打开("#Y密码过长，请重新填写")
		elseif self.输入框m:取文本()=="" then
			tp.常规提示:打开("#Y你还没有填写密码呢！")
		elseif string.len(self.输入框m:取文本())>12 then
			tp.常规提示:打开("#Y密码过长，请重新填写")
		elseif self.输入框m:取文本()~=self.输入框m:取文本() then
			tp.常规提示:打开("#Y俩次密码不一样?")
		else
			请求服务(3752,{密码=self.输入框:取文本()})
			self:打开()
		end
	end
end

function 物品密码:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		return true
	else
		return false
	end
end

function 物品密码:初始移动(x,y)
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

function 物品密码:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end
function 物品密码:更新(dt) end
return 物品密码