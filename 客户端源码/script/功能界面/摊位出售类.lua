--======================================================================--
-- @作者: GGE研究群: 684484316
-- @创建时间:   2019-09-03 02:34:19
-- @Last Modified time: 2025-02-02 18:57:24
-- 梦幻西游游戏资源破解  老毕   和 C++PrimerPlus  这俩位大神破解所有资源
--======================================================================--
local 摊位出售类 = class()
local tp,zts,zts1,zts3
local insert = table.insert
local xxx = 0
local yyy = 0
local sts = {"单价","数量","总额","现金"}
local tos = 取金钱颜色
local mouseb = 引擎.鼠标弹起
local bw = require("gge包围盒")(0,0,120,20)
local box = 引擎.画矩形

function 摊位出售类:初始化(根)
	tp = 根
    self.ID = 52
	self.x = 100
	self.y = 78
	self.xx = 0
	self.yy = 0
	self.注释 = "摆摊出售"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	local 资源 = 根.资源
	self.选中背景=根.资源:载入('登陆资源.wdf',"网易WDF动画",0x10921CA7)
	self.资源组 = {
		[1] = 自适应.创建(0,1,291,430,3,9),--资源:载入('wzife.wdf',"网易WDF动画",0X967049D),
		[2] = 自适应.创建(3,1,86,18,1,3),--资源:载入('wzife.wdf',"网易WDF动画",0XCE137B78),
		[3] = 资源:载入('登陆资源.wdf',"网易WDF动画",0XE2C626FA),
		[4] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"给予"),
		[5] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
	    [6] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true," 物品类"),
		[7] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"召唤兽类"),
		[8] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"更改招牌"),
		[9] = 按钮.创建(自适应.创建(12,4,44,20,1,3),0,0,4,true,true,"收摊"),
	    [10] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"查看记录"),
	    [11] = 按钮.创建(自适应.创建(12,4,44,20,1,3),0,0,4,true,true,"上架"),
		[12] = 资源:载入('登陆资源.wdf',"网易WDF动画",0X783C4453),--打造背景 0X839F03F8
	    [13] = 自适应.创建(3,1,105,18,1,3),--输入框背景
		[14] = 自适应.创建(1,1,287,18,1,3,nil,18),--标题背景
	    [15] = 按钮.创建(自适应.创建(12,4,43,22,1,3),0,0,4,true,true,"取消"),

		[17] = 按钮.创建(自适应.创建(29,4,26,26,4,1),0,0,5,true,true),--方形选择框
		[18] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0XC47885C6),0,0,4,true,true),--+加按钮
		[19] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xFD3D61F2),0,0,4,true,true),--上按钮
		[20] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x09217E13),0,0,4,true,true),--下按钮
		[21] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true," 打造类"),
		[22] = 自适应.创建(2,1,280,245,3,9),
		[23] = 自适应.创建(3,1,135,18,1,3),--输入框背景


	}

	self.打造按钮 = {打造技巧={},裁缝技巧={},炼金术={},淬灵之术={}}

		for i=1,16 do
			self.打造按钮.打造技巧[i] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"上架")
			self.打造按钮.打造技巧[i]:绑定窗口_(52)
		    self.打造按钮.打造技巧[i]:置偏移(0,-2)
		end
		for i=1,16 do
			self.打造按钮.裁缝技巧[i] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"上架")
			self.打造按钮.裁缝技巧[i]:绑定窗口_(52)
		    self.打造按钮.裁缝技巧[i]:置偏移(0,-2)
		end
		for i=1,16 do
			self.打造按钮.炼金术[i] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"上架")
			self.打造按钮.炼金术[i]:绑定窗口_(52)
		    self.打造按钮.炼金术[i]:置偏移(0,-2)
		end
		for i=1,16 do
			self.打造按钮.淬灵之术[i] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"上架")
			self.打造按钮.淬灵之术[i]:绑定窗口_(52)
		    self.打造按钮.淬灵之术[i]:置偏移(0,-2)
		end

	for n=4,11 do
		self.资源组[n]:绑定窗口_(52)
		self.资源组[n]:置偏移(0,-2)
	end
	self.背包按钮={}
	for i=1,5 do
		self.背包按钮[i]=按钮.创建(自适应.创建(12,4,20,20,1,3),0,0,4,true,true,i)
		self.背包按钮[i]:绑定窗口_(52)
		self.背包按钮[i]:置偏移(-2,-2)
	end
    self.资源组[10]:置偏移(0,-2)
	self.资源组[11]:置偏移(0,-2)
    self.资源组[21]:置偏移(0,-2)


   -- self.加锁 = tp.资源:载入('wzife.wdf',"网易WDF动画",0XF0AB57E7)
	self.选中人物 = 0
	self.窗口时间 = 0
	self.物品={}
	for i=1,100 do
		self.物品[i] = 根._物品格子.创建(0,0,i,"摆摊出售_物品")
	end
	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('摆摊出售总控件')
	总控件:置可视(true,true)
	self.输入框 = 总控件:创建输入("摆摊出售摊位输入",0,0,100,14)
	self.输入框:置可视(false,false)
	self.输入框:置限制字数(12)
	self.输入框:屏蔽快捷键(true)
	self.输入框:置光标颜色(-16777216)
	self.输入框:置文字颜色(-16777216)
   	self.输入框1 = 总控件:创建输入("摆摊出售价格输入",0,0,100,14)
   	self.输入框1:置数字模式()
	self.输入框1:置可视(false,false)
	self.输入框1:置限制字数(11)
	self.输入框1:屏蔽快捷键(true)
	self.输入框1:置光标颜色(-16777216)
	self.输入框1:置文字颜色(-16777216)
	self.打造输入框 = {打造技巧={},裁缝技巧={},炼金术={},淬灵之术={}}

		for i=1,16 do
		self.打造输入框.打造技巧[i] = 总控件:创建输入("打造输入"..i,0,0,100,14)
	   	self.打造输入框.打造技巧[i]:置数字模式()
		self.打造输入框.打造技巧[i]:置可视(false,false)
		self.打造输入框.打造技巧[i]:置限制字数(18)
		self.打造输入框.打造技巧[i]:屏蔽快捷键(true)
		self.打造输入框.打造技巧[i]:置光标颜色(-16777216)
		self.打造输入框.打造技巧[i]:置文字颜色(-16777216)
		end
		for i=1,16 do
		self.打造输入框.裁缝技巧[i] = 总控件:创建输入("裁缝输入"..i,0,0,100,14)
	   	self.打造输入框.裁缝技巧[i]:置数字模式()
		self.打造输入框.裁缝技巧[i]:置可视(false,false)
		self.打造输入框.裁缝技巧[i]:置限制字数(18)
		self.打造输入框.裁缝技巧[i]:屏蔽快捷键(true)
		self.打造输入框.裁缝技巧[i]:置光标颜色(-16777216)
		self.打造输入框.裁缝技巧[i]:置文字颜色(-16777216)
		end
		for i=1,16 do
		self.打造输入框.炼金术[i] = 总控件:创建输入("炼金输入"..i,0,0,100,14)
	   	self.打造输入框.炼金术[i]:置数字模式()
		self.打造输入框.炼金术[i]:置可视(false,false)
		self.打造输入框.炼金术[i]:置限制字数(18)
		self.打造输入框.炼金术[i]:屏蔽快捷键(true)
		self.打造输入框.炼金术[i]:置光标颜色(-16777216)
		self.打造输入框.炼金术[i]:置文字颜色(-16777216)
		end
		for i=1,16 do
		self.打造输入框.淬灵之术[i] = 总控件:创建输入("巧匠输入"..i,0,0,100,14)
	   	self.打造输入框.淬灵之术[i]:置数字模式()
		self.打造输入框.淬灵之术[i]:置可视(false,false)
		self.打造输入框.淬灵之术[i]:置限制字数(18)
		self.打造输入框.淬灵之术[i]:屏蔽快捷键(true)
		self.打造输入框.淬灵之术[i]:置光标颜色(-16777216)
		self.打造输入框.淬灵之术[i]:置文字颜色(-16777216)
		end


	zts2 = tp.字体表.普通字体__
	zts3 = tp.字体表.普通字体__
	zts1 = tp.字体表.描边字体
	self.字体 = tp.字体表.普通字体
	self.打造上架 = {打造技巧={},裁缝技巧={},炼金术={},淬灵之术={}}
	self.已上架打造 = {}
	self.开始 = 1
	self.结束 = 9
	self.道具开始 = 1
	self.道具结束 = 20

