
local 超级赐福 = class()
local tp,zts1
local insert = table.insert
local bw = require("gge包围盒")(0,0,140,34)
local box = 引擎.画矩形
function 超级赐福:初始化(根)
		self.ID = 149
		self.x = 150
		self.y = 80
		self.xx = 0
		self.yy = 0
		self.注释 = "超级赐福"
		self.可视 = false
		self.鼠标 = false
		self.焦点 = false
		self.可移动 = true
		local 按钮 = 根._按钮
		local 自适应 = 根._自适应
		local 资源 = 根.资源
		self.资源组 = {
			[1] = 自适应.创建(0,1,505,455,3,9),
	        [2] = 自适应.创建(2,1,220,200,3,9),
	        [3] = 自适应.创建(2,1,255,200,3,9),
			[4] = 自适应.创建(3,1,220,18,1,3),--背景框
			[5] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭
			[6] = 自适应.创建(1,1,501,18,1,3,nil,18),--标题背景
			[7]=  资源:载入('迭代.wdf',"网易WDF动画",0x00000019),
			[8] = 自适应.创建(2,1,220,200,3,9),
			}
	    self.锁定按钮= {
			[1] = 按钮.创建(自适应.创建(12,4,42,20,1,1),0,0,4,true,true,"锁定"),
	        [2] = 按钮.创建(自适应.创建(12,4,42,20,1,1),0,0,4,true,true,"锁定"),
	        [3] = 按钮.创建(自适应.创建(12,4,42,20,1,1),0,0,4,true,true,"锁定"),
			[4] = 按钮.创建(自适应.创建(12,4,42,20,1,1),0,0,4,true,true,"锁定"),

			}
		self.宝宝滑块 =  根._滑块.创建(自适应.创建(11,4,7,40,2,3,nil),4,14,195,2)
	    self.赐福按钮=按钮.创建(自适应.创建(12,4,80,20,1,1),0,0,4,true,true," 赐  福")
	    self.保存按钮=按钮.创建(自适应.创建(12,4,80,20,1,1),0,0,4,true,true," 保存技能")
	    self.技能背景=资源:载入('迭代.wdf',"网易WDF动画",0x00000020)
	    self.技能选中=资源:载入('迭代.wdf',"网易WDF动画",0x00000070)
	    self.技能列表=资源:载入(wdf配置.."/pic/技能列表.png","图片")
	    self.赐福勾选=资源:载入(wdf配置.."/pic/赐福勾选.png","图片")
	    self.头像格子= 资源:载入('登陆资源.wdf',"网易WDF动画",0x363AAF1B)

	    self.保存资源组 ={
	    			[1] = 自适应.创建(0,1,255,280,3,9),
	    			[2] = 自适应.创建(1,1,251,18,1,3,nil,18),--标题背景
	    			[3] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭
	    			[5] = 按钮.创建(自适应.创建(12,4,42,20,1,1),0,0,4,true,true,"确定"),
	        		[6] = 按钮.创建(自适应.创建(12,4,42,20,1,1),0,0,4,true,true,"取消"),
	        		[7] = 自适应.创建(2,1,230,180,3,9),


	}

	 self.技能资源组 ={
	    			[1] = 自适应.创建(0,1,255,240,3,9),
	    			[2] = 自适应.创建(1,1,251,18,1,3,nil,18),--标题背景
	    			[3] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭
	        		[4] = 自适应.创建(2,1,230,180,3,9),
			}




 		local 丸子资源=引擎.取物品("仙露丸子")
	    self.丸子动画= 资源:载入(丸子资源[11],"网易WDF动画",丸子资源[12])


		for n=1,4 do
			self.锁定按钮[n]:绑定窗口_(149)
		end
		self.资源组[5]:绑定窗口_(149)
	    self.赐福按钮:绑定窗口_(149)
		self.物品 = {}
		local 格子 = require("script/显示类/物品_格子")
		for i=1,100 do
			self.物品[i] = 格子(0,0,i,"战斗道具_物品")
		end
		self.赐福技能={}
		local jn = 根._技能格子
  		for i=1,4 do
  		    self.赐福技能[i] = jn(0,0,i,"奇经八脉技能")
  		end
  		self.原有赐福={}
		local jn = 根._技能格子
  		for i=1,4 do
  		    self.原有赐福[i] = jn(0,0,i,"奇经八脉技能")
  		end

  		self.显示技能={}
		local jn = 根._技能格子
  		for i=1,12 do
  		    self.显示技能[i] = jn(0,0,i,"奇经八脉技能")
  		end
  		self.高级技能={高级毒=true,高级夜战=true,高级反震=true,高级吸血=true,高级连击=true,高级飞行=true,高级隐身=true,
                         高级感知=true,高级再生=true,高级冥思=true,高级驱鬼=true,高级慧根=true,高级必杀=true,高级幸运=true,
                          高级神迹=true,高级招架=true,高级永恒=true,高级敏捷=true,高级偷袭=true,高级强力=true,高级防御=true,
                         高级盾气=true,高级合纵=true,高级魔之心=true,奔雷咒=true,泰山压顶=true,水漫金山=true,高级驱怪=true,
                         地狱烈火=true,高级进击必杀=true,高级进击法暴=true,高级法术连击=true,高级法术暴击=true,
                         高级法术波动=true,壁垒击破=true,高级法术抵抗=true,高级精神集中=true,高级否定信仰=true,
                         高级雷属性吸收=true,高级土属性吸收=true,高级水属性吸收=true,高级火属性吸收=true}





		self.窗口时间 = 0
		tp = 根
		zts1 = tp.字体表.描边字体
		self.字体 = tp.字体表.普通字体
		self.宝石字体= tp.字体表.描边字体__
		self.宝石字体:置颜色(0xFFFFFFFF)
		self.宝石字体:置描边颜色(0xfff741940)--xFFaf140c)
