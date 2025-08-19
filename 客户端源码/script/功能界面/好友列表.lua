--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:02:35
--======================================================================--
local 场景类_好友列表 = class()
local floor = math.floor
local tp,zts,zts1
local insert = table.insert

function 场景类_好友列表:初始化(根)
	self.ID = 34
	self.x = 全局游戏宽度-240
	self.y = 10
	self.xx = 0
	self.yy = 0
	self.注释 = "好友列表"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
  self.焦点1 = false
	self.可移动 = true
	self.窗口时间 = 0
	tp = 根
	zts = tp.字体表.普通字体
	zts1 = tp.字体表.描边字体
  self.精灵包围盒=require("gge包围盒")(self.x,self.y,185,40)
  self.自己围盒=require("gge包围盒")(self.x,self.y,185,40)
  self.名称盒子= require("gge包围盒")(self.x,self.y,180,40)
  self.空白包围盒  = require("gge包围盒")(self.x,self.y,0,0)
  local 资源 = tp.资源
  local 按钮 = tp._按钮
  local 自适应 = tp._自适应
  self.资源组 = {
      [1] =自适应.创建(0,1,230,580,3,9),
      [2] = 自适应.创建(1,1,226,18,1,3,nil,18),
      [3] = 自适应.创建(2,1,210,485,3,9),
      [4] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
      [5] =  tp._滑块.创建(自适应.创建(11,4,7,40,2,3,nil),4,14,475,2),
    }
  self.消息按钮=按钮.创建(自适应.创建(12,4,65,20,1,3),0,0,4,true,true," 消息")
  self.好友按钮=按钮.创建(自适应.创建(12,4,65,20,1,3),0,0,4,true,true," 好友")
  self.群友按钮=按钮.创建(自适应.创建(12,4,65,20,1,3),0,0,4,true,true,"  群")
  self.消息按钮:绑定窗口_(self.ID)
  self.好友按钮:绑定窗口_(self.ID)
  self.群友按钮:绑定窗口_(self.ID)
  self.消息按钮:置偏移(3,-2)
  self.好友按钮:置偏移(3,-2)
  self.群友按钮:置偏移(3,-2)


  self.右边 = 资源:载入(wdf配置.."/pic/聊天框/右.png","图片")
  self.下边 = 资源:载入(wdf配置.."/pic/聊天框/下.png","图片")
  self.梦幻头像 = 资源:载入(wdf配置.."/pic/聊天框/梦幻头像.png","图片")
  self.系统头像 = 资源:载入(wdf配置.."/pic/聊天框/系统头像.png","图片")
  self.房子 = 资源:载入(wdf配置.."/pic/聊天框/小房子.png","图片")
  self.名片 = 资源:载入(wdf配置.."/pic/聊天框/名片.png","图片")
  self.圆 = 资源:载入(wdf配置.."/pic/聊天框/圆.png","图片")
  self.加号 = 资源:载入(wdf配置.."/pic/聊天框/加号.png","图片")
  self.放大镜= 资源:载入(wdf配置.."/pic/聊天框/放大镜.png","图片")
  self.CC= 资源:载入(wdf配置.."/pic/聊天框/CC.png","图片")
  self.红包= 资源:载入(wdf配置.."/pic/聊天框/红包.png","图片")
  self.功能= 资源:载入(wdf配置.."/pic/聊天框/功能.png","图片")
  self.设置= 资源:载入(wdf配置.."/pic/聊天框/设置.png","图片")
   self.分组包围盒 ={}



  self.在线={}
  self.好友={}
  self.临时={}
  self.分组={}
  self.黑名单={}
  self.显示数据={}
  self.选中编号=0
  self.加入=0
  self.结束=0
  self.当前类型=""
  self.状态 = "好友"



end

