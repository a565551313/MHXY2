
local 附魔宝珠 = class()
local insert = table.insert
local mouseb = 引擎.鼠标弹起
local tp
local tos = 取金钱颜色
local mc = {"变身术","追加法术","变化咒","附加状态"}
local cl = {"青龙石","朱雀石","玄武石","白虎石"}
function 附魔宝珠:初始化(根)
 	self.ID = 88
	self.x = 0
	self.y = 0
	self.xx = 0
	self.yy = 0
	self.注释 = "附魔宝珠"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口时间 = 0
	tp = 根
end

function 附魔宝珠:加载资源()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x1A23FA1A),
		[2] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x1A23FA1B),0,0,3,true,true),
		[3] = 按钮.创建(自适应.创建(38,4,73,22,1,3),0,0,4,true,true,"点化"),
	}
	lsdh = tp.字体表.普通字体
	self.选择组 = {}
	for n=1,4 do
		self.选择组[n] = 按钮.创建(自适应.创建(30,4,25,22,4,9),0,0,4,true,true)
	end
	self.物品={}
	for i=1,20 do
		self.物品[i] = tp._物品格子.创建(0,0,i,"给予_物品")
	end
	self.材料 = tp._物品格子.创建(0,0,i,"给予_物品")
	self.宝珠数据 = 0
end

function 附魔宝珠:打开(数据)
 	if self.可视 then
		self.可视 = false
		self.物品 = nil
		self.材料 = nil
		self.触摸光环 = nil
		self.资源组=nil
		return
	else
		insert(tp.窗口_,self)
		self:加载资源()
		self.x = (全局游戏宽度/2)-160
		self.y = (全局游戏高度/2)-263
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
		for q=1,20 do
			self.物品[q]:置根(tp)
			self.物品[q]:置物品(数据[q])
		end
		self.选择 = 0
		self.材料位置 = 0
		self.消耗材料 = 0
		self.消耗 = {经验=0,材料数量=0,金钱=0,祈福值=0}
	end
end

function 附魔宝珠:刷新(数据)
	for q=1,20 do
		self.物品[q]:置根(tp)
		self.物品[q]:置物品(数据[q])
	end
	self.材料:置物品(nil)
end

function 消耗经验(等级)
	return 等级 * 3000
end

function 消耗金钱(等级)
	return 等级 * 5000
end

function 消耗石头(等级)
	return math.floor(等级/10)
end