end

function 摊位出售类:刷新(名称,角色名称,id,物品数据,bb数据,打造数据)
	self.上架物品=物品数据
	self.上架bb=bb数据
	for q=1,100 do
		self.物品[q]:置物品(tp.道具列表[q])
		if self.上架物品[q]~=nil then
			self.物品[q]:置灰色()
		end
	end
	self.已上架打造 = 打造数据

end

function 摊位出售类:打开(名称,角色名称,id,物品数据,bb数据,打造数据)
	if self.可视 and self.焦点 then return end
	if self.可视 then
		self.选中人物 = 0
		self.可视 = false
		self.输入框:置可视(false,false)
		self.输入框1:置可视(false,false)

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

		for q=1,100 do
			self.物品[q]:置物品(nil)
		end
	    self.bb选中=0
	    self.物品选中=0
		self.已上架打造 = {}
		self.开始 = 1
		self.结束 = 9
		self.道具开始 = 1
	    self.道具结束 = 20
	    self.格子={}
	else
		insert(tp.窗口_,self)
		self.上架物品=物品数据
		self.上架bb=bb数据
		for q=1,100 do
			 self.物品[q]:置物品(nil)
	          if tp.道具列表[q]~=nil then
				 self.物品[q]:置物品(tp.道具列表[q])
	             if self.上架物品[q]~=nil then
	                self.物品[q]:置灰色()
	             end
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
	    self.bb=tp.队伍[1].宝宝列表
	    self.显示类型="物品"
	    self.输入框:置可视(true,true)
	    self.输入框:置文本(名称)
	    self.输入框1:置可视(false,false)
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
	    self.摊主名称=角色名称
	    self.摊主id=id
	    self.bb选中=0
	    self.物品选中=0
	    self.打造技能 = ""
	    self.已上架打造 = 打造数据
	end
