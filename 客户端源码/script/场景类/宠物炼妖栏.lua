--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:11:31
--========================================,==============================--
local 场景类_宠物炼妖栏 = class()
local bw = require("gge包围盒")(0,0,120,37)
local box = 引擎.画矩形
local remove = table.remove
local insert = table.insert
local random = 引擎.取随机整数
local min = math.min
local cfs = 删除重复
local tss = 引擎.取天生
local qmxs = 引擎.取战斗模型
local mouseb = 引擎.鼠标弹起
local tx = 引擎.取头像
local zts,tp,zts1
local insert = table.insert
local qmx = 引擎.取模型

function 场景类_宠物炼妖栏:初始化(根)
	self.ID = 16
	self.x = 200
	self.y = 119
	self.xx = 0
	self.yy = 0
	self.注释 = "宠物炼妖栏"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	tp = 根
	self.加入 = 0
	self.开始 = 1
	self.结束 = 20
	self.窗口时间 = 0
	self.右键关闭=1
	zts = tp.字体表.普通字体
	zts1 = tp.字体表.描边字体
end

function 场景类_宠物炼妖栏:打开(道具)
	if self.可视 then
		self.可视 = false
		self.主动 = nil
		self.副动 = nil
		self.主召唤兽 = nil
		self.副召唤兽 = nil
		self.主点击 = nil
		self.副点击 = nil
		self.资源组 = nil
		self.物品 = nil
		self.头像组 = nil
		self.炼妖物品 = nil
		return
	else
		insert(tp.窗口_,self)
		self:加载数据()
		self.开始=1
		self.结束=20
		for n=self.开始,self.结束 do
			self.物品[n]:置物品(道具[n])
		end
	    tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end

function 场景类_宠物炼妖栏:加载数据()
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	local 物品 = tp._物品格子
	self.资源组 = {
		[0] = 自适应.创建(1,1,437,18,1,3,nil,18),
		[1] = 自适应.创建(0,1,441,405,3,9),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[3] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"合成"),
		[4] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"炼妖"),
		[5] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"炼化"),
		[6] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"吞噬"),
		[7] = 按钮.创建(自适应.创建(20,4,18,19,4,3),0,0,4,true,true),
		[8] = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true),
		[9] = 按钮.创建(自适应.创建(22,4,27,20,4,3),0,0,4,true,true),
		[10] = 按钮.创建(自适应.创建(23,4,27,20,4,3),0,0,4,true,true),
		[11] = 自适应.创建(2,1,130,117,3,9),
		[12] = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x62F1C735)
	}
	self.物品 = {}
	for i=1,20 do
		self.物品[i] = 物品.创建(0,0,i,"炼妖物品")
	end
	for n=2,10 do
		self.资源组[n]:绑定窗口_(16)
	end
	self.头像组 = {}
	self.炼妖物品 = 物品.创建(0,0,0,"炼妖_物品")
end

function 场景类_宠物炼妖栏:刷新道具(道具)
    self.开始=1
    self.结束=20
    for n=self.开始,self.结束 do
	    self.物品[n]:置物品(nil)
	    self.物品[n]:置物品(道具[n])
    end
end

function 场景类_宠物炼妖栏:清除()
 	tp.窗口.召唤兽属性栏:刷新()
	self.炼妖物品:置物品(nil)
	self.主召唤兽 = nil
	self.副召唤兽 = nil
end

local function 打书概率(v)
	if v <= 3 then
		return true
	else
	    local g = random(1,240)
	   	if v > 3 and v <= 8 then
	   		if g <= 20 then
	   			return true
	   		end
	   	elseif v > 8 and v <= 12 then
	   		if g <= 10 then
	   			return true
	   		end
	   	elseif v > 12 and v <= 24 then
	   		if g <= 5 then
	   			return true
	   		end
	   	end
	end
	return false
end

