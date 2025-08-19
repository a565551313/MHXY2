local 自动抓鬼 = class()

local floor = math.floor
local min = math.min
local tp,zts1,zts2
local xxx = 0
local yyy = 0
local max = 1
local insert = table.insert
local mouseb = 引擎.鼠标弹起
local wz = require("gge文字类")

function 自动抓鬼:初始化(根)
	self.ID = 109
	--宽高 549 431
	self.文字类=wz
	self.x = 160
	self.y = 5
	self.xx = 0
	self.yy = 0
	self.注释 = "自动抓鬼"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.状态 = 1
	self.窗口时间 = 0
	tp = 根
	zts2 = tp.字体表.标题字体
	self.分类选中=""
	self.子类选中=""
	self.玩法介绍内容=""
	self.丰富文本说明 = 根._丰富文本(476,265)
	self.切换  = 0
	self.事件 = "自动抓鬼"
end

function 自动抓鬼:打开(数据)

	if self.可视 then
		self.可视 = false
		self.资源组 = nil
		return
	else
		insert(tp.窗口_,self)
		local 资源 = tp.资源
		local 自适应 = tp._自适应
		local 按钮 = tp._按钮
		self.资源组 = {
			    --[4] = 按钮.创建(根.资源:载入('nfsc.wdf',"网易WDF动画",0x00000005),0,0,4),

			[1] = 自适应.创建(0,1,200,100,3,9),

			[2] = 按钮.创建(自适应.创建(12,4,48,20,1,3),0,0,4,true,true,"关闭"),
			[3] = 自适应.创建(1,1,196,18,1,3,nil,18),--标题背景


			}
			self.底图背景 =  自适应.创建(4,1,190,65,3,nil)


		self.状态 = 1
		self.加入 = 0
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
		self.进程 = 数据.进程
		self.仙玉 = 数额尾数转换(数据.仙玉+0)
		self.事件 = 数据.事件
		self.头像显示={}
		local 临时资源 = 引擎.取头像("僵尸")
        self.头像显示.小动画 = tp.资源:载入(临时资源[7],"网易WDF动画",临时资源[2])
        local n = 引擎.取战斗模型("僵尸")
	    self.头像显示.大动画= tp.资源:载入(n[10],"网易WDF动画",n[6])
	    self.头像显示.名称="自动抓鬼"
		self.头像显示.介绍="#Y/剩余抓鬼次数:"..self.仙玉
		self.宝石字体= tp.字体表.描边字体__
	    self.宝石字体:置颜色(0xFFFFFFFF)
	    self.宝石字体:置描边颜色(0xfff741940)--xFFaf140c)
	    self.物品背景 = 资源:载入(wdf配置.."/pic/打造方格.png", "图片")
	end
end
function 自动抓鬼:刷新(数据)
		self.进程 = 数据.进程
		self.仙玉 = 数额尾数转换(数据.仙玉+0)
		self.事件 = 数据.事件
		self.头像显示.介绍="#Y/剩余抓鬼次数:"..self.仙玉
end

function 自动抓鬼:显示(dt,x,y)
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
    self.资源组[3]:显示(self.x+2,self.y+2)
	zts2:置字间距(2)
	zts2:置颜色(白色)
	zts2:显示(self.x+70,self.y+2,self.事件)
	zts2:置字间距(0)
	self.底图背景:显示(self.x+5,self.y+30)
	self.资源组[2]:显示(self.x+140,self.y+50)
	self.资源组[2]:更新(x,y)
	if self.资源组[2]:事件判断() then
		self.可视 = false
		请求服务(42)
	end
    zts2:置颜色(黑色):显示(self.x+5,self.y+55,"剩余次数:")
    zts2:置颜色(白色)
	--字体:显示(self.x+10,self.y+50,"当前自动抓鬼次数："..self.仙玉)
	if self.头像显示~=nil  and self.头像显示.小动画~=nil then
		    self.物品背景:显示(self.x+80,self.y+35)
	        self.头像显示.小动画:显示(self.x+83,self.y+38)
	        if type(self.仙玉) == "string" then
	          self.宝石字体:显示(self.x+88,self.y+35+33,self.仙玉)
	        else
	          self.宝石字体:显示(self.x+90,self.y+35+33,self.仙玉)
	        end
	        if self.头像显示.小动画:是否选中(x,y) then
	            tp.提示:商城提示(x,y,self.头像显示.名称,self.头像显示.介绍,self.头像显示.大动画,nil,true)
	        end
    end
	if self.进程 == "关闭"  then
		self.可视 = false
		--请求服务(42)
	end
end












function 自动抓鬼:检查点(x,y)
	if self.资源组[1] ~= nil and  self.资源组[1]:是否选中(x,y) then
		return true
	end
end

function 自动抓鬼:初始移动(x,y)
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

function 自动抓鬼:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 自动抓鬼