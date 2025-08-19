--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:11:31
--======================================================================--
local 场景类_染色 = class()
local qmx = 引擎.取模型
local tp,zts,zts1
local insert = table.insert
function 场景类_染色:初始化(根)
	self.ID = 29
	self.x = 435
	self.y = 178
	self.xx = 0
	self.yy = 0
	self.注释 = "染色"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口时间 = 0
	tp = 根
	zts = tp.字体表.普通字体
	zts1 = tp.字体表.描边字体
end

function 场景类_染色:打开() -- 服饰染色 召唤兽染色
	if self.可视 then
		self.彩果 = nil
		self.方向 = nil
		self.染色方案 = nil
		self.人物组 = nil
		self.染色组 = nil
		self.可视 = false
		self.资源组 = nil
		return
	else
		insert(tp.窗口_,self)
		self:加载数据()
		-- if tp.队伍[1].模型 == "巫蛮儿" or tp.队伍[1].模型 == "杀破狼" or tp.队伍[1].模型 == "羽灵神" or tp.队伍[1].模型 == "偃无师" or tp.队伍[1].模型 == "鬼潇潇"  or tp.队伍[1].模型 == "桃夭夭" then
		-- 	tp.常规提示:打开("#Y/该角色暂未开放染色")
		-- 	return
		-- end

		self.方向 = 4
		self.彩果 = 0
		self.人物组 = {}
		self.染色方案 = 0
		self:置模型()
		self.染色组   = {0,0,0}
		self.初始染色组 = self.染色组
		self:置染色()
		self:置方向()
	    tp.运行时间 = tp.运行时间 + 1
	  	self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end



function 场景类_染色:置模型()
	local 资源 = tp.资源
	local rw=tp.队伍[1]

	local q = qmx(rw.模型)
	local 人物模型 = 资源:载入(q[3],"网易WDF动画",q[1])
	if rw.装备[3] then
		local wq = nil
		local v=tp:取武器子类(rw.装备[3].子类)
		if rw.装备[3].名称 == "龙鸣寒水" or rw.装备[3].名称 == "非攻" then
			v = "弓弩1"
		end
		local q = qmx(rw.模型,v)
		人物模型 = 资源:载入(q[3],"网易WDF动画",q[1])
		local m = tp:取武器附加名称(rw.装备[3].子类,rw.装备[3].级别限制 or rw.装备[3].等级,rw.装备[3].名称)
		local x = qmx(m.."_"..rw.模型)
		local wq = 资源:载入(x[3],"网易WDF动画",x[1])
		wq:置差异(wq.帧数-人物模型.帧数)
		self.人物组[2] = wq
	end
	self.人物组[1] = 人物模型
	self.染色方案 = rw.染色方案
end

function 场景类_染色:加载数据()
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	local 资源 = tp.资源
	self.资源组 = {
		[1] = 资源:载入('新界面.wdf',"网易WDF动画",0x00000436),
		[2] = 按钮.创建(资源:载入('UI.wdf',"网易WDF动画",0x00000001),0,0,4,true,true),
		[3] = 按钮.创建(资源:载入('UI.wdf',"网易WDF动画",0x00000071),0,0,4,true,true),
		[4] = 按钮.创建(资源:载入('UI.wdf',"网易WDF动画",0x00000072),0,0,4,true,true),
		[5] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"1"),
		[6] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"2"),
		[7] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"3"),
		[8] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"确定"),
		[9] = 自适应.创建(2,1,250,251,3,9),
	}
	for i=2,8 do
	  	self.资源组[i]:绑定窗口_(29)
	end
	self.资源组[8]:置偏移(-1,0)
end

function 场景类_染色:显示(dt,x,y)
	self.焦点 = false
	self.人物组[1]:更新(dt)
	self.资源组[2]:更新(x,y)
	self.资源组[5]:更新(x,y)
	self.资源组[6]:更新(x,y)
	self.资源组[7]:更新(x,y)
	self.资源组[3]:更新(x,y)
	self.资源组[4]:更新(x,y)
	self.资源组[8]:更新(x,y)
	if self.资源组[2]:事件判断() then
		self:打开()
		return false
	elseif self.资源组[3]:事件判断() then
	--	self.染色组 = self.初始染色组
	   self.染色组   = {0,0,0}
		self:置染色()
		self.彩果 = 10

	elseif self.资源组[4]:事件判断() then
		self.方向 = self.方向 - 1
		if self.方向 < 0 then
			self.方向 = 7
		end
		self:置方向()
	elseif self.资源组[5]:事件判断() then
		self.染色组[1] = (self.染色组[1] or 0)  + 1
		if self.染色组[1] > 11 then
			self.染色组[1] = 0
		end
		self:置染色()
		--self.彩果 = self.彩果 + self.染色组[1]
		self.彩果=10
		for n=1,3 do
          self.彩果 = self.彩果 + self.染色组[n]
		end
	elseif self.资源组[6]:事件判断() then
		self.染色组[2] = (self.染色组[2] or 0) + 1
		if self.染色组[2] > 11 then
			self.染色组[2] = 0
		end
		self:置染色()
		self.彩果=10
		for n=1,3 do


          self.彩果 = self.彩果 + self.染色组[n]

		 end
	elseif self.资源组[7]:事件判断() then
		self.染色组[3] = (self.染色组[3] or 0)  + 1
		if self.染色组[3] > 11 then
			self.染色组[3] = 0
		end
		self:置染色()
	self.彩果=10
		for n=1,3 do


          self.彩果 = self.彩果 + self.染色组[n]

		 end
	elseif self.资源组[8]:事件判断() then
			请求服务(3710,self.染色组)

	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[9]:显示(self.x+10,self.y+31)
	self.资源组[2]:显示(self.x+249,self.y+4)
	self.资源组[5]:显示(self.x+18,self.y+256,nil,true)
	self.资源组[6]:显示(self.x+46,self.y+256,nil,true)
	self.资源组[7]:显示(self.x+74,self.y+256,nil,true)
	self.资源组[3]:显示(self.x+200,self.y+256,nil,nil,nil,nil,nil,2,0,1)
	self.资源组[4]:显示(self.x+227,self.y+256,nil,nil,nil,nil,nil,2,0,1)
	self.资源组[8]:显示(self.x+202,self.y+288)

	zts:置颜色(4294967295)
	zts:显示(self.x+7,self.y+291,"所需彩果")
	zts:置颜色(-16777216)
	zts:显示(self.x+81,self.y+291,self.彩果)

	tp.影子:显示(self.x+130,self.y+214)
	self.人物组[1]:显示(self.x+130,self.y+214)
	if self.人物组[2] ~= nil then
		self.人物组[2]:更新(dt)
		self.人物组[2]:显示(self.x+130,self.y+214)
	end
end

function 场景类_染色:置方向()
	self.人物组[1]:置方向(self.方向)
	if self.人物组[2] ~= nil then
		self.人物组[2]:置方向(self.方向)
	end
end

function 场景类_染色:置染色()
	self.人物组[1]:置染色(self.染色方案,self.染色组[1],self.染色组[2],self.染色组[3],0)
	self:置方向()
end

function 场景类_染色:检查点(x,y)
	if self.可视 and self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_染色:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if self.可视 and self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_染色:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_染色