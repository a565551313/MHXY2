--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-31 23:15:52
--======================================================================--
local collectgarbage = collectgarbage
local 传送点 = require("script/场景类/传送点")
local 精灵类 = require("gge精灵类")
local tp

local 场景类_地图 = class()

function 场景类_地图:初始化(根)
	tp = 根
	self.战斗 ={}
	self.地图 = require("script/资源类/地图类")(根,self)
	self.选中窗口 = 0
	self.移动窗口 = false
	self.抓取物品 = nil
	self.抓取物品ID = nil
	self.抓取物品注释 = nil
	self.战斗提示 = ""
	self.战斗提示时间 = 0
	self.过度纹理 = require("gge纹理类")():渲染目标(全局游戏宽度,全局游戏高度)-- 创建一个截图的背景，实现官网的过度功能
	self.过度进度 = 155
	self.过度时间 = 30
	self.开启场景加载 = false
	self.屏幕坐标 = 生成XY()
	self.滑屏 = 生成XY()
	self.传送区 = nil
	self.当前刷新 = nil
	self.场景最低等级 = nil
	self.场景最高等级  = nil
	self.玩家 = {}
	self.传送 = {}
	self.场景人物 ={}


--有问题1343 1446 1447
-- 1339
---1400 镇妖塔





end

function 场景类_地图:转移(地图,X,Y)

	tp.进程 = 4
	tp.角色坐标 =生成XY(math.floor(X) or 0, math.floor(Y) or 0)
	self.滑屏 =生成XY(math.floor(X) or 0, math.floor(Y) or 0)
	tp.当前地图 = 地图
	local res = tonumber(string.sub(tp.当前地图,-1))
	local bp = tonumber(string.sub(tp.当前地图,-1))
	if tp.窗口.小地图.可视 then
	    tp.窗口.小地图:打开(9999999999999999999999)
	end
	self.地图:加载(wdf配置.."/scene/"..取地图id(tp.当前地图)..".map")
	self.人物 = require("script/全局/人物")(tp)
	tp.音乐 = tp.资源:载入(wdf配置.."/Audio/"..取地图id(tp.当前地图)..".mp3","音乐",nil,tp.音量)
    tp.音乐:播放(true)
    tp.音乐:置音量(游戏音量)
	self.玩家 = {}
	self.传送 = {}
	self.场景人物 ={}
	table.insert(self.场景人物, self.人物)
	-- 自由事件

	tp.窗口.时辰:刷新()
	引擎.截图到纹理(self.过度纹理)
	self.过度精灵 = 精灵类(self.过度纹理)
	self.过度进度 = 255
	self.过度时间 = 3
	tp.隐藏UI = true
	tp.恢复UI = true
	self.人物:停止移动()
	self.地图:传送(tp.角色坐标.x,tp.角色坐标.y)
	collectgarbage("collect")
end

function 场景类_地图:添加玩家(内容)
    -- local f = io.open("假人添加玩家调试.txt", "a+")
    -- f:write("添加玩家:", 内容.名称 or "", ",", 内容.模型 or "", ",", (内容.武器 and 内容.武器.名称 or tostring(内容.武器) or "无"), "\n")
    -- f:close()
    if not 内容 or not 内容.id then return end
   	self.玩家[内容.id]=玩家类.创建(内容)
	table.insert(self.场景人物, self.玩家[内容.id])
end

function 场景类_地图:删除玩家(角色ID)
	if not 角色ID then return end
	self.玩家[角色ID]=nil
	for i=#self.场景人物,1,-1 do
		if self.场景人物[i] and self.场景人物[i].类型=="玩家" and  self.场景人物[i].玩家ID == 角色ID then
			table.remove(self.场景人物, i)
			break
		end
	end
end

function 场景类_地图:玩家队长(角色ID,是否)
	self.玩家[角色ID].队长开关=是否
end

function 场景类_地图:玩家战斗(角色ID,是否)
	self.玩家[角色ID].战斗开关=是否
end

