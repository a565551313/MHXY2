--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-03-06 03:33:13
--======================================================================--
local 场景类_鉴定道具栏 = class()
local require = require
local tp,zts1
local floor = math.floor
local format = string.format
local insert = table.insert

function 场景类_鉴定道具栏:初始化(根)
	self.x = 78
	self.y = 179
	self.xx = 0
	self.yy = 0
	self.注释 = "鉴定装备"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	tp = 根
	zts1 = tp.字体表.描边字体
	self.开始 = 1
	self.结束 = 20
	self.窗口时间 = 0
	tp = 根
end

function 场景类_鉴定道具栏:打开(数据)
	self.数据 = 数据
	if self.可视 then
		self.可视 = false
		self.资源组=nil
		self.物品=nil
		return
	else
		insert(tp.窗口_,self)

		local 资源 = tp.资源
		local 按钮 = tp._按钮
		local 自适应 = tp._自适应
		self.资源组 = {

			[1] = 自适应.创建(0,1,295,275,3,9),
			[2] = 按钮.创建(tp._自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
			[3] = 自适应.创建(1,1,291,18,1,3,nil,18),--标题背景


		}

		-- 动态创建最大10页按钮
		self.背包按钮 = {}
		for i=1,10 do
			self.背包按钮[i] = 按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,tostring(i))
			self.背包按钮[i]:置偏移(-2,-2)
		end
	     self.开始 = 1
	     self.结束 = 20
		self.物品 = {}
		local 格子 = tp._物品格子
		for i=1,200 do
	        self.物品[i] = 格子.创建(0,0,i,"道具类")
	    end
		for n=1,200 do
			self.物品[n]:置物品(self.数据.道具.道具[n])
		end
		self.可视 = true
		tp.运行时间 = tp.运行时间 + 1
	  	self.窗口时间 = tp.运行时间
	end
end

function 场景类_鉴定道具栏:更新(dt,x,y)

 self.鼠标=self:检查点(x,y)
end
function 场景类_鉴定道具栏:取可用道具(名称,物品)