function 场景类_好友列表:打开(内容)
	if self.可视 then
		self.可视 = false
    self.在线={}
    self.好友={}
    self.临时={}
    self.分组={}
    self.黑名单={}
    self.显示数据={}
    self.选中编号=0
    self.排序行数=0
    self.加入=0
    self.结束=0
    self.当前类型=""
     self.状态 = "好友"
    return
	else
    insert(tp.窗口_,self)
    self.资源组[5]:置起始点(0)
    self.头像组 = {}
    self.好友={}
    self.临时={}
    self.分组={}
    self.黑名单={}
    self.分组包围盒={}
    self.显示数据={}
    tp.运行时间 = tp.运行时间 + 1
    self.窗口时间 = tp.运行时间
    self.可视 = true
    self.当前类型=""
    self.选中编号=0
    self.加入=0
    self.结束=0
    self.显示数据={}
    self.状态 = "好友"
    if 内容.在线 then
      self.在线=内容.在线
    end
    if 内容.好友 then
      self.好友=内容.好友
    end
    if 内容.临时 then
      self.临时=内容.临时
    end
    if 内容.分组 then
      self.分组=内容.分组
    end
    if 内容.黑名单 then
       self.黑名单=内容.黑名单
    end
    self.自己头像 = tp.资源:载入(wdf配置.."/pic/聊天框/"..tp.队伍[1].模型..".png","图片")
    self.空白包围盒:置宽高(198,340-(#self.分组+2)*20)
    for i=1,#self.分组+3 do
      self.分组包围盒[i]  = require("gge包围盒")(self.x,self.y,185,20)
    end







    -- 内容={在线=self.在线好友,临时=self.临时好友,好友=self.数据.好友,黑名单=self.数据.黑名单,分组=self.数据.分组}


	end
end


function 场景类_好友列表:更新数据(内容)
    self.在线={}
    self.好友={}
    self.临时={}
    self.分组={}
    self.黑名单={}
    self.分组包围盒={}
    self.显示数据={}
    if 内容.在线 then
      self.在线=内容.在线
    end
    if 内容.好友 then
      self.好友=内容.好友
    end
    if 内容.临时 then
      self.临时=内容.临时
    end
    if 内容.分组 then
      self.分组=内容.分组
    end
    if 内容.黑名单 then
       self.黑名单=内容.黑名单
    end
    if self.当前类型~="" and self.选中编号~=0 and self.状态 == "好友" then
       self:更新显示()
    end
    for i=1,#self.分组+3 do
      self.分组包围盒[i]  = require("gge包围盒")(self.x,self.y,185,20)
    end


end




function 场景类_好友列表:显示(dt,x,y)
  self.焦点 = false
  self.焦点1 = false
  self.资源组[1]:显示(self.x,self.y)
  self.资源组[2]:显示(self.x+2,self.y+2)
  zts1:置字间距(3)
  zts1:置颜色(白色):显示(self.x+self.资源组[1].宽度/2-58,self.y+1,"好友列表")
  zts1:置字间距(0)
  self.资源组[4]:更新(x,y)
  self.资源组[4]:显示(self.x+210,self.y+2)
  self.资源组[3]:显示(self.x+10,self.y+60)
  self.消息按钮:更新(x,y)
  self.好友按钮:更新(x,y)
  self.群友按钮:更新(x,y)
  self.消息按钮:显示(self.x+10,self.y+30,nil,nil,nil,self.状态 == "消息",2)
  self.好友按钮:显示(self.x+80,self.y+30,nil,nil,nil,self.状态 == "好友",2)
  self.群友按钮:显示(self.x+150,self.y+30)


  self.加号:显示(self.x+20,self.y+550)
  self.放大镜:显示(self.x+45,self.y+550)
  引擎.画线(self.x+77,self.y+552,self.x+77,self.y+568,0xFFFFFFFF)
  self.CC:显示(self.x+90,self.y+550)
  self.红包:显示(self.x+115,self.y+550)
  self.功能:显示(self.x+140,self.y+550)
  引擎.画线(self.x+175,self.y+552,self.x+175,self.y+568,0xFFFFFFFF)
  self.设置:显示(self.x+190,self.y+550)



  self.精灵包围盒:置坐标(self.x+22,self.y+65)
  self.自己围盒:置坐标(self.x+22,self.y+105)
  self.梦幻头像:显示(self.x+24,self.y+69)
  zts:置颜色(紫色):显示(self.x+57,self.y+70,"梦幻精灵")





  if self.精灵包围盒:检查点(x,y) then
        self.焦点1 = true
        引擎.画矩形(self.x+15,self.y+63,self.x+210,self.y+105,-1677721856)
  elseif self.自己围盒:检查点(x,y) then

        self.焦点1 = true
        引擎.画矩形(self.x+15,self.y+103,self.x+210,self.y+143,-1677721856)
  elseif self.资源组[4]:事件判断() then
    self:打开()
    return false
  elseif self.消息按钮:事件判断() then
      self.当前类型=""
      self.选中编号=0
      self.加入=0
      self.结束=0
      self.显示数据={}
      self.空白包围盒:置宽高(198,340-(#self.分组+2)*20)
      self.状态="消息"
  elseif self.好友按钮:事件判断() then
      self.当前类型=""
      self.选中编号=0
      self.加入=0
      self.结束=0
      self.显示数据={}
      self.空白包围盒:置宽高(0,0)
      self.状态="好友"
  elseif (self.加号:是否选中(x,y) or self.放大镜:是否选中(x,y)) and 引擎.鼠标弹起(左键) then
         tp.窗口.好友查找:打开()
  end

  if self.状态=="消息" then
      self.系统头像:显示(self.x+24,self.y+109)
      zts:置颜色(紫色):显示(self.x+57,self.y+110,"系统消息")
  else
      self.房子:显示(self.x+57,self.y+86)
      self.名片:显示(self.x+77,self.y+86)
      if self.自己头像 then
        self.自己头像:显示(self.x+24,self.y+109)
      end
      zts:置颜色(黑色):显示(self.x+57,self.y+110,tp.队伍[1].名称)
      self.房子:显示(self.x+57,self.y+126)
      self.圆:显示(self.x+77,self.y+126)



      for i=1,#self.分组+3 do
          local 显示Y= self.y+130+i*20
          local 当前显示Y = 0
          if  i>self.选中编号 then
              当前显示Y =130+i*20+(#self.显示数据-self.加入)*40
              显示Y= self.y+当前显示Y
          end
          local 是否显示= true
          if self.选中编号 and self.选中编号~=0 and i>self.选中编号 and (self.结束-(#self.显示数据-self.加入))*2+self.选中编号<i then
             是否显示 =false
          end
           if 是否显示 then
                if self.选中编号~=0 and self.选中编号 == i then
                   引擎.画矩形(self.x+15,显示Y-7,self.x+210,显示Y+13,1677721855)
                    self.下边:显示(self.x+20,显示Y)
                else
                    self.右边:显示(self.x+22,显示Y-2)
                end
                self.分组包围盒[i]:置坐标(self.x+22,显示Y-5)
                if i==1 then
                      zts:置颜色(黑色):显示(self.x+30,显示Y-5,"所有在线好友")
                      zts:置颜色(黑色):显示(self.x+114,显示Y-5,"("..self:取数量(self.在线)..")")
                   elseif i==#self.分组+2 then
                      zts:置颜色(黑色):显示(self.x+30,显示Y-5,"临时好友")
                      zts:置颜色(黑色):显示(self.x+86,显示Y-5,"("..self:取数量(self.临时)..")")
                    elseif i==#self.分组+3 then
                      zts:置颜色(黑色):显示(self.x+30,显示Y-5,"屏蔽名单")
                      zts:置颜色(黑色):显示(self.x+86,显示Y-5,"("..self:取数量(self.黑名单)..")")
                    else
                        if self.分组[i-1] then
                          zts:置颜色(黑色):显示(self.x+30,显示Y-5,self.分组[i-1].名称)
                          zts:置颜色(黑色):显示(self.x+30+string.len(tostring(self.分组[i-1].名称))*7,显示Y-5,"("..self:取在线(i-1).."/"..self:取数量(self.分组[i-1].好友)..")")
                        end
                end
                if self.分组包围盒[i]:检查点(x,y) then
                     self.焦点1 = true
                     self.焦点 = true
                     引擎.画矩形(self.x+15,显示Y-7,self.x+210,显示Y+13,-1677721856)
                     if 引擎.鼠标弹起(左键) then
                        self:打开好友(i)
                     elseif i>=2 and i<=#self.分组+1 and 引擎.鼠标弹起(右键) then
                         tp.窗口.组合输入框:打开("修改分组名称",{"请输入该分组名称，点击确认修改分组名称",白色,i-1})
                     end
                end
          end
      end
       if self.当前类型~="" and self.选中编号~=0 then
          self:好友显示(x,y)
       else
          self.空白包围盒:置坐标(self.x+22,self.y+165+(#self.分组+2)*20+(#self.显示数据-self.加入)*40)
           if  self.空白包围盒:检查点(x,y) and #self.分组<10 and 引擎.鼠标弹起(右键) then
                  self.焦点1 = true
                  local 事件 = function()
                    请求服务(17.1)
                  end
                  tp.窗口.文本栏:载入("你确定创建新的分组么",nil,true,事件)
           end
       end



    end




end


function 场景类_好友列表:打开好友(编号)

  local 类型=""
  if 编号==1 then
      类型="在线"
  elseif 编号==#self.分组+2 then
        类型="临时"
  elseif 编号==#self.分组+3 then
        类型="黑名单"
  else
      if self.分组[编号-1] then
         类型="分组"
      end
  end

  if 类型=="" then
       self.当前类型 = ""
       self.选中编号=0
       self.加入=0
       self.结束=0
       self.显示数据={}
       self.空白包围盒:置宽高(198,340-(#self.分组+2)*20)
  else
      if self.选中编号==编号 then
          self.当前类型=""
          self.选中编号=0
          self.加入=0
          self.结束=0
          self.显示数据={}
          self.空白包围盒:置宽高(198,340-(#self.分组+2)*20)
      else
          self.选中编号=编号
          self.当前类型=类型
          self.加入=0
          self.结束=math.ceil((380-self.选中编号*20)/40)
          self:更新显示()
          self.空白包围盒:置宽高(0,0)




      end
  end
end


function 场景类_好友列表:更新显示()
      self.显示数据={}
      if self.当前类型=="分组" then
         local 在线好友={}
         local 不在好友={}
          for k,v in pairs(self.分组[self.选中编号-1].好友) do
                if self.在线[k] then
                     在线好友[#在线好友+1]= {id=k,数据=self.好友[k],在线=true,好友度=self.好友[k].好友度 or 0,头像=tp.资源:载入(wdf配置.."/pic/聊天框/"..self.好友[k].模型..".png","图片"),房子=tp.资源:载入(wdf配置.."/pic/聊天框/小房子.png","图片")}
                else
                  if self.好友[k] then
                     不在好友[#不在好友+1]= {id=k,数据=self.好友[k],在线=false,好友度=self.好友[k].好友度 or 0,头像=tp.资源:载入(wdf配置.."/pic/聊天框/"..self.好友[k].模型..".png","图片"),房子=tp.资源:载入(wdf配置.."/pic/聊天框/小房子.png","图片")}
                  end
                end
           end
           if #在线好友>0 then
              table.sort(在线好友,function(a,b) return a.好友度>b.好友度 end )
           end
           if #不在好友>0 then
              table.sort(不在好友,function(a,b) return a.好友度>b.好友度 end )
           end
           if #在线好友>0 or #不在好友>0 then
              for i=1,#在线好友 do
                self.显示数据[#self.显示数据+1] =在线好友[i]
              end
              for i=1,#不在好友 do
                self.显示数据[#self.显示数据+1] =不在好友[i]
              end
           end

      elseif self.当前类型=="临时" then
          for k,v in pairs(self.临时) do
            if self.临时[k] then
              self.显示数据[#self.显示数据+1] = {id=k,数据=v,在线=v.在线,好友度= 0,头像=tp.资源:载入(wdf配置.."/pic/聊天框/"..v.模型..".png","图片"),房子=tp.资源:载入(wdf配置.."/pic/聊天框/小房子.png","图片")}
            end
          end
           table.sort(self.显示数据,function(a,b) return a.在线>b.在线 end )
      elseif self.当前类型=="黑名单" then
            for k,v in pairs(self.黑名单) do
                self.显示数据[#self.显示数据+1] = {id=k,数据=v,在线=false,好友度= 0,头像=tp.资源:载入(wdf配置.."/pic/聊天框/"..v.模型..".png","图片"),房子=tp.资源:载入(wdf配置.."/pic/聊天框/小房子.png","图片")}

            end
      else
           for k,v in pairs(self.在线) do
              if self.好友[k]  then
                 self.显示数据[#self.显示数据+1] = {id=k,数据=self.好友[k],在线=true,好友度= self.好友[k].好友度 or 0,头像=tp.资源:载入(wdf配置.."/pic/聊天框/"..self.好友[k].模型..".png","图片"),房子=tp.资源:载入(wdf配置.."/pic/聊天框/小房子.png","图片")}
              end
           end
           table.sort(self.显示数据,function(a,b) return a.好友度>b.好友度 end )

     end
     for i=1,#self.显示数据 do
        if not self.显示数据[i].在线 then
           self.显示数据[i].头像:灰度级()
        end
     end
     self.资源组[5]:置起始点(0)
end





function 场景类_好友列表:好友显示(x,y)
  if #self.显示数据>self.结束 then
      local 总行= #self.显示数据+math.ceil((#self.分组+3-self.选中编号)/2)
      self.资源组[5]:显示(self.x+211,self.y+60,x,y,self.鼠标)
      self.加入 = math.min(math.ceil((总行-self.结束)*self.资源组[5]:取百分比()),总行-self.结束)
      if  self.资源组[3]:是否选中(x,y) and 引擎.取鼠标滚轮() ==1 and self.加入 > 0 then
          self.资源组[5]:置起始点(self.资源组[5]:取百分比转换(self.加入-1,self.结束,总行))
      elseif self.资源组[3]:是否选中(x,y) and 引擎.取鼠标滚轮() ==-1 and self.加入 < 总行 - self.结束 then
          self.资源组[5]:置起始点(self.资源组[5]:取百分比转换(self.加入+1,self.结束,总行))
      end
  end




        local XX = 1
        for n=1,self.结束 do
            if self.显示数据[n+self.加入]~=nil then
                local zx,zy = self.x+30,self.y+XX*40+105+self.选中编号*20
                if  not self.显示数据[n+self.加入].在线 then
                    zts:置颜色(黑色):显示(zx+33,zy+3,self.显示数据[n+self.加入].数据.名称)
                else
                   if self.显示数据[n+self.加入].好友度>=10 then
                       zts:置颜色(绿色):显示(zx+33,zy+3,self.显示数据[n+self.加入].数据.名称)
                    else
                       zts:置颜色(黑色):显示(zx+33,zy+3,self.显示数据[n+self.加入].数据.名称)
                    end
                end
                self.显示数据[n+self.加入].头像:显示(zx,zy+3)
                self.显示数据[n+self.加入].房子:显示(zx+33,zy+19)
                self.名称盒子:置坐标(zx,zy)
                if self.名称盒子:检查点(x,y)  and not self.焦点 then
                   self.焦点1 = true
                     if 引擎.鼠标弹起(左键) then
                        请求服务(25,{数据=self.显示数据[n+self.加入].数据})
                      elseif 引擎.鼠标弹起(右键) then
                        tp.窗口.好友查看:打开(self.显示数据[n+self.加入].数据,self.分组)
                      end
                    引擎.画矩形(zx-2,zy-2,zx+180,zy+40,-1677721856)
                end

               XX= XX+1
            end
       end

end


function 场景类_好友列表:取数量(类型)
  local 在线=0
  for k,v in pairs(类型) do
      if 类型[k] then
         在线= 在线 + 1
      end
  end
  return 在线
end

function 场景类_好友列表:取在线(编号)
  local 在线=0
  if self.分组[编号] then
     for k,v in pairs(self.分组[编号].好友) do
         if self.在线[k] and self.分组[编号].好友[k] then
            在线= 在线 + 1
         end
     end
  end
    return 在线
end





function 场景类_好友列表:检查点(x,y)
	if self.可视 and self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
  else
    return false
	end
end

function 场景类_好友列表:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if self.可视 and self.鼠标 and not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_好友列表:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_好友列表