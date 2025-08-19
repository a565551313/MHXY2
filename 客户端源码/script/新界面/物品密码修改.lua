
local 物品密码修改 = class()
local tp,zts,zts1,zts2,zts3
local insert = table.insert
function 物品密码修改:初始化(根)
	self.ID = 131
	self.x = 200
	self.y = 100
	self.xx = 0
	self.yy = 0
	self.注释 = "物品密码修改"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,250,360,3,9),
		[2] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"确认"),
		[3] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"取消"),
		[4] = 自适应.创建(3,1,140,18,1,3),--背景框
		[5] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭
		[15] = 自适应.创建(1,1,246,18,1,3,nil,18),--标题背景
		}
	self.窗口时间 = 0
	tp = 根
	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('物品密码修改总控件')
	总控件:置可视(true,true)
	self.输入框 = 总控件:创建输入("物品密码修改设置输入",0,0,120,14)
	self.输入框:置可视(false,false)
	self.输入框:置限制字数(12)
	self.输入框:置文本("")
	self.输入框:屏蔽快捷键(true)
	self.输入框:置光标颜色(-16777216)
	self.输入框:置文字颜色(-16777216)
	self.输入框1 = 总控件:创建输入("物品密码修改设置输入1",0,0,120,14)
	self.输入框1:置可视(false,false)
	self.输入框1:置限制字数(12)
	self.输入框1:置文本("")
	self.输入框1:屏蔽快捷键(true)
	self.输入框1:置光标颜色(-16777216)
	self.输入框1:置文字颜色(-16777216)
	self.输入框2 = 总控件:创建输入("物品密码修改设置输入2",0,0,120,14)
	self.输入框2:置可视(false,false)
	self.输入框2:置限制字数(12)
	self.输入框2:置文本("")
	self.输入框2:屏蔽快捷键(true)
	self.输入框2:置光标颜色(-16777216)
	self.输入框2:置文字颜色(-16777216)
	zts2 = tp.字体表.描边字体
	zts3 = tp.字体表.普通字体__
	zts1 = tp.字体表.描边字体
	self.字体 = tp.字体表.普通字体
end

function 物品密码修改:打开()
	if self.可视 then
		self.选中人物 = 0
		self.可视 = false
		self.输入框:置可视(false,false)
		self.输入框1:置可视(false,false)
		self.输入框2:置可视(false,false)
	else
		insert(tp.窗口_,self)
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
		self.输入框:置可视(true,true)
		self.输入框:置文本("")
		self.输入框1:置可视(true,true)
		self.输入框1:置文本("")
		self.输入框2:置可视(true,true)
		self.输入框2:置文本("")
	end
end

function 物品密码修改:显示(dt,x,y)
	self.焦点=false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[15]:显示(self.x+2,self.y+2)

	tp.窗口标题背景_[4]:显示(self.x+65,self.y+2)
	zts1:置字间距(1)
	zts1:显示(self.x+80,self.y+1,"修改密码")
	zts1:置字间距(0)
	self.资源组[4]:显示(self.x+92,self.y+40)
	self.资源组[4]:显示(self.x+92,self.y+75)
	self.资源组[4]:显示(self.x+92,self.y+110)
	self.输入框:置坐标(self.x+102,self.y+43)
	self.输入框1:置坐标(self.x+102,self.y+78)
	self.输入框2:置坐标(self.x+102,self.y+113)
	self.字体:置颜色(白色):显示(self.x+24,self.y+40+2,"原密码")
	self.字体:置颜色(白色):显示(self.x+24,self.y+75+2,"新密码")
	self.字体:置颜色(白色):显示(self.x+24,self.y+110+2,"确认密码")
	self.字体:置颜色(白色):显示(self.x+24,self.y+140,"请用右边的软键盘输入您的物品锁\n密码的前3位，剩余的位数请用键\n盘输入。\n物品或召唤兽加锁时，密码由")
	self.字体:置颜色(黄色):显示(self.x+24,self.y+183,"                          a-\nz的小写英文字母、0-9的数字组\n成")
	self.字体:置颜色(白色):显示(self.x+24,self.y+212,"  ，长度不得少于4个或超过12\n个字符。加锁的召唤兽不允许使\n用系统赋予的名字。例如狼、蛤\n蟆精、地狱战神之类。修改密码\n一次扣除20点体力。")
	self.资源组[5]:更新(x,y)
	self.资源组[5]:显示(self.x+223,self.y+2)
	if self.输入框._已碰撞 or self.输入框1._已碰撞 or self.输入框2._已碰撞 then
		self.焦点 = true
	end
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y)
	self.资源组[2]:显示(self.x+53,self.y+320)
	self.资源组[3]:显示(self.x+140,self.y+320)
	self.控件类:更新(dt,x,y)
	self.控件类:显示(x,y)
	if self.资源组[5]:事件判断() or self.资源组[3]:事件判断() then
		self:打开()
	elseif self.资源组[2]:事件判断() then
		if self.输入框:取文本()=="" then
			tp.常规提示:打开("#Y你还没有填写原密码呢！")
			return
		elseif string.len(self.输入框:取文本())>12 then
			tp.常规提示:打开("#Y原密码过长，请重新填写")
			return
		elseif self.输入框1:取文本()=="" then
			tp.常规提示:打开("#Y你还没有填写新密码呢！")
			return
		elseif string.len(self.输入框1:取文本())>12 then
			tp.常规提示:打开("#Y新密码过长，请重新填写")
			return
		elseif self.输入框2:取文本()=="" then
			tp.常规提示:打开("#Y你还没有填写确认密码呢！")
			return
		elseif string.len(self.输入框2:取文本())>12 then
			tp.常规提示:打开("#Y确认密码过长，请重新填写")
			return
		elseif self.输入框:取文本() == self.输入框2:取文本() then
			tp.常规提示:打开("#Y新密码和旧密码一样")
			return
		elseif self.输入框1:取文本() ~= self.输入框2:取文本() then
			tp.常规提示:打开("#Y新密码俩次填写不一样")
			return
		end
        请求服务(3754,{密码=self.输入框:取文本(),新密码=self.输入框2:取文本()})
		self:打开()
	end
end

function 物品密码修改:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		return true
	else
		return false
	end
end

function 物品密码修改:初始移动(x,y)
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

function 物品密码修改:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end
function 物品密码修改:更新(dt) end
return 物品密码修改