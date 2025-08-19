--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-09-28 14:02:10
--======================================================================--
local 场景类_出售 = class()

local tp,zts,zts1
local floor = math.floor
local tonumber = tonumber
local tostring = tostring
local insert = table.insert
local xs = {[0]="单 价",[1]="数 量",[2]="总 额",[3]="现 金"}
local jqr = 取金钱颜色

function 场景类_出售:初始化(根)
	self.ID = 27
	self.x = 200
	self.y = 106
	self.xx = 0
	self.yy = 0
	self.注释 = "出售"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('出售总控件')
	总控件:置可视(true,true)
	self.输入框 = 总控件:创建输入("数量输入",self.x + 133,self.y + 310,100,14)
	self.输入框:置可视(false,false)
	self.输入框:置限制字数(3)
	self.输入框:置数字模式()
	self.输入框:屏蔽快捷键(true)
	self.输入框:置光标颜色(-16777216)
	self.输入框:置文字颜色(-16777216)
	self.窗口时间 = 0
	self.开始 = 1
	self.结束 = 20
	self.收购价格 = 1
	self.回收分类 = nil
	tp = 根
	zts = tp.字体表.普通字体
	zts1 = tp.字体表.描边字体
end

function 场景类_出售:打开(收购价格,回收分类)
	if self.可视 then
		self.道具 = nil
		self.单价 = nil
		self.数量 = nil
		self.可视 = false
		if self.上一次 ~= nil then
			self.物品[self.上一次].确定 = false
		end
		self.物品 = nil
		self.资源组 = nil
		self.上一次 = nil
		self.输入框:置可视(false,false)
		return
	else
		insert(tp.窗口_,self)
		self:加载资源()
		for n=self.开始,self.结束 do
			self.物品[n]:置物品(tp.道具列表[n])
		end
		self.收购价格 = 收购价格
		if self.收购价格 == nil then
			self.收购价格 = 1
		end
		self.回收分类 = 回收分类
	    tp.运行时间 = tp.运行时间 + 1
	  	self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end
function 场景类_出售:加载资源()
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,272,419,3,9),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[3] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true," 出  售"),
		[4] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"一键出售"),
		[5] = 按钮.创建(自适应.创建(22,4,27,20,4,3),0,0,4,true,true),
		[6] = 按钮.创建(自适应.创建(23,4,27,20,4,3),0,0,4,true,true),
		[7] = 自适应.创建(1,1,268,18,1,3,nil,18),
		[8] = 自适应.创建(3,1,90,18,1,3)
	}
	for n=2,6 do
	   self.资源组[n]:绑定窗口_(27)
	end
	self.物品 = {}
	local 格子 = tp._物品格子
	for i=1,20 do
		self.物品[i] = 格子(0,0,i,"出售")
	end
end

