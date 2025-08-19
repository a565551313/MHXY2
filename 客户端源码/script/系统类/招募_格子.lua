--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2018-11-13 19:54:46
--======================================================================--
local 系统类_招募格子 = class()

function 系统类_招募格子:初始化(x,y,ID)
	self.x = x
	self.y = y
	self.ID = ID
	self.角色 = nil
	self.模型 = nil
	self.事件 = false
	self.焦点 = false
	self.包围盒  = require("gge包围盒")(x,y,50,50)
	self.确定 = false
	self.偏移 = {x=0,y=0}
	self.模式 = 0
end

function 系统类_招募格子:置角色(角色,模式)
	if 角色 ~= nil then
		if 角色.名称 ~= nil then
			local v = ""
			if 模式 == 2 then
				v = "_"
			end
			local n = 引擎.取头像(角色.模型)
			if n[8] == nil then
				n[8] = n[7]
			end
			self.模型 = 引擎.场景.资源:载入(n[8],"网易WDF动画",n[2])
			self.角色 = 角色
		end
	else
	    self.模型 = nil
		self.角色 = nil
	end
end

function 系统类_招募格子:更新(dt,x,y,窗口)
	if not 引擎.场景.消息栏焦点 then
		self.事件 = false
		self.焦点 = false
		if self.包围盒:检查点(x,y)  and (not 引擎.场景.战斗中 and 引擎.场景.窗口_[引擎.场景.选中窗口] ~= nil and 引擎.场景.窗口_[引擎.场景.选中窗口].ID == 窗口) then
			按钮焦点 = true
			禁止关闭 = true
			self.焦点 = true
			引擎.场景.物品格子焦点_:更新(dt)
			if self.模型 ~= nil and self.角色 ~= nil then
				if 引擎.鼠标弹起(0) then
					self.事件 = true
				end
			end
		end
	end
end

function 系统类_招募格子:显示(x,y,窗口)
	if self.确定 then
		引擎.场景.物品格子确定_:显示(self.x+1,self.y+1)
	end
	if self.模型 ~= nil and self.角色 ~= nil then
		self.模型:显示(self.x+2,self.y+4)
	end
	if not 文本栏焦点 then
		if self.包围盒:检查点(x,y) and (not 引擎.场景.战斗中 and 引擎.场景.窗口_[引擎.场景.选中窗口] ~= nil and 引擎.场景.窗口_[引擎.场景.选中窗口].ID == 窗口) then
			self.焦点 = true
			引擎.场景.物品格子焦点_:显示(self.x+1,self.y+1)
		end
	end
end


function 系统类_招募格子:置坐标(x,y)
	self.x = x
	self.y = y
	self.包围盒:置坐标(x,y)
end

return 系统类_招募格子