end

function 超级赐福:打开()
		if self.可视 then
			   self.开始=1
			   self.结束=4
			   self.宠物模型 = nil
			   self.宠物饰品 = nil
			   self.宠物饰品2 = nil
			   self.选中=nil
			   self.头像组 = {}
			   self.窗口时间 = 0
			   self.可视 = false
			   self.宝宝滑块:置起始点(0)
			   return

		else
				self.携带数量= tp.队伍[1].携带宠物
				self.选中=nil
				self.开始=1
				self.结束=4
				self.宠物模型 = nil
			  	self.宠物饰品 = nil
			  	self.宠物饰品2 = nil
			  	for i=1,4 do
			  		self.赐福技能[i]:置技能(nil)
			  		self.原有赐福[i]:置技能(nil)
			  		self.锁定按钮[i].按钮文字="锁定"
			 	end
		  		for i=1,12 do
		  		    self.显示技能[i]:置技能(nil)
		  		end
			 	self.赐福按钮.按钮文字=" 赐  福"
			 	self.保存效果=false
			 	self.技能显示=false
			 	self.需求数量=1


				self:刷新()
				insert(tp.窗口_,self)
				tp.运行时间 = tp.运行时间 + 1
			    self.窗口时间 = tp.运行时间
			    self.可视 = true
		end
end


function 超级赐福:刷新()
	self.头像组 = {}
	for i=1,#tp.队伍[1].宝宝列表 do
		self.头像组[i]={}
		local  临时资源=引擎.取头像(tp.队伍[1].宝宝列表[i].模型)
		self.头像组[i].头像 = tp.资源:载入(临时资源[7],"网易WDF动画",临时资源[1])
		self.头像组[i].名称=tp.队伍[1].宝宝列表[i].名称
		self.头像组[i].等级=tp.队伍[1].宝宝列表[i].等级
	end
	self.物品数量=0
	for n=1,100 do
		self.物品[n]:置物品(tp.道具列表[n])
		if tp.道具列表[n]~=nil and tp.道具列表[n].名称=="仙露丸子" then
			self.物品数量=self.物品数量+tp.道具列表[n].数量
		end
	end

	if self.选中~=nil  and self.选中~=0 and tp.队伍[1].宝宝列表[self.选中] then
		self:置形象()
	end

