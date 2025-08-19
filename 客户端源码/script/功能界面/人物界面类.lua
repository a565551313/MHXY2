
local 人物界面 = class()
local 按钮组 = {'给予',"组队","好友","团队","观察","交易","装备","攻击","信息","临时",}
function 人物界面:初始化(根)
	self.ID = 105
	self.可视 = false
	self.可移动 = true
	tp = 根
	self.窗口时间 = 0
	self.鼠标 = false
	self.焦点 = false
	self.x = 380
	self.y = 80
	self.xx = 0
	self.yy = 0

end
function 人物界面:打开(数据)
	if self.可视 then
		self.可视 = false
		self.资源组 = nil
		return
	else
		table.insert(tp.窗口_,self)
		local 资源 = tp.资源
		local 按钮 = tp._按钮
		local 自适应 = tp._自适应
		self.资源组 = {
			[1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x770F5F96), --介绍
			[2] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xA0D00989), --按钮背景
		}
		for i=1,10 do
			self.资源组[i+2] = 按钮.创建(tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x91D4E204),0,0,4,true,true)
			self.资源组[i+2]:置偏移(-4,0)
		end

		self.玩家名称 = 数据[1]
		self.玩家id = 数据[2]
		self.玩家门派 = 数据[3]
		self.模型 = 数据[4]
		local s = 引擎.取头像(self.模型)
		self.资源组[13] = tp.资源:载入(s[7],"网易WDF动画",s[2])
		tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end


function 人物界面:检查点(x,y)
	if self.资源组 ~= nil and (self.资源组[1]:是否选中(x,y) or self.资源组[2]:是否选中(x,y)  or self.资源组[13]:是否选中(x,y))  then
		return true
	end
end

function 人物界面:显示(dt,x,y)
	for i=1,10 do
	    self.资源组[i+2]:更新(x,y)

	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[2]:显示(self.x,self.y+50)
	tp.人物头像背景_:显示(self.x-50,self.y-3)
	self.资源组[13]:显示(self.x-47,self.y)
	tp.字体表.普通字体__:置颜色(黄色)
	tp.字体表.普通字体__:显示(self.x+8,self.y+2,self.玩家名称)
	tp.字体表.普通字体__:显示(self.x+8,self.y+20,self.玩家id)
	tp.字体表.普通字体__:显示(self.x+8,self.y+36,self.玩家门派 or "无门派")

	local xxx,yyy = 0,0
	for i=1,10 do
		if yyy >= 5 then
			yyy = 0
			xxx = 1
		end

	    self.资源组[i+2]:显示(self.x+8+xxx*50,self.y+55+yyy*25,nil,2)
	    tp.字体表.普通字体__:置颜色(黑色):显示(self.x+13+xxx*50,self.y+60+yyy*25,按钮组[i])
	    yyy = yyy + 1
	end
	tp.字体表.普通字体__:置颜色(白色)

	if self.资源组[3]:事件判断() then --给予
		if self.玩家id > 99999 then
			tp.常规提示:打开("#Y对不起!对方不允给予!")
			   return
		end
		人物点击=true
		请求服务(3716,{id=self.玩家id})
	elseif self.资源组[4]:事件判断() then --组队
		if self.玩家id > 99999 then
			tp.常规提示:打开("#Y对不起!对方不允组队!")
			   return
		end
		人物点击=true
		--请求服务(4002,{id=self.玩家id})

		if tp.场景.玩家[self.玩家id].队长开关 then --有队伍的情况
				请求服务(4002,{id=self.玩家id})
		else
				请求服务(4014,{id=self.玩家id})
		end
	elseif self.资源组[5]:事件判断() then
		请求服务(19,{名称=self.玩家名称,id=self.玩家id,类型=1})
	elseif self.资源组[6]:事件判断() then



	elseif self.资源组[7]:事件判断() then
		if self.玩家id > 99999 then
			tp.常规提示:打开("#Y对不起!对方不允许查看装备!")
			   return
		end
    	请求服务(9000,{id=self.玩家id},1)

	elseif self.资源组[8]:事件判断() then --交易类
		if self.玩家id > 99999 then
			tp.常规提示:打开("#Y对不起!对方不允交易!")
			   return
		end
		人物点击=true
		请求服务(3718,{id=self.玩家id})
	elseif self.资源组[9]:事件判断() then
		  if self.玩家id > 99999 then
			tp.常规提示:打开("#Y对不起!对方不允许查看装备!")
			   return
		end
    	请求服务(9000,{id=self.玩家id},1)



	elseif self.资源组[10]:事件判断() then
		人物点击=true
		请求服务(33,{序列=self.玩家id})
	elseif self.资源组[11]:事件判断() then



	elseif self.资源组[12]:事件判断() then
		请求服务(18,{名称=self.玩家名称,id=self.玩家id,类型=1})

	end
end

function 人物界面:初始移动(x,y)
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

function 人物界面:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

function 人物界面:更新(dt)end
return 人物界面