end

function 摊位出售类:物品显示(dt,x,y)
	self.焦点=false
	tp.物品界面背景_:显示(self.x+20,self.y+95+20)
	zts2:显示(self.x + 92-77-10+20,self.y + 340,"出售单价")
	self.资源组[2]:显示(self.x+97,self.y+337)
	self.资源组[11]:显示(self.x+190,self.y+337)
	self.输入框1:置可视(true,true)

	self.输入框1:置坐标(self.x + 102,self.y + 340)
	local xx = 0
	local yy = 0
	for i=self.道具开始,self.道具结束 do
		if self.物品[i].格子==nil then
		 	self.物品[i]:置坐标(self.x + xx * 51 + 24-2,self.y + yy * 51 + 95+20)
		 	if self.物品选中==i then
              self.选中背景:显示(self.x + xx * 51 + 24-1,self.y + yy * 51 + 95+20+1)
	 	 	end
		    self.物品[i]:显示(dt,x,y,self.鼠标)
		    if self.物品[i].焦点 and not tp.消息栏焦点 then
				if self.物品[i].物品 ~= nil then
				tp.提示:道具行囊(x,y,self.物品[i].物品)
				    if 引擎.鼠标弹起(左键) then
                      --self:设置物品(i)
                       self.物品选中=i
                        if self.上架物品[i]~=nil then
                            self.输入框1:置文本(self.上架物品[i])
                            self.资源组[11].按钮文字="下架"
                            self.输入框1:置文字颜色(tos(self.输入框1:取文本()+0))
                        else
         	                self.资源组[11].按钮文字="上架"
         	                self.输入框1:置文字颜色(-16777216)
          	            end
				  	end
				end
				self.焦点 = true
			end
		end
		-- print(self.物品[i].模型)
		--table.print(self.物品[i])
		xx = xx + 1
		if xx == 5 then
			xx = 0
			yy = yy + 1
		end
	end
end

