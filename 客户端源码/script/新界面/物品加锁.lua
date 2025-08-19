
local 物品加锁 = class()
local tp,zts,zts1,zts2,zts3
local insert = table.insert
local xxx = 0
local yyy = 0
local format = string.format
local mousea = 引擎.鼠标弹起
local qtxs = 引擎.取头像
local qzdmx = 引擎.取战斗模型
local tos = 取金钱颜色
local mouseb = 引擎.鼠标弹起
local bw = require("gge包围盒")(0,0,120,20)
local box = 引擎.画矩形

function 物品加锁:初始化(根)
	tp = 根
    self.ID = 129
	self.x = 366
	self.y = 78
	self.xx = 0
	self.yy = 0
	self.注释 = "物品加锁"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	local 资源 = 根.资源
	self.资源组 = {
		[1] = 自适应.创建(0,1,295,301,3,9),--资源:载入('wzife.wdf',"网易WDF动画",0X967049D),
		[2] = 自适应.创建(3,1,86,18,1,3),--资源:载入('wzife.wdf',"网易WDF动画",0XCE137B78),
		[3] = 自适应.创建(4,1,1,1,3,nil),--宠物背景
		-- [4] = --宠物素材在使用
		[5] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
	    [6] = 按钮.创建(自适应.创建(27,4,25,69,4,3),0,0,5,true,true),
		[7] = 按钮.创建(自适应.创建(27,4,25,69,4,3),0,0,5,true,true),
		[8] = 按钮.创建(自适应.创建(27,4,25,69,4,3),0,0,5,true,true),
		[9] = 按钮.创建(自适应.创建(27,4,25,69,4,3),0,0,5,true,true),
		[10] = 按钮.创建(自适应.创建(12,4,44,20,1,3),0,0,4,true,true,"加锁"),
	    [11] = 按钮.创建(自适应.创建(12,4,44,20,1,3),0,0,4,true,true,"解锁"),
		--[12] = 资源:载入(全局界面皮肤,"网易WDF动画",0xADC83326),--分割图
		[13] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xFD3D61F2),0,0,4,true,true),--上按钮
		[14] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x09217E13),0,0,4,true,true),--下按钮
		[15] = 自适应.创建(1,1,291,18,1,3,nil,18),--标题背景
		[16] = 按钮.创建(自适应.创建(12,4,44,20,1,3),0,0,4,true,true,"道具"),
	    [17] = 按钮.创建(自适应.创建(12,4,44,20,1,3),0,0,4,true,true,"行囊"),
		[18] = 按钮.创建(自适应.创建(12,4,44,20,1,3),0,0,4,true,true,"法宝"),
	    --[19] = 按钮.创建(自适应.创建(12,4,44,22,1,3),0,0,4,true,true,"锦衣"),
		[20] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"全面加锁"),
	    [21] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"全面解锁"),

		[22] = 自适应.创建(3,1,95,18,1,3),--气血魔法攻击文字背景框
	    --58 ,59 已经在宠物饰品那使用了
	}
	self.资源组[3]:置宽高(107,117+74)
	--self.资源组[12]:置区域(0,0,17,75+74)
	self.动作底图 = 自适应.创建(2,1,140,145,3,9)
	for n=5,10 do
		self.资源组[n]:绑定窗口_(129)
	end
	local 格子 = 根._物品格子
	self.选中背景=根.资源:载入('登陆资源.wdf',"网易WDF动画",0x10921CA7)
	self.召唤兽装备饰品 = 格子(0,0,1,"道具行囊_召唤兽装备",底图)--底图可空
   self.加锁 = tp.资源:载入('新界面.wdf',"网易WDF动画",0X85655274)
   self.背包按钮={
			[1] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"1"),
			[2] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"2"),
			[3] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"3"),
			[4] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"4"),
			[5] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"5"),
		   }
		   for i=1,5 do
		  	self.背包按钮[i]:置偏移(-2,-2)
		  end

	self.选中人物 = 0
	self.窗口时间 = 0
	self.物品={}
	self.行囊={}
	self.法宝={}
	for i=1,100 do
		self.物品[i] = 根._物品格子.创建(0,0,i,"加锁_物品")
	end
	self.召唤兽装备 = {}
	for i=1,3 do
		self.召唤兽装备[i] = 格子(0,0,i,"道具行囊_召唤兽装备",123)
	end
	zts2 = tp.字体表.描边字体
	zts3 = tp.字体表.普通字体__
	zts1 = tp.字体表.描边字体
	self.字体 = tp.字体表.普通字体
    self.bb选中=0
    self.物品选中=0
    self.装备选中=0
    self.灵饰选中=0
	self.开始 = 1
	self.结束 = 20
	self.道具小类="道具"
	self.加入=0
