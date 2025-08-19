--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-06-08 15:09:05
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 动画类 = class()

local _was  = require("script/资源类/SP")
local jls   = require("script/资源类/gge精灵类")
--local jls   = require("gge精灵类")
local ceil  = math.ceil


function 动画类:初始化(wj,文件号,p,len)
	-- if 加载 then
	--    self._key = wj.."_"..文件号
	-- end
	 self.path = string.format('%s:%s:%s',len, wj or 'null', 文件号 or 'null')
        --print(self.path,"===============")
    if 全局资源缓存[self.path] then --5分钟缓存
        全局资源缓存[self.path].time = os.time() + 180
        self.was = 全局资源缓存[self.path]
    elseif 全局资源缓存弱[self.path] then --弱缓存
            全局资源缓存[self.path] = 全局资源缓存弱[self.path]
            全局资源缓存弱[self.path] = nil
            全局资源缓存[self.path].time = os.time() + 180
        self.was = 全局资源缓存[self.path]
    else
        全局资源缓存[self.path] = _was(p,len)
        self.was = 全局资源缓存[self.path]
    end
    -- if not self.was.缓存 then
    --     self.was.缓存={}
    -- end
	--self.was = _was(p,len)
    --self.was.缓存= setmetatable({}, {__mode = 'v'})
	self.方向数 = self.was.方向数
	self.帧数 = self.was.帧数
	self.宽度 =	self.was.宽度
	self.高度 = self.was.高度
	self.信息组 = {}
	--self.信息组[0] = self.was:取纹理(0) --全局资源缓存[len..wj..文件号]
	self.数量 = self.was.总帧数
	--self.精灵 = jls(self.信息组[0][1])
	self.精灵 = jls()
	self.开始帧 = 0
	self.结束帧 = 0
	self.当前帧 = 0
	self.时间累积 = 0
	self.差异 = 0
	self.已载入 = 0
	self.提速 = 0
	self.帧率 = 0.1
	self.x = 0
	self.y = 0
	self.禁止显示=len
	-- self.灰度 = false
	self:置方向(0)

end

function 动画类:置提速(v)
	self.提速 = v or 0
end



function 动画类:调色(...)
	local v = {...}
	local n,p = 0
	for i=0,255 do
		if i==self.was.PalList[n] then--调色板位置
			if v[n+1] and v[n+1]<self.was.Palette[n].n then
				p=self.was.Palette[n].p[v[n+1]].Color --方案位置
				if p[0].R ~= 255 and p[1].R ~= 255 and p[1].G ~= 255 and p[2].R ~= 255 then

				end
			else
				p=self.was.Palette[n].p[0].Color --方案位置
			end
			n=n+1
		end
		_RGB565to888_Pal(self.was.Palette16[i],self.Palette32+i,p)
	end
end


function 动画类:炫彩调色(sj1,sj)--新版本修改
    local v = sj1
    local rs = sj
    local n,p = 0
    for i=0,255 do
        if i==self.was.PalList[n] then--调色板位置
            if v[n+1] and v[n+1]<self.was.Palette[n].n then
                p=self.was.Palette[n].p[v[n+1]].Color --方案位置
                if rs[v[n+1]] then
                    if p[0].R ~= 255 and p[1].R ~= 255 and p[1].G ~= 255 and p[2].R ~= 255 then
                        p[0] = {R=rs[v[n+1]][1].R,G=rs[v[n+1]][1].G,B=rs[v[n+1]][1].B}
                        p[1] = {R=rs[v[n+1]][2].R,G=rs[v[n+1]][2].G,B=rs[v[n+1]][2].B}
                        p[2] = {R=rs[v[n+1]][3].R,G=rs[v[n+1]][3].G,B=rs[v[n+1]][3].B}
                    end
                else --我加的
                    if p[0].R ~= 255 and p[1].R ~= 255 and p[1].G ~= 255 and p[2].R ~= 255 then
                        p[0] = {R=rs[1][1].R,G=rs[1][1].G,B=rs[1][1].B}
                        p[1] = {R=rs[2][2].R,G=rs[2][2].R,B=rs[2][2].R}
                        p[2] = {R=rs[3][3].B,G=rs[3][3].B,B=rs[3][3].B}
                    end
                end
            else
                p=self.was.Palette[n].p[0].Color --方案位置
            end
            n=n+1
        end
        _RGB565to888_Pal(self.was.Palette16[i],self.Palette32+i,p)
    end
end
function 动画类:恢复调色()
    for i=0,255 do
        _RGB565to888(self.was.Palette16[i],self.Palette32+i)
    end
end

function 动画类:置染色(id, a, b, c)
    if not id then return end
    if id == "黑白" then
        self.hdj = a or 0
        self.染色 = false
        return
    end
    if not self.调色板id or self.调色板id ~= id then
        local 路径 = string.format("%s/wpal/%s.wpal", wdf配置, id)
        if self.was:置调色板(路径) then
            self.调色板id = id
            self.Palette32 = nil
        else
            print("警告：调色板加载失败 - "..路径)
            return
        end
    end

    if not self.Palette32 then
        self.Palette32 = self.was:取空染色() or error("染色模板初始化失败")
    end

    self:调色(
        tonumber(a) or 0,
        tonumber(b) or 0,
        tonumber(c) or 0,
        0
    )

    self.染色 = true
    self:重置纹理()
    self:置方向(0)
