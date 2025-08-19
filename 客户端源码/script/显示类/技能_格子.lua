--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-03-23 00:45:28
--======================================================================--
local 系统类_技能格子 = class()
local tp;
local mouse = 引擎.鼠标弹起

function 系统类_技能格子:初始化(x,y,ID,注释)
	self.x = x
	self.y = y
	self.注释 = 注释
	self.技能 = nil
	self.事件 = false
	self.焦点 = false
end

function 系统类_技能格子:置技能(技能,小模型,大模型) --判断是小模型
	if 技能 ~= nil and 技能.名称 ~= nil then
		self.技能 = 技能
		if tp == nil then
			tp = 引擎.场景
		end
		if 大模型==nil then
			local 临时技能=引擎.取技能(技能.名称)
			if #临时技能~=0 then
				大模型=临时技能[7]
				小模型=临时技能[8]
				self.技能.模型 = tp.资源:载入(临时技能[6],"网易WDF动画",临时技能[7])
				self.技能.小模型 = tp.资源:载入(临时技能[6],"网易WDF动画",临时技能[8])
				self.技能.介绍=临时技能[1]
				self.技能.消耗说明=临时技能[4]
				self.技能.使用条件=临时技能[5]
				self.技能.冷却=临时技能[12]
			end
		end
		if 大模型 == nil then
			self.技能.模型 = tp.资源:载入(技能.资源,"网易WDF动画",技能.大模型资源)
		end
		if 小模型 == nil and 技能.小模型 ~= nil then
			self.技能.小模型 = tp.资源:载入(技能.资源,"网易WDF动画",技能.小模型资源)
		end
	else
		self.技能 = nil
	end
end


function 系统类_技能格子:置奇经八脉技能(技能,小模型,大模型) --判断是小模型
	if 技能 ~= nil and 技能.名称 ~= nil then
		self.技能 = 技能
		if tp == nil then
			tp = 引擎.场景
		end
		if 大模型==nil then
			local 临时技能=引擎.取奇经八脉技能(技能.名称)
			if #临时技能~=0 then
				大模型=临时技能[7]
				小模型=临时技能[8]
				self.技能.模型 = tp.资源:载入(临时技能[6],"网易WDF动画",临时技能[7])
				self.技能.小模型 = tp.资源:载入(临时技能[6],"网易WDF动画",临时技能[8])
				self.技能.介绍=临时技能[1]
				self.技能.消耗说明=临时技能[4]
				self.技能.使用条件=临时技能[5]
				self.技能.冷却=临时技能[12]
			end
		end
		if 大模型 == nil then
			self.技能.模型 = tp.资源:载入(技能.资源,"网易WDF动画",技能.大模型资源)
		end
		if 小模型 == nil and 技能.小模型 ~= nil then
			self.技能.小模型 = tp.资源:载入(技能.资源,"网易WDF动画",技能.小模型资源)
		end
	else
		self.技能 = nil
	end
end


function 系统类_技能格子:显示(x,y,条件)
	if self.技能 == nil then
		return
	end
	self.事件 = false
	self.焦点 = false
	if 条件 and self.技能.模型:是否选中(x,y) then
		tp.按钮焦点 = true
		tp.禁止关闭 = true
		self.焦点 = true
		self.技能.模型:置高亮()
		if mouse(0) then
			self.事件 = true
		end
	else
		self.技能.模型:取消高亮()
	end
	if self.剩余冷却回合 ~= nil then
		self.技能.模型:灰度级()
	end
	self.技能.模型:显示(self.x,self.y)
end

function 系统类_技能格子:置坐标(x,y)
	self.x = x
	self.y = y
end

return 系统类_技能格子