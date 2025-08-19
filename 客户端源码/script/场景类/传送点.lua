--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-25 12:15:22
--======================================================================--
local tp
local xys = 生成XY
local jlb = 取两点距离
local 场景类_传送点 = class()

-- function 场景类_传送点:初始化(x,y,切换,id)
-- 	if tp == nil then
-- 		tp = 引擎.场景
-- 	end
-- 	self.坐标 = xys(x*20,y*20)
-- 	self.切换 = 切换
-- 	self.id = id
-- 	self.传送延时=系统参数.时间
-- end

function 场景类_传送点:初始化(数据)
	if tp == nil then
		tp = 引擎.场景
	end
	self.坐标 = xys(数据.x*20,数据.y*20)
	self.编号 = 数据.编号
	self.传送延时=系统参数.时间
end


function 场景类_传送点:更新(dt,x,y,pys)
	if not 全局自动走路开关 and jlb(tp.角色坐标,self.坐标) < 800 and (tp.角色坐标.x >= self.坐标.x-26 and tp.角色坐标.x <= self.坐标.x + 44 and tp.角色坐标.y >= self.坐标.y-9 and tp.角色坐标.y <= self.坐标.y + 45) then
			local kcs = true
			local sl = #tp.场景.人物.目标格子
			if sl > 0 then
				local dz = xys(tp.场景.人物.目标格子[sl].x*20,tp.场景.人物.目标格子[sl].y*20)
				if jlb(tp.角色坐标,dz) >= 800 then -- 若人物走到传送点阵时，人物与寻路目标点大于屏幕范围则不进行传送
					kcs = false
				end
			end
			if kcs and 系统参数.时间-self.传送延时>=3 then
				 self.传送延时=系统参数.时间
				 请求服务(1002,{x=math.floor(tp.角色坐标.x),y=math.floor(tp.角色坐标.y)},1)
				 请求服务(1003,{编号=self.编号})
			end
			return
	end
end



function 场景类_传送点:显示(dt,x,y,pys,zd)
	if jlb(tp.角色坐标,self.坐标) < 800 then
		tp.传送点:显示(self.坐标.x + pys.x,self.坐标.y + pys.y,zd)
	end
end

return 场景类_传送点

