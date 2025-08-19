--======================================================================--
--	☆ 作者：飞蛾扑火 QQ：1415559882
--======================================================================--
local 场景类_小地图NPC = class()
local ceil = math.ceil
local bw = require("gge包围盒")(0,0,148,18)
local box = 引擎.画矩形
local insert = table.insert
local remove = table.remove
local tp,task,font,fonts1
local min = math.min
local max = math.max
local mouseb = 引擎.鼠标弹起

local xys = 生成XY
local floor = math.floor
local format = string.format
local mouseb = 引擎.鼠标弹起
local wns = 引擎.文件是否存在
local insert = table.insert
local fgz = 分割字符
local tonumber = tonumber

function 场景类_小地图NPC:初始化(根)
	self.ID = 65
	self.x = 313
	self.y = 125
	self.xx = 0
	self.yy = 0
	self.注释 = "小地图NPC"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.介绍文本 = 根._丰富文本(187,215)
	self.选中 = 0
	self.加入 = 0
	self.介绍加入 = 0
	self.窗口时间 = 0
	self.状态 = 1
	task = 根.任务列表
	font = 根.字体表.普通字体
	fonts1 = 根.字体表.排行字体
	tp = 根
	self.NPC假人={}
end

function 场景类_小地图NPC:打开()
	if self.可视 then
		self.选中 = 0
		self.加入 = 0
		self.介绍加入 = 0
		self.介绍文本:清空()
		self.可视 = false
		self.NPC假人={}
		self.资源组 = nil
		return
	else
		insert(tp.窗口_,self)
		local 资源 = tp.资源
		local 按钮 = tp._按钮
		local 滑块 = tp._滑块
		local 自适应 = tp._自适应
		self.资源组 = {
			[1] = 自适应.创建(0,1,425,333,3,9),
			[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
			[3] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x335CECBC),0,0,4,true,true), --上
		    [4] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xB7F2FF5E),0,0,4,true,true), --下
			[5] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x335CECBC),0,0,4,true,true), --上
		    [6] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xB7F2FF5E),0,0,4,true,true), --下
			[7] =  滑块.创建(自适应.创建(11,4,7,40,2,3,nil),4,14,210,2),
			[10] = 滑块.创建(自适应.创建(11,4,7,40,2,3,nil),4,14,213,2),
			[11] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"自动寻路"),
			[12] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"副本介绍"),
			[15] = 自适应.创建(4,1,1,1,3,nil),
			[16] = 自适应.创建(1,1,421,18,1,3,nil,18),
			[17] = 自适应.创建(4,1,1,1,3,nil),
		}
		for n=2,6 do
		    self.资源组[n]:绑定窗口_(65)
		end
		for n=11,12 do
		    self.资源组[n]:绑定窗口_(65)
		end
		self.状态 = 1
	    tp.运行时间 = tp.运行时间 + 1
	  	self.窗口时间 = tp.运行时间
	    self.可视 = true
		self.NPC假人={}
		self.资源组[7]:置起始点(0)
		for k,v in pairs(NPC列表[tp.当前地图]) do
			table.insert(self.NPC假人,v)
		end
	end
end

