--======================================================================--
--	☆ 作者：飞蛾扑火 QQ：1415559882
--======================================================================--
local 场景类_坐骑技能栏 = class()
local zts,bb,tp,zts1
local yx = {{68,4},{25,28},{111,28},{24,75},{111,75},{68,97}}
local insert = table.insert
local mouseb = 引擎.鼠标弹起
function 场景类_坐骑技能栏:初始化(根)
	self.ID = 77
	self.xx = 0
	self.yy = 0
	self.注释 = "坐骑技能栏"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	tp = 根
	zts = tp.字体表.普通字体
	zts1 = tp.字体表.描边字体
	self.状态 = 1
	self.窗口时间 = 0
	self.介绍文本 = 根._丰富文本(255,200)
	self.介绍加入 = 0
	self.加入 = 0
	font = 根.字体表.人物字体_
	self.技能等级={}
end

function 场景类_坐骑技能栏:打开(b,编号)
	if self.可视 then
		if b ~= nil and  编号 ~= self.编号 then
			bb = b
			self.编号 = 编号
			for i=1,5 do
		   		local 临时技能=tp._技能.创建()
		    	临时技能:置对象(bb.技能[i],2)
			    self.技能[i]:置技能(临时技能)
			end
			for i=1,#bb.技能 do
				if bb.技能等级 ~= nil and bb.技能等级[i] ~= nil then
					self.技能等级[i] = bb.技能等级[i]
				else
					self.技能等级[i] = 0
				end
			end
			return
		end
		self.状态 = nil
		self.可视 = false
		self.介绍文本:清空()
		self.介绍加入 = 0
		self.编号 = 0
		if tp.窗口.坐骑资质栏.可视 then
			tp.窗口.坐骑资质栏:打开()
		end
		self.资源组 = nil
		self.技能 = nil
		return

	else
		insert(tp.窗口_,self)
		local 资源 = tp.资源
		local 按钮 = tp._按钮
		local 自适应 = tp._自适应
		local 滑块 = tp._滑块
		self.资源组 = {
			[1] = 自适应.创建(0,1,315,453,3,9),
			[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
			[3] = 按钮.创建(自适应.创建(10,4,44,20,1,3),0,0,4,true,true,"辅助"),
			[4] = 按钮.创建(自适应.创建(10,4,44,20,1,3),0,0,4,true,true,"天火"),
			[5] = 按钮.创建(自适应.创建(10,4,44,20,1,3),0,0,4,true,true,"苍雷"),
			--[6] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x68D384BD),--技能栏
			[6] =资源:载入('房屋图标.wdf',"网易WDF动画",0x00000030),
			[7] = 按钮.创建(自适应.创建(10,4,44,20,1,3),0,0,4,true,true,"赤电"),
			[8] = 按钮.创建(自适应.创建(10,4,44,20,1,3),0,0,4,true,true,"寒水"),
			[9] = 按钮.创建(自适应.创建(10,4,44,20,1,3),0,0,4,true,true,"疾风"),
			[10] = 自适应.创建(34,1,282,210,3,9),--说明框
			[11] = 按钮.创建(自适应.创建(20,4,18,19,4,3),0,0,4,true,true),--上滚动
			[12] = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true),--下滚动
			[13] = 自适应.创建(3,1,95,18,1,3),--属性框3 大
			[14] = 自适应.创建(1,1,311,18,1,3,nil,18),
			[15] = 自适应.创建(3,1,62,18,1,3),--属性框3 小
			[16] = 自适应.创建(0,1,303,380,3,9),--分框2
			[17] = 滑块.创建(自适应.创建(11,4,7,40,2,3,nil),4,14,213,2),
			[18] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xB15C5678),0,0,4,true,true,"查看资质"),
		}
		self.资源组[18]:置偏移(0,3)
		self.技能 = {}
		local jn = tp._技能格子
		for i=1,5 do
		    self.技能[i] = jn(0,0,i,"坐骑资质技能")
		end
		for i=2,5 do
		    self.资源组[i]:绑定窗口_(77)
		end
		bb = b
		for i=1,5 do
		   local 临时技能=tp._技能.创建()
		    临时技能:置对象(bb.技能[i],2)
		  	self.技能[i]:置技能(临时技能)
		end
		for i=1,#bb.技能 do
			if bb.技能等级 ~= nil and bb.技能等级[i] ~= nil then
				self.技能等级[i] = bb.技能等级[i]
			else
				self.技能等级[i] = 0
			end
		end
		self.编号 = 编号
		self.状态 = 1
		tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end

