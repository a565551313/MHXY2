--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-14 03:38:53
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 场景类_假人 = class()
local tp

function 场景类_假人:初始化(假人)
	if tp == nil then
		tp = 引擎.场景
	end
	if 假人.模型=="宝箱" then
	 	假人.方向=0
	end
	self.假人 = {}
	self.移动 = false
	self.行为 = "静立"
	self.类型 = "假人"
	self.标识 = 假人.id
	self.名称 = 假人.名称
	self.称谓 = 假人.称谓
	self.模型 = 假人.模型
	self.编号 = 假人.编号
	self.方向 = 假人.方向
	self.事件 = 假人.事件
	self.武器 = 假人.武器
	self.锦衣 = 假人.锦衣
	self.变异 = 假人.变异
	self.饰品 = 假人.显示饰品
	self.染色组 = 假人.染色组
	self.染色方案 = 假人.染色方案
	self.武器子类 = 假人.武器子类
	self.执行事件 = 假人.执行事件
	self.地图颜色 = 假人.地图颜色
	self.行走开关 = 假人.行走开关
	self.武器染色组 = 假人.武器染色组
	self.武器染色方案 = 假人.武器染色方案
	if 假人.X and 假人.Y then
		self.坐标 = 生成XY(math.floor(假人.X*20) or 0,math.floor(假人.Y*20) or 0)
	elseif 假人.x and 假人.y then
		self.坐标 = 生成XY(math.floor(假人.x*20) or 0,math.floor(假人.y*20)or 0)
	end
	self.是否显示 = true
	self.记忆方向 = self.方向
	self.触碰延时 = os.time()
	self.称谓动画 = nil
	self.目标格子 = {}
	self.任务开关 = {}
	if self.执行事件 == "明雷" or self.行走开关 then
		self.行走时间 = 20+math.random(-10,10)
	end
	if self.变异 and 染色信息[self.模型]  then
		self.染色方案 = 染色信息[self.模型].id
		self.染色组 = 染色信息[self.模型].方案
	end
	self:置模型()
end