end

function 物品加锁:刷新()
    self.bb=tp.队伍[1].宝宝列表
	for q=1,100 do
		self.物品[q]:置物品(nil)
	end
	local x道具 = tp.道具列表
	if self.道具小类=="法宝" then
	    x道具=tp.队伍[1].法宝
	elseif self.道具小类=="锦衣" then
	    x道具=tp.锦衣列表
	end
	if self.显示类型=="装备" then
	    x道具=tp.队伍[1].装备
	elseif self.显示类型=="灵饰" then
	    x道具=tp.队伍[1].灵饰
	end
	for q=1,100 do
		self.物品[q]:置物品(x道具[q])
        if x道具[q]~=nil and x道具[q].加锁~=nil then
            self.物品[q]:置灰色()
        end
	end
	x道具={}
end

function 物品加锁:打开(名称,角色名称,id,物品数据,bb数据)
	if self.焦点 then return end
	if self.可视 then
		self.选中人物 = 0
		self.可视 = false
		self.加入 = 0
		self.bb=nil
		for q=1,100 do
			self.物品[q]:置物品(nil)
		end
		self.开始 = 1
		self.结束 = 20
	    self.bb选中=0
	    self.物品选中=0
	    self.装备选中=0
	    self.灵饰选中=0
		self.道具小类="道具"
	else
		insert(tp.窗口_,self)
		self.开始 = 1
		self.结束 = 20
		self.加入 = 0
		self:刷新()
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.选中人物=0
	    self.对象名称=名称
	    self.对象等级=等级
	    self.对象类型=类型
	    self.格子={}
	    self.显示类型="物品"
		self.道具小类="道具"
	    self.摊主名称=角色名称
	    self.摊主id=id
	    self.bb选中=0
	    self.物品选中=0
	    self.装备选中=0
	    self.灵饰选中=0

	end
end

function 物品加锁:物品显示(dt,x,y)
	self.焦点=false
	-- self.资源组[10]:更新(x,y,self.物品选中~=0 and self.物品[self.物品选中]~=nil and self.物品[self.物品选中].加锁==nil)
	-- self.资源组[11]:更新(x,y,self.物品选中~=0 and self.物品[self.物品选中]~=nil and self.物品[self.物品选中].加锁~=nil)
	tp.物品界面背景_:显示(self.x+20,self.y+30+20)
	if self.显示类型~="装备" and self.显示类型~="灵饰" then
		self.资源组[16]:更新(x,y,self.道具小类~="道具")
		self.资源组[17]:更新(x,y,self.道具小类~="行囊")
		self.资源组[18]:更新(x,y,self.道具小类~="法宝")
		--self.资源组[19]:更新(x,y,self.道具小类~="锦衣")
		self.资源组[16]:显示(self.x+20,self.y+5+20)
		self.资源组[17]:显示(self.x+20+50,self.y+5+20)
		self.资源组[18]:显示(self.x+20+50*2,self.y+5+20)
		--self.资源组[19]:显示(self.x+20+44*4,self.y+5+20)
		if self.道具小类=="道具" then
			for i=1,5 do
			   self.背包按钮[i]:更新(x,y,self.结束~=i*20)
		       self.背包按钮[i]:显示(self.x+145+i*24,self.y+25)
		       if self.背包按钮[i]:事件判断() then
		       	  self.结束=i*20
		       	  self.开始=self.结束-19
		       end
		    end
		else
			self.开始 = 1
			self.结束 = 20
		end
	end
	if self.资源组[16]:事件判断() then
		请求服务(3699)
		self.道具小类="道具"
	elseif self.资源组[17]:事件判断() then
		请求服务(3700)
		self.道具小类="行囊"
	elseif self.资源组[18]:事件判断() then
		self.道具小类="法宝"
		请求服务(3732)
	-- elseif self.资源组[19]:事件判断() then
	-- 	self.道具小类="锦衣"
	-- 	请求服务(46)
	end
	local xx = 0
	local yy = 0
	for i=self.开始,self.结束 do
		if self.物品[i].格子==nil then
		 	self.物品[i]:置坐标(self.x + xx * 51 + 24-2,self.y + yy * 51 + 30+20)
		 	if self.物品选中==i then
              self.选中背景:显示(self.x + xx * 51 + 24-1,self.y + yy * 51 + 30+20+1)
	 	 	end

		    self.物品[i]:显示(dt,x,y,self.鼠标)
		    if self.物品[i].焦点 and not tp.消息栏焦点 then

				if self.物品[i].物品 ~= nil then
				tp.提示:道具行囊(x,y,self.物品[i].物品)
				    if 引擎.鼠标弹起(左键) then
                       self.物品选中=i
				  	end
				end
				self.焦点 = true
			end
		end
		xx = xx + 1
		if xx == 5 then
			xx = 0
			yy = yy + 1
		end
	end