function 场景类_地图:更新行走(路径,行走玩家ID)
	if 路径~=nil and self.玩家[行走玩家ID]~=nil and self.玩家[行走玩家ID].玩家ID~=nil and self.玩家[行走玩家ID].玩家ID == 行走玩家ID then
		local a = 生成XY(math.floor(self.玩家[行走玩家ID].坐标.x / 20),math.floor(self.玩家[行走玩家ID].坐标.y / 20))
		if  self.玩家[行走玩家ID].飞行  then
			self.玩家[行走玩家ID].目标格子 = self.地图.寻路:飞行寻路(a,路径)
		else
			if self.地图.寻路~=nil and self.地图.寻路:寻路(a,路径)~=nil then
				self.玩家[行走玩家ID].目标格子 = self.地图.寻路:寻路(a,路径)
			end
		end
		self.玩家[行走玩家ID].行走开关 = true
	end
end



function 场景类_地图:设置传送(内容)
		 if not 内容 then return end
		 for k,v in pairs(内容) do
		 	  table.insert(self.传送,传送点(v))
		 end
		 if not 传送数据[tp.当前地图] then
		    传送数据[tp.当前地图] =内容
		 end
end





function 场景类_地图:设置假人(内容)
		if not 内容 then return end
		self.场景人物 = {}
		table.insert(self.场景人物, self.人物)
		for k,v in pairs(内容) do
			 if not v.编号 then
			   	v.编号 = k
			 end
			 table.insert(self.场景人物, 假人类.创建(v))
		end
		if not NPC列表[tp.当前地图] then
		    NPC列表[tp.当前地图] =内容
		end
		collectgarbage("collect")
end


function 场景类_地图:添加单位(内容)
	     if 内容 and 内容.id and 内容.编号 then
	     	 table.insert(self.场景人物, 假人类.创建(内容))
	     end
end


function 场景类_地图:删除单位(编号,序列)
		 for i=#self.场景人物,1,-1 do
			if self.场景人物[i].编号 == 编号 and self.场景人物[i].标识 == 序列 then
				table.remove(self.场景人物, i)
				break
			end
		end
end

function 场景类_地图:更改单位(数据)
		for i=#self.场景人物,1,-1 do
			if self.场景人物[i].编号 == 数据.编号 and self.场景人物[i].名称 == 数据.名称 then
				table.remove(self.场景人物, i)
				break
			end
		end
		if 数据.变异 and 数据.变异 and 染色信息[数据.模型] then
			数据.染色方案 = 染色信息[数据.模型].id
			数据.染色组 = 染色信息[数据.模型].方案
		end
		table.insert(self.场景人物, 假人类.创建(数据))
end



function 场景类_地图:传送至(地图,坐标x,坐标y,fc)
	if fc ~= nil then

		引擎.截图到纹理(self.过度纹理)
		self.过度精灵 = 精灵类(self.过度纹理)
		self.过度进度 = 255
		self.过度时间 = 3
		tp.角色坐标.x,tp.角色坐标.y = math.floor(坐标x*20),math.floor(坐标y*20)
		self.地图.移动xy.x,self.地图.移动xy.y = tp.角色坐标.x,tp.角色坐标.y
		self.滑屏.x,self.滑屏.y = tp.角色坐标.x,tp.角色坐标.y
		tp.当前地图 = 地图
		if tp.窗口.小地图.可视 then
		    tp.窗口.小地图:打开(9999999999999999999999)
		end
		if tp.窗口.跑商商店.可视 then
			tp.窗口.跑商商店:打开()
		end
--        资源缓存:清空缓存()
		self.屏幕坐标 = 取画面坐标(self.滑屏.x,self.滑屏.y,self.地图.宽度,self.地图.高度)
		self.地图:加载(wdf配置.."/scene/"..取地图id(tp.当前地图)..".map")
		self:传送指定()
		self.地图:传送(tp.角色坐标.x,tp.角色坐标.y)
		local 地图等级={}
		地图等级[1],地图等级[2]=引擎.取场景等级(tp.当前地图)
		if 地图等级[1]~=nil then
			self.场景最低等级=地图等级[1]
			self.场景最高等级=地图等级[2]
			tp.窗口.消息框:添加文本("#Y/本场景等级为"..地图等级[1].."-"..地图等级[2].."级","xt")
		else
			self.场景最低等级=nil
			self.场景最高等级=nil
		end
		collectgarbage("collect")
		return
	end
	self.传送区 = {地图,坐标x,坐标y,fc}