function 场景类_假人:置模型()
		   	self.假人.静立 = nil
		   	self.假人.行走 = nil
		   	self.假人["武器_静立"] = nil
		   	self.假人["武器_行走"] = nil
		   	local m
		   	if not self.锦衣 and self.武器子类 then
		   		m = tp:取武器子类(self.武器子类)
			end
			local 资源 = 引擎.取模型(self.模型,m)
			local  显示武器 = true
			if self.锦衣 and self.锦衣~=0 and not 屏蔽锦衣效果 then
				if self.锦衣=="青春" or self.锦衣=="素颜" or self.锦衣=="绝色" or self.锦衣=="春秋" or  self.锦衣=="夏蚕"
					or self.锦衣=="星河" or self.锦衣=="白峨" or self.锦衣=="糖果" or self.锦衣=="青涩" or self.锦衣=="傲然"
					or self.锦衣=="牛仔" or  self.锦衣=="试剑" or self.锦衣=="骨龙战骑" or self.锦衣=="水嘟嘟·钻白" or self.锦衣=="斗战神"
					or  self.锦衣=="斗战胜佛" or  self.锦衣=="八部天龙马·玄" or self.锦衣=="龙凰·桃" or  self.锦衣=="龙凰·皑" then
					资源 =引擎.取战斗锦衣素材(self.锦衣,self.模型)
					self.假人.静立 = tp.资源:载入(资源[5],"网易WDF动画",资源[3])
					self.假人.行走 = tp.资源:载入(资源[5],"网易WDF动画",资源[4])
					显示武器 = false
				elseif 新加战斗锦衣[self.锦衣]~=nil then
						local 模型类型 = 取角色锦衣武器类型(self.模型,m)
		                资源 = 引擎.取武器锦衣素材(self.锦衣,self.模型,模型类型)
		                self.假人.静立 =tp.资源:载入(资源[5],"网易WDF动画",资源[3])
						self.假人.行走 =tp.资源:载入(资源[5],"网易WDF动画",资源[4])
						显示武器 = true
				end
			else
				self.假人.静立 = tp.资源:载入(资源[3],"网易假人动画",资源[1])
				self.假人.行走 = tp.资源:载入(资源[3],"网易假人动画",资源[1])
				if 资源[2] then
					self.假人.行走 = tp.资源:载入(资源[3],"网易假人动画",资源[2])
				end
			end

			if self.武器 and 显示武器 then
		   		local 物品 = 引擎.取物品(self.武器)
		   		if 物品 and 物品[11] then
		   			self.武器 = tp:取武器附加名称(物品[4],物品[5],self.武器)
		   		end
				local n = 引擎.取模型(self.武器.."_"..self.模型)
				if n and n[3] and n[1] and not 是否战斗锦衣 then
					self.假人["武器_静立"] = tp.资源:载入(n[3],"网易假人动画",n[1])
					self.假人["武器_行走"] = tp.资源:载入(n[3],"网易假人动画",n[2])
					if not self.锦衣 or self.锦衣==0 then
						self.假人["武器_静立"]:置差异(self.假人["武器_静立"].帧数-self.假人["静立"].帧数)
					end
					if self.武器染色方案 and self.武器染色方案~=0  and self.武器染色组 and self.武器染色组~=0 and #self.武器染色组>0 then
					    self.假人["武器_静立"]:置染色(self.武器染色方案,self.武器染色组[1],self.武器染色组[2],self.武器染色组[3])
					    self.假人["武器_行走"]:置染色(self.武器染色方案,self.武器染色组[1],self.武器染色组[2],self.武器染色组[3])
					end
				end
			elseif 引擎.取模型("武器_"..self.模型)[1] then
					local n = 引擎.取模型("武器_"..self.模型)
					if n and n[3] and n[1] then
						self.假人["武器_静立"] = tp.资源:载入(n[3],"网易假人动画",n[1])
						self.假人["武器_行走"] = tp.资源:载入(n[3],"网易假人动画",n[2])
						if not self.锦衣 or self.锦衣==0 then
							self.假人["武器_静立"]:置差异(self.假人["武器_静立"].帧数-self.假人["静立"].帧数)
						end
					end


			end


			self.方向开关 = self.假人.静立.方向数 == 8
			if (not self.锦衣 or self.锦衣==0) and self.染色方案 and self.染色方案~=0 and self.染色组 and type(self.染色组)=="table" then
				self:置染色(self.染色方案,self.染色组[1],self.染色组[2],self.染色组[3])
			end


			self:更新称谓()
			self:置方向(self.方向)

end

