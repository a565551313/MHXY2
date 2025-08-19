
local 攻略查看 = class()
local floor = math.floor
local ceil = math.ceil
local tp,zts,zts1
local insert = table.insert
local format = string.format


function 攻略查看:初始化(根)
	self.ID = 68
	self.x = 170
	self.y = 50
	self.xx = 0
	self.yy = 0
	self.注释 = "攻略查看"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	local 资源 = 根.资源
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	local 小型选项栏 = 根._小型选项栏
	local 滑块 = 根._滑块
	tp = 根
	self.资源组 = {
		[1] = 自适应.创建(0,1,300,455,3,9),
		[2] = 自适应.创建(1,1,296,18,1,3,nil,18),
		[3] = 自适应.创建(5,1,280,420,3,9),
		[4] = 按钮.创建(自适应.创建(18,4,16,16,4,1),0,0,4,true,true),
	}

	zts = tp.字体表.普通字体
	zts1 = tp.字体表.描边字体
	self.窗口时间 = 0
	self.丰富文本说明 = 根._丰富文本(250,345)
	self.丰富文本说明1 = 根._丰富文本(230,345)
	self.标题文字 ="攻略查看"



end





function 攻略查看:打开(数据)
	if self.可视 then
		self.分类 = nil
		self.可视 = false

	else
		insert(tp.窗口_,self)
		self.分类 = 1
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
		self.丰富文本说明:清空()
		self.丰富文本说明1:清空()
		self.标题文字 = 数据.标题文字
		self.丰富文本说明:置默认颜色(黑色)
		self.丰富文本说明:添加文本(数据.文本)
		self.丰富文本说明.滚动值 = self.丰富文本说明.行数量
		self.丰富文本说明:滚动(-21)
		self.丰富文本说明1:置默认颜色(黑色)
		self.丰富文本说明1:添加文本("#23#23#23#23#23#23#23#23#23#23#23")


	end
end




function 攻略查看:显示(dt,x,y)
	self.焦点 = false
	self.资源组[4]:更新(x,y)
    if self.资源组[4]:事件判断() then
		self:打开()
	end
	self.资源组[1]:显示(self.x,self.y)

   self.资源组[2]:显示(self.x+2,self.y+2)
   self.资源组[3]:显示(self.x+10,self.y+25)

	zts1:置字间距(3)
	zts1:置颜色(白色):显示(self.x+15,self.y+5,self.标题文字)
	zts1:置字间距(0)
	self.资源组[4]:显示(self.x+280,self.y+2)

	if 引擎.取鼠标滚轮() >0 then--鼠标上滚动
		   if self.丰富文本说明.滚动值 < #self.丰富文本说明.显示表 -21 then
				self.丰富文本说明:滚动(1)
			end
		elseif 引擎.取鼠标滚轮() <0  then--鼠标下滚动
		if self.丰富文本说明.滚动值 > 0 then
		   self.丰富文本说明:滚动(-1)
		end
	end
    self.丰富文本说明1:显示(self.x+40,self.y+35)
	self.丰富文本说明:显示(self.x+25,self.y+75)


end

function 攻略查看:检查点(x,y)
	if self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 攻略查看:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not 引擎.消息栏焦点 then
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
function 攻略查看:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end
return 攻略查看