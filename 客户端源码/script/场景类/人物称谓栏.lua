--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-13 05:11:25
--======================================================================--
local 场景类_人物称谓栏 = class()
local bw = require("gge包围盒")(0,0,190,18)
local box = 引擎.画矩形
local format = string.format
local mouse = 引擎.鼠标弹起
local fonts
local names,tp
local move = table.move
local insert = table.insert

function 场景类_人物称谓栏:初始化(根)
	self.ID = 6
	self.x = 375
	self.y = 110
	self.xx = 0
	self.yy = 0
	self.注释 = "人物称谓栏"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.加入 = 0
	self.选中 = 0
	self.介绍文本 = 根._丰富文本(210,139,根.字体表.普通字体)
	tp = 根
	names = tp.称谓
	fonts = tp.字体表.普通字体
	self.窗口时间 = 0
end

function 场景类_人物称谓栏:打开()
	if self.可视 then
		self.介绍文本:清空()
		self.资源组=nil
		self.可视 = false
		return
	else
		insert(tp.窗口_,self)
		self.加入 = 0
		self.选中 = 0
		self:加载资源()
	    tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	    names = tp.称谓
	end
end

function 场景类_人物称谓栏:刷新()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		--[1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x360CE2EC),
		[1] = 自适应.创建(0,1,250,360,3,9),


		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[3] = 按钮.创建(自适应.创建(20,4,18,19,4,3),0,0,4,true,true),
		[4] = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true),
		[5] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"改变"),
		[6] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"隐藏"),
		[7] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"删除"),
		[8] = 自适应.创建(1,1,246,18,1,3,nil,18),
		[9] = 自适应.创建(2,1,225,100,3,9),
		[10] =自适应.创建(4,1,225,150,3,nil),
		[11] = 自适应.创建(3,1,160,18,1,3),


	}
	for n=2,7 do
	   self.资源组[n]:绑定窗口_(6)
	end
	names = tp.称谓
end
function 场景类_人物称谓栏:加载资源()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		--[1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x360CE2EC),
		[1] = 自适应.创建(0,1,250,360,3,9),


		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[3] = 按钮.创建(自适应.创建(20,4,18,19,4,3),0,0,4,true,true),
		[4] = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true),
		[5] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"改变"),
		[6] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"隐藏"),
		[7] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"删除"),
		[8] = 自适应.创建(1,1,246,18,1,3,nil,18),
		[9] = 自适应.创建(2,1,225,100,3,9),
		[10] =自适应.创建(4,1,225,140,3,nil),
		[11] = 自适应.创建(3,1,160,18,1,3),


	}
	for n=2,7 do
	   self.资源组[n]:绑定窗口_(6)
	end
end

function 场景类_人物称谓栏:显示(dt,x,y)
	self.焦点 = false
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y,self.加入 > 0)
	self.资源组[4]:更新(x,y,self.加入 < #tp.称谓 - 5)
	self.资源组[5]:更新(x,y,self.选中 ~= 0)
	self.资源组[6]:更新(x,y,tp.当前称谓 ~= "无称谓" and tp.称谓[self.选中]==tp.当前称谓)
	self.资源组[7]:更新(x,y,self.选中 ~= 0 and asni)
	if self.资源组[2]:事件判断() then
		self:打开()
		return false
	elseif self.资源组[3]:事件判断() then
		self.加入 = self.加入 - 1
	elseif self.资源组[4]:事件判断() then
		self.加入 = self.加入 + 1
	elseif self.资源组[5]:事件判断() then
		if tp.当前地图 == 6010 or tp.当前地图 == 8000 or tp.当前地图 == 8001 or tp.当前地图 == 8002   then
			tp.常规提示:打开("#Y/该地图不能改变称谓")
			else
		tp.场景.人物.称谓偏移 = 生成XY(tp.字体表.人物字体:取宽度(tp.当前称谓) / 2,-15)
		请求服务(31,{称谓ID=self.选中})
	end
	elseif self.资源组[6]:事件判断() then
		tp.当前称谓 = "无称谓"
		请求服务(31,{称谓ID=0})
	elseif self.资源组[7]:事件判断() then
		if tp.队伍[1].称谓[self.选中] == nil then
			self:打开()
			return false
		end
		self.介绍文本:清空()
		请求服务(37,{称谓ID=self.选中})
		self.选中 = 0
	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[8]:显示(self.x+2,self.y+2)
	self.资源组[2]:显示(self.x + 229,self.y + 2)
	tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	tp.字体表.标题字体:置颜色(白色)
	tp.字体表.标题字体:显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"角色称谓")
	self.资源组[9]:显示(self.x + 15,self.y + 220)
	self.资源组[10]:显示(self.x + 15,self.y + 70)
	self.资源组[11]:显示(self.x + 80,self.y + 37)
	tp.字体表.标题字体:显示(self.x+7,self.y+38,"当前称谓:")


	self.资源组[3]:显示(self.x + 215,self.y + 98)
	self.资源组[4]:显示(self.x + 215,self.y + 190)
	self.资源组[5]:显示(self.x + 40,self.y + 328,true)
	self.资源组[6]:显示(self.x + 100,self.y + 328,true)
	self.资源组[7]:显示(self.x + 160,self.y + 328,true)
	fonts:置颜色(-16777216)
	for m=1,5 do
		if names[m] ~= nil then
			bw:置坐标(self.x + 23,self.y + 84 + m * 19)
			if self.选中 ~= m + self.加入 then
				if bw:检查点(x,y) then
					box(self.x + 20,self.y + 80 + m * 19,self.x + 211,self.y + 102 + m * 19,-3551379)
					if mouse(0) then
						self.选中 = m + self.加入
						self.介绍文本:清空()
						self.介绍文本:添加文本(format("#N/%s",tp:取称谓说明(tp.称谓[self.选中])))
					end
					self.焦点 = true
				end
			else
				local ys = -10790181
				if bw:检查点(x,y) then
					ys = -9670988
					self.焦点 = true
				end
				box(self.x + 20,self.y + 80 + m * 19,self.x + 211,self.y + 102 + m * 19,ys)
			end
			fonts:显示(self.x + 23,self.y + 84 + m * 19,names[m+self.加入])
		end
	end
	fonts:显示(self.x + 85, self.y + 39,tp.当前称谓)
	self.介绍文本:显示(self.x + 20,self.y + 225)
end

function 场景类_人物称谓栏:检查点(x,y)
	if self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_人物称谓栏:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if self.鼠标 and not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_人物称谓栏:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_人物称谓栏