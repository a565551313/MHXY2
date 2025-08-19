
local 战斗动画类 = class()


local 偏移x,偏移y = 0,0
local 偏移1x,偏移1y = 0,0
function 战斗动画类:初始化()
	self.动画 = {}
	self.武器 = {}
	self.副武器 = {}
	self.身体动画 = {}
	self.攻击特效 = {}
	self.模型资源 = {}
	self.锦衣资源 = {}
	self.武器资源 = {}
	self.行为 = "待战"
	self.武器数据 = ""
	self.音效模型 = ""
	self.单位模型 = ""
	self.状态行为 = "待战"
	self.显示武器 = false
	self.动作资源={"待战","跑去","防御","攻击","暴击","挨打","返回","死亡","施法"}
	self.模型类型 = 1

end




function 战斗动画类:创建动画(模型,类型,染色方案,染色组,变异,武器,变身,饰品,锦衣,武器染色方案,武器染色组,饰品染色方案,饰品染色组,副武器)
	--print(模型,类型,染色方案,染色组,变异,武器,变身,饰品,锦衣,武器染色方案,武器染色组,饰品染色方案,饰品染色组)
	--print(模型,饰品)
	    self.动画 = {}
		self.武器 = {}
		self.副武器 = {}
		self.光环 = {}
		self.身体动画 = {}
		self.攻击特效 = {}
		self.模型资源 = {}
		self.锦衣资源 = {}
		self.武器资源 = {}
		self.行为 = "待战"
		self.武器数据 = ""
		self.音效模型 = ""
		self.状态行为 = "待战"
		self.单位模型 = 模型
		self.显示武器 = false
		self.模型类型 = 1
		if 变身~=nil and 变身显示 then
			类型=1
			self.单位模型=变身
			if 变异 then
				染色方案 = 染色信息[self.单位模型].id
				染色组 = 染色信息[self.单位模型].方案
			else
				染色方案 = nil
				染色组 = nil
		   end
		end
		self.模型资源 = 引擎.取战斗模型(self.单位模型)

		if 类型=="角色" or 类型=="系统PK角色" or 类型=="系统角色" then
			if 武器 ~= nil then
				if 武器.名称 == "龙鸣寒水" or 武器.名称 == "非攻" then
					self.武器数据 = "弓弩1"
				else
					self.武器数据 = tp:取武器子类(武器.子类)
				end
				self.模型资源 = 引擎.取战斗模型(self.单位模型,self.武器数据)
			end
			self.动画.待战 = tp.资源:载入(self.模型资源[10],"网易WDF动画",self.模型资源[6])
			self.动画.跑去 = tp.资源:载入(self.模型资源[10],"网易WDF动画",self.模型资源[8])
			self.动画.防御 = tp.资源:载入(self.模型资源[10],"网易WDF动画",self.模型资源[4])
			self.动画.攻击 = tp.资源:载入(self.模型资源[10],"网易WDF动画",self.模型资源[1])
			self.动画.暴击 = tp.资源:载入(self.模型资源[10],"网易WDF动画",self.模型资源[1])
			self.动画.挨打 = tp.资源:载入(self.模型资源[10],"网易WDF动画",self.模型资源[9])
			self.动画.返回 = tp.资源:载入(self.模型资源[10],"网易WDF动画",self.模型资源[8])
			self.动画.死亡 = tp.资源:载入(self.模型资源[10],"网易WDF动画",self.模型资源[3])
			self.动画.施法 = tp.资源:载入(self.模型资源[10],"网易WDF动画",self.模型资源[7])
			if 染色方案~=0 and 染色组~=0 and 染色组~=nil and #染色组>0 then
				for n=1,#self.动作资源 do
					self.动画[self.动作资源[n]]:置染色(染色方案,染色组[1],染色组[2],染色组[3])
				end
        	end
            if 锦衣 and 锦衣[1] and 锦衣[1].名称  and 屏蔽锦衣效果==false then
                if 锦衣[1].战斗锦衣 then
                	self.锦衣资源 = 引擎.取战斗锦衣素材(锦衣[1].名称,self.单位模型)
					self.动画.待战 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[3])
					self.动画.跑去 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[4])
					self.动画.返回 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[4])
					self.动画.防御 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[3])
					self.动画.攻击 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[1])
					self.动画.暴击 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[1])
					self.动画.挨打 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[3])
					self.动画.施法 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[2])
					if self.锦衣资源[6] then
					    self.动画.挨打 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[6])
					end
					if self.锦衣资源[7] then
					    self.动画.死亡 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[7])
					end
					self.显示武器 = true
                else
                	if 新加战斗锦衣[锦衣[1].名称] then
                		self.模型类型 = 取角色锦衣武器类型(self.单位模型,self.武器数据)
                		self.锦衣资源 = 引擎.取武器锦衣素材(锦衣[1].名称,self.单位模型,self.模型类型)
                		self.动画.待战 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[3])
						self.动画.跑去 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[4])
						self.动画.返回 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[4])
						self.动画.防御 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[3])
						self.动画.攻击 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[1])
						self.动画.暴击 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[1])
						self.动画.挨打 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[3])
						self.动画.施法 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[2])
						if self.锦衣资源[6] then
						    self.动画.挨打 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[6])
						end
						if self.锦衣资源[7] then
						    self.动画.死亡 = tp.资源:载入(self.锦衣资源[5],"网易WDF动画",self.锦衣资源[7])
						end
						self.显示武器 = false
					end
                end
                self.动画.死亡 = tp.资源:载入("房屋图标.wdf","网易WDF动画",0x001E9FE2)
			end
			if 锦衣 and 锦衣[2] and 锦衣[2].名称 and 屏蔽光环足迹效果==false then
			    local n = 引擎.取光环(锦衣[2].名称)
			    for i=1,#self.动作资源 do
			    	self.光环[self.动作资源[i]]=tp.资源:载入(n[4],"网易假人动画",n[1])
			    end
			    self.光环.跑去=tp.资源:载入(n[4],"网易假人动画",n[2])
            end
            if self.武器数据 and self.武器数据~="" and 武器 then
				local m = tp:取武器附加名称(武器.子类,武器.级别限制,武器.名称)
				self.武器资源 = 引擎.取战斗模型(m.."_"..self.单位模型)
				if self.武器数据  == "弓弩" or self.武器数据  == "弓弩1" then
					self.攻击方式 = 1
				end
				if self.武器资源[10] then
					if 锦衣 and 锦衣[1] and 锦衣[1].名称 and 屏蔽锦衣效果==false then
						local n = 引擎.取模型(m.."_"..self.单位模型)
						self.武器.待战 = tp.资源:载入(n[3],"网易WDF动画",n[1])
						self.武器.挨打 = tp.资源:载入(n[3],"网易WDF动画",n[1])
						self.武器.防御 = tp.资源:载入(n[3],"网易WDF动画",n[1])
						self.武器.跑去 = tp.资源:载入(n[3],"网易WDF动画",n[2])
						self.武器.返回 = tp.资源:载入(n[3],"网易WDF动画",n[2])
					else
						self.武器.待战 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[6])
						self.武器.挨打 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[9])
						self.武器.防御 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[4])
						self.武器.跑去 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[8])
						self.武器.返回 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[8])
					end
					self.武器.攻击 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[1])
					self.武器.暴击 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[2])
					self.武器.施法 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[7])
					if self.武器资源[3] and self.武器资源[3] ~= 0 then
						self.武器.死亡 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[3])
					end
					if self.模型资源 and self.模型资源[15] and self.模型资源[11] and self.模型资源[12] then
						self.身体动画 = {}
						self.身体动画.攻击 = tp.资源:载入(self.模型资源[15],"网易WDF动画",self.模型资源[11])
						self.身体动画.暴击 = tp.资源:载入(self.模型资源[15],"网易WDF动画",self.模型资源[11])
					    self.身体动画.施法 = tp.资源:载入(self.模型资源[15],"网易WDF动画",self.模型资源[12])
					    if self.模型资源[16] then
					       	self.身体动画.暴击 = tp.资源:载入(self.模型资源[15],"网易WDF动画",self.模型资源[16])
					    end
					    if 武器.级别限制>90 then
					        if self.模型资源[13] then
					        	self.身体动画.攻击 = tp.资源:载入(self.模型资源[15],"网易WDF动画",self.模型资源[13])
						    	self.身体动画.暴击 = tp.资源:载入(self.模型资源[15],"网易WDF动画",self.模型资源[13])
					        end
					        if self.模型资源[16] then
						        self.身体动画.暴击 = tp.资源:载入(self.模型资源[15],"网易WDF动画",self.模型资源[16])
						    end
						    if self.模型资源[17] then
						        self.身体动画.暴击 = tp.资源:载入(self.模型资源[15],"网易WDF动画",self.模型资源[17])
						    end
					      	if self.模型资源[14] then
					        	self.身体动画.施法 = tp.资源:载入(self.模型资源[15],"网易WDF动画",self.模型资源[14])
					        end
					    end
					end
					if 武器.染色方案 and 武器.染色方案~=0 and 武器.染色组 and 武器.染色组~=0 and #武器.染色组>0 then
						for n=1,#self.动作资源 do
							self.武器[self.动作资源[n]]:置染色(武器.染色方案,武器.染色组[1],武器.染色组[2],武器.染色组[3])
						end
					end
					if 武器染色方案 and 武器染色方案~=0 and 武器染色组 and 武器染色组~=0 and #武器染色组>0 then
						for n=1,#self.动作资源 do
							self.武器[self.动作资源[n]]:置染色(武器染色方案,武器染色组[1],武器染色组[2],武器染色组[3])
						end
					end

				end
			end
			if 副武器 and 副武器.名称 then
				self.武器资源 = 引擎.取战斗模型(副武器.名称.."_"..self.单位模型)
				if self.武器资源[10] then
					if 锦衣 and 锦衣[1] and 锦衣[1].名称 and 屏蔽锦衣效果==false then
						local n = 引擎.取模型(副武器.名称.."_"..self.单位模型)
						self.副武器.待战 = tp.资源:载入(n[3],"网易WDF动画",n[1])
						self.副武器.防御 = tp.资源:载入(n[3],"网易WDF动画",n[1])
						self.副武器.挨打 = tp.资源:载入(n[3],"网易WDF动画",n[1])
						self.副武器.跑去 = tp.资源:载入(n[3],"网易WDF动画",n[2])
						self.副武器.返回 = tp.资源:载入(n[3],"网易WDF动画",n[2])
					else
						self.副武器.待战 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[6])
						self.副武器.防御 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[4])
						self.副武器.挨打 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[9])
						self.副武器.跑去 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[8])
						self.副武器.返回 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[8])
					end
					self.副武器.攻击 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[1])
					self.副武器.暴击 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[2])
					self.副武器.施法 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[7])
					if self.武器资源[3] and self.武器资源[3] ~= 0 then
						self.副武器.死亡 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[3])
					end
					if 副武器.染色方案 and 副武器.染色方案~=0 and 副武器.染色组 and 副武器.染色组~=0 and #副武器.染色组>0 then
						for n=1,#self.动作资源 do
							self.副武器[self.动作资源[n]]:置染色(副武器.染色方案,副武器.染色组[1],副武器.染色组[2],副武器.染色组[3])
						end
					end
					if self.模型资源 and self.模型资源[22] and self.模型资源[18] and self.模型资源[19] then
						self.攻击特效 = {}
						self.攻击特效.攻击 = tp.资源:载入(self.模型资源[22],"网易WDF动画",self.模型资源[18])
						self.攻击特效.暴击 = tp.资源:载入(self.模型资源[22],"网易WDF动画",self.模型资源[18])
						self.攻击特效.施法 = tp.资源:载入(self.模型资源[22],"网易WDF动画",self.模型资源[19])
						if self.模型资源[23] then
						    self.攻击特效.暴击 = tp.资源:载入(self.模型资源[22],"网易WDF动画",self.模型资源[23])
						end
						if 副武器.级别限制>90 then
						    if self.模型资源[20] then
						        self.攻击特效.攻击 = tp.资源:载入(self.模型资源[22],"网易WDF动画",self.模型资源[20])
							    self.攻击特效.暴击 = tp.资源:载入(self.模型资源[22],"网易WDF动画",self.模型资源[20])
						    end
						    if self.模型资源[23] then
							    self.攻击特效.暴击 = tp.资源:载入(self.模型资源[22],"网易WDF动画",self.模型资源[23])
							end
							if self.模型资源[24] then
							    self.攻击特效.暴击 = tp.资源:载入(self.模型资源[22],"网易WDF动画",self.模型资源[24])
							end
						    if self.模型资源[21] then
						        self.攻击特效.施法 = tp.资源:载入(self.模型资源[22],"网易WDF动画",self.模型资源[21])
						    end
						end
					end
				end
			end
			if self.显示武器 then
				self.武器 = {}
				self.副武器 = {}
			end
    	else-------------------宠物
		    self.动画.待战 = tp.资源:载入(self.模型资源[10],"网易WDF动画",self.模型资源[6])
		    self.动画.跑去 = tp.资源:载入(self.模型资源[10],"网易WDF动画",self.模型资源[8])
		    self.动画.防御 = tp.资源:载入(self.模型资源[10],"网易WDF动画",self.模型资源[4])
		    self.动画.攻击 = tp.资源:载入(self.模型资源[10],"网易WDF动画",self.模型资源[1])---人物模型第一套攻击动作
		    self.动画.暴击 = tp.资源:载入(self.模型资源[10],"网易WDF动画",self.模型资源[2])---人物模型第一套攻击动作
		    self.动画.挨打 = tp.资源:载入(self.模型资源[10],"网易WDF动画",self.模型资源[9])
		    self.动画.返回 = tp.资源:载入(self.模型资源[10],"网易WDF动画",self.模型资源[8])
		    self.动画.死亡 = tp.资源:载入(self.模型资源[10],"网易WDF动画",self.模型资源[3])
		    self.动画.施法 = tp.资源:载入(self.模型资源[10],"网易WDF动画",self.模型资源[7])
		    if 饰品 then
				self.武器资源 = 引擎.取战斗模型(self.单位模型.."_饰品")  ---这里显示宠物饰品的
		    	if self.武器资源[10] then
				   self.武器.待战 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[6])
				   self.武器.跑去 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[8])
				   self.武器.防御 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[4])
				   self.武器.攻击 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[1])---饰品第一套攻击动作
				   self.武器.暴击 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[2])---饰品第一套攻击动作
				   self.武器.挨打 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[9])
				   self.武器.返回 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[8])
				   self.武器.死亡 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[3])
				   self.武器.施法 = tp.资源:载入(self.武器资源[10],"网易WDF动画",self.武器资源[7])
		    	end
		    end
		    if self.模型资源 and  self.模型资源[15] and self.模型资源[11] and self.模型资源[12] then
				self.身体动画 = {}
				self.身体动画.攻击 = tp.资源:载入(self.模型资源[15],"网易WDF动画",self.模型资源[11])
				self.身体动画.暴击 = tp.资源:载入(self.模型资源[15],"网易WDF动画",self.模型资源[11])
				self.身体动画.施法 = tp.资源:载入(self.模型资源[15],"网易WDF动画",self.模型资源[12])
				if self.模型资源[16] then
					self.身体动画.暴击 = tp.资源:载入(self.模型资源[15],"网易WDF动画",self.模型资源[16])
				end
		    end
			for n=1,#self.动作资源 do
			     if 变异 and 染色信息[self.单位模型] then
			         self.动画[self.动作资源[n]]:置染色(染色信息[self.单位模型].id,染色信息[self.单位模型].方案[1],染色信息[self.单位模型].方案[2],染色信息[self.单位模型].方案[3])
			         self.动画.暴击:置染色(染色信息[self.单位模型].id,染色信息[self.单位模型].方案[1],染色信息[self.单位模型].方案[2],染色信息[self.单位模型].方案[3])
		          elseif 染色方案~=nil and 染色组~=nil then
		             self.动画[self.动作资源[n]]:置染色(染色方案,染色组[1],染色组[2],染色组[3])
		             self.动画.暴击:置染色(染色方案,染色组[1],染色组[2],染色组[3])
		          end
		          if 饰品 and 饰品染色方案 and 饰品染色组 and self.武器[self.动作资源[n]] then
		             self.武器[self.动作资源[n]]:置染色(饰品染色方案,饰品染色组[1],饰品染色组[2],饰品染色组[3])
		             self.武器.暴击:置染色(饰品染色方案,饰品染色组[1],饰品染色组[2],饰品染色组[3])
		          end
            end
		end
	self.影子= tp.资源:载入('登陆资源.wdf',"网易WDF动画",0xDCE4B562)
