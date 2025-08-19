
local 嘉年抽奖 = class()
local tp,zts1
local insert = table.insert

function 嘉年抽奖:初始化(根)
	tp = 根
  self.ID = 154
	self.x = 200
	self.y = 100
	self.xx = 0
	self.yy = 0
	self.注释 = "嘉年抽奖"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
  self.窗口时间 = 0
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
  local 资源 = tp.资源
		self.资源组 = {
			    [1] = 资源:载入(wdf配置.."/pic/转盘.png","图片"),
	        [2] = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x01000052),
	        [3] = 资源:载入(wdf配置.."/pic/覆盖图.png","图片"),
          [4] = 资源:载入(wdf配置.."/pic/未领取.png","图片"),
		}
	zts1 = 根.字体表.赞助字体
	self.窗口时间 = 0
	self.剩余次数 = 0
	self.赞助字体= tp.字体表.赞助字体
  self.赞助字体:置颜色(0xFFFFFFFF)
  self.赞助字体:置描边颜色(0xfff741940)
  self.商品={}
end
function 嘉年抽奖:打开(内容)
  if self.可视 then
  		self.可视 = false
  		return
  	else
		insert(tp.窗口_,self)
     	tp.运行时间 = tp.运行时间 + 1
		  self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.商品={}
	    self.剩余次数 = 内容.次数
	    for n=1,8 do
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
function 嘉年抽奖:刷新(内容)
	self.商品={}
    self.剩余次数 = 内容.次数
    for n=1,8 do
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



function 嘉年抽奖:显示(dt,x,y)
  self.焦点 = false
 	self.资源组[1]:显示(self.x-30,self.y-40)
	self.资源组[3]:显示(self.x+180,self.y+135)
  self.资源组[4]:显示(self.x+310,self.y+380)
  if self.资源组[3]:是否选中(x,y) and 引擎.鼠标弹起(0)  then--鼠标上滚
      请求服务(62,{文本="抽奖一次"})
  elseif self.资源组[3]:是否选中(x,y) then
       tp.提示:自定义(x-42,y+27,"#Y点击抽奖每次消耗10点嘉年华积分")
  elseif self.资源组[4]:是否选中(x,y) and 引擎.鼠标弹起(0)  then--鼠标上滚
       self:打开()
  elseif self.资源组[4]:是否选中(x,y) then
       tp.提示:自定义(x-42,y+27,"#Y关闭抽奖")
  end
 	zts1:置颜色(黑色)
 	zts1:显示(self.x+235,self.y+377,self.剩余次数)
 	zts1:显示(self.x+240,self.y-5,"10")
 	for n=1,1 do
     	tp.物品格子背景_:显示(363,150)
      	self.商品[n].小动画:显示(363,150)
     	if self.位置==n then
          	self.资源组[2]:显示(363,150)
       	end
       	if self.商品[n].小动画:是否选中(x,y) then
            tp.提示:商城提示(x,y+20,self.商品[n].名称,self.商品[n].说明,self.商品[n].大动画,self.商品[n].备注)
        end
 	end
 	for n=2,2 do
     	tp.物品格子背景_:显示(453,150)
      	self.商品[n].小动画:显示(453,150)
     	if self.位置==n then
          	self.资源组[2]:显示(453,150)
       	end
       	if self.商品[n].小动画:是否选中(x,y) then
            tp.提示:商城提示(x,y+20,self.商品[n].名称,self.商品[n].说明,self.商品[n].大动画,self.商品[n].备注)
        end
 	end
 	for n=3,3 do
     	tp.物品格子背景_:显示(516,224)
      	self.商品[n].小动画:显示(516,224)
     	if self.位置==n then
          	self.资源组[2]:显示(516,224)
       	end
       	if self.商品[n].小动画:是否选中(x,y) then
            tp.提示:商城提示(x,y+20,self.商品[n].名称,self.商品[n].说明,self.商品[n].大动画,self.商品[n].备注)
        end
 	end
 	for n=4,4 do
     	tp.物品格子背景_:显示(516,307)
      	self.商品[n].小动画:显示(516,307)
     	if self.位置==n then
          	self.资源组[2]:显示(516,307)
       	end
       	if self.商品[n].小动画:是否选中(x,y) then
            tp.提示:商城提示(x,y+20,self.商品[n].名称,self.商品[n].说明,self.商品[n].大动画,self.商品[n].备注)
        end
 	end
  	for n=5,5 do
     	tp.物品格子背景_:显示(301,307)
      	self.商品[n].小动画:显示(301,307)
     	if self.位置==n then
          	self.资源组[2]:显示(301,307)
       	end
       	if self.商品[n].小动画:是否选中(x,y) then
            tp.提示:商城提示(x,y+20,self.商品[n].名称,self.商品[n].说明,self.商品[n].大动画,self.商品[n].备注)
        end
 	end
 	  	for n=6,6 do
     	tp.物品格子背景_:显示(301,224)
      	self.商品[n].小动画:显示(301,224)
     	if self.位置==n then
          	self.资源组[2]:显示(301,224)
       	end
       	if self.商品[n].小动画:是否选中(x,y) then
            tp.提示:商城提示(x,y+20,self.商品[n].名称,self.商品[n].说明,self.商品[n].大动画,self.商品[n].备注)
        end
 	end
 		  	for n=7,7 do
     	tp.物品格子背景_:显示(363,376)
      	self.商品[n].小动画:显示(363,376)
     	if self.位置==n then
          	self.资源组[2]:显示(363,376)
       	end
       	if self.商品[n].小动画:是否选中(x,y) then
            tp.提示:商城提示(x,y+20,self.商品[n].名称,self.商品[n].说明,self.商品[n].大动画,self.商品[n].备注)
        end
 	end
 	for n=8,8 do
     	tp.物品格子背景_:显示(453,376)
      	self.商品[n].小动画:显示(453,376)
     	if self.位置==n then
          	self.资源组[2]:显示(453,376)
       	end
       	if self.商品[n].小动画:是否选中(x,y) then
            tp.提示:商城提示(x,y+20,self.商品[n].名称,self.商品[n].说明,self.商品[n].大动画,self.商品[n].备注)
        end
 	end
end

function 嘉年抽奖:检查点(x,y)
	if self.可视 and self.资源组~=nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 嘉年抽奖:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = false
	end
	if self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 嘉年抽奖:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 嘉年抽奖