
local 多角色仓库类 = class()
local bw1= require("gge包围盒")(0,0,200,23)
local bw2= require("gge包围盒")(0,0,200,23)
local tp,ckzts,ckzts1
local tonumbe = tonumber
local insert = table.insert
local box = 引擎.画矩形
function 多角色仓库类:初始化(根)
	self.ID = 123
	self.x = 0
	self.y = 0
	self.xx = 0
	self.yy = 0
	self.注释 = "多角色仓库类"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.仓库开始 = 1
	self.仓库结束 = 20
	self.选中仓库 = nil
	self.选中物品 = nil
	self.仓库页数 = 1
	self.背包页数 = 1
	self.窗口时间 = 0
	self.验证组 = {}
	self.验证时间 = 0
	self.操作时间 = 0
	self.操作次数 = 0
	self.召唤兽起始 = 0
	self.玩家id = 0
	tp = 根
	ckzts = tp.字体表.普通字体
	ckzts1 = tp.字体表.描边字体
	ckzts2 = tp.字体表.普通字体_
end

function 多角色仓库类:加载资源()
	local 资源 = tp.资源
	local 按钮 =  tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,610,330,3,9), -- 297
		[2] = 按钮(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[3] = 自适应.创建(1,1,606,18,1,3,nil,18),
		[4] = 按钮.创建(自适应.创建(13,4,70,21,1,1),0,0,4,true,true,"购买仓库"),
		[5] = 按钮(自适应.创建(13,4,55,21,1,3),0,0,4,true,true,"道具"),
		[6] = 按钮(自适应.创建(13,4,55,21,1,3),0,0,4,true,true,"行囊"),
		[7] = 按钮(自适应.创建(12,4,130,20,1,3),0,0,4,true,true,"道具仓库"),
		[8] = 按钮(自适应.创建(12,4,131,20,1,3),0,0,4,true,true,"召唤兽仓库"),
		[9] = 自适应.创建(6,1,270,250,3,9),
		[10] = 自适应.创建(3,1,35,18,1,3),
		[11] = 按钮(自适应.创建(12,4,30,20,1,3),0,0,4,true,true,"<-"),
		[12] = 按钮(自适应.创建(12,4,30,20,1,3),0,0,4,true,true,"->"),
		[13] = 自适应.创建(4,1,1,1,3,nil),
		[14] = 按钮.创建(自适应.创建(13,4,70,21,1,1),0,0,4,true,true,"整理仓库"),
		[15] = 自适应.创建(6,1,270,30,3,9),
		[16] = 按钮.创建(自适应.创建(20,4,18,19,4,3),0,0,4,true,true),--上滚动
		[17] = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true),--下滚动
		[18] = 自适应.创建(34,1,173,182,3,9),--召唤兽选择框
		[19] =  tp._滑块.创建(自适应.创建(11,4,7,40,2,3,nil),4,14,143,2),
	}
	for n=2,12 do
		if n~=3 and n~=9 and n~=10 then
			self.资源组[n]:绑定窗口_(123)
		end
	end
	self.道具仓库组={}
	self.背包道具组={}
	self.召唤兽仓库组={}
	self.仓库画线 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x2BA5AE64)
	self.仓库 = {}
	self.物品 = {}
	local 格子 = tp._物品格子
	for i=1,180 do
		self.仓库[i] = 格子(0,0,i,"多角色仓库")
		self.物品[i] = 格子(0,0,i,"多角色物品")
	end
	self.宠物数据={}
end