end

function 场景类_地图:播放音乐(位置)
	local yu = 取Bgm(取地图id(tp.当前地图))
	tp.音乐 = tp.资源:载入(wdf配置.."/Audio/"..yu..".mp3","音乐",nil)
	tp.音乐:置音量(游戏音量)
	if 位置~=nil then tp.音乐:置位置(位置) end
		--tp.音乐:置音量(游戏音量)
	if 游戏音量>0 then
		tp.音乐:播放(true)
	end
end

function 场景类_地图:传送指定()
	local yu = 取Bgm(取地图id(tp.当前地图))
	if tp.音乐.文件 ~= wdf配置.."/Audio/"..yu..".mp3" then
		if 引擎.文件是否存在(wdf配置.."/Audio/"..yu..".mp3") then
			tp.音乐:停止()
			tp.音乐 = nil
			tp.音乐 = tp.资源:载入(wdf配置.."/Audio/"..yu..".mp3","音乐",nil)
		--	tp.音乐:置音量(游戏音量)
			if tp.音乐开启 then
				tp.音乐:播放(true)
				tp.音乐:置音量(游戏音量)
			end
		end
	end
	self.人物:停止移动()
	self.玩家 = {}
	self.传送 = {}
	self.场景人物 ={}
	self.地图.移动xy.x,self.地图.移动xy.y = tp.角色坐标.x,tp.角色坐标.y
	table.insert(self.场景人物, self.人物)
	tp.窗口.时辰:刷新()
end

function 场景类_地图:显示(dt,x,y)
	self.地图:显示(tp.角色坐标,self.屏幕坐标,x,y,dt)
	全局时辰刷新()
	if tp.战斗中 then
		战斗类:更新(dt,x,y)
		战斗类:显示(dt,x,y)
	end
end

function 刷新道具逻辑(物品,指定ID,及时刷新) -- 及时刷新物品逻辑
	if tp.消息栏焦点 then
		return
	end
	-- 及时刷新有关道具的数据
	if 物品 ~= nil or 及时刷新 ~= nil then
		tp.道具列表[指定ID] = 物品
	end
	if tp.窗口.道具行囊.可视 then
		tp.窗口.道具行囊.物品[指定ID]:置物品(tp.道具列表[指定ID])
	end
	if tp.窗口.新道具行囊.可视 then
		tp.窗口.新道具行囊.物品[指定ID]:置物品(tp.道具列表[指定ID])
	end
	if tp.窗口.宠物炼妖栏.可视 then
		tp.窗口.宠物炼妖栏.物品[指定ID]:置物品(tp.道具列表[指定ID])
	end
	if tp.窗口.打造.可视 then
		tp.窗口.打造.物品[指定ID]:置物品(tp.道具列表[指定ID])
	end
	if tp.窗口.装备开运.可视 then
		tp.窗口.装备开运.物品[指定ID]:置物品(tp.道具列表[指定ID])
	end
	if tp.窗口.符石合成.可视 then
		tp.窗口.符石合成.物品[指定ID]:置物品(tp.道具列表[指定ID])
	end
	if tp.窗口.合成.可视 and 指定ID <= 20 then
		tp.窗口.合成.物品[指定ID]:置物品(tp.道具列表[指定ID])
	end
	if tp.窗口.出售.可视 then
		tp.窗口.出售.物品[指定ID]:置物品(tp.道具列表[指定ID])
	end
	if tp.窗口.仓库类.可视 then
		tp.窗口.仓库类.物品[指定ID]:置物品(tp.道具列表[指定ID])
	end
end

return 场景类_地图