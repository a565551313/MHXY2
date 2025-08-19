--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-04-12 02:12:21
--======================================================================--
local 内存类_技能 = class()
local ski = 引擎.取技能
local typ = type

function 内存类_技能:初始化()
--[[
    0  只有平时可用 只能对自己使用
	1  只有平时可用 能对我方使用
	2  只有战斗可用 只能对自已使用
	3  只有战斗可用 对我方使用
	4  只有战斗可用 对敌人使用
	5  平时战斗都可用 对自已使用
	6  平时战斗都可用 对我方使用
	7  被动
	8  未定义
	9  只有战斗可用,对我方使用,但不能对自己使用
	10 只有战斗可用,目标死亡可用
--]]
end

function 内存类_技能:置对象(名称,f)
	if 名称 == nil then return end
	if typ(名称) == "table" then 名称 = 名称.名称 end
	local n = ski(名称)
	if n == nil then return end
	self.名称 = 名称
	self.种类 = n[3]
	self.大模型资源 = n[7]
	self.小模型资源 = n[8]
	self.资源 = n[6]
	if f ~= nil and f  ~= 1 and f ~= 2 then return end
	self.介绍 = n[1]
	if self.种类 == 0 then
		self.包含技能 = {}
	end
	if self.种类 ~= 8 and self.种类 ~= 7 then
		self.学会 = false
	end
	if self.种类 ~= nil then
		self.消耗说明 = n[4]
	end
	if self.种类 ~= nil then
		self.使用条件 = n[5]
	end
	self.冷却 = n[12]
end

function 内存类_技能:置奇经八脉对象(名称)
	if 名称 == nil then return end
	if typ(名称) == "table" then 名称 = 名称.名称 end
	local n = 引擎.取奇经八脉技能(名称)
	if n == nil then return end
	self.名称 = 名称
	self.种类 = n[3]
	self.大模型资源 = n[7]
	self.小模型资源 = n[8]
	self.资源 = n[6]
	self.介绍 = n[1]
	if self.种类 == 0 then
		self.包含技能 = {}
	end
	if self.种类 ~= 8 and self.种类 ~= 7 then
		self.学会 = false
	end
	if self.种类 ~= nil then
		self.消耗说明 = n[4]
	end
	if self.种类 ~= nil then
		self.使用条件 = n[5]
	end
	self.冷却 = n[12]
end

return 内存类_技能