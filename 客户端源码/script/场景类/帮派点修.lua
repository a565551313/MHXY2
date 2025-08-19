--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:11:31
--======================================================================--
local 场景类_帮派点修 = class()
local tp,zts,zts1
local insert = table.insert
local xxx = 0
local yyy = 0
local bwh = require("gge包围盒")
local bw = bwh(0,0,25,276)
local bw1 = bwh(0,0,120,36)
local bw2 = bwh(0,0,244,20)
local box = 引擎.画矩形
local mousea = 引擎.鼠标弹起
local sts = {"攻击修炼","法术修炼","猎术修炼","防御修炼","抗法修炼"}
function 场景类_帮派点修:初始化(根)
	self.ID = 82
	self.x = 200
	self.y = 200
	self.xx = 0
	self.yy = 0
	self.注释 = "帮派点修"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口时间 = 0
	tp = 根
	zts = 根.字体表.普通字体
	zts1 = 根.字体表.描边字体
end

function 场景类_帮派点修:打开(银子,存银)
	if self.可视 then
		self.可视 = false
		self.资源组=nil
		return
	else
		self.修炼选中 = 0
		insert(tp.窗口_,self)
		self:加载资源()
		现金 = 银子
		存款 = 存银
	    tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end

function 场景类_帮派点修:加载资源()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,300,221,3,9),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[3] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"修炼"),
		[4] = 自适应.创建(2,1,260,153,3,9),
		[5] = 自适应.创建(3,1,94,18,1,3),
		[6] = 自适应.创建(1,1,296,18,1,3,nil,18),
	}
	for n=2,3 do
	   self.资源组[n]:绑定窗口_(82)
	end
end

function 场景类_帮派点修:显示(dt,x,y)
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y)
	if self.资源组[2]:事件判断() then
		self:打开()
		return
	elseif self.资源组[3]:事件判断() then
		请求服务(3743,{修炼项目=sts[self.修炼选中]})
	end
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[6]:显示(self.x+2,self.y+2)
	tp.窗口标题背景_[7]:显示(self.x+self.资源组[1].宽度/2-82,self.y+2)
	zts1:置字间距(3)
	zts1:显示(self.x+self.资源组[1].宽度/2-52,self.y+2,"请选择修炼项目")
	zts1:置字间距(0)
	zts:置颜色(4294967295)
	zts:置字间距(0)
	self.资源组[4]:显示(self.x+20,self.y+30)
	zts:置颜色(黑色)
	for i=0,4 do
		local jx = self.x + 50
		local jy = self.y + 42 + i * 28
		bw2:置坐标(jx-9,jy-7)
		local xz = bw2:检查点(x,y)
		if self.修炼选中 ~= i+1 then
			if xz then
				box(jx-9-21,jy-4,jx+230,jy+20,-3551379)
				if mousea(0) then
					self.修炼选中 = i+1
				end
				self.焦点 = true
			end
		else
			local ys = -10790181
			if xz then
				ys = -9670988
				self.焦点 = true
			end
		    box(jx-9-21,jy-4,jx+230,jy+20,ys)
		end
		zts:显示(self.x+25,self.y+42+i*28,sts[i+1])
			if i<2 then
			    zts:显示(self.x+95,self.y+42+i*28,"3万两5点帮贡5点帮派资材/次")
			else
				zts:显示(self.x+95,self.y+42+i*28,"2万两5点帮贡5点帮派资材/次")
			end
		end
	zts:置字间距(0)
	self.资源组[2]:显示(self.x+279,self.y+2)
	self.资源组[3]:显示(self.x+125,self.y+190,true)
	local xx = 0
	local yy = 0
end

function 场景类_帮派点修:检查点(x,y)
	if self.资源组~=nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_帮派点修:初始移动(x,y)
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

function 场景类_帮派点修:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy

	end
end

return 场景类_帮派点修