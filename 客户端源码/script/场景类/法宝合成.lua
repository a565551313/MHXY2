--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:11:31
--======================================================================--
local 场景类_法宝合成 = class()

local floor = math.floor
local tp,zts1
local insert = table.insert
local mouseb = 引擎.鼠标弹起

function 场景类_法宝合成:初始化(根)
	self.ID = 87
	self.xx = 0
	self.yy = 0
	self.x=137
	self.y=162
	self.注释 = "法宝合成"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.开始 = false
	self.可移动 = true
	tp = 根
	zts1 = tp.字体表.描边字体
	self.窗口时间 = 0
	self.选中物品 = 0
end
function 场景类_法宝合成:完成后关闭(数据)

		self.可视 = false

end
function 场景类_法宝合成:打开(数据)
	if self.可视 then
		self.可视 = false
		self.资源组 = nil
		self.合成 = nil
		self.物品 = nil
		self.选中材料 = nil
		return
	else
		insert(tp.窗口_,self)
		self:加载资源()
		tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.点击类型="道具"
	    self.数据=数据
	    self.选中物品 = 0
	    for i=1,20 do
			self.物品[i]:置物品(self.数据.道具[i])
			self.物品[i].选中 = nil
		end
		for i=1,5 do
			self.合成[i]:置物品(nil)
		end
	    self.可视 = true
	end
end
function 场景类_法宝合成:加载资源()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x01000040),
		[2] = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0xF11233BB),0,0,4,true,true),
		[3] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"开始"),
		[4] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"完成"),
		[5] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xBB25066F),
	}
	local 格子 = tp._物品格子
	self.合成={}
	for i=1,5 do
		self.合成[i]=格子.创建(0,0,i,"法宝合成")
	end
	self.物品 = {}
	for i=1,20 do
		self.物品[i] = 格子.创建(0,0,i,"道具行囊_物品")
	end
	self.选中材料={}
	for i=1,5 do
        self.选中材料[i] = 0
    end
end