function 场景类_假人:更新称谓(称谓)
		 self.称谓动画 = nil
		 if 称谓 and self.称谓~=称谓 then
		 	self.称谓 = 称谓
		 end
		 self.名称偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.名称) / 2,-15)
		 if self.称谓 and self.称谓~="" and self.称谓 ~= "无称谓" then
		 	self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2,-15)
		 	self.名称偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.名称) / 2,-40)
		 	if self.称谓 == "武神坛冠军" then
				self.称谓动画=tp.资源:载入('登陆资源.wdf',"网易假人动画",0xAABBCC1A)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2-30,-10)
			elseif self.称谓 == "武神坛亚军" then
				self.称谓动画=tp.资源:载入('登陆资源.wdf',"网易假人动画", 0xAABBCC1C)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2-30,-10)
			elseif self.称谓 == "武神坛季军" then
				self.称谓动画=tp.资源:载入('登陆资源.wdf',"网易假人动画",0xAABBCC1B)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2-30,-10)
			elseif self.称谓 == "英雄大会冠军" then
				self.称谓动画=tp.资源:载入('窗口文字.wdf',"网易假人动画",0x5DA1F100)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2-50,-10)
			elseif self.称谓 == "英雄大会亚军" then
				self.称谓动画=tp.资源:载入('窗口文字.wdf',"网易假人动画",0x5DA1F101)
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2-50,-10)
			elseif self.称谓=="镇妖塔10层" then
				self.称谓动画=tp.资源:载入('称谓.npk',"网易假人动画","镇妖塔10层")
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+25,1)
			elseif self.称谓=="镇妖塔20层" then
				self.称谓动画=tp.资源:载入('称谓.npk',"网易假人动画","镇妖塔20层")
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+15,1)
			elseif self.称谓=="镇妖塔30层" then
				self.称谓动画=tp.资源:载入('称谓.npk',"网易假人动画","镇妖塔30层")
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+25,1)
			elseif self.称谓=="镇妖塔40层" then
				self.称谓动画=tp.资源:载入('称谓.npk',"网易假人动画","镇妖塔40层")
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+20,1)
			elseif self.称谓=="镇妖塔50层" then
				self.称谓动画=tp.资源:载入('称谓.npk',"网易假人动画","镇妖塔50层")
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+22,1)
			elseif self.称谓=="镇妖塔60层" then
				self.称谓动画=tp.资源:载入('称谓.npk',"网易假人动画","镇妖塔60层")
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+25,-1)
			elseif self.称谓=="镇妖塔70层" then
				self.称谓动画=tp.资源:载入('称谓.npk',"网易假人动画","镇妖塔70层")
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+30,2)
			elseif self.称谓=="镇妖塔80层" then
				self.称谓动画 = tp.资源:载入('称谓.npk',"网易假人动画","镇妖塔80层")
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+25,1)
			elseif self.称谓 == "镇妖塔90层" then
				self.称谓动画 = tp.资源:载入('称谓.npk',"网易假人动画","镇妖塔90层")
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+28,1)
			elseif self.称谓 == "镇妖塔100层" then
				self.称谓动画=tp.资源:载入('称谓.npk',"网易假人动画","镇妖塔100层")
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+28,1)
	        elseif self.称谓 == "初露锋芒" then
				self.称谓动画=tp.资源:载入('vip称号.gpk',"网易假人动画","初露锋芒")
				self.称谓偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.称谓) / 2+28,1)
			else
				self.名称偏移 = 生成XY(tp.字体表.人物字体_:取宽度(self.名称) / 2,-35)
			end

		 end
end


function 场景类_假人:下一点(xy)
	if xy then
		if #self.目标格子 > 1 then
			local 位置 = #self.目标格子
			local 最后 = self.目标格子[位置]
			for n=1,#self.目标格子 do
				if tp.场景.地图.寻路:判断直线障碍(xy,self.目标格子[n]) then
					位置 = n
					break
				end
			end
			for i=1,位置 do
				table.remove(self.目标格子, 1)
			end
			if #self.目标格子 == 0 then
				self.目标格子 = 最后
			end
		end
	end
end

function 场景类_假人:设置路径(x,y)
 local 路径={x=math.floor(x/20),y=math.floor(y/20)}
 local 格子={x=math.floor(self.坐标.x/20),y=math.floor(self.坐标.y/20)}-- {x=self.格子x,y=self.格子y}
 self.目标格子 = tp.场景.地图.寻路:寻路(格子,路径)
 self.延时 = 10
 self.移动 = true
 self:取目标()
 end

function 场景类_假人:设置路径1(x,y)


 self.坐标.x=x*20
 self.坐标.y=y*20
 self.格子x=x
 self.格子y=y
 self.目标格子={}

 end

function 场景类_假人:取目标()
	if self.目标格子[1] == nil then
		return
	end
	self.终点 =  生成XY(math.floor(self.目标格子[1].x*20),math.floor(self.目标格子[1].y*20))
end

function 场景类_假人:开始移动()
	if self.目标格子[1] == nil then
		self:停止移动()
		return
	end
	self.行为 = "行走"
	local 方向 = 取八方向(取两点角度(self.坐标,self.终点),not self.方向开关)
	if 取两点距离(self.坐标,self.终点) < 2 then -- 小于可移动点直接到达位置
		self.坐标 = self.终点
		table.remove(self.目标格子, 1)
		self:下一点(self.目标格子[1])
		if #self.目标格子 <= 0 then
			self:停止移动()
		end
		self:取目标()
		return false
	end
	self.坐标 = 取移动坐标(self.坐标,self.终点,2)
	self:置方向(方向)
