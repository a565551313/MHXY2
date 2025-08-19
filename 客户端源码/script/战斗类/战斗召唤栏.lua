--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-10-08 12:02:46
--======================================================================--
local 场景类_战斗召唤栏 = class()
local tp
local tx = 引擎.取头像
function 场景类_战斗召唤栏:初始化(根)
	self.ID = 107
	self.x = 230
	self.y = 105
	self.xx = 0
	self.yy = 0
	self.注释 = "战斗召唤栏"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	local 按钮 = require("script/系统类/按钮")
	local 自适应 = 根._自适应
	local 资源 = 根.资源
	self.上页 = 根._按钮(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x7AB5584C),0,0,3,nil,nil)
	self.下页 = 根._按钮(根.资源:载入('登陆资源.wdf',"网易WDF动画",0xCB50AB1D),0,0,3,nil,nil)
	self.资源组 = {
		[1] = 根.资源:载入('新界面.wdf',"网易WDF动画",0x00000404),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[3] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x335CECBC),0,0,4,true,true), --上
		[4] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xB7F2FF5E),0,0,4,true,true), --下
		[5] = 按钮.创建(自适应.创建(12,4,72,22,1,3),0,0,4,true,true,"召唤宠物"),
		[23] = 根.资源:载入('登陆资源.wdf',"网易WDF动画",0x363AAF1B),--宠物背景头像资源
		[24] = 根.资源:载入('新界面.wdf',"网易WDF动画",0x00000128),--技能背景
		--[19] = 图像类("wdf/pic/认证.png"),
	}
	-- 适应组[111] = {按钮=资源:载入('登陆资源.wdf',"网易WDF动画",0x335CECBC)} -- 小上翻10*13
	-- 适应组[112] = {按钮=资源:载入('登陆资源.wdf',"网易WDF动画",0xB7F2FF5E)}

	self.窗口时间 = 0
	self.选中召唤兽 = 0
	self.加入 = 0
	self.技能页数 = 0
	self.人物 = ""
	self.头像组 = {}
	tp = 根
	self.物品 = {}
	local wp = tp._物品格子
	local 底图 =根.资源:载入('登陆资源.wdf',"网易WDF动画",0xA393A808)
	for i=1,3 do
	    self.物品[i] = wp(0,0,i,"召唤兽资质物品",底图)
	end
	self.技能 = {}


end


function 场景类_战斗召唤栏:打开(人物,数量)
	self.召唤数量=数量
	if self.可视 then
		self.加入 = 0
		self.选中召唤兽 = 0
		--self.物品 =  nil
		self.可视 = false
		self.技能页数 = 0
		self.头像组 = {}
        self.技能 = {}
		战斗类.战斗指令.召唤开关=false

	else

		self.加入 = 0
		self.选中召唤兽 = 0
		self.人物 = 人物
		self.可视 = true
		self.技能页数 = 0
		tp.运行时间 = tp.运行时间 + 1
	  	self.窗口时间 = tp.运行时间
	  	战斗类.战斗指令.召唤开关=true
	  	self.技能 = {}

	end
end

function 场景类_战斗召唤栏:更新(dt,mx,my)
	self:检查点(mx,my)

	if self.可视 then
		self.焦点 = false
		if self.鼠标 then
			if self.资源组[2]:事件判断()  then
				self:打开()
			end
			if self.资源组[3]:事件判断() and self.加入>0 then
				self.加入 = self.加入 - 1
			end
			if self.资源组[4]:事件判断() and self.加入 < #self.人物.宝宝列表 then
                 self.加入 = self.加入 + 1
				--print(加入)
			end
			if self.资源组[5]:事件判断() then
				if self:取是否召唤(self.选中召唤兽) then
                 	tp.常规提示:打开("#Y/该召唤兽已经参加过战斗了")
                 	return
                elseif self.选中召唤兽 == 0 then
                 	return
                else
                 	战斗类.战斗指令:设置召唤(self.选中召唤兽)
                 	self:打开()
                 	return
				 end
			end
			if 引擎.鼠标弹起(1) and not tp.禁止关闭 then
				self:打开()
			end
			if tp.按钮焦点 then
				self.焦点 = true
			end
		end
	end
end

