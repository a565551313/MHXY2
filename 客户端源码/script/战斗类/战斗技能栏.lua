--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-08 19:20:11
--======================================================================--
local 场景类_战斗技能栏 = class()
local tp
function 场景类_战斗技能栏:初始化(根)
	self.ID = 103
	self.x = 320
	self.y = 115
	self.xx = 0
	self.yy = 0
	self.注释 = "战斗"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	local 按钮 = 根._按钮
	local 资源 = 根.资源
    local 自适应 = 根._自适应
   self.资源组 = {
	    [1] = 自适应.创建(0,1,195,490,3,9),
		[2] = 自适应.创建(1,1,191,18,1,3,nil,18),
		--195 460

		[3] = 按钮.创建(自适应.创建(18,4,16,16,4,1),0,0,4,true,true),
	}
	self.技能 = {}
	for i=1,30 do
		self.技能[i] = 根._技能格子(0,0,i,"战斗技能栏")
	end
	self.背景 = 1
	self.窗口时间 = 0
	self.上回合 = nil
	self.上回合人物 = nil
	self.上回合宠物 = nil
	self.上回合人物特技 = nil

	tp = 根
	self.当前类型=nil
	self.法术类型=nil
	self.默认法术=nil
	self.操作对象=1
	self.循环个数 = 15

end

--function 场景类_战斗技能栏:打开(技能组,法术类型,人物或宠物,技能冷却,操作对象,战斗单位)
function 场景类_战斗技能栏:打开(技能组,类型,操作对象,战斗单位)
	if self.可视 then
		self.背景 = 1
		self.可视 = false
		self.当前类型=nil
		self.法术类型=nil
		战斗类.战斗指令.法术开关=false
	else
		for i=1,30 do
			self.技能[i]:置技能(nil)
			self.技能[i].剩余冷却回合 =nil
		end
		local 数量 = 0
		for k,v in pairs(技能组) do
			self.技能[k]:置技能(v,true)
			if 战斗单位.技能冷却 and 战斗单位.技能冷却[v.名称] then
				self.技能[k].剩余冷却回合 = 战斗单位.技能冷却[v.名称]
			end
			数量 = 数量 + 1
		end
		if 数量 >= 15 then
			self.背景 = 2
			self.资源组[1]:置宽高(195,490)
			self.循环个数 = 30
			self.y = 65
		else
			self.背景 = 1
		    self.资源组[1]:置宽高(195,280)
		    self.循环个数 = 15
		    self.y = 115
		end
		tp.运行时间 = tp.运行时间 + 1
	  	self.窗口时间 = tp.运行时间
	  	self.可视 = true
	  	self.当前类型 = 战斗单位.类型
		self.法术类型 = 类型
		self.操作对象 = 操作对象
        self.战斗单位 = 战斗单位
	  	战斗类.战斗指令.法术开关=true
	  	self.默认法术 = 战斗类.战斗指令:获取默认法术(self.操作对象)
	end
end

function 场景类_战斗技能栏:更新()
end

function 场景类_战斗技能栏:显示(dt,x,y)
	if not self.可视 then
		return
	end
	self.资源组[3]:更新(x,y)
	--self:检查点(self.x,self.y)
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[2]:显示(self.x+2,self.y+2)
	-- if self.鼠标 then
	self.资源组[3]:显示(self.x+175,self.y+2)
		--print(self.资源组[3]:事件判断())
   tp.字体表.排行字体:置颜色(白色):显示(self.x + 5,self.y + 3,self.战斗单位.名称)
	if self.资源组[3]:事件判断() then
		self:打开()
		return false
	end
	-- end

	local xx = 0
	local yy = 0
	for w=1,self.循环个数 do
		tp.技能背景:显示(self.x+15+xx*60,self.y+32+yy*42)
		if self.技能[w]~=nil then
			self.技能[w]:置坐标(self.x+16+xx*60,self.y+33+yy*42)
			self.技能[w]:显示(x,y,true or self.鼠标)
			 if  self.技能[w].剩余冷却回合 ~= nil and self.技能[w].剩余冷却回合>0 then
				 self.技能[w].技能.模型:灰度级()
				 if string.len(self.技能[w].剩余冷却回合)>1 then
				 	 tp.字体表.冷却字体:置颜色(白色):显示(self.x+19+xx*60,self.y+38+yy*42,self.技能[w].剩余冷却回合)
				  else
				     tp.字体表.冷却字体:置颜色(白色):显示(self.x+27+xx*60,self.y+38+yy*42,self.技能[w].剩余冷却回合)
				  end
			end
			if self.技能[w].技能 and self.技能[w].焦点 then
				tp.提示:技能(x,y,self.技能[w].技能,self.技能[w].剩余冷却回合)
				if not self.技能[w].剩余冷却回合 or self.技能[w].剩余冷却回合<=0 then
					if self.技能[w].事件 then
						战斗类.战斗指令:设置法术参数(self.技能[w])
						self:打开()
					elseif 引擎.鼠标弹起(右键) then
							if self.法术类型=="法术" then
								if self.当前类型=="角色" then
									self.上回合人物=w
								else
								    self.上回合宠物=w
								end
								战斗类.战斗指令:设置默认法术(w,self.操作对象)
							end
							战斗类.战斗指令:设置法术参数(self.技能[w])
							self:打开()
					end
				end
				self.焦点 = true
			end
			xx = xx + 1
			if xx > 2 then
				xx = 0
				yy = yy + 1
			end
		end
	end

	if self.默认法术 ~= nil and self.技能[self.默认法术] and self.技能[self.默认法术].技能 and self.法术类型=="法术" then
		if self.背景== 1  then
		   tp.字体表.普通字体:置颜色(-256):显示(self.x+15,self.y+255,self.技能[self.默认法术].技能.名称)
		else
		   tp.字体表.普通字体:置颜色(-256):显示(self.x+15,self.y+465,self.技能[self.默认法术].技能.名称)
		end
	end

	if self.法术类型=="特技" and self.当前类型=="角色" and self.战斗单位 and self.战斗单位.愤怒  then
		if self.背景== 1  then
		   tp.字体表.普通字体:置颜色(-256):显示(self.x+15,self.y+255,"当前愤怒:"..self.战斗单位.愤怒)
		else
		   tp.字体表.普通字体:置颜色(-256):显示(self.x+15,self.y+465,"当前愤怒:"..self.战斗单位.愤怒)
		end

	end

	if tp.按钮焦点 then
		self.焦点 = true
	end
	if 引擎.鼠标弹起(1) and not tp.禁止关闭 and self.鼠标 then
		self:打开()
	end
end

function 场景类_战斗技能栏:检查点(x,y)
	if self.资源组[1]:是否选中(x,y)  then
		self.鼠标=true
		return true
   else
   	    self.鼠标=false
   	    return false
	end
end

function 场景类_战斗技能栏:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		--tp.场景.战斗.移动窗口 = true
	end
	if self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_战斗技能栏:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_战斗技能栏