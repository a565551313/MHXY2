-- @Author: ASUS
-- @Date:   2021-10-05 15:37:16
-- @Last Modified by:   ASUS
-- @Last Modified time: 2023-12-13 13:46:01
local 场景类_战斗灵宝栏 = class()

function 场景类_战斗灵宝栏:初始化(根)
	self.ID = 146
	self.x = 158
	self.y = 142
	self.xx = 0
	self.yy = 0
	self.注释 = "战斗灵宝栏"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	local 资源 = 根.资源
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	self.资源组 = {
		[0] = 自适应.创建(1,1,491,18,1,3,nil,18), -- 背景
		[1] = 自适应.创建(0,1,495,245,3,9), -- 横条
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[3] = 自适应.创建(2,1,223,200,3,9),
		-- [3] = 按钮.创建(资源:载入('org.rpk',"网易WDF动画",16777558),0,0,4,nil,nil,"  使用"),
		-- [4] = 按钮.创建(资源:载入('org.rpk',"网易WDF动画",16777558),0,0,4,nil,nil,"  使用"),
		--[6] = 自适应.创建(2,1,221,242,3,9),
		}
	self.灵宝佩戴 = {}
	self.消耗 = {[1]=1,[2]=1}
	self.当前灵元 = 0
	zts = tp.字体表.普通字体
	zts1 = tp.字体表.描边字体
end

function 场景类_战斗灵宝栏:打开(sj)
	if self.可视 then
		self.可视 = false
	else
		self.灵宝佩戴 = {}
		self.消耗 = {[1]=1,[2]=1}
		self.数据=sj

		self.当前灵元 = tonumber(self.数据.灵元)
		for i=1,2 do
			self.灵宝佩戴[i]={}
			if self.数据.灵宝佩戴[i]~=nil then
				local 资源=引擎.取物品(self.数据.灵宝佩戴[i].名称)
	 			self.灵宝佩戴[i].大动画 = tp.资源:载入(资源[11],"网易WDF动画",资源[13])
				self.灵宝佩戴[i].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
				self.灵宝佩戴[i].名称 = self.数据.灵宝佩戴[i].名称
				self.灵宝佩戴[i].介绍 = 资源[1]
				if self.数据.灵宝佩戴[i].气血==1 then
					self.消耗[i] = 1
				elseif self.数据.灵宝佩戴[i].气血==2 then
					self.消耗[i] = 3
				elseif self.数据.灵宝佩戴[i].气血==3 then
					self.消耗[i] = 7

				end

				self.灵宝佩戴[i].介绍 =self.灵宝佩戴[i].介绍..
									  "\n#W/【使用条件】\n".."#G/"..self.数据.灵宝佩戴[i].特技.."#G/专用，消耗#G/"..self.消耗[i].."#G点灵元"..
									  "\n#R/【战斗效果】"..
									  "\n#W/"..资源[15]..
									  "\n#Y/当前灵元:#G"..self.当前灵元
			end
		end

		self.可视 = true
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	end
end

function 场景类_战斗灵宝栏:更新(dt,x,y)
	self.鼠标=self:检查点(x,y)
end

function 场景类_战斗灵宝栏:显示(dt,x,y)
	if not self.可视 then
		return false
	end
	self.焦点 = false
	if self.鼠标 then
		self.资源组[2]:更新(x,y)
		-- self.资源组[3]:更新(x,y,not (self.灵宝佩戴[1].物品== nil),2)
		-- self.资源组[4]:更新(x,y,not (self.灵宝佩戴[2].物品== nil),2)
		if self.资源组[2]:事件判断() then
			self:打开()
		-- elseif self.资源组[3]:事件判断() then
		-- 	 战斗类.战斗指令:设置灵宝参数(1,self:取可用道具(self.灵宝佩戴[1].物品.名称))
		-- elseif self.资源组[4]:事件判断() then
		-- 	 战斗类.战斗指令:设置灵宝参数(2,self:取可用道具(self.灵宝佩戴[2].物品.名称))
		end
	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[0]:显示(self.x+2,self.y+2)
	self.资源组[2]:显示(self.x + 475,self.y + 2,true)
	tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	zts1:置字间距(3)
	zts1:显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"选择灵宝")
	zts1:置字间距(0)
	for i=1,2 do
		self.资源组[3]:显示(self.x + 15+((i-1)*240),self.y + 30)
		if self.灵宝佩戴[i] and self.灵宝佩戴[i].大动画 then
			self.灵宝佩戴[i].大动画:显示(self.x + 62+((i-1)*240),self.y + 70)
			if self.灵宝佩戴[i].大动画:是否选中(x,y) then
				tp.提示:商城提示(x,y,self.灵宝佩戴[i].名称,self.灵宝佩戴[i].介绍,self.灵宝佩戴[i].大动画)
				 if 引擎.鼠标弹起(0) then
				 	战斗类.战斗指令:设置灵宝参数(i,self:取可用道具(self.灵宝佩戴[i].名称))
				 end
			end

		end
	end

	if tp.按钮焦点 then
		self.焦点 = true
	end
	if 引擎.鼠标弹起(1)  and not tp.禁止关闭 and self.鼠标 then
		self:打开()
	end
end

function 场景类_战斗灵宝栏:取可用道具(名称)
	if 名称=="风舞心经" or 名称=="寒霜盾戟"  or 名称=="战神宝典" then
		return 66
	elseif 名称=="断穹巨剑" or 名称=="相思寒针" or 名称=="锢魂命谱" or 名称=="青狮獠牙"  or 名称=="冥火炼炉" or 名称=="缚仙蛛丝" or 名称=="煞魂冥灯" or 名称=="九霄龙锥" or 名称=="化怨清莲"
		or 名称=="天雷音鼓"  then
		return 4
	elseif 名称=="静心禅珠" or 名称=="宁心道符" or 名称=="真阳令旗" or 名称=="护体灵盾" or 名称=="惊兽云尺"  or 名称=="乾坤金卷" or 名称=="乾坤木卷" or 名称=="乾坤水卷" or 名称=="乾坤火卷" or 名称=="乾坤土卷"  or 名称=="赤炎战笛" then
		return 3
	end
	return 0
 end

function 场景类_战斗灵宝栏:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		return true
	end
	return false
end

function 场景类_战斗灵宝栏:初始移动(x,y)
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

function 场景类_战斗灵宝栏:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_战斗灵宝栏