end

function 战斗动画类:保持帧率换方向(方向,动作)
	self.动画[动作]:置方向(方向)
	self.动画[动作]:换帧更新1()
	if self.武器~=nil and self.武器[动作]~=nil  then
		self.武器[动作]:置方向(方向)
		self.武器[动作]:换帧更新1()
	end
	if self.副武器~=nil and self.副武器[动作]~=nil  then
		self.副武器[动作]:置方向(方向)
		self.副武器[动作]:换帧更新1()
	end
	if self.身体动画 ~= nil and self.身体动画[动作]~=nil then
		self.身体动画[动作]:置方向(方向)
		self.身体动画[动作]:换帧更新1()
	end
	if self.攻击特效 ~= nil and self.攻击特效[动作]~=nil then
		self.攻击特效[动作]:置方向(方向)
		self.攻击特效[动作]:换帧更新1()
	end
end

function 战斗动画类:置方向(方向,动作)

	self.动画[动作]:置方向(方向)
	self.动画[动作]:换帧更新()
	if self.武器~=nil and self.武器[动作]~=nil  then
		self.武器[动作]:置方向(方向)
		self.武器[动作]:换帧更新()
	end
	if self.身体动画 ~= nil and self.身体动画[动作]~=nil then
		self.身体动画[动作]:置方向(方向)
		self.身体动画[动作]:换帧更新()
	end
	if self.副武器~=nil and self.副武器[动作]~=nil  then
		self.副武器[动作]:置方向(方向)
		self.副武器[动作]:换帧更新()
	end
	if self.攻击特效 ~= nil and self.攻击特效[动作]~=nil then
		self.攻击特效[动作]:置方向(方向)
		self.攻击特效[动作]:换帧更新()
	end