end

function 场景类_假人:停止移动()
	self.目标格子 = {}
	self.行为 = "静立"
	self.移动 = false

end

function 场景类_假人:事件开始()
	 if tp.当前地图 > 100000 then
	 	if self.名称 == "管家" then
	 		tp.窗口.对话栏:文本("男人_店小二","管家","主人，有什么可以为你效劳的。",{"使用厨房","使用丹房","使用卧室","我还要逛逛"})
	 	elseif self.名称 == "佣人" then
	 		   tp.窗口.对话栏:文本("女人_丫鬟","佣人","主人，有什么可以为你效劳的。",{"侍奉睡觉","打开仓库","养儿育女","我还要逛逛"})
	 	elseif self.名称 == "牧场看守" then
	 		   tp.窗口.对话栏:文本("男人_兰虎","牧场看守","主人，有什么可以为你效劳的。",{"打开牧场界面","我还要逛逛"})
	 	elseif self.名称 == "牧场管理员" then
	 		   tp.窗口.对话栏:文本("男人_兰虎","牧场管理员","主人，有什么可以为你效劳的。",{"进入牧场","我还要逛逛"})
	 	end
	 else
	    客户端:请求服务(1501,{地图=tp.当前地图,编号=self.编号,标识=self.标识},1)
	 end

end

function 场景类_假人:更新(dt,x,y)
	if self.是否显示 then
		self.假人[self.行为]:更新(dt)
		if self.假人["武器_"..self.行为] then
			self.假人["武器_"..self.行为]:更新(dt)
		end
		if self.假人[self.行为]:是否选中(x,y) and tp:可操作() and not tp.第一窗口移动中 then
			tp.选中假人 = true
			if 引擎.鼠标弹起(0) and 取两点距离(tp.角色坐标,self.坐标) < 250  and not self.特效 and (self.执行事件 or self.事件=="单位") then
				self:事件开始()
			end
			if tp.窗口.对话栏.可视 then
				self:事件方向(tp.角色坐标,self.坐标)
			end
		end
		if self.事件 == "明雷" and 取两点距离(tp.角色坐标,self.坐标) < 25 and os.time()-self.触碰延时>=1 then
			self.触碰延时=os.time()
			客户端:请求服务(1004,{地图=tp.当前地图,编号=self.编号,标识=self.标识},1)
		end
	end
end