function 多角色仓库类:打开(道具,道具仓库总数,召唤兽仓库总数,玩家id)
	if self.可视 then
		self.仓库开始 = 1
		self.仓库结束 = 100
		self.选中仓库 = nil
		self.选中物品 = nil
		self.可视 = false
		self.资源组=nil
		self.仓库=nil
		self.物品=nil
		self.操作时间=0
		self.操作次数=0
		self.召唤兽起始 = 0
		return
	else
		self.仓库页数 = 1
		self.背包页数 = 1
		self.召唤兽起始 = 0
		self.操作时间 = os.time()
		self.操作次数 = 0
		self.玩家id = 玩家id
		insert(tp.窗口_,self)
		self:加载资源()
		self.x = 160
		self.y = (全局游戏高度/2)-200
		for i=1,100 do
			self.物品[i]:置根(tp)
			self.物品[i]:置物品(tp.多角色[self.玩家id].道具列表[i])
			self.仓库[i]:置根(tp)
			self.仓库[i]:置物品(道具[i])
		end
	    tp.运行时间 = tp.运行时间 + 1
	  	self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.道具仓库总数 = 道具仓库总数
	    self.召唤兽仓库总数 = 召唤兽仓库总数
	    for n=1,self.道具仓库总数 do
			self.道具仓库组[n] = tp._按钮(tp._自适应.创建(13,4,22,21,1,3),0,0,4,true,true)
			self.道具仓库组[n]:绑定窗口_(123)
		end
	    for n=1,5 do
			self.背包道具组[n] = tp._按钮(tp._自适应.创建(13,4,22,21,1,3),0,0,4,true,true)
			self.背包道具组[n]:绑定窗口_(123)
		end
		for n=1,self.召唤兽仓库总数 do
			self.召唤兽仓库组[n] = tp._按钮(tp._自适应.创建(13,4,22,21,1,3),0,0,4,true,true)
			self.召唤兽仓库组[n]:绑定窗口_(123)
		end
	    self.道具类型 = "道具"
	    self.仓库类型 = "道具"
	    self.宠物数据= tp.多角色[self.玩家id].宝宝列表
	    self.选择召唤兽 = 0
	    self.选择召唤兽认证码 = nil
	    self.选择仓库召唤兽 = 0
	    self.选择仓库召唤兽认证码 = nil
	end
end
function 多角色仓库类:刷新道具()
	self.仓库开始 = 1
	self.仓库结束 = 100
 	for i=1,100 do
 		self.物品[i]:置物品(nil)
	  if self.道具类型 == "道具" then
	  	  if tp.多角色[self.玩家id].道具列表[i]~=nil then
			  self.物品[i]:置物品(tp.多角色[self.玩家id].道具列表[i])
		 end
	  else
	  	if tp.多角色[self.玩家id].行囊列表[i]~=nil then
		 self.物品[i]:置物品(tp.多角色[self.玩家id].行囊列表[i])
		end
	  end
	  self.物品[i].确定=nil
    end
 	self.选择仓库 = nil
 	self.选择物品=nil
 	--self.背包页数 = 1
 end

function 多角色仓库类:刷新仓库(数据,页数,玩家id)
	self.玩家id = 玩家id
	if self.仓库类型 == "道具" then
		self.仓库开始 = 1
		self.仓库结束 = 100
	 	for i=1,100 do
	 		self.仓库[i]:置根(tp)
		  	self.仓库[i]:置物品(数据[i])
	    end
	elseif self.仓库类型 == "召唤兽" then
		self.召唤兽仓库数据 = 数据
		self.宠物数据= tp.多角色[self.玩家id].宝宝列表
		self.召唤兽起始 = 0
		self.选择召唤兽 = 0
	    self.选择召唤兽认证码 = nil
	    self.选择仓库召唤兽 = 0
	    self.选择仓库召唤兽认证码 = nil
	end

 	self.仓库页数 = 页数
end

function 多角色仓库类:刷新道具仓库总数(道具,总数,玩家id)
	self.仓库类型 = "道具"
	self.仓库开始 = 1
	self.仓库结束 = 100
 	for i=1,100 do
 		self.仓库[i]:置根(tp)
	  	self.仓库[i]:置物品(道具[i])
    end
 	self.道具仓库总数 = 总数
 	self.玩家id = 玩家id
 	self.仓库页数 = 1
 	self.背包页数 = 1
 	for n=1,self.道具仓库总数 do
		self.道具仓库组[n] = tp._按钮(tp._自适应.创建(13,4,22,21,1,3),0,0,4,true,true)
		self.道具仓库组[n]:绑定窗口_(123)

	end
