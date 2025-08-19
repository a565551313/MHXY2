--======================================================================--

--======================================================================--
local 场景类_坐骑染色 = class()
local floor = math.floor
local xslb,bb,lb,tp,fy,gz,方向
local format = string.format
local insert = table.insert

function 场景类_坐骑染色:初始化(根)
	self.ID = 85
	self.x = 220
	self.y = 40
	self.xx = 0
	self.yy = 0
	self.注释 = "坐骑染色"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口时间 = 0
	tp = 根
	self.选中染色=0
	self.原来颜色=0
	self.染色组1=0
	self.染色组2=0
	方向=0
end

function 场景类_坐骑染色:打开(b,l,c)
	if b~=nil and self.可视 then self.可视=false end
	if self.可视 then
		if b ~= nil and bb ~= b then
			bb = b
			fy = 0
			self:置形象(方向)
			tp.运行时间 = tp.运行时间 + 1
		    self.窗口时间 = tp.运行时间
		    return false
		end
		fy = nil
		bb = nil
		xslb = nil
		self.可视 = false
		self.资源组=nil
		self.染色组=nil
	else
		fy = 0
		bb = b
		insert(tp.窗口_,self)
		self:加载数据()
		self:置形象(方向)
		tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    if bb.染色方案~=nil then
	        self.原来颜色=bb.染色方案
	    	self.染色组1=bb.染色组[1]
	    	self.染色组2=bb.染色组[2]
	    end
	    self.可视 = true
	end
end

function 场景类_坐骑染色:加载数据()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,465,451,3,9),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[3] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x5B52CB27),
		[4] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"还原"),
		[5] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"染色"),
		[8] = 自适应.创建(1,1,461,18,1,3,nil,18),
		[9] = 按钮.创建(tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x01000026),0,0,4,true,true),
	}
	self.染色组={}
	for n=1,80 do
		self.染色组[n]=按钮.创建(自适应.创建(10,4,28,21,1,3),0,0,4,true,true,n)
	end
end

function 场景类_坐骑染色:置形象(方向)
	if bb ~= nil then
		self.资源组[6] = nil
		self.资源组[7] = nil
		local n = 引擎.坐骑库(tp.队伍[1].模型,bb.模型,bb.饰品 or "空",bb.饰品2 or "空")--ani(tp.坐骑列表[self.选中].模型)
		self.资源组[6] = tp.资源:载入(n.坐骑资源,"网易WDF动画",n.坐骑站立)
		if bb.饰品 ~= nil then
			self.资源组[7] = tp.资源:载入(n.坐骑饰品资源,"网易WDF动画",n.坐骑饰品站立)--饰品
		end
		if bb.染色方案 ~= nil then
			if bb.染色方案 == "黑白" then
				self.资源组[6]:置染色("黑白",ARGB(255,235,235,235))
				self.资源组[6]:置方向(方向)
				if bb.饰品 ~= nil then
					self.资源组[7]:置染色("黑白",ARGB(255,185,185,185))
					self.资源组[7]:置方向(方向)
				end
			else
				if self.选中染色~=0 then
				    bb.染色方案=染色方案[self.选中染色].id
				    bb.染色组[1]=染色方案[self.选中染色].方案[1]
				    bb.染色组[2]=染色方案[self.选中染色].方案[2]
				    self.资源组[6]:置染色(bb.染色方案,bb.染色组[1],bb.染色组[2],bb.染色组[3])
					self.资源组[6]:置方向(方向)
				else
					bb.染色方案=nil
					bb.染色组[1]=nil
					bb.染色组[2]=nil
					--self.资源组[6]:置染色(bb.染色方案,bb.染色组[1],bb.染色组[2],bb.染色组[3])
					self.资源组[6]:置方向(方向)
				end
			end
		else
			if bb.染色方案==nil then
				bb.染色组={}
			    bb.染色方案=0
			 	bb.染色组[1]=0
			 	bb.染色组[2]=0
			end
			 bb.染色方案=0
			 bb.染色组[1]=0
			 bb.染色组[2]=0
			if self.选中染色~=0 then
			    bb.染色方案=染色方案[self.选中染色].id
			    bb.染色组[1]=染色方案[self.选中染色].方案[1]
			    bb.染色组[2]=染色方案[self.选中染色].方案[2]
			    self.资源组[6]:置染色(bb.染色方案,bb.染色组[1],bb.染色组[2],bb.染色组[3])
				self.资源组[6]:置方向(方向)
			end
		end
	end
end

function 场景类_坐骑染色:显示(dt,x,y)
	self.焦点 = false
	self.资源组[2]:更新(x,y)
	self.资源组[4]:更新(x,y)
	self.资源组[5]:更新(x,y)
	self.资源组[9]:更新(x,y)
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[4]:显示(self.x + 25,self.y + 218-30)
	self.资源组[5]:显示(self.x + 90,self.y + 218-30)
	self.资源组[3]:显示(self.x + 15,self.y + 30)
	self.资源组[8]:显示(self.x+2,self.y+2)
	tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	zts1:显示(self.x+self.资源组[1].宽度/2-30,self.y+3,self.注释)
	zts1:显示(self.x+15,self.y+218,"选中颜色为："..self.选中染色)
	tp.宽竖排花纹背景_:置区域(0,0,37,166)
	tp.宽竖排花纹背景_:显示(self.x+153,self.y+31)
	tp.宽竖排花纹背景_:置区域(0,549,37,38)
	tp.宽竖排花纹背景_:显示(self.x+153,self.y+200)
	tp.物品界面背景_:显示(self.x+192,self.y+29)
	self.资源组[2]:显示(self.x + 444,self.y + 2)
	self.资源组[9]:显示(self.x + 25,self.y +152)
	local xx = 0
	local yy = 0
	for n=1,80 do
		self.染色组[n]:更新(x,y,self.选中染色~=n)
		self.染色组[n]:显示(self.x+15+37*xx,self.y+255+yy*27)
		xx = xx + 1
		if xx > 11 then
			xx = 0
			yy = yy + 1
		end
		if self.鼠标 then
		    if self.染色组[n]:事件判断() then
		    	self.选中染色=n
		    	self:置形象(方向)
		    end
		end
	end
	if self.鼠标 then
		if self.资源组[2]:事件判断() then
			self:打开()
			return false
		elseif self.资源组[4]:事件判断() then
			self.选中染色=0
			self:置形象(方向)
		elseif self.资源组[5]:事件判断() then
			请求服务(3749,{序列=bb.认证码,序列1=bb.染色方案,序列2=bb.染色组[1],序列3=bb.染色组[2],序列4=bb.染色组[3]})
		elseif self.资源组[9]:事件判断() then
			方向 = 方向 - 1
			if 方向<0 then
			    方向=3
			end
			self:置形象(方向)
		end
	end
	if self.资源组[6] ~= nil then
		tp.影子:显示(self.x + 116-40,self.y+152-15)
		self.资源组[6]:更新(dt)
		self.资源组[6]:显示(self.x + 116-40,self.y+152-15)
		if self.资源组[7] ~= nil then
			self.资源组[7]:更新(dt)
			self.资源组[7]:显示(self.x + 116-40,self.y+152-15)
		end
	end
	local 字体 = tp.字体表.普通字体
	字体:置颜色(黑色)
	-- 字体:显示(self.x + 25,self.y + 38,bb.模型)

end

function 场景类_坐骑染色:检查点(x,y)
	if self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_坐骑染色:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_坐骑染色:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_坐骑染色