end

function 战斗动画类:置帧率(动作,帧率)
	self.动画[动作].帧率=帧率
	if self.武器~=nil and self.武器[动作]~=nil  then
		self.武器[动作].帧率=帧率
	end
	if self.身体动画 ~= nil and self.身体动画[动作]~=nil then
		self.身体动画[动作].帧率=帧率
	end
	if self.副武器~=nil and self.副武器[动作]~=nil  then
		self.副武器[动作].帧率=帧率
	end
	if self.攻击特效 ~= nil and self.攻击特效[动作]~=nil then
		self.攻击特效[动作].帧率=帧率
	end
end


function 战斗动画类:置颜色(颜色,动作)
	self.动画[动作]:置颜色(颜色)
	--self.动画[动作]:换帧更新()
	if self.武器~=nil and self.武器[动作]~=nil  then
		self.武器[动作]:置颜色(颜色)
		--  self.武器[动作]:换帧更新()
	end
	if self.身体动画 ~= nil and self.身体动画[动作]~=nil then
		self.身体动画[动作]:置颜色(颜色)
	end

	if self.副武器~=nil and self.副武器[动作]~=nil  then
		self.副武器[动作]:置颜色(颜色)
		--  self.武器[动作]:换帧更新()
	end
	if self.攻击特效 ~= nil and self.攻击特效[动作]~=nil then
		self.攻击特效[动作]:置颜色(颜色)
	end
