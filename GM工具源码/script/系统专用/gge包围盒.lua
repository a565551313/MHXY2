-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-01-27 03:51:34
-- @最后修改来自: baidwwy
-- @Last Modified time: 2017-09-24 15:56:30
--======================================================================--
--======================================================================--
local ggeobj = class()

--x,y,宽度,高度,是否创建核心
function ggeobj:初始化(x,y,w,h) self.x = x or 0 self.y = y or 0 self.w = w or 0 self.h = h or 0 self.x2 = self.x+self.w self.y2 = self.y+self.h end

function ggeobj:检查点(x,y) if x>=self.x and x<=self.x2 and y>=self.y and y<=self.y2 then  return true end end

function ggeobj:置中心(x,y) self.中心x = x or self.中心x self.中心y = y or self.中心y self.x = self.x -self.中心x self.y = self.y -self.中心y self.x2 = self.x+self.w self.y2 = self.y+self.h end

function ggeobj:置坐标(x,y) self.x = x self.y = y self.x2 = self.x+self.w self.y2 = self.y+self.h end

function ggeobj:置宽高(x,y) self.w = x self.h = y self.x2 = self.x+self.w self.y2 = self.y+self.h end

local 画线 = 引擎.画线
function ggeobj:显示(c)
	c = c or -1
	画线(self.x,self.y,self.x2,self.y,c)--上
	画线(self.x,self.y2,self.x2,self.y2,c)--下
	画线(self.x,self.y,self.x,self.y2,c)--左
	画线(self.x2,self.y,self.x2,self.y2,c)--右
end

return ggeobj