
local 藏宝阁类 = class()
local floor = math.floor
local ceil = math.ceil
local tp,zts,zts1
local insert = table.insert
local format = string.format

--4个盲盒礼包  5个神兜兜  仙玉300  银子100万  储备200万  双倍药3个
function 藏宝阁类:初始化(根)
	self.ID = 113
	self.x = 90
	self.y = 97
	self.xx = 0
	self.yy = 0
	self.注释 = "藏 宝 阁"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.焦点1 = false
	self.可移动 = true
	local 资源 = 根.资源
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	local 小型选项栏 = 根._小型选项栏
	local 滑块 = 根._滑块
	tp = 根
	self.资源组 = {
		[1] = 自适应.创建(0,1,655,380,3,9),
		[2] = 自适应.创建(1,1,651,18,1,3,nil,18),
		[3] = 自适应.创建(2,1,603,260,3,9),
		[4] = 按钮.创建(自适应.创建(18,4,16,16,4,1),0,0,4,true,true),
		[5] = 按钮.创建(自适应.创建(13,4,72,23,1,3),0,0,4,true,true,"装备商城"),
		[6] = 按钮.创建(自适应.创建(13,4,72,23,1,3),0,0,4,true,true,"灵饰商城"),
		[7] = 按钮.创建(自适应.创建(13,4,72,23,1,3),0,0,4,true,true,"宝宝商城"),
		[8] = 按钮.创建(自适应.创建(13,4,72,23,1,3),0,0,4,true,true,"银两商城"),
		[9] = 按钮.创建(自适应.创建(13,4,72,23,1,3),0,0,4,true,true,"道具商城"),
		[10] = 按钮.创建(自适应.创建(13,4,72,23,1,3),0,0,4,true,true,"角色商城"),
		[11] = 按钮.创建(自适应.创建(13,4,72,23,1,3),0,0,4,true,true,"价格排序"),
		[12] = 按钮.创建(自适应.创建(13,4,72,23,1,3),0,0,4,true,true,"我要出售"),
		[13] = 按钮.创建(自适应.创建(13,4,72,23,1,3),0,0,4,true,true,"我的物品"),
		[14] = 按钮.创建(自适应.创建(13,4,72,23,1,3),0,0,4,true,true,"购买商品"),
	}

	--self.提现按钮 = 按钮.创建(自适应.创建(13,4,72,23,1,3),0,0,4,true,true,"我要提现")
	self.上按钮= 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xFD3D61F2),0,0,4,true,true)--上按钮
	self.下按钮 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x09217E13),0,0,4,true,true)--下按钮
	for i=4,14 do
		self.资源组[i]:绑定窗口_(113)
	end
	--self.提现按钮:绑定窗口_(113)
	self.上按钮:绑定窗口_(113)
	self.下按钮:绑定窗口_(113)
	zts = tp.字体表.排行字体
	zts1 = tp.字体表.标题字体
	self.窗口时间 = 0
	self.物品 = {}
	self.开始=1
	self.结束=4
	self.数据 = {}
	self.选中 = 0
	self.玩家id = 0
	self.分类 = "装备商城"
	self.点卡 = 0
	self.临时资源=""
    self.物品数据 ={}
	local 格子 = 根._物品格子
    for i=1,100 do
        self.物品数据[i] = 格子(0,0,i,"物品")
    end





end





function 藏宝阁类:打开(数据,点卡)
	if self.可视 then
		self.分类 = nil
		self.可视 = false
		self.开始=1
	    self.结束=4
	    self.选中 = 0
	    self.玩家id = 0
	    self.数据 = {}
        self.物品 = {}
        for i=1,100 do
	        self.物品数据[i]:置物品(nil)
	    end
	else
		insert(tp.窗口_,self)
		self.分类 = "装备商城"
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
		self.开始=1
	    self.结束=4
	    self.选中 = 0
	    self.玩家id = 0
	    self.数据 = 数据
        self.物品 = {}
        self.点卡 = 点卡

        for n=1,#self.数据 do
        	self.物品[n] = {}
	        local 临时资源=引擎.取物品(self.数据[n].名称)
	        self.物品[n].小动画=tp.资源:载入(临时资源[11],"网易WDF动画",临时资源[12])
	      --  self.物品[n].大动画=tp.资源:载入(资源[11],动画类型,资源[13])
	        self.物品[n].名称=self.数据[n].名称
	        self.物品[n].价格=self.数据[n].价格
	        self.物品[n].时间=self.数据[n].时间
	        self.物品[n].数量 =self.数据[n].数量
	        self.物品[n].类型 =self.数据[n].类型
	        self.物品[n].编号 = self.数据[n].编号
	        self.物品[n].玩家id = self.数据[n].玩家id
       end
       for i=1,100 do
	       self.物品数据[i]:置物品(nil)
	   end

	end
