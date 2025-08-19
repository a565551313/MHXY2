--======================================================================--
local 场景类_打造 = class()
local floor = math.floor
local insert = table.insert
local random = 引擎.取随机整数
local mouseb = 引擎.鼠标弹起
local zts,tp,zts1
local remove = table.remove
local cs = 2

local sts = {"所需资金：","现有资金：","所需体力：","现有体力："}
local 可选项目 ={}
function 场景类_打造:初始化(根)
	self.ID = 21
	self.x = 200
	self.y = 156
	self.xx = 0
	self.yy = 0
	self.注释 = "制造"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.开始 = 1
	self.结束 = 20
	self.总价 = 0
	self.窗口时间 = 0
	tp = 根
	zts = tp.字体表.下拉字体
	zts1 = tp.字体表.下拉字体_
	self.体力消耗=0
	self.分类="打造"
end

function 场景类_打造:打开(ss)
	if self.可视 then
		self.随身 = nil
		self.开始 = 1
		self.结束 = 20
		self.可视 = false
		self.资源组=nil
		self.物品=nil
		self.材料=nil
		return
	else
		insert(tp.窗口_,self)
		self:加载资源()
		self.刷新数据=ss
		self.分类="打造"
		self.开始 = 1
		self.结束 = 20
		for i=1,100 do
			self.物品[i]:置物品(ss[i])
		end
		for i=1,3 do
			self.材料[i]:置物品(nil)
		end
	    tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.消耗体力=0
	end
end
function 场景类_打造:加载资源()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	local 小型选项栏 = tp._小型选项栏
	self.资源组 = {
		[1] = 自适应.创建(0,1,458,358,3,9),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,24,true),
		[3] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,24,true,"打造"),
		[4] = 按钮.创建(自适应.创建(22,4,27,20,4,3),0,0,4,24,true),
		[5] = 按钮.创建(自适应.创建(23,4,27,20,4,3),0,0,4,24,true),

		[8] = 自适应.创建(1,1,455,18,1,3,nil,18),
		[9] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,24,true,"打造"),
		[10] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,24,true,"镶嵌"),
		[11] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,24,true,"合成"),
		[12] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,24,true,"修理"),
		[13] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,24,true,"熔炼"),
		[14] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,24,true,"分解"),
		[15] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,24,true,"神器"),
		[19] = 自适应.创建(3,1,94,18,1,3),
		[20] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xB17505CF),
		[21] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xB17505CF),
		[24] = 按钮.创建(资源:载入('迭代.wdf',"网易WDF动画",0x00000050),0,0,4,true,true), --下拉
		[25] = 小型选项栏.创建(自适应.创建(105,1,95,110,3,9),"打造"),--下拉选项

		[26] = 按钮.创建(资源:载入('迭代.wdf',"网易WDF动画",0x00000050),0,0,4,true,true), --下拉
		[27] = 小型选项栏.创建(自适应.创建(105,1,80,110,3,9),"镶嵌"),--下拉选项

		[28] = 按钮.创建(资源:载入('迭代.wdf',"网易WDF动画",0x00000050),0,0,4,true,true), --下拉
		[29] = 小型选项栏.创建(自适应.创建(105,1,80,110,3,9),"合成"),--下拉选项

		[30] = 按钮.创建(资源:载入('迭代.wdf',"网易WDF动画",0x00000050),0,0,4,true,true), --下拉
		[31] = 小型选项栏.创建(自适应.创建(105,1,80,110,3,9),"修理"),--下拉选项

		[32] = 按钮.创建(资源:载入('迭代.wdf',"网易WDF动画",0x00000050),0,0,4,true,true), --下拉
		[33] = 小型选项栏.创建(自适应.创建(105,1,80,110,3,9),"熔炼"),--下拉选项

		[34] = 按钮.创建(资源:载入('迭代.wdf',"网易WDF动画",0x00000050),0,0,4,true,true), --下拉
		[35] = 小型选项栏.创建(自适应.创建(105,1,80,110,3,9),"分解"),--下拉选项
		[50] = 资源:载入(wdf配置.."/pic/打造背景.png", "图片"),
		[51] = 资源:载入(wdf配置.."/pic/打造合成.png", "图片"),
		[52] = 资源:载入(wdf配置.."/pic/打造方格.png", "图片"),
	}
	self.背包按钮={
			[1] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"1"),
			[2] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"2"),
			[3] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"3"),
			[4] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"4"),
			[5] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,"5"),
		   }
		   for i=1,5 do
		  	self.背包按钮[i]:置偏移(-2,-2)
		  end


	self.处理项目 = "强化人物装备"
	cs=2
	可选项目 = {"强化人物装备","普通人物装备","召唤兽装备","强化灵饰淬灵","灵饰淬灵"}
	local 格子 = tp._物品格子
	self.物品 = {}
	for i=1,100 do
		self.物品[i] = 格子(0,0,i,"打造")
		self.物品[i]:置物品(nil)
	end
	self.材料 = {}
	self.材料[1] = 格子(self.x+4,self.y,1,"打造材料")
	self.材料[2] = 格子(self.x+4,self.y,2,"打造材料")
	self.材料[3] = 格子(self.x+4,self.y,3,"打造材料")
