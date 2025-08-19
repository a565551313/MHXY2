--======================================================================--

--======================================================================--
local 系统类_传音飞鸽 = class()
local floor = math.floor
local tp,zts,zt
local format = string.format
local insert = table.insert


function 系统类_传音飞鸽:初始化(根)
	self.ID = 101
	self.x = 68
	self.y = 95
	self.xx = 0
	self.yy = 0
	self.注释 = "传音飞鸽"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	tp = 根
	self.窗口时间 = 0

     zt = tp.字体表.普通字体




end

function 系统类_传音飞鸽:打开(数据)
	if self.可视 then
		self.可视 = false
		self.资源组=nil
		return
	else



		insert(tp.窗口_,self)
		local 资源 = tp.资源
		local 按钮 = tp._按钮
		local 自适应 = tp._自适应



		self.资源组 = {
			[1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xAABBCC9A),
			[2] = 按钮.创建(tp.资源:载入('登陆资源.wdf',"网易WDF动画",0xAABBCC9B),0,0,3,true,true),





		}


		self.数据=数据
		tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.进程=1
	    self.信息=1




	end
end




function 系统类_传音飞鸽:显示(dt,x,y)
	self.焦点 = false




    self.资源组[2]:更新(x,y)


	 self.资源组[1]:显示(self.x-30-45,self.y+200+40)
	 self.资源组[2]:显示(self.x+14-45,self.y+248+40)

     zt:显示(self.x+14-35,self.y+248+43,"查看详细")
     zt:置颜色(白色)
	  if self.资源组[2]:事件判断() then

  	  请求服务(107.1)
  	end





end

function 系统类_传音飞鸽:检查点(x,y)
	if self.资源组 ~= nil and self.资源组[1]:是否选中(x,y) then
		return true
	end
end

function 系统类_传音飞鸽:初始移动(x,y)
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

function 系统类_传音飞鸽:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 系统类_传音飞鸽