
local 队伍申请列表类 = class()
local insert = table.insert
local remove = table.remove
local floor = math.floor
local tp,zts,zts1

function 队伍申请列表类:初始化(根)
   self.ID = 4
	self.x = 100
	self.y = 169
	self.xx = 0
	self.yy = 0
	self.注释 = "队伍申请列表类"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.队伍坐标 = {14,133,252,371,490}
	self.选中人物 = 0
	self.窗口时间 = 0
	tp = 根
	self.队伍格子 = {}
	local 格子 = require("script/系统类/队伍_格子")
	for i=1,5 do
		self.队伍格子[i] = 格子.创建(0,0,i,tp)
	end
	zts1 = tp.字体表.描边字体
end

function 队伍申请列表类:刷新(数据)
	self.队伍数据=数据
	self.选中人物=0
	for i=1,5 do
		self.队伍格子[i]:置人物(nil)
		self.队伍格子[i]:置人物(数据[i])
	end
end

function 队伍申请列表类:打开(数据)
	if self.可视 then
		for i=1,5 do
			self.队伍格子[i].禁止 = false
		end
		self.选中人物 = 0
		self.可视 = false
		self.资源组 = nil
		return
	else
		insert(tp.窗口_,self)
		local 按钮 = tp._按钮
		local 自适应 = tp._自适应
		self.资源组 = {
			[1] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"同意申请"),
			[2] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"拒绝申请"),
			--[3] = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x8FCD5E87)
			[3] = 自适应.创建(0,1,617,291+20,3,9),
			[4] = 自适应.创建(1,1,613,18,1,3,nil,18),
			[5] = 自适应.创建(2,1,116,141,3,9),
			[6] = 自适应.创建(3,1,117,18,1,3),
		}
		for n=1,2 do
			self.资源组[n]:绑定窗口_(4)
		end
		self.队伍数据=数据
		for i=1,5 do
         -- print(数据[i])
		  self.队伍格子[i]:置人物(数据[i])
		end
		local 申请数据=数据
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.选中人物=0
	end
end
function 队伍申请列表类:更新(dt)end

function 队伍申请列表类:显示(dt,x,y)
	self.焦点=false
	self.资源组[1]:更新(x,y,self.选中人物 ~= 0)
	self.资源组[2]:更新(x,y,self.选中人物 ~= 0)
	self.资源组[3]:显示(self.x,self.y)
	self.资源组[1]:显示(self.x+155,self.y+263)
	self.资源组[2]:显示(355+self.x,263+self.y)
	self.资源组[4]:显示(self.x+2,self.y+2)
	tp.窗口标题背景_[4]:显示(self.x+self.资源组[3].宽度/2-60,self.y+2)
	zts1:置字间距(3)
	zts1:显示(self.x+self.资源组[3].宽度/2-30,self.y+2,"申请列表")
	zts1:置字间距(0)
 	for i=0,4 do
		local jx = 11+i*120
		i = i + 1
		self.资源组[5]:显示(self.x + jx,self.y + 35)
		self.资源组[6]:显示(self.x + jx,self.y + 180)
		self.资源组[6]:显示(self.x + jx,self.y + 205)
		self.资源组[6]:显示(self.x + jx,self.y + 230)
		self.队伍格子[i]:置坐标(self.x + jx,self.y + 35)--(self.x + jx-4,self.y + 35)
		self.队伍格子[i]:显示(dt,x,y,self.鼠标,self.队伍数据,-8,-2)
		if self.队伍格子[i].事件 then
	        if self.选中人物==i then
	            self.选中人物=0
            else
	            self.选中人物=i
				self.队伍格子[self.选中人物].禁止 = true
         	end
		end

	end
	if self.资源组[1]:事件判断() then --同意
      请求服务(4004,{序列=self.选中人物})
      self.选中人物=0
    elseif self.资源组[2]:事件判断() then --同意
      请求服务(4005,{序列=self.选中人物})
      self.选中人物=0
 	end
end

function 队伍申请列表类:检查点(x,y)
	if self.可视 and self.资源组 ~=nil and  self.资源组[3]:是否选中(x,y)  then
		return true
	else
		return false
	end
end

function 队伍申请列表类:初始移动(x,y)
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

function 队伍申请列表类:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end


return 队伍申请列表类