end
function 场景类_打造:刷新道具(ss)

	for i=1,100 do
		self.物品[i]:置物品(nil)
		self.物品[i]:置物品(ss[i])
	end
	for i=1,3 do
		self.材料[i]:置物品(nil)
		self.材料[i].ID=nil
		self.材料[i].道具序列=nil
	end
	if self.资源组[25].可视 then
		self.资源组[25]:打开()
	end
 	self.消耗体力=0
 	self.总价=0
end

function 场景类_打造:内部刷新道具(ss)
    self.开始 = 1
	self.结束 = 20
	for i=1,100 do
		self.物品[i]:置物品(nil)
		self.物品[i]:置物品(ss[i])
	end
	if self.处理项目 == "星辉石" and self.分类=="合成" then
		for i=1,3 do
			if self.材料[i].物品 ~= nil then
				self.物品[self.材料[i].道具序列]:置物品(self.材料[i].物品)
				tp.道具列表[self.材料[i].道具序列] = self.材料[i].物品
			end
			self.材料[i]:置物品(nil)
			self.材料[i].ID=nil
			self.材料[i].道具序列=nil
		end
	else
		for i=1,2 do
			if self.材料[i].物品 ~= nil then
				self.物品[self.材料[i].道具序列]:置物品(self.材料[i].物品)
				tp.道具列表[self.材料[i].道具序列] = self.材料[i].物品
			end
			self.材料[i]:置物品(nil)
			self.材料[i].ID=nil
			self.材料[i].道具序列=nil
		end
	end
	if self.资源组[25].可视 then
		self.资源组[25]:打开()
	end
 	self.消耗体力=0
 	self.总价=0
end


