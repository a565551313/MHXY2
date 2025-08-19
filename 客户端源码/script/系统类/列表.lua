--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-08-14 18:37:16
--======================================================================--
local 系统类_列表 = class()

local zts
local tp
local bw = require("gge包围盒")(0,0,0,0)
local box = 引擎.画矩形
local mouseb = 引擎.鼠标弹起
local ceil = math.ceil
local max = math.max
function 系统类_列表:初始化(背景,事件,宽度,高度,显示高度)
	self.背景 = 背景
	self.宽度 = 宽度
	self.高度 = 高度
	self.事件 = 事件
	self.显示高度 = 显示高度
	self.最大显示量 = ceil(self.显示高度/self.高度)
	self.起始 = 1
	self.选中 = 0
	self.可视 = false
end

function 系统类_列表:打开(选项,根)
	if self.可视 then
		self.起始 = 1
		self.可视 = false
	else
		if tp == nil then
			tp = 根
			zts = tp.字体表.普通字体
		end
		self.选项 = 选项
		self.可视 = true
	end
end

function 系统类_列表:置选中(选项)
	for i=1,#self.选项 do
		if self.选项[i] == 选项 then
			self.选中 = i
			if self.选中 > self.最大显示量 then
				self.起始 = self.选中-self.最大显示量+1

			end
			break
		end
	end
end

function 系统类_列表:显示(sx,sy,x,y,sb)
	if not self.可视 then
		return
	end
	zts:置颜色(-1)
	bw:置宽高(self.宽度,self.高度-6)
	for i=self.起始,self.起始+self.最大显示量-1 do
		if self.选项[i] ~= nil then
			local zx,zy = sx,sy+((i-self.起始)*self.高度)
			bw:置坐标(zx,zy)
			local xs = bw:检查点(x,y) and not tp.第一窗口移动中 and not tp.消息栏焦点
			if self.选中 ~= i then
				if xs then
					box(zx-2,zy-2,zx+self.宽度+10,zy+self.高度-3,0xff1E90FF)
					if mouseb(0) and sb then
						self.弹出事件 = self.选项[i]
						break
					end
				end
			else
				local ys = 0xff1E90FF
				if xs then
					ys = 0xff1E90FF
					if mouseb(0) and sb then
						self.弹出事件 = self.选项[i]
						break
					end
				end
				box(zx-2,zy-2,zx+self.宽度+10,zy+self.高度-3,ys)
			end
			zts:置颜色(白色):显示(zx+1,zy," "..self.选项[i])
		end
	end
end

return 系统类_列表