function 摊位出售类:bb显示(dt,x,y)
    self.资源组[3]:显示(self.x+20,self.y+95+20)
	self.资源组[19]:显示(self.x+252,self.y+111)
	self.资源组[20]:显示(self.x+252,self.y+303)
	zts2:显示(self.x + 92-77-10+20,self.y + 340,"出售单价")
	self.资源组[2]:显示(self.x+97,self.y+337)
	self.资源组[11]:显示(self.x+190,self.y+337)
	self.输入框1:置可视(true,true)
	self.输入框1:置坐标(self.x + 102,self.y + 340)
	for n=1,#tp.队伍[1].宝宝列表 do
		bw:置坐标(self.x+37,self.y+100+n*25)
		if self.bb选中==n then
			box(self.x+37-10,self.y+80+n*25+15,self.x+37+208-20,self.y+80+n*25+20+23,-2097481216)
		end
		-- if tp.队伍[1].宝宝列表[n].加锁~=nil and tp.队伍[1].宝宝列表[n].加锁 then
		--     self.加锁:显示(self.x+24,self.y+80+n*25+20)
		-- end
		if self.bb选中==n then
			self.字体:置颜色(红色):显示(self.x+37,self.y+100+n*25,tp.队伍[1].宝宝列表[n].名称)
		else
			self.字体:置颜色(黑色):显示(self.x+37,self.y+100+n*25,tp.队伍[1].宝宝列表[n].名称)
		end
		if self.上架bb[n]~=nil then
			self.字体:置颜色(灰色):显示(self.x+37,self.y+100+n*25,tp.队伍[1].宝宝列表[n].名称)
		end
		if bw:检查点(x,y)  then
			if 引擎.鼠标弹起(0) and self.鼠标 and not tp.消息栏焦点 then
				--self:设置交易召唤兽(n)
				-- 点击事件=true
				self.bb选中=n
				if self.上架bb[n]~=nil then
					self.输入框1:置文本(self.上架bb[n])
					self.资源组[11].按钮文字="下架"
					self.输入框1:置文字颜色(tos(self.输入框1:取文本()+0))
				else
					self.资源组[11].按钮文字="上架"
					self.输入框1:置文字颜色(-16777216)
				end
            elseif 引擎.鼠标弹起(1) and self.鼠标 and not tp.消息栏焦点 then
                tp.窗口.召唤兽查看栏:打开(tp.队伍[1].宝宝列表[n])
            end
		end
 	end
	if self.资源组[3]:是否选中(x,y) then
	    self.焦点=true
	end
end