end

function 动画类:炫彩染色(id,sj,位置)--新版本修改
    if id == nil then
        return
    end
    if id == "黑白" then
        self.hdj = a
        return
    end
    if not self.was.Palette then
        self.was:置调色板(wdf配置.."/"..[[wpal\]]..id..".wpal",id)
    end
    if self.was.Palette then
        self.染色 = true
        if not self.Palette32 then
            self.Palette32 = self.was:取空染色()
        end
        local wz
        if id <= 12 or (id>=200 and id <= 300) then
            wz = {1,1,1,0}
        elseif 位置 then
            wz = 位置
        else
            wz = 取染色方案(id)
        end
        self:炫彩调色(wz,sj)
        self:重置纹理()
        self:置方向(0)
    end
end

function 动画类:恢复染色()--新版本修改
    self.染色 = false
    self.Palette32 = nil
    self:重置纹理()
end








function 动画类:更新纹理()--新版本修改
    if self.信息组[self.当前帧] == nil then
        if self.染色  then
            self.信息组[self.当前帧] = self.was:取纹理(self.当前帧,self.Palette32)
        elseif self.灰度 then
            self.信息组[self.当前帧] = self.was:取纹理(self.当前帧)
            self.信息组[self.当前帧][1] = self.信息组[self.当前帧][1]:灰度级()
        else
            if not self.was.缓存[self.当前帧] then
                self.was.缓存[self.当前帧] = self.was:取纹理(self.当前帧)
            end
            self.信息组[self.当前帧] = self.was.缓存[self.当前帧]
        end
    end
    self.精灵:置纹理(self.信息组[self.当前帧][1])
end


-- function 动画类:灰度级()
-- 	-- self.灰度 = true
-- 	self.精灵:灰度级()
-- end

function 动画类:灰度级()
    if not self.灰度 then
        self.灰度=true
       	self:重置纹理()
        --self:更新纹理()
    end
end

function 动画类:取消灰度级()
    if self.灰度 then
        self.灰度=false
        self:重置纹理()
       -- self:更新纹理()
    end
end

-- function 动画类:重置纹理()
-- 	self.信息组 = {}
-- 	self.信息组[0] = self.was:取纹理(0)
-- 	self.精灵:置纹理(self.信息组[0][1])
-- 	self.已载入 = 0
-- 	-- self.灰度 = false
-- end

function 动画类:重置纹理()
    self.信息组 = {}
    self:更新纹理()
    self.已载入 = 0
    -- self.灰度 = false
end

-- function 动画类:重置纹理()
-- 	self.信息组 = {}
-- 	self.信息组[0] = self.was:取纹理(0)
-- 	self.精灵:置纹理(self.信息组[0][1])
--     self:更新纹理()
-- end

function 动画类:释放()
	--self.精灵:释放(true)
	self.精灵:释放(true)
  --  递归清空(self)
end
function 动画类:是否选中(x,y) return self.精灵:是否选中(x,y) end

function 动画类:取间隔() return self.当前帧 - self.开始帧 end

function 动画类:取中间() return ceil((self.结束帧 - self.开始帧)/2) end

function 动画类:置差异(v) self.差异 = v
end

function 动画类:置高亮(v) self:置混合(1) self:置颜色(-13158601) end

function 动画类:置高亮模式(a) self:置混合(1) self:置颜色(a) end

function 动画类:取消高亮(v) self:置混合(0) self:置颜色(4294967295) end

function 动画类:置混合(b) self.精灵:置混合(b or 0) end

function 动画类:置颜色(v,i) self.精灵:置颜色(v,i or -1) end

function 动画类:取宽度() if self.帧数 == 1 then return self.宽度+5 else return self.宽度 end end

function 动画类:取高度() if self.帧数 == 1 then return self.高度+5 else return self.高度+6 end end

function 动画类:取高度s() return self.高度 end

function 动画类:取当前帧()
  return self.当前帧
end

function 动画类:取结束帧()
  return self.结束帧
end

function 动画类:取开始帧()
 return self.开始帧
end

function 动画类:置当前帧(帧)

 self.当前帧 = 帧

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
		-- self:更新纹理()
		-- print(pt)
		if pt == nil then
			self:更新纹理()
		end
	end
end


function 动画类:显示(x,y,htx,hty)
    if htx == true then htx = nil end
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
        self.精灵:显示(self.x,self.y,htx,hty)
    end
end

function 动画类:换帧更新(d,c)
	self.开始帧 = self.方向 * self.帧数
    self.结束帧 = self.帧数 + self.开始帧 - 1
    self.当前帧 = self.开始帧
    self:更新纹理()
end

function 动画类:换帧更新1(d,c)
	self.开始帧 = self.方向 * self.帧数
    self.结束帧 = self.帧数 + self.开始帧 - 1
    self.当前帧 = self.结束帧
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

function 动画类:置翻转(x,y,h)
	self.精灵:置翻转(x,y,h)
end



return 动画类