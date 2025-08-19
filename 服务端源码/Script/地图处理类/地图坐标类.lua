--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-12 16:14:56
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 地图坐标类 = class()
local map类 = require("Script/地图处理类/MAP")
function 地图坐标类:初始化(文件,传送)
  self.mapzz = {}
  self.增加 = {x=0,y=0,z=0}
  self.db = {}
  self.map = map类([[scene/]]..文件..".map")
  self.宽度,self.高度,self.行数,self.列数 = self.map.Width,self.map.Height,self.map.MapRowNum,self.map.MapColNum
  self.寻路 = 路径类.创建(hc,self.列数*16,self.行数*12,self.map:取障碍())
  self.map = nil
  self.路径点={}
  local 临时高度=self.高度/20
  local 临时宽度=self.宽度/20
  for n=1,临时宽度 do
    for i=1,临时高度 do
      local xy={x=n,y=i}
      local 允许=true
      if 传送 then
        for w=1,#传送 do
          if 取两点距离(xy,传送[w])<5 then
            允许=false
          end
        end
      end
      if xy.x<20 or xy.y<20 or xy.x>=self.宽度-20 or xy.y>=self.高度-20 then
        允许=false
      end
      if 允许 and self.寻路:检查点(xy.x,xy.y) then
        self.路径点[#self.路径点+1]={x=xy.x,y=xy.y}
      end
    end
  end
  -- self.寻路 =nil
end

function 地图坐标类:取随机点()
  local 随机点=取随机数(1,#self.路径点)
  return {x=self.路径点[随机点].x,y=self.路径点[随机点].y}
end
function 地图坐标类:更新(dt) end
function 地图坐标类:显示(x,y) end

return 地图坐标类