end

function 物品加锁:bb显示(dt,x,y)
	self.动作底图:显示(self.x+10,self.y + 20)
	self.资源组[3]:显示(self.x+177-20,self.y+20)
	--self.资源组[12]:显示(self.x+284-20,self.y+43)
	self.字体:置字间距(10)
	self.字体:显示(self.x+186-20,self.y+26,"宝宝列表")
	self.字体:置字间距(0)
	-- self.资源组[10]:更新(x,y,self.选中召唤兽~=0 and tp.队伍[1].宝宝列表[self.选中召唤兽]~=nil and tp.队伍[1].宝宝列表[self.选中召唤兽].加锁==nil)
	-- self.资源组[11]:更新(x,y,self.选中召唤兽~=0 and tp.队伍[1].宝宝列表[self.选中召唤兽]~=nil and tp.队伍[1].宝宝列表[self.选中召唤兽].加锁~=nil)
	--do
	self.资源组[13]:更新(x,y,self.加入 > 0)
	self.资源组[14]:更新(x,y,self.加入 <  #tp.队伍[1].宝宝列表 - 7)
	self.资源组[13]:显示(self.x + 285-20,self.y + 23,true)
	self.资源组[14]:显示(self.x + 285-20,self.y + 119+74,true)
	self.字体:置颜色(白色)
	self.字体:显示(self.x + 13,self.y + 174+2,"气血")
	self.字体:显示(self.x + 13,self.y + 174+23+2,"魔法")
	self.资源组[22]:显示(self.x + 48,self.y + 174)
	self.资源组[22]:显示(self.x + 48,self.y + 174+23)
	if self.资源组[13]:事件判断() then
		self.加入 = self.加入 - 1
	elseif self.资源组[14]:事件判断() then
		self.加入 = self.加入 + 1
	end
	local 列表 = 0
	self.字体:置颜色(-16777216)
	local dxs = nil
	tp.物品格子背景_:显示(self.x+224+5,self.y+2+220-6)
	self.召唤兽装备饰品:置坐标(self.x+226+6,self.y+220-6)
	self.召唤兽装备饰品:显示(dt,x,y,self.鼠标)
	dxs = tp.队伍[1].宝宝列表
	for m=1,7 do
		if dxs[m + self.加入] ~= nil then
			bw:置坐标(self.x + 182-20,self.y + 24 + m * 23)
			if self.选中召唤兽 ~= m + self.加入 then
				if bw:检查点(x,y) then
					box(self.x + 179-20,self.y + 24 + m * 23,self.x + 283-20,self.y + 24 + m * 22 + 22+m,-3551379)
					if mousea(0) and self.鼠标 then
						self.选中召唤兽 = m + self.加入
						self:置形象()
					end
					self.焦点 = true
				end
			else
				if dxs[m + self.加入].加锁~=nil and dxs[m + self.加入].加锁 then
					self.加锁:显示(self.x+40-20,self.y + 23)
				end
				self.字体:显示(self.x + 55,self.y + 174+2,dxs[self.选中召唤兽].气血.."/"..dxs[self.选中召唤兽].最大气血)
				self.字体:显示(self.x + 55,self.y + 174+23+2,dxs[self.选中召唤兽].魔法.."/"..dxs[self.选中召唤兽].最大魔法)
				local ys = -10790181
				if bw:检查点(x,y) then
					ys = -9670988
					self.焦点 = true
				end
				box(self.x + 179-20,self.y + 24 + m * 23,self.x + 283-20,self.y + 24 + m * 22 + 22+m,ys)
			end
			self.字体:显示(self.x + 182-20,self.y + 27 + m * 23,dxs[m + self.加入].名称)

			if dxs[m + self.加入].加锁~=nil and dxs[m + self.加入].加锁 then
			    self.加锁:显示(self.x + 182+90-20,self.y + 22 + m * 23)
			end
		end
	end
	if self.窗口 == "召唤兽" and dxs[self.选中召唤兽] ~= nil then
		if self.召唤兽装备饰品.焦点 and not tp.消息栏焦点 then
			if self.召唤兽装备饰品.物品 ~= nil then
				tp.提示:道具行囊(x,y,self.召唤兽装备饰品.物品)
			end
			-- if 引擎.鼠标弹起(右键) then
			-- 	请求服务(51,{序列=tp.队伍[1].宝宝列表[self.选中召唤兽].认证码})
			-- 	self.召唤兽装备饰品:置物品(nil)
			-- end
		end
	else
		self.召唤兽装备饰品:置物品(nil)
	end
	if self.资源组[4] ~= nil then
		self.资源组[4]:更新(dt)
		tp.影子:显示(self.x + 98-30,self.y + 115+30)
		self.资源组[4]:显示(self.x + 98-30,self.y + 115+30)
	end
	if self.资源组[58] ~= nil then
		self.资源组[58]:更新(dt)
		self.资源组[58]:显示(self.x + 98-30,self.y + 115+30)
	end
	if self.资源组[59] ~= nil then
		self.资源组[59]:更新(dt)
		self.资源组[59]:显示(self.x + 98-30,self.y + 115+30)
	end
	for i=1,3 do
		tp.物品格子背景_:显示(self.x+i*17+i*53-53+1,self.y+220-2)
		self.召唤兽装备[i]:置坐标(self.x+i*17+i*53-53+4,self.y+220-4)
		self.召唤兽装备[i]:显示(dt,x,y,self.鼠标)
		if not tp.消息栏焦点 then
			if self.召唤兽装备[i].物品 ~= nil and self.召唤兽装备[i].焦点 then
				tp.提示:道具行囊(x,y,self.召唤兽装备[i].物品)
			end
			if tp.队伍[1].宝宝列表[self.选中召唤兽] ~= nil then
				-- if tp.场景.抓取物品 == nil and self.召唤兽装备[i].物品 ~= nil and self.召唤兽装备[i].焦点  then
				-- 	if mousea(1) then
				-- 		请求服务(3709,{类型=self.点击类型,角色="bb",道具=i,编号=self.选中召唤兽})
				-- 	end
				-- end
				-- if self.召唤兽装备[i].事件 then

				-- end
			end
			if self.召唤兽装备[i].焦点 then
				self.焦点 = true
			end
		end
	end
end

function 物品加锁:显示(dt,x,y)
	self.焦点=false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[6]:更新(x,y,self.显示类型~="物品")
	self.资源组[7]:更新(x,y,self.显示类型~="宝宝")
	self.资源组[8]:更新(x,y,self.显示类型~="装备")
	self.资源组[9]:更新(x,y,self.显示类型~="灵饰")
	self.资源组[6]:显示(self.x-23,self.y+10)
	self.资源组[7]:显示(self.x-23,self.y+80)
	self.资源组[8]:显示(self.x-23,self.y+150)
	self.资源组[9]:显示(self.x-23,self.y+220)
	self.资源组[15]:显示(self.x+2,self.y+2)

	tp.窗口标题背景_[4]:显示(self.x+90,self.y+2)
	zts1:置字间距(3)
	zts1:显示(self.x+105,self.y+1,self.显示类型.."加锁")
	zts1:置字间距(0)
	self.资源组[5]:更新(x,y)
	-- self.资源组[11]:更新(x,y)
	self.资源组[5]:显示(self.x+269,self.y+2)
	-- self.资源组[11]:显示(self.x+190,self.y+337)
	zts2:置字间距(2)
	zts2:显示(self.x-17,self.y+27,"道\n具")
	zts2:显示(self.x-17,self.y+90,"召\n唤\n兽")
	zts2:显示(self.x-17,self.y+167,"装\n备")
	zts2:显示(self.x-17,self.y+237,"灵\n饰")
	zts2:置字间距(0)
	self.资源组[10]:更新(x,y,self.物品选中~=0 or self.选中召唤兽~=0)
	self.资源组[11]:更新(x,y,self.物品选中~=0 or self.选中召唤兽~=0)
	self.资源组[20]:更新(x,y)
	self.资源组[21]:更新(x,y)
	self.资源组[10]:显示(self.x+15,self.y+275)
	self.资源组[11]:显示(self.x+13+44+15,self.y+275)
	self.资源组[20]:显示(self.x+11+44*3-15,self.y+275)
	self.资源组[21]:显示(self.x+9+44*3+72,self.y+275)
	if self.资源组[5]:事件判断() then
		self:打开()
	elseif self.资源组[6]:事件判断() then
		self.物品选中=0
		self.选中召唤兽=0
		self.显示类型="物品"
		请求服务(3699)
		self.道具小类="道具"
	elseif self.资源组[7]:事件判断() then
		self.显示类型="宝宝"
		self.物品选中=0
		self.选中召唤兽=0
	elseif self.资源组[8]:事件判断() then
		self.物品选中=0
		self.选中召唤兽=0
		self.显示类型="装备"
	for q=1,20 do
		self.物品[q]:置物品(nil)
	end
	    x道具=tp.队伍[1].装备

	for q=1,20 do
		self.物品[q]:置物品(x道具[q])
        if x道具[q]~=nil and x道具[q].加锁~=nil then
            self.物品[q]:置灰色()
        end
	end
	elseif self.资源组[9]:事件判断() then
		self.物品选中=0
		self.选中召唤兽=0
		self.显示类型="灵饰"
	for q=1,20 do
		self.物品[q]:置物品(nil)
	end

	    x道具=tp.队伍[1].灵饰

	for q=1,20 do
		self.物品[q]:置物品(x道具[q])
        if x道具[q]~=nil and x道具[q].加锁~=nil then
            self.物品[q]:置灰色()
        end
	end
		-- 请求服务(3721,{名称=self.输入框:取文本()})
	end
	if self.显示类型=="物品" or self.显示类型=="装备" or self.显示类型=="灵饰"then
		self:物品显示(dt,x,y)
	-- elseif self.显示类型=="装备" then
	-- 	self:装备显示(dt,x,y)
	-- elseif self.显示类型=="灵饰" then
	-- 	self:灵饰显示(dt,x,y)
	else
		self:bb显示(dt,x,y)
	end
	if self.资源组[10]:事件判断() then
		if self.显示类型=="宝宝" then
			if self.选中召唤兽==0 then
				tp.常规提示:打开("#Y/请先设置要出售的召唤兽")
				return
			end
		elseif self.显示类型=="物品" or self.显示类型=="灵饰" then
			if self.物品选中==0 then
				tp.常规提示:打开("#Y/请先设置要出售的物品")
				return
			end
		end
		if self.显示类型=="宝宝" then
			请求服务(3751,{操作="加锁",主类=self.显示类型,分类=self.道具小类,道具=self.选中召唤兽})
		else
			请求服务(3751,{操作="加锁",主类=self.显示类型,分类=self.道具小类,道具=self.物品选中})
		end
	elseif self.资源组[11]:事件判断() then
		if self.显示类型=="宝宝" then
			if self.选中召唤兽==0 then
				tp.常规提示:打开("#Y/请先设置要出售的召唤兽")
				return
			end
		elseif self.显示类型=="物品" or self.显示类型=="灵饰" then
			if self.物品选中==0 then
				tp.常规提示:打开("#Y/请先设置要出售的物品")
				return
			end
		end
		if self.显示类型=="宝宝" then
			请求服务(3751,{操作="解锁",主类=self.显示类型,分类=self.道具小类,道具=self.选中召唤兽})
		else
			请求服务(3751,{操作="解锁",主类=self.显示类型,分类=self.道具小类,道具=self.物品选中})
		end
	elseif self.资源组[20]:事件判断() then
		if self.显示类型=="宝宝" then
			请求服务(3751,{操作="全面加锁",分类=self.道具小类,主类=self.显示类型})
		else
			请求服务(3751,{操作="全面加锁",分类=self.道具小类,主类=self.显示类型})
		end
	elseif self.资源组[21]:事件判断() then
		if self.显示类型=="宝宝" then
			请求服务(3751,{操作="全面解锁",分类=self.道具小类,主类=self.显示类型})
		else
			请求服务(3751,{操作="全面解锁",分类=self.道具小类,主类=self.显示类型})
		end
	end
end

function 物品加锁:置形象()
	self.资源组[4] = nil
	self.资源组[58]=nil
	self.资源组[59]=nil
	if self.选中召唤兽 ~= 0 and tp.队伍[1].宝宝列表[self.选中召唤兽]  ~= nil then
		local 模型=tp.队伍[1].宝宝列表[self.选中召唤兽].模型
		if tp.队伍[1].宝宝列表[self.选中召唤兽].进阶 then
			模型="进阶"..模型
		end
		local n = qzdmx(模型)
		self.资源组[4] = tp.资源:载入(n[10],"网易WDF动画",n[6])
		if tp.队伍[1].宝宝列表[self.选中召唤兽].染色方案 ~= nil then
			self.资源组[4]:置染色(tp.队伍[1].宝宝列表[self.选中召唤兽].染色方案,tp.队伍[1].宝宝列表[self.选中召唤兽].染色组[1],tp.队伍[1].宝宝列表[self.选中召唤兽].染色组[2],tp.队伍[1].宝宝列表[self.选中召唤兽].染色组[3])
			self.资源组[4]:置方向(0)
		end
		for i=1,3 do
			self.召唤兽装备[i]:置物品(tp.队伍[1].宝宝列表[self.选中召唤兽].装备[i])
			self.召唤兽装备[i].聊天框数据 = tp.队伍[1].宝宝列表[self.选中召唤兽].装备[i]
		end
		if tp.队伍[1].宝宝列表[self.选中召唤兽].饰品~=nil  then
			local 召唤wp ={总类=682,子类=1,识别码="4000147_1585490655_3897488_741",分类=1,名称="炎魔神饰品"}
			召唤wp.名称=tp.队伍[1].宝宝列表[self.选中召唤兽].饰品
			self.召唤兽装备饰品:置物品(召唤wp)
			self.召唤兽装备饰品.聊天框数据 = 召唤wp
			召唤wp={}
		else
			self.召唤兽装备饰品:置物品(tp.队伍[1].宝宝列表[self.选中召唤兽].装备[4])
		end
		local n
		if tp.队伍[1].宝宝列表[self.选中召唤兽].饰品 ~= nil then
			n = qzdmx(tp.队伍[1].宝宝列表[self.选中召唤兽].模型.."_饰品")
			self.资源组[58] = tp.资源:载入(n[10],"网易WDF动画",n[6])
			self.资源组[58]:置方向(0)
		end
		if tp.队伍[1].宝宝列表[self.选中召唤兽].饰品2 ~= nil then
			n = qzdmx(tp.队伍[1].宝宝列表[self.选中召唤兽].模型.."_饰品2")
			self.资源组[59] = tp.资源:载入(n[10],"网易WDF动画",n[6])
			self.资源组[59]:置方向(0)
		end
	end
end

function 物品加锁:检查点(x,y)
	if self.可视 and (self.资源组[1]:是否选中(x,y) or self.资源组[6]:是否选中(x,y) or self.资源组[7]:是否选中(x,y) or self.资源组[8]:是否选中(x,y) or self.资源组[9]:是否选中(x,y)) then
		return true
	else
		return false
	end
end

function 物品加锁:初始移动(x,y)
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

function 物品加锁:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end
function 物品加锁:更新(dt) end
return 物品加锁