function 场景类_打造:打造公式()
	self.消耗体力 = 0
	self.总价 = 0
	if self.分类 == "打造" then
		if self.材料[1].物品 ~= nil and self.材料[2].物品 ~= nil then
			if self.材料[1].物品.名称 == "上古锻造图策" or self.材料[1].物品.名称 == "天眼珠" or self.材料[1].物品.名称 == "三眼天珠" or self.材料[1].物品.名称 == "九眼天珠" then
				local a = 0
				if self.材料[1].物品.级别限制 and self.材料[2].物品.级别限制 then
					if self.材料[1].物品.级别限制 >= self.材料[2].物品.级别限制 then
						a = self.材料[1].物品.级别限制
					else
					    a = self.材料[2].物品.级别限制
					end
				end
				self.消耗体力 = a - 20
				self.总价 = (a-65)*400+8950
			else
				local a = 0
				if self.材料[1].物品.子类 and self.材料[2].物品.子类 then
					if self.材料[1].物品.子类 >= self.材料[2].物品.子类 then
						a = self.材料[1].物品.子类
					else
					  a = self.材料[2].物品.子类
					end
				end
				self.消耗体力 = (a - 10)*2+50
				if a <= 20 then
				  self.总价 = 5000
				elseif a == 30 then
					self.总价 = 10000
				elseif a == 40 then
					self.总价 = 20000
				elseif a == 50 then
					self.总价 = 30000
				elseif a == 60 then
					self.总价 = 40000
				elseif a == 70 then
					self.总价 = 80000
				elseif a == 80 then
					self.总价 = 100000
				elseif a == 90 then
					self.总价 = 200000
				elseif a == 100 then
					self.总价 = 300000
				elseif a == 110 then
					self.总价 = 400000
				elseif a == 120 then
					self.总价 = 500000
				elseif a == 130 then
					self.总价 = 600000
				elseif a == 140 then
					self.总价 = 700000
				else
				  self.总价 = 800000
				end
			end
		end
	elseif self.分类 == "镶嵌" then
		if self.处理项目 == "宝石转移" then
			if self.材料[2].物品 and self.材料[2].物品.锻炼等级 then
				self.总价 = self.材料[1].物品.级别限制*10000*self.材料[2].物品.锻炼等级
			end
		elseif self.处理项目 == "星辉石转移" then
			if self.材料[2].物品 and self.材料[2].物品.幻化等级 then
				self.总价 = self.材料[1].物品.级别限制*20000*self.材料[2].物品.幻化等级
			end
		end
		self.消耗体力 = 0
		self.总价 = 0
	elseif self.分类 == "合成" then
		self.总价 = 0
		if self.材料[1].物品 ~= nil and self.材料[2].物品 ~= nil then
			if self.处理项目 == "宝石" and self.材料[1].物品.分类 == 6 then
				self.消耗体力 = (self.材料[1].物品.级别限制 or 0)  *10
			elseif self.处理项目 == "碎石锤"  and self.材料[1].物品.名称 == "碎石锤" then
				self.消耗体力 = (self.材料[1].物品.级别限制 or 0)  *10
			elseif self.处理项目 == "星辉石"  and self.材料[1].物品.名称 == "星辉石" then
				self.消耗体力 = (self.材料[1].物品.级别限制 or 0)  *10
			elseif self.处理项目 == "钟灵石"  and self.材料[1].物品.名称 == "钟灵石" then
				self.消耗体力 = (self.材料[1].物品.级别限制 or 0)  *10
			elseif self.处理项目 == "精魄灵石"  and self.材料[1].物品.名称 == "精魄灵石" then
				self.消耗体力 = (self.材料[1].物品.级别限制 or 0)  *10
			elseif self.处理项目 == "变身卡"   and self.材料[1].物品.名称 == "怪物卡片" then
				self.消耗体力 = (self.材料[1].物品.等级 or 0) *10
			elseif self.处理项目 == "百炼精铁"   and self.材料[1].物品.名称 == "百炼精铁" then
				self.消耗体力 = self.材料[1].物品.子类 or 0
			elseif self.处理项目 == "暗器" then
				if self.材料[1].物品 ~= nil and self.材料[2].物品 ~= nil then
					local a = 0
					local b = 0
					if self.材料[1].物品.分类 and self.材料[2].物品.分类 then
						if self.材料[1].物品.分类 >= self.材料[2].物品.分类 then
							a = self.材料[1].物品.分类
							b = self.材料[2].物品.分类
						else
						    a = self.材料[2].物品.分类
						    b = self.材料[1].物品.分类
						end
						self.消耗体力 = a
						self.总价 = a*a + b*b
					end
				end
			end
		end
	elseif self.分类 == "熔炼" then
		if self.处理项目 == "熔炼装备" then
			local a=60
			if self.材料[1].物品 ~= nil then
				if self.材料[1].物品.总类 == 2 then
					a = self.材料[1].物品.级别限制
				end
			end
			if self.材料[2].物品 ~= nil then
				if self.材料[2].物品.总类 == 2 then
					a = self.材料[2].物品.级别限制
				end
			end
			self.消耗体力 = math.floor(a/10)
			self.总价 = math.ceil(a/60)*20000
		elseif self.处理项目 == "还原装备" then
			self.总价 = math.ceil(self.材料[1].物品.级别限制*10000)
		end
	elseif self.分类 == "修理" then
		if self.材料[1].物品 ~= nil then
			if self.材料[1].物品.总类 == 2 then
				self.消耗体力 = (self.材料[1].物品.级别限制 or 0)  +20
			end
		end
	elseif self.分类 == "分解" then
		if self.材料[1].物品 ~= nil then
			if self.材料[1].物品.总类 == 2 then
				local xh = self:取分解(self.材料[1].物品.级别限制,self.材料[1].物品.分类)
				self.消耗体力 = xh[2]
				self.总价 = xh[1]
			end
		end
	end
end

