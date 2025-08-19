--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-12-06 07:34:09
--======================================================================--
local 内存类_物品 = class()
local ceil = math.ceil

local floor = math.floor
local wps = 引擎.取物品
local typ = type
local random = 引擎.取随机整数
local 五行_ = {"金","木","水","火","土"}

local function 变身卡(模型)
	if 模型 == "大海龟" then
		return "大海龟","item.wdf",0x4A028BEE,0x3C7B89E8,nil,nil,20,1,3
	elseif 模型 == "巨蛙" then
		return "巨蛙","item.wdf",0x4A028BEE,0x98E3377F,nil,nil,20,1,3
	elseif 模型 == "海星" then
		return "海星","item.wd1",1241680878,3876179373,nil,nil,20,1,3,"item.wdf"
	elseif 模型 == "章鱼" then
		return "章鱼","item.wd1",1241680878,2880866697,nil,nil,20,1,3,"item.wdf"
	elseif 模型 == "浣熊" then
		return "浣熊","item.wd1",1241680878,2785980633,nil,nil,20,1,3,"item.wdf"
	elseif 模型 == "大蝙蝠" then
		return "大蝙蝠","item.wdf",1241680878,0x2481DFCC,nil,nil,20,1,3
	elseif 模型 == "赌徒" then
		return "赌徒","item.wdf",1241680878,0x6BE81A68,nil,nil,20,1,3
	elseif 模型 == "海毛虫" then
		return "海毛虫","item.wdf",1241680878,0x3BD0B554,nil,nil,20,1,3
	elseif 模型 == "护卫" then
		return "护卫","item.wdf",1241680878,0x7003F174,nil,nil,20,1,3
	elseif 模型 == "强盗" then
		return "强盗","item.wdf",1241680878,0xD5C2566E,nil,nil,20,1,3
	elseif 模型 == "山贼" then
		return "山贼","item.wdf",1241680878,0x5F7346A8,nil,nil,20,1,3
	elseif 模型 == "树怪" then
		return "树怪","item.wdf",1241680878,0x4ED5C9C4,nil,nil,20,1,3
	elseif 模型 == "野猪" then
		return "野猪","item.wdf",1241680878,0xEF3A830D,nil,nil,20,1,3
	end
end


local function 取套装效果(tz)
	if tz == "盘丝阵" or tz == "定心术" or tz == "极度疯狂" or tz == "金刚护法" or tz == "逆鳞" or tz == "生命之泉" or tz == "魔王回首" or tz == "幽冥鬼眼" or tz == "楚楚可怜" or tz == "百毒不侵" or tz == "变身" or tz == "普渡众生" or
		tz == "炼气化神" or tz == "修罗隐身" or tz == "杀气诀" or tz == "一苇渡江" or tz == "碎星诀" or tz == "明光宝烛" then
		return "附加状态"
	elseif tz == "知己知彼" or tz == "似玉生香" or tz == "三味真火" or tz == "日月乾坤" or tz == "镇妖" or tz == "尸腐毒" or tz == "阎罗令" or tz == "百万神兵" or tz == "勾魂" or tz == "判官令" or tz == "雷击" or tz == "魔音摄魂" or tz == "摄魄" or tz == "紧箍咒" or
		tz == "落岩" or tz == "含情脉脉" or tz == "日光华" or tz == "水攻" or tz == "唧唧歪歪" or tz == "谆谆教诲"  or tz == "靛沧海" or tz == "烈火" or tz == "催眠符" or tz == "龙卷雨击" or tz == "巨岩破" or tz == "奔雷咒" or tz == "失心符" or tz == "龙腾" or tz == "苍茫树" or tz == "泰山压顶" or
		tz == "落魄符" or tz == "龙吟" or tz == "地裂火" or tz == "水漫金山" or tz == "定身符" or tz == "五雷咒" or tz == "后发制人" or tz == "地狱烈火" or tz == "满天花雨" or tz == "飞砂走石" or tz == "横扫千军" or tz == "落叶萧萧" or tz == "尘土刃" or tz == "荆棘舞" or tz == "冰川怒" or tz == "夺命咒" or tz == "浪涌" or tz == "裂石" then
		return "法术追加"
	end
