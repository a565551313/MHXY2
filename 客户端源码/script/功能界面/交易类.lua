--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-14 01:20:37
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 交易类 = class()
local tp
local xxx = 0
local yyy = 0
local sts = {"单价","数量","总额","现金"}
local 包围盒 = require("gge包围盒")(0,0,120,20)

function 交易类:初始化(根)
   	self.ID = 51
	self.x = 200
	self.y = 78
	self.xx = 0
	self.yy = 0
	self.注释 = "交易类"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.右键关闭=1
	self.窗口时间 = 0
	self.对方bb={}
	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('给予总控件')
	总控件:置可视(true,true)
	self.输入框 = 总控件:创建输入("银两输入",0,0,100,14)
	self.输入框:置可视(false,false)
	self.输入框:置限制字数(12)
	self.输入框:置数字模式()
	self.输入框:屏蔽快捷键(true)
	self.输入框:置光标颜色(-16777216)
	self.输入框:置文字颜色(-65536)
	self.选择 = 根._按钮.创建(根.资源:载入('迭代.wdf',"网易WDF动画",0x00000009),0,0,1,true,true)
	self.选择:置根(根)
	self.选择:置偏移(-3,2)
	self.选择1 = 根._按钮.创建(根.资源:载入('迭代.wdf',"网易WDF动画",0x00000009),0,0,1,true,true)
	self.选择1:置根(根)
	self.选择1:置偏移(-3,2)
	self.选择xy={{x=0,y=0},{x=0,y=0}}
	tp = 根
end


function 交易类:打开(名称,等级,类型)
	if self.可视 then
		self.可视 = false
		self.输入框:置可视(false,false)
		请求服务(3719)
		self.资源组 = nil
		self.物品 = nil
		self.对方物 = nil
		return
	else
		table.insert(tp.窗口_,self)
		local 按钮 = tp._按钮
		local 自适应 = tp._自适应
		local 资源 = tp.资源
		self.资源组 = {
			[1] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"确定"),
			[2] = 资源:载入('登陆资源.wdf',"网易WDF动画",0XAABBCC2A),
			[3] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"取消"),
			[4] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"物品"),
			[5] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"召唤兽"),
			[6] = 资源:载入('登陆资源.wdf',"网易WDF动画",0XAABBCC2B),

		}
		self.物品={}
		for i=1,20 do
			self.物品[i] = tp._物品格子.创建(0,0,i,"交易_物品")
		end
		self.对方物品={}
		for n=1,3 do
			self.对方物品[n] = tp._物品格子.创建(0,0,i,"交易_物品")
		end
		local wp = tp._物品
		for q=1,20 do
			--local sp = wp()
			--sp:置对象(tp.道具列表[q])
			self.物品[q]:置物品(tp.道具列表[q])
			self.物品[q].格子=nil
		end
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.对象名称=名称
	    self.对象等级=等级 or 0
	    self.对象类型=类型
	    self.格子={}
	    self.bb={}
	    self.输入框:置可视(true,true)
	    self.输入框:置文本("0")
	    self.显示类型="物品"
	    self.选择1:置打勾框(false)
	    self.选择:置打勾框(false)
	    self.锁定状态=false
	    self.对方bb={}
	    self.对方道具={}
	    self.对方银子=0
	    self.对方开关=false
	end
end

function 交易类:设置我方数据(数据)
	 if 数据.锁定 then
	 	self.锁定状态=true
	  	self.选择:置打勾框(true)
	 else
	  	self.锁定状态=false
	  	self.选择:置打勾框(false)
	  end
end

function 交易类:设置对方数据(数据)
	 if 数据.锁定 then
		self.对方银子=数据.银子
		for n=1,3 do
			-- print(self.对方物品[n],数据.道具[n])
			self.对方物品[n]:置物品(数据.道具[n])
		end
		self.对方bb=数据.bb
		--table.print(数据.bb)
		self.对方开关=true
		self.选择1:置打勾框(true)
	  else
	  	self.对方开关=false
		self.选择1:置打勾框(false)
	  end
end


function 交易类:更新(dt) end

function 交易类:设置物品(id)
	local 编号=0
	for n=1,3 do
		if not self.格子[n] and 编号==0 then 编号=n end
	end
	if 编号==0 then
		self.物品[self.格子[1]].格子=nil
		self.格子[1]=id
		self.物品[self.格子[1]].格子=1
	else
		self.格子[编号]=id
		self.物品[self.格子[编号]].格子=1
	end