end

function 战斗动画类:取当前帧(动作)
	return self.动画[动作]:取当前帧()
end

function 战斗动画类:取结束帧(动作)
	return self.动画[动作]:取结束帧()
end

function 战斗动画类:取开始帧(动作)
	return self.动画[动作]:取开始帧()
end

function 战斗动画类:更新(dt,动作)
	if self.光环~=nil and self.光环[动作]~=nil  then
		self.光环[动作]:更新(dt)
	end
	if self.动画~=nil and self.动画[动作]~=nil then
		self.动画[动作]:更新(dt)
 	end
	if self.武器~=nil and self.武器[动作]~=nil  then
		self.武器[动作]:更新(dt)
	end
	if self.身体动画 ~= nil and self.身体动画[动作]~=nil then
		self.身体动画[动作]:更新(dt*1.5)
	end
	if self.副武器~=nil and self.副武器[动作]~=nil  then
		self.副武器[动作]:更新(dt)
	end
	if self.攻击特效 ~= nil and self.攻击特效[动作]~=nil then
		self.攻击特效[动作]:更新(dt*1.5)
	end

end



function 战斗动画类:显示(x,y,动作)
	if self.光环~=nil and self.光环[动作]~=nil  then
		self.光环[动作]:显示(x,y)
	end
	self.影子:显示(x,y)

	self.动画[动作]:显示(x,y)
	if self.武器~=nil and self.武器[动作]~=nil  then
		self.武器[动作]:显示(x+偏移x,y+偏移y)
	end
	if self.副武器~=nil and self.副武器[动作]~=nil  then
		self.副武器[动作]:显示(x+偏移1x,y+偏移1y)
	end
	if self.身体动画 ~= nil and self.身体动画[动作]~=nil then
		self.身体动画[动作]:显示(x,y)
	end
	if self.攻击特效 ~= nil and self.攻击特效[动作]~=nil then
		self.攻击特效[动作]:显示(x,y)
	end
