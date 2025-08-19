--======================================================================--
-- @作者: GGE研究群: 684484316
-- @创建时间:   2019-09-03 02:34:19
-- @Last Modified time: 2025-01-23 22:02:34
-- 梦幻西游游戏资源破解  老毕   和 C++PrimerPlus  这俩位大神破解所有资源
--======================================================================--
local 摊位购买类 = class()
local tp,zts,zts1,zts3
local insert = table.insert
local xxx = 0
local yyy = 0
local sts = {"单价","数量","总额","现金"}
local tos = 取金钱颜色
local mouseb = 引擎.鼠标弹起
local bw = require("gge包围盒")(0,0,120,20)
local bw1 = require("gge包围盒")(0,0,260,68)
local box = 引擎.画矩形


function 摊位购买类:初始化(根)
    self.ID = 54
	self.x = 100
	self.y = 78
	self.xx = 0
	self.yy = 0
	self.注释 = "摆摊购买"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	local 资源 = 根.资源
	self.选中背景=根.资源:载入('登陆资源.wdf',"网易WDF动画",0x10921CA7)
	self.资源组 = {
		[1] = 自适应.创建(0,1,625,420,3,9),--资源:载入('wzife.wdf',"网易WDF动画",0X9F9301F5),
		[2] = 自适应.创建(3,1,90,18,1,3),--资源:载入('wzife.wdf',"网易WDF动画",0XCE137B78),
		[3] = 资源:载入('登陆资源.wdf',"网易WDF动画",0XE2C626FA),-----大框
		-- [4] = 按钮.创建(自适应.创建(12,4,43,22,1,3),0,0,4,true,true,"给予"),
		[5] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
	    [6] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true," 物品类"),
		[7] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"召唤兽类"),
		[8] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"更改招牌"),
		-- [9] = 按钮.创建(自适应.创建(12,4,43,22,1,3),0,0,4,true,true,"收摊"),
	    -- [10] = 按钮.创建(自适应.创建(12,4,72,22,1,3),0,0,4,true,true,"查看记录"),
	    [11] = 按钮.创建(自适应.创建(12,4,64,20,1,3),0,0,4,true,true,"购买"),
	    [12] = 资源:载入('登陆资源.wdf',"网易WDF动画",0X783C4453),--打造背景 0X839F03F8
	    [13] = 自适应.创建(3,1,105,18,1,3),--输入框背景----未用到
		[14] = 自适应.创建(1,1,621,18,1,3,nil,18),--标题背景
	    [15] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"取消"),
		--[17] = 按钮.创建(自适应.创建(29,4,26,26,4,1),0,0,5,true,true),--方形选择框
        [17] =按钮.创建(资源:载入(根.打勾框,"网易WDF动画",0x00000009),0,0,1,true,true),
		--[18] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0XC47885C6),0,0,4,true,true),--+加按钮
		[18] =按钮.创建(自适应.创建(25,4,19,19,4,3),0,0,4,true,true),
		[19] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xFD3D61F2),0,0,4,true,true),--上按钮
		[20] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x09217E13),0,0,4,true,true),--下按钮
		[21] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true," 打造类"),
		[22] = 自适应.创建(2,1,280,245,3,9),
		[23] = 自适应.创建(3,1,135,18,1,3),--输入框背景---用不到
	}
	self.宠物底图=资源:载入(wdf配置.."/pic/1.png", "图片")
	self.宠物选中=资源:载入(wdf配置.."/pic/3.png", "图片")
	self.页面切换 =按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x49D09C8B),0,0,4,true,true)
	self.打造按钮 = {打造技巧={},裁缝技巧={},炼金术={},淬灵之术={}}
	self.背包按钮={}
	for i=1,7 do
		self.背包按钮[i]=按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,i)
		self.背包按钮[i]:绑定窗口_(54)
		self.背包按钮[i]:置偏移(-2,-2)
	end


		for i=1,16 do
			self.打造按钮.打造技巧[i] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"购买")
			self.打造按钮.打造技巧[i]:绑定窗口_(54)
		    self.打造按钮.打造技巧[i]:置偏移(0,-2)
		end
		for i=1,16 do
			self.打造按钮.裁缝技巧[i] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"购买")
			self.打造按钮.裁缝技巧[i]:绑定窗口_(54)
		    self.打造按钮.裁缝技巧[i]:置偏移(0,-2)
		end
		for i=1,16 do
			self.打造按钮.炼金术[i] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"购买")
			self.打造按钮.炼金术[i]:绑定窗口_(54)
		    self.打造按钮.炼金术[i]:置偏移(0,-2)
		end
		for i=1,16 do
			self.打造按钮.淬灵之术[i] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"购买")
			self.打造按钮.淬灵之术[i]:绑定窗口_(54)
		    self.打造按钮.淬灵之术[i]:置偏移(0,-2)
		end
	for n=6,7 do
		self.资源组[n]:绑定窗口_(54)
		self.资源组[n]:置偏移(0,-2)
	end
	self.资源组[15]:绑定窗口_(54)
	self.资源组[11]:绑定窗口_(54)
	self.资源组[11]:置偏移(10,-2)
	self.资源组[21]:绑定窗口_(54)
	self.资源组[21]:置偏移(0,-2)
	self.选中人物 = 0
	self.窗口时间 = 0
	tp = 根
	self.物品={}
	for i=1,105 do
		self.物品[i] = 根._物品格子.创建(0,0,i,"摆摊购买_物品")
	end
	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('摆摊购买总控件')
	总控件:置可视(true,true)
	self.输入框 = 总控件:创建输入("摆摊购买数量输入",0,0,100,14)
	self.输入框:置可视(false,false)
	self.输入框:置限制字数(4)
	self.输入框:置数字模式()
	self.输入框:屏蔽快捷键(true)
	self.输入框:置光标颜色(-16777216)
	self.输入框:置文字颜色(-16777216)
	self.输入框:置文本(0)

	self.打造输入框 = {打造技巧={},裁缝技巧={},炼金术={},淬灵之术={}}

		for i=1,16 do
		self.打造输入框.打造技巧[i] = 总控件:创建输入("打造输入"..i,0,0,100,14)
	   	self.打造输入框.打造技巧[i]:置数字模式()
		self.打造输入框.打造技巧[i]:置可视(false,false)

		self.打造输入框.打造技巧[i]:屏蔽快捷键(true)
		self.打造输入框.打造技巧[i]:置光标颜色(-16777216)
		self.打造输入框.打造技巧[i]:置文字颜色(-16777216)
		end
		for i=1,16 do
		self.打造输入框.裁缝技巧[i] = 总控件:创建输入("裁缝输入"..i,0,0,100,14)
	   	self.打造输入框.裁缝技巧[i]:置数字模式()
		self.打造输入框.裁缝技巧[i]:置可视(false,false)

		self.打造输入框.裁缝技巧[i]:屏蔽快捷键(true)
		self.打造输入框.裁缝技巧[i]:置光标颜色(-16777216)
		self.打造输入框.裁缝技巧[i]:置文字颜色(-16777216)
		end
		for i=1,16 do
		self.打造输入框.炼金术[i] = 总控件:创建输入("炼金输入"..i,0,0,100,14)
	   	self.打造输入框.炼金术[i]:置数字模式()
		self.打造输入框.炼金术[i]:置可视(false,false)

		self.打造输入框.炼金术[i]:屏蔽快捷键(true)
		self.打造输入框.炼金术[i]:置光标颜色(-16777216)
		self.打造输入框.炼金术[i]:置文字颜色(-16777216)
		end
		for i=1,16 do
		self.打造输入框.淬灵之术[i] = 总控件:创建输入("巧匠输入"..i,0,0,100,14)
	   	self.打造输入框.淬灵之术[i]:置数字模式()
		self.打造输入框.淬灵之术[i]:置可视(false,false)

		self.打造输入框.淬灵之术[i]:屏蔽快捷键(true)
		self.打造输入框.淬灵之术[i]:置光标颜色(-16777216)
		self.打造输入框.淬灵之术[i]:置文字颜色(-16777216)
		end
	self.商品最大数量=0
	zts2 = tp.字体表.普通字体__
	zts3 = tp.字体表.普通字体__
	zts1 = tp.字体表.描边字体
	self.字体 = tp.字体表.普通字体
	self.打造数据 = {}
	self.熟练度 = {}
	self.开始 = 1
	self.结束 = 9
	self.道具开始 = 1
	self.道具结束 = 15
