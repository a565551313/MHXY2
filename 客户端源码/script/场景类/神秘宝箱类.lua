
local 神秘宝箱类 = class()
local tp,zts1
local insert = table.insert

function 神秘宝箱类:初始化(根)
	tp = 根
    self.ID = 90
	self.x = 200
	self.y = 100
	self.xx = 0
	self.yy = 0
	self.注释 = "给予类"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.右键关闭=1
	zts1 = 根.字体表.描边字体
	self.窗口时间 = 0
end
function 神秘宝箱类:打开(内容)
if self.可视 then
		for i=1,5 do
			--self.队伍格子[i].禁止 = false
		end
		self.选中人物 = 0
		self.可视 = false
		self.资源组=nil
		return
	else
		insert(tp.窗口_,self)
		local 按钮 = tp._按钮
		local 自适应 = tp._自适应
		self.资源组 = {
			[1] = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0xE5B48C60),
	        [2] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"停止"),
	        [3] = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x01000052),
		}
     	tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.开关=false
	    self.进程=0
	    self.位置=0
	    self.间隔=0
	    self.商品={}
	    self.起始=时间
	    self.速度=5
	    self.中奖=内容.道具.中奖
	    for n=1,24 do
         	self.商品[n]={}
         	local 资源=引擎.取物品(内容.道具[n].名称)
		  	self.商品[n].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
		  	self.商品[n].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
		  	self.商品[n].名称=内容.道具[n].名称
		  	self.商品[n].说明=资源[1]
		  	if 内容.道具[n].说明~=nil and 内容.道具[n].说明~="普通" then
          	   self.商品[n].说明=内容.道具[n].说明
          	end
          	self.商品[n].备注=nil
          	if 内容.道具[n].备注~=nil and 内容.道具[n].备注~="无" then
          	   self.商品[n].备注=内容.道具[n].备注
          	end

	    end
    end
end

function 神秘宝箱类:更新(dt)

end


function 神秘宝箱类:显示(dt,x,y)
 	self.资源组[1]:显示(self.x,self.y)
 	if self.开关 then
		if self.进程==0 then
			self.间隔=self.间隔+1
	   		if self.间隔>=self.速度 then
	   	 		self.间隔=0
		  		self.位置=self.位置+1
		  		if self.位置==25 then self.位置=1 end
	     	end
	     	self.资源组[2]:更新(x,y)
	     	self.资源组[2]:显示(self.x+218,self.y+340)
	     	if self.资源组[2]:事件判断() then
	         	self.进程=1
	         	self.起始=时间
	     	end
		elseif self.进程==1 then
	  		self.间隔=self.间隔+1
	   		if self.间隔>=self.速度 then
	   	 		self.间隔=0
		  		self.位置=self.位置+1
		  		if self.位置==25 then self.位置=1 end
	     	end
	  		if 时间>=self.起始+3 then
	     		self.进程=2
	  	 	end
		elseif self.进程==2 then
	   		local 距离=math.abs(self.位置-self.中奖)
	   		if 距离>=15 then
	     		self.速度=10
	    	elseif 距离>=10 then
	     		self.速度=17
	    	elseif 距离>=5 then
	     		self.速度=25
	   	 	end
	   		self.间隔=self.间隔+1
	   		if self.间隔>=self.速度 then
	   	 		self.间隔=0
		  		self.位置=self.位置+1
		  		if self.位置==25 then self.位置=1 end
	     	end
	    	if self.位置==self.中奖 then
	    		self.进程=3
	    		self.起始=时间
	    	   请求服务(3755,{序号=self.中奖})
	    	end
	   	elseif self.进程==3 and 时间>=self.起始+1 then
	     	self:打开()
	     	return
	 	end
	 end
 	zts1:置颜色(白色)
 	zts1:显示(self.x+444,self.y+238,self.名称)
 	local xx=0
 	local yy=1
 	for n=1,24 do
     	local xx1=self.x + xx * 69+42
     	local yy1= self.y + yy * 71-25
      	self.商品[n].小动画:显示(xx1,yy1)
      	zts1:显示(xx1,yy1+53,self.商品[n].名称)
     	if self.位置==n then
          	self.资源组[3]:显示(xx1-3,yy1-2)
       	end
       	if self.商品[n].小动画:是否选中(x,y) then
            tp.提示:商城提示(self.x + xx * 54-14 ,self.y + yy * 51 + 15,self.商品[n].名称,self.商品[n].说明,self.商品[n].大动画,self.商品[n].备注)
        end
      	xx=xx+1
       	if xx==6 then
         	xx=0
         	yy=yy+1
     	end
 	end
end

function 神秘宝箱类:检查点(x,y)
	if self.可视 and self.资源组~=nil and self.资源组[1]:是否选中(x,y)  then
		return true
	else
		return false
	end
end

function 神秘宝箱类:初始移动(x,y)
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

function 神秘宝箱类:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end
return 神秘宝箱类