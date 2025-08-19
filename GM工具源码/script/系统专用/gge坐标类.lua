-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2016-04-17 19:35:04
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-06-09 23:26:21

local point = class()

local _eq 		= function (a,b) return a.x==b.x and a.y==b.y end
local _add 		= function (a,b) return point(a.x + b.x,a.y + b.y) end
local _tostring = function (a,b) return "ggePoint",string.format("%s,%s",a.x,a.y) end
local _sub 		= function (a,b) return point(a.x - b.x,a.y - b.y) end
local _mul 		= function (a,b) return point(a.x * b.x,a.y * b.y) end
local _div 		= function (a,b) return point(a.x / b.x,a.y / b.y) end
local _concat 	= function (a,b) return string.format("%s,%s",a.x + b.x,a.y + b.y) end
--__mod %
--__unm
--__lt <
--__le <=
function point:初始化(x,y)
	self.x = tonumber(x) or 0
	self.y = tonumber(y) or 0
	self[1] = self.x
	self[2] = self.y
	local t = getmetatable(self)
	t.__eq 			= _eq
	t.__tostring 	= _tostring
	t.__add 		= _add
	t.__sub 		= _sub
	t.__mul 		= _mul
	t.__div 		= _div
	t.__concat 		= _concat
end
function point:ceil()
	self.x = math.ceil(self.x)
	self.y = math.ceil(self.y)
	return self
end
function point:floor()
	self.x = math.floor(self.x)
	self.y = math.floor(self.y)
	return self
end
function point:unpack()
	return self.x,self.y
end
function point:更新(x,y)
	self.x = x
	self.y = y
end
function point:复制()
	return point(self.x,self.y)
end
--取两点距离
function point:取距离(p)
	return math.sqrt (math.pow(self.x-p.x,2) + math.pow(self.y-p.y,2))
end
--取两点弧度
local pi2 =  math.pi*2
function point:取弧度(p)
	local x = self.x
	local y = self.y
	if(p.y ==y and p.x==x)then
		return 0
	elseif(p.y >=y and p.x<=x)then
		return math.pi-math.abs(math.atan((p.y-y)/(p.x-x)))
	elseif(p.y <=y and p.x>=x)then
		return pi2-math.abs(math.atan((p.y-y)/(p.x-x)))
	elseif(p.y <=y and p.x<=x)then
		return math.atan((p.y-y)/(p.x-x))+math.pi
	elseif(p.y >=y and p.x>=x)then
		return math.atan((p.y-y)/(p.x-x))
	end
end
function point:取角度(p)
	return math.deg(self:取弧度(p))
end
function point:取地图位置(w,h)--图块宽高
	return point(math.ceil(self.x/w), math.ceil(self.y/h))
end
function point:取距离坐标(r,a) --r距离,a孤度
	local x,y = 0,0

	x=r* math.cos(a)+self.x
	y=r* math.sin(a)+self.y
	return point(x,y)
end
function point:取移动坐标(dst,r)
	local a = self:取弧度 (dst)
	return self:取距离坐标(r,a)
end
function point:取屏幕坐标(w,h) --地图宽高
	local w2,h2 = 引擎.宽度2,引擎.高度2--窗口宽高的一半
	local rx,ry = 0,0
	local x,y = self.x,self.y
	if w >引擎.宽度 then
		if (x>w2 and x<w-w2) then
			rx = -(x-w2)
		elseif x<=w2 then
			rx=0
		elseif x>=w-w2 then
			rx=-(w-引擎.宽度)
		end
	end
	if h > 引擎.高度 then
		if (y>h2 and y<h-h2) then
			ry = -(y-h2)
		elseif y<=h2 then
			ry=0
		elseif y>=h-h2 then
			ry=-(h-引擎.高度)
		end
	end


	return point(rx,ry)
end
--@参数 半径,边数,颜色
function point:显示(r,num,color)
	r = r or 3
	num = num or 20
	color = color or 0xFFFF0000
	local draw = 引擎.画线

	local a = 360/num
	local pxy,pxy1
	for i=0,num-1 do
		pxy = self:取距离坐标(r,math.rad(i*a))
		pxy1 = self:取距离坐标(r,math.rad((i+1)*a))
		draw(pxy.x,pxy.y,pxy1.x,pxy1.y,color)
	end
end
return point