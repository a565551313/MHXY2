--======================================================================--

--======================================================================--
local 场景类_召唤兽查看栏 = class()
local floor = math.floor
local xslb,bb,lb,tp,fy,gz
local format = string.format
local insert = table.insert
local bds = {"攻击资质","防御资质","体力资质","法力资质","速度资质","躲闪资质"}
local bds1 = {"寿命","成长","五行"}
local 字体1 = {"参战等级","气血","魔法","攻击","防御","速度","灵力"}
local 字体2 = {"等级","体质","魔力","力量","耐力","敏捷","潜能"}
function 场景类_召唤兽查看栏:初始化(根)
	self.ID = 38
	self.x = 200
	self.y = 117
	self.xx = 0
	self.yy = 0
	self.注释 = "召唤兽查看栏"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口时间 = 0
	tp = 根
end

function 场景类_召唤兽查看栏:打开(b,l,c)
	if b~=nil and self.可视 then self.可视=false end
	if self.可视 then
		if b ~= nil and bb ~= b then
			bb = b
			fy = 0
			for n=1,#bb.技能 do
		  		self.技能[n] = gz(0,0,n,"技能查看")
			    local 临时技能=tp._技能.创建()
			    if bb.技能[n] ~= nil then
				   临时技能:置对象(bb.技能[n],2)
				   self.技能[n]:置技能(临时技能)
			    else
			       break
			    end
			end
			self:置形象()
			tp.运行时间 = tp.运行时间 + 1
		    self.窗口时间 = tp.运行时间
		    return false
		end
		fy = nil
		bb = nil
		xslb = nil
		self.可视 = false
		self.资源组=nil
		self.资源组2=nil
		self.技能=nil
		return
	else
		fy = 0
		bb = b
		self.技能={}
		insert(tp.窗口_,self)
		self:加载资源()
		for n=1,#bb.技能 do
	  		self.技能[n] = gz(0,0,n,"技能查看")
		    local 临时技能=tp._技能.创建()
		    if bb.技能[n] ~= nil then
			   临时技能:置对象(bb.技能[n],2)
			   self.技能[n]:置技能(临时技能)
		    else
		       break
		    end
		end
		for i=1,3 do
			if bb.装备~=nil then
		    self.物品[i]:置物品(bb.装备[i])
		end
		end
		self:置形象()
		tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end
function 场景类_召唤兽查看栏:加载资源()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {

		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[3] =  按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"显示类型"),
		[4] =  按钮.创建(tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x7AB5584C),0,0,3,true,true),
		[5] =  按钮.创建(tp.资源:载入('登陆资源.wdf',"网易WDF动画",0xCB50AB1D),0,0,3,true,true),
	}

	self.资源组2 = {
		[1] = 自适应.创建(0,1,455,380,3,9),
		[2] = 资源:载入("登陆资源.wdf","网易WDF动画",0x94699a68),
		[3] = 自适应.创建(3,1,120,18,1,3),
		[4] = 自适应.创建(3,1,70,18,1,3),
		[5] = 自适应.创建(3,1,90,18,1,3),
		[6] = 自适应.创建(3,1,60,18,1,3),
		[7] = 自适应.创建(3,1,55,18,1,3),
		[8] = 自适应.创建(1,1,451,18,1,3,nil,18),
	}
	self.技能 = {}
	for n=2,5 do
	    self.资源组[n]:绑定窗口_(38)
	end
	gz = tp._技能格子
	self.追加法术 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xef45cdc6)
	self.物品 = {}
	local wp = tp._物品格子
	local 底图 =资源:载入('登陆资源.wdf',"网易WDF动画",0xA393A808)
	for i=1,3 do
	    self.物品[i] = wp(0,0,i,"召唤兽资质物品",底图)
	end
end

