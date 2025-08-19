--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-12 18:07:05
--======================================================================--
local 场景类_任务追踪栏 = class()

local floor = math.floor
local format = string.format
local insert = table.insert
local remove = table.remove
local tp
local xxx = 0
local yyy = 0
local box = 引擎.画矩形
local min = math.min
local max = math.max
local ceil = math.ceil
local mousea = 引擎.鼠标按下
local mouseb = 引擎.鼠标弹起

function 场景类_任务追踪栏:初始化(根)
	self.ID = 46
	self.x = 全局游戏宽度-200
	self.y = 100
	self.xx = 0
	self.yy = 0
	self.焦点 = false
	self.移动窗口 = false
	self.可移动窗口 = false
	local 资源 = 根.资源
	local 按钮 = require("script/系统类/按钮")
	tp = 根
	self.资源组 = {
		[1] = 根._自适应.创建(71,1,165,24,3,9),
		[2] = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0xD465F50F),0,0,4),
		[3] = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0x44F2D2D3),0,0,4),
		[4] = 按钮(资源:载入('org3.rpk',"网易WDF动画",0x1000066),0,0,4),
		[5] = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0x335CECBC),0,0,4),
		[6] = tp._滑块(资源:载入('登陆资源.wdf',"网易WDF动画",0x7F027E7B),4,10,139,2),
		[7] = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0xB7F2FF5E),0,0,4),
		[8] = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0x36DDB607),0,0,4),
		[9] = 根._自适应.创建(75,1,160,180,3,9),
		[10] = 按钮(资源:载入('org3.rpk',"网易WDF动画",0x1000067),0,0,4),
		[11] = 按钮(资源:载入('org3.rpk',"网易WDF动画",0x1000065),0,0,4),
		[12] = 按钮(资源:载入('org3.rpk',"网易WDF动画",0x1000068),0,0,4),
	}

	-- self.资源组[9]:置宽高(200,120)
--self.资源组[9]:置宽高(200,120)

	self.状态 = 2
	self.介绍加入 = 0
	self.窗口时间 = 0
	self.罗羹效果 = false
	self.介绍文本 = 根._丰富文本(153,170,nil,0,10)
	--:添加元素("L",-16776961)
	self.task = 根.任务列表
	self.数据记录={}
	self.背景表={}
	--self.wz文字 = require("gge文字类").创建(wdf配置.."/font/hkyt.ttf",21,false,true,false)
	self.wz文字 = tp.字体表.排行字体
end

