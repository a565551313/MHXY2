--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-06-08 16:50:47
--======================================================================--
local 系统类_队伍格子 = class()
local bw = require("gge包围盒")
local zts
local tp;
local qms = 引擎.取模型
local mouseb = 引擎.鼠标弹起
local zqj = 引擎.坐骑库
local 临时资源
local 临时资源包
local n,m

function 系统类_队伍格子:初始化(x,y,ID,根)
	self.x = x
	self.y = y+1
	self.ID = ID
	self.物品 = nil
	self.模型 = nil
	self.事件 = false
	self.焦点 = false
	self.禁止 = false
	self.包围盒  = bw(x,y,116,141)
end

function 系统类_队伍格子:置人物(人物)
	self.武器 = nil
	self.坐骑 = nil
	self.模型身体 = nil
	self.坐骑饰品 = nil
	self.光环 = nil
	self.足迹 = nil
	if 人物 ~= nil then
		if tp == nil then
			tp = 引擎.场景
			zts = tp.字体表.普通字体
		end
		if  人物.名称 ~= nil and 人物.名称 ~= 0 then
			self.武器 = nil
			self.坐骑 = nil
			self.坐骑饰品 = nil
			self.临时方向=4
			n = qms(人物.模型)
			if 人物.变身数据~=nil and 变身显示 then
              n = qms(人物.变身数据)
              self.临时方向=1
              self.模型 = tp.资源:载入(n[3],"网易WDF动画",n[1])
              if 人物.变异 and 染色信息[人物.变身数据]~=nil then
                self.染色方案2 = 染色信息[人物.变身数据].id
				self.染色组2 = 染色信息[人物.变身数据].方案
		    	self.模型:置染色(self.染色方案2,self.染色组2[1],self.染色组2[2],self.染色组2[3])
              end
              self.模型:置方向(self.临时方向)
            elseif  人物.坐骑 ~= nil and (#人物.坐骑 ~= nil or #人物.坐骑 ~= 0) and 人物.坐骑.模型 ~= nil and (人物.锦衣[1]==nil ) then
            	local 资源组 = {}
            	local 站立坐骑 = 0
            	if 引擎.新增坐骑(人物.模型,人物.坐骑.模型,"奔跑") then
					资源组 = {}
					资源组.人物资源 = "xzzq.wdf"
					资源组.人物站立 = 引擎.新增坐骑(人物.模型,人物.坐骑.模型,"站立")
					资源组.坐骑资源 = "xzzq.wdf"
					资源组.坐骑站立 = 引擎.新增坐骑(人物.模型,人物.坐骑.模型,"站立")
				else
					资源组 = zqj(人物.模型,人物.坐骑.模型,人物.坐骑.饰品 or "空")
				end
				if 站立坐骑 == 0 then
					self.模型 = tp.资源:载入(资源组.人物资源,"网易WDF动画",资源组.人物站立)
				else
					if 人物.装备[3] ~= nil then
						local 是否战斗锦衣 = true
		            	m = tp:取武器子类(人物.装备[3].子类)
						n = qms(人物.模型,m)
						if 人物.锦衣[1] ~= nil and 人物.锦衣[1].名称 ~= nil and 人物.变身数据 == nil  then
							if 人物.锦衣[1].战斗锦衣 then
								  n =引擎.取战斗锦衣素材(人物.锦衣[1].名称,人物.模型)
							      self.模型 = tp.资源:载入(n[5],"网易WDF动画",n[3])
							      是否战斗锦衣 = false
							elseif 新加战斗锦衣[人物.锦衣[1].名称]~=nil  then
						             local 模型类型 = 取角色锦衣武器类型(人物.模型,m)
						             n = 引擎.取武器锦衣素材(人物.锦衣[1].名称,人物.模型,模型类型)
						             self.模型 = tp.资源:载入(n[5],"网易WDF动画",n[3])
							end
						else
							self.模型 = tp.资源:载入(n[3],"网易WDF动画",n[1])
						end
                        if 是否战斗锦衣 then
							m = tp:取武器附加名称(人物.装备[3].子类,人物.装备[3].级别限制,人物.装备[3].名称)
							n = qms(m.."_"..人物.模型)
							self.武器 = tp.资源:载入(n[3],"网易WDF动画",n[1])
							if 人物.装备[3].染色方案 ~= nil then
								self.武器:置染色(人物.装备[3].染色方案,人物.装备[3].染色组[1],人物.装备[3].染色组[2],人物.装备[3].染色组[3])
							end
							self.武器:置方向(4)
							if (人物.锦衣[1] ~= nil and 人物.锦衣[1].名称 ~= nil) or 人物.变身数据 ~= nil  then
							else
								self.武器:置差异(self.武器.帧数-self.模型.帧数)
							end
							if 人物.染色方案 ~= nil then
								if (人物.锦衣[1] ~= nil and 人物.锦衣[1].名称 ~= nil) or 人物.变身数据 ~= nil  then
								else
									self.模型:置染色(人物.染色方案,人物.染色组[1],人物.染色组[2],人物.染色组[3])
								end
							end
					   end
						self.模型:置方向(4)
					else
						if 人物.锦衣[1] ~= nil and 人物.锦衣[1].名称 ~= nil and 人物.变身数据 == nil  then
								if 人物.锦衣[1].战斗锦衣 then
									n =引擎.取战斗锦衣素材(人物.锦衣[1].名称,人物.模型)
									 self.模型 = tp.资源:载入(n[5],"网易WDF动画",n[3])
								elseif 新加战斗锦衣[人物.锦衣[1].名称]~=nil  then
						             local 模型类型 = 取角色锦衣武器类型(人物.模型)
						             n = 引擎.取武器锦衣素材(人物.锦衣[1].名称,人物.模型,模型类型)
						             self.模型 = tp.资源:载入(n[5],"网易WDF动画",n[3])
								end
							else
							    self.模型 = tp.资源:载入(n[3],"网易WDF动画",n[1])
								if 人物.染色方案 ~= nil then
									if (人物.锦衣[1] ~= nil and 人物.锦衣[1].名称 ~= nil) or 人物.变身数据 ~= nil  then
									else
										self.模型:置染色(人物.染色方案,人物.染色组[1],人物.染色组[2],人物.染色组[3])
									end
								end
						end
						self.模型:置方向(4)
					end
					if 人物.锦衣 ~= nil and 人物.锦衣[2] ~= nil then
						n = 引擎.取光环(人物.锦衣[2].名称)
						self.光环=tp.资源:载入(n[4],"网易WDF动画",n[1])
					end
					if 人物.锦衣 ~= nil and 人物.锦衣[3] ~= nil then
						n = 引擎.取足迹(人物.锦衣[3].名称)
						self.足迹=tp.资源:载入(n[4],"网易WDF动画",n[1])
					end
					if 人物.锦衣 ~= nil and 人物.锦衣[6] ~= nil then
						n = 引擎.取魂兽(人物.锦衣[6].名称)
						self.魂兽=tp.资源:载入(n[4],"网易WDF动画",n[1])
					end
					self.人物 = 人物

				end
				-- if 人物.染色方案~=nil and 人物.坐骑.模型 ~= "独角兽" and 人物.坐骑.模型 ~= "幻·帝江" and 人物.坐骑.模型 ~= "幻·帝江·月白" and 人物.坐骑.模型 ~= "独角兽1" and 人物.坐骑.模型 ~= "飞天龙马"  and 人物.坐骑.模型 ~= "霜雪龙宝" and 人物.坐骑.模型 ~= "冰晶雪魄" and 人物.坐骑.模型 ~= "冰晶魅灵" and 人物.坐骑.模型 ~= "青梅竹马"  and 人物.坐骑.模型 ~= "深海狂鲨"  and 人物.坐骑.模型 ~= "独角马" and 人物.坐骑.模型 ~= "海豚恋人" and 人物.坐骑.模型 ~="冰晶魅灵" and 人物.坐骑.模型 ~="炫影天马" and 人物.坐骑.模型 ~="玲珑雪狐" and 人物.坐骑.模型 ~="玲珑雪狐女" and 人物.坐骑.模型 ~="烈焰雄狮" and 人物.坐骑.模型 ~="九尾神狐1" then
				--     if (人物.锦衣[1] ~= nil and 人物.锦衣[1].名称 ~= nil) or 人物.变身数据 ~= nil  then
				--     else
				--    	 	self.模型:置染色(人物.染色方案,人物.染色组[1],人物.染色组[2],人物.染色组[3])
				--    	end
				-- end
				self.坐骑 = tp.资源:载入(资源组.坐骑资源,"网易WDF动画",资源组.坐骑站立)
				-- if 人物.坐骑.染色方案~=nil and 人物.坐骑.染色组~=0 and #人物.坐骑.染色组~=0 then
				--     self.坐骑:置染色(人物.坐骑.染色方案,人物.坐骑.染色组[1],人物.坐骑.染色组[2],人物.坐骑.染色组[3])
				-- end
				if 资源组.坐骑饰品站立 ~= nil then
					self.坐骑饰品 = tp.资源:载入(资源组.坐骑饰品资源,"网易WDF动画",资源组.坐骑饰品站立)
					-- if 人物.坐骑.饰品物件~=nil and 人物.坐骑.饰品物件.染色方案~=nil and 人物.坐骑.饰品物件.染色组~=0 and #人物.坐骑.饰品物件.染色组~=0 then
					--     self.坐骑饰品:置染色(人物.坐骑.饰品物件.染色方案,人物.坐骑.饰品物件.染色组[1],人物.坐骑.饰品物件.染色组[2],人物.坐骑.饰品物件.染色组[3])
					-- end
					self.坐骑饰品:置方向(4)
				end
				self.模型:置方向(4)
				self.坐骑:置方向(4)

            elseif  人物.装备[3] ~= nil then
            	local 是否战斗锦衣 = true
            	m = tp:取武器子类(人物.装备[3].子类)
				n = qms(人物.模型,m)
				if 人物.锦衣[1] ~= nil and 人物.锦衣[1].名称 ~= nil and 人物.变身数据 == nil  then
					if 人物.锦衣[1].战斗锦衣 then
						n =引擎.取战斗锦衣素材(人物.锦衣[1].名称,人物.模型)
						self.模型 = tp.资源:载入(n[5],"网易WDF动画",n[3])
						是否战斗锦衣 = false
					elseif 新加战斗锦衣[人物.锦衣[1].名称]~=nil  then
						   local 模型类型 = 取角色锦衣武器类型(人物.模型,m)
						   n = 引擎.取武器锦衣素材(人物.锦衣[1].名称,人物.模型,模型类型)
						   self.模型 = tp.资源:载入(n[5],"网易WDF动画",n[3])
					end
				else
					self.模型 = tp.资源:载入(n[3],"网易WDF动画",n[1])
				end
				if  是否战斗锦衣 then
					m = tp:取武器附加名称(人物.装备[3].子类,人物.装备[3].级别限制,人物.装备[3].名称)
					n = qms(m.."_"..人物.模型)
					self.武器 = tp.资源:载入(n[3],"网易WDF动画",n[1])
					if 人物.装备[3].染色方案 ~= nil then
						self.武器:置染色(人物.装备[3].染色方案,人物.装备[3].染色组[1],人物.装备[3].染色组[2],人物.装备[3].染色组[3])
					end
					self.武器:置方向(4)
					if (人物.锦衣[1] ~= nil and 人物.锦衣[1].名称 ~= nil) or 人物.变身数据 ~= nil  then
					else
						self.武器:置差异(self.武器.帧数-self.模型.帧数)
					end
					if 人物.染色方案 ~= nil then
						if (人物.锦衣[1] ~= nil and 人物.锦衣[1].名称 ~= nil) or 人物.变身数据 ~= nil  then
						else
							self.模型:置染色(人物.染色方案,人物.染色组[1],人物.染色组[2],人物.染色组[3])
						end
					end
				end
				self.模型:置方向(4)
            else
				if 人物.锦衣[1] ~= nil and 人物.锦衣[1].名称 ~= nil and 人物.变身数据 == nil  then
					if 人物.锦衣[1].战斗锦衣 then
					   n =引擎.取战斗锦衣素材(人物.锦衣[1].名称,人物.模型)
					   self.模型 = tp.资源:载入(n[5],"网易WDF动画",n[3])
					elseif 新加战斗锦衣[人物.锦衣[1].名称]~=nil then
						   local 模型类型 = 取角色锦衣武器类型(人物.模型)
						   n = 引擎.取武器锦衣素材(人物.锦衣[1].名称,人物.模型,模型类型)
						   self.模型 = tp.资源:载入(n[5],"网易WDF动画",n[3])
					end
				else
					self.模型 = tp.资源:载入(n[3],"网易WDF动画",n[1])
					if 人物.染色方案 ~= nil then
						if (人物.锦衣[1] ~= nil and 人物.锦衣[1].名称 ~= nil) or 人物.变身数据 ~= nil  then
						else
							self.模型:置染色(人物.染色方案,人物.染色组[1],人物.染色组[2],人物.染色组[3])
						end
					end
				end
				self.模型:置方向(4)
			end
			if 人物.锦衣 ~= nil and 人物.锦衣[2] ~= nil then
				n = 引擎.取光环(人物.锦衣[2].名称)
				self.光环=tp.资源:载入(n[4],"网易WDF动画",n[1])
			end
			if 人物.锦衣 ~= nil and 人物.锦衣[3] ~= nil then
				n = 引擎.取足迹(人物.锦衣[3].名称)
				self.足迹=tp.资源:载入(n[4],"网易WDF动画",n[1])
			end
			self.人物 = 人物
		end
	else
	    self.模型 = nil
		self.人物 = nil
	end
end
function 系统类_队伍格子:显示(dt,x,y,条件,数据,x1,y1)
	self.事件 = false
	self.焦点 = false
	self.互换 = false
	if self.模型 == nil then
		self.武器 = nil
		self.坐骑 = nil
		self.模型身体 = nil
		self.坐骑饰品 = nil
	end
	if self.模型 ~= nil and self.人物 ~= nil then
		if self.坐骑 ~= nil then
			self.坐骑:更新(dt)
			if self.坐骑饰品 ~= nil then
				self.坐骑饰品:更新(dt)
			end
		end
		if self.模型身体 ~= nil then
			self.模型身体:更新(dt)
		end
		if self.武器 ~= nil then
			self.武器:更新(dt)
		end
		if self.光环 ~= nil then
			self.光环:更新(dt)
		end
		if self.足迹 ~= nil then
			self.足迹:更新(dt)
		end
		self.模型:更新(dt)
	end
	if 条件 and self.包围盒:检查点(x,y) and not tp.消息栏焦点 then
		tp.按钮焦点 = true
		tp.禁止关闭 = true
		self.焦点 = true
		if self.模型 ~= nil and self.人物 ~= nil then
			if mouseb(0) then
				self.事件 = true
			end
			if mouseb(1) then
				self.互换 = true
			end
		end
		if not self.禁止 then
			tp.队伍格子焦点_:显示(self.x,self.y)
		end
	end
	if self.禁止 then
		tp.队伍格子确定_:显示(self.x,self.y)
	end
	local 人物 = 数据[self.ID]
	if 人物 ~= nil then
		zts:置颜色(-16777216)
		zts:显示(self.x + 18+(x1 or 0),self.y + 152+(y1 or 0),人物.名称)
		zts:显示(self.x + 18+(x1 or 0),self.y + 176+(y1 or 0),人物.门派)
		zts:显示(self.x + 18+(x1 or 0),self.y + 200+(y1 or 0),人物.等级.."级")
	end
	if self.模型 ~= nil and 人物 ~= nil then
		tp.影子:显示(self.x + 54,self.y + 117)
		if self.光环 ~= nil then
			self.光环:显示(self.x + 54,self.y + 117)
		end
		if self.坐骑 ~= nil then
			self.坐骑:显示(self.x + 54,self.y + 117)
			if self.坐骑饰品 ~= nil then
				self.坐骑饰品:显示(self.x + 54,self.y + 117)
			end
		end
		if self.模型身体 ~= nil then
			self.模型身体:显示(self.x + 54,self.y + 117)
		end
		if self.足迹 ~= nil then
			self.足迹:显示(self.x + 54,self.y + 117)
		end
		self.模型:显示(self.x + 54,self.y + 117)
		if self.武器 ~= nil then
			self.武器:显示(self.x + 54,self.y + 117)
		end
	end
end

function 系统类_队伍格子:释放()

end

function 系统类_队伍格子:置坐标(x,y)
	self.x = x
	self.y = y
	self.包围盒:置坐标(x,y)
end

return 系统类_队伍格子