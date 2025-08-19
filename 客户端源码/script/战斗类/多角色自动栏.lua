
local 场景类_多角色自动栏 = class()
local 状态 = "取消自动"
local 开启自动 = false
local format = string.format
local tp,zt
local tb = {"防御","攻击","设置技能"}
function 场景类_多角色自动栏:初始化(根)
	self.ID = 669
	self.x = 1
	self.y = 313
	self.xx = 0
	self.yy = 0
	self.注释 = "战斗"
	self.可视 = false
	self.可视化 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口时间 = 0
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	local 资源 = 根.资源
	local 小型选项栏 = 根._小型选项栏
	self.资源组 = {
		[1] = 自适应.创建(0,1,360,270,3,9),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭
		[3] =按钮.创建(自适应.创建(12,4,70,20,1,1),0,0,4,true,true,"隐藏面板"),
		[4] = 自适应.创建(1,1,330,18,1,3,nil,18),--标题背景
		[5] =资源:载入('自动战斗.wdf',"网易WDF动画",0x00000001),
		[6] = 资源:载入('自动战斗.wdf',"网易WDF动画",0x00000002),
		[7] =资源:载入('自动战斗.wdf',"网易WDF动画",0x00000003),
		[8] = 自适应.创建(3,1,92,18,1,3,nil,18),
		}

	tp = 根
	zt=tp.字体表.普通字体

	self.显示技能 ={}
	self.改变技能  ={}
	self.法术界面= require("script/战斗类/多角色技能栏").创建(根)
	self.九黎界面= require("script/战斗类/多角色九黎栏").创建(根)
	self.技能设置 = false
	self.门派类型 = ""

end

function 场景类_多角色自动栏:打开()
	if self.可视化 then
		self.可视化 = false
		self.显示技能 ={}
	    self.改变技能  ={}
	    self.技能设置 = false
	else
		self.可视化 = true
		self.可移动 = true
		self.技能设置 = false
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间

	end
end
function 场景类_多角色自动栏:更新(dt,x,y) end


function 场景类_多角色自动栏:刷新(内容)
	  self.改变技能[内容.位置].已改参数 = 内容.技能
	  local 临时种类 = 引擎.取技能(内容.技能)
	  self.改变技能[内容.位置].已改附加 = 临时种类[3]
	  self.技能设置 = false
end



function 场景类_多角色自动栏:显示(dt,x,y)
--self:取自动状态()
	self.焦点 = false

	     if  self.资源组[5]:是否选中(x,y) and 引擎.鼠标弹起(0)  then
			       	if  self.x == 1 then
			         	self.x = self.x-310
			         else
			            self.x = 1
			         end
			   end

			self.资源组[5]:显示(self.x,self.y-95)
			local xx = 0
			local yy = 0
			for i = 1 ,10 do
			    self.资源组[7]:显示(self.x+15+xx*60,self.y-95+40+yy*85)
			    if 多角色操作数据[i] ~=nil then
	             if 多角色操作数据[i].参数~= "攻击"  then
					    local s  = 引擎.取技能(多角色操作数据[i].参数)
					   self.显示技能[i] = tp.资源:载入(s[6],"网易WDF动画",s[7])
					   self.显示技能[i]:显示(self.x+14+xx*60,self.y-95+41+yy*85)
					else
						local s  = 引擎.取技能("必杀")
					   self.显示技能[i] = tp.资源:载入(s[6],"网易WDF动画",s[7])
					   self.显示技能[i]:显示(self.x+14+xx*60,self.y-95+41+yy*85)
					end
				 end

			    xx = xx + 1
			    if xx >=5 then
			    	yy = yy +1
			    	xx = 0
			    end
			end



	         self.资源组[6]:显示(self.x,self.y-95)
	         local zx = 0
			local zy = 0
			for i = 1 ,10 do
                 if 多角色操作数据[i] ~=nil then
					zt:置颜色(白色):显示(self.x+11+zx*60,self.y-95+88+zy*85,多角色操作数据[i].参数)
					if self.显示技能[i]:是否选中(x,y) then
						local 编号 = 多角色操作数据[i].编号
						if 战斗类.战斗单位[编号] then
							tp.提示:自定义(x-42,y+27,"#Y/右键设置 #R/".. 战斗类.战斗单位[编号].名称.."#Y/ 的技能")
							if 引擎.鼠标弹起(1) and (tp.多角色[ 战斗类.战斗单位[编号].数据.id]~=nil or  战斗类.战斗单位[编号].数据.id ==tp.队伍[1].数字id) then
								if 战斗类.战斗单位[编号].门派 == "九黎城" then
									self.九黎界面:打开(战斗类.战斗单位[编号],i)
								else
									self.法术界面:打开(战斗类.战斗单位[编号],i)
								end
							end
						end
					end

				end

			    zx = zx + 1
			    if zx >=5 then
			    	zy = zy +1
			    	zx = 0
			    end
			end



	if tp.按钮焦点 then
		self.焦点 = true
	end
	-- if 引擎.鼠标弹起(1)  and not tp.禁止关闭 and self.鼠标 then
	-- 	self:打开()
	-- end
	  if self.技能设置 then
	  	 if self.门派类型=="九黎城" then
	  	 	 self.九黎界面:显示(dt,x,y)
	  	 else
	  	     self.法术界面:显示(dt,x,y)
	  	 end
      end
end

function 场景类_多角色自动栏:检查点(x,y)
	if self.资源组[1]:是否选中(x,y) or  self.资源组[5]:是否选中(x,y) then
		self.鼠标=true
		--local xy={x=x-self.x,y=y-self.y}
		--self.x,self.y=x,y
		return true

	end
end

function 场景类_多角色自动栏:初始移动(x,y)


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

function 场景类_多角色自动栏:开始移动(x,y)
	if self.可视化 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end
return 场景类_多角色自动栏