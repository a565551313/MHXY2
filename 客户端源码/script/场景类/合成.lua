--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-09-28 14:02:15
--======================================================================--
local 场景类_合成 = class()

local floor = math.floor
local tp
local insert = table.insert

function 场景类_合成:初始化(根)
	self.ID = 37
	self.x = 200
	self.y = 110
	self.xx = 0
	self.yy = 0
	self.注释 = "合成"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.开始 = 1
	self.结束 = 20
	self.上次 = {}
	self.材料数量 = 0
	self.窗口时间 = 0
	tp = 根
end

function 场景类_合成:打开()
	if self.可视 then
		self.可视 = false
		self.资源组 = nil
		self.物品 = nil
		self.材料 = nil
	else
		insert(tp.窗口_,self)
		self:加载数据()
		for i=1,20 do
			self.物品[i]:置物品(tp.道具列表[i])
		end
		tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end

function 场景类_合成:加载数据()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	self.资源组 = {
		[1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xC885F689),
		[2] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xF11233BB),0,0,4,true,true),
		[3] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x2BD1DEF7),0,0,4,true,true,"合成"),
	}
	local 格子 = tp._物品格子
	self.物品 = {}
	for i=1,20 do
		self.物品[i] = 格子(0,0,"合成")
	end
	self.材料 = {}
	for i=1,4 do
		self.材料[i] = 格子(0,0,"合成材料")
	end
	for n=2,3 do
		self.资源组[n]:绑定窗口_(37)
	end
end

local function 可合成(a,b)
	if a == 5 then
		if b == 6 then
			return true
		end
	end
end

function 场景类_合成:显示(dt,x,y)
	self.焦点 = false
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y,self.材料数量 >= 2)
	if self.资源组[2]:事件判断() then
		self:打开()
		return false
	elseif self.资源组[3]:事件判断() then
		if 可合成(self.上次[2],self.上次[3]) then
			if self.上次[2] == 5 then
				if self.上次[3] == 6 then
					if self.上次[4] < 16 then
						if self.材料数量 == 2 then
							local dj = self.上次[4] + 1
							增加物品(self.上次[1],dj)
							for i=1,4 do
								self.材料[i]:置物品(nil)
							end
							self.上次 = {}
							self.材料数量 = 0
						elseif self.材料数量 == 3 then
							local cs = 1
							local dj = self.上次[4] + 1
							增加物品(self.上次[1],dj)
							for i=1,4 do
								if self.材料[i].物品 ~= nil then
									cs = cs + 1
								end
								self.材料[i]:置物品(nil)
								if cs == 3 then
									break
								end
							end
							self.材料数量 = self.材料数量 - 2
						elseif self.材料数量 == 4 then
							local dj = self.上次[4] + 2
							增加物品(self.上次[1],dj)
							for i=1,4 do
								self.材料[i]:置物品(nil)
							end
							self.材料数量 = 0
							self.上次 = {}
						end
					else
						tp.常规提示:打开("#Y/已经达到合成上限了")
					end
				end
			end
		else
			tp.常规提示:打开("#Y/这些物品不能够进行合成")
		end
	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[2]:显示(self.x+288,self.y+12)
	self.资源组[3]:显示(self.x+190,self.y+152,true)
	local is = 0
	for h=1,4 do
		for l=1,5 do
			is = is + 1
			self.物品[is]:置坐标(l * 51 - 14 + self.x,h * 51 + self.y + 129)
			self.物品[is]:显示(dt,x,y,self.鼠标)
			if self.物品[is].物品 ~= nil and self.物品[is].焦点 then
				tp.提示:道具行囊(x,y,self.物品[is].物品)
				if self.物品[is].事件 and self.鼠标 then
					if self.材料数量 < 4 then
						self.材料数量 = self.材料数量 + 1
						if self.上次[1] == nil or (self.上次[1] == self.物品[is].物品.名称 and self.上次[2] == self.物品[is].物品.总类 and self.上次[3] == self.物品[is].物品.分类 and self.上次[4] == self.物品[is].物品.级别限制)  then
							self.物品[is].物品.数量 = self.物品[is].物品.数量 - 1
							self.上次 = {self.物品[is].物品.名称,self.物品[is].物品.总类,self.物品[is].物品.分类,self.物品[is].物品.级别限制}
							local cs = self.物品[is].物品.数量
							local dj = 复制物品(self.物品[is].物品)
							dj.数量 = 1
							for i=1,4 do
								if self.材料[i].物品 == nil then
									self.材料[i]:置物品(dj)
									break
								end
							end
							if self.物品[is].物品.数量 <= 0 then
								self.物品[is]:置物品(nil)
							end
							刷新道具逻辑(self.物品[is].物品,is,true)
						else
							self.材料数量 = self.材料数量 - 1
							tp.常规提示:打开("#Y/必须放入完全相同的物品才可以进行合成")
						end
					else
						tp.常规提示:打开("#Y/放入的物品太多了，不允许再放入了")
					end
				end
			end
		end
	end
	is = 0
	for h=1,2 do
		for l=1,2 do
			is = is + 1
			self.材料[is]:置坐标(l * 58 - 23 + self.x,h * 55 + self.y + 8)
			self.材料[is]:显示(dt,x,y,self.鼠标)
			if self.材料[is].物品 ~= nil and self.材料[is].焦点 then
				tp.提示:道具行囊(x,y,self.材料[is].物品)
				if self.材料[is].事件 and self.鼠标 then
					self.材料数量 = self.材料数量 - 1
					if self.材料数量 <= 0 then
						self.上次 = {}
					end
					增加物品(self.材料[is].物品)
					self.材料[is]:置物品(nil)
				end
			end
		end
	end
end

function 场景类_合成:检查点(x,y)
	if self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_合成:初始移动(x,y)
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

function 场景类_合成:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_合成