function 附魔宝珠:显示(dt,x,y)
	self.焦点 = false
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y)
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[2]:显示(self.x+290,self.y+3)
	local xx=0
	local yy=0
	for n=1,4 do
		self.选择组[n]:更新(x,y)
		self.选择组[n]:显示(self.x+40 + (xx*130),self.y+287+(yy)*35,true,nil,nil,self.选择 == n,4)
		lsdh:置颜色(0xff77342c):显示(self.x+70 + (xx*130),self.y+293+(yy)*35,mc[n])
		xx = xx + 1
		if xx == 2 then
			xx = 0
			yy = 1
		end
		if self.选择组[n]:事件判断() then
			if n~=3 then
				self.选择 = n
			else
			    tp.常规提示:打开("#Y/暂未开放变化咒套装。")
			end
		end
	end
	if self.资源组[2]:事件判断() then
		self:打开()
		return
	elseif self.资源组[3]:事件判断() then
		if self.材料.物品~=nil and self.材料位置~=0 and self.选择~=0 and self.宝珠数据~=0 then
			请求服务(3768,{装备=self.材料位置,套装=self.选择,宝珠数据 = self.宝珠数据})
		else
			if self.宝珠数据== 0 then
				tp.常规提示:打开("#Y/宝珠数据异常，请重新打开界面操作。")
			else
			    tp.常规提示:打开("#Y/请先选择需要点化套装的装备或您未选择点化的套装类型。")
			end
		end
	end
    self.资源组[3]:显示(self.x+125,self.y+490)
    local xx = 0
	local yy = 0
	for i=1,20 do
	 	if self.物品[i]~=nil and self.物品[i].物品~=nil then
	 	 	self.物品[i]:置坐标(self.x + xx * 56 + 26,self.y + yy * 56 + 36)
	     	self.物品[i]:显示(dt,x,y,self.鼠标,{0,0,(self.物品[i].物品.总类 == 2 and self.物品[i].物品.分类<=6 and self.物品[i].物品.分类~=3)})
	     	if self.物品[i].焦点 and not tp.消息栏焦点 then
				if self.物品[i].物品 ~= nil then
					tp.提示:道具行囊(x,y,self.物品[i].物品)
					if 引擎.鼠标弹起(左键) and self.物品[i].物品.总类 == 2 and self.物品[i].物品.分类<=6 and self.材料.物品==nil and self.物品[i].物品.分类~=3 then
						if self.物品[i].物品.分类 == 5 or self.物品[i].物品.分类 == 6 then
							self.消耗材料 = 3
						else
						    self.消耗材料 = self.物品[i].物品.分类
						end
						self.消耗.金钱 = 消耗金钱(self.物品[i].物品.级别限制)
						self.消耗.材料数量 = 消耗石头(self.物品[i].物品.级别限制)
						self.消耗.经验 = 消耗经验(self.物品[i].物品.级别限制)
						if self.物品[i].物品.祈福值~=nil then
							self.消耗.祈福值 = self.物品[i].物品.祈福值
						end
						self.材料:置物品(self.物品[i].物品)
						self.材料位置 = i
						self.物品[i]:置物品(nil)
					elseif 引擎.鼠标弹起(左键) and self.物品[i].物品.总类 == 2 and self.材料.物品==nil and self.物品[i].物品.分类==3 then
						tp.常规提示:打开("#Y/武器无法进行点化操作。")
					end
					刷新道具逻辑(self.物品[i].物品,i,true)
				end
				self.焦点 = true
			end
	   	end
	   	xx = xx + 1
		if xx == 5 then
			xx = 0
			yy = yy + 1
		end
	end
	self.材料:置坐标(self.x + 33,self.y+395)
	self.材料:显示(dt,x,y,self.鼠标)
	if self.材料.物品 ~= nil and self.材料.焦点 then
		tp.提示:道具行囊(x,y,self.材料.物品)
		if mouseb(0) and self.鼠标 then
			if 取物品数量() < 20 then
				if self.材料.物品.可叠加 then
					增加物品(self.材料.物品,nil,self.材料.物品.数量,self.材料位置)
				else
				    增加物品(self.材料.物品,nil,nil,self.材料位置)
				end
				self.材料:置物品(nil)
			else
				tp.常规提示:打开("#Y/包裹已满。请及时清理")
			end
		end
	end
	if self.材料.焦点 then
		self.焦点 = true
	end
	lsdh:置颜色(白色):显示(self.x+110,self.y+368,"消耗经验")
	lsdh:置颜色(白色):显示(self.x+110,self.y+399,"消耗")
	if self.材料.物品~=nil and self.消耗材料~=0 then
		lsdh:置颜色(绿色):显示(self.x+140,self.y+399,cl[self.消耗材料])
	end
	lsdh:置颜色(白色):显示(self.x+110,self.y+430,"消耗金钱")
	lsdh:置颜色(白色):显示(self.x+110,self.y+461,"祈福值")
	if self.材料.物品~=nil then
		lsdh:置颜色(黑色):显示(self.x+200,self.y+368,self.消耗.经验)
		lsdh:置颜色(蓝色):显示(self.x+200,self.y+399,self.消耗.材料数量)
		lsdh:置颜色(黑色):显示(self.x+200,self.y+430,self.消耗.金钱)
		lsdh:置颜色(红色):显示(self.x+200,self.y+461,self.消耗.祈福值 .."/30")
	end
end

function 附魔宝珠:初始移动(x,y)
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

function 附魔宝珠:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy


	end
end
function 附魔宝珠:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		return true
	else
		return false
	end
end
return 附魔宝珠