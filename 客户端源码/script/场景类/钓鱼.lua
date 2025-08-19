--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:19:27
--======================================================================--
local 场景类_钓鱼 = class()

local floor = math.floor
local tp
local insert = table.insert
local zts,zts1
local tx = 引擎.取头像
local random = 引擎.取随机整数
local xys = 生成XY
local remove = table.remove
local sort = table.sort
local time = os.time
local string = tostring
local mousea = 引擎.鼠标按下
local mouseb = 引擎.鼠标弹起
local number = tonumber
local string = tostring
local sort = table.sort

function 场景类_钓鱼:初始化(根)
	self.ID = 31
	self.x = 120
	self.y = 150
	self.xx = 0
	self.yy = 0
	self.xxx = 85
	self.yyy = 208
	self.xxxx = 0
	self.yyyy = 0
	self.xxxxx = 0
	self.xxxxxx = 0
	self.注释 = "钓鱼"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可视1 = false
	self.可移动 = true
	local 资源 = 根.资源
	local 按钮 = 根._按钮
	local 自适应= 根._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,638,453,3,9),
		[2] = 自适应.创建(1,1,634,18,1,3,nil,18),
		[3] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		-- 背景素材
		[5] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x24E41DF4),
		[6] = {},
		[8] = {},
		[9] = 自适应.创建(6,1,205,123,3,9),
		[10] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xEB31976D),0,0,3,true,true),
		[11] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x9B3A987D),0,0,3,true,true),
		[12] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[13] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x82FA515B),
		[14] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x484A618B),
		[15] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xA0C042CD),
		[16] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"抛竿"),
		[17] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xEB31976D),0,0,3,true,true),
	}
	self.资源组[9]:置颜色(ARGB(140,255,255,255))
	self.资源组[16]:置偏移(14,-1)
	self.窗口时间 = 0
	self.下次加入鱼时间 = 0
	self.下次加入鱼数量 = 0
	self.移动窗口 = false
	self.选中窗口 = false
	self.选中滑块 = false
	self.移动滑块 = false
	self.力度计时 = true
	self.提示文字 = ""
	self.提示时间 = 0
	tp = 根
	zts = tp.字体表.普通字体
	zts1 = tp.字体表.描边字体
end

function 场景类_钓鱼:取鱼竿资源(id)
	local yg = {{0x30095171,0x6494CB03,0xB8136390,0x09AEE796,0x176A564C}}
	return yg[id]
end
-- 1ED79819 大闸蟹做上钩  27A00C60 大闸蟹右上钩   3BECBD22右行走   3DC630B5
-- 233316F0 对下上钩
-- 242D0140 沙丁鱼上钩
-- 2A65A2D5 小黄鱼右上钩  3CB13AD5大黄鱼左行走
-- 2FD2704C 金枪鱼右上钩  3C703ED0左上钩
function 场景类_钓鱼:取鱼资源(id)
	local y = {
		-- 左至右 右至左  124E001B --- 钓鱼特效成为 13614BD5哇哇吐   1A64A413右       345A9710 娃娃鱼左
		{{0xC58184F5,0x2BA2E98C},{0x692B53CB,0x428E63B2},"草鱼",1.2},
		{{0x00FFE220,0x03DCBE41},{0xDF44710B,0x3E138B56},"甲鱼",0.8},
		{{0x083E7D4E,0x03DCBE41},{0x2F779F1F,0x3E138B56},"海马",0.8},
		{{0x3DC630B5,0x1ED79819},{0x3BECBD22,0x27A00C60},"大闸蟹",0.8},
		{{0x345A9710,0x13614BD5},{0x13614BD5,0x13614BD5},"娃娃鱼",0.8}
	}
	return y[id]
end

local function 排序(a,b) return a[4].y < b[4].y end

