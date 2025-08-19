--======================================================================--

--======================================================================--
local 系统类_功德录 = class()
local floor = math.floor
local tp,zts,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10
local format = string.format
local insert = table.insert
local tx = 引擎.取头像
local floor = math.floor
local min = math.min
 local 基础={
        气血={a=98,b=600},
        伤害={a=14,b=180},
        防御={a=14,b=180},
        速度={a=20,b=60},
        穿刺等级={a=22,b=32},
        治疗能力={a=20,b=60},
        固定伤害={a=14,b=180},
        法术伤害={a=14,b=180},
        法术防御={a=14,b=180},
        气血回复效果={a=20,b=60},
        封印命中等级={a=20,b=60},
        抵抗封印等级={a=22,b=32},
        法术暴击等级={a=20,b=60},
        物理暴击等级={a=20,b=60},
        抗法术暴击等级={a=22,b=32},
        抗物理暴击等级={a=22,b=32},

      }
function 系统类_功德录:初始化(根)
	self.ID = 73
	self.x = 170
	self.y = 95
	self.xx = 0
	self.yy = 0
	self.注释 = "功德录"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	tp = 根
	self.窗口时间 = 0
	zts = tp.字体表.普通字体
	a1 = 0
    a2 = 0
    a3 = 0
    a4 = 0
    a5 = 0
    a6 = 0
    a7 = 0
    a8 = 0
    a9 = 0
    a10 = 0

end
function 系统类_功德录:打开(内容)
	if self.可视 then
		self.可视 = false
		self.资源组 = nil
		self.数据=nil
		return
	else
		self.数据=内容
		insert(tp.窗口_,self)
		self:加载资源()
	    tp.运行时间 = tp.运行时间 + 1
	  	self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.九珠条数=0
     -- table.print(self.数据)
	end
end
function 系统类_功德录:加载资源()

		local 资源 = tp.资源
		local 按钮 = tp._按钮
		local 自适应 = tp._自适应

		self.资源组 = {
		[1] = 自适应.创建(0,1,296,404,3,9),
        [2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
        [3] = 资源:载入('房屋图标.wdf',"网易WDF动画",0X10000058),
        [4] = 自适应.创建(2,1,279,256,3,9),
        [5] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"洗练"),
        [6] = 资源:载入(wdf配置.."/pic/界面/功德长条.png", "图片"),
        [7] =  资源:载入('房屋图标.wdf',"网易WDF动画",0x10000095),
        [8] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x11F8B522),0,0,1,true,true),
        [9] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x11F8B522),0,0,1,true,true),
        [10] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x11F8B522),0,0,1,true,true),
        [11] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x11F8B522),0,0,1,true,true),
        [12] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x11F8B522),0,0,1,true,true),
        [13] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x11F8B522),0,0,1,true,true),
        [14] = 自适应.创建(1,1,291,18,1,3,nil,18),

		}
		self.资源组[8]:置打勾框(false)
		self.资源组[9]:置打勾框(false)
		self.资源组[10]:置打勾框(false)
		self.资源组[11]:置打勾框(false)
		self.资源组[12]:置打勾框(false)
		self.资源组[13]:置打勾框(false)
		self.九珠条数=0
end

function 系统类_功德录:刷新(内容)
	self.数据=内容
end

function 系统类_功德录:显示(dt,x,y)
	  self.焦点 = false
    for n = 8,13 do
	  self.资源组[n]:更新(x,y)
	end

   self.资源组[2]:更新(x,y)
   self.资源组[5]:更新(x,y)

