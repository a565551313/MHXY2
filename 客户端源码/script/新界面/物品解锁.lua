
local 物品解锁 = class()
local tp,zts,zts1,zts2,zts3
local insert = table.insert
function 物品解锁:初始化(根)
	self.ID = 132
	self.x = 200
	self.y = 100
	self.xx = 0
	self.yy = 0
	self.注释 = "物品解锁"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,300,340,3,9),
		[2] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"确认"),
		[3] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"取消"),
		[4] = 自适应.创建(3,1,180,18,1,3),--背景框
		[5] = 按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"修改密码"),
		[6] = 按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"强行解锁"),
		[7] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭
		[15] = 自适应.创建(1,1,296,18,1,3,nil,18),--标题背景
		}
	self.窗口时间 = 0
	tp = 根
	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('物品解锁设置总控件')
	总控件:置可视(true,true)
	self.输入框 = 总控件:创建输入("物品解锁输入",0,0,175,14)
	self.输入框:置可视(false,false)
	self.输入框:置限制字数(12)
	self.输入框:置文本("")
	self.输入框:屏蔽快捷键(true)
	self.输入框:置光标颜色(-16777216)
	self.输入框:置文字颜色(-16777216)
	self.输入框:置密码模式()
	zts2 = tp.字体表.描边字体
	zts3 = tp.字体表.普通字体__
	zts1 = tp.字体表.描边字体
	self.字体 = tp.字体表.普通字体
end

function 物品解锁:打开()
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

function 物品解锁:显示(dt,x,y)
	self.焦点=false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[15]:显示(self.x+2,self.y+2)
	tp.窗口标题背景_[4]:显示(self.x+90,self.y+2)
	zts1:置字间距(1)
	zts1:显示(self.x+105,self.y+1,"解除密码")
	zts1:置字间距(0)
	self.资源组[7]:更新(x,y)
	self.资源组[7]:显示(self.x+273,self.y+2)
	self.字体:置颜色(白色):显示(self.x+26,self.y+45,"请用右边的软键盘入您物品锁密码\n的前3位,剩余的位数请用键盘输入。")
	self.字体:置颜色(白色):显示(self.x+26,self.y+145,"请输入密码以解除物品及钱庄的加锁\n限制。如果你忘了密码，可以点击“")
	self.字体:置颜色(黄色):显示(self.x+26,self.y+174,"强行解除")
	self.字体:置颜色(白色):显示(self.x+26,self.y+174,"        ”按钮，但需要等待15天，1\n5天后自动解除密码。15天内记起密码\n可以通过再次输入立刻解除密码。申\n请强行解除密码需要消耗体力100点(\n0至9级的游戏角色仅需消耗体力10点\n)。修改密码需要消耗体力20点。")
	self.资源组[4]:显示(self.x + 62,self.y + 98)
	self.输入框:置坐标(self.x + 72,self.y + 101)
	if self.输入框._已碰撞 then
		self.焦点 = true
	end
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y)
	self.资源组[5]:更新(x,y)
	self.资源组[6]:更新(x,y)
	self.资源组[2]:显示(self.x+24,self.y+300)
	self.资源组[5]:显示(self.x+76,self.y+300)
	self.资源组[6]:显示(self.x+155,self.y+300)
	self.资源组[3]:显示(self.x+234,self.y+300)
	self.控件类:更新(dt,x,y)
	self.控件类:显示(x,y)
	if self.资源组[7]:事件判断() or self.资源组[3]:事件判断() then
		self:打开()
	elseif self.资源组[2]:事件判断() then
		if self.输入框:取文本()=="" then
			tp.常规提示:打开("#Y你还没有填写密码呢！")
		elseif string.len(self.输入框:取文本())>12 then
			tp.常规提示:打开("#Y密码过长，请重新填写")
		else
            请求服务(3753,{密码=self.输入框:取文本()})
			self:打开()
		end
	elseif self.资源组[5]:事件判断() then
		tp.窗口.物品密码修改:打开()
		self:打开()
	elseif self.资源组[6]:事件判断() then
		local 事件 = function()
			请求服务(3755,{密码=12})
		end
		tp.窗口.文本栏:载入("真的要强行删除密码吗？需要等待15天后系统自动为你解除密码哦！",nil,true,事件)
		self:打开()
	end
end

function 物品解锁:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		return true
	else
		return false
	end
end

function 物品解锁:初始移动(x,y)
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

function 物品解锁:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
		self.输入框:置坐标(self.x + 42,self.y + 70)
	end
end
function 物品解锁:更新(dt) end

return 物品解锁