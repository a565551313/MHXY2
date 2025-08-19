--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-12 18:05:54
--======================================================================--
local 场景类_任务栏 = class()
local ceil = math.ceil
local bw = require("gge包围盒")(0,0,148,18)
local box = 引擎.画矩形
local insert = table.insert
local remove = table.remove
local tp,task,font,fonts1
local min = math.min
local max = math.max
local mouseb = 引擎.鼠标弹起
local fb = {{"乌鸡国","#R/副本难度：低\n#L/找长安国子监吴举人进入副本"},
{"车迟斗法","#R/副本难度：低\n#L/找长寿村慧觉和尚进入副本"},
{"水陆大会","#R/副本难度：低\n#L/找化生寺疥癞和尚进入副本"},
{"通天河","#R/副本难度：高\n#L/找长寿村的蝴蝶女进入副本"},
-- {"黑风山","#R/副本难度：高\n#L/找大唐国境小二进入副本"},
{"齐天大圣","#R/副本难度：高\n#L/找傲来国红毛猿进入副本"},
-- {"大闹天宫","#R/副本难度：高\n#L/找长寿村太白金星进入副本"},
-- {"秘境降妖","#R/副本难度：高\n#L/找长安城的御林军左统领进入副本"},
}

function 场景类_任务栏:初始化(根)
	self.ID = 20
	self.x = 250
	self.y = 125
	self.xx = 0
	self.yy = 0
	self.注释 = "任务栏"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.介绍文本 = 根._丰富文本(187,215)
	self.介绍文本:添加元素("ms",根.包子表情动画[85])
	self.选中 = 0
	self.加入 = 0
	self.介绍加入 = 0
	self.窗口时间 = 0
	self.状态 = 1
	task = 根.任务列表
	font = 根.字体表.普通字体
	tp = 根
end

function 场景类_任务栏:打开(数据)
	if self.可视 then
		self.选中 = 0
		self.加入 = 0
		self.介绍加入 = 0
		self.介绍文本:清空()
		self.可视 = false
		self.资源组 = nil
		return
	else
		insert(tp.窗口_,self)
		self.状态 = 1
	    tp.运行时间 = tp.运行时间 + 1
	  	self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self:加载资源()
	    task={}
	    for n=1,#数据 do
         	self:添加(数据[n][1],数据[n][2],数据[n][3],数据[n][4])
	    end
	end
end

function 场景类_任务栏:刷新(数据)
	insert(tp.窗口_,self)
    task={}
    for n=1,#数据 do
     	self:添加(数据[n][1],数据[n][2],数据[n][3],数据[n][4])
    end
end

function 场景类_任务栏:加载资源()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 滑块 = tp._滑块
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,430,353,3,9),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[3] = 按钮.创建(自适应.创建(20,4,18,19,4,3),0,0,4,true,true),
		[4] = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true),
		[5] = 按钮.创建(自适应.创建(20,4,18,19,4,3),0,0,4,true,true),
		[6] = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true),
		[7] =  滑块.创建(自适应.创建(11,4,7,40,2,3,nil),4,14,210,2),
		[10] = 滑块.创建(自适应.创建(11,4,7,40,2,3,nil),4,14,213,2),
		[11] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"已接任务"),
		[12] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"副本介绍"),
		[13] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"创建副本"),
		[14] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"取消创建"),
		[15] = 自适应.创建(4,1,1,1,3,nil),
		[16] = 自适应.创建(1,1,426,18,1,3,nil,18),
		[17] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"任务追踪"),
	}
	for n=2,6 do
	    self.资源组[n]:绑定窗口_(20)
	end
	for n=11,14 do
	    self.资源组[n]:绑定窗口_(20)
	end
