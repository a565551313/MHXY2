--======================================================================--
--	☆ 作者：飞蛾扑火 QQ：1415559882
--======================================================================--
local 场景类_坐骑资质栏 = class()
local zts,bb,tp,zts1
local yx = {{68,4},{25,28},{111,28},{24,75},{111,75},{68,97}}
local insert = table.insert
local bds = {"攻击资质","防御资质","体力资质","法力资质","速度资质","躲闪资质"}
local bds1 = {"寿命","成长","五行"}

function 场景类_坐骑资质栏:初始化(根)
	self.ID = 76
	self.xx = 0
	self.yy = 0
	self.注释 = "坐骑资质栏"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	tp = 根
	zts = tp.字体表.普通字体
	zts1 = tp.字体表.描边字体
	self.状态 = 1
	self.窗口时间 = 0
end

function 场景类_坐骑资质栏:打开(b)
	if self.可视 then
		if b ~= nil and  b ~= bb then
			bb = b
			for i=1,3 do
			    self.物品[i]:置物品(bb.装备[i])
			end
			return
		end
		self.状态 = nil
		self.可视 = false
		self.资源组 = nil
		self.物品 = nil
		return
	else
		insert(tp.窗口_,self)
		local 资源 = tp.资源
		local 按钮 = tp._按钮
		local 自适应 = tp._自适应
		self.资源组 = {
			[1] = 自适应.创建(0,1,242,320,3,9),
			[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
			--[6] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x68D384BD),
			[6] = 资源:载入('房屋图标.wdf',"网易WDF动画",0x00000030),
			[7] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x7367031D),
			[8] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x1E714129),
			[9] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xF2FC2425),
			[10] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x10E2B4A7),
			[11] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xC361C087),
			[12] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x4FC09361),
			[13] = 自适应.创建(3,1,95,18,1,3),
			[14] = 自适应.创建(1,1,238,18,1,3,nil,18),
		}

		self.资源组[12]:置区域(14,31,184,66)
		self.物品 = {}
		local wp = tp._物品格子
		for i=1,3 do
		    self.物品[i] = wp(0,0,i,"坐骑资质物品")
		end
		self.资源组[2]:绑定窗口_(76)
		bb = b
		for i=1,3 do
		    self.物品[i]:置物品(bb.装备[i])
		end
		self.状态 = 1
		tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end

function 场景类_坐骑资质栏:显示(dt,x,y)
	self.焦点 = false
	self.资源组[2]:更新(x,y)
	if self.资源组[2]:事件判断() then
		self:打开()
		return false
	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[14]:显示(self.x+2,self.y+2)

	 tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	zts1:置字间距(3)
	zts1:显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"坐骑资质")
	zts1:置字间距(0)
	self.资源组[12]:显示(self.x+30,self.y+27)
	zts1:置字间距(10)
	for i=0,5 do
		zts1:显示(self.x+23,self.y+98+i*23,bds[i+1])
		self.资源组[13]:显示(self.x+124,self.y+96+i*23)
	end
	zts1:置字间距(58)
	zts1:置颜色(-1404907)
	for i=0,2 do
		zts1:显示(self.x+23,self.y+236+i*23,bds1[i+1])
		self.资源组[13]:显示(self.x+124,self.y+234+i*23)
	end
	zts1:置颜色(4294967295)
	zts1:置字间距(0)
	self.资源组[2]:显示(self.x+221,self.y+2)
	local xx = 0
	local yy = 0
	for i=1,3 do
	    self.物品[i]:置坐标(self.x + 37 + (i-1) *60,self.y + 31)
	    self.物品[i]:显示(dt,x,y,self.鼠标)
	   	if self.物品[i].物品 ~= nil and self.物品[i].焦点 then
			tp.提示:道具行囊(x,y,self.物品[i].物品)
	   	end
	end
	zts:置颜色(-16777216)
	zts:显示(self.x+131,self.y+100,bb.攻击资质)
	zts:显示(self.x+131,self.y+123,bb.防御资质)
	zts:显示(self.x+131,self.y+146,bb.体力资质)
	zts:显示(self.x+131,self.y+169,bb.法力资质)
	zts:显示(self.x+131,self.y+192,bb.速度资质)
	zts:显示(self.x+131,self.y+215,bb.躲闪资质)
    if bb.寿命~=nil then
      zts:显示(self.x+131,self.y+238,bb.寿命)--"★永生★"
    else
    	zts:显示(self.x+131,self.y+238,"★永生★")
    end
	zts:显示(self.x+131,self.y+261,bb.成长)
	zts:显示(self.x+131,self.y+284,bb.五行)
end

function 场景类_坐骑资质栏:检查点(x,y)
	if self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_坐骑资质栏:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if self.鼠标 and not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_坐骑资质栏:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_坐骑资质栏