function 场景类_小地图NPC:显示(dt,x,y)
	self.焦点 = false
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y,self.加入 > 0)
	self.资源组[4]:更新(x,y,self.加入 < #self.NPC假人 - 11)
	self.资源组[5]:更新(x,y,self.介绍加入 > 0)
	self.资源组[6]:更新(x,y,self.介绍加入 < #self.介绍文本.显示表 - 13)
	self.资源组[11]:更新(x,y,self.选中 > 0)
	if self.资源组[2]:事件判断() then
		self:打开()
		return false
	elseif self.资源组[3]:事件判断() then
		self.资源组[7]:置起始点(self.资源组[7]:取百分比转换(self.加入-1,11,#self.NPC假人))
	elseif self.资源组[4]:事件判断() then
		self.资源组[7]:置起始点(self.资源组[7]:取百分比转换(self.加入+1,11,#self.NPC假人))
	elseif self.资源组[5]:事件判断() then
		self.资源组[10]:置起始点(self.资源组[10]:取百分比转换(self.介绍加入-1,13,#self.介绍文本.显示表))
	elseif self.资源组[6]:事件判断() then
		self.资源组[10]:置起始点(self.资源组[10]:取百分比转换(self.介绍加入+1,13,#self.介绍文本.显示表))
	elseif self.资源组[11]:事件判断() then
		if #self.NPC假人>0 and not 摊位名称 then
			local xxQ = self.NPC假人[self.选中].x
			local yyQ = self.NPC假人[self.选中].y
			tp.窗口.小地图:清空()
			local 格子 = xys(xxQ,yyQ)
			local a = xys(floor(tp.角色坐标.x / 20),floor(tp.角色坐标.y / 20))
			tp.场景.人物.目标格子 = tp.场景.地图.寻路:寻路(a,格子)
			tp.场景.跟随坐标 = {tp.场景.人物.目标格子}
			tp.场景.人物.移动 = true
			tp.场景.人物:取目标(tp.场景.人物.目标格子[1])
		end
	elseif self.资源组[12]:事件判断()  then

	end



	self.资源组[1]:显示(self.x,self.y)
	self.资源组[16]:显示(self.x+2,self.y+2)
	self.资源组[2]:显示(self.x + 403,self.y + 2)

	if  string.len(取地图名称(tp.当前地图)) == 2 then
		tp.窗口标题背景_[1]:显示(self.x+146,self.y+2)
	elseif  string.len(取地图名称(tp.当前地图)) == 4 then
	    tp.窗口标题背景_[2]:显示(self.x+146,self.y+2)
	elseif  string.len(取地图名称(tp.当前地图)) == 6 then
	    tp.窗口标题背景_[3]:显示(self.x+146,self.y+2)
	elseif  string.len(取地图名称(tp.当前地图)) == 8 then
	    tp.窗口标题背景_[4]:显示(self.x+146,self.y+2)
	elseif  string.len(取地图名称(tp.当前地图)) == 10 then
	    tp.窗口标题背景_[5]:显示(self.x+146,self.y+2)
	elseif  string.len(取地图名称(tp.当前地图)) == 12 then
	    tp.窗口标题背景_[6]:显示(self.x+146,self.y+2)
	elseif  string.len(取地图名称(tp.当前地图)) == 14 then
	    tp.窗口标题背景_[7]:显示(self.x+146,self.y+2)
	elseif  string.len(取地图名称(tp.当前地图)) == 16 then
	    tp.窗口标题背景_[8]:显示(self.x+146,self.y+2)
	elseif  string.len(取地图名称(tp.当前地图)) == 18 then
	    tp.窗口标题背景_[9]:显示(self.x+146,self.y+2)
	elseif  string.len(取地图名称(tp.当前地图)) == 20 then
	    tp.窗口标题背景_[10]:显示(self.x+146,self.y+2)
	end
	fonts1:置字间距(3)
	fonts1:显示(self.x+176,self.y+2,取地图名称(tp.当前地图))
	fonts1:置字间距(0)
	self.状态=1
	if self.状态 == 1 then
		self.资源组[15]:置宽高(159,251)
		self.资源组[15]:显示(self.x+15,self.y+63)
		self.资源组[17]:置宽高(190,251)
		self.资源组[17]:显示(self.x+204,self.y+63)
		fonts1:置字间距(10)
		fonts1:显示(self.x+52,self.y+68,"NPC列表")
		fonts1:显示(self.x+259,self.y+68,"NPC详细")
		fonts1:置字间距(0)
		self.资源组[11]:显示(self.x + 340,self.y + 30,true)--自动寻路
		-- tp.画线:置区域(0,0,15,209)
		-- tp.画线:显示(self.x+179,self.y+85)
		-- tp.画线:显示(self.x+399,self.y+85)
		self.资源组[3]:显示(self.x + 176,self.y + 66)
		self.资源组[4]:显示(self.x + 176,self.y + 294)
		self.资源组[5]:显示(self.x + 396,self.y + 66)
		self.资源组[6]:显示(self.x + 396,self.y + 294)
		if #self.NPC假人 > 11 then
			self.加入 = min(ceil((#self.NPC假人-11)*self.资源组[7]:取百分比()),#self.NPC假人-11)
			self.资源组[7]:显示(self.x + 176,self.y + 84,x,y,self.鼠标)
		end
		if #self.介绍文本.显示表 > 13 then
			self.介绍加入 = min(ceil((#self.介绍文本.显示表-13)*self.资源组[10]:取百分比()),#self.介绍文本.显示表-13)
			self.介绍文本.加入 = self.介绍加入
			self.资源组[10]:显示(self.x + 395,self.y + 84,x,y,self.鼠标)
		end
    if  self.资源组[15]:是否选中(x,y) then
		if 引擎.取鼠标滚轮() >0 and  self.加入 > 0 then--鼠标上滚动
		    self.资源组[7]:置起始点(self.资源组[7]:取百分比转换(self.加入-1,11,#self.NPC假人))
		  elseif 引擎.取鼠标滚轮() <0  and self.加入 < #self.NPC假人 - 11 then--鼠标下滚动
		   	self.资源组[7]:置起始点(self.资源组[7]:取百分比转换(self.加入+1,11,#self.NPC假人))
		  end
	end
		font:置颜色(-16777216)
		font:置阴影颜色(nil)
		for n=1,#self.NPC假人 do
			if((n + self.加入) <= (11 + self.加入)) and self.NPC假人[n + self.加入]~=nil then
				bw:置坐标(self.x + 17,self.y + 89 + (n-1)*19.5)
				if self.选中 ~= self.加入 + n then
					if bw:检查点(x,y) then
						box(self.x + 21,self.y + 93 + (n-1)*19.5,self.x + 169,self.y + 93 + (n-1)*19.5+18,-3551379)
						if mouseb(0) and self.鼠标 and not tp.消息栏焦点 then
							self.选中 = n + self.加入
							self.介绍文本:清空()
							self.介绍文本:添加文本("#L/◆ "..self.NPC假人[n+ self.加入].名称.."\n#R/◆X坐标: "..到文本(到整数(self.NPC假人[self.选中].x)).."\n#Z/◆Y坐标: "..到文本(到整数(self.NPC假人[self.选中].y)).."\n#N/◆NPC介绍: ".."暂无!")
							for i=1,#self.介绍文本.显示表 - 13 do
								self.介绍文本:滚动(1)
							end
							self.资源组[10]:置起始点(0)
							self.介绍加入 = 0
						end
						self.焦点 = true
					end
				else
					local ys = -10790181
					if bw:检查点(x,y) then
						ys = -9670988
						self.焦点 = true
					end
					box(self.x + 21,self.y + 93 + (n-1)*19.5,self.x + 169,self.y + 93 + (n-1)*19.5+18,ys)
				end
				font:显示(self.x+30,self.y+95+(n-1)*19.5,self.NPC假人[n+ self.加入].名称)
			end
		end
		self.介绍文本:显示(self.x + 208,self.y + 95.5)
	end
	fonts1:置字间距(0)
	if self.资源组[7].接触 or self.资源组[10].接触 then
		self.焦点 = true
	end
end

function 场景类_小地图NPC:检查点(x,y)
	if self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_小地图NPC:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_小地图NPC:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_小地图NPC