end

function 摊位购买类:刷新(名称,角色名称,id,物品数据,bb数据,打造数据,熟练度)
	self.上架物品=物品数据
	self.上架bb=bb数据
	local wp = tp._物品
	self.道具 = {}
	self.头像组={}
	for i in pairs(物品数据) do
		self.道具[#self.道具+1] = 物品数据[i]
		self.道具[#self.道具].背包编号=物品数据[i].背包编号
	end
	for q=1,105 do
		   self.物品[q]:置物品(self.道具[q])
		if self.道具[q]~=nil then
		   self.物品[q].名称=self.道具[q].名称
		   self.物品[q].价格=self.道具[q].价格
		   self.物品[q].数量=self.道具[q].数量
		   self.物品[q].背包编号=self.道具[q].背包编号
		end
	end
	self.对象名称=名称
	self.对象等级=等级
	self.对象类型=类型
	self.bb=bb数据
	self.摊主名称=角色名称
	self.摊主id=id
	self.摊位名称=名称
	self.打造数据 = 打造数据
	self.熟练度 = 熟练度
end

function 摊位购买类:打开(名称,角色名称,id,物品数据,bb数据,打造数据,熟练度,显示类型)
	if self.可视 and self.焦点 then return end
	if 名称==nil and self.可视 then
		self.选中人物 = 0
		self.可视 = false
		self.输入框:置焦点(false)
		self.输入框:置可视(false,false)
		self.开始 = 1
    	self.结束 = 9
		self.道具开始 = 1
	    self.道具结束 = 15
	else
		insert(tp.窗口_,self)
		self.上架物品=物品数据
		self.上架bb=bb数据
		local wp = tp._物品
	    self.道具 = {}
		for i in pairs(物品数据) do
			self.道具[#self.道具+1] = 物品数据[i]
			self.道具[#self.道具].背包编号=物品数据[i].背包编号
		end
		for q=1,105 do
			   self.物品[q]:置物品(self.道具[q])
			if self.道具[q]~=nil then
			   self.物品[q].名称=self.道具[q].名称
			   self.物品[q].价格=self.道具[q].价格
			   self.物品[q].数量=self.道具[q].数量
			   self.物品[q].背包编号=self.道具[q].背包编号
			end
		end
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.选中人物=0
	    self.对象名称=名称
	    self.对象等级=等级
	    self.对象类型=类型
	    self.格子={}
	    self.bb=bb数据
	    self.显示类型="物品"
	    if 显示类型~=nil then
	    	self.显示类型 = 显示类型
	    end
	    self.摊主名称=角色名称
	    self.摊主id=id
	    self.bb选中=0
	    self.物品选中=0
	    self.摊位名称=名称
	    self.商品单价=0
	    self.商品数量=0
	    self.商品总价格=0
	    self.输入框:置可视(true,true)
	    self.商品最大数量=0
	    self.打造数据 = 打造数据
	    self.熟练度 = 熟练度
	    self.打造技能 = ""
	     self.头像组={}
	    if 观察[self.摊主id]==nil then
		   观察[self.摊主id]={[1]=0,关注=false}
		end
		self.资源组[17]:置打勾框(观察[self.摊主id].关注)

	    for i=1,16 do
		  self.打造输入框.打造技巧[i]:置可视(false,false)
		end
		for i=1,16 do
		  self.打造输入框.裁缝技巧[i]:置可视(false,false)
		end
		for i=1,16 do
		  self.打造输入框.炼金术[i]:置可视(false,false)
		end
		for i=1,16 do
		  self.打造输入框.淬灵之术[i]:置可视(false,false)
		end
	end
end

function 摊位购买类:物品显示(dt,x,y)
	self.焦点=false
	local xx = 0
	local yy = 0
	for i=self.道具开始,self.道具结束 do
		if self.物品[i].格子==nil and self.物品[i].物品 ~= nil then
			tp.物品格子背景_:显示(self.x + xx * 200 + 20,self.y + yy * 59 + 23)
			self.物品[i]:置坐标(self.x + xx * 200 + 22,self.y + yy * 59 + 25)
			if self.物品选中==i then
				self.选中背景:显示(self.x + xx * 200 + 23,self.y + yy * 59 + 26)
				self.字体:置颜色(红色):显示(self.x+ xx * 200 + 74,self.y+ yy * 59 + 30,self.物品[i].名称)
				self.字体:置颜色(红色):显示(self.x+ xx * 200 + 74,self.y+ yy * 59 + 54,"单价:")
			else
			    self.字体:置颜色(黄色):显示(self.x+ xx * 200 + 74,self.y+ yy * 59 + 30,self.物品[i].名称)
			    self.字体:置颜色(黄色):显示(self.x+ xx * 200 + 74,self.y+ yy * 59 + 54,"单价:")
			end
			self.物品[i]:显示(dt,x,y,self.鼠标)
			self.资源组[2]:显示(self.x+ xx * 200 + 110,self.y+ yy * 59 + 54)
			self.字体:置颜色(tos(self.物品[i].价格)):显示(self.x+ xx * 200 + 113,self.y+ yy * 59 + 56,self.物品[i].价格)
			if self.物品[i].焦点 and not tp.消息栏焦点 then
				if self.物品[i].物品 ~= nil then
					tp.提示:道具行囊(x,y,self.物品[i].物品)
					if 引擎.鼠标弹起(左键) then
						self.物品选中=i
						self.商品单价=self.物品[i].价格
						self.商品最大数量 = self.物品[i].数量
						if self.商品最大数量==nil then self.商品最大数量 =1 end
						if self.商品数量>0 and self.商品数量<=self.商品最大数量 then
							self.商品数量 = self.商品数量 + 1
						else
							self.商品数量=1
						end
						self.输入框:置文本(self.商品数量)
						self.输入框:置可视(true,true)
					end
				end
				self.焦点 = true
			end
		end
		xx = xx + 1
		if xx == 3 then
			xx = 0
			yy = yy + 1
		end
	end
	if self.物品选中~=nil and self.物品选中>0 then
		if self.物品[self.物品选中].物品 == nil then
			self.bb选中=0
		    self.物品选中=0
		    self.商品单价=0
		    self.商品数量=0
		    self.商品总价格=0
		    self.输入框:置文本(0)
		end
		if self.输入框:取文本()=="" or self.输入框:取文本()== nil or tonumber(self.输入框:取文本())==nil then
		   self.商品数量 = 0
		   self.输入框:置文本(0)
		else
			if self.商品最大数量==nil then self.商品最大数量 =1 end
			if tonumber(self.输入框:取文本())>=tonumber(self.商品最大数量) then
			   self.输入框:置文本(self.商品最大数量)
			   self.商品数量 = self.商品最大数量
			end
			if self.商品总价格 ~=self.商品单价*tonumber(self.输入框:取文本()) then
				self.商品数量 = tonumber(self.输入框:取文本())
				self.商品总价格 =self.商品单价*self.商品数量
			end
		end

	end




	self.控件类:更新(dt,x,y)
	if self.输入框._已碰撞 then
		self.焦点 = true
	end
	-- if  not tp.窗口.召唤兽查看栏.可视 and (not self.焦点 and 引擎.鼠标弹起(1)) then
	-- 	self:打开()
	-- end
	self.控件类:显示(x,y)
end

function 摊位购买类:bb显示(dt,x,y)

    local xx=0
	local yy=0
	for n, v in pairs(self.bb) do
		self.宠物底图:显示(self.x+20+xx*300,self.y+30+yy*80)
		if self.头像组[n] == nil then
			local i = 引擎.取头像(self.bb[n].模型)
			self.头像组[n] = tp.资源:载入(i[7],"网易WDF动画",i[1])
		end
		tp.宠物头像背景_:显示(self.x+35+xx*300,self.y+42+yy*80)
		self.头像组[n]:显示(self.x+38+xx*300,self.y+46+yy*80)
		bw1:置坐标(self.x+20+xx*300,self.y+30+yy*80)
		if self.bb选中==n then
			self.字体:置颜色(红色)
			self.字体:显示(self.x+88+xx*300,self.y+42+yy*80,self.bb[n].名称)
			self.字体:显示(self.x+200+xx*300,self.y+42+yy*80,"等级")
			self.字体:显示(self.x+230+xx*300,self.y+42+yy*80,self.bb[n].等级)
			self.字体:显示(self.x+88+xx*300,self.y+62+yy*80,"单 价")
		else
			self.字体:置颜色(白色)
			self.字体:显示(self.x+88+xx*300,self.y+42+yy*80,self.bb[n].名称)
			self.字体:显示(self.x+200+xx*300,self.y+42+yy*80,"等级")
			self.字体:显示(self.x+230+xx*300,self.y+42+yy*80,self.bb[n].等级)
			self.字体:显示(self.x+88+xx*300,self.y+62+yy*80,"单 价")
		end
		self.资源组[2]:显示(self.x+140+xx*300,self.y+60+yy*80)
		self.字体:置颜色(tos(self.bb[n].价格)):显示(self.x+144+xx*300,self.y+64+yy*80,self.bb[n].价格)
		if bw1:检查点(x,y)  then
			self.宠物选中:显示(self.x+18+xx*300,self.y+29+yy*80)
			if 引擎.鼠标弹起(0) and self.鼠标 and not tp.消息栏焦点 then
				self.bb选中=n
				self.商品数量=1
				self.商品单价=self.bb[n].价格
				self.商品总价格=self.bb[n].价格
			elseif 引擎.鼠标弹起(1) and self.鼠标 and not tp.消息栏焦点 then
				self.焦点=true
				tp.窗口.召唤兽查看栏:打开(self.bb[n])
			end
		end
		xx=xx+1
		if xx==2 then
			yy=yy+1
			xx=0
		end
	end
	if self.bb选中~=nil and self.bb选中>0 then
		if self.bb[self.bb选中] == nil then
			self.bb选中=0
		    self.商品单价=0
		    self.商品数量=0
		    self.商品总价格=0
		end
	end
	self.字体:置颜色(白色)
end


function 摊位购买类:打造显示(dt,x,y)
    self.资源组[3]:显示(self.x+20,self.y+95)---250  --235
    self.资源组[22]:显示(self.x+275,self.y+95)
    self.资源组[19]:更新(x,y)
	self.资源组[20]:更新(x,y)
	self.资源组[19]:显示(self.x+537,self.y+95)
	self.资源组[20]:显示(self.x+537,self.y+321)
	tp.画线:置区域(0,0,15,207)
	tp.画线:显示(self.x+541,self.y+114)
	for i = 1 , 16 do
		self.打造按钮.打造技巧[i]:更新(x,y)
    end
    for i = 1 , 16 do
		self.打造按钮.裁缝技巧[i]:更新(x,y)
    end
    for i = 1 , 16 do
		self.打造按钮.炼金术[i]:更新(x,y)
    end
    for i = 1 , 16 do
		self.打造按钮.淬灵之术[i]:更新(x,y)
    end
	local xx = 1
	if self.打造数据~=nil then
	for n,v in pairs(self.打造数据) do

		if self.打造数据[n]~=nil then
			bw:置坐标(self.x+37,self.y+80+xx*25)
			if self.打造技能==n then
				box(self.x+27,self.y+75+xx*25,self.x+225,self.y+100+xx*25,-2097481216)
			end
			if self.打造技能 == n then
				self.字体:置颜色(红色):显示(self.x+37,self.y+80+xx*25,n)
				self.字体:置颜色(红色):显示(self.x+115,self.y+80+xx*25,"熟练度:"..self.熟练度[n])
			else
				self.字体:置颜色(黑色):显示(self.x+37,self.y+80+xx*25,n)
				self.字体:置颜色(黑色):显示(self.x+115,self.y+80+xx*25,"熟练度:"..self.熟练度[n])

				for i=1,16 do
					self.打造输入框[n][i]:置可视(false,false)
				end
			end
			if bw:检查点(x,y)  then
				if 引擎.鼠标弹起(0) and self.鼠标 and not tp.消息栏焦点 then
					self.打造技能=n
					self.开始 = 1
					self.结束 = 9
			 			local 临时排序 = {}
				 		for n,v in pairs(self.打造数据[n]) do
				 			临时排序[#临时排序+1]={编号 = n}
						end
						if  临时排序~=nil and #临时排序>0 then
						 if #临时排序<9  then
							table.sort(临时排序,function(a,b) return a.编号<b.编号 end)
								--self.开始  = 临时排序[1]
							self.结束 = self.开始 + 8
							self.结束 = 	临时排序[#临时排序].编号
						 end
					 end
	            end
			end
			xx = xx + 1
		end
 	end



	  if self.打造技能~=nil and self.打造技能~="" then

	 	if self.结束<16 then
		   for y = self.结束,16 do
		   	self.打造输入框[self.打造技能][y]:置可视(false,false)
		   end
		 end
		 if self.开始>1 and #self.打造数据[self.打造技能]~=1 then
		   for y = 1,self.开始 do
		   	self.打造输入框[self.打造技能][y]:置可视(false,false)
		   end
		 end
	end





      for n,v in pairs(self.打造数据) do

			if self.打造技能==n then
				local yy = 1
				 for i=self.开始,self.结束 do
				   if self.打造数据[self.打造技能][i]~=nil  then
	                  local 显示等级 = i * 10
		                self.字体:置颜色(黑色):显示(self.x+290,self.y+80+yy*26,显示等级.."级")
				        self.打造按钮[self.打造技能][i]:显示(self.x+480,self.y+78+yy*26)
				        self.资源组[23]:显示(self.x+330,self.y+78+yy*26)
				        self.打造输入框[self.打造技能][i]:置可视(true,true)
						self.打造输入框[self.打造技能][i]:置坐标(self.x+333,self.y+80+yy*26)
						self.打造输入框[self.打造技能][i]:置文本(self.打造数据[self.打造技能][i])
						self.打造输入框[self.打造技能][i]:置文字颜色(tos(self.打造输入框[self.打造技能][i]:取文本()+0))
						yy = yy + 1
						if  self.打造按钮[self.打造技能][i]:事件判断() then
							请求服务(3726,{打造=self.打造技能,数量=i})

			                return
			            end
		             end
				 end

                 if self.资源组[19]:事件判断() then
					if self.开始 == 1 then
						tp.常规提示:打开("#Y/已经到最顶层了")
						return
					end
					self.开始 = self.开始 -1
					self.结束 = self.结束 -1
				elseif self.资源组[20]:事件判断() then
					if self.结束 > #self.打造数据[n] then
						tp.常规提示:打开("#Y/已经到最低层了")
						return
					end
					self.开始 = self.开始 + 1
				    self.结束 = self.结束 + 1
				end


			end
     end

       end
	if self.资源组[3]:是否选中(x,y) then
	    self.焦点=true
	end

	self.控件类:更新(dt,x,y)
	self.控件类:显示(x,y)
end






function 摊位购买类:显示(dt,x,y)
	self.焦点=false
	if self.显示类型~="打造" then
		self.资源组[1]:置宽高(625,420)
	    self.资源组[14]:置宽高(621,18)
	    self.资源组[1]:显示(self.x,self.y)
	    self.资源组[14]:显示(self.x+2,self.y+2)
		if  tp.窗口标题背景_[math.ceil(string.len(self.摊位名称)/2)]~=nil then
			local 动态显示 = math.ceil(string.len(self.摊位名称)/2)
		    tp.窗口标题背景_[动态显示]:显示(self.x+self.资源组[1].宽度/2-15*动态显示,self.y+2)
		    zts1:置字间距(3)
		     if 观察[self.摊主id].关注 then
			 	zts1:置颜色(红色)
			 else
			    zts1:置颜色(白色)
			 end
			zts1:显示(self.x+self.资源组[1].宽度/2-(15*动态显示-30),self.y+2,self.摊位名称)
			zts1:置字间距(0)
		 else
		 	tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
		    zts1:置字间距(3)
			zts1:置颜色(白色):显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"摆摊购买")
			zts1:置字间距(0)
		 end

		self.资源组[5]:更新(x,y)
		self.资源组[6]:更新(x,y,self.显示类型~="物品")
		self.资源组[7]:更新(x,y,self.显示类型~="bb")
		self.资源组[21]:更新(x,y,self.显示类型~="打造")
		self.资源组[11]:更新(x,y)
		--self.资源组[15]:更新(x,y)

		self.资源组[5]:显示(self.x+603,self.y+2)
		self.资源组[6]:显示(self.x+180,self.y+327)
		self.资源组[7]:显示(self.x+180+95,self.y+327)
		self.资源组[21]:显示(self.x+180+95+95,self.y+327)
		self.资源组[11]:显示(self.x+180,self.y+385)
		self.资源组[18]:更新(x,y)--加好友
		self.资源组[18]:显示(self.x+540,self.y+392)
		self.资源组[17]:更新(x,y)--选择款
		self.资源组[17]:显示(self.x+560,self.y+387)
		zts3:显示(self.x+587,self.y+394,"关注")
		zts2:置字间距(2)
		zts2:置颜色(白色)
		zts2:显示(self.x +470,self.y + 330,"摊主")
		zts2:置字间距(0)
		zts2:显示(self.x +472,self.y + 359,"I D")
		zts2:显示(self.x + 18,self.y + 330,"数量")
		zts2:显示(self.x + 18,self.y + 359,"总价")
		zts2:显示(self.x + 18,self.y + 387,"现金")
		zts2:置字间距(0)
		self.资源组[13]:显示(self.x+508,self.y+328)
		self.资源组[13]:显示(self.x+508,self.y+357)
		self.资源组[13]:显示(self.x+56,self.y+328)
		self.资源组[13]:显示(self.x+56,self.y+357)
		self.资源组[13]:显示(self.x+56,self.y+386)

		self.字体:置颜色(黑色):显示(self.x +513,self.y + 331,self.摊主名称)
		self.字体:置颜色(黑色):显示(self.x +513,self.y + 360,self.摊主id)

		self.字体:置颜色(tos(self.商品总价格)):显示(self.x + 61,self.y + 360,self.商品总价格)
		self.字体:置颜色(tos(tp.金钱)):显示(self.x + 61,self.y + 388,tp.金钱)
	------------------------------------------------
		if self.显示类型=="物品" then
	       for i=1,7 do
			   self.背包按钮[i]:更新(x,y,self.道具结束~=i*15)
			   self.背包按钮[i]:显示(self.x+230+i*32,self.y+385)
			   if self.背包按钮[i]:事件判断() then
				  self.道具结束=i*15
				  self.道具开始=self.道具结束-14
			   end
		    end
		 else
		     self.字体:置颜色(黑色):显示(self.x +60,self.y + 331,self.商品数量)
		end



	else
		self.资源组[1]:置宽高(582,360)
	    self.资源组[14]:置宽高(578,18)
	    self.资源组[1]:显示(self.x,self.y)
	    self.资源组[14]:显示(self.x+2,self.y+2)
		tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
		zts1:置字间距(3)
		zts1:置颜色(白色):显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"摆摊购买")
		zts1:置字间距(0)

		self.资源组[5]:更新(x,y)
		self.资源组[6]:更新(x,y,self.显示类型~="物品")
		self.资源组[7]:更新(x,y,self.显示类型~="bb")
		self.资源组[21]:更新(x,y,self.显示类型~="打造")

		self.资源组[11]:更新(x,y)
		self.资源组[5]:显示(self.x+562,self.y+2)
		self.资源组[6]:显示(self.x+136,self.y+67)
		self.资源组[7]:显示(self.x+136+95,self.y+67)
		self.资源组[21]:显示(self.x+136+95+95,self.y+67)

		self.资源组[18]:更新(x,y)--加好友
		self.资源组[18]:显示(self.x+482,self.y+27)
		self.资源组[17]:更新(x,y)--选择款
		self.资源组[17]:显示(self.x+502,self.y+22)
		zts3:显示(self.x+529,self.y+29,"关注")
		zts2:置字间距(2)
		zts2:置颜色(白色)
		zts2:显示(self.x + 12,self.y + 34,"招牌")
		zts2:显示(self.x + 177,self.y + 34,"摊主")
		zts2:置字间距(0)
		zts2:显示(self.x + 342,self.y + 34,"ID")
		zts2:显示(self.x + 18,self.y + 320,"现金")
		zts2:置字间距(0)
		self.资源组[13]:显示(self.x+222,self.y+32)
		self.资源组[13]:显示(self.x+57,self.y+32)
		self.资源组[2]:显示(self.x+372,self.y+32)
		self.资源组[23]:显示(self.x+56,self.y+318)
		self.字体:置颜色(黑色):显示(self.x + 225,self.y + 35,self.摊主名称)
		self.字体:置颜色(黑色):显示(self.x + 373,self.y + 35,self.摊主id)
		self.字体:置颜色(tos(tp.金钱)):显示(self.x + 61,self.y + 321,tp.金钱)
		if 观察[self.摊主id].关注 then
		 	self.字体:置颜色(红色)
		 else
		    self.字体:置颜色(黑色)
		 end
	    self.字体:显示(self.x + 60,self.y + 35,self.摊位名称)

	end






    self.页面切换:更新(x,y)
    self.页面切换:显示(self.x+5,self.y+5)
	self.输入框:置坐标(self.x + 60,self.y + 331)
	if self.资源组[5]:事件判断()  then
		self:打开()
	-- elseif self.资源组[15]:事件判断() then
	-- 	self:打开()
	elseif self.资源组[6]:事件判断() then
		self.显示类型="物品"
		self.输入框:置可视(true,true)
		self.bb选中=0
	    self.物品选中=0
	    self.商品单价=0
	    self.商品数量=0
	    self.商品总价格=0
	    self.输入框:置文本(self.商品数量)
	elseif self.资源组[7]:事件判断() then
		self.显示类型="bb"
		self.输入框:置可视(false,false)
		self.bb选中=0
	    self.物品选中=0
	    self.商品单价=0
	    self.商品数量=0
	    self.商品总价格=0
	     self.输入框:置文本(self.商品数量)
    elseif self.资源组[21]:事件判断() then
        self.显示类型="打造"
    	self.输入框:置可视(false,false)
    	self.bb选中=0
	    self.物品选中=0
	    self.商品单价=0
	    self.商品数量=0
	    self.商品总价格=0
	     self.输入框:置文本(self.商品数量)
	elseif self.资源组[17]:事件判断() then
		if 观察[self.摊主id]~=nil and 观察[self.摊主id].关注 then
			观察[self.摊主id].关注=false
		else
		    观察[self.摊主id].关注=true
		end
		self.资源组[17]:置打勾框(观察[self.摊主id].关注)
	elseif self.资源组[18]:事件判断() then
		if tp.场景.玩家[self.摊主id]~=nil and tp.场景.玩家[self.摊主id].类型=="假人玩家" then
			tp.常规提示:打开("#Y添加失败!")
		    return
		end
		请求服务(21,{id=self.摊主id, 类型=1})
    elseif self.页面切换:事件判断() then
    	新摆摊界面= false
		tp.窗口.摊位购买:打开(self.摊位名称,self.摊主名称,self.摊主id,self.上架物品,self.上架bb,self.打造数据,self.熟练度,self.显示类型)
		f函数.写配置(程序目录.."config.ini","mhxy","新摆摊界面",新摆摊界面)
		self:打开()

	end
	if self.显示类型=="物品" then
		self:物品显示(dt,x,y)
	elseif self.显示类型=="bb" then
		self:bb显示(dt,x,y)
	elseif self.显示类型=="打造" then
		self:打造显示(dt,x,y)

	end

	if self.资源组[11]:事件判断() then
		if self.显示类型=="bb" then
			if self.bb选中==0 then
				tp.常规提示:打开("#Y/请先选择要购买的召唤兽")
				return
			end
		elseif self.显示类型=="物品" then
			if self.物品选中==0 or self.物品[self.物品选中].物品 == nil then
				tp.常规提示:打开("#Y/请先选择要购买的物品")
				return
			end
		end
		if self.显示类型=="bb" then
			请求服务(3726,{bb=self.bb选中})
		else


			-- if self.输入框:取文本()~="" and  tonumber(self.输入框:取文本()) <=0 then
			-- 	self.输入框:置文本(0)
			-- elseif self.输入框:取文本()~="" and  tonumber(self.输入框:取文本()) > 999 then
			-- 	self.输入框:置文本(999)
			-- end


			self.商品数量 = tonumber(self.输入框:取文本())
			if self.商品数量 <= 0 or self.商品数量=="" then
			    self.商品数量 = 1
			elseif self.商品数量>=tonumber(self.商品最大数量) then
				self.商品数量 = tonumber(self.商品最大数量)
			elseif self.商品数量 >= 1000 then
				self.商品数量 = 999
			end

			请求服务(3726,{道具=self.物品[self.物品选中].背包编号,数量=self.商品数量})
		end
	end
end

function 摊位购买类:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y) then
		return true
	else
		return false
	end
end

function 摊位购买类:初始移动(x,y)
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

function 摊位购买类:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end
function 摊位购买类:更新(dt) end
return 摊位购买类