function 摊位出售类:打造显示(dt,x,y)
    self.资源组[3]:显示(self.x+20,self.y+95)---250  --235
    self.资源组[22]:显示(self.x+275,self.y+95)
	self.输入框1:置可视(false,false)
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
	for n=7,10 do
		if tp.队伍[1].辅助技能[n].等级 >= 10 then
			bw:置坐标(self.x+37,self.y+80+xx*25)
			if self.打造技能==tp.队伍[1].辅助技能[n].名称 then
				box(self.x+27,self.y+75+xx*25,self.x+225,self.y+100+xx*25,-2097481216)
			end
			if self.打造技能==tp.队伍[1].辅助技能[n].名称 then
				self.字体:置颜色(红色):显示(self.x+37,self.y+80+xx*25,tp.队伍[1].辅助技能[n].名称)
				self.字体:置颜色(红色):显示(self.x+137,self.y+80+xx*25,tp.队伍[1].辅助技能[n].等级.."级")
			else
				self.字体:置颜色(黑色):显示(self.x+37,self.y+80+xx*25,tp.队伍[1].辅助技能[n].名称)
				self.字体:置颜色(黑色):显示(self.x+137,self.y+80+xx*25,tp.队伍[1].辅助技能[n].等级.."级")
				for i=1,16 do
					self.打造输入框[tp.队伍[1].辅助技能[n].名称][i]:置可视(false,false)
				end
			end
			if bw:检查点(x,y)  then
				if 引擎.鼠标弹起(0) and self.鼠标 and not tp.消息栏焦点 then
					self.打造技能=tp.队伍[1].辅助技能[n].名称
					self.开始 = 1
					self.结束 = 9
					if  math.floor(tp.队伍[1].辅助技能[n].等级/10)< 9 then
						self.结束 = math.floor(tp.队伍[1].辅助技能[n].等级/10)
					end
	            end
			end
			xx = xx + 1
		end
 	end

	  if self.打造上架[self.打造技能]~=nil then
	 	if self.结束<16 then
		   for y = self.结束,16 do
		   	self.打造输入框[self.打造技能][y]:置可视(false,false)
		   end
		 end
		 if self.开始>1 then
		   for y = 1,self.开始 do
		   	self.打造输入框[self.打造技能][y]:置可视(false,false)
		   end
		 end
	end





      for n=7,10 do
        	local 等级 = math.floor(tp.队伍[1].辅助技能[n].等级/10)
			if self.打造技能==tp.队伍[1].辅助技能[n].名称 then

				local yy = 1
				 for i=self.开始,self.结束 do
                  local 显示等级 = i * 10
	                  if  self.已上架打造[self.打造技能] and self.已上架打造[self.打造技能][i]~=nil then
	                  	 self.字体:置颜色(红色):显示(self.x+290,self.y+80+yy*26,显示等级.."级")
	                  	 self.打造按钮[self.打造技能][i].按钮文字 = "下架"
                         self.打造输入框[self.打造技能][i]:置文字颜色(tos(self.打造输入框[self.打造技能][i]:取文本()+0))
	                  else
	                     self.字体:置颜色(黑色):显示(self.x+290,self.y+80+yy*26,显示等级.."级")
	                     self.打造按钮[self.打造技能][i].按钮文字="上架"
						 self.打造输入框[self.打造技能][i]:置文字颜色(-16777216)
	                  end
			        self.打造按钮[self.打造技能][i]:显示(self.x+480,self.y+78+yy*26)
			        self.资源组[23]:显示(self.x+330,self.y+78+yy*26)
			        self.打造输入框[self.打造技能][i]:置可视(true,true)
					self.打造输入框[self.打造技能][i]:置坐标(self.x+333,self.y+80+yy*26)

					yy = yy + 1
	                  if  self.打造按钮[self.打造技能][i]:事件判断() then
	                      if self.打造按钮[self.打造技能][i].按钮文字=="上架"  then
		                  	if self.打造输入框[self.打造技能][i]:取文本()=="" or self.打造输入框[self.打造技能][i]:取文本()+0<=0 then
								tp.常规提示:打开("#Y/请先设置商品的单价")
								return
							end
							self.打造上架[self.打造技能][i]=self.打造输入框[self.打造技能][i]:取文本()
                            请求服务(3722,{打造=self.打造上架,价格=self.打造输入框[self.打造技能][i]:取文本()})
                            self.打造按钮[self.打造技能][i].按钮文字 = "下架"
                            self.打造输入框[self.打造技能][i]:置文字颜色(tos(self.打造输入框[self.打造技能][i]:取文本()+0))
                           else
                           	   请求服务(3723,{打造=self.打造技能,等级 = i})
                               self.打造上架[self.打造技能][i] = nil
                               self.打造按钮[self.打造技能][i].按钮文字 = "上架"
                               self.打造输入框[self.打造技能][i]:置文字颜色(-16777216)

                           end
	                  	return
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
					if self.结束 == 等级 then
						tp.常规提示:打开("#Y/已经到最低层了")
						return
					end
					self.开始 = self.开始 + 1
				    self.结束 = self.结束 + 1
				end
			end
       end
	if self.资源组[3]:是否选中(x,y) then
	    self.焦点=true
	end

end


