--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2020-04-30 23:13:32
--======================================================================--
local 超级寻路 = class()
local floor = math.floor
local remove = table.remove
local jls = 取两点距离
local zbs = 取距离坐标
local hds = 取两点孤度
local ax1 = require("Astart类")
local xys = 生成XY

function 超级寻路:初始化(v,w,h,buf,len)
	self.l_A = ax1(w,h,buf,len)
	self.l_路径 = {}
	self.l_宽度 = w
	self.l_高度 = h
end

function 超级寻路:检查点(x,y)
	return self.l_A:检查点(x,y)
end

function 超级寻路:寻路(xy,txy,s)
	local x,y 		= xy.x,xy.y
	local tx,ty		= txy.x,txy.y
	if self:判断直线障碍(xy,txy) then
		if not self:检查点(tx,ty) then
		    tx, ty = self:坐标算格子(self:最近坐标(txy) or xy)
		end
		if not self:检查点(x,y) then
		    x,y = self:坐标算格子(self:最近坐标(xy))
		end
		self.l_路径 = self.l_A:取路径(x,y,tx,ty)
		self:下一点(self.l_路径[1])
		if #self.l_路径 == 0 then
			if not self:检查点(tx,ty) then
			    tx, ty = self:坐标算格子(self:最近坐标(txy) or xy)
			end
			if not self:检查点(x,y) then
			    x,y = self:坐标算格子(self:最近坐标(xy))
			end
			self.l_路径 = self.l_A:取路径(x,y,tx,ty)
			if #self.l_路径 > 1 then
				self.l_路径 = self:寻路1(self.l_路径)
			end
		end
		return self.l_路径
	else
		return {xys(txy.x,txy.y)}
	end
end

function 超级寻路:寻路1(xy,xy1)
	local xn = #xy
	if self:判断直线障碍(xy[1],xy[xn]) then
		remove(xy, 1)
		return self:并行下一点(xy)
	else
		return {xy[xn]}
	end
end

function 超级寻路:并行下一点(xy)
	local 位置 = #xy
	if 位置 > 1 then
		local 最后 = xy[位置]
		for i=2,#xy do
			if self:判断直线障碍(xy[1],xy[i]) then
				位置 = i
				break
			end
		end
		for i=1,位置 do
			remove(xy, 1)
		end
		if #xy == 0 then
			xy = 最后
		end
		return xy
	end
end

function 超级寻路:下一点(xy)
	if #self.l_路径 > 1 then
		local 位置 = #self.l_路径
		local 最后 = self.l_路径[位置]
		for i=2,#self.l_路径 do
			if self:判断直线障碍(self.l_路径[1],self.l_路径[i]) then
				位置 = i
				break
			end
		end
		for i=1,位置  do
			remove(self.l_路径, 1)
		end
		if #self.l_路径 == 0 then
			self.l_路径 = 最后
		end
	end
end

function 超级寻路:判断直线障碍(xy,txy,v)
	local 距离 = jls(xy,txy) - 1.5
	local 孤度 = hds(xy,txy)
	local 坐标
	repeat
		坐标 = zbs(xy,距离,孤度)
		if not self:检查点(坐标.x,坐标.y) then
			return true
		end
		距离 = 距离 - 0.5
	until 距离 < 0
end

function 超级寻路:最近坐标(xy)--最近可以行走的坐标
	local 距离 = 1
	local 坐标
	repeat
		for i=0,6,0.5 do
			坐标 = zbs(xy,距离,i)
			if self:检查点(self:坐标算格子(坐标))then
				return 坐标
			end
		end 距离 = 距离 + 1
	until 距离 > 300
end

function 超级寻路:坐标算格子(x,y)
	y,x = x.y,x.x
	return x,y
end

return 超级寻路