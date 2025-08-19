--======================================================================--

--======================================================================--
local 系统类_活跃商城 = class()
local floor = math.floor
local tp,zts,zt
local format = string.format
local insert = table.insert

function 系统类_活跃商城:初始化(根)
	self.x = 230
	self.y = 110
	self.xx = 0
	self.yy = 0
	self.ID = 101
	self.注释 = "活跃商城"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	tp = 根
	self.银两文字 = tp.文字类.创建(wdf配置.."/font/hkyt.ttf", 15)
	self.银两文字:置颜色(白色)
	self.窗口时间 = 0
	self.选中编号 = 0
	self.选中编号2 = 0
	self.选中编号3 = 0
	self.加入 = 0
	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('给予总控件')
	总控件:置可视(true,true)
	self.输入框 = 总控件:创建输入("银两输入",0,0,100,14)
	self.输入框:置可视(false,false)
	self.输入框:置限制字数(8)
	self.输入框:置数字模式()
	self.输入框:屏蔽快捷键(true)
	self.输入框:置光标颜色(-16777216)
	self.输入框:置文字颜色(-16777216)
	zts = tp.字体表.道具字体
	zt = tp.字体表.描边字体
end

function 系统类_活跃商城:打开(数据)
	if self.可视 then
		self.可视 = false
		self.选中编号 = 0
		self.选中编号2 = 0
		self.选中编号3 = 0
		self.物品数据={}
		self.输入框:置可视(false,false)
		self.资源组 = nil
		self.选中显示 = nil
		self.选中显示2 = nil
		self.购买 = nil
		return
	else
		insert(tp.窗口_,self)
		local 资源 = tp.资源
		local 按钮 = tp._按钮
		local 自适应 = tp._自适应
		self.资源组 = {
			[1] = 资源:载入('nccmm.npk',"网易WDF动画","3"),
		}
		self.选中显示 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x6F88F494)
		self.选中显示2 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x10921CA7)
		self.购买 = 按钮.创建(资源:载入('nccmm.npk',"网易WDF动画","11"),0,0,2,true,true," 购  买")
		self.数据=数据["活跃兑换"]
		self.组号 = 数据.组号
		self.物品数据={}
		self.商品编号 = 0
		for i=1,#数据["活跃兑换"] do
			self.物品数据[i] = tp._物品格子.创建(0,0,i,"活跃商品")
			self.物品数据[i]:置物品(数据["活跃兑换"][i])
			self.物品数据.数量的=#数据["活跃兑换"]
			self.物品数据[i].编号 = n
			self.物品数据[i].价格=数据["活跃兑换"][i].价格
		end
		self.可用活跃=数据.积分数.当前活跃
		self.总积分=数据.积分数.累积活跃
		self.数量 = 1
		self.价格 = 0
		self.总额 = 0
		self.输入框:置可视(true,true)
	    self.输入框:置文本("")
		tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end

function 系统类_活跃商城:显示(dt,x,y)
	self.购买:更新(x,y,self.商品编号 ~= 0)
	if self.输入框:取文本() ~= "" and self.数量 ~= (self.输入框:取文本()+0) then
		self.数量 = 到整数(self.输入框:取文本())
		self.总额 = self.数量 * self.价格
	end
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	self.输入框:置可视(true,true)
	self.输入框:置坐标(self.x+255,self.y+375)
	self.控件类:更新(dt,x,y)
	self.控件类:显示(x,y)
	银两显示(self.银两文字, self.可用活跃, self.x+20,self.y+ 375)
	银两显示(self.银两文字, self.总额,self.x+150,self.y+ 375)
	self.购买:显示(self.x+340, self.y+367)
	if self.购买:事件判断() then
	    if self.商品编号 == 0 then
			tp.常规提示:打开("#y/请先选择一件商品")
		else
			if self.商品编号~=0 then
				if self.可用活跃< self.物品数据[self.商品编号].价格 then
				    tp.常规提示:打开("#y/当前可用活跃不够兑换商品!")
				    return
				end
				self.可用活跃=self.可用活跃-self.物品数据[self.商品编号].价格*self.数量
				self.发送信息 = {
					编号 = self.商品编号,--self.物品数据[self.分类][self.商品编号].编号,
					位置 =self.商品编号,
					数量 = self.数量,
					组号 = self.组号,
					分类 = "活跃兑换"
				}
				请求服务(30,self.发送信息)
			end
		end
	end
	local bbsa = self.物品数据.数量的
	local x横,x竖 = 0,0
	for n = 1, 48 do
		if self.物品数据[n+self.加入*48]~=nil then
			if self.物品数据[n+self.加入*48].焦点 then
				self.选中编号 = n+self.加入*48
				if 引擎.鼠标弹起(左键) then
				    self.选中编号2=n
				    self.选中编号3 = n+self.加入*48
				end
			end
			self.物品数据[n+self.加入*48]:置坐标(self.x+15+x横*51, self.y+35+x竖*51)
			self.物品数据[n+self.加入*48]:显示(dt,x,y,self.鼠标)
			if self.选中编号2 ~= 0 and self.选中编号2 == n then
				self.选中显示2:显示(self.x+15+x横*51, self.y+36+x竖*51)
			end
		end
		if x横 == 8  then
			x横 = 0
			x竖=x竖+1
		else
			x横 = x横+1
		end
	end
	if self.选中编号 ~= 0 then
		if self.物品数据[self.选中编号].焦点 then
		    tp.提示:道具行囊(x,y,self.物品数据[self.选中编号].物品)
		end
		if 引擎.鼠标弹起(左键) then
			self.价格 = self.数据[self.选中编号].价格
			if self.商品编号 == self.选中编号 then
				self.数量 = self.数量 + 1
				self.总额 = self.数量 * self.价格
				self.输入框:置文本(self.数量)
				return 0
			else
				self.数量 = 1
				self.总额 = self.数量 * self.价格
				self.输入框:置文本(self.数量)
			end
			self.商品编号 = self.选中编号
		elseif 引擎.鼠标弹起(右键) and self.商品编号 == self.选中编号 and self.数量 > 1 then
			self.数量 = self.数量 - 1
			self.总额 = self.数量 * self.价格
			self.输入框:置文本(self.数量)
		end
	end
	if self.输入框._已碰撞 then
		self.焦点 = true
	end
end

function 系统类_活跃商城:检查点(x,y)
	if self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 系统类_活跃商城:初始移动(x,y)
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

function 系统类_活跃商城:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 系统类_活跃商城