function 场景类_出售:显示(dt,x,y)
	self.焦点 = false
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y,self.道具 ~= nil and self.回收分类 ~= nil and ((self.道具.总类 == self.回收分类[1] or self.道具.总类 == self.回收分类[2] or self.道具.总类 == self.回收分类[3]) or self.回收分类 == nil))
	self.资源组[4]:更新(x,y)
	self.资源组[5]:更新(x,y,self.开始 ~= 1)
	self.资源组[6]:更新(x,y,self.结束 ~= 160)
	if self.鼠标 then
		if self.资源组[2]:事件判断() then
			self:打开()
			return
		elseif self.资源组[3]:事件判断() then
			tp.金钱 = tonumber(tp.金钱) + floor(tonumber(self.数量) * tonumber(self.单价))
			self.道具.数量 = tonumber(self.道具.数量) - tonumber(self.数量)
			if self.道具.数量 <= 0 then
				self.物品[self.上一次]:置物品(nil)
				self.物品[self.上一次].确定 = false
				self.道具 = nil
				self.数量 = 0
				self.单价 = 0
				self.输入框:置可视(false,false)
			end
			刷新道具逻辑(self.物品[self.上一次].物品,self.上一次,true)
		elseif self.资源组[4]:事件判断() then
			for i=self.开始,self.结束 do
				if self.物品[i].物品 ~= nil and (self.回收分类 == nil or (self.物品[i].物品.总类 == self.回收分类)) then
					if self.物品[i].物品.数量 == nil then
						self.物品[i].物品.数量 = 0
					end
					local s = tonumber(self.物品[i].物品.数量)
					if s == nil then
						s = 0
					end
					if s < 0 then
						s = 1
					end
					local jg = tonumber(self.物品[i].物品.价格)
					if jg == nil then
						jg = 0
					end
					local ac = floor(s * jg * self.收购价格)
					tp.金钱 = tonumber(tp.金钱) + ac
					self.物品[i].物品.数量 = tonumber(self.物品[i].物品.数量) - s
					if self.物品[i].物品.数量 <= 0 then
						self.物品[i]:置物品(nil)
						self.物品[i].确定 = false
						self.道具 = nil
						self.数量 = nil
						self.单价 = nil
						self.输入框:置可视(false,false)
					end
					刷新道具逻辑(self.物品[i].物品,i,true)
				end
			end
		elseif self.资源组[5]:事件判断() then
			self.开始 = self.开始 - 20
			self.结束 = self.结束 - 20
			for n=self.开始,self.结束 do
				self.物品[n]:置物品(tp.道具列表[n])
			end
		elseif self.资源组[6]:事件判断() then
			self.开始 = self.开始 + 20
			self.结束 = self.结束 + 20
			for n=self.开始,self.结束 do
				self.物品[n]:置物品(tp.道具列表[n])
			end
		end
	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[7]:显示(self.x+2,self.y+2)
	tp.窗口标题背景_[3]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	zts1:显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"出  售")
	tp.物品界面背景_:显示(self.x+9,self.y+30)
	tp.横排花纹背景_:置区域(3,0,147,13)
	tp.横排花纹背景_:显示(self.x+116,self.y+242)
	zts:置颜色(4294967295)
	for i=0,3 do
		zts:显示(self.x+68,self.y+277+i*24,xs[i])
		self.资源组[8]:显示(self.x+108,self.y+273+i*24)
	end
	self.资源组[2]:显示(self.x+251,self.y+2)
	self.资源组[3]:显示(self.x+100,self.y+369)
	self.资源组[4]:显示(self.x+100,self.y+393)
	self.资源组[5]:显示(self.x+55,self.y+244)
	self.资源组[6]:显示(self.x+86,self.y+244)
	local xx = 0
	local yy = 0
	for i=1,20 do
		i = self.开始 - 1 + i
		local jx = xx * 51 + 10
		local jy = yy * 51 + 30
		self.物品[i]:置坐标(self.x + jx,self.y + jy)
		self.物品[i]:显示(dt,x,y,self.鼠标,self.回收分类)
		if self.物品[i].焦点 and self.物品[i].物品 ~= nil then
			tp.提示:道具行囊(x,y,self.物品[i].物品)
			if self.物品[i].事件 then
				if self.上一次 ~= nil and self.上一次 ~= 0 then
					self.物品[self.上一次].确定 = false
				end
				self.物品[i].确定 = true
				self.道具 = self.物品[i].物品
				self.数量 = 1
				local jg = self.物品[i].物品.价格
				if jg == nil then
					jg = 0
				end
				self.单价 = floor(tonumber(jg) * self.收购价格)
				self.输入框:置文本(1)
				self.输入框:置可视(true,true)
				self.上一次 = i
				jg = nil
			end
		end
		xx = xx + 1
		if xx == 5 then
			xx = 0
			yy = yy + 1
		end
	end
	zts:置颜色(-16777216)
	if self.道具 ~= nil then
		zts:显示(self.x + 115,self.y + 277,self.单价)
		local s = tonumber(self.输入框:取文本())
		if s == nil or s <= 0 or s == ""  then
		s = 1
	end
	if self.道具 ~= nil and s > tonumber(self.道具.数量) then
		if tonumber(self.道具.数量) == 0 then
			self.输入框:置文本(1)
		else
			self.输入框:置文本(tonumber(self.道具.数量))
		end
		end
		self.数量 = tonumber(self.输入框:取文本())
		if self.数量 == nil then
			self.数量 = 1
		end
		zts:显示(self.x + 115,self.y + 325,self.数量 * self.单价)
		self.输入框:置坐标(self.x-380,self.y-115)
		s = nil
	end
	zts:置颜色(jqr(tp.金钱))
	zts:显示(self.x + 115,self.y + 349,tp.金钱)
	self.控件类:更新(dt,x,y)
	self.控件类:显示(x,y)
	if self.输入框._已碰撞  then
		self.焦点 = true
	end
end


function 场景类_出售:检查点(x,y)
	if self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_出售:初始移动(x,y)
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

function 场景类_出售:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_出售