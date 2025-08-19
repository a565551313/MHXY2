local 场景类_梦幻指引 = class()

local floor = math.floor
local min = math.min
local tp,zts
local insert = table.insert
local 资源,按钮







function 场景类_梦幻指引:初始化(根)
	self.ID = 70
	--宽高 549 431
	self.x = 全局游戏宽度/2-660/2
	self.y = 全局游戏高度/2-452/2
	self.xx = 0
	self.yy = 0
	self.注释 = "梦幻指引"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	资源 = 根.资源
	按钮 = 根._按钮
	self.状态 = "日常任务"
	self.开始 = 1
	self.结束 = 6
	self.显示数据={}
	self.窗口时间 = 0
	tp = 根
	zts = tp.字体表.普通字体

end

function 场景类_梦幻指引:打开(数据)
	if self.可视 then
		self.可视 = false
		self.资源组 = nil
		self.顶部按钮 = nil
		self.葫芦按钮 = nil
		self.进度条 = nil
		self.显示数据={}
		return
	else
		insert(tp.窗口_,self)
		self:加载数据()
		self.状态 = 数据.标题
		self.数据= 数据.文本
		self.活跃度 = 数据.活跃度
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
		self.开始 = 1
	    self.结束 = 6
		self.显示数据={}
		for i=1,#self.数据 do
			self.显示数据[i]=self.数据[i]
			if self.数据[i].显示类型~=nil and self.数据[i].显示类型=="头像" then
				local 临时资源 = 引擎.取头像(self.数据[i].显示)
				if 临时资源~=nil then
			        self.显示数据[i].小动画=tp.资源:载入(临时资源[7],"网易WDF动画",临时资源[2])
			    else
			        self.显示数据[i].小动画=tp.资源:载入("物品图标.wdf","网易WDF动画",0x5453A471)
			    end
			     self.显示数据[i].偏移x = 3
			     self.显示数据[i].偏移y = 3
			else
			   local 临时资源=引擎.取物品(self.数据[i].显示)
				if 临时资源~=nil then
			        self.显示数据[i].小动画=tp.资源:载入(临时资源[11],"网易WDF动画",临时资源[12])
			    else
			        self.显示数据[i].小动画=tp.资源:载入("物品图标.wdf","网易WDF动画",0x5453A471)
			    end
			     self.显示数据[i].偏移x = 0
			     self.显示数据[i].偏移y = 0
			end
	         self.显示数据[i].按钮 = tp._按钮.创建(tp.资源:载入('nccmm.npk',"网易WDF动画","11"),0,0,4,true,true,"查看攻略")
	         self.显示数据[i].按钮:绑定窗口_(70)
		end
		if self.结束>=#self.显示数据 then self.结束=#self.显示数据 end
	end
end
function 场景类_梦幻指引:加载数据()
	local 自适应 = tp._自适应
	local 资源 = tp.资源
    local 按钮 = tp._按钮



	self.资源组 = {
		[1] = tp.资源:载入('nccmm.npk',"网易WDF动画","10"),
		[2] = 自适应.创建(5,1,590,300,3,9),
		--[3] = 按钮.创建(pwd("5"),0,0,4,true,true),
		[3] =按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x00000135),0,0,4,true,true),

		[4] = 按钮.创建(tp.资源:载入('nccmm.npk',"网易WDF动画","14"),0,0,4,true,true),
		[5] = 资源:载入("wdf/pic/界面/活跃奖励.png","图片"),--pwd("30"),
		[6] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x00000136),0,0,4,true,true),
		[7] = 按钮.创建(tp.资源:载入('nccmm.npk',"网易WDF动画","6"),0,0,4,true,true),
		[8] = 按钮.创建(tp.资源:载入('nccmm.npk',"网易WDF动画","2"),0,0,4,true,true),
		[9] = 自适应.创建(9,1,270,75,3,9),
		[10] = 按钮.创建(自适应.创建(20,4,18,19,4,3),0,0,4,true,true),--上滚动
		[11] = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true),--下滚动
		--[12] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xE6490543),
		[12] =资源:载入("wdf/pic/打造方格.png","图片")

	}
	self.顶部按钮={
	    [1] = 按钮.创建(资源:载入('nccmm.npk',"网易WDF动画","1"),0,0,4,true,true,"日常任务"),
		[2] = 按钮.创建(资源:载入('nccmm.npk',"网易WDF动画","1"),0,0,4,true,true,"限时活动"),
		[3] = 按钮.创建(资源:载入('nccmm.npk',"网易WDF动画","1"),0,0,4,true,true,"全天活动"),
		[4] = 按钮.创建(资源:载入('nccmm.npk',"网易WDF动画","1"),0,0,4,true,true,"基础攻略"),
}

