--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:02:34
--======================================================================--
local 场景类_商店 = class()
local tp,zts,zts1
local insert = table.insert
local xxx = 0
local yyy = 0
local sts = {"单价","数量","总额","现金"}
local tos = 取金钱颜色
local mouseb = 引擎.鼠标弹起
function 场景类_商店:初始化(根)
	self.ID = 22
	self.x = 220
	self.y = 100
	self.xx = 0
	self.yy = 0
	self.注释 = "商店"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('商店总控件')
	总控件:置可视(true,true)
	self.输入框 = 总控件:创建输入("商店数量输入",0,0,100,14)
	self.输入框:置可视(false,false)
	self.输入框:置限制字数(3)
	self.输入框:置数字模式()
	self.输入框:屏蔽快捷键(true)
	self.输入框:置光标颜色(-16777216)
	self.输入框:置文字颜色(-16777216)
	self.输入框:置文本("")
	self.单价 = 0
	self.数量 = 0
	self.上一次 = 1
	self.窗口时间 = 0
	tp = 根
	zts = 根.字体表.普通字体
	zts1 = 根.字体表.描边字体
end

function 场景类_商店:打开(道具组,名称)
	if self.可视 then
		for i=1,25 do
			self.商品[i]:置物品(nil)
		end
		self.道具 = nil
		self.单价 = 0
		self.数量 = 0
		self.可视 = false
		self.商品[self.上一次].确定 = false
		self.上一次 = 1
		self.输入框:置焦点(false)
		self.输入框:置可视(false,false)
		self.资源组 = nil
		self.商品 = nil
		return
	else
		self.临时道具={}
		self.临时价格={}
		for n=1,#道具组 do
          self.临时数据=分割文本2(道具组[n],"*")
          self.临时道具[n]=self.临时数据[1]
          self.临时价格[n]=self.临时数据[2]
		end
		insert(tp.窗口_,self)
		self:加载数据()
		local wp = tp._物品
		for n=1,#self.临时道具 do
			sp = wp()
			sp:置对象(self.临时道具[n])
			if sp.总类 == 2 then
				sp.鉴定 = true
			end
			self.商品[n]:置物品(sp)
			self.商品[n].物品.价格=self.临时价格[n]
			self.商品[n].物品.原始商品=道具组[n]
          if self.商品[n].物品.总类==2 then
		     self.商品[n].物品.鉴定=true
			 self.商品[n].物品.五行=取五行()
			 self.商品[n].物品.开运孔数 = {当前=0,上限=0}
			self.商品[n].物品.符石={}
			self.商品[n].物品.星位={}
			self.商品[n].物品.符石组合 = {符石组合 = {},门派条件 ={},部位条件={},效果说明={}}
			self.商品[n].物品.熔炼效果={}

			 end
		end
	    self.输入框:置可视(true,true)
	    self.输入框:置文本("")
	    tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
 self.商店名称=名称
end

function 场景类_商店:加载数据()	-- body
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,272,421,3,9),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[3] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"购买"),
		[4] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xE9C090A3),
		[5] = 自适应.创建(3,1,94,18,1,3),
		[6] = 自适应.创建(1,1,268,18,1,3,nil,18),
	}
	for n=2,3 do
	   self.资源组[n]:绑定窗口_(22)
	end
	self.商品 = {}
	local 物品格子 = tp._物品格子
	for i=1,25 do
		self.商品[i] = 物品格子(0,i,n,"商店")
	end
end

function 场景类_商店:显示(dt,x,y)
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y,self.道具 ~= nil)
	if self.资源组[2]:事件判断() then
		self:打开()
		return
	elseif self.资源组[3]:事件判断() then
		local v = tonumber(self.数量 * self.单价)
		if v < 0 then
			引擎.关闭()
		end
		请求服务(1503,{数量=self.数量,商品=self.道具.原始商品})
	end
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[6]:显示(self.x+2,self.y+2)
	tp.横排花纹背景_:置区域(0,0,248,13)
	tp.横排花纹背景_:显示(self.x+14,self.y+293)

  if self.商店名称==nil then
  	tp.窗口标题背景_[3]:显示(self.x+self.资源组[1].宽度/2-50,self.y+2)
	 zts1:显示(self.x+self.资源组[1].宽度/2-20,self.y+2,"购  买")

  else
  	tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
  	 zts1:显示(self.x+self.资源组[1].宽度/2-30,self.y+2,self.商店名称)
	 end
	zts:置颜色(4294967295)
	zts:置字间距(15)
	for i=0,3 do
		self.资源组[5]:显示(self.x+70,self.y+317+i*24)
		zts:显示(self.x+22,self.y+321+i*24,sts[i+1])
	end
	zts:置字间距(0)
	self.资源组[4]:显示(self.x+9,self.y+28)
	self.资源组[2]:显示(self.x+251,self.y+2)
	self.资源组[3]:显示(self.x+188,self.y+390,true)
	local xx = 0
	local yy = 0
	for i=1,25 do
		self.商品[i]:置坐标(self.x + xx * 51 + 10,self.y + yy * 51 + 28)
		self.商品[i]:显示(dt,x,y,self.鼠标)
		if self.商品[i].物品 ~= nil and self.商品[i].焦点 then
			tp.提示:道具行囊(x,y,self.商品[i].物品,true)
			if mouseb(0) then
				if self.道具 == nil then
					self.商品[self.上一次].确定 = false
					self.商品[i].确定 = true
					self.上一次 = i
					self.道具 = self.商品[i].物品
					self.单价 = tostring(self.道具.价格)
					self.数量 = 1
				else
					if self.上一次 == i then
						self.数量 = self.数量 + 1
					else
						self.商品[self.上一次].确定 = false
						self.商品[i].确定 = true
						self.上一次 = i
						self.道具 = self.商品[i].物品
						self.单价 = tostring(self.道具.价格)
						self.数量 = 1
					end
				end
				self.输入框:置文本(self.数量)
			end
		end
		xx = xx + 1
		if xx == 5 then
			xx = 0
			yy = yy + 1
		end
	end
	if self.道具 ~= nil then
		zts:置颜色(-16777216)
		zts:显示(self.x + 79,self.y + 322,self.单价)
		self.输入框:置坐标(self.x + 80,self.y + 345)
		if self.输入框:取文本() == "" then
			self.输入框:置文本(1)
		end
		if tonumber(self.输入框:取文本()) > 99 then
			self.输入框:置文本(99)
		end
		self.数量 = tonumber(self.输入框:取文本())
		zts:置颜色(tos((self.数量 * self.单价)))
		zts:显示(self.x + 78,self.y + 369,(self.数量 * self.单价))
	end
	zts:置颜色(tos(tp.金钱))
	zts:显示(self.x + 78,self.y + 393,tp.金钱)
	self.控件类:更新(dt,x,y)
	if self.输入框._已碰撞 then
		self.焦点 = true
	end
	self.控件类:显示(x,y)
end

function 场景类_商店:检查点(x,y)
	if self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_商店:初始移动(x,y)
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

function 场景类_商店:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy

	end
end

return 场景类_商店