function 场景类_法宝合成:显示(dt,x,y)
	self.焦点 = false
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y,self.开始==false)
	self.资源组[4]:更新(x,y,self.开始)
	local 空位 = 0
	if self.资源组[2]:事件判断() then
		self:打开()
		self.开始=false
		return false
	elseif self.资源组[3]:事件判断() then
		for n=1,5 do
			if self.合成[n].物品==nil then
				空位=空位+1
			end
		end
		if 空位>=3 then
		    tp.常规提示:打开("#Y/合成法宝的材料不够哦")
			self.开始=false
		else
			self.开始=true
		end
	elseif self.资源组[4]:事件判断() then
		请求服务(3754,{序列=self.选中材料[1]..","..self.选中材料[2]..","..self.选中材料[3]..","..self.选中材料[4]..","..self.选中材料[5]})
		self.开始=false
		self:完成后关闭()
	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[2]:显示(self.x+560,self.y+3)
	self.资源组[3]:显示(self.x+460,self.y+268)
	self.资源组[4]:显示(self.x+520,self.y+268)
	if self.开始 then
	    self.资源组[5]:更新(x,y)
	    self.资源组[5]:显示(self.x+351+80,self.y+66+77)
	end
	local xx = 0
	local yy = 0
	for i=1,20 do
		local jx = xx*51+23
		local jy = yy*51+35
		self.物品[i]:置坐标(jx + self.x,jy + self.y)
		self.物品[i]:显示(dt,x,y,self.鼠标,{1001})
		if self.物品[i].焦点 then
			if self.物品[i].物品 ~= nil then
				tp.提示:道具行囊(x,y,self.物品[i].物品)
			end
		end
		xx = xx + 1
		if xx == 5 then
			xx = 0
			yy = yy + 1
		end
		self.合成[1]:置坐标(self.x+298,jy + self.y-150)
		self.合成[2]:置坐标(self.x+513,jy + self.y-150)
		self.合成[3]:置坐标(self.x+298,jy + self.y+5)
		self.合成[4]:置坐标(self.x+513,jy + self.y+5)
		self.合成[5]:置坐标(self.x+407,self.y+116)
		if self.物品[i].事件  then
			if tp.场景.抓取物品 == nil and self.物品[i].物品 ~= nil and self.鼠标 and self.物品[i].物品.总类==1001 and 引擎.鼠标弹起(0x00)  then
             	local 允许拿起=true
          	 	if self.物品[self.选中物品]~=nil then
                  	self.物品[self.选中物品].选中=nil
          	 	end
             	if self.选中物品~=i then
                 	self.选中物品=i
                 	self.物品[i].选中=true
                 	允许拿起=false
             	end
             	if 允许拿起 then
				  	tp.场景.抓取物品 = self.物品[i].物品
				 	tp.场景.抓取物品ID = i
				 	tp.场景.抓取物品注释 = self.物品[i].注释
				 	self.物品[tp.场景.抓取物品ID].确定 = true
				 	self.物品[i]:置物品(nil)
				end
			elseif mouseb(0) and tp.场景.抓取物品 ~= nil then
				self.物品[tp.场景.抓取物品ID]:置物品(tp.场景.抓取物品)
				self.物品[tp.场景.抓取物品ID].确定 = false
			  	tp.场景.抓取物品 = nil
			 	tp.场景.抓取物品ID = nil
			 	tp.场景.抓取物品注释 = nil
			end
		end
		if mouseb(1) and tp.场景.抓取物品 ~= nil then
			self.物品[tp.场景.抓取物品ID]:置物品(tp.场景.抓取物品)
			self.物品[tp.场景.抓取物品ID].确定 = false
		  	tp.场景.抓取物品 = nil
		 	tp.场景.抓取物品ID = nil
		 	tp.场景.抓取物品注释 = nil
		end
	end

	for n=1,5 do
		if self.合成[n].事件 and tp.场景.抓取物品 ~= nil then
			if self.合成[n].物品 == nil then
				self.合成[n]:置物品(tp.场景.抓取物品)
				self.合成[n].道具序列=tp.场景.抓取物品ID
				self.选中材料[n]=self.合成[n].道具序列
				self.物品[tp.场景.抓取物品ID]:置物品(nil)
				self.物品[tp.场景.抓取物品ID].确定 = false
				self.物品[tp.场景.抓取物品ID].选中=nil
			  	tp.场景.抓取物品 = nil
			 	tp.场景.抓取物品ID = nil
			 	tp.场景.抓取物品注释 = nil
			elseif self.合成[n].物品 ~= nil then
			    local 道具位置 = self.合成[n].道具序列
			    local 临时物品 = self.合成[n].物品
			    self.合成[n]:置物品(tp.场景.抓取物品)
				self.合成[n].道具序列=tp.场景.抓取物品ID
				self.选中材料[n]=self.合成[n].道具序列
				self.物品[tp.场景.抓取物品ID]:置物品(nil)
				self.物品[tp.场景.抓取物品ID].选中=nil
				self.物品[道具位置]:置物品(临时物品)
			end
		end
	end

	for n=1,5 do
		self.合成[n]:显示(dt,x,y,self.鼠标,false)
		if self.合成[n].物品 ~= nil and self.合成[n].焦点 then
			tp.提示:道具行囊(x,y,self.合成[n].物品)
			if mouseb(0) and self.鼠标 then
				if 取物品数量() < 160 then
					local 临时物品 = self.合成[n].物品
					增加物品(self.合成[n].物品)
					self.物品[self.合成[n].道具序列]:置物品(临时物品)
					self.合成[n]:置物品(nil)
				else
					tp.常规提示:打开("#Y/包裹已满。请及时清理")
				end
				break
			end
		end
		if self.合成[n].焦点 then
			self.焦点 = true
		end
	end
end



function 场景类_法宝合成:检查点(x,y)
	if self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_法宝合成:初始移动(x,y)
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

function 场景类_法宝合成:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_法宝合成