self.葫芦按钮={
	    [1] = 按钮.创建(资源:载入('nccmm.npk',"网易WDF动画","27"),0,0,4,true,true),
		[2] = 按钮.创建(资源:载入('nccmm.npk',"网易WDF动画","27"),0,0,4,true,true),
		[3] = 按钮.创建(资源:载入('nccmm.npk',"网易WDF动画","27"),0,0,4,true,true),
		[4] = 按钮.创建(资源:载入('nccmm.npk',"网易WDF动画","27"),0,0,4,true,true),
		[5] = 按钮.创建(资源:载入('nccmm.npk',"网易WDF动画","27"),0,0,4,true,true),
		[6] = 按钮.创建(资源:载入('nccmm.npk',"网易WDF动画","27"),0,0,4,true,true),
}
	self.进度条 =  资源:载入('登陆资源.wdf',"网易WDF动画",0x3906F9F1)
	self.资源组[4]:绑定窗口_(70)
	for i=1,4 do
		self.顶部按钮[i]:绑定窗口_(70)
		self.顶部按钮[i]:置偏移(35,0)
	end
end

function 场景类_梦幻指引:刷新(数据)
		if self.状态~= 数据.标题 then
		   self.状态 = 数据.标题
		   self.开始 = 1
	       self.结束 = 6
	     end
		self.数据=数据.文本
		self.活跃度 = 数据.活跃度
		self.显示数据={}
		for i=1,#self.数据 do
			self.显示数据[i]=self.数据[i]
			if self.数据[i].显示类型~=nil and self.数据[i].显示类型=="头像" then
				local 临时资源 = 引擎.取头像(self.数据[i].显示)
				if 临时资源~=nil then
			        self.显示数据[i].小动画=tp.资源:载入(临时资源[7],"网易WDF动画",临时资源[2])
			    else
			        self.显示数据[i].小动画=tp.资源:载入("物品图标.wdf","网易WDF动画",0x5453A471)
			    end
			     self.显示数据[i].偏移x = 3
			     self.显示数据[i].偏移y = 3
			else
			   local 临时资源=引擎.取物品(self.数据[i].显示)
				if 临时资源~=nil then
			        self.显示数据[i].小动画=tp.资源:载入(临时资源[11],"网易WDF动画",临时资源[12])
			    else
			        self.显示数据[i].小动画=tp.资源:载入("物品图标.wdf","网易WDF动画",0x5453A471)
			    end
			     self.显示数据[i].偏移x = 0
			     self.显示数据[i].偏移y = 0
			end

	         self.显示数据[i].按钮 = tp._按钮.创建(tp.资源:载入('nccmm.npk',"网易WDF动画","11"),0,0,4,true,true,"查看攻略")
	         self.显示数据[i].按钮:绑定窗口_(70)
		end
		if self.结束>=#self.显示数据 then self.结束=#self.显示数据 end
end

