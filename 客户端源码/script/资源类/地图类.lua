--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-20 06:07:49
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 地图类 = class()
local ceil = math.ceil
local floor = math.floor
local abs = math.abs
local sort = table.sort
local tp,tps,hc
local insert = table.insert
local remove = table.remove
local pair = pairs
local fgjl = require("script/资源类/gge精灵类")()
local _lj = require("script/资源类/路径类")
local map = require("script/资源类/MAP")
local dtx = require("script/数据中心/特效")
local tytx = require("script/数据中心/庭院特效")
local h,l
local 重新排序 = false

local function 排序(a,b)
	if a.坐标.y == b.坐标.y then
		重新排序 = true
	   	return false
	end
	return b.坐标.y > a.坐标.y
end

function 地图类:初始化(根,根1)
	tp = 根
	tps = 根1
	self.移动xy={}
	self.移动xy.x,self.移动xy.y=tp.角色坐标.x,tp.角色坐标.y
	self.镜头目标   = 生成XY(1,1)
	self.飞行= false
	self.云 = 引擎.场景.资源:载入('新界面.wdf',"网易WDF动画",4046268095)
	self.云1 = 引擎.场景.资源:载入('新界面.wdf',"网易WDF动画",3362353993)
end

function 地图类:加载(文件)
	if hc ~= tp.当前地图 then
		hc = tp.当前地图
		self.mapzz = {}
		--self.增加 = {x=0,y=0,z=0}
		self.db = {}
		self.map = map(文件)
		self.宽度,self.高度,self.行数,self.列数 = self.map.Width,self.map.Height,self.map.MapRowNum,self.map.MapColNum
		self.寻路 = _lj.创建(hc,self.列数*16,self.行数*12,self.map:取障碍())
		self.移动xy.x,self.移动xy.y=tp.角色坐标.x,tp.角色坐标.y
		self.传送tx = nil
		self.特效cw = {}
		self.房屋tx = {}

		self:新载地图特效()
		全局临时路径=文件
	end
end

function 地图类:房屋特效(sj,移动)
	if tp.当前地图 > 100000 then
		if tp.房屋数据.庭院ID == tp.当前地图 then
			if not sj.编号 then
				sj.编号 = #tp.房屋数据.庭院装饰+1
			end
			tp.房屋数据.庭院装饰[sj.编号] = sj
		elseif tp.房屋数据.房屋ID == tp.当前地图 then
			if not sj.编号 then
				sj.编号 = #tp.房屋数据.室内装饰+1
			end
			tp.房屋数据.室内装饰[sj.编号] = sj
		elseif tp.房屋数据.阁楼ID == tp.当前地图 then
			if not sj.编号 then
				sj.编号 = #tp.房屋数据.阁楼装饰+1
			end
			tp.房屋数据.阁楼装饰[sj.编号] = sj
		elseif tp.房屋数据.牧场ID == tp.当前地图 then
			if not sj.编号 then
				sj.编号 = #tp.房屋数据.牧场装饰+1
			end
			tp.房屋数据.牧场装饰[sj.编号] = sj
		end
		table.insert(self.房屋tx,tytx(sj,移动))
	end
end