function 场景类_打造:显示(dt,x,y)
	self.焦点 = false
	self.资源组[2]:更新(x,y)
	self.资源组[9]:更新(x,y,self.分类~="打造")
	self.资源组[10]:更新(x,y,self.分类~="镶嵌")
	self.资源组[11]:更新(x,y,self.分类~="合成")
	self.资源组[12]:更新(x,y,self.分类~="修理")
	self.资源组[13]:更新(x,y,self.分类~="熔炼")
	self.资源组[14]:更新(x,y,self.分类~="分解")
	self.资源组[15]:更新(x,y,self.分类~="神器")
	self.资源组[4]:更新(x,y,self.开始 ~= 1)
	self.资源组[5]:更新(x,y,self.结束 ~= 160)

	self.资源组[1]:显示(self.x,self.y)
	self.资源组[8]:显示(self.x+2,self.y+2)
	self.资源组[2]:显示(self.x + 269+167,self.y + 4,true)
	for i=1,7 do
		self.资源组[8+i]:显示(self.x+15+(i-1)*62,self.y+35)
	end
	tp.物品界面背景_:显示(self.x+193,self.y+102)
    tp.窗口标题背景_[3]:显示(self.x+self.资源组[1].宽度/2-60,self.y)
    zts:置颜色(白色):显示(self.x+self.资源组[1].宽度/2-30,self.y+3,"  制 造")
	zts:置颜色(白色)

	if self.鼠标 then
    if self.资源组[2]:事件判断() then
    	self:打开()
    	return
    elseif self.资源组[9]:事件判断() then
			self.分类="打造"
			可选项目 = {"强化人物装备","普通人物装备","召唤兽装备","强化灵饰淬灵","灵饰淬灵"}
			self.处理项目 = "强化人物装备"
			self:内部刷新道具(tp.道具列表)
			cs=2
		elseif self.资源组[10]:事件判断() then
			self.分类="镶嵌"
			self:内部刷新道具(tp.道具列表)
			self.处理项目 = "宝石"
			可选项目 = {"宝石","星辉石","钟灵石","宝石转移","星辉石转移","珍珠","点化石","精魄灵石"}
			cs=2
		elseif self.资源组[11]:事件判断() then
			self.分类="合成"
			self:内部刷新道具(tp.道具列表)
			self.处理项目 = "宝石"
			可选项目 = {"宝石","星辉石","钟灵石","精魄灵石","变身卡","百炼精铁","暗器"}
			cs=2
		elseif self.资源组[12]:事件判断() then
			self.分类="修理"
			self:内部刷新道具(tp.道具列表)
			self.处理项目 = "人物装备"
			可选项目 = {"人物装备","召唤兽装备"}
			cs=1
		elseif self.资源组[13]:事件判断() then
			self.分类="熔炼"
			可选项目 = {"熔炼装备","还原装备"}
			self:内部刷新道具(tp.道具列表)
			self.处理项目 = "熔炼装备"
			cs=2
		elseif self.资源组[14]:事件判断() then
			self.处理项目 = "人物装备"
			可选项目 = {"人物装备","召唤兽装备"}
		 	self.分类="分解"
			self:内部刷新道具(tp.道具列表)
			cs=1
		elseif self.资源组[15]:事件判断() then
			-- tp.常规提示:打开("#Y/暂未开放")
			-- if 1~=1 then
			-- 	self.分类="神器"
			-- 	self:内部刷新道具(tp.道具列表)
			-- end
			tp.窗口.对话栏:文本("物件_打铁炉","物件_打铁炉","你想进行哪种操作呢？",{"炼制灵犀之屑","合成灵犀玉","更换神器五行"})
			self:打开()
			return 0
		elseif self.资源组[3]:事件判断()  then
   		if self.材料[1].物品 ~= nil and (self.材料[2].物品~=nil or self.分类=="修理" or self.处理项目=="还原装备") then
   			local 事件 = function ()
   				请求服务(4501,{序列=self.材料[1].道具序列,序列1=self.材料[2].道具序列,序列2=self.材料[3].道具序列,类型=self.分类,分类=self.处理项目})
   			end
	   		if self.分类=="修理" then
	   			tp.窗口.文本栏:载入("#H修理装备有一定的失败风险,你确定要进行修理么?",nil,true,事件)
	   		elseif self.分类=="镶嵌" then
	   			if self.处理项目 == "宝石转移" then
	   		 		tp.窗口.文本栏:载入("#H你确定要将副道具宝石转移至主装备么?",nil,true,事件)
	   		 	elseif self.处理项目 == "星辉石转移" then
	   		 		tp.窗口.文本栏:载入("#H你确定要将副道具星辉石转移至主装备么?",nil,true,事件)
	   		 	 else
	   		 	 	事件()
	   		 	-- 	tp.窗口.文本栏:载入("#H你确定要将该道具宝石镶嵌该装备么?",nil,true,事件)
	   		 	end
	   		elseif self.分类=="分解" then
	   			tp.窗口.文本栏:载入("#H你确定要将该装备进行分解么?一旦分解无法找回！",nil,true,事件)
	   		elseif self.处理项目=="还原装备" then
	   			tp.窗口.文本栏:载入("#H你确定要将该装备重铸属性还原么?一旦分解无法取消！",nil,true,事件)
	   		else
	   			事件()
	   		end
    	end
    end
	end


	for i=0,3 do
		self.资源组[19]:显示(self.x+85,self.y+185+i*24)
		if self.分类 == "分解" and i == 0 then
			zts:显示(self.x+15,self.y+188+i*24,"需分解符")
		else
			zts:显示(self.x+15,self.y+188+i*24,sts[i+1])
		end
	end
	self.资源组[19]:显示(self.x+55,self.y+76)
	if self.处理项目 == "星辉石" and self.分类=="合成" then
		self.资源组[51]:显示(self.x + 2,self.y + 97)
		self.资源组[52]:显示(self.x + 10+4,self.y + 108)
		self.资源组[52]:显示(self.x + 70,self.y + 108)
		self.资源组[52]:显示(self.x + 126,self.y + 108)
		for ns=1,3 do
			self.材料[ns]:置坐标(self.x-43 + (ns * 57),self.y+108)
			self.材料[ns]:显示(dt,x,y,self.鼠标,false)
			if self.材料[ns].物品 ~= nil and self.材料[ns].焦点 then
				self.焦点 = true
				tp.提示:道具行囊(x,y,self.材料[ns].物品)
				if mouseb(0) and self.鼠标 then
					if ns == 1 then
						self.材料1总价 = 0
					else
						self.材料2总价 = 0
					end
					self.物品[self.材料[ns].道具序列]:置物品(self.材料[ns].物品)
					刷新道具逻辑(self.物品[self.材料[ns].道具序列].物品,self.材料[ns].道具序列,true)
					self.材料[ns]:置物品(nil)
					break
				end
			end

		end
	else
		if cs == 1 then
			self.资源组[20]:显示(self.x + 35,self.y + 108)
			self.资源组[50]:显示(self.x + 17,self.y + 98)
		else
			self.资源组[20]:显示(self.x + 35,self.y + 108)
			self.资源组[21]:显示(self.x + 115,self.y + 108)
			self.资源组[50]:显示(self.x + 17,self.y + 98)
		end
		for ns=1,2 do
				self.材料[ns]:置坐标(self.x-27 + (ns * 68),self.y+108)
				self.材料[ns]:显示(dt,x,y,self.鼠标,false)
				if self.材料[ns].物品 ~= nil and self.材料[ns].焦点 then
					self.焦点 = true
					tp.提示:道具行囊(x,y,self.材料[ns].物品)
					if mouseb(0) and self.鼠标 then
						if ns == 1 then
							self.材料1总价 = 0
						else
							self.材料2总价 = 0
						end
						self.物品[self.材料[ns].道具序列]:置物品(self.材料[ns].物品)
						刷新道具逻辑(self.物品[self.材料[ns].道具序列].物品,self.材料[ns].道具序列,true)
						self.材料[ns]:置物品(nil)
						break
					end
				end
		end
	end
	self.资源组[24]:更新(x,y)
	self.资源组[24]:显示(self.x+143,self.y+75)
	self.资源组[25]:显示(self.x+55,self.y+96,x,y,self.鼠标)
	zts:显示(self.x+190,self.y+72,"所需材料：")
	if self.资源组[24]:事件判断() then
		self.资源组[25]:打开(可选项目)
		self.资源组[25]:置选中(self.处理项目)
	elseif self.资源组[25]:事件判断() then
		self.处理项目 = self.资源组[25].弹出事件
		self:内部刷新道具(tp.道具列表)
		self.资源组[25].弹出事件 = nil
	end
	zts:显示(self.x+20,self.y+78,self.分类)
	zts1:置颜色(黑色):显示(self.x+62,self.y+79,self.处理项目)
  zts:置颜色(黄色)
  zts:显示(self.x+255,self.y+72,self:所需材料(self.处理项目))
  	self.资源组[3]:显示(self.x + 70,self.y + 310,true)



	if self.分类=="打造" then
		self.资源组[3]:更新(x,y,self.材料[1].物品 ~= nil and self.材料[2].物品 ~= nil)
		self.资源组[3]:置文字("打造")
	    zts1:置颜色(黑色):显示(self.x+62,self.y+79,self.处理项目)
	elseif self.分类=="镶嵌" then
		self.资源组[3]:更新(x,y,self.材料[1].物品 ~= nil and self.材料[2].物品 ~= nil)
		self.资源组[3]:置文字("镶嵌")
		if self.处理项目 == "宝石转移" or self.处理项目 == "星辉石转移" then
			zts1:置颜色(红色)
			zts1:显示(self.x+189,self.y+88,"此操作会将副材料宝石转移至主材")
			zts1:置颜色(白色)
			self.资源组[3]:置文字("转移")
		end
	    zts1:置颜色(黑色):显示(self.x+62,self.y+79,self.处理项目)
	elseif self.分类=="合成" then
		self.资源组[3]:更新(x,y,self.材料[1].物品 ~= nil and self.材料[2].物品 ~= nil)
		self.资源组[3]:置文字("合成")

		zts1:置颜色(黑色):显示(self.x+62,self.y+79,self.处理项目)
	elseif self.分类=="修理" then
		self.资源组[3]:更新(x,y,self.材料[1].物品 ~= nil)
		self.资源组[3]:置文字("修理")

		zts1:置颜色(黑色):显示(self.x+62,self.y+79,self.处理项目)
	elseif self.分类=="熔炼" then
		if self.处理项目 == "熔炼装备" then
			self.资源组[3]:置文字("熔炼")
		else
			self.资源组[3]:置文字("还原")
		end
		self.资源组[3]:更新(x,y,self.材料[1].物品 ~= nil)

		zts1:置颜色(黑色):显示(self.x+62,self.y+79,self.处理项目)
	elseif self.分类=="分解" then
		self.资源组[3]:更新(x,y,self.材料[1].物品 ~= nil)
		self.资源组[3]:置文字("分解")

		zts1:置颜色(黑色):显示(self.x+62,self.y+79,self.处理项目)
	elseif self.分类=="神器" then
		self.资源组[3]:更新(x,y,self.材料[1].物品 ~= nil)
		self.资源组[3]:置文字("神器")

	end
	for i=1,5 do
	   self.背包按钮[i]:更新(x,y,self.结束~=i*20)
       self.背包按钮[i]:显示(self.x+165+i*50,self.y+325)
       if self.背包按钮[i]:事件判断() then
       	  self.结束=i*20
       	  self.开始=self.结束-19
       end
	end

    local xx = 0
	local yy = 0

	for is=self.开始,self.结束 do
		self.物品[is]:置坐标(self.x + 195+xx * 51,self.y + 103+yy * 51)
		   	if self.物品[is].物品~=nil then
				self.物品[is]:显示(dt,x,y,self.鼠标, not self:取装备可用(is))
				if self.物品[is].焦点 then
					self.焦点 = true
					tp.提示:道具行囊(x,y,self.物品[is].物品)
					if self.处理项目 == "星辉石" and self.分类=="合成" then
						if self.物品[is].事件 and self:取装备可用(is) and self.鼠标 then
							local zl = self.物品[is].物品.子类
							if self.材料[1].物品 == nil then
								self.材料[1]:置物品(self.物品[is].物品)
								self.材料[1].道具序列=is
								self:打造公式()
								self.物品[is]:置物品(nil)
							elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
								self.材料[2]:置物品(self.物品[is].物品)
								self.材料[2].道具序列=is
								self:打造公式()
								self.物品[is]:置物品(nil)
							elseif self.材料[1].物品 ~= nil and self.材料[2].物品 ~= nil and self.材料[3].物品 == nil then
								self.材料[3]:置物品(self.物品[is].物品)
								self.材料[3].道具序列=is
								self:打造公式()
								self.物品[is]:置物品(nil)
							else
								local cl1 = self.材料[1].物品
								local xl = self.材料[1].道具序列
								self.材料[1]:置物品(self.物品[is].物品)
								self.材料[1].道具序列=is
								self:打造公式()
								self.物品[xl]:置物品(cl1)
								self.物品[is]:置物品(nil)
							end
							刷新道具逻辑(self.物品[is].物品,is,true)
						end
					else
						if self.物品[is].事件 and self:取装备可用(is) and self.鼠标 then
							local zl = self.物品[is].物品.子类
							if self.材料[1].物品 == nil then
								self.材料[1]:置物品(self.物品[is].物品)
								self.材料[1].道具序列=is
								self:打造公式()
								self.物品[is]:置物品(nil)
							elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil and  self.处理项目~="还原装备"  and self.分类 ~= "修理" then
								self.材料[2]:置物品(self.物品[is].物品)
								self.材料[2].道具序列=is
								self:打造公式()
								self.物品[is]:置物品(nil)
							elseif self.材料[1].物品 ~= nil and self.材料[2].物品 ~= nil then
								if self.材料[1].物品.分类 == self.物品[is].物品.分类 and self.材料[1].物品.子类 == self.物品[is].物品.子类 then
									local cl1 = self.材料[1].物品
									local xl = self.材料[1].道具序列
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self:打造公式()
									self.物品[xl]:置物品(cl1)
									self.物品[is]:置物品(nil)
								elseif self.材料[2].物品.分类 == self.物品[is].物品.分类 and self.材料[2].物品.子类 == self.物品[is].物品.子类 then
									local cl2 = self.材料[2].物品
									local xl = self.材料[2].道具序列
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self:打造公式()
									self.物品[xl]:置物品(cl2)
									self.物品[is]:置物品(nil)
								end
							end
							刷新道具逻辑(self.物品[is].物品,is,true)
						end
					end
				end
			end
			xx =xx + 1
			if xx>=5 then
				xx = 0
				yy = yy + 1
			end

	end

	-- local is = self.开始 - 1
	-- for h=1,4 do
	-- 	for l=1,5 do
	-- 		is = is + 1

	-- 	end
	-- end
	if self.材料[1].物品 ~= nil and self.材料[2].物品 ~= nil or (self.分类 == "修理" and self.材料[1].物品 ~= nil)  or (self.处理项目 == "还原装备" and self.材料[1].物品 ~= nil)  then
		zts:置颜色(取金钱颜色(self.总价))
		zts:显示(self.x + 95,self.y + 187,self.总价)
		zts:置颜色(-16777216)
		zts:显示(self.x + 95,self.y + 236,self.消耗体力)
	end
	zts:置颜色(取金钱颜色(tp.金钱))
	zts:显示(self.x + 95,self.y + 212,tp.金钱)
	zts:置颜色(-16777216)
	zts:显示(self.x + 95,self.y + 261,tp.队伍[1].体力)
	zts1:置颜色(白色)
	zts:置颜色(白色)
