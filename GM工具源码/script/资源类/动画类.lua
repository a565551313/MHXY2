--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2020-02-22 08:37:03
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 动画类 = class()

local _was  = require("script/资源类/SP")
local jls   = require("gge精灵类")
local ceil  = math.ceil

function 动画类:初始化(p,len,文件,文件号)
	self.was = _was(p,len)
	--print(p,len)
	self.方向数 = self.was.方向数
	self.帧数 = self.was.帧数
	self.宽度 =	self.was.宽度
	self.高度 = self.was.高度
	self.信息组 = {}
	self.信息组[0] = self.was:取纹理(0)
	self.数量 = self.was.总帧数
	self.精灵 = jls(self.信息组[0][1])
	self.开始帧 = 0
	self.结束帧 = 0
	self.当前帧 = 0
	self.时间累积 = 0
	self.差异 = 0
	self.已载入 = 0
	self.提速 = 0
	self.帧率=0.1
	self.x = 0
	self.y = 0
	self.禁止显示=len
	self:置方向(0)
end

function 动画类:置提速(v)
	self.提速 = v or 0
end

function 动画类:置染色(id,a,b,c,d)
	if id == nil then
		return
	end
	if id == "黑白" then
		self.hdj = a
		return
	end
	self.was:置调色板(wdf配置.."/"..[[wpal\]]..id..".wpal")
	self.was:调色(a or 0,b or 0,c or 0,0)
	self.信息组 = {}
	self.信息组[0] = self.was:取纹理(0)
	self.精灵:置纹理(self.信息组[0][1])
	self.已载入 = 0
	self:置方向(0)
end

function 动画类:置武器染色(id,a,b,c,d)
	if id == nil then
		return
	end
	if id == "黑白" then
		self.hdj = a
		return
	end
	self.was:置调色板(wdf配置.."/"..[[wpal\]]..id..".wpal")
	self.was:调色(a or 0,b or 0,c or 0,0)
	self.信息组 = {}
	self.信息组[0] = self.was:取纹理(0)
	self.精灵:置纹理(self.信息组[0][1])
	self.已载入 = 0
	self:置方向(0)
end

function 动画类:灰度级()
	self.精灵:灰度级()
end

function 动画类:是否选中(x,y) return self.精灵:是否选中(x,y) end

function 动画类:取间隔() return self.当前帧 - self.开始帧 end

function 动画类:取中间() return ceil((self.结束帧 - self.开始帧)/2) end

function 动画类:置差异(v) self.差异 = v end

function 动画类:置高亮(v) self:置混合(1) self:置颜色(-13158601) end

function 动画类:置高亮模式(a) self:置混合(1) self:置颜色(a) end

function 动画类:取消高亮(v) self:置混合(0) self:置颜色(4294967295) end

function 动画类:置混合(b) self.精灵:置混合(b or 0) end

function 动画类:置颜色(v,i) self.精灵:置颜色(v,i or -1) end

function 动画类:取宽度() if self.帧数 == 1 then return self.宽度+5 else return self.宽度 end end

function 动画类:取高度() if self.帧数 == 1 then return self.高度+5 else return self.高度+6 end end

function 动画类:取高度s() return self.高度 end

function 动画类:更新纹理()
	if self.信息组[self.当前帧] == nil then
		self.信息组[self.当前帧] = self.was:取纹理(self.当前帧)
		self.已载入 = self.已载入 +1
	end
	self.精灵:置纹理(self.信息组[self.当前帧][1])
end
function 动画类:取当前帧()

 return self.当前帧


 end


function 动画类:取结束帧()

 return self.结束帧


 end


 function 动画类:取开始帧()

 return self.开始帧


 end

function 动画类:更新(dt,zl,pt)
	dt = dt or 引擎.取帧时间()
	if zl ~= nil and zl ~= 0 then
		dt = dt / zl
	elseif self.提速 ~= 0 then
		dt = dt * self.提速
	end
	self.时间累积 = self.时间累积 + dt


	if (self.时间累积 > self.帧率) then
		self.当前帧 = self.当前帧 + 1
		if (self.当前帧 > self.结束帧 - self.差异) then
			self.当前帧 = self.开始帧
		end
		self.时间累积 = 0
		if pt == nil then
			self:更新纹理()
		end
	end
end

function 动画类:显示(x,y)
	if self.禁止显示==19880 then return  end
	if self.信息组[self.当前帧] ~= nil then
		if y == nil then
			y,x=x.y,x.x
		end
		self.x = x - (self.信息组[self.当前帧][2] or self.信息组[0][2])
		self.y = y - (self.信息组[self.当前帧][3] or self.信息组[0][3])
		if self.hdj then
			self.精灵:灰度级()
			self.精灵:置颜色(self.hdj)
		end
		self.精灵:显示(self.x,self.y)
	end
end

function 动画类:换帧更新(d,c)
	self.开始帧 = self.方向 * self.帧数
    self.结束帧 = self.帧数 + self.开始帧 - 1
    self.当前帧 = self.开始帧
    self:更新纹理()
end







function 动画类:置方向(d,c)
	if self.方向~=d or c then
	--if  c then
		if d ~= nil then
			if d > self.方向数 then
				d = 0
			end
			self.开始帧 = d * self.帧数
			self.结束帧 = self.帧数 + self.开始帧 - 1
			self.当前帧 = self.开始帧
			self:更新纹理()
			self.方向 = d
		end
	end
end

function 动画类:置区域(x,y,w,h)
	self.精灵:置区域(x,y,w,h)
end

return 动画类