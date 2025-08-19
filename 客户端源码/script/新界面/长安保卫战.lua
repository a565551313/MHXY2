--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-09-28 15:04:02
--======================================================================--
local 场景类_长安保卫战 = class()
local ceil = math.ceil
local insert = table.insert
local remove = table.remove
local floor = math.floor
local ceil = math.ceil
local min = math.min
local max = math.max
local tp,zts

function 场景类_长安保卫战:初始化(根)
	self.ID = 135
	self.x = 200
	self.y = 125
	self.xx = 0
	self.yy = 0
	self.注释 = "长安保卫战"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.介绍文本 =  根._丰富文本(295,150)


	self.介绍文本:置默认颜色(黑色)
	tp = 根
	zts = tp.字体表.排行字体
end
function 场景类_长安保卫战:打开(数据)
	if self.可视 then
		 self.介绍文本:清空()

		self.可视 = false
	else
		self.状态=1
		if self.资源组==nil then
		    self:加载资源()
		end
		self.刷怪记录=数据.刷怪记录

		self.积分=数据.积分
		self.介绍文本:清空()
        self.介绍文本:置默认颜色(黑色)
		self.介绍文本:添加文本(self.刷怪记录)
	     self.介绍文本.滚动值 = 15
		 self.介绍文本:滚动(-15)
		self.先锋=""
		self.头目=""
		self.大王=""
		for k,v in pairs(数据.先锋) do
			-- print(k,v) --地图 ， 数量
			if v>10 then
			    self.先锋=self.先锋..取地图名称(k).."、"
			end
		end
		for k,v in pairs(数据.头目) do
			-- print(k,v) --地图 ， 数量
			if v>5 then
			    self.头目=self.头目..取地图名称(k).."、"
			end
		end
		for k,v in pairs(数据.大王) do
			-- print(k,v) --地图 ， 数量
			if v>=2 then
			    self.大王=self.大王..取地图名称(k).."、"
			end
		end

		insert(tp.窗口_,self)
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
	end
end
function 场景类_长安保卫战:加载资源()
    local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 滑块 = tp._滑块
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,450,294,3,9),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[3] = 按钮.创建(自适应.创建(12,4,75,20,1,3),0,0,4,true,true,"最新战况"),
		[4] = 按钮.创建(自适应.创建(12,4,75,20,1,3),0,0,4,true,true,"个人积分"),
		[5] = 按钮.创建(自适应.创建(12,4,75,20,1,3),0,0,4,true,true,"长安功臣"),
		[6] = 按钮.创建(自适应.创建(12,4,75,20,1,3),0,0,4,true,true,"活动说明"),
		[7] = 自适应.创建(2,1,330,159,3,9),
		[8] = 自适应.创建(2,1,330,80,3,9),
		[9] = 自适应.创建(1,1,446,18,1,3,nil,18),
	}
	for i=2,6 do
		self.资源组[i]:绑定窗口_(self.ID)
	end
end


function 场景类_长安保卫战:显示(dt,x,y)
	self.焦点 = false
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y,self.状态 ~= 1)
	self.资源组[4]:更新(x,y,self.状态 ~= 2)
	self.资源组[5]:更新(x,y,self.状态 ~= 3)
	self.资源组[6]:更新(x,y,self.状态 ~= 4)
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[9]:显示(self.x+2,self.y+2)
	tp.窗口标题背景_[4]:显示(self.x-50+self.资源组[1].宽度/2,self.y+2)
	tp.字体表.标题字体:显示(self.x-20+self.资源组[1].宽度/2,self.y+2,"长安战报")
	self.资源组[2]:显示(self.x-18+self.资源组[1].宽度,self.y+2)
	self.资源组[3]:显示(self.x+17,self.y+33,nil,nil,nil,self.状态 == 1,2)
	self.资源组[4]:显示(self.x+17,self.y+70,nil,nil,nil,self.状态 == 2,2)
	self.资源组[5]:显示(self.x+17,self.y+108,nil,nil,nil,self.状态 == 3,2)
	self.资源组[6]:显示(self.x+17,self.y+145,nil,nil,nil,self.状态 == 4,2)
	self.资源组[7]:显示(self.x+102,self.y+30)
	if self.状态==1 then --战况
		self.资源组[8]:显示(self.x+102,self.y+200)

		zts:置颜色(黑色):显示(self.x+112,self.y+210,"当前剩余怪物最多的场景：\n先锋：\n头目：\n大王：")
		zts:置颜色(红色):显示(self.x+155,self.y+225,self.先锋)
		zts:置颜色(红色):显示(self.x+155,self.y+240,self.头目)
		zts:置颜色(红色):显示(self.x+155,self.y+255,self.大王)
		self.介绍文本:置文字 (tp.字体表.排行字体1)
		self.介绍文本:显示(self.x+112,self.y+40)
		if  引擎.取鼠标滚轮() >0 then--鼠标上滚动
			   if self.介绍文本.滚动值 < #self.介绍文本.显示表 -12 then
					self.介绍文本:滚动(1)
				end
		elseif  引擎.取鼠标滚轮() <0  then--鼠标下滚动
			if self.介绍文本.滚动值 > 0 then
			   self.介绍文本:滚动(-1)
			end
		end
		self.介绍文本:置文字 (tp.字体表.外部文字)
	elseif self.状态==2 then --积分
		zts:置颜色(黑色):显示(self.x+115,self.y+40,"当前你的积分为：")
		zts:置颜色(红色):显示(self.x+240,self.y+42,self.积分)
	-- elseif self.状态==2 then --说明
	end
	if self.资源组[2]:事件判断() then --关闭
        self:打开()
    elseif self.资源组[3]:事件判断() then --战况
    	self.状态 = 1
    elseif self.资源组[4]:事件判断() then --积分
    	self.状态 = 2
    end

end

function 场景类_长安保卫战:检查点(x,y)
	if self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_长安保卫战:初始移动(x,y)
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

function 场景类_长安保卫战:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_长安保卫战