end

function 多角色仓库类:刷新召唤兽仓库总数(总数,仓库数据,玩家id)
	self.仓库类型="召唤兽"
 	self.召唤兽仓库总数 = 总数
 	self.玩家id = 玩家id
 	self.仓库页数 = 1
 	self.背包页数 = 1
 	self.召唤兽仓库数据 = 仓库数据
 	self.宠物数据= tp.多角色[self.玩家id].宝宝列表
 	for n=1,self.召唤兽仓库总数 do
		self.召唤兽仓库组[n] = tp._按钮(tp._自适应.创建(13,4,22,21,1,3),0,0,4,true,true)
		self.召唤兽仓库组[n]:绑定窗口_(123)
	end
	self.资源组[19]:置起始点(0)
	self.选择召唤兽 = 0
    self.选择召唤兽认证码 = nil
    self.选择仓库召唤兽 = 0
    self.选择仓库召唤兽认证码 = nil
end

function 多角色仓库类:显示(dt,x,y)
	self.焦点 = false
	self.资源组[2]:更新(x,y)
	self.资源组[4]:更新(x,y)
	self.资源组[14]:更新(x,y)
	self.资源组[5]:更新(x,y)
	self.资源组[6]:更新(x,y)
	self.资源组[7]:更新(x,y)
	self.资源组[8]:更新(x,y)
	self.资源组[11]:更新(x,y)
	self.资源组[12]:更新(x,y)
  	if self.资源组[2]:事件判断() then
  	 	self:打开()
  	 	return
  	elseif self.资源组[5]:事件判断() then
  		self.道具类型 = "道具"
        请求服务(63,{参数=self.玩家id,文本="仓库道具",道具类型=self.道具类型})
    elseif self.资源组[6]:事件判断() then
    	self.道具类型 = "行囊"
    	self.背包页数 = 1
		请求服务(63,{参数=self.玩家id,文本="仓库道具",道具类型=self.道具类型})
	elseif self.资源组[7]:事件判断() then
		self.仓库类型 = "道具"
		self.道具类型 = "道具"
		self.选择召唤兽 = 0
	    self.选择召唤兽认证码 = nil
	    self.选择仓库召唤兽 = 0
	    self.选择仓库召唤兽认证码 = nil
		请求服务(63,{参数=self.玩家id,文本="道具仓库",序列=1})
	elseif self.资源组[8]:事件判断() then
		self.选择召唤兽 = 0
	    self.选择召唤兽认证码 = nil
	    self.选择仓库召唤兽 = 0
	    self.选择仓库召唤兽认证码 = nil
		请求服务(63,{参数=self.玩家id,文本="获取宝宝仓库1"})
  	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[3]:显示(self.x+2,self.y+2)
	tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	self.资源组[2]:显示(self.x + 588,self.y + 2)
	ckzts1:显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"角色仓库")
	self.资源组[7]:显示(self.x+140,self.y+29,nil,nil,nil,self.仓库类型=="道具",2)
	self.资源组[8]:显示(self.x+340,self.y+29,nil,nil,nil,self.仓库类型=="召唤兽",2)
	if self.仓库类型 == "道具" then
		for n=1,self.道具仓库总数 do
			self.道具仓库组[n]:更新(x,y)
		end
		for n=1,5 do
			self.背包道具组[n]:更新(x,y)
		end
		for n=1,self.道具仓库总数 do
	  	    if self.道具仓库组[n]:事件判断() and self.道具仓库组[n].事件 and self.道具仓库组[n].窗口按钮 then
				self.仓库页数 = n
				请求服务(63,{参数=self.玩家id,文本="道具仓库",序列=self.仓库页数})
			end
	  	end
		for n=1,5 do
			if self.背包道具组[n]:事件判断() and self.背包道具组[n].事件 and self.背包道具组[n].窗口按钮 then
				self.背包页数 = n
				for q=(self.背包页数-1)*20+1,self.背包页数*20 do
					self.物品[q]:置物品(tp.多角色[self.玩家id].道具列表[q])
				end
			end
		end
		tp.宽竖排花纹背景_:置区域(0,0,17,40)
		tp.宽竖排花纹背景_:显示(self.x+298,self.y+85)
		tp.宽竖排花纹背景_:置区域(0,0,17,40)
		tp.宽竖排花纹背景_:显示(self.x+298,self.y+240)
		self.仓库画线:置区域(0,0,70,2)
		self.仓库画线:显示(self.x+18,self.y+58)
		ckzts2:置颜色(白色):显示(self.x+120,self.y+58,"仓库"..self.仓库页数)
		self.仓库画线:显示(self.x+195,self.y+58)
		self.仓库画线:显示(self.x+345,self.y+58)
		ckzts2:置颜色(白色):显示(self.x+443,self.y+58,"道具仓库")
		self.仓库画线:显示(self.x+520,self.y+58)
		tp.物品界面背景_:显示(self.x+14,self.y+79)
		tp.物品界面背景_:显示(self.x+340,self.y+79)
		ckzts2:置颜色(白色):显示(self.x+294,self.y+132,"数量")
		self.资源组[10]:显示(self.x+290,self.y+150)
		self.资源组[11]:显示(self.x+294,self.y+175)
		self.资源组[12]:显示(self.x+294,self.y+205)
		self.资源组[4]:显示(self.x + 195,self.y + 300,true)
		self.资源组[14]:显示(self.x + 270,self.y + 300,true)
		self.资源组[5]:显示(self.x + 345,self.y + 300,nil,nil,nil,self.道具类型=="道具",2)
		self.资源组[6]:显示(self.x + 405,self.y + 300,nil,nil,nil,self.道具类型=="行囊",2)
		if self.资源组[4]:事件判断() then
		  tp.窗口.对话栏:文本(tp.多角色[self.玩家id].模型,tp.多角色[self.玩家id].名称, "增加物品仓库数量需要支付20点仙玉，每增加一间仓库将额外消耗（已增加仓库数量*20）点仙玉。本次增加仓库需要消耗#R"..((self.道具仓库总数-3)*20+20).."#W点仙玉，你是否需要进行购买仓库操作？",{"确定购买该角色道具仓库","让我再想想"})
		elseif self.资源组[14]:事件判断() then
			请求服务(63,{参数=self.玩家id,文本="整理仓库",道具类型=self.道具类型,页数=self.仓库页数})
		end
		ckzts2:置颜色(黄色):显示(self.x+463,self.y+303,"鼠标右击道具可快速转移")
		if self.道具仓库总数 > 7 then
			self.资源组[9]:显示(self.x+5,self.y+332)
		end
		if self.道具类型 == "道具" then
			self.资源组[15]:显示(self.x+340,self.y+332)
		end
		local new_x = 0
		local new_y = 0
		for n=1,self.道具仓库总数 do
			if n < 8 then
		    	self.道具仓库组[n]:显示(self.x+15+(n-1)*25,self.y+300,nil,nil,nil,self.仓库页数==n,2)
		    	ckzts1:显示(self.x+22+(n-1)*25,self.y+301,n)
		    else
		    	self.道具仓库组[n]:显示(self.x+15+new_x*25,self.y+335+new_y*25,nil,nil,nil,self.仓库页数==n,2)
		    	if n >=10 then
		    		ckzts1:显示(self.x+18+new_x*25,self.y+336+new_y*25,n)
			    else
			    	ckzts1:显示(self.x+22+new_x*25,self.y+336+new_y*25,n)
			    end
		    	new_x = new_x + 1
		    end
		    if new_x == 10 then
		    	new_y = new_y + 1
		    	new_x = 0
		    end
		end
		if self.道具类型 == "道具" then
			for n=1,5 do
		    	self.背包道具组[n]:显示(self.x+345+(n-1)*25,self.y+335,nil,nil,nil,self.背包页数==n,2)
		    	ckzts1:显示(self.x+352+(n-1)*25,self.y+336,n)
			end
		end
		local xx = 0
		local yy = 0
		local 提示文字 = tp.字体表.描边字体2
		local 背包页起点=(self.背包页数-1)*20
		for i=背包页起点+1,背包页起点+20 do
			local jx = xx*51+341
			local jy = yy*51+79
			self.物品[i]:置坐标(jx + self.x,jy + self.y)
			if self.物品[i].物品 ~= nil then
				local 分割名称 = 分割文本(self.物品[i].物品.名称,"商品")
				if 分割名称[1] == "" or 分割名称[1] == "帮派银票" then
					self.物品[i]:显示(dt,x,y,self.鼠标,{0,0,分割名称[1] ~= "" and 分割名称[1] ~= "帮派银票"})
				else
					self.物品[i]:显示(dt,x,y,self.鼠标)
				end
			else
			    self.物品[i]:显示(dt,x,y,self.鼠标)
			end
			if self.物品[i].焦点 then
				if self.物品[i].物品 ~= nil then
					local 分割名称 = 分割文本(self.物品[i].物品.名称,"商品")
					tp.提示:道具行囊(x,y,self.物品[i].物品)
					if self.物品[i].事件 and self.鼠标 then
						if self.选择物品 ~= nil then
							self.物品[self.选择物品].确定 = false
						end
						self.选择物品 = i
						self.物品[i].确定 = true
					elseif 引擎.鼠标弹起(右键) and (分割名称[1] ~= "" and 分割名称[1] ~= "帮派银票") then
						if self.操作时间 + 1 <= os.time() then
							self.操作时间 = os.time()
							self.操作次数 = 0
						else
							if self.操作次数 >= 2 then
								tp.常规提示:打开("#Y/操作过快，请歇息一下#86")
								return
							end
						end
						if self.选择物品 ~= nil then
							self.物品[self.选择物品].确定 = false
						end
				 		请求服务(63,{参数=self.玩家id,文本="存入仓库",页数=self.仓库页数,物品=i,类型=self.道具类型})
				 		self.操作次数 = self.操作次数 + 1
					end
				end
			end
			xx = xx + 1
			if xx == 5 then
				xx = 0
				yy = yy + 1
			end
		end

		local xx = 0
		local yy = 0
		for i=1,20 do
			local jx = xx*51+306
			local jy = yy*51+79
			jx = jx-291
			self.仓库[self.仓库开始-1+i]:置坐标(jx + self.x,jy + self.y)
			self.仓库[self.仓库开始-1+i]:显示(dt,x,y,self.鼠标)
			if self.仓库[i].焦点 then
				if self.仓库[i].物品 ~= nil then
					tp.提示:道具行囊(x,y,self.仓库[i].物品)
					if self.仓库[i].事件 and self.鼠标 then
						if self.选择仓库 ~= nil then
							self.仓库[self.选择仓库].确定 = false
						end
					    self.选择仓库 = i
					    self.仓库[i].确定 = true
	               	elseif 引擎.鼠标弹起(右键) then
					 	请求服务(63,{参数=self.玩家id,文本="取出物品",页数=self.仓库页数,物品=i,类型=self.道具类型})
					end
				end
			end
			xx = xx + 1
			if xx == 5 then
				xx = 0
				yy = yy + 1
			end
		end
	elseif self.仓库类型 == "召唤兽" then
		for n=1,self.召唤兽仓库总数 do
			self.召唤兽仓库组[n]:更新(x,y)
		end
		for n=1,self.召唤兽仓库总数 do
	  	    if self.召唤兽仓库组[n]:事件判断() and self.召唤兽仓库组[n].事件 and self.召唤兽仓库组[n].窗口按钮 then
				self.仓库页数 = n
				请求服务(63,{参数=self.玩家id,文本="获取宝宝仓库",序列=self.仓库页数})
			end
	  	end

		tp.宽竖排花纹背景_:置区域(0,0,17,80)
		tp.宽竖排花纹背景_:显示(self.x+298,self.y+85)
		tp.宽竖排花纹背景_:置区域(0,0,17,40)
		tp.宽竖排花纹背景_:显示(self.x+298,self.y+240)
		self.资源组[11]:显示(self.x+294,self.y+175)
		self.资源组[12]:显示(self.x+294,self.y+205)
		self.仓库画线:置区域(0,0,70,2)
		self.仓库画线:显示(self.x+18,self.y+58)
		ckzts2:置颜色(白色):显示(self.x+105,self.y+58,"召唤兽仓库"..self.仓库页数)
		self.仓库画线:显示(self.x+195,self.y+58)
		self.仓库画线:显示(self.x+345,self.y+58)
		ckzts2:置颜色(白色):显示(self.x+430,self.y+58,"已携带召唤兽")
		self.仓库画线:显示(self.x+520,self.y+58)
		self.资源组[13]:置宽高(255,210)
		self.资源组[13]:显示(self.x+15,self.y+80)
		self.资源组[13]:显示(self.x+340,self.y+80)
		ckzts2:置颜色(黄色):显示(self.x+463,self.y+303,"鼠标右击可查看属性")
		ckzts1:置颜色(白色):显示(self.x+30,self.y+85,"名字")
		ckzts1:置颜色(白色):显示(self.x+170,self.y+85,"等级")
		ckzts1:置颜色(白色):显示(self.x+355,self.y+85,"名字")
		ckzts1:置颜色(白色):显示(self.x+495,self.y+85,"等级")
		if self.召唤兽仓库总数 > 7 then
			self.资源组[9]:显示(self.x+5,self.y+332)
		end
		self.资源组[4]:显示(self.x + 195,self.y + 300,true)
  		if #self.宠物数据 > 7 then
			self.资源组[19]:置高度(math.min(math.floor(143/(#self.宠物数据-7)),104))
			self.召唤兽起始 = math.min(math.ceil((#self.宠物数据-7)*self.资源组[19]:取百分比()),#self.宠物数据-7)
		end
  		self.资源组[16]:更新(x,y,self.召唤兽起始 > 0)
		self.资源组[17]:更新(x,y,self.召唤兽起始 < #self.宠物数据 - 7)
		self.资源组[16]:显示(self.x+575,self.y+110)
		self.资源组[17]:显示(self.x+575,self.y+270)
		if #self.宠物数据 > 7 then
			self.资源组[19]:显示(self.x+577,self.y+128,x,y,self.鼠标)
		end
		if self.资源组[4]:事件判断() then
			 tp.窗口.对话栏:文本(tp.多角色[self.玩家id].模型,tp.多角色[self.玩家id].名称, "增加召唤兽仓库数量需要支付20点仙玉，每增加一间召唤兽仓库将额外消耗（已增加仓库数量*20）点仙玉。本次增加仓库需要消耗#R"..((self.召唤兽仓库总数-1)*20+20).."#W点仙玉，你是否需要进行购买仓库操作？",{"确定购买该角色召唤兽仓库","让我再想想"})
		elseif self.资源组[11]:事件判断() then
			if self.选择召唤兽~=0 and self.宠物数据[self.选择召唤兽]~=nil then
				if self.宠物数据[self.选择召唤兽].参战信息~=nil then
					tp.常规提示:打开("#Y/参战的召唤兽无法存入仓库。")
				else
					if #self.宠物数据 > 7 then
						self.资源组[19]:置起始点(self.资源组[19]:取百分比转换(self.召唤兽起始-1,7,#self.宠物数据))
					end
					请求服务(63,{参数=self.玩家id,文本="存入宝宝仓库",认证码=self.选择召唤兽认证码,页数=self.仓库页数})
				 --   请求服务(7003,{认证码=self.选择召唤兽认证码,页数=self.仓库页数})
				end
			else
				tp.常规提示:打开("#Y/请选择一只召唤兽进行存放。")
			end
		elseif self.资源组[12]:事件判断() then
			if self.选择仓库召唤兽~=0 and self.召唤兽仓库数据[self.选择仓库召唤兽]~=nil then
				if #self.宠物数据 > 7 then
					self.资源组[19]:置起始点(self.资源组[19]:取百分比转换(self.召唤兽起始-1,7,#self.宠物数据))
				end
				--请求服务(7004,{认证码=self.选择仓库召唤兽认证码,页数=self.仓库页数})
				请求服务(63,{参数=self.玩家id,文本="取出宝宝仓库",认证码=self.选择仓库召唤兽认证码,页数=self.仓库页数})
			else
				tp.常规提示:打开("#Y/请选择一只仓库召唤兽进行取出。")
			end
		elseif self.资源组[16]:事件判断() then--上滚动
			self.资源组[19]:置起始点(self.资源组[19]:取百分比转换(self.召唤兽起始-1,7,#self.宠物数据))
		elseif self.资源组[17]:事件判断() then--下滚动
			self.资源组[19]:置起始点(self.资源组[19]:取百分比转换(self.召唤兽起始+1,7,#self.宠物数据))
		elseif(self.资源组[18]:是否选中(x,y) or self.资源组[16]:是否选中(x,y) or self.资源组[19]:是否选中(x,y)) and 引擎.取鼠标滚轮() ==1 and self.召唤兽起始 > 0 then--鼠标上滚动
			self.资源组[19]:置起始点(self.资源组[19]:取百分比转换(self.召唤兽起始-1,7,#self.宠物数据))
		elseif (self.资源组[18]:是否选中(x,y) or self.资源组[17]:是否选中(x,y) or self.资源组[19]:是否选中(x,y)) and 引擎.取鼠标滚轮() ==-1 and self.召唤兽起始 < #bblb - 7 then--鼠标下滚动
			self.资源组[19]:置起始点(self.资源组[19]:取百分比转换(self.召唤兽起始+1,7,#self.宠物数据))
		end
		if self.宠物数据[1]~=nil and self.宠物数据[self.选择召唤兽] ~= nil and self.选择召唤兽-self.召唤兽起始 <= 7 then
			box(self.x+343,self.y+85+((self.选择召唤兽-self.召唤兽起始)*24),self.x+343+200,self.y+85+((self.选择召唤兽-self.召唤兽起始)*24)+23,-10790181)
		end
		for i=self.召唤兽起始+1,self.召唤兽起始+7 do
			if self.宠物数据[i] ~= nil then
				local jx = self.x+343
				local jy = self.y+85+((i-self.召唤兽起始)*24)
				bw1:置坐标(jx,jy)
				if bw1:检查点(x,y) and self.鼠标 then
					box(jx,jy,jx+200,jy+23,-2097481216)
					if 引擎.鼠标弹起(0) and self.鼠标 and not tp.消息栏焦点 then
						self.选择召唤兽 = i
						self.选择召唤兽认证码 = self.宠物数据[i].认证码
					elseif 引擎.鼠标弹起(1) and self.鼠标 and not tp.消息栏焦点 then
						self.右键关闭 = 1
						self.选择召唤兽 = i
						self.选择召唤兽认证码 = self.宠物数据[i].认证码
		                tp.窗口.召唤兽查看栏:打开(tp.多角色[self.玩家id].宝宝列表[self.选择召唤兽])
		            else
						self.右键关闭 = nil
					end
				end
				if self.宠物数据[i].参战信息 == 1 then
					ckzts:置颜色(黄色):显示(jx+3,jy+3,self.宠物数据[i].名称)
					ckzts:置颜色(黄色):显示(jx+155,jy+3,self.宠物数据[i].等级)
				else
				    ckzts:置颜色(黑色):显示(jx+3,jy+3,self.宠物数据[i].名称)
				    ckzts:置颜色(黑色):显示(jx+155,jy+3,self.宠物数据[i].等级)
				end
				if self.宠物数据[i].加锁~=nil and self.宠物数据[i].加锁 then
		    		tp.加锁图标:显示(jx+220,jy)
		    	end
			end
		end
		if self.召唤兽仓库数据[1]~=nil and self.召唤兽仓库数据[self.选择仓库召唤兽] ~= nil then
			box(self.x+18,self.y+85+(self.选择仓库召唤兽*24),self.x+18+200,self.y+85+(self.选择仓库召唤兽*24)+23,-10790181)
		end
		for i=1,7 do
			if self.召唤兽仓库数据[i] ~= nil then
				local jx = self.x+18
				local jy = self.y+85+(i*24)
				bw2:置坐标(jx,jy)
				if bw2:检查点(x,y) and self.鼠标 then
					box(jx,jy,jx+200,jy+23,-2097481216)
					if 引擎.鼠标弹起(0) and self.鼠标 and not tp.消息栏焦点 then
						self.选择仓库召唤兽 = i
						self.选择仓库召唤兽认证码 = self.召唤兽仓库数据[i].认证码
					elseif 引擎.鼠标弹起(1) and self.鼠标 and not tp.消息栏焦点 then
						self.右键关闭 = 1
						self.选择仓库召唤兽 = i
						self.选择仓库召唤兽认证码 = self.召唤兽仓库数据[i].认证码
		                tp.窗口.召唤兽查看栏:打开(self.召唤兽仓库数据[self.选择仓库召唤兽])
		            else
						self.右键关闭 = nil
					end
				end
				if self.召唤兽仓库数据[i].参战信息 == 1 then
					ckzts:置颜色(黄色):显示(jx+3,jy+3,self.召唤兽仓库数据[i].名称)
					ckzts:置颜色(黄色):显示(jx+155,jy+3,self.召唤兽仓库数据[i].等级)
				else
				    ckzts:置颜色(黑色):显示(jx+3,jy+3,self.召唤兽仓库数据[i].名称)
				    ckzts:置颜色(黑色):显示(jx+155,jy+3,self.召唤兽仓库数据[i].等级)
				end
				if self.召唤兽仓库数据[i].加锁~=nil and self.召唤兽仓库数据[i].加锁 then
		    		tp.加锁图标:显示(jx+220,jy)
		    	end
			end
		end
		local new_x = 0
		local new_y = 0
		for n=1,self.召唤兽仓库总数 do
			if n < 8 then
		    	self.召唤兽仓库组[n]:显示(self.x+15+(n-1)*25,self.y+300,nil,nil,nil,self.仓库页数==n,2)
		    	ckzts1:显示(self.x+22+(n-1)*25,self.y+301,n)
		    else
		    	self.召唤兽仓库组[n]:显示(self.x+15+new_x*25,self.y+335+new_y*25,nil,nil,nil,self.仓库页数==n,2)
		    	if n >=10 then
		    		ckzts1:显示(self.x+18+new_x*25,self.y+336+new_y*25,n)
			    else
			    	ckzts1:显示(self.x+22+new_x*25,self.y+336+new_y*25,n)
			    end
		    	new_x = new_x + 1
		    end
		    if new_x == 10 then
		    	new_y = new_y + 1
		    	new_x = 0
		    end
		end
	end
	if self.资源组[19].接触 then
		self.焦点 = true
	end
end

function 多角色仓库类:检查点(x,y)
	if self.可视 and (self.资源组[1]:是否选中(x,y) or self.资源组[9]:是否选中(x,y) or self.资源组[15]:是否选中(x,y)) then
		return true
	end
end

function 多角色仓库类:初始移动(x,y)
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

function 多角色仓库类:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy

	end
end

function 多角色仓库类:判断仓库数量(页数)
	local i = 页数 * 20
	local sl = 0
	for m=i-19,i do
		if self.仓库[m].物品 == nil then
			sl = sl + 1
		end
	end
	return sl
end

return 多角色仓库类