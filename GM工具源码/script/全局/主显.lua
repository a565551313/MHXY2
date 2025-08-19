--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2020-02-20 12:16:51
--======================================================================--
local collectgarbage = collectgarbage
local xys = 生成XY
local jr = require("script/全局/假人")
local wjtp = require("script/全局/玩家")
local cs = require("script/场景类/传送点")
local zys = require("script/场景类/自由事件")
local jl = require("gge精灵类")
local tp = nil
local floor = math.floor
local lsph = nil
local insert = table.insert
local ygs = 引擎.取野怪
local mls = 引擎.取明雷
local zysj,zt,lsph
local BGM = 取Bgm
local cjs = 引擎.取场景等级
local jtus = 引擎.截图到纹理
local hmzb = 取画面坐标
local wj = 引擎.文件是否存在
local 场景类_地图 = class()

function 场景类_地图:初始化(根)
	tp = 根
	zt = tp.字体表.描边字体
	self.战斗 ={}
	self.地图 = require("script/资源类/地图类")(根,self)
	self.选中窗口 = 0
	self.移动窗口 = false
	self.抓取物品 = nil
	self.抓取物品ID = nil
	self.抓取物品注释 = nil
	self.战斗提示 = ""
	self.战斗提示时间 = 0
	self.过度纹理 = require("gge纹理类")():渲染目标(全局游戏宽度+50,全局游戏高度+50)-- 创建一个截图的背景，实现官网的过度功能
	self.过度进度 = 155
	self.过度时间 = 30
	self.开启场景加载 = false
	self.屏幕坐标 = xys()
	self.滑屏 = xys()
	self.自由事件 = nil
	self.传送区 = nil
	self.传送时间 = 0
	self.当前刷新 = nil
	self.场景最低等级 = nil
	self.场景最高等级  = nil
end

function 场景类_地图:转移(地图,X,Y)
	-- tp.标题 = nil
	-- tp.读取 = nil
	-- tp.创建 = nil
	tp.进程 = 4
	zysj = 引擎.自由事件
	tp.角色坐标.x,tp.角色坐标.y = floor(X),floor(Y)
	self.滑屏.x,self.滑屏.y = floor(X),floor(Y)
	tp.当前地图 = 地图
	if tp.窗口.小地图.可视 then
	    tp.窗口.小地图:打开(9999999999999999999999)
	end
	if 地图>=1600 and 地图<=1620 then
		self.地图:加载(wdf配置.."/scene/1514.map")
	elseif tp.当前地图==5001 then
		self.地图:加载(wdf配置.."/scene/1042.map")
	else
		self.地图:加载(wdf配置.."/scene/"..tp.当前地图..".map")
	end
	--self.地图:加载(wdf配置.."/scene/"..地图..".map")
	self.人物 = require("script/全局/人物")(tp)
	tp.音乐 = tp.资源:载入(wdf配置.."/Audio/"..tp.当前地图..".mp3","音乐",nil,tp.音量)
    tp.音乐:播放(true)
    tp.音乐:置音量(游戏音量)
	self.假人 = {}
	self.玩家 = {}
	self.传送 = {}
	self.场景人物 = {}
	insert(self.场景人物, self.人物)
	-- 自由事件
	local zy = zysj(tp.当前地图)
	if zy ~= nil then
		self.自由事件 = {}
		for i=1,#zy do
			if ((zy[i][3] ~= nil and tp.剧情进度[zy[i][3]] == zy[i][4]) or zy[i][3] == nil) and ((zy[i][5] ~= nil and tp.剧情开关[zy[i][5]] == zy[i][6]) or zy[i][5] == nil) then
				local ab = zys(zy[i])
				insert(self.自由事件,ab)
			end
		end
	end
	-- tp.假人库:刷新远古()
	-- tp.假人库:刷新远古(tp.当前地图)
	tp.窗口.时辰:刷新()
	-- jtus(self.过度纹理)
	self.过度精灵 = jl(self.过度纹理)
	self.过度进度 = 255
	self.过度时间 = 3
	tp.隐藏UI = true
	tp.恢复UI = true
	self.人物:停止移动()
	collectgarbage("collect")
end

function 场景类_地图:添加玩家(sj)
   	self.玩家[sj.id]=wjtp(sj)
	insert(self.场景人物, self.玩家[sj.id])
end

function 场景类_地图:删除玩家(角色ID)
	table.remove(self.玩家,角色ID)
	for i=1,#self.场景人物 do
		if self.场景人物[i]~=nil and self.场景人物[i].类型=="玩家" and self.场景人物[i].玩家ID~=nil and self.场景人物[i].玩家ID == 角色ID then
			table.remove(self.场景人物, i)
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
	if self.玩家[行走玩家ID]~=nil and self.玩家[行走玩家ID].玩家ID~=nil and self.玩家[行走玩家ID].玩家ID == 行走玩家ID then
		local a = xys(floor(self.玩家[行走玩家ID].坐标.x / 20),floor(self.玩家[行走玩家ID].坐标.y / 20))
		self.玩家[行走玩家ID].目标格子 = tp.场景.地图.寻路:寻路(a,路径)
		self.玩家[行走玩家ID].行走开关 = true
	end
end

function 场景类_地图:设置传送(内容)
	local qcs = 场景取传送表
	local c = qcs(tp.当前地图)--内容
	if #c > 0 then
		for n=1,#c do
		 	self.传送[n] = cs(c[n].x,c[n].y,c[n].切换,n)
		 	q = nil
		end
	end
end