end

function 交易类:物品显示(dt,x,y)
	local xx = 0
	local yy = 0
	for i=1,20 do
		if self.物品[i].格子==nil then
			self.物品[i]:置坐标(self.x + xx * 51 + 237,self.y + yy * 51 + 89)
			self.物品[i]:显示(dt,x,y,self.鼠标)
			if self.物品[i].焦点 and not tp.消息栏焦点 then
				if self.物品[i].物品 ~= nil then
					tp.提示:道具行囊(x,y,self.物品[i].物品)
					if 引擎.鼠标弹起(左键) and self.锁定状态==false then
						self:设置物品(i)
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
 	for n=1,3 do
		if self.格子[n]~=nil then
			--self.物品[self.格子[n]]:置坐标(self.x + n*58-58+15 ,self.y + 298)
			self.物品[self.格子[n]]:置坐标(self.x + n*58-58+26 ,self.y + 68)
			self.物品[self.格子[n]]:显示(dt,x,y,self.鼠标)
			if self.物品[self.格子[n]].焦点 and not tp.消息栏焦点 then
				if self.物品[self.格子[n]].物品 ~= nil then
					tp.提示:道具行囊(x,y,self.物品[self.格子[n]].物品)
					if 引擎.鼠标弹起(左键) and self.锁定状态==false then
						self.物品[self.格子[n]].格子=nil
						self.格子[n]=nil
					end
				end
				self.焦点 = true
			end
		end
	end
	if self.对方开关 then
		for n=1,3 do
			--self.物品[self.格子[n]]:置坐标(self.x + n*58-58+15 ,self.y + 298)
			self.对方物品[n]:置坐标(self.x + n*58-58+26 ,self.y + 265)
			self.对方物品[n]:显示(dt,x,y,self.鼠标)
			if  self.对方物品[n].焦点 and not tp.消息栏焦点 then
				if self.对方物品[n].物品 ~= nil then
					tp.提示:道具行囊(x,y,self.对方物品[n].物品)
				end
				self.焦点 = true
			end
		end
	end
end

function 交易类:取是否选中(id)
	for n=1,3 do
		if self.bb[n]==id then return true  end
	end
	return false
end

function 交易类:设置交易召唤兽(id)
	local 编号=0
	for n=1,3 do
		if not self.bb[n] and 编号==0 then 编号=n end
		if self.bb[n]==id then self.bb[n]=nil return  end
	end
	if 编号==0 then
		self.bb[1]=id
	else
		self.bb[编号]=id
	end
end

function 交易类:召唤兽显示(dt,x,y)
	--self.资源组[6]:显示(self.x+275,self.y+50)
	local 字体 = tp.字体表.人物字体
	local 点击事件=false
	for n=1,#tp.队伍[1].宝宝列表 do
		if self:取是否选中(n) then
			字体:置颜色(绿色)
		else
			字体:置颜色(黑色)
		end
		包围盒:置坐标(self.x+265,self.y+60+n*25)
		字体:显示(self.x+265,self.y+60+n*25,tp.队伍[1].宝宝列表[n].名称)
		if 包围盒:检查点(x,y) and 点击事件==false and self.锁定状态==false  then
			if 引擎.鼠标弹起(0) and self.鼠标 and not tp.消息栏焦点 then
				self:设置交易召唤兽(n)
				点击事件=true
			elseif 引擎.鼠标弹起(1) and self.鼠标 and not tp.消息栏焦点 then
				tp.窗口.召唤兽查看栏:打开(tp.队伍[1].宝宝列表[n])
				点击事件=true
			end
		end
	end
	for n=1,3 do
		if self.bb[n]~=nil then
			字体:置颜色(黑色):显示(self.x+40,self.y+43+n*29,tp.队伍[1].宝宝列表[self.bb[n]].名称)
			包围盒:置坐标(self.x+40,self.y+45+n*29)
			if 包围盒:检查点(x,y) then
				if 引擎.鼠标弹起(左键) and self.鼠标 and not tp.消息栏焦点  and self.锁定状态==false then
					self.bb[n]=nil
				elseif 引擎.鼠标弹起(左键) and self.鼠标 and not tp.消息栏焦点 then
					 tp.窗口.召唤兽查看栏:打开(tp.队伍[1].宝宝列表[self.bb[n]])
				end
			end
		end
	end
	if self.对方开关 then
		字体:置颜色(黑色)
		for n=1,3 do
			if self.对方bb[n]~=nil then
				字体:置颜色(黑色):显示(self.x+40,self.y+240+n*29,self.对方bb[n].名称)
				包围盒:置坐标(self.x+40,self.y+240+n*29)
				if 包围盒:检查点(x,y) then
					if 引擎.鼠标弹起(右键) and self.鼠标 and not tp.消息栏焦点   then
						-- self.bb[n]=nil
					elseif 引擎.鼠标弹起(左键) and self.鼠标  then
						tp.窗口.召唤兽查看栏:打开(self.对方bb[n])
					end
				end
			end
		end
	end
