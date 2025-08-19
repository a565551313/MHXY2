--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-09-28 14:02:14
--======================================================================--
local 场景类_自由技能栏 = class()

local floor = math.floor
local bw = require("gge包围盒")(0,0,164,39)
local box = 引擎.画矩形
local tp
local mouseb = 引擎.鼠标弹起

function 场景类_自由技能栏:初始化(根)
	self.ID = 35
	self.x = 228
	self.y = 83
	self.xx = 0
	self.yy = 0
	self.注释 = "自由技能栏"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.介绍文本 = 根._丰富文本(150,150,根.字体表.普通字体)
	self.窗口时间 = 0
	self.刷新文本 = false
	self.类别 = ""
	self.选中 = 0
	self.加入 = 0
	self.上限 = 0
	tp = 根
end

function 场景类_自由技能栏:打开(类别)
	if self.可视 then
		self.介绍文本:清空()
		self.刷新文本 = false
		self.可视 = false
		self.资源组 = nil
		self.学习格子 = nil
		return
	else
		local jn = tp._技能格子
		local 资源 = tp.资源
		local 按钮 = tp._按钮
		self.资源组 = {
			[1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x9ED74AA6),
			[2] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xF11233BB),0,0,4,true,true),
			[3] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xFD3D61F2),0,0,4,true,true),
			[4] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x09217E13),0,0,4,true,true),
			[5] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xFD3D61F2),0,0,4,true,true),
			[6] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x09217E13),0,0,4,true,true),
			[7] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x2BD1DEF7),0,0,4,true,true,"学习"),
		}
		for n=2,7 do
			self.资源组[n]:绑定窗口_(35)
		end
		self.学习格子 = {}
		if 类别 == "辅助" then
			for i=1,#tp.队伍[1].辅助技能 do
				self.学习格子[i] = tp.资源:载入(tp.队伍[1].辅助技能[i].资源,"网易WDF动画",tp.队伍[1].辅助技能[i].小模型资源)
			end
			self.上限 = 150
		end
		self.类别 = 类别
		tp.运行时间 = tp.运行时间 + 1
	  	self.窗口时间 = tp.运行时间
		self.可视 = true
	end
end

function 场景类_自由技能栏:显示(dt,x,y)
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y,false)
	self.资源组[4]:更新(x,y,false)
	self.资源组[5]:更新(x,y,false)
	self.资源组[6]:更新(x,y,false)
	self.资源组[7]:更新(x,y,self.选中 ~= 0)
	local font = tp.字体表.普通字体
	local xx = 0
	local yy = 0
	if self.资源组[2]:事件判断() then
		self:打开()
		return false
	elseif self.资源组[7]:事件判断() then
		if self.类别 == "辅助" then
			local a = self:学习技能(tp.队伍[1].辅助技能[self.选中].等级)
			if a >= a then
				if tp.队伍[1].辅助技能[self.选中].等级 < self.上限 then
					tp.积分 = tp.积分 - a
					tp.队伍[1].技能等级[self.选中] = tp.队伍[1].技能等级[self.选中] + 1
					tp.队伍[1].辅助技能[self.选中].等级 = tp.队伍[1].辅助技能[self.选中].等级 + 1
					tp.队伍[1]:刷新信息("1")
					tp.常规提示:打开(string.format("#Y/本次升级消耗了%d积分，还剩点%d积分",a,tp.积分))
					self.介绍文本:清空()
					self.介绍文本:添加文本("#N/【介绍】"..tp.队伍[1].辅助技能[self.选中].介绍)
					self.介绍文本:添加文本("#N/【等级】"..tp.队伍[1].辅助技能[self.选中].等级)
					self.介绍文本:添加文本("#N/【升级积分】"..self:学习技能(tp.队伍[1].辅助技能[self.选中].等级))
				else
					tp.常规提示:打开("#Y/已经达到上限等级了，不可以再升级了")
				end
			else
			    tp.常规提示:打开(string.format("#Y/你当前的积分为%d点，距离升级辅助技能差需要%d点积分",tp.积分,a-tp.积分))
			end
		end
	end
	-- 显示
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[2]:显示(self.x + 364,self.y + 6)
	self.资源组[3]:显示(self.x + 355,self.y + 40)
	self.资源组[4]:显示(self.x + 355,self.y + 168)
	self.资源组[5]:显示(self.x + 354,self.y + 202)
	self.资源组[6]:显示(self.x + 354,self.y + 330)
	self.资源组[7]:显示(self.x + 154,self.y + 440,true)
	if self.类别 == "辅助" then
		for i=1,#self.学习格子 do
			xx = self.x + 18
			yy = self.y + i * 40
			bw:置坐标(xx,yy + 30)
			if self.选中 ~= i + self.加入 then
				if bw:检查点(x,y) then
					box(xx-2,yy+25,xx+163,yy+39+25,-3551379)
					if self.鼠标 and mouseb(0) then
						self.选中 = i + self.加入
						self.介绍文本:清空()
						self.介绍文本:添加文本("#N/【介绍】"..tp.队伍[1].辅助技能[self.选中].介绍)
						self.介绍文本:添加文本("#N/【等级】"..tp.队伍[1].辅助技能[self.选中].等级)
						self.介绍文本:添加文本("#N/【升级积分】"..self:学习技能(tp.队伍[1].辅助技能[self.选中].等级))
					end
					self.焦点 = true
				end
			else
				local ys = -10790181
				if bw:检查点(x,y) then
					ys = -9670988
					self.焦点 = true
				end
				box(xx-2,yy+25,xx+163,yy+39+25,ys)
			end
			self.学习格子[i]:显示(self.x + 18,yy + 30)
			font:置颜色(-16777216)
			font:显示(xx + 35,yy + 37,tp.队伍[1].辅助技能[i].名称)
			font:显示(xx + 112,yy + 37 ,tp.队伍[1].辅助技能[i].等级.."/"..self.上限)
		end
	end
	if self.选中 ~= 0 then
		font:显示(self.x + 83,self.y + 362,tp.队伍[1].当前经验)
		font:显示(self.x + 83,self.y + 385,tp.金钱)
		font:显示(self.x + 83,self.y + 407,tp.存银)
		font:显示(self.x + 290,self.y + 362,0)
		font:显示(self.x + 290,self.y + 385,0)
		font:显示(self.x + 290,self.y + 407,0)
	end
	self.介绍文本:显示(self.x+205,self.y+205)
end

function 场景类_自由技能栏:检查点(x,y)
	if self.可视 and  self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_自由技能栏:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if self.可视 and self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_自由技能栏:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

function 场景类_自由技能栏:学习技能(当前技能等级,目标技能等级)
	return floor(当前技能等级*(1+0.5*(当前技能等级-1)))
end

return 场景类_自由技能栏