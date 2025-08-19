--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:25:43
--======================================================================--
local 靓号设定 = class()
local bw = require("gge包围盒")(0,0,220,26)
local box = 引擎.画矩形
local format = string.format
local mouse = 引擎.鼠标弹起
local tp
local move = table.move
local insert = table.insert

function 靓号设定:初始化(根)
	self.ID = 144
	self.x = 300
	self.y = 70
	self.xx = 0
	self.yy = 0
	self.注释 = "靓号设定"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.加入 = 0
	self.选中 = 0
	self.介绍文本 = 根._丰富文本(220,26)
	tp = 根
	self.靓号集合={}
	for i=1,7 do
		self.靓号集合[i] = 根._丰富文本(220,26)
	end
	self.窗口时间 = 0
end

function 靓号设定:打开(编号)
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
	    for i=1,7 do
	    	self.靓号集合[i]:清空()
	    	self.靓号集合[i]:添加文本(金色id(tp.队伍[1].数字id,i))
	    end
	    self.介绍文本:清空()
	    if 编号~=nil and 编号~=0 then
	    	self.介绍文本:添加文本(金色id(tp.队伍[1].数字id,tonumber(编号)))
	    else
	    	self.介绍文本:添加文本(""..tp.队伍[1].数字id)
	    end
	end
end

function 靓号设定:刷新(编号)
       self.介绍文本:清空()
	    if 编号~=nil and 编号~=0 then
	    	self.介绍文本:添加文本(金色id(tp.队伍[1].数字id,tonumber(编号)))
	    else
	    	self.介绍文本:添加文本(""..tp.队伍[1].数字id)
	    end

end


function 靓号设定:加载资源()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {

		[1] = 自适应.创建(0,1,250,360,3,9),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[3] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"改变"),
		[4] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"隐藏"),
		[5] = 自适应.创建(1,1,246,18,1,3,nil,18),
		[6] =自适应.创建(4,1,225,240,3,nil),
		[7] = 自适应.创建(3,1,160,18,1,3),
	}
	for n=2,4 do
	   self.资源组[n]:绑定窗口_(144)
	end
end

function 靓号设定:显示(dt,x,y)
	self.焦点 = false
	self.资源组[2]:更新(x,y)

	self.资源组[3]:更新(x,y,self.选中 ~= 0)
	self.资源组[4]:更新(x,y)

	if self.资源组[2]:事件判断() then
		self:打开()
		return false
	elseif self.资源组[3]:事件判断() then
		请求服务(201,{编号=self.选中})
	elseif self.资源组[4]:事件判断() then
		请求服务(201,{编号=0})
	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[5]:显示(self.x+2,self.y+2)
	self.资源组[2]:显示(self.x + 229,self.y + 2)
	tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	tp.字体表.标题字体:显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"角色靓号")

	self.资源组[6]:显示(self.x + 15,self.y + 70)
	self.资源组[7]:显示(self.x + 80,self.y + 37)
	tp.字体表.标题字体:显示(self.x+7,self.y+38,"当前靓号:")
	self.资源组[3]:显示(self.x + 40,self.y + 328,true)
	self.资源组[4]:显示(self.x + 140,self.y + 328,true)
    self.介绍文本:显示(self.x + 90,self.y + 36)

	for m=1,7 do
			bw:置坐标(self.x + 23,self.y + 84 + m * 26)
			if self.选中 ~= m then
				if bw:检查点(x,y) then
					box(self.x + 20,self.y + 80 + m * 26,self.x + 239,self.y + 102 + m * 26,-3551379)
					if mouse(0) then
					  self.选中 = m
					end
					self.焦点 = true
				end
			else
				local ys = -10790181
				if bw:检查点(x,y) then
					ys = -9670988
					self.焦点 = true
				end
				box(self.x + 20,self.y + 80 + m * 26,self.x + 239,self.y + 102 + m * 26,ys)
			end
		  self.靓号集合[m]:显示(self.x + 23,self.y + 80 + m * 26)
		end

end

function 靓号设定:检查点(x,y)
	if self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 靓号设定:初始移动(x,y)
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

function 靓号设定:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 靓号设定