function 场景类_梦幻指引:显示(dt,x,y)

	self.资源组[3]:更新(x,y)
	self.资源组[4]:更新(x,y)

	self.资源组[6]:更新(x,y)
	self.资源组[7]:更新(x,y)
	self.资源组[8]:更新(x,y)

	if self.资源组[3]:事件判断() then
		--请求服务(46)
		if tp.窗口.仙玉商城类.可视 then
			    tp.窗口.仙玉商城类:打开()
			else
				请求服务(29)
			end
		self:打开()
		return false


	elseif self.资源组[4]:事件判断() then
		self:打开()
		return false


	elseif self.资源组[6]:事件判断() then
		请求服务(46)
		 self:打开()
		 return
	elseif self.资源组[7]:事件判断() then
		--请求服务(39)
		-- self:打开()
		-- return
	elseif self.资源组[8]:事件判断() then
		--请求服务(48)
	elseif self.资源组[10]:事件判断() then
		  if self.开始 == 1 then
		 else
			self.开始 = self.开始 - 1
			self.结束 = self.开始 + 5
			if self.开始<= 1 then
			   self.开始 = 1
			   self.结束 = self.开始 + 5
			end
			if self.结束>=#self.显示数据 then self.结束=#self.显示数据 end
		end

	elseif self.资源组[11]:事件判断() then
		 if self.结束 >= #self.显示数据 then
		else
		  self.开始 = self.开始 + 1
	      self.结束 = self.开始 + 5
	      if self.结束>=#self.显示数据 then self.结束=#self.显示数据 end
		end

	end
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[4]:显示(self.x+639,self.y)---
	for i=1,4 do
		self.顶部按钮[i]:更新(x,y,self.状态 ~= self.顶部按钮[i].按钮文字)
		self.顶部按钮[i]:显示(self.x-100+i*150,self.y+33,true,nil,nil,self.状态 ==self.顶部按钮[i].按钮文字,2)
		 if self.顶部按钮[i]:事件判断() then
		 	 请求服务(40,{获取="获取其他数据",文本 =self.顶部按钮[i].按钮文字 })
         end
	end
	self.资源组[5]:显示(self.x+120,self.y+389)
	self.进度条:置区域(0,0,min(floor( self.活跃度/ 600 * 330),330),8)
	self.进度条:显示(self.x+120,self.y+400)
    self.资源组[2]:显示(self.x+48,self.y+3+26+36)
    self.资源组[3]:显示(self.x+35,self.y+380)---签到

	for i=1,6 do
		local 动态显示 = i*100
		self.葫芦按钮[i]:更新(x,y,self.活跃度>=动态显示)
		self.葫芦按钮[i]:显示(self.x+100+i*55,self.y+390,true,nil,nil,self.活跃度 >= 动态显示,2)
		 zts:置颜色(白色):显示(self.x+103+i*55,self.y+430,动态显示)
		 if self.葫芦按钮[i]:事件判断() then
		    请求服务(40,{获取="活跃度领取",文本=self.状态,编号=i})
		 end
	end



    self.资源组[6]:显示(self.x+471,self.y+391)
	--self.资源组[7]:显示(self.x+551,self.y+391)
	--self.资源组[8]:显示(self.x+600,self.y+391)
	zts:置颜色(白色):显示(self.x+500,self.y+435,"当前活跃："..self.活跃度)
	--zts:置颜色(白色):显示(self.x+475,self.y+430,"活动日历")
	-- zts:置颜色(白色):显示(self.x+550,self.y+430,"排 行")
	-- zts:置颜色(白色):显示(self.x+601,self.y+430,"兑 换")
	-- zts:置颜色(白色):显示(self.x+508,self.y+401,os.date("%d", os.time()).."日")

	if 引擎.取鼠标滚轮() >0 and self.资源组[1]:是否选中(x,y) and self.鼠标 then
		if self.开始 == 1 then
		 else
			self.开始 = self.开始 - 1
			self.结束 = self.开始 + 5
			if self.开始<= 1 then
			   self.开始 = 1
			   self.结束 = self.开始 + 5
			end
			if self.结束>=#self.显示数据 then self.结束=#self.显示数据 end
		end
	elseif 引擎.取鼠标滚轮() <0  and self.资源组[1]:是否选中(x,y) and self.鼠标 then
	     if self.结束 >= #self.显示数据 then
		else
		  self.开始 = self.开始 + 1
	      self.结束 = self.开始 + 5
	      if self.结束>=#self.显示数据 then self.结束=#self.显示数据 end
		end
	end


	local xx=0
	local yy=0
	self.资源组[10]:更新(x,y)
	self.资源组[11]:更新(x,y)
	for i=self.开始,self.结束 do
	  if self.显示数据[i]~=nil then
		 self.显示数据[i].按钮:更新(x,y)
		 self.资源组[9]:显示(self.x+68+xx*280,self.y+92+yy*85)
		 self.资源组[12]:显示(self.x+88+xx*280,self.y+92+13+yy*85)
		 self.显示数据[i].小动画:显示(self.x+88+self.显示数据[i].偏移x+xx*280,self.y+92+self.显示数据[i].偏移y+13+yy*85)
		 self.显示数据[i].按钮:显示(self.x+88+158+xx*280,self.y+92+40+yy*85)

		zts:置颜色(蓝色):显示(self.x+88+58+xx*280,self.y+92+15+yy*85,self.显示数据[i].名称)
		if self.显示数据[i].难度~=nil and self.显示数据[i].难度~="无" then
			zts:置颜色(红色):显示(self.x+88+58+xx*280,self.y+92+45+yy*85,"难度:"..self.显示数据[i].难度)
		end
		 if self.显示数据[i].按钮:事件判断() then
			 请求服务(40,{获取="查看攻略",文本 =self.状态,文件=self.显示数据[i].名称})
		 end
	  end

	  xx=xx+1
	 if xx>=2 then
		yy=yy+1
		xx=0
	end
  end
  self.资源组[10]:显示(self.x+620,self.y+80-16)
  self.资源组[11]:显示(self.x+620,self.y+330+17)




end


function 场景类_梦幻指引:检查点(x,y)
	if self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_梦幻指引:初始移动(x,y)
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

function 场景类_梦幻指引:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_梦幻指引