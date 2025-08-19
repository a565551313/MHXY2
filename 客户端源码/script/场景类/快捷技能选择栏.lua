--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-09-28 14:21:26
--======================================================================--
local 场景类_快捷技能选择栏 = class()
local tp
local insert = table.insert
local xxx = 0
local yyy = 0
function 场景类_快捷技能选择栏:初始化(根)
	self.ID = 48
	self.x = 390
	self.y = 85
	self.xx = 0
	self.yy = 0
	self.注释 = "战斗"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口时间 = 0
	self.偏移 = {0,0}
	tp = 根

end

function 场景类_快捷技能选择栏:打开(格子)
	if self.可视 then
		self.可视 = false
		tp.快捷技能显示 =false
		self.资源组=nil
		self.技能=nil
		return
	else
		self.格子 = 格子
		self:加载资源()
		for i=1,8 do
			local 临时技能={名称="仙灵店铺",等级1}
			self.技能[i]:置技能(临时技能)--tp.队伍[1].人物技能[i])
		end
		insert(tp.窗口_,self)
	  	self.可视 = true
	  	tp.快捷技能显示 =true
	end
end
function 场景类_快捷技能选择栏:加载资源()
	local 按钮 = tp._按钮
	local 资源 = tp.资源
	self.资源组 = {
		[1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x4226BD41),
	}
	self.技能 = {}
	local 格子 = tp._技能格子
	for i=1,8 do
		self.技能[i] = 格子(0,0,i,"快捷技能选择栏")
	end
end

function 场景类_快捷技能选择栏:显示(dt,x,y)
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	local xx = 0
	local yy = 0
	for i=1,8 do
		self.技能[i]:置坐标(self.x+25+xx*50,self.y+28+yy*42)
		self.技能[i]:显示(x,y,self.鼠标)
		if self.技能[i].技能 and self.技能[i].焦点 then
			tp.提示:技能(x,y,self.技能[i].技能,self.技能[i].剩余冷却回合,true)
			if self.技能[i].事件 then
				tp.队伍[1].快捷技能[self.格子] = self.技能[i].技能
				self:打开()
				return
			end
		end
		xx = xx + 1
		if xx == 3 then
			xx = 0
			yy = yy + 1
		end
	end
end

function 场景类_快捷技能选择栏:检查点(x,y)
	if self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_快捷技能选择栏:初始移动(x,y)
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

function 场景类_快捷技能选择栏:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_快捷技能选择栏