end
function 场景类_任务栏:添加(名称_,介绍_,描述_,取中间数据_)
	insert(task,{名称=名称_,介绍=介绍_,描述=描述_,取中间数据=取中间数据_})
	if self.选中 ~= 0 and task[self.选中] ~= nil and task[self.选中].名称 == 名称_ then
		self.介绍文本:清空()
		self.介绍文本:添加文本("#W/◆"..task[self.选中].介绍)
		if 描述_ ~= nil then
			self.介绍文本:添加文本("")
			self.介绍文本:添加文本("")
			self.介绍文本:添加文本("#ms")
			self.介绍文本:添加文本("#L/"..描述_)
		end
		for i=1,#self.介绍文本.显示表 - 13 do
			self.介绍文本:滚动(1)
		end
	end
	if #task > 11 and self.加入 ~= 0 then
		self.资源组[7]:置起始点(self.资源组[7]:取百分比转换(self.加入+1,11,#task))
		self.加入 = min(ceil((#task-11)*self.资源组[7]:取百分比()),#task-11)
	end
end

function 场景类_任务栏:修改内容(名称,内容,描述,取中间数据_)
	for i=1,#task do
		if task[i].名称 == 名称 then
		   	task[i].介绍 = 内容
		   	task[i].描述 = 描述
		   	if self.选中 ~= 0 and task[self.选中].名称 == 名称  then
		   		self.介绍文本:清空()
				if 描述 ~= nil then
					self.介绍文本:添加文本("")
					self.介绍文本:添加文本("")
					self.介绍文本:添加文本("#ms")
					self.介绍文本:添加文本("#L/"..描述)
				end
				for i=1,#self.介绍文本.显示表 - 13 do
					self.介绍文本:滚动(1)
				end
				self.资源组[10]:置起始点(0)
				self.介绍加入 = 0
		   	end
		   	break
		end
	end
end

function 场景类_任务栏:是否有该任务(名称)
	for i=1,#task do
		if task[i].名称 == 名称 then
			return task[i]
		end
	end
	return 0
end

function 场景类_任务栏:删除(名称)
	for i=1,#task do
	    if task[i].名称 == 名称 then
			if task[i].名称=="摄妖香" then
			    引擎.场景.摄妖香剩余功效时辰=0
			end
	    	if #task > 12 then
		    	self.资源组[7]:置起始点(self.资源组[7]:取百分比转换(self.加入-1,11,#task))
		    	self.选中 = self.选中 - 1
		    else
		    	self.选中 = max(self.选中 - 1,0)
		    	self.加入 = 0
		    end
	    	if self.状态 == 1 and self.选中 ~= 0 and 名称 == task[self.选中].名称 then
	    		self.介绍文本:清空()
	    	end
		   	remove(task,i)
		   	break
		end
	end
end

function 场景类_任务栏:显示(dt,x,y)
	self.焦点 = false
	self.资源组[2]:更新(x,y)
	self.资源组[11]:更新(x,y,self.状态~=1)
	self.资源组[12]:更新(x,y,self.状态~=2)
	self.资源组[3]:更新(x,y,self.加入 > 0)
	self.资源组[4]:更新(x,y,self.加入 < #task - 11)
	self.资源组[5]:更新(x,y,self.介绍加入 > 0)
	self.资源组[6]:更新(x,y,self.介绍加入 < #self.介绍文本.显示表 - 13)
	if self.资源组[2]:事件判断() then
		self:打开()
		return false
	elseif self.资源组[3]:事件判断() then
		self.资源组[7]:置起始点(self.资源组[7]:取百分比转换(self.加入-1,11,#task))
	elseif self.资源组[4]:事件判断() then
		self.资源组[7]:置起始点(self.资源组[7]:取百分比转换(self.加入+1,11,#task))
	elseif self.资源组[5]:事件判断() then
		self.资源组[10]:置起始点(self.资源组[10]:取百分比转换(self.介绍加入-1,13,#self.介绍文本.显示表))
	elseif self.资源组[6]:事件判断() then
		self.资源组[10]:置起始点(self.资源组[10]:取百分比转换(self.介绍加入+1,13,#self.介绍文本.显示表))
	elseif self.资源组[11]:事件判断() or self.资源组[12]:事件判断()  then
		if self.状态 == 2 then
			self.状态 = 1
			bw:置宽高(148,18)
			self.介绍文本.宽度,self.介绍文本.默认宽度,self.介绍文本.高度 = 187,187,215
		else
			self.状态 = 2
			bw:置宽高(108,18)
			self.介绍文本.宽度,self.介绍文本.默认宽度,self.介绍文本.高度 = 205,205,215
		end
		self.选中 = 0
		self.加入 = 0
		self.介绍加入 = 0
		self.介绍文本:清空()
		self.资源组[10]:置起始点(0)
	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[16]:显示(self.x+2,self.y+2)
	self.资源组[2]:显示(self.x + 409,self.y + 2)
	tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	font:置字间距(3)
	font:置颜色(白色):显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"任务提示")
	font:置字间距(0)
	self.资源组[11]:显示(self.x + 20,self.y + 30,nil,nil,nil,self.状态==1,2)
	self.资源组[12]:显示(self.x + 100,self.y + 30,nil,nil,nil,self.状态==2,2)
	if self.状态 == 1 then
		self.资源组[15]:置宽高(159,251)
		self.资源组[15]:显示(self.x+15,self.y+63)
		self.资源组[15]:置宽高(190,251)
		self.资源组[15]:显示(self.x+204,self.y+63)
		font:置字间距(10)
		font:显示(self.x+52,self.y+68,"任务列表")
		font:显示(self.x+259,self.y+68,"任务详细")
		font:置字间距(0)

		-- tp.画线:置区域(0,0,15,209)
		-- tp.画线:显示(self.x+179,self.y+85)
		-- tp.画线:显示(self.x+399,self.y+85)
		self.资源组[3]:显示(self.x + 176,self.y + 66)
		self.资源组[4]:显示(self.x + 176,self.y + 294)
		self.资源组[5]:显示(self.x + 396,self.y + 66)
		self.资源组[6]:显示(self.x + 396,self.y + 294)
		if #task > 11 then
			self.加入 = min(ceil((#task-11)*self.资源组[7]:取百分比()),#task-11)
			self.资源组[7]:显示(self.x + 176,self.y + 84,x,y,self.鼠标)
		end
		if #self.介绍文本.显示表 > 13 then
			self.介绍加入 = min(ceil((#self.介绍文本.显示表-13)*self.资源组[10]:取百分比()),#self.介绍文本.显示表-13)
			self.介绍文本.加入 = self.介绍加入
			self.资源组[10]:显示(self.x + 395,self.y + 84,x,y,self.鼠标)
		end
		font:置颜色(-16777216)
		font:置阴影颜色(nil)
		local wzzb = 0
		for n=1,11 do
			if((n + self.加入) <= (11 + self.加入)) and task[n + self.加入]~=nil and task[n + self.加入].名称~="摄妖香" then
				if ((n + self.加入) <= (11 + self.加入)) and task[n + self.加入]~=nil and task[n + self.加入].名称~="变身卡" then
					if ((n + self.加入) <= (11 + self.加入)) and task[n + self.加入]~=nil and task[n + self.加入].名称~="双倍时间" then
						if ((n + self.加入) <= (11 + self.加入)) and task[n + self.加入]~=nil and task[n + self.加入].名称~="精修时间" then
							if ((n + self.加入) <= (11 + self.加入)) and task[n + self.加入]~=nil and task[n + self.加入].名称~="罗羹效果" then
									if ((n + self.加入) <= (11 + self.加入)) and task[n + self.加入]~=nil and task[n + self.加入].名称~="离线经验加成" then
										if ((n + self.加入) <= (11 + self.加入)) and task[n + self.加入]~=nil and task[n + self.加入].名称~="离线储备加成" then

				wzzb=wzzb+1
				bw:置坐标(self.x + 17,self.y + 89 + (wzzb-1)*19.5)
				if self.选中 ~= self.加入 + n then
					if bw:检查点(x,y) then
						box(self.x + 21,self.y + 93 + (wzzb-1)*19.5,self.x + 169,self.y + 93 + (wzzb-1)*19.5+18,-3551379)
						if mouseb(0) and self.鼠标 and not tp.消息栏焦点 then
							self.选中 = n + self.加入
							self.介绍文本:清空()
							self.介绍文本:添加文本("#W/◆"..task[self.选中].介绍)
							if task[self.选中].描述 ~= nil then
								self.介绍文本:添加文本("")
								self.介绍文本:添加文本("")
							    self.介绍文本:添加文本("#ms")
							    self.介绍文本:添加文本("#L/"..task[self.选中].描述)
							end
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
					box(self.x + 21,self.y + 93 + (wzzb-1)*19.5,self.x + 169,self.y + 93 + (wzzb-1)*19.5+18,ys)
				end
				font:显示(self.x+30,self.y+95+(wzzb-1)*19.5,task[n + self.加入].名称)
			end
		end
		end
		end
		end
	    end
		end
		end
		self.介绍文本:显示(self.x + 208,self.y + 95.5)
		self.资源组[17]:更新(x,y)
		if self.资源组[17]:事件判断() then
			tp.任务追踪 = not tp.任务追踪
		end
		self.资源组[17]:显示(self.x+23,self.y+320)
	elseif self.状态 == 2 then
		self.资源组[15]:置宽高(129,252)
		self.资源组[15]:显示(self.x+15,self.y+63)
		self.资源组[15]:置宽高(220,252)
		-- tp.画线:置区域(0,0,15,228)
		self.资源组[15]:显示(self.x+171,self.y+63)
		-- tp.画线:显示(self.x+149,self.y+68)
		-- tp.画线:显示(self.x+396,self.y+68)
		self.资源组[3]:显示(self.x + 146,self.y + 64)
		self.资源组[4]:显示(self.x + 146,self.y + 296)
		self.资源组[5]:显示(self.x + 393,self.y + 64)
		self.资源组[6]:显示(self.x + 393,self.y + 296)
		font:置字间距(10)
		font:显示(self.x+43,self.y+68,"副本列表")
		font:显示(self.x+243,self.y+68,"副本详细")
		font:置字间距(0)
		if #self.介绍文本.显示表 > 13 then
			self.介绍加入 = min(ceil((#self.介绍文本.显示表-13)*self.资源组[10]:取百分比()),#self.介绍文本.显示表-13)
			self.介绍文本.加入 = self.介绍加入
			self.资源组[10]:显示(self.x + 393,self.y + 83,x,y,self.鼠标)
		end
		font:置颜色(-16777216)
		for n=1,5 do
			bw:置坐标(self.x + 14,self.y + 91 + (n-1)*19.5)
			if self.选中 ~= self.加入 + n then
			if bw:检查点(x,y) then
					box(self.x + 20,self.y + 95 + (n-1)*19.5,self.x + 136,self.y + 95 + (n-1)*19.5+18,-3551379)
					if mouseb(0) and self.鼠标 and not tp.消息栏焦点 then
						self.选中 = n
						self.介绍文本:清空()
						self.介绍文本:添加文本(fb[self.选中][2])
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
				box(self.x + 20,self.y + 95 + (n-1)*19.5,self.x + 136,self.y + 95 + (n-1)*19.5+18,ys)
			end
			font:显示(self.x+30,self.y+97+(n-1)*19.5,fb[n][1])
			self.介绍文本:显示(self.x + 180,self.y + 98.5)
		end
	end
	font:置字间距(0)
	if self.资源组[7].接触 or self.资源组[10].接触 then
		self.焦点 = true
	end
end


function 场景类_任务栏:检查点(x,y)
	if self.资源组~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_任务栏:初始移动(x,y)
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

function 场景类_任务栏:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_任务栏