end

function 交易类:显示(dt,x,y)
	self.右键关闭 = nil
	local 字体 = tp.字体表.普通字体
	self.焦点=false
	self.输入框:置坐标(self.x + 130,self.y + 43)
	--self.选择xy={{x=self.x+185,y=self.y + 63},{x=self.x+185,y=self.y + 260}}
	if self.显示类型=="物品" then
		self.资源组[2]:显示(self.x,self.y)
		self:物品显示(dt,x,y)
	else
		self.资源组[6]:显示(self.x,self.y)
		self:召唤兽显示(dt,x,y)
	end
	--self.资源组[1]:更新(x,y,self.选中人物 ~= 0)
	--self.资源组[2]:更新(x,y,self.选中人物 ~= 0)
	self.资源组[1]:显示(self.x+265,self.y+320)
	self.资源组[3]:显示(self.x+365,self.y+320)
	self.资源组[4]:显示(self.x+275,self.y + 40)
	self.资源组[5]:显示(self.x+395,self.y+40)

	self.资源组[4]:更新(x,y)
	self.资源组[5]:更新(x,y)
	self.资源组[1]:更新(x,y)
	self.资源组[3]:更新(x,y)

	self.选择:更新(x,y)
	self.选择1:更新(x,y)
 	if self.资源组[3]:事件判断() then
		self:打开()
		return
	elseif self.选择:事件判断() then
	   请求服务(3717,{银子=self.输入框:取文本(),道具=self.格子,bb=self.bb})
	elseif self.资源组[1]:事件判断() then
	   请求服务(3738)
		--	self:设置对方数据({bb=table.loadstring(table.取金钱颜色tring(tp.队伍[1].宝宝列表)),道具=table.loadstring(table.取金钱颜色tring(tp.道具列表)),银子=1000})
	elseif self.资源组[4]:事件判断() then
		self.显示类型="物品"
	elseif self.资源组[5]:事件判断() then
		self.显示类型="召唤兽"
	-- elseif self.选择:事件判断() and self.锁定状态==false then
	end
	if self.显示类型=="物品" then
		self.选择xy={{x=self.x+196,y=self.y + 70},{x=self.x+196,y=self.y + 263}}
	elseif self.显示类型=="召唤兽" then
		self.选择xy={{x=self.x+224,y=self.y + 40},{x=self.x+224,y=self.y + 235}}
	end
	-- self.资源组[2]:显示(355+self.x,263+self.y)
  	--字体:置颜色(取金钱颜色(tp.金钱))
	--字体:显示(self.x + 47,self.y + 67,tp.金钱)
	字体:置颜色(黄色)
	字体:显示(self.x + 75,self.y + 201,self.对象等级.."           陌生人")
	字体:显示(self.x + 93,self.y + 173,self.对象名称)
    字体:置颜色(黑色):显示(self.x + 130,self.y + 240,self.对方银子)
	self.选择:显示(self.选择xy[1].x,self.选择xy[1].y,true)
	self.选择1:显示(self.选择xy[2].x,self.选择xy[2].y,true)
	self.控件类:更新(dt,x,y)
	if self.输入框._已碰撞 then
		self.焦点 = true
	end
	self.控件类:显示(x,y)
end

function 交易类:检查点(x,y)
	if self.可视 and self.资源组 ~= nil and self.资源组[2]:是否选中(x,y)  then
		return true
	else
		return false
	end
end

function 交易类:初始移动(x,y)
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

function 交易类:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 交易类