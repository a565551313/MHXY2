--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-14 01:24:38
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 合成旗类 = class()
local tp



function 合成旗类:初始化(根)
	self.ID = 55
	self.x = 190
	self.y = 176
	self.xx = 0
	self.yy = 0
	self.注释 = "合成旗"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	tp = 根
	self.窗口时间 = 0
	-- self.地图大小={
	-- 	[1092]={z=4480,y=3020},
	-- 	[1001]={z=11000,y=5600},
	-- 	[4001]={z=11000,y=5600},
	-- 	[1070]={z=3200,y=4200},
	-- 	[1208]={z=3840,y=2400},
	-- }
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	self.背景窗口 = tp._自适应.创建(0,1,0,0,3,9)
	self.圆圈=资源:载入('登陆资源.wdf',"网易WDF动画",0x393947EB)
	self.圆圈=资源:载入('登陆资源.wdf',"网易WDF动画",0x393947EB)
end

-- function 合成旗类:打开(数据)
-- 	if self.可视 or 数据==nil or 数据.地图==nil then
-- 		self.可视 = false
-- 		self.背景窗口 = nil
-- 		self.圆圈 = nil
-- 		self.小地图 = nil
-- 		return
-- 	else
-- 		table.insert(tp.窗口_,self)
-- 		local 资源 = tp.资源
-- 		local 按钮 = tp._按钮
-- 		self.背景窗口 = tp._自适应.创建(0,1,0,0,3,9)
-- 		self.圆圈=资源:载入('登陆资源.wdf',"网易WDF动画",0x393947EB)
-- 	    tp.运行时间 = tp.运行时间 + 1
-- 	  	self.窗口时间 = tp.运行时间
-- 	    self.可视 = true
-- 	    local Smap,Smapa = 小地图资源加载(数据.地图)
-- 	    self.坐标点=数据.xy
-- 	    self.小地图 = tp.资源:载入(Smap,"网易WDF动画",Smapa)
-- 		self.宽度 = self.小地图:取宽度()
--   	    self.高度 = self.小地图:取高度()
-- 		self.x = self.x or math.floor((全局游戏宽度 - self.宽度) /2)
-- 		self.y = self.y or math.floor((全局游戏高度 - self.高度) /2)
--     	local fg = {}
-- 		分割字符(tostring(self.高度),fg)
-- 		fg = tonumber(fg[3])
-- 		local v = 27
-- 		if fg == 1 or fg == 3 or fg == 5 or fg == 7 or fg == 9 then
-- 			v = 26
-- 		end
-- 		self.qx = nil self.qy = nil
-- 		self.背景窗口:置宽高(self.宽度+26,self.高度+v)
-- 		self.偏移X = (self.宽度 - 20) / self.地图大小[数据.地图].z
-- 	    self.偏移Y = (self.高度 - 20)/  self.地图大小[数据.地图].y
-- 	end
-- end

function 合成旗类:打开(数据)
	if self.可视 or 数据==nil or 数据.地图==nil then
		self.可视 = false
	else
		小地图宽度,小地图高度 = 取场景等级宽高(数据.地图)
		table.insert(tp.窗口_,self)
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
		local Smap,Smapa = 小地图资源加载(数据.地图)
		self.坐标点=数据.xy
		self.小地图 = tp.资源:载入(Smap,"网易WDF动画",Smapa)
		self.宽度 = self.小地图:取宽度()
		self.高度 = self.小地图:取高度()
		self.x = self.x or math.floor((1000 - self.宽度) /2)
		self.y = self.y or math.floor((620 - self.高度) /2)
		local fg = {}
		分割字符(tostring(self.高度),fg)
		fg = tonumber(fg[3])
		local v = 27
		if fg == 1 or fg == 3 or fg == 5 or fg == 7 or fg == 9 then
			v = 26
		end
		self.qx = nil self.qy = nil
		self.背景窗口:置宽高(self.宽度+26,self.高度+v)
		self.偏移X = (self.宽度 - 20) / 小地图宽度
		self.偏移Y = (self.高度 - 20)/  小地图高度
	end
end


-- function 合成旗类:显示(dt,x,y)
-- 	self.焦点 = false
-- 	self.背景窗口:显示(self.x-16,self.y-17)
-- 	self.小地图:显示(self.x,self.y)
-- 	for n=1,#self.坐标点 do
-- 		if self.偏移X==nil then
-- 			self.偏移X=1
-- 		end
-- 		if self.偏移Y==nil then
-- 			self.偏移Y=1
-- 		end
-- 		local x1,y1=self.坐标点[n].x,self.坐标点[n].y
-- 		self.圆圈:显示(x1*20 * self.偏移X + 13 + self.x,y1*20 * self.偏移Y + 13 + self.y)
-- 		if self.圆圈:是否选中(x,y) and 引擎.鼠标弹起(左键) then
-- 			请求服务(3737,{序列=n})
-- 			self:打开()
-- 			return
-- 		end
-- 	end
-- end


function 合成旗类:显示(dt,x,y)
	self.焦点 = false
	self.背景窗口:显示(self.x-16,self.y-17)
	self.小地图:显示(self.x,self.y)
	for n=1,#self.坐标点 do
		if self.偏移X==nil then
			self.偏移X=1
		end
		if self.偏移Y==nil then
			self.偏移X=1
		end
		local x1,y1=self.坐标点[n].x,self.坐标点[n].y

		self.圆圈:显示(x1*20 * self.偏移X + 13 + self.x,y1*20 * self.偏移Y + 13 + self.y)
		if self.圆圈:是否选中(x,y) and 引擎.鼠标弹起(左键) then
			请求服务(3737,{序列=n})
			self:打开()
		end
	end
end


function 合成旗类:检查点(x,y)
	if self.可视 and self.小地图 ~= nil and  self.小地图:是否选中(x,y)  then
		return true
	end
end

function 合成旗类:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if self.可视 and self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 合成旗类:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 合成旗类

