--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2019-12-24 16:54:28
--======================================================================--
local 滑块 = class()

local bw = require("gge包围盒")
local mouse = 引擎.鼠标按住
local mouses = 引擎.鼠标弹起
local ARGB = ARGB
local ceil = math.ceil
local floor = math.floor

function 滑块:初始化(文件,数量,终点x,终点y,方式) -- 1横2竖
	self.滑块 = 文件
	self.包围盒 = bw(0,0,终点x,终点y)
	self.焦点 = 0
	self.起始点 = 0
	self.方式 = 方式
	self.按下 = false
	self.计次 = 0
	self.偏移x = 0
	self.偏移y = 0
	self.数量 = 数量
	self.宽度 = self.滑块.宽度
	self.高度 = self.滑块.高度
	self.原始宽度 = self.宽度
	self.原始高度 = self.高度
end

function 滑块:是否选中(x,y)
	return self.滑块:是否选中(x,y)
end

function 滑块:绑定窗口_(窗口ID)
	self.绑定窗口 = 窗口ID
end

function 滑块:置起始点(百分比)
	if self.方式 == 2 then
		self.起始点 = floor(((self.包围盒.h-self.高度)*百分比))
	else
	    self.起始点 = floor(((self.包围盒.w-self.宽度)*百分比))
	end
end

function 滑块:置高度(高度)
	if self.高度 == 高度 then return end
	self.高度 = 高度
	self.滑块:置宽高(self.宽度,self.高度)
end

function 滑块:取百分比转换(加入值,可减少值,总值)
	加入值 = 加入值 or 0
	return 加入值/(总值-可减少值)
end

function 滑块:取百分比()
	if self.方式 == 2 then
		return (self.起始点/(self.包围盒.h-self.高度))
	else
		return (self.起始点/(self.包围盒.w-self.宽度))
	end
end

function 滑块:显示(x,y,dx,dy,条件,可以允许在第二窗口)
	if self.数量 >= 4 then
		self.滑块.当前帧 = self.焦点
		self.滑块:更新纹理()
	end
	self.包围盒:置坐标(x,y)
	if self.方式 == 2 then
		self.滑块:显示(x,y+self.起始点)
	else
		self.滑块:显示(x+self.起始点,y)
	end
	if self.接触 then
		if mouses(0) then
			self.焦点 = 0
			self.偏移x = 0
			self.偏移y = 0
			self.接触 = false
			self.计次 = 0
		end
	end
	if self.接触 then
		if self.计次 >= 6 then
			if self.方式 == 2 then
				self.起始点 = dy-y-self.偏移y-(self.高度/2)
				if self.起始点 <= 0 then
					self.起始点 = 0
				elseif self.起始点 >= self.包围盒.h-self.高度 then
					self.起始点 = self.包围盒.h-self.高度
				end
			else
				self.起始点 = dx-x-self.偏移x-(self.宽度/2)
				if self.起始点 <= 0 then
					self.起始点 = 0
				elseif self.起始点 >= self.包围盒.w-self.宽度 then
					self.起始点 = self.包围盒.w-self.宽度
				end
			end
		end
		if mouse(0) then
			self.计次 = self.计次 + 1
		end
	end
	if self.滑块:是否选中(dx,dy) and not tp.第一窗口移动中 and not (tp.选项栏选中 and 可以允许在第二窗口 == nil) and not tp.消息栏焦点 then
		self.焦点 = 2
		if mouse(0) then
			self.焦点 = 1
			if not self.接触 then
				self.接触 = true
				tp.第一窗口移动中 = true
				self.偏移x = dx-x-(self.宽度/2)-self.起始点
				self.偏移y = dy-y-(self.高度/2)-self.起始点
			end
		end
	else
		if not self.接触 then
			self.焦点 = 0
		end
	end
	if not 条件 then
		self.焦点 = 0
		self.偏移x = 0
		self.偏移y = 0
		self.接触 = false
		self.计次 = 0
	end
end

return 滑块