function 场景类_地图:设置假人(内容)
    self.假人 = {}
    self.玩家 = {}
	self.传送 = {}
	collectgarbage("collect")
	local qjr = 场景取假人表
	local lsb = tp.临时Npc
	local v = qjr(tp.当前地图,nil,1)--内容
	local b = mls(tp.当前地图)
	if #v > 0 then
		for n=1,#v do
			v[n].编号 = n
		    insert(self.假人,jr(v[n]))
		end
	end
    b=nil
	if b ~= nil then
		local 假人表 = tp.假人库:生成临时假人(tp.当前地图,b,nil,20,"明雷怪")
		for n=1,#假人表 do
		    self.假人[n] = jr(假人表[n])
		end
	end
	self.场景人物 = {}
	insert(self.场景人物, self.人物)
	for i=1,#self.假人 do
		insert(self.场景人物, self.假人[i])
	end
	for i=1,#lsb do
		if lsb[i].地图 == 地图 then
			local npc = jr(lsb[i])
			insert(self.假人,npc)
			insert(self.场景人物, npc)
		end
	end
end

function 场景类_地图:删除单位(编号)
	local 删除序列=0
	for n, v in pairs(tp.场景.场景人物) do
		if tp.场景.场景人物[n].真实编号==编号 then
			删除序列=编号
		end
	end
	if 删除序列~=0 then
		table.remove(tp.场景.场景人物,删除序列)
	end
	local 删除序列=0
	for n, v in pairs(self.假人) do
		if self.假人[n].真实编号==编号 then
			删除序列=编号
		end
	end
	if 删除序列~=0 then
		table.remove(self.假人,删除序列)
	end
end

function 场景类_地图:传送至(地图,坐标x,坐标y,fc)
	if fc ~= nil then
		collectgarbage("collect")
		-- jtus(self.过度纹理)
		self.过度精灵 = jl(self.过度纹理)
		self.过度进度 = 255
		self.过度时间 = 3
		tp.角色坐标.x,tp.角色坐标.y = floor(坐标x*20),floor(坐标y*20)
		self.地图.移动xy.x,self.地图.移动xy.y = tp.角色坐标.x,tp.角色坐标.y
		self.滑屏.x,self.滑屏.y = tp.角色坐标.x,tp.角色坐标.y
		tp.当前地图 = 地图
		if tp.窗口.小地图.可视 then
		    tp.窗口.小地图:打开(9999999999999999999999)
		end
		self.屏幕坐标 = hmzb(self.滑屏.x,self.滑屏.y,self.地图.宽度,self.地图.高度)
		if tp.当前地图>=1600 and tp.当前地图<=1620 then
		   self.地图:加载(wdf配置.."/scene/1514.map")
		elseif tp.当前地图==5001 then
		   self.地图:加载(wdf配置.."/scene/1042.map")
        else
		   self.地图:加载(wdf配置.."/scene/"..tp.当前地图..".map")
		  end
		self:传送指定()
		local 地图等级={}
		地图等级[1],地图等级[2]=cjs(tp.当前地图)
		if 地图等级[1]~=nil then
			tp.场景.场景最低等级=地图等级[1]
			tp.场景.场景最高等级=地图等级[2]
			tp.窗口.消息框:添加文本("#Y/本场景等级为"..地图等级[1].."-"..地图等级[2].."级","xt")
		else
			tp.场景.场景最低等级=nil
			tp.场景.场景最高等级=nil
		end
		return
	end
	self.传送区 = {地图,坐标x,坐标y,fc}
end

function 场景类_地图:播放音乐(位置)
	local yu = BGM(tp.当前地图)
	tp.音乐 = tp.资源:载入(wdf配置.."/Audio/"..yu..".mp3","音乐",nil)
	tp.音乐:置音量(游戏音量)
	if 位置~=nil then tp.音乐:置位置(位置) end
		--tp.音乐:置音量(游戏音量)
	if 游戏音量>0 then
		tp.音乐:播放(true)
	end
end

function 场景类_地图:传送指定()
	local yu = BGM(tp.当前地图)
	if tp.音乐.文件 ~= wdf配置.."/Audio/"..yu..".mp3" then
		if wj(wdf配置.."/Audio/"..yu..".mp3") then
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
	self.场景人物 = {}
	self.假人 = {}
	self.传送 = {}
	self.玩家 = {}
	self.地图.移动xy.x,self.地图.移动xy.y = tp.角色坐标.x,tp.角色坐标.y
	insert(self.场景人物, self.人物)
	tp.窗口.时辰:刷新()
end

function 场景类_地图:显示(dt,x,y)
	self.地图:显示(tp.角色坐标,self.屏幕坐标,x,y,dt)
	全局时辰刷新()
	if tp.战斗中 then
		战斗类:更新(dt,x,y)
		战斗类:显示(dt,x,y)
	else
		if self.战斗.跳转事件 ~= nil then
			if self.战斗.跳转事件 == "贼王" then
				引擎.强盗战斗(true,"贼王",tp.当前地图,0)
			end
			self.战斗.跳转事件 = nil
		end
		if self.自由事件 ~= nil then
			for i=1,#self.自由事件 do
				self.自由事件[i]:显示()
			end
		end
	end
	if tp.摄妖香剩余功效时辰~=nil and tp.摄妖香剩余功效时辰>0 and not tp.隐藏UI then
		tp.窗口.人物框:加入小图标信息(3,"摄妖香剩余:",tp.摄妖香剩余功效时辰)
	else
		tp.窗口.人物框:删除小图标信息(3)
	end
	if self.传送~=nil and #self.传送~=nil then
		for n=1,#self.传送 do
			if self.传送[n] ~= nil then
				self.传送[n]:更新(dt,xx,yy,偏移)
			end
		end
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
	if tp.窗口.道具仓库.可视 then
		tp.窗口.道具仓库.物品[指定ID]:置物品(tp.道具列表[指定ID])
	end
end

return 场景类_地图