function 摊位出售类:显示(dt,x,y)
	self.焦点=false
	if self.显示类型~="打造" then
		self.焦点=false
		self.资源组[1]:置宽高(291,410)
	    self.资源组[14]:置宽高(287,18)
	    self.资源组[1]:显示(self.x,self.y)
	    self.资源组[14]:显示(self.x+2,self.y+2)

		tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
		zts1:置字间距(3)
		zts1:置颜色(白色):显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"摆摊系统")
		zts1:置字间距(0)
		self.资源组[5]:更新(x,y)
		self.资源组[6]:更新(x,y,self.显示类型~="物品")
		self.资源组[7]:更新(x,y,self.显示类型~="bb")
		self.资源组[21]:更新(x,y,self.显示类型~="打造")
		self.资源组[8]:更新(x,y)
		self.资源组[11]:更新(x,y)
		self.资源组[5]:显示(self.x+269,self.y+2)
		self.资源组[6]:显示(self.x+16,self.y+87)
		self.资源组[7]:显示(self.x+16+95,self.y+87)
		self.资源组[21]:显示(self.x+16+95+95,self.y+87)
		self.资源组[8]:显示(self.x+165,self.y+30)

		zts2:置字间距(2)
		zts2:置颜色(白色)
		zts2:显示(self.x + 62-47-3,self.y + 35-8+7,"招牌")
		zts2:显示(self.x + 62-47-3,self.y + 60-8+7,"摊主")
		zts2:置字间距(0)
		zts2:显示(self.x + 207-40+5,self.y + 60-8+9,"ID")
		zts2:置字间距(0)
		self.资源组[13]:显示(self.x+62-5,self.y+60-3)
		self.资源组[13]:显示(self.x+62-5,self.y+35-3)
		self.资源组[2]:显示(self.x+207-10,self.y+60-3)
		self.字体:置颜色(黑色)
		self.字体:显示(self.x + 62,self.y + 60,self.摊主名称)
		self.字体:显示(self.x + 207,self.y + 60,self.摊主id)
		if self.显示类型 == "物品" then
		 	 for i=1,5 do
			     self.背包按钮[i]:更新(x,y,self.道具结束~=i*20)
			     self.背包按钮[i]:显示(self.x-8+i*35,self.y+370)
			     if self.背包按钮[i]:事件判断() then
			       	self.道具结束=i*20
			       	self.道具开始=self.道具结束-19
			      end
			  end
			  self.资源组[9]:更新(x,y)
		      self.资源组[9]:显示(self.x+215,self.y+370)
	   else
	   	    self.资源组[9]:更新(x,y)
	        self.资源组[9]:显示(self.x+135,self.y+370)
			self.资源组[10]:更新(x,y)
			self.资源组[10]:显示(self.x+35,self.y+370)

	   end
	else
		self.资源组[1]:置宽高(582,360)
	    self.资源组[14]:置宽高(578,18)
	    self.资源组[1]:显示(self.x,self.y)
	    self.资源组[14]:显示(self.x+2,self.y+2)
		tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
		zts1:置字间距(3)
		zts1:置颜色(白色):显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"摆摊系统")
		zts1:置字间距(0)
		self.资源组[5]:更新(x,y)
		self.资源组[6]:更新(x,y,self.显示类型~="物品")
		self.资源组[7]:更新(x,y,self.显示类型~="bb")
		self.资源组[21]:更新(x,y,self.显示类型~="打造")
		self.资源组[8]:更新(x,y)
		self.资源组[11]:更新(x,y)
		self.资源组[5]:显示(self.x+562,self.y+2)
		self.资源组[6]:显示(self.x+136,self.y+67)
		self.资源组[7]:显示(self.x+136+95,self.y+67)
		self.资源组[21]:显示(self.x+136+95+95,self.y+67)
		self.资源组[8]:显示(self.x+165,self.y+30)
		self.资源组[9]:更新(x,y)
	    self.资源组[9]:显示(self.x+135,self.y+320)
	    self.资源组[10]:更新(x,y)
		self.资源组[10]:显示(self.x+35,self.y+320)
		zts2:置字间距(2)
		zts2:置颜色(白色)
		zts2:显示(self.x + 12,self.y + 34,"招牌")
		zts2:显示(self.x + 250,self.y + 34,"摊主")
		zts2:置字间距(0)
		zts2:显示(self.x + 415,self.y + 34,"ID")
		zts2:置字间距(0)
		self.资源组[13]:显示(self.x+295,self.y+32)
		self.资源组[13]:显示(self.x+57,self.y+32)
		self.资源组[2]:显示(self.x+445,self.y+32)
		self.字体:置颜色(黑色)
		self.字体:显示(self.x + 300,self.y + 35,self.摊主名称)
		self.字体:显示(self.x + 448,self.y + 35,self.摊主id)


	end
	self.输入框:置坐标(self.x + 62,self.y + 35)

	if self.资源组[5]:事件判断() then
		self:打开()
	elseif self.资源组[6]:事件判断() then
		self.显示类型="物品"
		self.bb选中=0
	    self.物品选中=0
	    self.打造技能 = ""
	    self.输入框1:置文本("")
	elseif self.资源组[7]:事件判断() then
		self.显示类型="bb"
		self.bb选中=0
	    self.物品选中=0
	    self.打造技能 = ""
	    self.输入框1:置文本("")
	elseif self.资源组[21]:事件判断() then
		self.显示类型="打造"
		self.bb选中=0
	    self.物品选中=0
	    self.打造技能 = ""
	    self.输入框1:置文本("")
	elseif self.资源组[8]:事件判断() and self.输入框:取文本()~="" then
		请求服务(3721,{名称=self.输入框:取文本()})
	elseif self.资源组[9]:事件判断()  then
		self:打开()
		请求服务(3724)
	end
	if self.显示类型=="物品" then
		self:物品显示(dt,x,y)
	elseif self.显示类型=="bb" then
		self:bb显示(dt,x,y)
	elseif self.显示类型=="打造" then
		self:打造显示(dt,x,y)
	end
	self.控件类:更新(dt,x,y)
	if self.输入框._已碰撞 then
		self.焦点 = true
	end
	if self.输入框1._已碰撞 then
		self.焦点 = true
	end

	for i=1,16 do
		if self.打造输入框.打造技巧[i]._已碰撞 then
		   self.焦点 = true
		end
	end
	for i=1,16 do
		if self.打造输入框.裁缝技巧[i]._已碰撞 then
		   self.焦点 = true
		end
	end
	for i=1,16 do
		if self.打造输入框.炼金术[i]._已碰撞 then
		   self.焦点 = true
		end
	end
	for i=1,16 do
		if self.打造输入框.淬灵之术[i]._已碰撞 then
		   self.焦点 = true
		end
	end

	self.控件类:显示(x,y)

	if self.资源组[11]:事件判断() then
		if self.显示类型=="bb" then
			if self.bb选中==0 then
				tp.常规提示:打开("#Y/请先设置要出售的召唤兽")
				return
			end
		elseif self.显示类型=="物品" then
			if self.物品选中==0 then
				tp.常规提示:打开("#Y/请先设置要出售的物品")
				return
			end
		end
		if self.资源组[11].按钮文字=="上架" then
			if self.输入框1:取文本()=="" or self.输入框1:取文本()+0<=0 then
				tp.常规提示:打开("#Y/请先设置商品的单价")
				return
			end
			if self.显示类型=="bb" then
				if tp.队伍[1].宝宝列表[self.bb选中]~=nil and tp.队伍[1].宝宝列表[self.bb选中].加锁~=nil and tp.队伍[1].宝宝列表[self.bb选中].加锁 then
					tp.常规提示:打开("#Y/该召唤兽已加锁,请先解锁！")
				    return
				end
				请求服务(3722,{bb=self.bb选中,价格=self.输入框1:取文本()})


			else
				if tp.道具列表[self.物品选中]~=nil and tp.道具列表[self.物品选中].加锁~=nil and tp.道具列表[self.物品选中].加锁 then
					tp.常规提示:打开("#Y/该物品已加锁,请先解锁！")
				    return
				end
				请求服务(3722,{道具=self.物品选中,价格=self.输入框1:取文本()})

			end
			self.资源组[11].按钮文字="下架"
			self.输入框1:置文字颜色(tos(self.输入框1:取文本()+0))
		else
			if self.显示类型=="bb" then
				请求服务(3723,{bb=self.bb选中})
			else
				请求服务(3723,{道具=self.物品选中})
			end
			self.资源组[11].按钮文字="上架"
			self.输入框1:置文字颜色(-16777216)

		end
	end
end

function 摊位出售类:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y) then
		return true
	else
		return false
	end
end

function 摊位出售类:初始移动(x,y)
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

function 摊位出售类:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end
function 摊位出售类:更新(dt) end
return 摊位出售类