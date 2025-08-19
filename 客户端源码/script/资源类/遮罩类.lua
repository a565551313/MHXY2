--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2018-11-13 19:56:55
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 遮罩类 = class()

local xys = 生成XY
local random = math.random

function 遮罩类:初始化(精灵)
    self.精灵 = 精灵
    self.xy     = xys(精灵.X,精灵.Y)
    self.排序点   = 精灵.排序点
    self.随机     = random(1,1200)/100 --随机排序值,防止相同排序点出现.
    self.是否遮罩 = true
    self.可见 = true
    self.坐标    = xys(精灵.X+10,self.排序点)
end

function 遮罩类:固定(v)
    self.是否固定   = v
    self.可见       = v
end

function 遮罩类:检查点(x,y)
    return self.精灵:检查点(x,y)
end

function 遮罩类:取排序点(xy)
    return self.排序点+self.随机
end

function 遮罩类:显示(dt,xx,yy,偏移)
   -- if self.可见  then
        self.精灵:显示(self.xy+偏移)
   --end
end

return 遮罩类