function 场景类_战斗召唤栏:显示(dt,mx,my)
	if self.可视 then
		self.资源组[1]:显示(self.x+13,self.y-16)
		self.资源组[24]:显示(self.x + 207,self.y + 133)
		self.资源组[2]:更新1(mx,my)
		self.资源组[3]:更新1(mx,my,self.加入 > 0)
		self.资源组[4]:更新1(mx,my,self.加入 < #self.人物.宝宝列表)
		self.资源组[5]:更新1(mx,my,self.选中召唤兽 ~= 0 and self.人物.参战宝宝 ~= self.人物.宝宝列表[self.选中召唤兽])
		if not self.鼠标 then
			self.资源组[2].焦点 = 0
			if self.加入 > 0 then
				self.资源组[3].焦点 = 0
			else
				self.资源组[3].焦点 = 3
			end
			if self.加入 < #self.人物.宝宝列表 - 5 then
				self.资源组[4].焦点 = 0
			else
				self.资源组[4].焦点 = 3
			end
			if self.选中召唤兽 ~= 0 then
				self.资源组[5].焦点 = 0
			else
				self.资源组[5].焦点 = 3
			end
		end
		self.资源组[2]:显示(self.x + 364+13,self.y + 4-16)
		self.资源组[3]:显示(self.x + 177+13,self.y + 62-16)
		self.资源组[4]:显示(self.x + 177+13,self.y + 261-16)
		self.资源组[5]:显示(self.x + 157+13,self.y + 408+13-16,true)


		local 偏移x = 26
		local 偏移y = 40

		for m=1,7 do
			if self.人物.宝宝列表[m] ~= nil then
				if((m + self.加入) <= (5 + self.加入)) then
					if(mx - self.x > 10 and my - self.y > 偏移y + 40*m - 30 and mx - self.x < 150 and my - self.y + 3 < 偏移y + 40*(m+1) - 13 ) and self.鼠标 and not 文本栏焦点 then
						if mx - self.x+12 > 0 and my - self.y-35 > 0 + 40 * m - 30  and mx - self.x < 150 and my - self.y+7 < 42 + 40*(m+1) - 13 and self.人物.宝宝列表[m] ~= nil and not 文本栏焦点 then
							if 引擎.鼠标弹起(0) then
								if self.人物.宝宝列表[m + self.加入] then
								   self.选中召唤兽 = m + self.加入
							    end
							    for i=1,3 do
							    	self.物品[i]:置物品(nil)
							    	if  self.人物.宝宝列表[self.选中召唤兽]~=nil and self.人物.宝宝列表[self.选中召唤兽].装备~=nil then
										self.物品[i]:置物品(self.人物.宝宝列表[self.选中召唤兽].装备[i])
									end
						        end
							    local 格子 = tp._技能格子
								for i=1,24 do
									self.技能[i] = 格子(0,0,i,"召唤技能栏")
									self.技能[i]:置技能(nil)
								end
								for i=1,#self.人物.宝宝列表[self.选中召唤兽].技能 do
									 local 临时技能=tp._技能.创建()
									 临时技能:置对象(self.人物.宝宝列表[self.选中召唤兽].技能[i])
									self.技能[i]:置技能(临时技能)
							    end
						end
							for n=1,19 do
								引擎.画矩形(self.x + 25 + 偏移x,self.y + 偏移y + 40 * m - 30 + n,self.x + 170,self.y + 偏移y + 40 * m - 13 + n,ARGB(255,201,207,109))
							end
							self.焦点 = true
						end
					end
				end
			end
		end
		if (self.选中召唤兽 - self.加入) > 0  and (self.选中召唤兽 - self.加入 <= 5) then
			for n=1,19 do
				引擎.画矩形(self.x + 25 + 偏移x,self.y + 偏移y + 40 * (self.选中召唤兽 - self.加入) - 30 + n,self.x + 170,self.y + 偏移y + 40 * (self.选中召唤兽 - self.加入) - 13 + n,ARGB(255,91,90,219))
			end
		end
		for n=1,7	do
			if((n + self.加入) <= (5 + self.加入)) and self.人物.宝宝列表[n + self.加入]~=nil then
				local 颜色 = ARGB(255,0,0,0)
				if self.人物.宝宝列表[n + self.加入] ==  self.人物.参战宝宝 then
					颜色 = ARGB(255,255,255,0)
				end
			  if self.头像组[n + self.加入] == nil then
			  	local i = tx(self.人物.宝宝列表[n + self.加入].模型)
			  	self.头像组[n+self.加入] = tp.资源:载入(i[7],"网易WDF动画",i[1])
			  end
			   self.资源组[23]:显示(self.x + 4 + 偏移x,self.y + 偏移y + 9 + (n-1) * 40)
			   self.头像组[n+self.加入]:显示(self.x + 5 + 偏移x,self.y + 偏移y + 11 + (n-1) * 40)
			   tp.字体表.普通字体:置颜色(颜色):显示(self.x + 偏移x+60,self.y + 20+偏移y + (n-1) * 40,self.人物.宝宝列表[n + self.加入].名称)

			end
		end

	if self.选中召唤兽 ~= 0 then





	if self.技能页数 > 0 then
		self.上页:更新(mx,my,self.技能页数>0)
		self.上页:显示(self.x+374+5,self.y+157-16)
	end
	if #self.人物.宝宝列表[self.选中召唤兽].技能 > 12 then
		self.下页:更新(mx,my,self.技能页数<2)
		self.下页:显示(self.x+374+5,self.y+245-16)
	end
	if self.上页:事件判断() then
		if self.技能页数 == 0 then
			self.技能页数 = 0
		else
        self.技能页数 = self.技能页数 - 1
    end
	elseif self.下页:事件判断() then
         self.技能页数 = self.技能页数 + 1
	end
	local 坐标={[1]=199+14,[2]=259+14,[3]=319+14}
	for i=1,3 do
		 self.物品[i]:置坐标(self.x + 坐标[i],self.y + 90-16)
		 self.物品[i]:显示(dt,mx,my,self.鼠标)
		 if self.物品[i].物品 ~= nil and self.物品[i].焦点 then
			tp.提示:道具行囊(mx,my,self.物品[i].物品)
	    end
    end

      local xx,yy = 0,0
	for i=1+self.技能页数*12,12+self.技能页数*12 do
		local jx = self.x+208+(xx*43)
		local jy = self.y+135+(yy*43)
		if self.技能[i]~=nil then
			self.技能[i]:置坐标(jx+1,jy+1)
		   	self.技能[i]:显示(mx,my,self.鼠标)
		   	if self.技能[i].焦点  then
		   	   tp.提示:技能(mx,my,self.技能[i].技能)
		    end
	        xx = xx + 1
		    if xx >= 4 then
			   xx = 0
			   yy = yy + 1
			end
	    end

    end

			tp.字体表.排行字体1:置颜色(0xFF000000)
			tp.字体表.排行字体1:显示(self.x + 50+4+13,self.y+271+18-16,self.人物.宝宝列表[self.选中召唤兽].名称)
			tp.字体表.排行字体1:显示(self.x + 50+4+13,self.y+298+18-1-16,self.人物.宝宝列表[self.选中召唤兽].等级)
			tp.字体表.排行字体1:显示(self.x + 50+4+13,self.y+326+18-2-1-16,self.人物.宝宝列表[self.选中召唤兽].气血.."/"..self.人物.宝宝列表[self.选中召唤兽].最大气血)
			tp.字体表.排行字体1:显示(self.x + 50+4+13,self.y+354+18-3-2-16,self.人物.宝宝列表[self.选中召唤兽].魔法.."/"..self.人物.宝宝列表[self.选中召唤兽].最大魔法)
			tp.字体表.排行字体1:显示(self.x + 50+4+13,self.y+381+18-4-2-16,self.人物.宝宝列表[self.选中召唤兽].寿命)

			tp.字体表.排行字体1:显示(self.x + 234+4+13,self.y+271+18-16,self.人物.宝宝列表[self.选中召唤兽].伤害)
			tp.字体表.排行字体1:显示(self.x + 234+4+13,self.y+298+18-1-16,self.人物.宝宝列表[self.选中召唤兽].防御)
			tp.字体表.排行字体1:显示(self.x + 234+4+13,self.y+326+18-2-1-16,self.人物.宝宝列表[self.选中召唤兽].速度)
			tp.字体表.排行字体1:显示(self.x + 234+4+13,self.y+354+18-3-2-16,self.人物.宝宝列表[self.选中召唤兽].灵力)
			tp.字体表.排行字体1:显示(self.x + 234+4+13,self.y+381+18-4-2-16,self.人物.宝宝列表[self.选中召唤兽].忠诚)
		end


	end
end
function 场景类_战斗召唤栏:取是否召唤(id)
 	for n=1,#self.召唤数量 do
     	if self.召唤数量[n]==id then
           return true
     	end
 	end
 	return false
end

function 场景类_战斗召唤栏:检查点(x,y)
	local n = false
	self.鼠标=false
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		n  = true
		self.鼠标=true
	end
	return n
end

function 场景类_战斗召唤栏:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not 引擎.消息栏焦点 then
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

function 场景类_战斗召唤栏:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_战斗召唤栏