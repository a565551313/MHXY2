--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-03-10 17:42:12-
--======================================================================--
local 场景类_灵饰 = class()

local floor = math.floor
local tp,zts1
local insert = table.insert


function 场景类_灵饰:初始化(根)
	self.ID = 40
	self.xx = 0
	self.yy = 0
	self.注释 = "灵饰"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	tp = 根
	zts1 = tp.字体表.描边字体
	self.窗口时间 = 0
end

function 场景类_灵饰:打开(x,y)
	if self.可视 then
		self.可视 = false
		self.资源组 = nil
		self.物品 = nil
		return
	else
		insert(tp.窗口_,self)
		self:加载数据()
		for i=1,5 do
			if tp.队伍[1].灵饰[i] ~= nil and  tp.队伍[1].灵饰[i].名称 ~= nil then
				self.物品[i]:置物品(tp.队伍[1].灵饰[i])
			end
		end
		self.x = x
		self.y = y
		tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end

function 场景类_灵饰:加载数据()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,129,201,3,9),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[3] = 自适应.创建(1,1,125,18,1,3,nil,18),
		[4] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x841CBD61),
		[5] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x9912E8B9),
		[6] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x5795605E),
		[7] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xEBD8985D),
		[8] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x21246323),
	}
	self.资源组[2]:绑定窗口_(40)
	self.物品 = {}
	local 格子 = tp._物品格子
	for i=1,5 do
		self.物品[i] = 格子(0,0,i,"道具行囊_灵饰")
	end
end

function 场景类_灵饰:刷新()
	for i=1,5 do
		self.物品[i]:置物品(nil)
		if tp.队伍[1].灵饰[i] ~= nil and  tp.队伍[1].灵饰[i].名称 ~= nil then
			self.物品[i]:置物品(tp.队伍[1].灵饰[i],nil,nil,nil,1)
		end
	end
end

function 场景类_灵饰:显示(dt,x,y)
	self.焦点 = false
	self.资源组[2]:更新(x,y)
	if self.资源组[2]:事件判断() then
		self:打开()
		return false
	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[3]:显示(self.x+2,self.y+2)
	self.资源组[2]:显示(self.x+108,self.y+2)
	zts1:置字间距(3)
	zts1:显示(self.x+self.资源组[1].宽度/2-15,self.y+2,"灵饰")
	zts1:置字间距(0)
	local xx = 0
	local yy = 1
	local xs = 0
	for i=1,5 do
		if i == 5 then
			xs = 27
		end
		xx = xx + 1
		self.资源组[3+i]:显示(self.x + xx * 58-49+xs,self.y + yy * 57-31)
		self.物品[i]:置坐标(self.x + xx * 58-47+xs,self.y + yy * 57-31,nil,nil,4,-1)
		self.物品[i]:显示(dt,x,y,self.鼠标,nil,3)
		if self.物品[i].物品 ~= nil and self.物品[i].焦点 then
			tp.提示:道具行囊(x,y,self.物品[i].物品,true)
		end
		if xx >= 2 then
			xx = 0
			yy = yy + 1
		end
		if self.物品[i].事件 then
			if tp.场景.抓取物品 ~= nil and self.物品[i].物品 == nil and self.物品[i].焦点 then

			elseif tp.场景.抓取物品 ~= nil and self.物品[i].物品 ~= nil and self.物品[i].焦点 then

			elseif tp.场景.抓取物品 == nil and self.物品[i].物品 ~= nil and self.物品[i].焦点 then
				请求服务(3704,{类型=tp.窗口.道具行囊.点击类型,角色="主角",灵饰=true,道具=i})
			end
		elseif self.物品[i].右键 then
			if  self.物品[i].物品 ~= nil then
			    请求服务(3704,{类型=tp.窗口.道具行囊.点击类型,角色="主角",灵饰=true,道具=i})
			end
		end
	end
end



function 场景类_灵饰:检查点(x,y)
	if self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_灵饰:初始移动(x,y)
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

function 场景类_灵饰:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_灵饰