local function 合妖(a,b)
	local gl = random(1,100)
	if gl <= 5 then
		return true
	else
		local gls = {}
		gl = random(1,10)
		if gl <= 5 then
			gls[1] = a.模型
		elseif gl > 5 then
			gls[1] = b.模型
		end
		gl = random(1,10)
		if gl <= 5 then
			gls[2] = a.五行
		elseif gl > 5 then
			gls[2] = b.五行
		end
		gls[3] = min(random((a.攻击资质+b.攻击资质)*0.4,(a.攻击资质+b.攻击资质)*0.54),1800)
		gls[4] = min(random((a.体力资质+b.体力资质)*0.4,(a.体力资质+b.体力资质)*0.54),6000)
		gls[5] = min(random((a.法力资质+b.法力资质)*0.4,(a.法力资质+b.法力资质)*0.54),3500)
		gls[6] = min(random((a.防御资质+b.防御资质)*0.4,(a.防御资质+b.防御资质)*0.54),1600)
		gls[7] = min(random((a.速度资质+b.速度资质)*0.4,(a.速度资质+b.速度资质)*0.54),1700)
		gls[8] = min(random((a.躲闪资质+b.躲闪资质)*0.4,(a.躲闪资质+b.躲闪资质)*0.54),1700)
		gls[9] = min(random(((a.成长*100)+(b.成长*100))*0.36,((a.成长*100)+(b.成长*100))*0.5)/100,1.3)
		gls[12] = nil
		gls[13] = nil
		local ssa = "野怪"
		if a.种类 == "野怪" and b.种类 == "野怪" then
			ssa = "野怪"
		elseif a.种类 == "宝宝" and b.种类 == "宝宝" then
			ssa = "宝宝"
		elseif a.种类 == "变异" and b.种类 == "变异" then
			ssa = "变异"
		elseif (a.种类 == "变异" and b.种类 == "宝宝") or (a.种类 == "宝宝" and b.种类 == "变异") then
			ssa = "变异"
		elseif (a.种类 == "野怪" and b.种类 ~= "野怪") or (a.种类 ~= "野怪" and b.种类 == "野怪") then
			ssa = "野怪"
		end
		gls[11] = ssa
		if gls[11] == "变异" then
			if a.染色方案 ~= nil then
				gls[1] = a.模型
				gls[12] = a.染色方案
				gls[13] = a.染色组
			elseif b.染色方案 ~= nil then
				gls[1] = b.模型
				gls[12] = b.染色方案
				gls[13] = b.染色组
			end
		end
		local anum = #a.技能
		local bnum = #b.技能
		local cnum = 0
		local v = random(1,10)
		if v < 6 then
			cnum = anum
		else
		    cnum = bnum
		end
		local aski = tss(gls[1])
		local bski = {}
		for n=1,#aski do
			insert(bski,aski[n])
		end
		for i=1,#a.技能 do
			insert(bski,a.技能[i].名称)
		end
		for i=1,#b.技能 do
			insert(bski,b.技能[i].名称)
		end
		for n=1,#bski do
			if random(1,100) <= 65 then
				remove(bski,n)
			end
		end
		gls[10] = cfs(bski)
		return gls
	end
end

function 场景类_宠物炼妖栏:主置形象()
	if tp.队伍[1].宝宝列表[self.主召唤兽]  ~= nil and self.主召唤兽 ~= 0 then
		local n = qmxs(tp.队伍[1].宝宝列表[self.主召唤兽].模型)
		self.主动 = tp.资源:载入(n[10],"网易WDF动画",n[6])
		if tp.队伍[1].宝宝列表[self.主召唤兽].饰品 ~= nil then
			n = qmxs(tp.队伍[1].宝宝列表[self.主召唤兽].模型.."_饰品")
			self.资源组[24] = tp.资源:载入(n[10],"网易WDF动画",n[6])
		end
		if tp.队伍[1].宝宝列表[self.主召唤兽].染色方案 ~= nil then
			self.主动:置染色(tp.队伍[1].宝宝列表[self.主召唤兽].染色方案,tp.队伍[1].宝宝列表[self.主召唤兽].染色组[1],tp.队伍[1].宝宝列表[self.主召唤兽].染色组[2],tp.队伍[1].宝宝列表[self.主召唤兽].染色组[3],tp.队伍[1].宝宝列表[self.主召唤兽].染色组[4])
			self.主动:置方向(0)
		end
	end
end

function 场景类_宠物炼妖栏:副置形象()
	if tp.队伍[1].宝宝列表[self.副召唤兽]  ~= nil and self.副召唤兽 ~= 0 then
		local n = qmxs(tp.队伍[1].宝宝列表[self.副召唤兽].模型)
		self.副动 = tp.资源:载入(n[10],"网易WDF动画",n[6])
		if tp.队伍[1].宝宝列表[self.副召唤兽].饰品 ~= nil then
			n = qmxs(tp.队伍[1].宝宝列表[self.副召唤兽].模型.."_饰品")
			self.资源组[25] = tp.资源:载入(n[10],"网易WDF动画",n[6])
		end
		if tp.队伍[1].宝宝列表[self.副召唤兽].染色方案 ~= nil then
			self.副动:置染色(tp.队伍[1].宝宝列表[self.副召唤兽].染色方案,tp.队伍[1].宝宝列表[self.副召唤兽].染色组[1],tp.队伍[1].宝宝列表[self.副召唤兽].染色组[2],tp.队伍[1].宝宝列表[self.副召唤兽].染色组[3],tp.队伍[1].宝宝列表[self.副召唤兽].染色组[4])
			self.副动:置方向(0)
		end
	end
