--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2019-09-02 17:03:29
--======================================================================--
local 系统类_小型选项栏 = class()

local zts
local tp
local min = math.min
local ceil = math.ceil

function 系统类_小型选项栏:初始化(背景,事件)
	self.背景 = 背景
	self.宽度 = self.背景.宽度
	self.高度 = self.背景.高度
	self.事件 = 事件
	self.可视 = false
end

function 系统类_小型选项栏:打开(选项,背景)
	if self.可视 then
		self.列表:打开()
		self.可视 = false
	else
		if tp == nil then
			tp = 引擎.场景
			zts = tp.字体表.普通字体
		end
		if self.列表 == nil then
			self.列表 = tp._列表.创建(背景,self.事件,self.背景.宽度-12,21,self.背景.高度-20)
		end
		if #选项 > self.列表.最大显示量 then
		    self.背景:置宽高(self.宽度+15,self.高度)
		    self.上翻 = tp._按钮.创建(tp._自适应.创建(20,4,18,19,4,3),0,0,4,true,true)
		    self.下翻 = tp._按钮.创建(tp._自适应.创建(21,4,18,19,4,3),0,0,4,true,true)
		    self.滑块 = tp._滑块.创建(tp._自适应.创建(11,4,15,40,2,3,nil),4,14,self.高度-42,2)
		    self.允许加入 = true
		else
			if self.背景.宽度 ~= self.宽度 then
				self.背景:置宽高(self.宽度,self.高度)
		    	self.允许加入 = false
			end
		end

		self.列表:打开(选项,tp)
		self.可视 = true
	end
end

function 系统类_小型选项栏:事件判断()
	return self.弹出事件 ~= nil
end

function 系统类_小型选项栏:置选中(选项)
	if self.滑块~=nil then
			self.列表:置选中(选项)
		self.滑块:置起始点(self.滑块:取百分比转换(self.列表.起始-1,self.列表.最大显示量,#self.列表.选项))
	end
end

function 系统类_小型选项栏:是否选中(x,y)
	return self.背景:是否选中(x,y)
end

function 系统类_小型选项栏:显示(sx,sy,x,y,sb)
	if not self.可视 then
		return
	end
	self.背景:显示(sx,sy)
	if self.背景:是否选中(x,y) then
		tp.按钮焦点 = true
		tp.选项栏选中 = true
		tp.第二次删除 = 0
	end
	self.列表:显示(sx+7,sy+6,x,y,sb)
	if self.允许加入 then
		tp.画线:置区域(0,0,15,self.背景.高度-39)
		tp.画线:显示(sx+self.背景.宽度-15,sy+20)
		self.上翻:更新(x,y,self.列表.起始 > 1)
		self.下翻:更新(x,y,self.列表.起始 < #self.列表.选项-self.列表.最大显示量+1)
		if self.上翻:事件判断() then
			self.列表.起始 = self.列表.起始 - 1
			self.滑块:置起始点(self.滑块:取百分比转换(self.列表.起始-1,self.列表.最大显示量,#self.列表.选项))
		elseif self.下翻:事件判断() then
		    self.列表.起始 = self.列表.起始 + 1
		    self.滑块:置起始点(self.滑块:取百分比转换(self.列表.起始-1,self.列表.最大显示量,#self.列表.选项))
		end
		self.上翻:显示(sx+self.背景.宽度-19,sy+2)
	    self.下翻:显示(sx+self.背景.宽度-19,sy+self.高度-21)
	    self.滑块:显示(sx+self.背景.宽度-18,sy+21,x,y,sb,true)
	    if self.滑块.接触 then
	    	self.列表.起始 = min(ceil(self.列表.最大显示量*self.滑块:取百分比())+1,self.列表.最大显示量-1)
	    end
	end
	if self.列表.弹出事件 ~= nil then
		self.弹出事件 = self.列表.弹出事件

		self:打开()
		self.列表.弹出事件 = nil
		return
	end
	--[[for i=1,5 do
		if self.选项[i] ~= nil then
			local zx,zy = sx+7,sy+8+(i-1)*21
			bw:置坐标(zx,zy)
			local xs = bw:检查点(x,y) and not tp.第一窗口移动中
			if self.选中+self.加入 == 0 or self.选中+self.加入 ~= i+self.加入 then
				if xs then
					box(zx-2,zy-2,zx+self.背景.宽度-12,zy+18,-1677721856)
					if mouseb(0) then
						self.选中 = i
						self.弹出事件 = self.选项[i]
						self:打开()
						break
					end
				end
			end
			if self.选中+self.加入 == i+self.加入 then
				local ys = 1677721855
				if xs then
					ys = 2101757695
					if mouseb(0) then
						self.选中 = i
						self.弹出事件 = self.选项[i]
						self:打开()
						break
					end
				end
				box(zx-2,zy-2,zx+self.背景.宽度-12,zy+18,ys)
			end
		    zts:显示(zx,zy,self.选项[i])
		end
	end--]]
end

return 系统类_小型选项栏