function 场景类_钓鱼:打开(渔场,人员)
	if self.可视 then
	 	self.资源组[4] = nil
		self.资源组[6] = {}
		self.资源组[7] = nil
		self.资源组[8] = {}
		self.渔场 = nil
		self.可视 = false
		self.可视1 = false
		self.xxx = 85
		self.yyy = 208
		self.xxxx = 0
		self.yyyy = 0
		self.xxxxx = 0
		self.xxxxxx = 0
		self.力度计时 = true
	else
		if 渔场 == 1 then
			self.资源组[4] = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x25029DA4)
			self.资源组[7] = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x3E36C7F5)
			self.渔场 = "傲来渔场"
		else
			self.资源组[4] = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x0C4965C0)
			self.资源组[7] = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x7CF21DD2)
			self.渔场 = "长寿渔场"
		end
		self.人员 = 人员
		for i=1,#tp.队伍  do
			local s = tx(tp.队伍[i].模型)
			self.资源组[6][i] = {}
			self.资源组[6][i][1] = tp.资源:载入(s[7],"网易WDF动画",s[2])
			self.资源组[6][i][2] = 0
			self.资源组[6][i][3] = {}
			local yg = self:取鱼竿资源(i)
			for n=1,5 do
				self.资源组[6][i][3][n] = {}
				self.资源组[6][i][3][n][1] = tp.资源:载入('登陆资源.wdf',"网易WDF动画",yg[n])
			end
			self.资源组[6][i][4] = 1
		end
		self.可视1 = true
		self.上钩 = false
		self.下次加入鱼时间 = 5
		self.下次加入鱼数量 = random(1,3)
		insert(tp.窗口_,self)
		tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end