end

function 场景类_宠物炼妖栏:显示(dt,x,y)
	local bbs = tp.队伍[1].宝宝列表
	self.焦点 = false
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y)
	self.资源组[4]:更新(x,y)
	self.资源组[5]:更新(x,y)
	self.资源组[6]:更新(x,y)
	self.资源组[7]:更新(x,y)
	self.资源组[8]:更新(x,y)
	self.资源组[9]:更新(x,y)
	self.资源组[10]:更新(x,y)
	self.资源组[3]:更新(x,y,self.主召唤兽 ~= nil and self.副召唤兽 ~= nil)
	self.资源组[4]:更新(x,y,((self.主召唤兽 ~= nil and self.副召唤兽 == nil) or (self.副召唤兽 ~= nil and self.主召唤兽 == nil)))
	self.资源组[5]:更新(x,y,((self.主召唤兽 ~= nil and self.副召唤兽 == nil) or (self.副召唤兽 ~= nil and self.主召唤兽 == nil)))
	self.资源组[6]:更新(x,y,self.主召唤兽 ~= nil and self.副召唤兽 ~= nil)
	self.资源组[7]:更新(x,y,self.加入 > 0)
	self.资源组[8]:更新(x,y,self.加入 < #tp.队伍[1].宝宝列表 - 5)
	self.资源组[9]:更新(x,y,self.开始 ~= 1)
	self.资源组[10]:更新(x,y,self.结束 ~= 160)
	if self.主动 ~= nil then
		self.主动:更新(dt)
	end
	if self.副动 ~= nil then
		self.副动:更新(dt)
	end
    if self.资源组[2]:事件判断() then
    	self:打开()
    	return
	elseif self.资源组[3]:事件判断() then
		请求服务(5009,{序列=self.主召唤兽,序列1=self.副召唤兽})
	elseif self.资源组[4]:事件判断() then
		if self.炼妖物品.物品~=nil and self.主召唤兽 ~= nil then
			请求服务(5008,{序列=self.炼妖物品.物品编号,序列1=self.主召唤兽})
		end
   	elseif self.资源组[5]:事件判断() then
		if self.炼妖物品.物品~=nil and self.主召唤兽 ~= nil then
		local 事件 = function()
			请求服务(5010,{序列=self.炼妖物品.物品编号,序列1=self.主召唤兽})
		end
		tp.窗口.文本栏:载入("如果无论炼化是否成功失败，你所选择的召唤兽都会消失。请确认是否进行炼化操作？",nil,true,事件)
		end
	elseif self.资源组[7]:事件判断() then
		self.加入 = self.加入 - 1
	elseif self.资源组[8]:事件判断() then
		self.加入 = self.加入 + 1
	elseif self.资源组[9]:事件判断() then

	elseif self.资源组[10]:事件判断() then
    elseif self.资源组[1]:是否选中(x,y) and 引擎.鼠标弹起(右键) then
    	self:打开()
    	return
	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[0]:显示(self.x+2,self.y+2)
	tp.窗口标题背景_[3]:显示(self.x+self.资源组[1].宽度/2-68,self.y+2)
	zts1:显示(self.x+self.资源组[1].宽度/2-38,self.y+2,"炼  妖")
	self.资源组[11]:置宽高(130,117)
	for i=1,2 do
		self.资源组[11]:显示(self.x+i*261-236,self.y+36)
	end
	self.资源组[11]:置宽高(150,228)
	self.资源组[11]:显示(self.x+13,self.y+164)
	self.资源组[2]:显示(self.x + 420,self.y + 2)
	self.资源组[3]:显示(self.x + 165,self.y + 103)
	self.资源组[4]:显示(self.x + 224,self.y + 103)
	self.资源组[5]:显示(self.x + 165,self.y + 129)
	self.资源组[6]:显示(self.x + 224,self.y + 129)
	self.资源组[7]:显示(self.x + 148,self.y + 166)
	self.资源组[8]:显示(self.x + 148,self.y + 374)
	self.资源组[9]:显示(self.x + 173,self.y + 377)
	self.资源组[10]:显示(self.x + 204,self.y + 377)
	tp.画线:置区域(0,0,15,189)
	tp.画线:显示(self.x+152,self.y+185)
	tp.物品界面背景_:显示(self.x+174,self.y+164)
	tp.横排花纹背景_:置区域(0,0,192,13)
	tp.横排花纹背景_:显示(self.x+237,self.y+376)
	tp.物品格子背景_:显示(self.x+196,self.y+39)
	local p = self.开始 - 1
	for h=1,4 do
		for l=1,5 do
			p = p + 1
			self.物品[p]:置坐标(l * 51 + self.x+124,h * 51+self.y+114)
			self.物品[p]:显示(dt,x,y,self.鼠标,{3})
			 if self.物品[p].焦点 then
					if self.物品[p].物品 ~= nil then
					tp.提示:道具行囊(x,y,self.物品[p].物品)
					if mouseb(0) and self.物品[p].物品.总类 == 3 then
				    	if self.炼妖物品.物品 == nil then
				    		self.炼妖物品:置物品(self.物品[p].物品)
				    		self.炼妖物品.物品编号=p
				    		刷新道具逻辑(nil,p,true)
				    	elseif self.炼妖物品.物品 ~= nil then
				    		local jy1 = self.炼妖物品.物品
				    		self.炼妖物品:置物品(self.物品[p].物品)
				    		self.炼妖物品.物品编号=p
				    		self.物品[p].物品 = jy1
				    	end
				   	end
				end
			end
		end
	end
	if self.主动 ~= nil and self.主召唤兽 ~= nil then
		tp.影子:显示(self.x + 85,self.y + 130)
		self.主动:显示(self.x + 85,self.y + 130)
		if self.资源组[24] ~= nil then
			self.资源组[24]:更新(dt)
			self.资源组[24]:显示(self.x + 85,self.y + 130)
		end
	end
	if self.副动 ~= nil and self.副召唤兽 ~= nil then
		tp.影子:显示(self.x + 345,self.y + 130)
		self.副动:显示(self.x + 345,self.y + 130)
		if self.资源组[25] ~= nil then
			self.资源组[25]:更新(dt)
			self.资源组[25]:显示(self.x + 345,self.y + 130)
		end
	end
	self.炼妖物品:置坐标(self.x+199,self.y+40)
	self.炼妖物品:显示(dt,x,y,self.鼠标)
	if self.炼妖物品.物品 ~= nil and self.炼妖物品.焦点 then
		tp.提示:道具行囊(x,y,self.炼妖物品.物品)
	end
	for i=1,5 do
		if bbs[i+self.加入] ~= nil  then
			local jx = self.x+19
			local jy = self.y+(i*43)+129
			bw:置坐标(jx,jy+1)
			if self.头像组[i+self.加入] == nil or self.头像组[i+self.加入][1] ~= bbs[i+self.加入].模型 then
				self.头像组[i+self.加入] = {bbs[i+self.加入].模型}
				local n = tx(self.头像组[i+self.加入][1])
				self.头像组[i+self.加入][2] = tp.资源:载入(n[7],"网易WDF动画",n[1])
			end
			if bw:检查点(x,y) then
				if mouseb(0) and self.鼠标 and not tp.消息栏焦点 then
					if self.主召唤兽 ~= i + self.加入 and self.副召唤兽 ~= i + self.加入 then
						if self.主召唤兽 == nil then
							self.主召唤兽 = i + self.加入
							self:主置形象()
						elseif self.副召唤兽 == nil then
							self.副召唤兽 = i + self.加入
							self:副置形象()
						elseif self.主召唤兽 ~= nil and self.副召唤兽 ~= nil then
							self.主召唤兽 = i + self.加入
							self:主置形象()
						end
					else
						if self.主召唤兽 == i + self.加入 then
							self.主召唤兽 = nil
							self:主置形象()
						elseif self.副召唤兽 == i + self.加入 then
							self.副召唤兽 = nil
							self:副置形象()
						end
					end
				end
				self.焦点 = true
			end
			if self.主召唤兽 == i + self.加入 or self.副召唤兽 == i + self.加入 then
				box(jx-2,jy-3,jx+128,jy+40,-2097481216)
			end
			tp.宠物头像背景_:显示(jx+1,jy)
			self.头像组[i+self.加入][2]:显示(jx+4,jy+4)
			if self.主召唤兽 == i + self.加入 or self.副召唤兽 == i + self.加入 then
				self.资源组[12]:显示(jx+92,jy+3)
			end
			if tp.队伍[1].宝宝列表[i+self.加入].参战信息 ~= nil then
				zts:置颜色(-65536)
			else
				zts:置颜色(-16777216)
			end
			zts:显示(jx+41,jy+4,bbs[i+self.加入].名称)
			zts:显示(jx+41,jy+21,bbs[i+self.加入].等级.."级")
		end
	end
end

function 场景类_宠物炼妖栏:检查点(x,y)
	if self.资源组~=nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_宠物炼妖栏:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if  self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_宠物炼妖栏:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_宠物炼妖栏