end

function 场景类_打造:取装备可用(is)
	local mc = self.物品[is].物品.名称
	if self.分类=="打造" then
		if self.处理项目 == "召唤兽装备" and (mc == "上古锻造图策" or mc == "天眼珠" or mc == "三眼天珠" or mc == "九眼天珠") then
			return true
		elseif (self.处理项目 == "强化人物装备" or self.处理项目 == "普通人物装备") and  (mc == "制造指南书" or mc == "百炼精铁") then
			return true
		elseif (self.处理项目 == "强化灵饰淬灵"or self.处理项目 == "灵饰淬灵") and (mc == "灵饰指南书" or mc == "元灵晶石") then
			return true
		-- elseif (self.处理项目 == "元身打造") and (mc == "战魂" or self.物品[is].物品.总类==66 and self.物品[is].物品.分类 ==1) then
		-- 	return true
		end
		return false
	elseif self.分类=="镶嵌" then
		if self.处理项目 == "宝石" and mc ~= "星辉石" and (self.物品[is].物品.总类==2 and self.物品[is].物品.分类 <=6 or self.物品[is].物品.总类==5 and self.物品[is].物品.分类==6) then
			return true
		elseif self.处理项目 == "星辉石" and (mc == "星辉石" or (self.物品[is].物品.总类==2 and self.物品[is].物品.分类 >=10 and self.物品[is].物品.分类 <=13)) then
			return true
		elseif self.处理项目 == "钟灵石" and (mc == "钟灵石" or (self.物品[is].物品.总类==2 and self.物品[is].物品.分类 >=10 and self.物品[is].物品.分类 <=13)) then
			return true
		elseif self.处理项目 == "珍珠"  and (mc == "珍珠" or self.物品[is].物品.总类==2 and self.物品[is].物品.分类 <=9) then
			return true
		elseif self.处理项目 == "点化石" and (mc == "点化石" or self.物品[is].物品.总类==2 and self.物品[is].物品.分类 <=9 and self.物品[is].物品.分类 >=7) then
			return true
		elseif self.处理项目 == "精魄灵石" and (mc == "精魄灵石" or self.物品[is].物品.总类==2 and self.物品[is].物品.分类 <=9 and self.物品[is].物品.分类 >=7) then
			return true
		elseif self.处理项目 == "宝石转移" and self.物品[is].物品.总类==2 and self.物品[is].物品.分类 <=6 then
			return true
		elseif self.处理项目 == "星辉石转移" and self.物品[is].物品.总类==2 and self.物品[is].物品.分类 <=13 and self.物品[is].物品.分类>=10 then
			return true
		end
		return false
	elseif self.分类=="熔炼" then
		if self.处理项目 == "熔炼装备" and (self.物品[is].物品.总类==2 and self.物品[is].物品.分类 <=6 or mc == "钨金") then
			return true
		elseif self.处理项目 == "还原装备" and self.物品[is].物品.总类==2 and self.物品[is].物品.分类 <=6 then
			return true
		end
		return false
	elseif self.分类=="合成" then
		if self.处理项目 == "宝石" and mc ~= "星辉石" and self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类==6 then
			return true
		elseif self.处理项目 == "星辉石" and mc == "星辉石" then
			return true
		elseif self.处理项目 == "钟灵石" and mc == "钟灵石" then
			return true
		elseif self.处理项目 == "精魄灵石" and mc == "精魄灵石" then
			return true
		elseif self.处理项目 == "变身卡" and mc == "怪物卡片" then
			return true
		elseif self.处理项目 == "碎石锤" and mc == "碎石锤" then
			return true
		elseif self.处理项目 == "百炼精铁" and mc == "百炼精铁" then
			return true
		elseif self.处理项目 == "暗器" and self.物品[is].物品.总类 == 2000 then
			return true
		end
		return false
	elseif self.分类=="修理" then
		if (self.物品[is].物品.总类==2 and self.物品[is].物品.分类 <=9) then
			return true
		end
		return false
	elseif self.分类=="分解" then
		if mc == "分解符" or (self.物品[is].物品.总类==2 and self.物品[is].物品.分类 <=13) then
			return true
		end
		return false
	end
	return false
