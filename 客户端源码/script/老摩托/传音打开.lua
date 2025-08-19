--======================================================================--

--======================================================================--
local 传音打开 = class()
local floor = math.floor
local tp,e1,e11
local format = string.format
local insert = table.insert


function 传音打开:初始化(根)
	self.ID = 102
	self.x = 68
	self.y = 95
	self.xx = 0
	self.yy = 0
	self.注释 = "首冲系统"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	tp = 根
	self.窗口时间 = 0


     e1 = tp.字体表.普通字体
     e11 = tp.字体表.普通字体




end

function 传音打开:打开(内容)
	if self.可视 then
		self.可视 = false
		self.资源组=nil
		return
	else



		insert(tp.窗口_,self)
		local 资源 = tp.资源
		local 按钮 = tp._按钮
		local 自适应 = tp._自适应


		self.资源组 = {
			[1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xAABBCC9C),
            [2] = 按钮.创建(tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x01343E13),0,0,3,true,true),
			[3] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xAABBCC9B),0,0,4,true,true),
            [4] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xAABBCC9B),0,0,4,true,true),
            [5] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xE1A5BDA0),



		}
		self.选中显示 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x10921CA7)

		self.数据=数据
		self.仙玉=内容
		tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.进程=1
	    self.信息=1
	    self.物品=0

        self.选中=0

	    local 格子 = tp._物品格子
		self.物品 = {}
		for i=1,1 do
			self.物品[i] = 格子.创建(0,0,i,"道具行囊_物品")

		end


	end
end




function 传音打开:显示(dt,x,y)
	self.焦点 = false


    self.资源组[2]:更新(x,y)
    self.资源组[3]:更新(x,y)
    self.资源组[4]:更新(x,y)

	  self.资源组[1]:显示(self.x+110,self.y+20)

	  self.资源组[2]:显示(self.x+563,self.y+25)

	  self.资源组[3]:显示(self.x+490,self.y+328)
	  self.资源组[4]:显示(self.x+405,self.y+328)
	  self.资源组[5]:显示(self.x+121,self.y+83)

      e1:置颜色(黑色)
	  e1:显示(self.x+462,self.y+172," 1")
	  e1:显示(self.x+468,self.y+292,self.仙玉)

      e11:置颜色(白色)
	  e11:显示(self.x+405,self.y+329," 兑换仙玉")
	  e11:显示(self.x+490,self.y+329,"  购 买")

    local xx=0
    for n=1,1 do
        self.物品[n]:置坐标(self.x+125+xx*51,self.y+80)
        self.物品[n]:显示(dt,x,y,self.鼠标)
        if  self.物品[n].焦点 and not tp.消息栏焦点  then
        	tp.提示:道具行囊(x,y,self.物品[n].物品)
        	if 引擎.鼠标弹起(左键) then
        		if self.选中==0 then
        			self.选中=n
        	    else
        	    	if self.选中==n then
        	    		self.选中=0
        	    	else
        	    		self.选中=n
        	    	end
        	    end
        	end
        end
        if self.选中==n then
        	self.物品[n].确定 = true
        	e1:显示(self.x+462,self.y+262," 50")
			  e1:显示(self.x+462,self.y+203," 50天")
			  e1:显示(self.x+462,self.y+232," 5秒")
          if self.资源组[3]:事件判断()  then
          	 请求服务(111)

          end
        else
        	self.物品[n].确定 = nil
        	if self.资源组[3]:事件判断() then
        		tp.常规提示:打开("#Y请选中要购买的物品")

        	end

        end
        xx=xx+1
        if xx>=5 then
           xx=0
        end
    end


    if self.资源组[2]:事件判断() then
    	self:打开()
    	return
    end




end

function 传音打开:检查点(x,y)
	if self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 传音打开:初始移动(x,y)
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

function 传音打开:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 传音打开