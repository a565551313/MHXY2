-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2022-10-15 17:58:33
-- @最后修改来自: baidwwy
-- @Last Modified time: 2025-01-23 22:02:34
local 铃铛界面 = class()
local tp
local zts1,zts
local bwh = require("gge包围盒")
local bw = bwh(0,0,52,52)
local bw1 = bwh(0,0,311,161)
local wz = require("gge文字类")
local mousea = 引擎.鼠标弹起

function 铃铛界面:初始化(根)
   	local 资源 = 根.资源
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	tp = 根
	self.ID = 108
	self.x = 90+(全局游戏宽度-800)/2
	self.y = 200
	self.xx = 0
	self.yy = 0
	self.注释 = "铃铛界面"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口时间 = 0
	self.页数=0
	self.模式=0
	self.选中=0
	zts =tp.字体表.描边字体
	zts1 = tp.字体表.描边字体
	self.资源组 = {
		[1]=资源:载入('铃铛界面.wdf',"网易WDF动画",0x00000001),
		[2]=按钮.创建(自适应.创建(13,4,43,21,1,3),0,0,4,true,true,"炼化"),
		[3]=按钮.创建(自适应.创建(13,4,26,21,1,3),0,0,4,true,true,"1"),
		[4]=按钮.创建(自适应.创建(13,4,26,21,1,3),0,0,4,true,true,"2"),
		[5]=按钮.创建(自适应.创建(13,4,26,21,1,3),0,0,4,true,true,"3"),
		[6]=按钮.创建(自适应.创建(13,4,26,21,1,3),0,0,4,true,true,"4"),
		[7]=按钮.创建(自适应.创建(13,4,26,21,1,3),0,0,4,true,true,"5"),
		[8]=按钮.创建(自适应.创建(13,4,43,21,1,3),0,0,4,true,true,"领取"),
		[21] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x22D22D6D),
		[20] = tp.物品格子背景_,
     }
	self.物品 = {}
	self.坐标 = {}
	local 格子 = 根._物品格子
 	for i=1,60 do
		self.物品[i] = 格子(0,0,i,"道具小窗口")
	end
	self.类型 = 0
    self.开始 = 0
	self.中奖 = 0
	self.抽奖中 = 0
end

function 铃铛界面:打开(数据)
	if self.可视 then
		self.可视=false
		self.类型 = 0
		self.开始 = 0
		self.页数 = 0
		self.中奖 = 0
		self.选中 = 0
		self.抽奖中 = 0
	else
		table.insert(tp.窗口_,self)
	    self.数据 = 数据
		self.铃铛 = 数据.物品id
		self.铃铛个数 = 数据.铃铛个数 + 0
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	    self.可视=true
        for i=1,60 do
			self.物品[i]:置物品(self.数据.奖励数据[i])
		end
	end
end

function 铃铛界面:刷新(数据)
    self.数据 = 数据
	for i=1,60 do
		self.物品[i]:置物品(self.数据.奖励数据[i])
	end
	self.铃铛 = 数据.物品id
	self.铃铛个数 = 数据.铃铛个数 + 0
	self.开始 = 1
	self.中奖 = math.random(12)*-52
	self.抽奖中 = 0
end