end




--self.物品数据[i]:置物品(self.数据.数据[i])

function 藏宝阁类:物品数据刷新(数据,物品编号)
	self.物品数据[物品编号]:置物品(nil)
	 if self.分类~="宝宝商城" and self.分类~="角色商城"then
	 	self.物品数据[物品编号]:置物品(数据)
	 end
end

function 藏宝阁类:刷新(数据,类型,点卡)
		self.数据 = 数据
		self.物品 = {}
		self.点卡 = 点卡
		self.选中 = 0
		self.玩家id = 0
		if 类型 ~=self.分类 then
			self.开始=1
		    self.结束=4
		end
		self.分类 = 类型

	      for n=1,#self.数据 do
	      	   self.物品[n] = {}
	      	   self.临时资源=引擎.取物品(self.数据[n].名称)
	      	   if self.分类~="宝宝商城" and self.分类~="角色商城" then
			       self.临时资源=引擎.取物品(self.数据[n].名称)
			       self.物品[n].小动画=tp.资源:载入(self.临时资源[11],"网易WDF动画",self.临时资源[12])
			    else
			       self.临时资源 = 引擎.取头像(self.数据[n].模型)
                   self.物品[n].小动画 = tp.资源:载入(self.临时资源[7],"网易WDF动画",self.临时资源[2])
			    end
		     --  self.物品[n].大动画=tp.资源:载入(临时资源[11],"网易WDF动画",临时资源[13])
		       self.物品[n].名称=self.数据[n].名称
		       self.物品[n].价格=self.数据[n].价格
		       self.物品[n].时间=self.数据[n].时间
		       if self.分类 == "银两商城" then
		       	print(self.数据[n].数量)
		       local 转换数额 = 数额尾数转换(self.数据[n].数量)
		       	self.物品[n].数量 = 转换数额
		       else
		       	self.物品[n].数量 = self.数据[n].数量
		       end

		       self.物品[n].类型 =self.数据[n].类型
		       self.物品[n].编号 = self.数据[n].编号
		       self.物品[n].玩家id = self.数据[n].玩家id
	       end
	  for i=1,100 do
	      self.物品数据[i]:置物品(nil)
	  end


end