function 场景类_坐骑技能栏:修改内容(名称,内容,描述,bb)
	if 名称 ~= nil then
		self.介绍文本:清空()
		if 描述 ~= nil then
			self.介绍文本:添加文本("#R/"..名称.."#L/".." 等级: "..内容.."/3#Y(右键升级)")
			self.介绍文本:添加文本("#L/".."实际效果(饱食度影响): "..bb.忠诚.."%")
			self.介绍文本:添加文本("#L/".."当前等级: ".."#H/"..描述)
		end
		for i=1,#self.介绍文本.显示表 - 13 do
			self.介绍文本:滚动(1)
		end
		self.资源组[17]:置起始点(0)
		self.介绍加入 = 0
	end
end

function 场景类_坐骑技能栏:刷新技能(b,编号)
	bb = b
	self.编号 = 编号
	for i=1,5 do
   		local 临时技能=tp._技能.创建()
    	临时技能:置对象(bb.技能[i],2)
	    self.技能[i]:置技能(临时技能)
	end
	for i=1,#bb.技能 do
		if bb.技能等级 ~= nil and bb.技能等级[i] ~= nil then
			self.技能等级[i] = bb.技能等级[i]
		else
			self.技能等级[i] = 0
		end
	end
end

function 场景类_坐骑技能栏:显示(dt,x,y)
	self.焦点 = false
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y,self.状态 ~= 1)
	self.资源组[4]:更新(x,y,self.状态 ~= 2)
	self.资源组[5]:更新(x,y,self.状态 ~= 3)
	self.资源组[7]:更新(x,y,self.状态 ~= 4)
	self.资源组[8]:更新(x,y,self.状态 ~= 5)
	self.资源组[9]:更新(x,y,self.状态 ~= 6)
	self.资源组[11]:更新(x,y,self.介绍加入 > 0)
	self.资源组[12]:更新(x,y,self.介绍加入 < #self.介绍文本.显示表 - 13)
	self.资源组[18]:更新(x,y,bb ~= nil)
	if self.资源组[2]:事件判断() then
		self:打开()
		if tp.窗口.坐骑资质栏.可视 then
			tp.窗口.坐骑资质栏:打开()
		end
		return false
	elseif self.资源组[3]:事件判断() then
		self.状态 = 1
	elseif self.资源组[4]:事件判断() then
		self.状态 = 2
	elseif self.资源组[5]:事件判断() then
		self.状态 = 3
	elseif self.资源组[7]:事件判断() then
		self.状态 = 4
	elseif self.资源组[8]:事件判断() then
		self.状态 = 5
	elseif self.资源组[9]:事件判断() then
		self.状态 = 6
	elseif self.资源组[11]:事件判断() then
		self.资源组[17]:置起始点(self.资源组[17]:取百分比转换(self.介绍加入-1,13,#self.介绍文本.显示表))
	elseif self.资源组[12]:事件判断() then
		self.资源组[17]:置起始点(self.资源组[17]:取百分比转换(self.介绍加入+1,13,#self.介绍文本.显示表))
	elseif self.资源组[18]:事件判断() then
		tp.窗口.坐骑资质栏:打开(bb)
		tp.窗口.坐骑资质栏.x = self.x + 315
		tp.窗口.坐骑资质栏.y = self.y
	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[16]:显示(self.x+8,self.y+64)
	self.资源组[14]:显示(self.x+2,self.y+2)
    tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	zts1:置字间距(3)
	zts1:显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"坐骑技能")
	zts1:置字间距(2)
	zts1:显示(self.x+23,self.y+29+5,"可用技能点")
	self.资源组[15]:显示(self.x+104,self.y+27+5)
	zts:置颜色(-16777216)
	zts:显示(self.x+110,self.y+29+5,bb.技能点)
	self.资源组[18]:显示(self.x+230,self.y+29,true)
	zts1:置颜色(4294967295)
	zts1:置字间距(0)
	self.资源组[2]:显示(self.x+294,self.y+2)
	if self.状态 == 1 then
	    self.资源组[3]:显示(self.x+18,self.y+68,true,nil,nil,self.状态 == 1,2)
	else
		self.资源组[3]:显示(self.x+18,self.y+70,true,nil,nil,self.状态 == 1,2)
	end
	if self.状态 == 2 then
	    self.资源组[4]:显示(self.x+70-5,self.y+68,true,nil,nil,self.状态 == 2,2)
	else
		self.资源组[4]:显示(self.x+70-5,self.y+70,true,nil,nil,self.状态 == 2,2)
	end
	if self.状态 == 3 then
	    self.资源组[5]:显示(self.x+122-10,self.y+68,true,nil,nil,self.状态 == 3,2)
	else
		self.资源组[5]:显示(self.x+122-10,self.y+70,true,nil,nil,self.状态 == 3,2)
	end
	if self.状态 == 4 then
	    self.资源组[7]:显示(self.x+174-15,self.y+68,true,nil,nil,self.状态 == 4,2)
	else
		self.资源组[7]:显示(self.x+174-15,self.y+70,true,nil,nil,self.状态 == 4,2)
	end
	if self.状态 == 5 then
	    self.资源组[8]:显示(self.x+226-20,self.y+68,true,nil,nil,self.状态 == 5,2)
	else
		self.资源组[8]:显示(self.x+226-20,self.y+70,true,nil,nil,self.状态 == 5,2)
	end
	if self.状态 == 6 then
	    self.资源组[9]:显示(self.x+278-25,self.y+68,true,nil,nil,self.状态 == 6,2)
	else
		self.资源组[9]:显示(self.x+278-25,self.y+70,true,nil,nil,self.状态 == 6,2)
	end
	self.资源组[10]:显示(self.x+20,self.y+220)
	tp.画线:置区域(0,0,15,175)--滑块虚线
	tp.画线:显示(self.x+20+282-14,self.y+220+18)
	self.资源组[11]:显示(self.x+20+282-18,self.y+220)
	self.资源组[12]:显示(self.x+20+282-18,self.y+220+210-18)
	local xx = 0
	local yy = 0
	local xxi = 0
	local yyi = 0
	local yyii = 0
	if self.状态 == 1 then
		for i=1,5 do
			yyi=yyi*xxi
			yyii = yyii+1
			local jx = self.x+20+yyi+(xx*41)
			local jy = self.y+100+(yy*41)
			if yyii>4 then
			    jy = self.y+100+20+(yy*41)
			end
			self.资源组[6]:显示(jx,jy)
		    self.技能[i]:置坐标(jx+3,jy+2)
	   	    self.技能[i]:显示(x,y,self.鼠标)
	   	    if self.技能[i].焦点 and self.技能[i].技能 ~= nil then
	   	    	tp.窗口.坐骑技能栏:修改内容(self.技能[i].技能.名称,self.技能等级[i] or 0,self.技能[i].技能.介绍,bb)-- tp.提示:技能(x,y,self.技能[i].技能)
	   	    	if mouseb(1) then
	   	    		if bb.技能点 > 0 then
	   	    			请求服务(98,{编号=self.编号,技能编号=i,名称=self.技能[i].技能.名称})
	   	    		else
	   	    			tp.常规提示:打开("#Y/你没有足够的技能点！")
	   	    			return
	   	    		end
	   	    	end
	   	    end
			xx = xx + 1
			xxi=xxi+1
			if xxi == 4 then
				yyi=0
				xxi=0
			end
			yyi=35
			if xx > 3 then
				xx = 0
				yy = yy + 1
			end
		end
	end
	self.介绍文本:显示(self.x+22,self.y+226)
		if #self.介绍文本.显示表 > 13 then
			self.介绍加入 = min(ceil((#self.介绍文本.显示表-13)*self.资源组[17]:取百分比()),#self.介绍文本.显示表-13)
			self.介绍文本.加入 = self.介绍加入
			self.资源组[17]:显示(self.x+22,self.y+222,x,y,self.鼠标)
		end
	if self.资源组[17].接触 then
		self.焦点 = true
	end
end

function 场景类_坐骑技能栏:检查点(x,y)
	if self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_坐骑技能栏:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if self.鼠标 and not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_坐骑技能栏:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_坐骑技能栏