function 场景类_钓鱼:显示(dt,x,y)
	self.焦点 = false
	self.选中窗口 = false
	if self.资源组[9]:是否选中(x,y) then
		self.焦点 = true
		self.选中窗口 = true
	end
	self.资源组[3]:更新(x,y)
	if self.资源组[3]:事件判断() then
		self:打开()
		return
	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[2]:显示(self.x+2,self.y+2)
	self.资源组[4]:显示(self.x+11,self.y+24)
	tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	zts1:置字间距(3)
	zts1:显示(self.x+self.资源组[1].宽度/2-30,self.y+2,self.渔场)
	zts1:置字间距(0)
	self.资源组[3]:显示(self.x+617,self.y+2)
	for i=1,#tp.队伍 do
		local actor = self.资源组[6][i]
	    self.资源组[5]:显示(self.x+14+((i-1)*123),self.y+45)
	    self.资源组[6][i][1]:显示(self.x+20+((i-1)*123),self.y+51)
	    zts:置颜色(ARGB(255,0,0,0))
	    zts:显示(self.x+73+((i-1)*123),self.y+51,"渔获")
	    zts:显示(self.x+73+((i-1)*123),self.y+66,actor[2])
	    zts:显示(self.x+73+((i-1)*123)-53,self.y+103,tp.队伍[i].名称)
	    local dts = self.资源组[6][i][6] or 1
	    actor[3][5][1]:更新(dt)
	    actor[3][5][1]:显示(self.x+79+((i-1)*123),self.y+193-5)
	    actor[3][actor[4]][1]:更新(dt*dts)
	    actor[3][actor[4]][1]:显示(self.x+79+((i-1)*123),self.y+193)
	    if actor[4] == 2 or actor[4] == 4 then
	    	if actor[3][actor[4]][1].当前帧 == actor[3][actor[4]][1].结束帧 then
	    		actor[3][actor[4]][1].当前帧 = 0
	    		actor[3][actor[4]][1]:更新纹理()
	    		if actor[4] == 2 then
		    		actor[4] = actor[4] + 1
		    	else
		    	    actor[4] = 1
		    	end
	    	end
	    end
	end

	for i=1,#self.资源组[8] do
		if self.资源组[8][i] ~= nil then
			if self.资源组[8][i][7] == nil then
				if self.资源组[8][i][5] == 1 then
					self.资源组[8][i][4].x = self.资源组[8][i][4].x + self.资源组[8][i][6]
					if self.资源组[8][i][4].x > 627 then
						self.资源组[8][i] = nil
					end
				elseif self.资源组[8][i][5] == 2 then
					self.资源组[8][i][4].x = self.资源组[8][i][4].x - self.资源组[8][i][6]
					if self.资源组[8][i][4].x <= 10 then
						self.资源组[8][i] = nil
					end
				end
			end
			if self.资源组[8][i] ~= nil and self.资源组[6][1][4] == 3 and self.资源组[6][1][5][1] == nil and self.资源组[8][i][8] == nil then
				-- 事件开始
				local zxz,zdz = 0,60
				if self.资源组[8][i][5] == 1 then
					zxz,zdz = 0,100
				end
				if self.资源组[8][i][4].x >= zxz and self.资源组[8][i][4].x <= zdz then
					self.提示文字 = "鱼儿上钩了！看准时机吧！"
					self.提示时间 = 0
					self.资源组[8][i][7] = 1
					self.资源组[6][1][5] = {self.资源组[8][i]}
					self.资源组[8][i][4].y = 355
				end
				-- 事件结束
			end
		end
	end

	local sl = #self.资源组[8]
	local zsl = #self.资源组[8]
	for n=1,zsl do
		for i=1,sl do
			if self.资源组[8][i] == nil then
				remove(self.资源组[8],i)
				sl = sl - 1
				break
			end
		end
	end
	for i=1,sl do
		local bfid = 1
		if self.资源组[8][i][9] ~= nil then
			bfid = 2
			if self.资源组[8][i][bfid].当前帧 == self.资源组[8][i][bfid].结束帧 then
				--增加物品(self.资源组[8][i][3])
				--print(self.资源组[8][i][3])
				请求服务(1507,{物品=self.资源组[8][i][3]})
				self.提示文字 = "收获了一只"..self.资源组[8][i][3]
				self.提示时间 = 150
				self.资源组[8][i] = nil
			end
		end
		if self.资源组[8][i] ~= nil then
			self.资源组[8][i][bfid]:更新(dt)
			self.资源组[8][i][bfid]:显示(self.x + self.资源组[8][i][4].x,self.y + self.资源组[8][i][4].y)
		end
	end
	self.资源组[7]:显示(self.x+11,self.y+169)
	-- 加入鱼
	self.下次加入鱼时间 = self.下次加入鱼时间 - 0.05
	if self.下次加入鱼时间 <= 0 then
		local y数组 = random_array({295,310,325,340,355})
		for i=1,self.下次加入鱼数量 do
			local u = self:取鱼资源(random(1,5))
			local f = random(1,2)
			local z
			local x
			local zy = {}
			if f == 1 then
				z = u[1]
			else
				z = u[2]
			end
			zy[1] = tp.资源:载入('登陆资源.wdf',"网易WDF动画",z[1])
			zy[2] = tp.资源:载入('登陆资源.wdf',"网易WDF动画",z[2])
			zy[3] = u[3]
			if f == 1 then
				x =  zy[1].宽度+10
			else
				x =  617-zy[1].宽度
			end
			zy[4] = xys(x,y数组[1])
			zy[5] = f
			zy[6] = u[4]
			remove(y数组,1)
			insert(self.资源组[8],zy)
		end
		self.下次加入鱼时间 = random(13,20)
		self.下次加入鱼数量 = random(1,3)
	end
	self.资源组[17]:更新(x,y)
	if self.资源组[17]:事件判断() then
		if self.可视1 then
			self.可视1 = false
			self.xxxx = 0
			self.yyyy = 0
			self.xxxxx = 0
			self.xxxxxx = 0
			self.力度计时 = true
		else
			self.可视1 = true
			self.xxxx = 0
			self.yyyy = 0
			self.xxxxx = 0
			self.xxxxxx = 0
			self.力度计时 = true
		end
	end
	self.资源组[17]:显示(self.x + 15,self.y+ 402)
	if self.提示文字 ~= "" then
		zts:置颜色(-459738)
		zts:显示(self.x + ((617-zts:取宽度(self.提示文字)) / 2)+20,self.y+410,self.提示文字)
		if self.提示时间 > 0 then
			self.提示时间 = self.提示时间 - 1
			if self.提示时间 == 0 then
				self.提示文字 = ""
			end
		end
	end
	if self.可视1 then
		self.资源组[10]:更新(x,y)
		self.资源组[11]:更新(x,y)
		self.资源组[12]:更新(x,y)
		self.资源组[16]:更新(x,y)
		if self.资源组[12]:事件判断() then
			self.可视1 = false
			self.xxxx = 0
			self.yyyy = 0
			self.xxxxx = 0
			self.xxxxxx = 0
			self.力度计时 = true
			return
		elseif self.资源组[16]:事件判断() then
			if self.资源组[6][1][4] == 1 or self.资源组[6][1][4] == 3 then
				if self.资源组[6][1][5] == nil then -- 未抛竿时
					if 物品判断("鱼竿",1,true) then
						self.资源组[6][1][4] = 2
						self.资源组[16]:置文字("收杆")
						self.资源组[6][1][5] = {}
					else
						tp.常规提示:打开("#Y/温馨提示：你没有鱼竿，无法进行钓鱼")
					end
				else
					-- 几率判断
					if self.资源组[6][1][5][1] == nil then -- 没钓到鱼就拉杆
						self.资源组[6][1][5] = nil
						self.资源组[6][1][4] = 4
						self.资源组[6][1][6] = 1.5
						self.提示文字 = "很遗憾，鱼儿脱钩溜走了……"
						self.提示时间 = 150
						self.资源组[16]:置文字("抛竿")
					else
						local id = 0
						for i=1,sl do
							if self.资源组[8][i][7] ~= nil then
								id = i
								break
							end
						end
						local jl = true -- 钓鱼确定开关
						if jl then
							-- 钓到鱼的情况下
							self.资源组[8][id][9] = 1 -- 表示钓到该鱼
							self.资源组[6][1][5] = nil
							self.资源组[6][1][4] = 4
							self.资源组[6][1][6] = 1.2
						else
							self.资源组[8][id][6] = 7 -- 垂钓失败，鱼加速跑走
							self.资源组[8][id][8] = 1 -- 标记该鱼，表示不可捕获
							self.资源组[8][id][7] = nil
							self.资源组[6][1][5] = nil
							self.资源组[6][1][4] = 4
							self.资源组[6][1][6] = 1.5
							self.提示文字 = "很遗憾，鱼儿脱钩溜走了……"
							self.提示时间 = 150
							-- self.资源组[16]:置文字("抛竿")
						end
					end
					self.力度计时 = true
					self.xxxxx = 0
				end
			end
		end
		self.资源组[9]:显示(self.x + self.xxx,self.y + self.yyy)
		self.资源组[10]:显示(self.x + self.xxx + 6,self.y + self.yyy + 5)
		self.资源组[11]:显示(self.x + self.xxx + 45,self.y + self.yyy + 5)
		zts:置颜色(ARGB(255,255,255,255))
		zts:显示(self.x + self.xxx + 89,self. y + self.yyy + 8,"当前法宝：")
		self.资源组[12]:显示(self.x + self.xxx + 185,self.y + self.yyy + 5)
		self.资源组[13]:显示(self.x + self.xxx + 26 + self.xxxxx,self.y + self.yyy + 58)
		self.资源组[14]:显示(self.x + self.xxx + 24,self.y + self.yyy + 65)
		self.资源组[15]:显示(self.x + self.xxx + 26,self.y + self.yyy + 83)
		self.资源组[15]:显示(self.x + self.xxx + 164,self.y + self.yyy + 83)
		self.资源组[16]:显示(self.x + self.xxx + 62,self.y + self.yyy + 95)
		--滑块移动
		if self.资源组[6][1][5] ~= nil then
			if self.力度计时 then
				self.xxxxx = self.xxxxx + 2
				if self.xxxxx >= 136 then
					self.xxxxx = 136
					self.力度计时 = false
				end
			else
				self.xxxxx = self.xxxxx - 2
				if self.xxxxx <= 0 then
					self.xxxxx = 0
					self.力度计时 = true
				end
			end
		end
		--窗口移动
		if  self.选中窗口 and mousea(0) and not tp.按钮焦点 then
			self.xxxx = x - self.xxx
			self.yyyy = y - self.yyy
			self.移动窗口 = true
			tp.第二窗口移动中 = true
		elseif self.移动窗口 and (mouseb(0) or tp.隐藏UI or tp.消息栏焦点)  then
			self.移动窗口 = false
			tp.第二窗口移动中 = false
		end
		if self.移动窗口 and not tp.隐藏UI and not tp.消息栏焦点 then
			self.xxx = x - self.xxxx
			self.yyy = y - self.yyyy
		end
		if self.xxx <= 11 then
			self.xxx = 11
		end
		if self.yyy <= 24 then
			self.yyy = 24
		end
		if self.xxx >= 423 then
			self.xxx = 423
		end
		if self.yyy >= 320 then
			self.yyy = 320
		end
	end
end

function 场景类_钓鱼:检查点(x,y)
	return self.资源组[1]:是否选中(x,y)
end

function 场景类_钓鱼:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 and not self.资源组[9]:是否选中(x,y) then
		tp.移动窗口 = false
	end
	if self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_钓鱼:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_钓鱼