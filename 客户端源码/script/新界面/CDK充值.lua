--======================================================================--
-- @作者: GGE研究群: 34211 9466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:26:01
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所有资源
--======================================================================--
local CDK充值 = class()
local tp,zts1
local insert = table.insert
function CDK充值:初始化(根)
	self.ID = 145
	self.x = 200
	self.y = 150
	self.xx = 0
	self.yy = 0
	self.注释 = "CDK充值设置"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,350,100,3,9),
		[2] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"确认充值"),
		[3] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"查看累充"),
		[4] = 自适应.创建(3,1,220,18,1,3),--背景框
		[5] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭

		[6] = 自适应.创建(1,1,346,18,1,3,nil,18),--标题背景
		}
	self.窗口时间 = 0
	tp = 根
	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('CDK充值设置总控件')
	总控件:置可视(true,true)
	self.输入框 = 总控件:创建输入("CDK充值",0,0,220,14)
	self.输入框:置可视(false,false)
	self.输入框:置限制字数(100)
	self.输入框:置文本("")
	self.输入框:置光标颜色(-16777216)
	self.输入框:置文字颜色(-16777216)



	zts1 = tp.字体表.描边字体
	self.字体 = tp.字体表.普通字体
end

function CDK充值:打开()
	if self.可视 then
		self.选中人物 = 0
		self.可视 = false
		self.输入框:置可视(false,false)

	else
		insert(tp.窗口_,self)
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
		self.输入框:置可视(true,true)
		self.输入框:置文本("")

	end
end

function CDK充值:显示(dt,x,y)
	self.焦点=false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[6]:显示(self.x+2,self.y+2)
	tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	zts1:置字间距(3)
	zts1:显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"卡号充值")
	zts1:置字间距(0)
	self.资源组[5]:更新(x,y)
	self.资源组[5]:显示(self.x+330,self.y+2)
	if self.输入框._已碰撞  then
		self.焦点 = true
	end
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y)
	self.资源组[2]:显示(self.x+75,self.y+70)
	self.资源组[3]:显示(self.x+230,self.y+70)
	self.控件类:更新(dt,x,y)
	self.字体:置颜色(白色):显示(self.x+26,self.y+43,"输入卡号:")
	self.资源组[4]:显示(self.x + 95,self.y + 40)
	self.输入框:置坐标(self.x + 100,self.y + 43)
	self.控件类:显示(x,y)
	if self.输入框._输入焦点 and 引擎.按键按住(KEY.CTRL) and 引擎.按键弹起(KEY.V) then
		self.输入框:置文本(取剪贴板())
	end

	if self.资源组[5]:事件判断() then
		self:打开()
	elseif self.资源组[3]:事件判断() then
		  请求服务(36,{领取= "打开"})
		  self:打开()
	elseif self.资源组[2]:事件判断() then
		if self.输入框:取文本()=="" or self.输入框:取文本()==nil then
			tp.常规提示:打开("#Y你还没输入卡号！")
		else
			请求服务(36,{领取= "确定充值",卡号 = self.输入框:取文本()})
			self:打开()
		end
	end
end

function CDK充值:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		return true
	else
		return false
	end
end

function CDK充值:初始移动(x,y)
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

function CDK充值:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end
function CDK充值:更新(dt) end
return CDK充值