function 藏宝阁类:显示(dt,x,y)
	self.焦点 = false
	self.焦点1 = false
	self.资源组[4]:更新(x,y)
	for i =5,14 do
	    self.资源组[i]:更新(x,y)
	end
	--self.提现按钮:更新(x,y)
	self.上按钮:更新(x,y)
	self.下按钮:更新(x,y)


    if self.资源组[4]:事件判断() then
		self:打开()
	end

	self.资源组[1]:显示(self.x,self.y)
	 tp.竖排花纹背景1_:置区域(0,0,18,260)
	tp.竖排花纹背景1_:显示(self.x+3,self.y+72)
	tp.竖排花纹背景1_:显示(self.x+633,self.y+72)
   self.资源组[2]:显示(self.x+2,self.y+2)
	self.资源组[3]:显示(self.x+25,self.y+72)

	tp.窗口标题背景_[3]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	zts1:置字间距(3)
	zts1:显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"藏宝阁")
	zts1:置字间距(0)
	self.资源组[4]:显示(self.x+630,self.y+2)
	self.上按钮:显示(self.x+612,self.y+71)
	self.下按钮:显示(self.x+612,self.y+314)
	tp.画线:置区域(0,0,15,224)
	tp.画线:显示(self.x+616,self.y+91)

    if self.资源组[11]:事件判断() then------排序
    	self:价格排序()
	elseif self.资源组[12]:事件判断() then------出售

		tp.窗口.对话栏:文本(tp.队伍[1].模型,tp.队伍[1].名称, "请选择上架商品类型",{"藏宝阁上架货币","藏宝阁上架物品","藏宝阁上架角色","藏宝阁上架召唤兽"})
	elseif self.资源组[14]:事件判断() then------购买
		if self.选中 == 0 or self.选中 ==nil then
			tp.常规提示:打开("#Y/你还未选择商品")
		else
		   请求服务(69,{类型=self.分类,文本="购买商品",编号=self.选中,购买id=self.玩家id})
		end




    elseif self.资源组[13]:事件判断() then------取出物品
	tp.窗口.对话栏:文本(tp.队伍[1].模型,tp.队伍[1].名称, "请选择打开商品类型",{"打开上架商品","打开购买商品","打开上架召唤兽","打开购买召唤兽"})

	end


	if self.上按钮:事件判断() then
		if self.开始 == 1 then
			tp.常规提示:打开("#Y/已经到最顶层了")
		else
			self.开始 = self.开始 -4
			self.结束 = self.开始 + 3
			if self.开始<= 1 then
			   self.开始 = 1
			   self.结束 = self.开始 + 3
			end
		end

	elseif self.下按钮:事件判断() then
		if self.结束 >= #self.物品 then
			tp.常规提示:打开("#Y/已经到最低层了")
		else
		  self.开始 = self.开始 + 4
	      self.结束 = self.开始 + 3
		end


	end


	if 引擎.取鼠标滚轮() >0 and self.资源组[3]:是否选中(x,y) and self.鼠标 then
		if self.开始 == 1 then
			tp.常规提示:打开("#Y/已经到最顶层了")
		else
			self.开始 = self.开始 -1
			self.结束 = self.开始 + 3
			if self.开始<= 1 then
			   self.开始 = 1
	           self.结束 = self.开始 + 3
			end
		end
	elseif 引擎.取鼠标滚轮() <0  and self.资源组[3]:是否选中(x,y) and self.鼠标 then
	    if self.结束 >= #self.物品 then
			tp.常规提示:打开("#Y/已经到最低层了")
		else
		  self.开始 = self.开始 + 1
		  self.结束 = self.开始 + 3
		end
	end





   local xx = 0

   for i = 5,11 do
	   	if i==11 then
	   	  self.资源组[i]:显示(self.x+10+xx*90,self.y+35)
	   else
	      self.资源组[i]:显示(self.x+10+xx*90,self.y+35,true,nil,nil,self.分类 == self.资源组[i]:取文字(),2)
		   	if self.资源组[i]:事件判断() then
			  请求服务(69,{类型=self.资源组[i]:取文字(),文本="更新"})
			end

	   end
   	xx =xx +1
   end

   local zx = 0

   for i = 12,14 do
   	self.资源组[i]:显示(self.x+10+zx*90,self.y+345)
   	zx =zx +1
   end
   local zy = 0
   for i =1 ,4 do
       tp.物品格子背景_:显示(self.x+35,self.y+98+zy*55)
       zy =zy +1
   end

        local xy = 0
		  zts:置颜色(黑色)
		  for n=self.开始,self.结束 do
				if self.物品[n] ~= nil and self.物品[n].小动画 ~= nil then
					if self.物品数据[n].物品~=nil then
						self.物品数据[n]:置坐标(self.x+37,self.y+98+xy*55)
						self.物品数据[n]:显示(dt,x,y,self.鼠标)
					else
						self.物品[n].小动画:显示(self.x+36,self.y+100+xy*55)
					end

					zts:显示(self.x+100,self.y+115+xy*55,self.物品[n].名称)

					zts:显示(self.x+220,self.y+115+xy*55,self.物品[n].数量 or 1)
					zts:显示(self.x+335,self.y+115+xy*55,self.物品[n].类型)
					zts:显示(self.x+430,self.y+115+xy*55,self.物品[n].价格)
					zts:显示(self.x+555,self.y+115+xy*55,math.ceil((self.物品[n].时间-os.time())/86400).."天")
					if self.物品[n].小动画:是否选中(x,y) or (self.物品数据[n].物品~= nil and self.物品数据[n].焦点)   then
						self.焦点1 = true
						if self.物品数据[n].物品==nil then
							tp.物品格子焦点_:显示(self.x+38,self.y+99+xy*55)
						end

						if self.物品数据[n].物品 ~= nil then
							tp.提示:道具行囊(x,y,self.物品数据[n].物品)
						else
							tp.提示:自定义(x-42,y+27,"#Y/鼠标右键点击查看商品详情")
							if 引擎.鼠标弹起(右键) then
							 请求服务(69,{类型=self.分类,文本="查看商品",编号=self.物品[n].编号,购买id=self.物品[n].玩家id,显示编号=n})
						   end
						end

						if 引擎.鼠标弹起(左键)  then
							self.选中 = self.物品[n].编号
							self.玩家id = self.物品[n].玩家id
						end
					end

					if self.选中~=0 then
						if self.物品[n].编号 ==self.选中  then
						  tp.物品格子确定_:显示(self.x+38,self.y+99+xy*55)
						end
					end
					xy =xy +1
				end
			end



     zts:置颜色(黑色)
	if self.分类 == "装备商城" then

		zts:显示(self.x+100,self.y+77,"装备名称")
		zts:显示(self.x+210,self.y+77,"装备等级")
		zts:显示(self.x+320,self.y+77,"装备类型")
		zts:显示(self.x+430,self.y+77,"购买价格")
		zts:显示(self.x+540,self.y+77,"剩余时间")

	elseif self.分类 == "灵饰商城" then

		zts:显示(self.x+100,self.y+77,"灵饰名称")
		zts:显示(self.x+210,self.y+77,"灵饰等级")
		zts:显示(self.x+320,self.y+77,"灵饰类型")
		zts:显示(self.x+430,self.y+77,"购买价格")
		zts:显示(self.x+540,self.y+77,"剩余时间")
   elseif self.分类 == "宝宝商城" then

        zts:显示(self.x+100,self.y+77,"宝宝名称")
		zts:显示(self.x+210,self.y+77,"宝宝等级")
		zts:显示(self.x+320,self.y+77,"宝宝类型")
		zts:显示(self.x+430,self.y+77,"购买价格")
		zts:显示(self.x+540,self.y+77,"剩余时间")
   elseif self.分类 == "银两商城" then

		zts:显示(self.x+100,self.y+77,"银两名称")
		zts:显示(self.x+210,self.y+77,"银两数量")
		zts:显示(self.x+320,self.y+77,"银两类型")
		zts:显示(self.x+430,self.y+77,"购买价格")
		zts:显示(self.x+540,self.y+77,"剩余时间")
   elseif self.分类 == "道具商城" then

		zts:显示(self.x+100,self.y+77,"物品名称")
		zts:显示(self.x+210,self.y+77,"物品数量")
		zts:显示(self.x+320,self.y+77,"物品单价")
		zts:显示(self.x+430,self.y+77,"购买价格")
		zts:显示(self.x+540,self.y+77,"剩余时间")
	elseif self.分类 == "角色商城" then
		zts:显示(self.x+100,self.y+77,"角色名称")
		zts:显示(self.x+210,self.y+77,"角色等级")
		zts:显示(self.x+320,self.y+77,"角色门派")
		zts:显示(self.x+430,self.y+77,"购买价格")
		zts:显示(self.x+540,self.y+77,"剩余时间")

	end
   zts:置颜色(白色):显示(self.x+310,self.y+348,"剩余点卡:")
   zts:置颜色(红色):显示(self.x+390,self.y+350,self.点卡)

   --self.提现按钮:显示(self.x+550,self.y+345)
   --if self.提现按钮:事件判断() then
   	 --tp.窗口.组合输入框:打开("藏宝阁提现",{"输入你要提现点卡数额",白色,self.点卡,self.分类})
   --end

     zts:置颜色(白色)
end


function 藏宝阁类:价格排序()
	if self.物品~=nil and self.物品[1]~=nil then
		if  self.价格排序开关 == nil or self.价格排序开关 == 1 then
			table.sort(self.物品, function (a, b)
				return a.价格 < b.价格
			end)
			self.价格排序开关 = 2
			tp.常规提示:打开("#Y/商品价格已从低到高排序")
		elseif self.价格排序开关 == 2 then
			table.sort(self.物品, function (a, b)
				return a.价格 > b.价格
			end)
			self.价格排序开关 = 1
			tp.常规提示:打开("#Y/商品价格已从高到低排序")
		end
   end
end




function 藏宝阁类:检查点(x,y)
	if self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 藏宝阁类:初始移动(x,y)
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
function 藏宝阁类:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end
return 藏宝阁类