self.资源组[1]:显示(self.x,self.y)
self.资源组[14]:显示(self.x+2,self.y+2)
tp.窗口标题背景_[3]:显示(self.x+self.资源组[1].宽度/2-45,self.y)
zts:置颜色(白色):显示(self.x+self.资源组[1].宽度/2-15,self.y+3,"功德录")
self.资源组[2]:显示(self.x+278,self.y+4)
self.资源组[3]:显示(self.x+20,self.y+35)
self.资源组[4]:显示(self.x+10,self.y+140)
self.资源组[5]:显示(self.x+128,self.y+365)
zts:置颜色(白色):显示(self.x+145,self.y+39,"草堂名刹岁丰深")
zts:置颜色(白色):显示(self.x+145,self.y+61,"三藏谈经事莫寻")
zts:置颜色(白色):显示(self.x+145,self.y+83,"三藏谈经事莫寻")
zts:置颜色(白色):显示(self.x+145,self.y+105,"风来犹作海潮音")

	if self.资源组[8]:事件判断() then
		if a1 == 0 then
			self.资源组[8]:置打勾框(true)
			a1 = 1
		elseif a1 == 1 then
			a1 = 0
			self.资源组[8]:置打勾框(false)
		end
	elseif self.资源组[9]:事件判断() then
		if a2 == 0 then
			self.资源组[9]:置打勾框(true)
			a2 = 1
		elseif a2 == 1 then
			a2 = 0
			self.资源组[9]:置打勾框(false)
		end
	elseif self.资源组[10]:事件判断() then
		if a3 == 0 then
			self.资源组[10]:置打勾框(true)
			a3 = 1
		elseif a3 == 1 then
			a3 = 0
			self.资源组[10]:置打勾框(false)
	    end
	elseif self.资源组[11]:事件判断() then
		if a4 == 0 then
			self.资源组[11]:置打勾框(true)
			a4 = 1
		elseif a4 == 1 then
			a4 = 0
			self.资源组[11]:置打勾框(false)
		end
	elseif self.资源组[12]:事件判断() then
		if a5 == 0 then
			self.资源组[12]:置打勾框(true)
			a5 = 1
		elseif a5 == 1 then
			a5 = 0
			self.资源组[12]:置打勾框(false)
		end
	elseif self.资源组[13]:事件判断() then
		if a6 == 0 then
			self.资源组[13]:置打勾框(true)
			a6 = 1
		elseif a6 == 1 then
			a6 = 0
			self.资源组[13]:置打勾框(false)
	    end
	end

	if a1 == 1 then
	   self.资源组[8]:置打勾框(true)
	end
	if a2 == 1 then
	   self.资源组[9]:置打勾框(true)
	end
	if a3 == 1 then
	   self.资源组[10]:置打勾框(true)
	end
	if a4 == 1 then
	   self.资源组[11]:置打勾框(true)
	end
	if a5 == 1 then
	   self.资源组[12]:置打勾框(true)
	end
	if a6 == 1 then
	   self.资源组[13]:置打勾框(true)
	end
	local 当前数量 = a1+a2+a3+a4+a5+a6
	local 当前需求 = 3
	if 当前数量 == 1 then
         当前需求 = 6
	elseif 当前数量 == 2 then
	         当前需求 = 12
	elseif 当前数量 == 3 then
	         当前需求 = 24
	elseif 当前数量 == 4 then
	         当前需求 = 48
	elseif 当前数量 == 5 then
	         当前需求 = 96
	elseif 当前数量 == 6 then
	         当前需求 = 192
	end
	zts:置颜色(蓝色):显示(self.x+10+math.floor((290-zts:取宽度("当前需求功德残卷:"..当前需求))/2),self.y+150,"当前需求功德残卷:"..当前需求)
	for n=1,#self.数据.九珠副 do
		self.资源组[n+7]:显示(self.x+240,self.y+145+n*30)
		self.资源组[6]:显示(self.x+110,self.y+145+n*30)
		self.资源组[7]:置区域(0,0,min(floor(self.数据.九珠副[n].数值 /基础[self.数据.九珠副[n].类型].b *119),119),21)
	    self.资源组[7]:显示(self.x+112,self.y+147+n*30)
	    self.九珠条数=self.九珠条数+1
		--zts999:置颜色(黑色):显示(self.x+23,self.y+140+n*30,self.数据.九珠副[n].类型)
		zts:置颜色(黑色):显示((self.x + 10 - zts:置颜色(黑色):取宽度(self.数据.九珠副[n].类型)/1)+100,self.y+150+n*30,self.数据.九珠副[n].类型)
		zts:置颜色(白色):显示(self.x+144,self.y+150+n*30,self.数据.九珠副[n].数值.."/"..基础[self.数据.九珠副[n].类型].b)--这个怎么读基础数值B的
		--还有一个东西呢 别急 你没注意到 稍等一下 我这边回个消息  嗯好
    end





   -- self.资源组[6]:显示(self.x+150,self.y+135+n*30)
   -- self.资源组[7]:置区域(0,0,min(floor(self.数据.九珠1[n].数值 / self:取封顶数值() * 112),112),21)
   -- self.资源组[7]:显示(self.x+152,self.y+136+n*30)
	--zts999:置颜色(黑色):显示((200- zts999:置颜色(黑色):取宽度(self.数据.九珠1[n].类型)/1)+3,self.y+140+n*30,self.数据.九珠1[n].类型)
	--zts999:置颜色(白色):显示((200- zts999:置颜色(白色):取宽度(self.数据.九珠1[n].数值)/2)+70,self.y+140+n*30,self.数据.九珠1[n].数值.."/0")
	--end
	if self.资源组[5]:事件判断() then
	  --请求服务(919)
	  请求服务(103,{锁定数据={[1]=a1,[2]=a2,[3]=a3,[4]=a4,[5]=a5,[6]=a6}})
	end



if self.资源组[2]:事件判断() then
self:打开()
return false
end

end

function 系统类_功德录:检查点(x,y)
	if self.可视 and self.资源组[1] ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end
function 系统类_功德录:初始移动(x,y)
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

function 系统类_功德录:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 系统类_功德录