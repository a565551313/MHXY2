--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2021-07-10 22:43:01
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 技能类 = class()
local ski = 取法术技能
local typ = type

function 技能类:初始化() end
function 技能类:置对象(名称,f)
	if 名称 == nil then
	 return
	end
	if typ(名称) == "table" then
	 名称 = 名称.名称
	end
	local n = ski(名称) if n == nil then
	 return
	end
	self.名称 = 名称 --self.种类 = n[3] --self.大模型资源 = n[7] self.小模型资源 = n[8] self.资源 = n[6]
	if f ~= nil and f  ~= 1 and f ~= 2 then
	 return
	end
	self.介绍 = n[1]
	self.介绍=nil
	if self.种类 == 0 then
		self.包含技能 = {}
	end
	if self.种类 ~= 8 and self.种类 ~= 7 then
		self.学会 = false
	end
	if self.种类 ~= nil then
		--self.消耗说明 = n[4]
	end
	if self.种类 ~= nil then
		--self.使用条件 = n[5]
	end
	--self.冷却 = n[12]
end
function 技能类:更新(dt) end
function 技能类:显示(x,y) end

return 技能类