function 场景类_召唤兽查看栏:置形象()
	if bb ~= nil then
		self.资源组[6] = nil
		self.资源组[7] = nil
		local n = 引擎.取战斗模型(bb.模型)
		self.资源组[6] = tp.资源:载入(n[10],"网易WDF动画",n[6])
		if 引擎.取战斗模型(bb.模型.."_饰品") ~= nil and #引擎.取战斗模型(bb.模型.."_饰品") >0 then
			n = 引擎.取战斗模型(bb.模型.."_饰品")
			self.资源组[7] = tp.资源:载入(n[10],"网易WDF动画",n[6])
		end
		if bb.染色方案 ~= nil then
			if bb.染色方案 == "黑白" then
				self.资源组[6]:置染色("黑白",ARGB(255,235,235,235))
				self.资源组[6]:置方向(0)
				if bb.饰品 ~= nil then
					self.资源组[7]:置染色("黑白",ARGB(255,185,185,185))
					self.资源组[7]:置方向(0)
				end
			else
				self.资源组[6]:置染色(bb.染色方案,bb.染色组[1],bb.染色组[2],bb.染色组[3])
				self.资源组[6]:置方向(0)
			end
		end
	end
end

function 场景类_召唤兽查看栏:显示(dt,x,y)
	self.焦点 = false
	if bb.种类=="孩子" then
			self.资源组[2]:更新(x,y)
			self.资源组2[1]:显示(self.x,self.y)
			tp.竖排花纹背景_:置区域(0,0,13,170)
			tp.竖排花纹背景_:显示(self.x+15,self.y+30)
			self.资源组2[2]:显示(self.x+55,self.y+55)
			self.资源组2[3]:显示(self.x+60,self.y+180)
			tp.宝宝装备背景[1]:显示(self.x+200,self.y+30)
			tp.宝宝装备背景[2]:显示(self.x+200,self.y+90)
			tp.宝宝装备背景[3]:显示(self.x+200,self.y+150)
			tp.字体表.普通字体:置字间距(10)
			tp.字体表.普通字体:置颜色(白色)
			for i=0,5 do
				tp.字体表.普通字体:显示(self.x+265,self.y+30+i*23,bds[i+1])
				self.资源组2[4]:显示(self.x+370,self.y+30+i*22)
			end
			tp.字体表.普通字体:置字间距(58)
			tp.字体表.普通字体:置颜色(-1404907)
			for i=0,2 do
				tp.字体表.普通字体:显示(self.x+267,self.y+165+i*23,bds1[i+1])
				self.资源组2[4]:显示(self.x+370,self.y+166+i*23)
			end
			tp.字体表.普通字体:置字间距(0)
			tp.字体表.普通字体:置颜色(白色)
			for i=0,6 do
				if  i==0 then
					tp.字体表.普通字体:显示(self.x+20,self.y+206+i*24,字体1[i+1])
					self.资源组2[6]:显示(self.x+55+30,self.y+206+i*24)
				else
					tp.字体表.普通字体:显示(self.x+20,self.y+206+i*24,字体1[i+1])
					self.资源组2[5]:显示(self.x+55,self.y+206+i*24)
				end
			end

			for i=0,6 do
				tp.字体表.普通字体:显示(self.x+165,self.y+206+i*24,字体2[i+1])
				self.资源组2[7]:显示(self.x+200,self.y+206+i*24)
			end


			local xx = 0
			local yy = 0
			for i=1,12 do
				local jx = self.x+310-47+(xx*41)
				local jy = self.y+110+127+(yy*41)
				tp.技能背景:显示(jx,jy)
				xx = xx + 1
				if xx > 3 then
					xx = 0
					yy = yy + 1
				end
			end
			self.资源组[2]:显示(self.x + 431,self.y + 2)
			if lb == nil then
				self.资源组[3]:更新(x,y)
				self.资源组[3]:显示(self.x + 6,self.y+2,true)
			end
			if self.鼠标 then
				if self.资源组[2]:事件判断() then
					self:打开()
					return false
				elseif self.资源组[3] ~= nil and self.资源组[3]:事件判断() then
					if xslb == nil then
						xslb = true
						self.资源组[3]:置文字("关闭类型")
					else
						xslb = nil
						self.资源组[3]:置文字("显示类型")
					end
				end
			end

	else

			self.资源组[2]:更新(x,y)
			self.资源组[4]:更新(x,y,fy == 12)
			self.资源组[5]:更新(x,y,#bb.技能>12 and fy == 0)
			self.资源组2[1]:显示(self.x,self.y)
			tp.竖排花纹背景_:置区域(0,0,13,170)
			tp.竖排花纹背景_:显示(self.x+15,self.y+30)
			self.资源组2[8]:显示(self.x + 2,self.y+2)
			self.资源组2[2]:显示(self.x+55,self.y+55)
			self.资源组2[3]:显示(self.x+60,self.y+180)
			tp.宝宝装备背景[1]:显示(self.x+200,self.y+30)
			tp.宝宝装备背景[2]:显示(self.x+200,self.y+90)
			tp.宝宝装备背景[3]:显示(self.x+200,self.y+150)

			tp.字体表.普通字体:置字间距(10)
			tp.字体表.普通字体:置颜色(白色)
			for i=0,5 do
				tp.字体表.普通字体:显示(self.x+265,self.y+30+i*23,bds[i+1])
				self.资源组2[4]:显示(self.x+370,self.y+30+i*22)
			end
			tp.字体表.普通字体:置字间距(58)
			tp.字体表.普通字体:置颜色(-1404907)
			for i=0,2 do
				tp.字体表.普通字体:显示(self.x+267,self.y+165+i*23,bds1[i+1])
				self.资源组2[4]:显示(self.x+370,self.y+166+i*23)
			end


			tp.字体表.普通字体:置字间距(0)
			tp.字体表.普通字体:置颜色(白色)

			for i=0,6 do
				if  i==0 then
					tp.字体表.普通字体:显示(self.x+20,self.y+206+i*24,字体1[i+1])
					self.资源组2[6]:显示(self.x+55+30,self.y+206+i*24)
				else
					tp.字体表.普通字体:显示(self.x+20,self.y+206+i*24,字体1[i+1])
					self.资源组2[5]:显示(self.x+55,self.y+206+i*24)
				end
			end

			for i=0,6 do
				tp.字体表.普通字体:显示(self.x+165,self.y+206+i*24,字体2[i+1])
				self.资源组2[7]:显示(self.x+200,self.y+206+i*24)
			end


			local xx = 0
			local yy = 0
			for i=1,12 do
				local jx = self.x+310-47+(xx*41)
				local jy = self.y+110+127+(yy*41)
				tp.技能背景:显示(jx,jy)
				xx = xx + 1
				if xx > 3 then
					xx = 0
					yy = yy + 1
				end
			end


			self.资源组[2]:显示(self.x + 431,self.y + 2)
			if lb == nil then
				self.资源组[3]:更新(x,y)
				self.资源组[3]:显示(self.x + 6,self.y+2,true)
			end
			if self.鼠标 then
				if self.资源组[2]:事件判断() then
					self:打开()
					return false
				elseif self.资源组[3] ~= nil and self.资源组[3]:事件判断() then
					if xslb == nil then
						xslb = true
						self.资源组[3]:置文字("关闭类型")
					else
						xslb = nil
						self.资源组[3]:置文字("显示类型")
					end
				elseif self.资源组[4]:事件判断() then
					if fy == 0 then
						tp.常规提示:打开("#Y/已经到顶了!")
					else
						fy = 0
					end
				elseif self.资源组[5]:事件判断() then
					if fy == 12 then
						tp.常规提示:打开("#Y/已经到最下面!")
					else
						fy = 12
					end
				end
			end
			self.资源组[4]:显示(self.x + 436,self.y + 278)
			self.资源组[5]:显示(self.x + 436,self.y + 312)
	end


	for i=1,3 do
	    self.物品[i]:置坐标(self.x + 205,self.y - 32+i*61)
	    self.物品[i]:显示(dt,x,y,self.鼠标)
	    if self.物品[i].物品 ~= nil and self.物品[i].焦点 then
		  tp.提示:道具行囊(x,y,self.物品[i].物品)
		end
	end

	if  bb.套装效果~=nil then
		self.追加法术:显示(self.x + 80+250-170,self.y+150)
		if self.追加法术:是否选中(x,y) then
			tp.提示:自定义(self.x + 80+250-170,self.y+150,bb.套装效果[2]..bb.套装效果[1])
		end
	end


	tp.窗口标题背景_[3]:显示(self.x+self.资源组2[1].宽度/2-60,self.y+2)
	tp.字体表.普通字体:置颜色(白色)
	tp.字体表.普通字体:显示(self.x+self.资源组2[1].宽度/2-33,self.y+3,"召 唤 兽")

	if self.资源组[6] ~= nil then
		tp.影子:显示(self.x + 116,self.y+152)
		self.资源组[6]:更新(dt)
		self.资源组[6]:显示(self.x + 116,self.y+152)
		if self.资源组[7] ~= nil then
			self.资源组[7]:更新(dt)
			self.资源组[7]:显示(self.x + 116,self.y+152)
		end
	end
	tp.字体表.普通字体:置颜色(ARGB(255,255,255,255))
	local v = ""
	if xslb then
		if bb.种类==nil then
			v = "(未知)"
		else
			v = "("..bb.种类..")"
		end
	end
	tp.字体表.普通字体:显示(self.x + 55,self.y + 35,bb.模型..v)
	tp.字体表.普通字体:置颜色(-16711936)
	--tp.字体表.普通字体:显示(self.x + 50 + #bb.名称*7.2,self.y + 35,v)
	tp.字体表.普通字体:置颜色(-16777216)
	tp.字体表.普通字体:显示(self.x + 75,self.y + 181,bb.名称)
	tp.字体表.普通字体:显示(self.x + 95,self.y + 209,bb.参战等级)
	tp.字体表.普通字体:显示(self.x + 219,self.y + 209,bb.等级)
	tp.字体表.普通字体:显示(self.x + 62,self.y + 233,bb.气血)
	tp.字体表.普通字体:显示(self.x + 62,self.y + 256,bb.魔法)
	tp.字体表.普通字体:显示(self.x + 62,self.y + 280,bb.伤害)
	tp.字体表.普通字体:显示(self.x + 62,self.y + 305,bb.防御)
	tp.字体表.普通字体:显示(self.x + 62,self.y + 328,bb.速度)
	tp.字体表.普通字体:显示(self.x + 62,self.y + 353,bb.灵力)

	tp.字体表.普通字体:显示(self.x + 206,self.y + 232,bb.体质)
	tp.字体表.普通字体:显示(self.x + 206,self.y + 257,bb.魔力)
	tp.字体表.普通字体:显示(self.x + 206,self.y + 280,bb.力量)
	tp.字体表.普通字体:显示(self.x + 206,self.y + 305,bb.耐力)
	tp.字体表.普通字体:显示(self.x + 206,self.y + 328,bb.敏捷)
	tp.字体表.普通字体:显示(self.x + 206,self.y + 352,0)

	tp.字体表.普通字体:显示(self.x + 374,self.y + 33,bb.攻击资质)
	tp.字体表.普通字体:显示(self.x + 374,self.y + 55,bb.防御资质)
	tp.字体表.普通字体:显示(self.x + 374,self.y + 77,bb.体力资质)
	tp.字体表.普通字体:显示(self.x + 374,self.y + 101,bb.法力资质)
	tp.字体表.普通字体:显示(self.x + 374,self.y + 122,bb.速度资质)
	tp.字体表.普通字体:显示(self.x + 374,self.y + 144,bb.躲闪资质)
   	if bb.种类=="神兽" then
      	tp.字体表.普通字体:显示(self.x + 374,self.y + 170,"★永生★")
   	else
   	 	tp.字体表.普通字体:显示(self.x + 374,self.y + 170,bb.寿命)
	end
	tp.字体表.普通字体:显示(self.x + 374,self.y + 192,bb.成长)
	tp.字体表.普通字体:显示(self.x + 374,self.y + 215,bb.五行)

	local xx = 0
	local yy = 0
	for n=1,12 do
		if self.技能[n+fy] ~= nil and self.技能[n+fy].技能 ~= nil then
			self.技能[n+fy]:置坐标(self.x+266+(xx*41),self.y+239+(yy*41))
			self.技能[n+fy]:显示(x,y,self.鼠标)
			if self.技能[n+fy].焦点 then
				tp.提示:技能(x,y,self.技能[n+fy].技能)
			end
			xx = xx + 1
			if xx > 3 then
				xx = 0
				yy = yy + 1
			end
		end
	end

end

function 场景类_召唤兽查看栏:检查点(x,y)
	if self.资源组 ~= nil and self.资源组2~=nil and self.资源组2[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_召唤兽查看栏:初始移动(x,y)
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

function 场景类_召唤兽查看栏:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_召唤兽查看栏