function 铃铛界面:显示(dt,x,y)
	self.焦点=false
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y,self.类型+2~=3)
	self.资源组[4]:更新(x,y,self.类型+2~=4)
	self.资源组[5]:更新(x,y,self.类型+2~=5)
	self.资源组[6]:更新(x,y,self.类型+2~=6)
	self.资源组[7]:更新(x,y,self.类型+2~=7)
	self.资源组[8]:更新(x,y)
	self.资源组[21]:更新(dt)
	self.资源组[20]:显示(self.x+10,self.y+65)
	self.资源组[20]:显示(self.x+69,self.y+65)
	self.资源组[20]:显示(self.x+128,self.y+65)
	self.资源组[20]:显示(self.x+187,self.y+65)
	self.资源组[20]:显示(self.x+246,self.y+65)
	bw1:置坐标(self.x,self.y)
	if self.资源组[2]:事件判断() then
		if self.类型 ~= 0 then
			if self.中奖 == 0 then
				if self.抽奖中 == 0 then
					self.抽奖中 = 1
					请求服务(3810,{铃铛=self.铃铛,编号=13,内容=1,类型=self.类型})
				else
					tp.常规提示:打开("#Y/请重新使用铃铛进行炼化!")
				end
			else
				tp.常规提示:打开("#Y/领取奖励后继续!")
			end
		else
			tp.常规提示:打开("#Y/请选择需要炼化的个数!")
		end
	elseif self.资源组[3]:事件判断() then
		if self.铃铛个数 < 1 then
			tp.常规提示:打开("#Y/当前铃铛不足!")
		else
			if self.中奖 == 0 then
				self.类型 = 1
			else
				tp.常规提示:打开("#Y/领取奖励后继续!")
			end
		end
	elseif self.资源组[4]:事件判断() then
		if self.铃铛个数 < 2 then
			tp.常规提示:打开("#Y/当前铃铛不足!")
		else
			if self.中奖 == 0 then
				self.类型 = 2
			else
				tp.常规提示:打开("#Y/领取奖励后继续!")
			end
		end
	elseif self.资源组[5]:事件判断() then
		if self.铃铛个数 < 3 then
			tp.常规提示:打开("#Y/当前铃铛不足!")
		else
			if self.中奖 == 0 then
				self.类型 = 3
			else
				tp.常规提示:打开("#Y/领取奖励后继续!")
			end
		end
	elseif self.资源组[6]:事件判断() then
		if self.铃铛个数 < 4 then
			tp.常规提示:打开("#Y/当前铃铛不足!")
		else
			if self.中奖 == 0 then
				self.类型 = 4
			else
				tp.常规提示:打开("#Y/领取奖励后继续!")
			end
		end
	elseif self.资源组[7]:事件判断() then
		if self.铃铛个数 < 5 then
			tp.常规提示:打开("#Y/当前铃铛不足!")
		else
			if self.中奖 == 0 then
				self.类型 = 5
			else
				tp.常规提示:打开("#Y/领取奖励后继续!")
			end
		end
	elseif self.资源组[8]:事件判断() then
		if self.中奖 ~= 0 and self.选中~=0 then
			请求服务(3811,{铃铛=self.铃铛,编号=13,选中=self.选中,类型=self.类型})
			self.开始 = 0
			self.中奖 = 0
			self.页数 = 0
			self.选中 = 0
			self.类型 = 0
		else
			tp.常规提示:打开("#Y/请选择奖励或摇奖后领取!")
		end
	end
	if self.开始 ~= 0 then
		if self.中奖 == self.页数 then

		else
			self.页数 = self.页数 - 1
		end
		if self.页数 == -624*(6-self.类型)-1 then
			self.页数 = 0
		end

		local xx = 0
		local yy = 0
		for i=1,60 do
			local jx = xx * 59 + 10
			local jy = 65 + 52 + yy * 52 + self.页数
			if jy >= 0 and jy < 116 then
			    bw:置坐标(self.x+jx,self.y+jy)
			  	local xz = bw:检查点(x,y)
				self.物品[i]:置坐标(self.x + jx+1,self.y + jy-3)
				self.物品[i]:显示(dt,x,y,self.鼠标)
				if i == self.选中 then
			  		self.资源组[21]:显示(self.x+jx-2,self.y+jy-3)
			  	end
			  	if  self:检查点1(x,y) and xz and self.物品[i].物品 ~= nil then
					tp.提示:道具行囊(x,y,self.物品[i].物品)
					if mousea(0) and self.中奖 == self.页数 then
						self.选中 = i
					end
				end
			end
			xx = xx + 1
			if xx == self.类型 then
				xx = 0
				yy = yy + 1
			end
		end
	end
	self.资源组[1]:显示(self.x,self.y)
	zts1:置颜色(0xFFFFFFFF):显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"铃铛界面")
	zts1:显示(self.x+10,self.y+34,"炼化个数")
	self.资源组[2]:显示(self.x+250,self.y+33)
	self.资源组[3]:显示(self.x+80,self.y+33)
	self.资源组[4]:显示(self.x+110,self.y+33)
	self.资源组[5]:显示(self.x+140,self.y+33)
	self.资源组[6]:显示(self.x+170,self.y+33)
	self.资源组[7]:显示(self.x+200,self.y+33)
	self.资源组[8]:显示(self.x+250,self.y+128)
end

function 铃铛界面:初始移动(x,y)
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

function 铃铛界面:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy


	end
end

function 铃铛界面:检查点(x,y)
	if  self.资源组[1]:是否选中(x,y) or bw1:检查点(x,y)  then
		return true
	end
end

function 铃铛界面:检查点1(x,y)
	if  self.资源组[1]:是否选中(x,y)  then
		return false
		else
		return true
	end
end

return 铃铛界面