end




function 战斗动画类:取是否有进阶资源(模型)
          local 临时资源 = {"牛魔王","金铙僧","金身罗汉","真陀护法","增长巡守","般若天女","持国巡守","灵灯侍者","进阶白熊","进阶天兵","进阶天将","进阶风伯","进阶凤凰",
          "进阶雨师","进阶蚌精","进阶琴仙","进阶泪妖","进阶镜妖", "进阶龙龟","进阶画魂","进阶鬼将","进阶巴蛇","进阶灵鹤","进阶幽灵","进阶鲛人","进阶蛟龙","进阶小丫丫",
          "进阶小仙女","进阶小仙灵","进阶小精灵","进阶小魔头", "进阶野猪精","进阶鼠先锋","进阶阴阳伞","进阶雷鸟人","进阶踏云兽","进阶炎魔神","进阶噬天虎","进阶吸血鬼",
          "进阶机关鸟","进阶连弩车","进阶机关兽","进阶金铙僧","进阶混沌兽","进阶机关人","进阶雾中仙","进阶夜罗刹","进阶蝎子精","进阶蜃气妖", "进阶古代瑞兽","进阶蝴蝶仙子",
          "进阶黑山老妖","进阶地狱战神","进阶碧水夜叉","进阶巡游天神","进阶芙蓉仙子","进阶星灵仙子","进阶如意仙子","进阶锦毛貂精","进阶千年蛇魅","进阶百足将军","进阶律法女娲",
          "进阶灵符女娲","进阶净瓶女娲","进阶红萼仙子","进阶大力金刚","进阶葫芦宝贝","进阶幽萤娃娃", "进阶猫灵人形","进阶猫灵兽形","进阶狂豹人形","进阶狂豹兽形","进阶曼珠沙华",
          "进阶长眉灵猴","进阶巨力神猿","进阶金身罗汉","进阶蔓藤妖花","进阶毗舍童子","进阶持国巡守","进阶真陀护法","进阶增长巡守" ,"进阶灵灯侍者","进阶般若天女","进阶修罗傀儡鬼",
          "进阶修罗傀儡妖","进阶犀牛将军人形","进阶犀牛将军兽形"}
          for i=1,#临时资源 do
          	if 临时资源[i] == 模型 then
          		return true
          	end
          end
   return  false
end

function 战斗动画类:卸载()
	for i,v in ipairs(self.动作资源) do
		if self.动画~=nil and  self.动画[v] then
		 	self.动画[v]:释放()
		end
		if self.武器~=nil and self.武器[v]~=nil  then
			self.武器[v]:释放()
		end
		if self.副武器~=nil and self.副武器[v]~=nil  then
			self.副武器[v]:释放()
		end
		if self.身体动画 ~= nil and self.身体动画[v]~=nil then
			self.身体动画[v]:释放()
		end
		if self.攻击特效 ~= nil and self.攻击特效[v]~=nil then
			self.攻击特效[v]:释放()
		end
		if self.光环~=nil and self.光环[v]~=nil  then
			self.光环[v]:释放()
		end
	end
	self.动画={}
	self.武器={}
	self.光环={}
	self.副武器={}
	self.身体动画={}
	self.攻击特效={}
	递归清空(self)
end

return 战斗动画类