function 场景类_假人:显示(dt,x,y,pys)
	if 取两点距离(tp.角色坐标,self.坐标) < 800  then
		self:更新(dt,x,y,pys)
		if self.行走时间 ~= nil then
			self.行走时间 = self.行走时间 - 1
			if self.行走时间 <= 0 then
				local 临时目标 = 生成XY(math.floor(self.坐标.x / 20)+ math.random(-6,6),math.floor(self.坐标.y / 20)+math.random(-6,6))
				if 临时目标 ~= nil and self.目标格子[1] == nil then
					local a = 生成XY(math.floor(self.坐标.x / 20),math.floor(self.坐标.y / 20))
					self.目标格子 = tp.场景.地图.寻路:寻路(a,临时目标)
					self:取目标()
					self.移动 = true
				end
				self.行走时间 = 250+math.random(-20,10)
			end
		end
		if tp.窗口.对话栏.可视 == false and self.方向 ~= self.记忆方向 and (self.执行事件 ~= "明雷" and not self.行走开关) then
			self:置方向(self.记忆方向)
		end
		local 显示xy = 生成XY(math.floor(self.坐标.x + pys.x),math.floor(self.坐标.y +  pys.y))


		tp.影子:显示(显示xy)

		self.假人[self.行为]:显示(显示xy)

		if self.名称 == "商人的鬼魂" or self.名称 == "白鹿精"
		or self.名称 == "酒肉和尚" or self.名称 == "执法天兵"
		or self.名称 == "白琉璃"or self.名称 == "幽冥鬼"
		or self.名称 == "刘洪"  then
			tp.战斗图标:显示(显示xy.x-5,显示xy.y-100)
			elseif self.名称 == "新手接待师" then
			tp.任务图标:显示(显示xy.显示xy.y-120)
			elseif self.名称 == "野猪" or self.名称 == "蟹将军" then
			tp.战斗图标:显示(显示xy.x-5,显示xy.y-50)
			elseif self.名称 == "杜少海" or self.名称 == "皇宫护卫" or self.名称 == "钟馗"  or self.名称 == "赵捕头" then
			tp.任务图标:显示(显示xy.x-5,显示xy.y-80)
		end
		if self.假人["武器_"..self.行为] ~= nil and not 飞行特效 then
			self.假人["武器_"..self.行为]:显示(显示xy)
		end


		--local 名称颜色 =0xFFF0F000-- -171588352
		local 名称颜色 = -171588352

		if self.假人[self.行为]:是否选中(x,y) and tp:可操作() and not tp.第一窗口移动中 then
			self.假人[self.行为]:置高亮()
			if self.假人["武器_"..self.行为] ~= nil then
				self.假人["武器_"..self.行为]:置高亮()
			end
			名称颜色 = -419495936
			--称谓颜色 = -419495936

		else
			self.假人[self.行为]:取消高亮()
			if self.假人["武器_"..self.行为] ~= nil then
				self.假人["武器_"..self.行为]:取消高亮()
			end
			名称颜色 = -171588352
			--称谓颜色 = 0xFF2D96FF
		end
		if self.称谓 and self.称谓~="" then
			local 称谓颜色 = -931286529
			if self.称谓=="红名村村长" then
			    称谓颜色 = 4278255615
			end
			if self.称谓动画 then
				self.称谓动画:更新()
				self.称谓动画:显示(显示xy.x-self.称谓偏移.显示xy.y-self.称谓偏移.y)
			else
				tp.字体表.人物字体_:置颜色(称谓颜色)
				tp.字体表.人物字体_:显示x(显示xy - self.称谓偏移,self.称谓)
			end
		end
		tp.字体表.人物字体_:置阴影颜色(-1275068416)
		tp.字体表.人物字体_:置颜色(名称颜色)
		tp.字体表.人物字体_:显示x(显示xy - self.名称偏移,self.名称)
		if self.移动 then
			self:开始移动(dt)
		end
		if self.特效 then
			self.特效:更新(dt*self.帧率)
			if (self.特效.当前帧 >= self.特效.结束帧) then
				self.特效 = nil
				return false
			end
			self.特效:显示(显示xy)
		end
		-- self.坐标.x = s.x
		-- self.坐标.y = s.y
		self.是否显示 = true
	else
	    self.是否显示 = false
	end
	-- self.喊话:显示(s.x + pys.x,s.y + pys.y,dt,x,y)
end

function 场景类_假人:置方向(d)
	if self.假人["静立"].方向数 < 4 then
		return false
	end
	if self.假人["行走"] ~= nil then
		self.假人["行走"]:置方向(d)
	end
	self.假人["静立"]:置方向(d)
	if self.假人["武器_静立"] ~= nil then
		self.假人["武器_静立"]:置方向(d)
		self.假人["武器_行走"]:置方向(d)
	end
	self.方向 = d
end