end

function 场景类_打造:所需材料(类型)
	if 类型 == "强化人物装备" or 类型 == "普通人物装备" then
		return "制造指南书、百炼精铁"
	elseif self.分类=="打造" and 类型 == "召唤兽装备" then
		return "天眼珠、上古锻造图册"
	elseif self.分类=="打造" and (类型 == "强化灵饰淬灵" or 类型 == "灵饰淬灵") then
		return "灵饰指南书、元灵晶石"
	-- elseif self.分类=="打造" and 类型 == "元身打造"  then
	-- 	return "战魂、陨铁"
	elseif self.分类=="镶嵌"  then
		if 类型 == "宝石" then
			return 类型.."、人物装备"
		elseif  类型 == "星辉石" then
			return 类型.."、人物灵饰"
		elseif 类型 == "宝石转移" then
			return "相同类型人物装备"
		elseif 类型 == "星辉石转移" then
			return "人物灵饰"
		end
	elseif 类型 == "珍珠" then
		return 类型.."、人物装备/召唤兽装备"
	elseif 类型 == "点化石" then
		return "点化石、召唤兽装备"
	elseif 类型 == "精魄灵石" then
		return "精魄灵石、召唤兽装备"
	elseif self.分类=="合成" then
		return 类型
	elseif self.分类=="分解" then
		return 类型.."、分解符"
	else
		return 类型
	end