end

function 内存类_物品:初始化()

end

function 内存类_物品:置对象(名称,打造,总类,根,允许)
	local 道具
	local c = false

	if typ(名称) == "table" then
		self.临时道具= wps(名称)
        self.介绍 = 道具[1]
		self.总类 = 道具[2]
		self.分类 = 道具[3]
		self.子类 = 道具[4]
		道具 = 名称
		self.名称 = 道具.名称
		c = true
		self.介绍 = 道具.介绍
		self.总类 = 道具.总类
		self.分类 = 道具.分类
		self.子类 = 道具.子类
		if  道具.总类 == 2 then
			self.级别限制 = 道具.级别限制
			self.角色限制 = 道具.角色限制
			self.性别限制 = 道具.性别限制
			self.级别限制 = 道具.级别限制
		end
		self.小模型 = 道具.小模型
		self.大模型 = 道具.大模型
		--print(道具.类型)
		if 道具.阶品 ~= nil then
		    self.阶品 = 道具.阶品
		end
		if 道具.价格 ~= nil then
		    self.价格 = 道具.价格
		end
		if 道具.气血 ~= nil then
			self.气血 = 道具.气血
		end
		if 道具.魔法 ~= nil then
			self.魔法 = 道具.魔法
		end
	else
		道具 = wps(名称)
		self.介绍 = 道具[1]
		self.总类 = 道具[2]
		self.分类 = 道具[3]
		self.子类 = 道具[4]
		self.名称 = 名称
		if 道具[2] == 2 then
			self.级别限制 = 0
			if 道具[7] ~= nil then
				self.角色限制 = 道具[7]
			end
			if 道具[6] ~= nil then
				self.性别限制 = 道具[6]
			end
			if 道具[5] ~= nil then
				self.级别限制 = 道具[5]
			end
		end
		if 道具[2] == 1 then
			self.阶品 = 道具[8]
		end
		if 道具[14] ~= nil then
			self.价格 = 道具[14]
		end
		if 道具[9] ~= nil then
			self.气血 = 道具[9]
		end
		if 道具[10] ~= nil then
			self.魔法 = 道具[10]
		end
	end
	self.资源 = 道具[11]
	self.小模型资源 = 道具[12]
	self.大模型资源 = 道具[13]
	if self.总类 == 2 and 允许==nil then
		if self.级别限制 == nil then
			self.级别限制 = 0
		end
		local lv = self.级别限制
		if self.分类 == 3 then
			self.伤害 = ceil((lv/10)*30+10)
			self.命中 = ceil((lv/10)*35+10+2)
		elseif self.分类 == 4 then
			self.防御 = ceil((lv/10)*15+10)
		elseif self.分类 == 1 then
			self.防御 = ceil((lv/10)*5+5)
			self.魔法 = ceil((lv/10)*10+5+2)
		elseif self.分类 == 5 then
			self.防御 = ceil((lv/10)*5+5)
			self.气血 = ceil((lv/10)*20+10)
		elseif self.分类 == 2 then
			self.灵力 = ceil((lv/10)*12+5)
		elseif self.分类 == 6 then
			self.防御 = ceil((lv/10)*5+5)
			self.敏捷 = ceil((lv/10)*3+5)
		elseif self.分类 == 10 then
			self.气血 = ceil((lv/5)*15+20)
		elseif self.分类 == 11 then
			self.魔法 = ceil((lv/5)*5+40)
		elseif self.分类 == 12 then
			self.伤害 = ceil((lv/5)*20+20)
		elseif self.分类 == 13 then
			self.防御 = ceil((lv/5)*3+10)
		elseif self.分类 == 14 then
			self.敏捷 = ceil((lv/5)*2+10)
		end
		self.鉴定 = true
		self.五行 = 五行_[random(1,5)]
		if self.分类 == 3 then
			if self.级别限制 >= 0 and self.级别限制 < 10 then
				self.价格 = 500
			elseif self.级别限制 >= 10 and self.级别限制 < 20 then
				self.价格 = 3000
			elseif self.级别限制 >= 20 and self.级别限制 < 30 then
				self.价格 = 6000
			elseif self.级别限制 >= 30 and self.级别限制 < 40 then
				self.价格 = 10000
			else
				self.价格 = floor((self.级别限制 * 3500)/5)
			end
		else
			if self.级别限制 >= 0 and self.级别限制 < 10 then
				self.价格 = 500
			elseif self.级别限制 >= 10 and self.级别限制 < 20 then
				self.价格 = 1000
			elseif self.级别限制 >= 20 and self.级别限制 < 30 then
				self.价格 = 2500
			elseif self.级别限制 >= 30 and self.级别限制 < 40 then
				self.价格 = 5000
			else
				self.价格 = floor((self.级别限制 * 2500)/5)
			end
		end
		self.开运孔数 = {当前=0,上限=0}
		if self.级别限制<=40 then
		    self.开运孔数 = {当前=0,上限=2}
		elseif self.级别限制>40 and self.级别限制<=80 then
		    self.开运孔数 = {当前=0,上限=3}
		elseif self.级别限制>40 and self.级别限制<=80 then
		    self.开运孔数 = {当前=0,上限=3}
		elseif self.级别限制>80 and self.级别限制<=120 then
		    self.开运孔数 = {当前=0,上限=4}
		elseif self.级别限制>120 and self.级别限制<=160 then
		    self.开运孔数 = {当前=0,上限=5}
		elseif self.级别限制>160 and self.级别限制<=180 then
		    self.开运孔数 = {当前=0,上限=6}
		end
		self.符石={}
		self.星位={}
		self.符石组合 = {符石组合 = {},门派条件 ={},部位条件={},效果说明={}}
		self.熔炼效果={}
	elseif self.总类 == 3 then
		if self.分类 == 1 then
			self.附带技能 = 打造
		end
	elseif self.总类 == 1 then
		if self.阶品 ~= 3 or self.分类 ~= 11 then
			self.可叠加 = true
		else
		    self.可叠加 = false
		end
	elseif self.总类 == 4 then
		self.可叠加 = true
	elseif self.总类 == 5 then
		self.子类 = 打造
		if 总类 ~= nil then
			self.特效 = 总类
		end
		self.可叠加 = false
		if self.分类 == 4 then
			self.子类 = 道具[4]
			self.特效 = 道具[5]
			self.可叠加 = true
		elseif self.分类 == 6 then
			self.子类 = 道具[4]
			self.角色限制 = 道具[8]
			self.级别限制 = 打造 or 1
			self.特效 = 道具[9]
		end
	elseif  self.总类 == 6 then
		self.可叠加 = true
	elseif self.总类 == 7 then
		if self.分类 == 2 then
			self.可叠加 = true
		else
		    self.可叠加 = false
		end
	elseif  self.总类 == 9 then
		self.可叠加 = true
	elseif self.总类 == 10 then
		self.可叠加 = true
	elseif self.总类 == 11 then
		self.可叠加 = false
	elseif self.总类 == 12 then
		self.子类 = 打造
		self.可叠加 = false
	elseif self.总类 == 13 then
		self.子类 = 打造
		self.可叠加 = false
	elseif self.总类 == 100 then
		self.可叠加 = true
	elseif self.总类 == 20 or self.总类 == 25 or self.总类 == 8 then
		self.可叠加 = true
	elseif self.总类 == 1000 then
		self.特效 = 道具[5]
		self.特技 = 道具[6]
		self.气血 = 0
		self.魔法 = 道具[3] * 50
		self.角色限制 = 道具[7] or 0
		self.五行 = 五行_[random(1,5)]
		self.伤害 = 道具[8] or 0
	elseif self.总类 == 1005 then  ----灵宝
		self.使用 = 道具[5]
		self.特技 = 道具[6]
		self.效果 = 道具[15]
		self.魔法 = 道具[3] * 50
		self.气血 = 0
	elseif self.总类 == 21 then
		self.特效 = 道具[8]
		if self.分类 == 3 then
			self.可叠加 = false
		else
			self.可叠加 = true
		end
	elseif self.总类 == 30 then
		self.角色限制,self.资源,self.小模型资源,self.大模型资源,self.特技,self.特效,self.魔法,self.气血,self.伤害,self.小模型id = 变身卡(打造)
	end
end

return 内存类_物品