end
function 场景类_鉴定道具栏:显示(dt,x,y)
	if not self.可视 then
		return false
	end
	self.焦点 = false


	   self.资源组[2]:更新(x,y)
		if self.资源组[2]:事件判断() then
			self:打开()
				return
		end

	self.资源组[1]:显示(self.x,self.y)
	self.资源组[3]:显示(self.x+2,self.y+2)
	tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	self.资源组[2]:显示(self.x + 275,self.y + 2,true)

	for i=1,math.ceil(tp.总格/20) do
	   self.背包按钮[i]:更新(x,y,self.结束~=i*20)
       self.背包按钮[i]:显示(self.x-13+i*28,self.y+245)
       if self.背包按钮[i]:事件判断() then
        self.结束=i*20
        self.开始=self.结束-19
       end
	end

	zts1:显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"鉴定点化")
	local xx = 0
	local yy = 0
     tp.物品界面背景_:显示(self.x+19,self.y+25)
	for n=self.开始,self.结束 do
			self.物品[n]:置坐标(self.x+21+xx*50,self.y+25+yy*50)
			self.物品[n]:显示(dt,x,y,self.鼠标,{2})
			if self.物品[n].物品~=nil and self.物品[n].焦点 then
				tp.提示:道具行囊(x,y,self.物品[n].物品)
				if self.物品[n].事件 and self.物品[n].物品.总类 == 2 and self.鼠标 then
					local 物品编号 = n
                    if self.物品[n].物品.鉴定 == false  then
                    	if self.数据.编号 ~=nil and self.物品[self.数据.编号].物品.名称 == "神兵图鉴" then
	                    	    if self.物品[n].物品.分类 == 3 or self.物品[n].物品.分类 == 4 then
	                    	    	if self.物品[n].物品.级别限制 > self.物品[self.数据.编号].物品.子类 then
	                    	    	    tp.常规提示:打开("#Y/神兵图鉴的等级过低无法鉴定该装备")
	                    	    	else
	                    	    		请求服务(4510,{序列=self.物品[n].物品,序列1=self.数据.编号,序列2=n})
	                    	    		self.可视 = false
	                    	    	end
	                    	    else
	                    			tp.常规提示:打开("#Y/神兵图鉴只能鉴定武器和衣服")
	                    		end
                    	elseif self.数据.编号 ~=nil and self.物品[self.数据.编号].物品.名称 == "灵宝图鉴" then
                    		if self.物品[n].物品.分类 == 3 or self.物品[n].物品.分类 == 4 then
                    	    	tp.常规提示:打开("#Y/灵宝图鉴只能鉴定帽子、鞋子、腰带和饰品")
                    	   elseif  self.物品[n].物品.灵饰 then
                    	    	tp.常规提示:打开("#Y/灵宝图鉴只能鉴定帽子、鞋子、腰带和饰品")
                    	    else
                    			if self.物品[n].物品.级别限制 > self.物品[self.数据.编号].物品.子类 then
                    	    	    tp.常规提示:打开("#Y/灵宝图鉴的等级过低无法鉴定该装备")
                    	    	else
                    	    		请求服务(4510,{序列=self.物品[n].物品,序列1=self.数据.编号,序列2=n})
                    	    		self.可视 = false
                    	    	end
                    		end
                    	elseif self.数据.编号 ~=nil and self.物品[self.数据.编号].物品.名称 == "灵饰图鉴" then
                    		if not self.物品[n].物品.灵饰 then
                    	    	tp.常规提示:打开("#Y/灵饰图鉴只能鉴定灵饰")
                    	    else
                    			if self.物品[n].物品.级别限制 > self.物品[self.数据.编号].物品.子类 then
                    	    	    tp.常规提示:打开("#Y/灵宝图鉴的等级过低无法鉴定该装备")
                    	    	else
                    	    		请求服务(4510,{序列=self.物品[n].物品,序列1=self.数据.编号,序列2=n})
                    	    		self.可视 = false
                    	    	end
                    		end
                    	elseif self.数据.名称 == "兵器谱" then
                    		if self.物品[n].物品.分类 == 3 or self.物品[n].物品.分类 == 4 then
                    	    	if self.物品[n].物品.级别限制 > self.数据.等级 then
                    	    	    tp.常规提示:打开("#Y/神兵图鉴的等级过低无法鉴定该装备")
                    	    	    self.可视 = false
                    	    	else
                    	    		请求服务(4510,{序列=self.物品[n].物品,序列2=n,数据=self.数据})
                    	    		self.可视 = false
                    	    	end
                    	    else
                    			tp.常规提示:打开("#Y/神兵图鉴只能鉴定武器和衣服")
                    			self.可视 = false
                    		end
                    	elseif self.数据.名称 == "堪察令" then
                    		if self.物品[n].物品.分类 == 3 or self.物品[n].物品.分类 == 4 then
                    	    	tp.常规提示:打开("#Y/灵宝图鉴只能鉴定帽子、鞋子、腰带和饰品")
                    	    	self.可视 = false
                    	    else
                    			if self.物品[n].物品.级别限制 > self.数据.等级 then
                    	    	    tp.常规提示:打开("#Y/灵宝图鉴的等级过低无法鉴定该装备")
                    	    	    self.可视 = false
                    	    	else
                    	    		请求服务(4510,{序列=self.物品[n].物品,序列2=n,数据=self.数据})
                    	    		self.可视 = false
                    	    	end
                    		end
                    	end
                    else
                    	if self.数据.编号 ~=nil and self.物品[self.数据.编号].物品.名称 == "仙灵丹"  then
                    		 if self.物品[n].物品.灵饰 then
                    	 	     	tp.常规提示:打开("#Y/灵饰无法获得仙人赐福")
		                     elseif self.物品[n].物品.赐福 == nil or self.物品[n].物品.赐福.总类 == nil then
		                       local 事件 = function()
								      请求服务(4518,{序列=self.物品[n].物品,序列1=self.数据.编号,序列2=物品编号})
								 end
								tp.窗口.文本栏:载入("未被赐福的装备只有5%几率添加是否添加赐福",nil,true,事件)
		                        self.可视 = false
		                    else
		                      请求服务(4518,{序列=self.物品[n].物品,序列1=self.数据.编号,序列2=n})
		                      self.可视 = false
		                    end
		                elseif self.数据.编号 ~=nil and self.物品[self.数据.编号].物品.名称 == "特效点化石" then
		                	   if self.物品[n].物品.灵饰 then
                    	 	     	tp.常规提示:打开("#Y/灵饰无法附加特技")
                    		   elseif self.物品[n].物品.特效~=nil  then
                    	    		 local 事件 = function()
								          请求服务(4519,{序列=self.物品[n].物品,序列1=self.数据.编号,序列2=物品编号})
								       end
								     tp.窗口.文本栏:载入("你确定改变该装备的特效么",nil,true,事件)
								     self.可视 = false
                    	    	else
                    	    		 请求服务(4519,{序列=self.物品[n].物品,序列1=self.数据.编号,序列2=n})
                    	    		self.可视 = false
                    	    	end
                    	 elseif self.数据.编号 ~=nil and self.物品[self.数据.编号].物品.名称 == "特技点化石" then
                    	 	   if self.物品[n].物品.灵饰 then
                    	 	     	tp.常规提示:打开("#Y/灵饰无法附加特技")
                    		   elseif self.物品[n].物品.特技~=nil  then
                    	    		 local 事件 = function()
								          请求服务(4520,{序列=self.物品[n].物品,序列1=self.数据.编号,序列2=物品编号})
								       end
								     tp.窗口.文本栏:载入("你确定改变该装备的特技么",nil,true,事件)
								     self.可视 = false
                    	    	else
                    	    		 请求服务(4520,{序列=self.物品[n].物品,序列1=self.数据.编号,序列2=n})
                    	    		 self.可视 = false
                    	    	end
                        elseif self.数据.编号 ~=nil and self.物品[self.数据.编号].物品.名称 == "无级别点化石" then
                    	 	   if self.物品[n].物品.灵饰 then
                    	 	     	tp.常规提示:打开("#Y/灵饰无法附加特技")
                    	    	else
                    	    		 请求服务(4521,{序列=self.物品[n].物品,序列1=self.数据.编号,序列2=n})
                    	    		 self.可视 = false
                    	    	end
                    	 elseif self.数据.编号 ~=nil and self.物品[self.数据.编号].物品.名称 == "灵饰点化石" then
                    	 	   if not self.物品[n].物品.灵饰 then
                    	 	     	tp.常规提示:打开("#Y/不是灵饰无法附加特效")
                    	    	else
                    	    		 请求服务(4522,{序列=self.物品[n].物品,序列1=self.数据.编号,序列2=n})
                    	    		 self.可视 = false
                    	    	end
                    	elseif self.数据.编号 ~=nil and self.物品[self.数据.编号].物品.名称 == "灵饰洗炼石" then
                    	 	   if not self.物品[n].物品.灵饰 then
                    	 	     	tp.常规提示:打开("#Y/不是灵饰无法附加特效")
                    	    	else
                    	    		 请求服务(4523,{序列=self.物品[n].物品,序列1=self.数据.编号,序列2=n})
                    	    		 self.可视 = false
                    	    	end

                    	elseif self.数据.编号 ~=nil and (self.物品[self.数据.编号].物品.名称 == "鸿蒙灵宝"
                    			or self.物品[self.数据.编号].物品.名称 == "鸿蒙仙宝" or self.物品[self.数据.编号].物品.名称 == "鸿蒙神宝"
                    			or self.物品[self.数据.编号].物品.名称 == "太初灵石" or self.物品[self.数据.编号].物品.名称 == "太初仙石"
                    			or self.物品[self.数据.编号].物品.名称 == "太初神石" or self.物品[self.数据.编号].物品.名称 == "鸿蒙原石"
                    			or self.物品[self.数据.编号].物品.名称 == "太初原石" )then
                    			if self.物品[n].物品.灵饰 or self.物品[n].物品.分类 >6 then
	                    	 	     	tp.常规提示:打开("#Y/只有装备才能使用该道具")
			                    else
				                      请求服务(4524,{序列=self.物品[n].物品,序列1=self.数据.编号,序列2=n})
				                      self.可视 = false
			                    end







                        else
                            tp.常规提示:打开("#Y/已鉴定的装备无法再鉴定")
                        end
                    end
                    刷新道具逻辑(self.物品[n].物品,n,true)
                end
			end
			xx =xx + 1
			if xx>=5 then
				xx = 0
				yy = yy + 1
			end
	end




end

function 场景类_鉴定道具栏:检查点(x,y)
	if self.可视 and self.资源组~=nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
	return false
end

function 场景类_鉴定道具栏:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not 引擎.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.场景.战斗.移动窗口 = true
	end
	if self.可视 and self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_鉴定道具栏:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_鉴定道具栏