function 地图类:新载地图特效()
		if tp.当前地图 > 100000 then
			 self.房屋tx = {}
		     if tp.房屋数据.庭院ID == tp.当前地图 then
		     	tp.房屋数据.庭院装饰 = tp.房屋数据.庭院装饰 or {}
		     	for k,v in ipairs(tp.房屋数据.庭院装饰) do
		     		 self:房屋特效(v)
		     	end
		     	local 庭院特效= 取传特效表(tp.房屋数据.庭院地图)
		        if 庭院特效 and 庭院特效[1] then
		            self.房屋tx[#self.房屋tx+1] = dtx(庭院特效[1].x,庭院特效[1].y,庭院特效[1].切换,庭院特效[1].资源)
		        end

		     elseif tp.房屋数据.房屋ID == tp.当前地图 then
		     			tp.房屋数据.室内装饰 = tp.房屋数据.室内装饰 or {}
			          	for k,v in ipairs(tp.房屋数据.室内装饰) do
				     		self:房屋特效(v)
				     	end
		     elseif tp.房屋数据.阁楼ID == tp.当前地图 then
		     		tp.房屋数据.阁楼装饰 = tp.房屋数据.阁楼装饰 or {}
		          	for k,v in ipairs(tp.房屋数据.阁楼装饰) do
				     	 self:房屋特效(v)
				     end
		     elseif tp.房屋数据.牧场ID == tp.当前地图 then
		     		tp.房屋数据.牧场装饰 = tp.房屋数据.牧场装饰 or {}
		          	for k,v in ipairs(tp.房屋数据.牧场装饰) do
				     	 self:房屋特效(v)
				     end
		     end
		else
			if tp.场景特效 then
			     self.特效cw = 取传特效表(tp.当前地图)
				if #self.特效cw > 0 then
					self.传送tx = {}
					for nw=1,#self.特效cw do
						if self.特效cw[nw]~=nil then
						    self.传送tx[nw] = dtx(self.特效cw[nw].x,self.特效cw[nw].y,self.特效cw[nw].切换,self.特效cw[nw].资源)
						end
					end
				end
			end
		end

end


function 地图类:重新加载(文件)
	hc = tp.当前地图
	self.传送初始化= false
	self.mapzz = {}
	--self.增加 = {x=0,y=0,z=0}
	self.db = {}
	self.map = map(文件)
	self.宽度,self.高度,self.行数,self.列数 = self.map.Width,self.map.Height,self.map.MapRowNum,self.map.MapColNum
	self.寻路 = _lj.创建(hc,self.列数*16,self.行数*12,self.map:取障碍())
	self.移动xy.x,self.移动xy.y=tp.角色坐标.x,tp.角色坐标.y
	self.传送tx = nil
	self.特效cw = {}
	self.房屋tx = {}
	self:新载地图特效()
	全局临时路径=文件
end





function 地图类:取角色距离(x,y,距离)
 	local 距离=距离 or 1200
  	if 取两点距离a(tp.角色坐标.x,tp.角色坐标.y,x,y)<=距离 then
   		return true
  	else
   		return false
    end
end



function 地图类:飞行坐骑(开关)
  self.飞行 = 开关

end


--43131456




function 地图类:传送(x,y)
    self.镜头目标.x = x
    self.镜头目标.y = y
    tps.屏幕坐标 = self.镜头目标
    self.传送初始化 = true
end

function 地图类:自动寻路()
	--换地图后继续自动寻路
	if tp.跨地图寻径开关 and tp.跨地图寻径[1]~=nil then
		if tp.跨地图寻径[1].当前地图+0 == tp.当前地图+0 then
			local 内容={x=tp.跨地图寻径[1].x+0,y=tp.跨地图寻径[1].y+0,距离=0}
			请求服务(1001,生成XY(tp.跨地图寻径[1].x+0,tp.跨地图寻径[1].y+0),1)
			tp.场景.人物:设置路径(内容,true)
			table.remove(tp.跨地图寻径,1)
			if #tp.跨地图寻径==0 then
				--tp.跨地图寻径开关 =false
				tp.跨地图寻径={}
			end
		else
			tp.跨地图寻径开关 = false
			tp.跨地图寻径 = {}
		end
	else

	end
end

local function getCameraSpeedNew(diff)
    if(diff > 40) then
        return diff/20
    elseif (diff < -40) then
        return diff/20
    end
    if(diff < 1 and diff > -1) then
        return diff
    end
    if(diff > 0) then
        return 1
    elseif (diff < 0) then
        return -1
    end
end

function 地图类:获取屏幕移动速度()
   	local xyz = 两点算挨打偏移坐标(self.镜头目标,tps.屏幕坐标,6)
	if(xyz.x > 0) then
		xyz.x = math.floor(xyz.x)
	else
		xyz.x = math.ceil(xyz.x)
	end
	if(xyz.y > 0) then
		xyz.y = math.floor(xyz.y)
	else
		xyz.y = math.ceil(xyz.y)
	end
end

function 地图类:镜头更新()


    if(self.传送初始化 == true) then
        tps.屏幕坐标.x = self.镜头目标.x
        tps.屏幕坐标.y = self.镜头目标.y
        self:自动寻路()
        self.传送初始化 = false
        return
    end
    local x_diff,y_diff
    local x_speed,y_speed
    x_diff = self.镜头目标.x - tps.屏幕坐标.x
    y_diff = self.镜头目标.y - tps.屏幕坐标.y


    if(x_diff ~= 0) then
        --x_speed = getCameraSpeed(x_diff)
        x_speed = getCameraSpeedNew(x_diff)
        if(x_speed > 0) then
            x_speed = math.floor(x_speed)
        else
            x_speed = math.ceil(x_speed)
        end
        -- print("x_speed"..x_speed)
        -- print("test"..两点算挨打偏移坐标(self.镜头目标,tps.屏幕坐标,4).x)
        tps.屏幕坐标.x = tps.屏幕坐标.x + x_speed
    else
        tps.屏幕坐标.x = self.镜头目标.x
    end
    if(y_diff ~= 0) then
        --y_speed = getCameraSpeed(y_diff)
        y_speed = getCameraSpeedNew(y_diff)
        if(y_speed > 0) then
            y_speed = math.floor(y_speed)
        else
            y_speed = math.ceil(y_speed)
        end
        tps.屏幕坐标.y = tps.屏幕坐标.y + y_speed
    else
        tps.屏幕坐标.y = self.镜头目标.y
    end
end

function 地图类:检查排序点(p, px,py) --判断目标是否在遮罩后面
	zzx=p[2]
	zzy=p[3]
	zzw=p[4]
	zzh=p[5]
    if px >= zzx and px <= zzx+zzw then
        local x = math.ceil((px - zzx) / 10)
        if x <= 0 then
            return py < zzy
        else
        	return py < zzy+zzh
        end
    elseif px < zzx then
        return py < zzy
    elseif px > zzx + zzw then
        return py < zzy+zzh
    end
    return false
end







function 地图类:显示(pos,偏移,xx,yy,dt,pys1)
	local mp = {}
	local 主角位置1 = ceil(pos.x/320)
	local 主角位置2 = ceil(pos.y/240)
	local 开始位置1 = 主角位置1 - 4
	local 结束位置1 = 主角位置1 + 4
	local 开始位置2 = 主角位置2 - 4
	local 结束位置2 = 主角位置2 + 4
	if self.列数==nil then
	    if 全局临时路径~=nil then
	        self:重新加载(全局临时路径)
	    end
	    return
	end

	if tp.场景特效  then
		if self.传送tx==nil or self.特效cw==nil or (self.特效cw~=nil and #self.特效cw < 0) then
		    self:新载地图特效()
		end
	else
		self.传送tx=nil
		self.特效cw = {}
	end
	if tp.当前地图 > 100000 and #self.房屋tx < 0  then
		self:新载地图特效()
	end

	if 结束位置1 > self.列数  then
		结束位置1 = self.列数
	end
	if 开始位置1 < 1 then
		开始位置1 = 1
		结束位置1 = 结束位置1 + 1
	end
	if 结束位置2 > self.行数 then
		结束位置2 = self.行数
	end
	if 开始位置2 < 1 then
		开始位置2 = 1
	end

	local id
	local zz,mmm
	for h = 开始位置2, 结束位置2 do
		for  l = 开始位置1, 结束位置1 do
			id = ((h-1)*self.列数+l)-1
			if self.db[id] == nil then
				self.db[id] = {{}}
				zz = self.map:取附近遮罩(id)
				for i=1,#zz do
					if self.mapzz[zz[i]] == nil then
						self.mapzz[zz[i]] = 1
					    mmm = {self.map:取遮罩(zz[i])}
						insert(self.db[id][1],mmm)
					end
				end
				self.db[id][2] = {(l-1)*320,(h-1)*240}
				self.db[id][3] = #self.db[id][1]
				self.map:取纹理(id)
				break
			end
		end
	end




	for h = 开始位置2, 结束位置2 do
		for  l = 开始位置1, 结束位置1 do
			id = ((h-1)*self.列数+l)-1

			if self.db[id] ~= nil then
				for i=1,#self.db[id][1] do
					if self:检查排序点(self.db[id][1][i],pos.x,pos.y+30) then
						insert(mp,self.db[id][1][i])
					end
				end
				fgjl:置纹理(self.map.缓存[id])
				if 偏移 == nil or 偏移.x == nil or self.db[id][2] == nil or self.db[id][2][1] == nil or self.db[id][2][2] == nil then
					if 偏移 == nil or 偏移.x == nil then
						tp.窗口.消息框:添加文本("请截图给管理员,谢谢[ 偏移 ]地图问题","系统")
					else
						tp.窗口.消息框:添加文本("请截图给管理员,谢谢[ db ]地图问题","系统")
					end
				else

					fgjl:显示(self.db[id][2][1]+偏移.x,self.db[id][2][2]+偏移.y)


				end
			end
		end
	end





--------------摩托修改两点距离
	for i,v in pairs(self.db) do
	  if self.db[i] ~= nil and self:取角色距离(self.db[i][2][1],self.db[i][2][2],2000) ==false then
		 self.db[i] = nil
		 self.map.缓存[i] = nil
	 end
	end

	if not tp.战斗中 then
		local cs
		if tp.第二场景开启 == false then
			tp.选中假人 = false
			local rw = tps.场景人物
			if tp.窗口.快捷技能栏:检查点(xx,yy) or tp.窗口.底图框:检查点(xx,yy) or tp.窗口.人物框:检查点(xx,yy) or tp.窗口.时辰:检查点(xx,yy) or tp.窗口.任务追踪栏:检查点(xx,yy)  then
				tp.禁止通行 = true
			end


			if self.房屋tx~=nil then
				table.sort(self.房屋tx,排序)
				for n=1,#self.房屋tx do
					if self.房屋tx[n]~=nil  then
					    self.房屋tx[n]:显示(dt,xx,yy,偏移)
					end
				end
			end
			if tps.传送 then
				for k,v in pairs(tps.传送) do
					v:更新(dt,xx,yy,偏移)
					v:显示(dt,xx,yy,偏移)
				end
			end


			-- if tps.传送~=nil and #tps.传送~=nil then
			-- 	for n=1,#tps.传送 do
			-- 		tps.传送[n]:显示(dt,xx,yy,偏移)
			-- 	end
			-- end
			if self.传送tx~=nil and tp.场景特效 then
				for n=1,#self.传送tx do
					if self.特效cw[n]~=nil then
					    self.传送tx[n]:显示(dt,xx,yy,偏移)
					end
				end
			end

			table.sort(rw,排序)

			for n=1,#rw do
				rw[n]:显示(dt,xx,yy,偏移)
			end

			if 重新排序 then
				table.sort(rw,排序)
				重新排序 = false
			end

		else
			--if tp.剧情处理.可视 and tp.剧情处理.显示方式 == 0 then
				if tp.第二场景.人物组 ~= nil then
				 	sort(tp.第二场景.人物组,排序)
				 	for i=1,#tp.第二场景.人物组 do
				 		local v = tp.第二场景.人物组[i]
				 		if v.出现特效 == nil then
				 			tp.影子:显示(v.坐标 + tps.屏幕坐标)
				 		end
				 		v:显示(dt,xx,yy,tps.屏幕坐标)
				 	end
				end
			   if self.传送tx~=nil and tp.场景特效 then
					for n=1,#self.传送tx do
						if self.特效cw[n]~=nil  then
						  self.传送tx[n]:显示(dt,xx,yy,偏移)
						end
					end
				end
			--end
		end
	    if not self.飞行 then
			for i=1,#mp do
				fgjl:置纹理(mp[i][1])
				fgjl:显示(mp[i][2]+偏移.x,mp[i][3]+偏移.y)
			end
		elseif 坐骑显示 then
			self.云:更新()
			self.云1:更新()
			self.云:显示(10,全局游戏高度/3+50)
		     self.云1:显示(全局游戏宽度/2+300,全局游戏高度/3+50)--(全局游戏宽度/2+300,全局游戏高度/3-50)
		end
		if tp.第二场景.人物组 ~= nil then
			for i=1,#tp.第二场景.人物组 do
				local v = tp.第二场景.人物组[i]
				v.喊话:显示(v.坐标.x + tps.屏幕坐标.x,v.坐标.y + tps.屏幕坐标.y)
			end
		end
		if self.传送tx~=nil and tp.场景特效 then
			for n=1,#self.传送tx do
				if self.特效cw[n]~=nil  then
				   self.传送tx[n]:显示(dt,xx,yy,偏移)
				end
			end
		end




           self.镜头目标 = 取画面坐标(tp.角色坐标.x,tp.角色坐标.y,self.宽度,self.高度)

         -- tps.屏幕坐标 = self.镜头目标
         self:镜头更新()
	end
end
return 地图类;