function 场景类_任务追踪栏:加载(名称_,介绍_,描述_,取中间数据_)  --无用
	insert(self.task,{名称=名称_,介绍=介绍_,描述=描述_,取中间数据=取中间数据_})
	self.介绍文本:清空()
	任务坐标={}
	for i=1,#self.task do
		if self.task[i].名称=="摄妖香" and self.task[i].取中间数据~=nil and self.task[i].取中间数据>0 then
		    引擎.场景.摄妖香剩余功效时辰=self.task[i].取中间数据
		else
			if self.task[i].名称=="罗羹效果" then
			    self.罗羹效果=true
			end
			 if self.task[i].取中间数据~=nil and self.task[i].取中间数据.x~=nil then
				local 断句 = 分割文本(self.task[i].介绍,"@")
				任务坐标[i] = {名称=self.task[i].取中间数据.名称,x=self.task[i].取中间数据.x,y=self.task[i].取中间数据.y,地图 = self.task[i].取中间数据.地图}
				 self.介绍文本:添加文本(format("#G/%s\n◆%s#G/xx/%s#W/%s",self.task[i].名称,断句[1],self.task[i].取中间数据.名称,断句[2]))
			else
				 self.介绍文本:添加文本(format("#G/%s\n◆%s",self.task[i].名称,self.task[i].介绍))
			end
			--self.介绍文本:添加文本(format("#G/%s\n◆%s",self.task[i].名称,self.task[i].介绍))
		end
	    if i < #self.task then
		    self.介绍文本:添加文本("")
		end
	end
	for i=1,#self.介绍文本.显示表 - 10 do
		self.介绍文本:滚动(1)
	end
	if #self.介绍文本.显示表 > 10 and self.介绍加入 ~= 0 then
		self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.介绍加入+1,10,#self.介绍文本.显示表))
		self.介绍加入 = min(ceil((#self.介绍文本.显示表-10)*self.资源组[6]:取百分比()),#self.介绍文本.显示表-10)
		self.介绍文本.加入 = self.介绍加入
	end
end

function 场景类_任务追踪栏:修改内容(名称,内容,描述,取中间数据_)
	for i=1,#self.task do
		if self.task[i].名称 == 名称 then
		   	self.task[i].介绍 = 内容
		   	self.task[i].描述 = 描述
		   	if self.选中 ~= 0 and self.task[self.选中].名称 == 名称  then
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
				-- self.资源组[6]:置起始点(0)
				self.介绍加入 = 0
		   	end
		   	break
		end
	end
end
--
function 场景类_任务追踪栏:删除(名称)
	for i=1,#self.task do
	    if self.task[i].名称 == 名称 then
	    	if #self.task > 12 then
		    	self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.加入-1,11,#self.task))
		    	self.选中 = self.选中 - 1
		    else
		    	self.选中 = max(self.选中 - 1,0)
		    	self.加入 = 0
		    end
	    	if self.状态 == 1 and self.选中 ~= 0 and 名称 == self.task[self.选中].名称 then
	    		self.介绍文本:清空()
	    	end
		   	remove(self.task,i)
		   	break
		end
	end
end

function 场景类_任务追踪栏:刷新(名称,介绍,描述,取中间数据_)
	self.数据记录[#self.数据记录+1]={名称=名称,介绍=介绍,描述=描述_,取中间数据=取中间数据_}
	self.介绍文本:清空()
	任务坐标={}
	for i=1,#self.数据记录 do
		local 资源=tp.窗口.人物框:取图标(self.数据记录[i].名称)
		if 资源[1]==nil then
			if self.数据记录[i].取中间数据~=nil and self.数据记录[i].取中间数据.x~=nil then
				local 断句 = 分割文本(self.数据记录[i].介绍,"@")
				任务坐标[i] = {名称=self.数据记录[i].取中间数据.名称,x=self.数据记录[i].取中间数据.x,y=self.数据记录[i].取中间数据.y,地图 = self.数据记录[i].取中间数据.地图}
				 self.介绍文本:添加文本(format("#G/%s\n◆%s#G/xx/%s#W/%s",self.数据记录[i].名称,断句[1],self.数据记录[i].取中间数据.名称,断句[2]))
			else
				 self.介绍文本:添加文本(format("#G/%s\n◆%s",self.数据记录[i].名称,self.数据记录[i].介绍))
			end

		--	self.介绍文本:添加文本(format("#R/%s\n◆%s",self.数据记录[i].名称,self.数据记录[i].介绍))
		    if i < #self.数据记录 then
			    self.介绍文本:添加文本("")
			end
		end
	end



	for i=1,#self.介绍文本.显示表 - 10 do
		self.介绍文本:滚动(1)
	end
	if #self.介绍文本.显示表 > 10 and self.介绍加入 ~= 0 then
		self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.介绍加入+1,10,#self.介绍文本.显示表))
		self.介绍加入 = min(ceil((#self.介绍文本.显示表-10)*self.资源组[6]:取百分比()),#self.介绍文本.显示表-10)
		self.介绍文本.加入 = self.介绍加入
	end

end



function 场景类_任务追踪栏:显示(dt,x,y)
	if not tp.任务追踪 then
		self.x = 全局游戏宽度-162
		self.焦点 = false
		self.资源组[4]:更新(x,y)
		self.资源组[4]:显示(self.x+146,self.y-1)
		if self.资源组[4]:事件判断(x,y) then
			self.资源组[4]:置翻转()
			tp.任务追踪 = true
		end
		if  tp.按钮焦点 then
			self.焦点 = true
		end
		return
	end
	self.x = 全局游戏宽度-162
	self.焦点 = false
	self.资源组[self.状态]:更新(x,y)
	self.资源组[4]:更新(x,y)
	self.资源组[10]:更新(x,y)
	self.资源组[11]:更新(x,y)
	self.资源组[12]:更新(x,y)
	self.介绍文本:更新(x,y)
	if self.资源组[4]:事件判断(x,y) then
		tp.任务追踪 = false
		self.资源组[4]:置翻转(true)
	end
	self.资源组[1]:显示(self.x-3,self.y-5)
    self.资源组[9]:显示(self.x,self.y+20)
	self.wz文字:置字间距(1)
	self.wz文字:置颜色(0xFFFFFFFF)
	self.wz文字:显示(self.x+55,self.y,"任务追踪")


	self.资源组[4]:显示(self.x+146,self.y-1)
	self.资源组[10]:显示(self.x+7,self.y-4)
	self.资源组[11]:显示(self.x+32,self.y-3)
	self.资源组[12]:显示(self.x+122,self.y-1)


	-- if #self.介绍文本.显示表 > 10 then
	-- 	self.资源组[5]:更新(x,y,self.介绍加入 > 0)
	-- 	self.资源组[7]:更新(x,y,self.介绍加入 < #self.介绍文本.显示表 - 10)
	-- 	if self.资源组[5]:事件判断() then
	-- 		self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.介绍加入-1,10,#self.介绍文本.显示表))
	-- 	elseif self.资源组[7]:事件判断() then
	-- 		self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.介绍加入+1,10,#self.介绍文本.显示表))
	-- 	end
	-- 	self.资源组[5]:显示(self.x+185,self.y+31)
	-- 	box(self.x+185,self.y+44,self.x+195,self.y+183,ARGB(160,30,30,30))
	-- 	self.资源组[6]:显示(self.x+185,self.y+44,x,y,true)
	-- 	self.资源组[7]:显示(self.x+185,self.y+183)
	-- 	self.介绍加入 = min(ceil((#self.介绍文本.显示表-10)*self.资源组[6]:取百分比()),#self.介绍文本.显示表-10)
	-- 	self.介绍文本.加入 = self.介绍加入
	-- end
	self.介绍文本:显示(self.x+3,self.y+30,4294967295)


	if 引擎.取鼠标滚轮() >0 then--鼠标上滚动
		   if self.介绍文本.滚动值 < #self.介绍文本.显示表 -10 then
				self.介绍文本:滚动(1)
			end
	elseif 引擎.取鼠标滚轮() <0  then--鼠标下滚动
		if self.介绍文本.滚动值 > 0 then
		   self.介绍文本:滚动(-1)
		end
	end
	if  tp.按钮焦点 then
		self.焦点 = true
	end


end



function 场景类_任务追踪栏:检查点(x,y)
	if not tp.战斗中 and ((self.可移动窗口 and self.资源组[1]:是否选中(x,y) ) or self.焦点)  then--or self.资源组[9]:是否选中(x,y)
		return true
	end
end
function 场景类_任务追踪栏:初始移动(x,y)
	if tp.消息栏焦点 then
		return
	end
	if not self.焦点 then
		self.移动窗口 = true
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_任务追踪栏:开始移动(x,y)
	self.x = x - self.xx
	self.y = y - self.yy
end


return 场景类_任务追踪栏