end








function 超级赐福:置形象()
	  self.宠物模型 = nil
	  self.宠物饰品 = nil
	  self.宠物饰品2 = nil
	  self.保存效果=false
	  self.技能显示=false
	  self.赐福按钮.按钮文字=" 赐  福"
	  if tp.队伍[1].宝宝列表[self.选中]  ~= nil then
		 local n = 引擎.取战斗模型(tp.队伍[1].宝宝列表[self.选中].模型)
		  self.宠物模型 = tp.资源:载入(n[10],"网易WDF动画",n[6])
		  self.宠物模型:置方向(0)
		  if 引擎.取战斗模型(tp.队伍[1].宝宝列表[self.选中].模型.."_饰品") ~= nil and #引擎.取战斗模型(tp.队伍[1].宝宝列表[self.选中].模型.."_饰品")~=0 then
				if tp.队伍[1].宝宝列表[self.选中].饰品~=nil then
					  n = 引擎.取战斗模型(tp.队伍[1].宝宝列表[self.选中].模型.."_饰品")
					  self.宠物饰品 = tp.资源:载入(n[10],"网易WDF动画",n[6])
					  self.宠物饰品:置方向(0)
				else
					  n = 引擎.取战斗模型(tp.队伍[1].宝宝列表[self.选中].模型)
					  self.宠物模型 = tp.资源:载入(n[10],"网易WDF动画",n[6])
					  self.宠物模型:置方向(0)
				 end
		   end
		   if tp.队伍[1].宝宝列表[self.选中].饰品2 ~= nil then
					n = 引擎.取战斗模型(tp.队伍[1].宝宝列表[self.选中].模型.."_饰品2")
					self.宠物饰品2 = tp.资源:载入(n[10],"网易WDF动画",n[6])
					self.宠物饰品2:置方向(0)
		    end
			if tp.队伍[1].宝宝列表[self.选中].染色方案 ~= nil and tp.队伍[1].宝宝列表[self.选中].染色组~=nil then
					self.宠物模型:置染色(tp.队伍[1].宝宝列表[self.选中].染色方案,tp.队伍[1].宝宝列表[self.选中].染色组[1],tp.队伍[1].宝宝列表[self.选中].染色组[2],tp.队伍[1].宝宝列表[self.选中].染色组[3])
					self.宠物模型:置方向(0)
			end
			if tp.队伍[1].宝宝列表[self.选中].饰品染色方案 ~= nil and tp.队伍[1].宝宝列表[self.选中].饰品染色组~=nil and tp.队伍[1].宝宝列表[self.选中].饰品 ~= nil then
					self.宠物饰品:置染色(tp.队伍[1].宝宝列表[self.选中].饰品染色方案,tp.队伍[1].宝宝列表[self.选中].饰品染色组[1],tp.队伍[1].宝宝列表[self.选中].饰品染色组[2],tp.队伍[1].宝宝列表[self.选中].饰品染色组[3])
					self.宠物模型:置方向(0)
			end
			for i=1,4 do
				self.赐福技能[i]:置技能(nil)
				self.原有赐福[i]:置技能(nil)
			    self.锁定按钮[i].按钮文字="锁定"
			end
		  	local 临时列表={}
		  	for n=1,#tp.队伍[1].宝宝列表[self.选中].技能 do
		  		if self.高级技能[tp.队伍[1].宝宝列表[self.选中].技能[n]] then
		  			临时列表[#临时列表+1]=tp.队伍[1].宝宝列表[self.选中].技能[n]
		  		end
		  	end
		  	for i=1,12 do
		  		if 临时列表[i]~=nil then
			  		local 临时技能=tp._技能()
					临时技能:置对象(临时列表[i])
					self.显示技能[i]:置技能(临时技能,true)
				else
					self.显示技能[i]:置技能(nil)
		  		end
		  	end
			local 锁定数量=0
			if tp.队伍[1].宝宝列表[self.选中].临时赐福~=nil then
					local 已有技能={}
					for i=1,4 do
						local 临时技能=tp._技能()
						临时技能:置对象(tp.队伍[1].宝宝列表[self.选中].临时赐福[i])
						self.赐福技能[i]:置技能(临时技能,true)
						for n=1,#tp.队伍[1].宝宝列表[self.选中].技能 do
							if self.赐福技能[i].技能~=nil and self.赐福技能[i].技能.名称~=nil and self.赐福技能[i].技能.名称==tp.队伍[1].宝宝列表[self.选中].技能[n] then
							    已有技能[tp.队伍[1].宝宝列表[self.选中].技能[n]]=true
							end
						end
						if tp.队伍[1].宝宝列表[self.选中].赐福锁定~=nil  and  tp.队伍[1].宝宝列表[self.选中].赐福锁定[i] then
							锁定数量=锁定数量+1
							self.锁定按钮[i].按钮文字="解锁"
						else
						    self.锁定按钮[i].按钮文字="锁定"
						end
					end

					for i=1,4 do
					    if self.赐福技能[i].技能~=nil and self.赐福技能[i].技能.名称~=nil and not 已有技能[self.赐福技能[i].技能.名称] then
					        	self.赐福技能[i].技能.模型:灰度级()
					    end
					end
					self.赐福按钮.按钮文字=" 再次赐福"
			end
			if tp.队伍[1].宝宝列表[self.选中].超级赐福~=nil then
					local 已有技能={}
					for i=1,4 do
						local 临时技能=tp._技能()
						临时技能:置对象(tp.队伍[1].宝宝列表[self.选中].超级赐福[i])
						self.原有赐福[i]:置技能(临时技能,true)
						for n=1,#tp.队伍[1].宝宝列表[self.选中].技能 do
							if self.原有赐福[i].技能~=nil and self.原有赐福[i].技能.名称~=nil and self.原有赐福[i].技能.名称==tp.队伍[1].宝宝列表[self.选中].技能[n] then
							    已有技能[tp.队伍[1].宝宝列表[self.选中].技能[n]]=true
							end
						end
					end
					for i=1,4 do
					    if self.原有赐福[i].技能~=nil and self.原有赐福[i].技能.名称~=nil  and not 已有技能[self.原有赐福[i].技能.名称]  then
					       self.原有赐福[i].技能.模型:灰度级()
					    end
					end
			end
			if 锁定数量==1 then
				self.需求数量=5
			elseif 锁定数量>=2 then
			    self.需求数量=25
			else
			    self.需求数量=1
			end





	end
end


function 超级赐福:显示(dt,x,y)
		self.焦点=false
		self.资源组[1]:显示(self.x,self.y)
		self.资源组[2]:显示(self.x+10,self.y+30)
		self.资源组[3]:显示(self.x+240,self.y+30)

		self.资源组[6]:显示(self.x+2,self.y+2)
	    self.资源组[7]:显示(self.x+240,self.y+240)
	    self.资源组[8]:显示(self.x+10,self.y+240)
	    self.资源组[5]:更新(x,y)
		self.资源组[5]:显示(self.x+485,self.y+2)

		tp.窗口标题背景_[2]:显示(self.x+self.资源组[1].宽度/2-45,self.y+2)
		zts1:置字间距(3)
		zts1:显示(self.x+self.资源组[1].宽度/2-15,self.y+2,"赐福")
		zts1:置字间距(0)

		self.技能背景:显示(self.x+335,self.y+145)
		self.丸子动画:显示(self.x+340,self.y+150)
        self.宝宝滑块:显示(self.x+220,self.y+250,x,y,self.鼠标)
        local 显示字体 = self.物品数量.."/"..self.需求数量
        local 显示坐标=math.floor(string.len(显示字体)*3)
        self.宝石字体:显示(self.x+360-显示坐标,self.y+180,显示字体)
		self.赐福按钮:更新(x,y,self.选中~=nil and self.选中~=0 and self.物品数量>=self.需求数量 and not self.赐福显示)
		self.保存按钮:更新(x,y)
		if self.赐福按钮.按钮文字==" 赐  福" then
	    	self.赐福按钮:显示(self.x+321,self.y+205)
		else
		   self.赐福按钮:显示(self.x+370,self.y+205)
		   self.保存按钮:显示(self.x+275,self.y+205)
		end








		if self.资源组[5]:事件判断() then
			self:打开()
		elseif self.赐福按钮:事件判断() and self.选中 and self.选中~=0 then
				for i=1,4 do
				    self.赐福技能[i]:置技能(nil)
					self.锁定按钮[i].按钮文字="锁定"
				end
				请求服务(5021,{类型="随机赐福",序列=tp.队伍[1].宝宝列表[self.选中].认证码})
        elseif self.保存按钮:事件判断() and self.选中 and self.选中~=0 then
	        	if self.选中==nil or self.选中==0 then
					tp.常规提示:打开("#Y/你还没有选择宝宝,请选择宝宝后在操作")
				else
		        	 local 是否发送=true
		        	 for i=1,4 do
		        	   	 if self.赐福技能[i]==nil or self.赐福技能[i].技能==nil or (self.赐福技能[i].技能~=nil and self.赐福技能[i].技能.名称==nil) then
		        	   	    是否发送=false
		        	   	 end
		        	 end
		        	 if 是否发送 then
		        	 	self.保存效果=true
		        	 	self.技能显示=false

					 else
					    tp.常规提示:打开("#Y/请重新赐福技能")
					 end
				end
		end

		if self.赐福显示~=nil then
			 self:赐福动画(dt,x,y)
		end



	    self.技能列表:显示(self.x+140,self.y+40)
	    if self.技能列表:是否选中(x,y) and 引擎.鼠标弹起(0)  then--鼠标上滚
	    	self.保存效果=false
		    self.技能显示=true
	    end


		for n=1,4 do
			self.技能背景:显示(self.x+250+(n-1)*60,self.y+45)
			self.技能选中:显示(self.x+250+(n-1)*60,self.y+45)
			self.锁定按钮[n]:更新(x,y,self.赐福技能~=nil and self.赐福技能[n]~=nil and self.赐福技能[n].技能 ~= nil)
			self.锁定按钮[n]:显示(self.x+254+(n-1)*60,self.y+105)
			if self.锁定按钮[n]:事件判断() then
				if self.选中==nil or self.选中==0 then
					tp.常规提示:打开("#Y/你还没有选择宝宝,请选择宝宝后在操作")
				elseif self.赐福技能[n].技能 == nil or  (self.赐福技能[n].技能~=nil and self.赐福技能[n].技能.名称==nil) then
					tp.常规提示:打开("#Y/请先赐福技能")
				else
					if self.锁定按钮[n].按钮文字=="锁定" then
						请求服务(5021,{类型="锁定技能",编号=n,序列=tp.队伍[1].宝宝列表[self.选中].认证码})
					else
						请求服务(5021,{类型="解锁技能",编号=n,序列=tp.队伍[1].宝宝列表[self.选中].认证码})
					end

				end
			end

			if  self.赐福技能[n]~=nil then
				self.赐福技能[n]:置坐标(self.x+256+(n-1)*60,self.y+52)
				self.赐福技能[n]:显示(x,y,self.鼠标)
				if self.选中~=nil and self.选中~=0 and tp.队伍[1].宝宝列表[self.选中].赐福锁定~=nil and tp.队伍[1].宝宝列表[self.选中].赐福锁定[n] and not self.赐福显示 then
				   tp.加锁图标:显示(self.x+270+(n-1)*60,self.y+82)
				end
		       	if self.赐福技能[n].技能 ~= nil and self.赐福技能[n].焦点 then
				  	tp.提示:超级技能(x,y,self.赐福技能[n].技能.名称)
			   	end
		    end
		end


		local  yy = 0
		for i=self.开始,self.结束 do
		     if self.头像组[i]~=nil and self.头像组[i].头像 then
                  self.头像格子:显示(self.x+25,self.y+255+yy*45)
		          self.头像组[i].头像:显示(self.x+28,self.y+258+yy*45)
		          local zx,zy = self.x+20,self.y+250+yy*45
		     	 if self.选中 == i then
		                box(zx-2,zy-2,zx+200,zy+45,1677721855)
		                self.赐福勾选:显示(self.x+45,self.y+275+yy*45)
		          end
				  self.字体:置颜色(-16777216):显示(self.x+70,self.y+255+yy*45,self.头像组[i].名称)
				  self.字体:置颜色(-16777216):显示(self.x+70,self.y+275+yy*45,self.头像组[i].等级.."级")
		          bw:置坐标(zx,zy)
		          if bw:检查点(x,y) then
		             if 引擎.鼠标弹起(0) then
		                self.选中=i
		                self:置形象()
		             end
		             box(zx-2,zy-2,zx+200,zy+45,1677721855)
		          end
		      	yy=yy+1
		     end
		end





		if self.资源组[8]:是否选中(x,y) and 引擎.取鼠标滚轮() ==1 and self.开始 > 1   then--鼠标上滚动
			    self.开始=self.开始-1
			    self.结束=self.开始+3
				self.宝宝滑块:置起始点(取百分比转换(self.开始-1,0,#self.头像组))
		elseif self.资源组[8]:是否选中(x,y) and 引擎.取鼠标滚轮() ==-1 and self.结束<#self.头像组 then--鼠标下滚动
			    self.开始=self.开始+1
			    self.结束=self.开始+3
				self.宝宝滑块:置起始点(取百分比转换(self.开始-1,0,#self.头像组))
		end


		local xxx = 0
		local yyy = 0
	    for n= 1, 20 do
		    self.物品[n]:置坐标(self.x+240+xxx*51,self.y+240+yyy*51)
			if self.物品[n].物品~=nil then
			    self.物品[n]:显示(dt,x,y,self.鼠标)
			    if self.物品[n].物品.名称~="仙露丸子"then
		         		tp.物品格子禁止_:显示(self.x+245+xxx*51,self.y+245+yyy*51)
		         end
			    if self.物品[n].焦点 and self.鼠标  and not tp.消息栏焦点 then
					 tp.提示:道具行囊(x,y,self.物品[n].物品)
				end
			end
				xxx = xxx + 1
				if xxx>=5 then
					xxx = 0
					yyy = yyy +1
			    end
		end







		if self.宠物模型 ~= nil then
			tp.影子:显示(self.x + 120,self.y +190)
   			self.宠物模型:更新(dt)
  			self.宠物模型:显示(self.x + 120,self.y +190)
		end
		if self.宠物饰品 ~= nil then

   			self.宠物饰品:更新(dt)
  			self.宠物饰品:显示(self.x + 120,self.y +190)
		end
		if self.宠物饰品2 ~= nil then

   			self.宠物饰品2:更新(dt)
  			self.宠物饰品2:显示(self.x + 120,self.y +190)
		end
	   if self.保存效果 then
	   		self:保存窗口(dt,x,y)
	   elseif self.技能显示 then
	   		self:技能窗口(dt,x,y)
	   end








end

function 超级赐福:刷新赐福(数据)
	self.物品数量=0
	for n=1,100 do
		self.物品[n]:置物品(tp.道具列表[n])
		if tp.道具列表[n]~=nil and tp.道具列表[n].名称=="仙露丸子" then
			self.物品数量=self.物品数量+tp.道具列表[n].数量
		end
	end
	if self.选中~=nil and self.选中~=0 then
		tp.队伍[1].宝宝列表[self.选中].临时赐福=数据
		local  是否显示 = true
		if tp.队伍[1].宝宝列表[self.选中].临时赐福==nil  then
		 	是否显示 = false
		else
		  for i=1,4 do
		    if tp.队伍[1].宝宝列表[self.选中].临时赐福[i]==nil then
		    	是否显示 = false
		    end
		  end
		end
		if 是否显示 then
			self.赐福显示=0

		else
		 	self.赐福显示=nil
		end
		if tp.队伍[1].宝宝列表[self.选中].超级赐福~=nil then
			local 已有技能={}
			for i=1,4 do
				local 临时技能=tp._技能()
				临时技能:置对象(tp.队伍[1].宝宝列表[self.选中].超级赐福[i])
				self.原有赐福[i]:置技能(临时技能,true)
				for n=1,#tp.队伍[1].宝宝列表[self.选中].技能 do
					if self.原有赐福[i].技能~=nil and self.原有赐福[i].技能.名称~=nil and self.原有赐福[i].技能.名称==tp.队伍[1].宝宝列表[self.选中].技能[n] then
						已有技能[tp.队伍[1].宝宝列表[self.选中].技能[n]]=true
					end
				end
			 end
			 for i=1,4 do
				if self.原有赐福[i].技能~=nil and self.原有赐福[i].技能.名称~=nil then
					if not 已有技能[self.原有赐福[i].技能.名称] then
					    self.原有赐福[i].技能.模型:灰度级()
					end
			    end
			 end
		end
	end

end


function 超级赐福:赐福动画(dt,x,y)
	if self.赐福显示~=nil then
		 -- self.赐福特效:更新(dt)
		 -- self.赐福特效:显示(self.x+321-80,self.y+30)
      	self.赐福显示=self.赐福显示+1
      	local 临时技能=tp._技能()
	    if self.赐福显示==30 then
		    临时技能:置对象(tp.队伍[1].宝宝列表[self.选中].临时赐福[1])
			self.赐福技能[1]:置技能(临时技能,true)
	    elseif self.赐福显示==60 then
		       临时技能:置对象(tp.队伍[1].宝宝列表[self.选中].临时赐福[2])
			   self.赐福技能[2]:置技能(临时技能,true)
		elseif self.赐福显示==90 then
	      		临时技能:置对象(tp.队伍[1].宝宝列表[self.选中].临时赐福[3])
				self.赐福技能[3]:置技能(临时技能,true)
		elseif self.赐福显示==120  then
	      	  	临时技能:置对象(tp.队伍[1].宝宝列表[self.选中].临时赐福[4])
				self.赐福技能[4]:置技能(临时技能,true)
		elseif self.赐福显示==150 then
		      local 已有技能={}
			  for i=1,4 do
				  for n=1,#tp.队伍[1].宝宝列表[self.选中].技能 do
					  if self.赐福技能[i].技能~=nil and self.赐福技能[i].技能.名称~=nil and self.赐福技能[i].技能.名称==tp.队伍[1].宝宝列表[self.选中].技能[n] then
						 已有技能[tp.队伍[1].宝宝列表[self.选中].技能[n]]=true
					  end
				  end
			  end
			  local 锁定数量=0
				for i=1,4 do
				    if self.赐福技能[i].技能~=nil and self.赐福技能[i].技能.名称~=nil and not 已有技能[self.赐福技能[i].技能.名称]  then
				        self.赐福技能[i].技能.模型:灰度级()
				    end
				    if tp.队伍[1].宝宝列表[self.选中].赐福锁定~=nil and tp.队伍[1].宝宝列表[self.选中].赐福锁定[i] then
				    	锁定数量=锁定数量+1
						self.锁定按钮[i].按钮文字="解锁"
					else
						 self.锁定按钮[i].按钮文字="锁定"
					end
				end
			 	if 锁定数量==1 then
					self.需求数量=5
				elseif 锁定数量>=2 then
				    self.需求数量=25
				else
				    self.需求数量=1
				end
		     self.赐福按钮.按钮文字=" 再次赐福"
			 self.赐福显示=nil
      	end
	end
end


function 超级赐福:保存窗口(dt,x,y)

	 self.保存资源组[1]:显示(self.x+130,self.y+80)
	 self.保存资源组[2]:显示(self.x+132,self.y+82)
	 self.保存资源组[3]:更新(x,y)
	 self.保存资源组[3]:显示(self.x+367,self.y+82)

	 self.保存资源组[5]:更新(x,y)
	 self.保存资源组[5]:显示(self.x+205,self.y+326)
	 self.保存资源组[6]:更新(x,y)
	 self.保存资源组[6]:显示(self.x+262,self.y+326)
	 self.保存资源组[7]:显示(self.x+143,self.y+130)

	 tp.窗口标题背景_[6]:显示(self.x+130+self.保存资源组[1].宽度/2-75,self.y+82)
	 zts1:置字间距(3)
	 zts1:显示(self.x+130+self.保存资源组[1].宽度/2-45,self.y+82,"保存赐福效果")
	 zts1:置字间距(0)
	 if self.保存资源组[3]:事件判断() or self.保存资源组[6]:事件判断()  then
		self.保存效果=false
	 elseif  self.保存资源组[5]:事件判断()  then
		请求服务(5021,{类型="保存技能",序列=tp.队伍[1].宝宝列表[self.选中].认证码})
	 end
	  self.字体:置颜色(白色):显示(self.x+143,self.y+110,"确定要保存本次赐福效果么?")
	  self.字体:置颜色(黑色):显示(self.x+223,self.y+145,"原赐福效果")
	  self.字体:置颜色(黑色):显示(self.x+216,self.y+220,"本次赐福效果")
		for n=1,4 do
			if self.原有赐福[n]~=nil then
			   self.原有赐福[n]:置坐标(self.x+163+(n-1)*50,self.y+165)
			   self.原有赐福[n]:显示(x,y,self.鼠标)
		       if self.原有赐福[n].技能 ~= nil and self.原有赐福[n].焦点 then
				  	tp.提示:超级技能(x,y,self.原有赐福[n].技能.名称)
			   end
		    end

		    if self.赐福技能[n]~=nil then
			   self.赐福技能[n]:置坐标(self.x+163+(n-1)*50,self.y+240)
			   self.赐福技能[n]:显示(x,y,self.鼠标)

		       if self.赐福技能[n].技能 ~= nil and self.赐福技能[n].焦点 then
				  	tp.提示:超级技能(x,y,self.赐福技能[n].技能.名称)
			   end
		    end



		end


end


function 超级赐福:技能窗口(dt,x,y)
	 self.技能资源组[1]:显示(self.x+10,self.y+65)
	 self.技能资源组[2]:显示(self.x+12,self.y+67)
	 self.技能资源组[3]:更新(x,y)
	 self.技能资源组[3]:显示(self.x+245,self.y+67)
	 self.技能资源组[4]:显示(self.x+23,self.y+110)
	 tp.窗口标题背景_[5]:显示(self.x+10+self.技能资源组[1].宽度/2-68,self.y+67)
	 zts1:置字间距(3)
	 zts1:显示(self.x+10+self.技能资源组[1].宽度/2-30,self.y+67,"召唤兽技能")
	 zts1:置字间距(0)
	 if self.技能资源组[3]:事件判断()   then
		self.技能显示=false
	 end
	  self.字体:置颜色(白色):显示(self.x+23,self.y+90,"可以赐福的技能")
	  local xx=0
	  local yy = 0

	  for n=1,12 do
		  if self.显示技能[n]~=nil then
			   self.显示技能[n]:置坐标(self.x+43+xx*50,self.y+130+yy*50)
			   self.显示技能[n]:显示(x,y,self.鼠标)
		       if self.显示技能[n].技能 ~= nil and self.显示技能[n].焦点 then
				  	tp.提示:超级技能(x,y,self.显示技能[n].技能.名称)
			   end
		   end
		   xx=xx+1
		   if xx>=4 then
			   	yy=yy+1
			   	xx=0
		   end
	  end



end



function 超级赐福:检查点(x,y)
		if self.可视 and self.资源组[1]:是否选中(x,y)  then
			return true
		else
			return false
		end
end

function 超级赐福:初始移动(x,y)
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

function 超级赐福:开始移动(x,y)
		if self.鼠标 then
			self.x = x - self.xx
			self.y = y - self.yy
		end
end
function 超级赐福:更新(dt) end
return 超级赐福