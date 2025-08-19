--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:19:27
--======================================================================--
local 场景类_战斗自动栏 = class()
local 开启自动 = false
local format = string.format
local tp

function 场景类_战斗自动栏:初始化(根)
	self.ID = 102
	self.x = 18
	self.y = 340
	self.xx = 0
	self.yy = 0
	self.注释 = "战斗"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口时间 = 0
	local 资源 = 根.资源
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,200,110,3,9),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,1),0,0,4,true,true),
		[3] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"取消"),
		[4] = 自适应.创建(1,1,196,18,1,3,nil,18),
	    [5] = 按钮.创建(自适应.创建(12,4,60,20,1,3),0,0,4,true,true," 暂离"),
		[6] = 按钮.创建(自适应.创建(12,4,60,20,1,3),0,0,4,true,true," 重置"),
		--[3] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x2BD1DEF7),0,0,4,true,nil,"取消"),
	}

	tp = 根
	self.第一次 = false
	self.回合计数 = 999
	self.状态 = "开启"


end

function 场景类_战斗自动栏:打开(sf)
	if self.可视 then
		self.可视 = false
	else
		self.可视 = true
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		if sf ~= false then
		  	self.状态 = "取消"
		else
		    self.状态 = "开启"
		end
		self.资源组[3]:置文字(self.状态)
		self.回合计数 = 999
	end
end

function 场景类_战斗自动栏:更新(dt,x,y)
end




function 场景类_战斗自动栏:取自动语句(类型)

 	if 类型==1 then --人物
     	local 编号=0
     	for n=1,#战斗类.战斗单位 do
         	if 战斗类.战斗单位[n].数据.类型=="角色" and 战斗类.战斗单位[n].数据.id==tp.队伍[1].数字id and 战斗类.战斗单位[n].数据.助战编号 == nil then
            	编号=n
         	end
     	end
      	local 语句="攻击"
      	if 编号==0 then return 语句 end
     	if 战斗类.战斗单位[编号].数据.自动指令~=nil then
         	if 战斗类.战斗单位[编号].数据.自动指令.类型=="法术" then
             	语句=战斗类.战斗单位[编号].数据.自动指令.参数
            else
             	语句=战斗类.战斗单位[编号].数据.自动指令.类型
         	end
     	end
       	return 语句
   	elseif 类型==2 then --人物
    	local 编号=0
	    for n=1,#战斗类.战斗单位 do
	        if 战斗类.战斗单位[n].数据.类型=="bb" and 战斗类.战斗单位[n].数据.id==tp.队伍[1].数字id then
	            编号=n
	        end
	    end
      	if 编号==0 then return "无" end
      	local 语句="攻击"
     	if 战斗类.战斗单位[编号].数据.自动指令~=nil then
         	if 战斗类.战斗单位[编号].数据.自动指令.类型=="法术" then
             	语句=战斗类.战斗单位[编号].数据.自动指令.参数
            else
             	语句=战斗类.战斗单位[编号].数据.自动指令.类型
         	end
     	end
       	return 语句
 	end
end



function 场景类_战斗自动栏:取自动状态()
	self.状态="开启"
  	for n=1,#战斗类.战斗单位 do
        if 战斗类.战斗单位[n].数据.自动战斗 and 战斗类.战斗单位[n].数据.类型=="角色" and 战斗类.战斗单位[n].数据.id==tp.队伍[1].数字id then
            self.状态="取消"
        end
    end
  	if self.资源组[3].按钮文字~=self.状态 then
      	self.资源组[3]:置文字(self.状态)
    end
 end
function 场景类_战斗自动栏:显示(dt,x,y)
	self:取自动状态()
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[4]:显示(self.x+2,self.y+2)
	self.资源组[2]:更新1(x,y)
	self.资源组[3]:更新1(x,y)
	self.资源组[2]:显示(self.x+178,self.y+2)

	self.资源组[5]:更新1(x,y)
	self.资源组[6]:更新1(x,y)
	self.资源组[5]:显示(self.x+5,self.y+85)
	self.资源组[6]:显示(self.x+70,self.y+85)
	self.资源组[3]:显示(self.x+135,self.y+85)

	tp.字体表.自动栏字体:置颜色(白色)
	tp.字体表.自动栏字体:显示(self.x + 66,self.y + 33,"剩余     回合")
	tp.字体表.自动栏字体:显示(self.x + 11,self.y + 54,"人物：         召唤兽：")

	tp.字体表.自动栏字体:置颜色(黄色)
	--tp.字体表.自动栏字体:显示(self.x + 92,self.y + 33,"∞")
	tp.字体表.自动栏字体:显示(self.x + 92,self.y + 33,self.回合计数)
	tp.字体表.自动栏字体:显示(self.x + 46,self.y + 54,self:取自动语句(1))
	tp.字体表.自动栏字体:显示(self.x + 147,self.y + 54,self:取自动语句(2))
	tp.字体表.排行字体:置颜色(白色):显示(self.x+self.资源组[1].宽度/2-30,self.y+3,"自动战斗")

	-- tp.字体表.普通字体:置颜色(白色)
	-- tp.字体表.普通字体:显示(self.x + 25,self.y + 33,self:取自动语句(1))
	-- tp.字体表.普通字体:显示(self.x + 25,self.y + 60,self:取自动语句(2))



   if self.回合计数<=0 and self.可视 then
   	  if self.状态 =="取消" then
   	  	 请求服务(5507)
   	  end
   	  战斗类.自动开关 = false
	  self.可视 = false
   	  self.回合计数 =  999
   	end

	if self.鼠标 then
		if self.资源组[2]:事件判断() then
			战斗类.自动开关 = false
			self.可视 = false
		elseif self.资源组[3]:事件判断() then
          请求服务(5507)
        elseif self.资源组[5]:事件判断() then
        	self.回合计数=9999
        elseif self.资源组[6]:事件判断() then
         	self.回合计数=  999
		end
	end
	if tp.按钮焦点 then
		self.焦点 = true
	end
	if 引擎.鼠标弹起(1) and not tp.禁止关闭 and self.鼠标 then
		self:打开()
	end
end

function 场景类_战斗自动栏:检查点(x,y)
	if self.资源组[1]:是否选中(x,y) then
	  	self.鼠标=true
	  	--self.焦点 = true
		return true
	end

end

function 场景类_战斗自动栏:初始移动(x,y)
	-- tp.运行时间 = tp.运行时间 + 1
	-- if not self.第一次 then
	-- 	tp.运行时间 = tp.运行时间 + 2
	-- 	self.第一次 = true
	-- end
	if not 引擎.场景.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end

	if not self.焦点 then
		战斗类.移动窗口 = true
	end
	if self.可视 and self.鼠标 and not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_战斗自动栏:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end




return 场景类_战斗自动栏