end

function 场景类_打造:取分解(等级,类型)
  if 类型 <= 6 or (类型 >=10 and 类型 <= 13)then
    if 等级 == 60 then
      return {5,90,1}
    elseif 等级 == 70 then
      return {5,105,取随机数(1,2)}
    elseif 等级 == 80 then
      return {5,120,取随机数(2,3)}
    elseif 等级 == 90 then
      return {6,135,取随机数(2,4)}
    elseif 等级 == 100 then
      return {6,150,取随机数(3,5)}
    elseif 等级 == 110 then
      return {7,165,取随机数(3,5)}
    elseif 等级 == 120 then
      return {12,180,取随机数(4,6)}
    elseif 等级 == 130 then
      return {16,195,取随机数(5,6)}
    elseif 等级 == 140 then
      return {23,210,取随机数(5,6)}
    else
      return {999,9999,取随机数(5,6)}
    end
  else
    if 等级 == 65 then
      return {4,90,1}
    elseif 等级 == 75 then
      return {4,105,1}
    elseif 等级 == 85 then
      return {4,120,取随机数(1,2)}
    elseif 等级 == 95 then
      return {4,135,取随机数(1,2)}
    elseif 等级 == 105 then
      return {5,150,取随机数(2,3)}
    elseif 等级 == 115 then
      return {5,165,取随机数(2,3)}
    elseif 等级 == 125 then
      return {8,180,取随机数(4,6)}
    elseif 等级 == 135 then
      return {16,195,取随机数(5,6)}
    elseif 等级 == 145 then
      return {23,210,取随机数(5,6)}
     else
      return {999,9999,取随机数(5,6)}
    end
  end
end

function 场景类_打造:检查点(x,y)


	if self.可视  and self.资源组[1]:是否选中(x,y)  then
       self.焦点 =false
		return true
	end
	return false
end

function 场景类_打造:初始移动(x,y)

	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间

 	end
	if not self.焦点 then

		tp.移动窗口 = true
	end
	if self.可视 and self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_打造:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end










return 场景类_打造