function 场景类_假人:置武器(假人,饰品)
	if 饰品 == nil then
		local 资源 = 引擎.取模型(假人.模型,tp:取武器子类(假人.武器子类))
		self.假人["静立"] = nil
		self.假人["行走"] = nil
		self.假人["静立"] = tp.资源:载入(资源[3],"网易假人动画",资源[1])
		self.假人["行走"] = tp.资源:载入(资源[3],"网易假人动画",资源[2])
		if 假人.锦衣~=nil and 假人.锦衣~=0 and 新加战斗锦衣[假人.锦衣]~=nil then
		    local 模型类型 = 取角色锦衣武器类型(假人.模型,tp:取武器子类(假人.武器子类))
			资源 = 引擎.取武器锦衣素材(假人.锦衣,假人.模型,模型类型)
			self.假人 = {["静立"] = tp.资源:载入(资源[5],"网易假人动画",资源[3]),["行走"] = tp.资源:载入(资源[3],"网易假人动画",资源[4])}
		end
	end
	local n
	if 饰品 then
		n = 引擎.取模型("武器_"..假人.模型)
	else
		if 假人.武器~= nil then
			local 物品 = 引擎.取物品(假人.武器)
			local m
			if 物品 ~= nil and 物品[11] ~= nil then
			 	m = tp:取武器附加名称(物品[4],物品[5],假人.武器)
			 	n = 引擎.取模型(m.."_"..假人.模型)
			end
		end
	end
	if n~=nil and n[3]~=nil then
		self.假人["武器_静立"] = tp.资源:载入(n[3],"网易假人动画",n[1])
		self.假人["武器_行走"] = tp.资源:载入(n[3],"网易假人动画",n[2])
		if 假人.锦衣~=nil and 假人.锦衣~=0 then
		else
			self.假人["武器_静立"]:置差异(self.假人["武器_静立"].帧数-self.假人["静立"].帧数)
		end
	end
	if not 饰品 and self.武器染色方案 and  self.武器染色方案~=0  and self.武器染色组~=nil and self.武器染色组~=0  and #self.武器染色组>0 then
	    self.假人["武器_静立"]:置染色(self.武器染色方案,self.武器染色组[1],self.武器染色组[2],self.武器染色组[3])
	    self.假人["武器_行走"]:置染色(self.武器染色方案,self.武器染色组[1],self.武器染色组[2],self.武器染色组[3])
	end
	if self.假人["行走"] ~= nil and self.假人["武器_行走"]~=nil then
		if 假人.锦衣~=nil and 假人.锦衣~=0 then
		else
			self.假人["武器_行走"]:置差异(self.假人["武器_行走"].帧数-self.假人["行走"].帧数)
		end
	end
	self:置方向(self.方向)
end

function 场景类_假人:置染色(染色方案,a,b,c)
	self.假人["静立"]:置染色(染色方案,a,b,c)
	if  self.假人["行走"] ~= nil then
		 self.假人["行走"]:置染色(染色方案,a,b,c)
	end
	self:置方向(self.方向)
end

function 场景类_假人:事件方向(a,b)
	if 取两点角度(b,a) ~= nil and 取八方向(math.floor(取两点角度(b,a))) ~= nil then
		if self.方向开关 then
			self:置方向(取八方向(math.floor(取两点角度(b,a))))
			tp.场景.人物:置方向(取八方向(math.floor(取两点角度(a,b))))
		else
			self:置方向(取四方向(math.floor(取两点角度(b,a))))
			tp.场景.人物:置方向(取八方向(math.floor(取两点角度(a,b))))
		end
	end
end



function 场景类_假人:卸载()
	self.假人["静立"] = nil
	self.假人["行走"] = nil
	self.假人["武器_静立"] = nil
	self.假人["武器_行走"] = nil
	self.假人 = nil
	self.名称 = nil
	self.标识=nil
	self.坐标 = nil
	self.编号 = nil
	self.行为 = nil
	self.类型 = nil
	self.方向 = nil
	self.记忆方向 = nil
	self.执行事件 = nil
	self.武器 = nil
	self.模型 = nil
	self.染色组 = nil
	self.锦衣 = nil
	self.地图颜色 = nil
	self.行走开关 = nil
	self.触碰延时=nil
	self.名称偏移 = nil
	self.称谓动画 = nil
	self.称谓 = nil
	self.称谓偏移 = nil
	self.目标格子 = nil
	self.任务开关 = nil
	self.方向开关 = nil
	self.移动 = nil
	self.行走时间 = nil
	self.武器染色方案=nil
	self.武器染色组=nil
    self.染色方案 = nil
	self.染色组 = nil


end





return 场景类_假人