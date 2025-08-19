--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:11:32
--======================================================================--
local 场景类_碎星锤道具栏 = class()
local require = require
local tp,zts1
local floor = math.floor
local format = string.format
local insert = table.insert

function 场景类_碎星锤道具栏:初始化(根)
	self.id = "技能研习"
	self.x = 176
	self.y = 179
	self.xx = 0
	self.yy = 0
	self.注释 = "碎星锤"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.选中=0
	tp = 根
    zts1 = tp.字体表.描边字体
	self.开始 = 1
	self.结束 = 20
	self.窗口时间 = 0
end

function 场景类_碎星锤道具栏:打开(数据)
	self.数据 = 数据
	if self.可视 then
		self.可视 = false
		self.资源组 = nil
		self.物品 = nil
		self.技能=nil
	else
		insert(tp.窗口_,self)
		local 按钮 = require("script/系统类/按钮")
		self.资源组 = {
			[1] = tp._自适应.创建(0,1,510,290,3,9),
			[2] = 按钮.创建(tp._自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
			[3] = 按钮.创建(tp._自适应.创建(12,4,100,20,1,3),0,0,4,true,true," 研  习"),
			[4] = tp._自适应.创建(1,1,506,18,1,3,nil,18),
			--[5] = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x68D384BD),
			[5] =资源:载入('房屋图标.wdf',"网易WDF动画",0x00000030),
		}
		self.资源组[3]:绑定窗口_(技能研习)
		self.物品 = {}
		local 格子 = tp._物品格子
		for i=1,20 do
	        self.物品[i] = 格子.创建(0,0,i,"道具类")
	    end
		for n=self.开始,self.结束 do
			self.物品[n]:置物品(self.数据.道具.道具[n])
		end
		self.技能 = {}
		local jn = tp._技能格子
		for i=1,12 do
		    self.技能[i] = jn(0,0,i,"召唤兽资质技能")
		end
		for i=1,#self.数据.孩子.技能 do
			    local 临时技能=tp._技能.创建()
			    临时技能:置对象(self.数据.孩子.技能[i],2)
			    self.技能[i]:置技能(临时技能)
		end
		self.可视 = true
		tp.运行时间 = tp.运行时间 + 1
	  	self.窗口时间 = tp.运行时间
	end
end

function 场景类_碎星锤道具栏:更新(dt,x,y)

 self.鼠标=self:检查点(x,y)
end
function 场景类_碎星锤道具栏:刷新数据(数据)
		self.数据 = 数据
	    self.物品 = {}
		local 格子 = tp._物品格子
		for i=1,20 do
	        self.物品[i] = 格子.创建(0,0,i,"道具类")
	    end
		for n=self.开始,self.结束 do
			self.物品[n]:置物品(self.数据.道具.道具[n])
		end
		self.技能 = {}
		local jn = tp._技能格子
		for i=1,12 do
		    self.技能[i] = jn(0,0,i,"召唤兽资质技能")
		end
		for i=1,#self.数据.孩子.技能 do
			    local 临时技能=tp._技能.创建()
			    临时技能:置对象(self.数据.孩子.技能[i],7) --这里写什么都没事
			    self.技能[i]:置技能(临时技能)
		end
end
function 场景类_碎星锤道具栏:显示(dt,x,y)
	if not self.可视 then
		return false
	end
	self.焦点 = false
   if self.鼠标 then
		self.资源组[2]:更新(x,y)
		if self.资源组[2]:事件判断() then
			self:打开()
			return
		end
	else
		self.资源组[2].焦点 = 0

	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[4]:显示(self.x + 2,self.y + 2)
	self.资源组[2]:显示(self.x + 489,self.y + 2,true)
    tp.物品界面背景_:显示(self.x+15,self.y+30)
	local xx = 0
	local yy = 0
	for i=1,12 do
		local jx = self.x+310+(xx*41)
		local jy = self.y+110+(yy*41)
		self.资源组[5]:显示(jx,jy)  --这个是技能格子好像是
		xx = xx + 1
		if xx > 3 then
			xx = 0
			yy = yy + 1
		end
	end

	-- tp.窗口标题背景_:置区域(0,0,80,16)
	-- tp.窗口标题背景_:显示(self.x+210,self.y+3)
	tp.竖排花纹背景_:置区域(0,0,13,200)
	tp.竖排花纹背景_:显示(self.x+280,self.y+35)
	tp.字体表.人物字体:显示(self.x+300,self.y+40,"选择道具中的魔兽要诀或者高级\n磨兽要诀，单击研习按钮学习")

	self.资源组[3]:更新(x,y)
	self.资源组[3]:显示(self.x + 86,self.y + 256,true)

    tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-63,self.y+2)
	zts1:显示(self.x+self.资源组[1].宽度/2-30,self.y+3,"技能学习")
	local n = self.开始-1
	local c =  false
	for h=1,4 do
		for l=1,5 do
			n = n + 1
			self.物品[n]:置坐标(l*51-37+self.x+4,h*51+self.y-16)
			self.物品[n]:显示(dt,x,y,self.鼠标,{3})
			if self.物品[n].物品~=nil and self.物品[n].焦点 then
				tp.提示:道具行囊(x,y,self.物品[n].物品)
				if self.物品[n].事件 and self.物品[n].物品.总类==3 and self.鼠标 then
                	--请求服务(4515,{序列=self.物品[n].物品,序列1=self.数据.编号,序列2=n})
                    -- self.可视 = false
                    -- 刷新道具逻辑(self.物品[n].物品,n,true)
                    if self.选中~=0 then
                   		 self.物品[self.选中].确定=false
                	end
                    self.物品[n].确定=true
                    self.选中=n
                end
			end
		end
	end
	local xx = 0
	local yy = 0
	for n=1,12 do
		if self.技能[n] ~= nil and self.技能[n].技能 ~= nil then
			self.技能[n]:置坐标(self.x+312+(xx*42),self.y+112+(yy*42))
			self.技能[n]:显示(x,y,self.鼠标)
			if self.技能[n].焦点 then
				tp.提示:技能(x,y,self.技能[n].技能)
			end
			xx = xx + 1
			if xx > 3 then
				xx = 0
				yy = yy + 1
			end
		end
	end


	if self.资源组[3]:事件判断() then
		if self.选中==0 then
			tp.常规提示:打开("#Y/请先选中一个道具")
			return
		end
	    请求服务(102,{序列=4,道具=self.选中,位置=self.数据.位置})
	end

end

function 场景类_碎星锤道具栏:检查点(x,y)
	if self.可视 and self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
	return false
end

function 场景类_碎星锤道具栏:初始移动(x,y)
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

function 场景类_碎星锤道具栏:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_碎星锤道具栏