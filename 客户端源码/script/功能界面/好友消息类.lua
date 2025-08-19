--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:02:35
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 好友消息类 = class()
local tp,zts1,zts


function 好友消息类:初始化(根)
  self.ID = 57
	self.x = 全局游戏宽度/2-190
  self.y = 全局游戏高度/2-257
	self.xx = 0
	self.yy = 0
	self.注释 = "好友消息类"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true

	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
  local 滑块 = 根._滑块
  local 资源 = 根.资源
	self.资源组 = {
      [1] = 自适应.创建(0,1,380,515,3,9),
      [2] = 自适应.创建(1,1,376,18,1,3,nil,18),
      [3] = 自适应.创建(2,1,360,280,3,9),
      [4] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
      [5] = 自适应.创建(2,1,360,73,3,9),
      [6] = 滑块.创建(自适应.创建(11,4,7,40,2,3,nil),4,14,275,2),

	}

  self.等级背景 =自适应.创建(3,1,130,18,1,3)
  self.好友按钮 = 按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"加为好友")
  self.好友按钮:绑定窗口_(self.ID)
  self.好友按钮:置偏移(0,-1)
  self.历史按钮 = 按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"历史消息")
  self.历史按钮:绑定窗口_(self.ID)
  self.历史按钮:置偏移(0,-1)
  self.举报按钮 = 按钮.创建(自适应.创建(12,4,42,20,1,3),0,0,4,true,true,"举报")
  self.举报按钮:绑定窗口_(self.ID)
  self.举报按钮:置偏移(0,-1)
  self.表情开关 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x590CAA9B)
  self.表情开关.当前帧 = 2
  self.表情开关:更新纹理()
  self.颜色按钮 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x9D123E79),0,0,1,true)
  self.颜色按钮:绑定窗口_(self.ID)
  self.祝福按钮 = 按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"梦幻祝福")
  self.祝福按钮:绑定窗口_(self.ID)
  self.祝福按钮:置偏移(0,-1)
  self.说话按钮 = 按钮.创建(自适应.创建(12,4,140,20,1,3),0,0,4,true,true,"按住说话(Ctrl+Z)")
  self.说话按钮:绑定窗口_(self.ID)
  self.说话按钮:置偏移(13,-1)
  self.发送按钮 = 按钮.创建(自适应.创建(12,4,80,20,1,3),0,0,4,true,true,"发送")
  self.发送按钮:绑定窗口_(self.ID)
  self.发送按钮:置偏移(20,-1)





	tp = 根
  zts=tp.字体表.普通字体
  zts1 = tp.字体表.描边字体
	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('好友消息总控件')
	总控件:置可视(true,true)
  self.输入框={}
  for i=1,4 do
    self.输入框[i] = 总控件:创建输入("好友消息输入"..i,0,0,355,18)
    self.输入框[i]:置可视(false,false)
    self.输入框[i]:置限制字数(50)--230
    --self.输入框:置多行(true)
    self.输入框[i]:屏蔽快捷键(true)
    self.输入框[i]:置光标颜色(-16777216)
    self.输入框[i]:置文字颜色(-16777216)
  end
  self.颜色开始 = false
  self.颜色精灵 = require("gge精灵类")(0,0,0,12,12)
  self.颜色表 = {{"#R/",0xFFFF0000,"红色"},{"#C/",0xFFFF9932,"橙色"},{"#Y/",0xFFFFFF00,"黄色"},{"#G/",0xFF00FF00,"绿色"},{"#P/",0xFF00FFFF,"青色"},{"#B/",0xFF03A89E,"蓝色"},{"#F/",0xFFFF00FF,"紫色"},{"#W/",0xFFFFFFFF,"白色"}}
  self.颜色背景 = 根._自适应.创建(71,1,125,23,3,9)
  self.包围盒 = require("gge包围盒")(self.x,self.y,12,12)
  self.窗口时间 = 0
  self.加入=0
  self.结束=0

end

function 好友消息类:打开(数据)

  if self.可视 then
    self.可视=false
    self.加入=0
  self.结束=0
    for i=1,4 do
      self.输入框[i]:置可视(false,false)
    end
    请求服务(25.3)
    return
  else



      for i=1,4 do
        self.输入框[i]:置可视(true,true)
        self.输入框[i]:置文本("")
      end
      self.输入框[1]:置焦点(true)
      self:加载数据(数据)

      table.insert(tp.窗口_,self)
      tp.运行时间 = tp.运行时间 + 1
      self.窗口时间 = tp.运行时间
      self.可视 = true
  end

end

function 好友消息类:加载数据(数据)


  self.名称=数据.名称
  self.数字id=tonumber(数据.id)
  self.等级=数据.等级
  self.友好=数据.好友度 or 0
  self.是否好友=数据.是否好友
  self.显示数据={}
  self.整体高度 = 0
  -- self.资源组[6]:置起始点(100)
   请求服务(25.2,{id=self.数字id})
  if 数据.记录 then
    for i=1,#数据.记录 do
      self.显示数据[i]={}
      self.显示数据[i].时间=数据.记录[i].时间
      self.显示数据[i].时间显示=os.date("%H", 数据.记录[i].时间)..":"..os.date("%M", 数据.记录[i].时间)
      if os.date("%Y", os.time())==os.date("%Y", 数据.记录[i].时间) and os.date("%m", os.time())==os.date("%m", 数据.记录[i].时间) and os.date("%d", os.time())~=os.date("%d", 数据.记录[i].时间) then
          self.显示数据[i].时间显示=os.date("%d", 数据.记录[i].时间).."("..os.date("%H", 数据.记录[i].时间)..":"..os.date("%M", 数据.记录[i].时间)..")"
      elseif os.date("%Y", os.time())==os.date("%Y", 数据.记录[i].时间) and os.date("%m", os.time())~=os.date("%m", 数据.记录[i].时间) then
          self.显示数据[i].时间显示=os.date("%m", 数据.记录[i].时间).."-"..os.date("%d", 数据.记录[i].时间).."("..os.date("%H", 数据.记录[i].时间)..":"..os.date("%M", 数据.记录[i].时间)..")"
       elseif os.date("%Y", os.time())~=os.date("%Y", 数据.记录[i].时间) then
          self.显示数据[i].时间显示=os.date("%Y", 数据.记录[i].时间).."-"..os.date("%m", 数据.记录[i].时间).."-"..os.date("%d", 数据.记录[i].时间).."("..os.date("%H", 数据.记录[i].时间)..":"..os.date("%M", 数据.记录[i].时间)..")"
      end
      self.显示数据[i].id=数据.记录[i].id
      if 数据.记录[i].id == tp.队伍[1].数字id then
         self.显示数据[i].头像=tp.资源:载入(wdf配置.."/pic/聊天框/"..tp.队伍[1].模型..".png","图片")
      else
          self.显示数据[i].头像=tp.资源:载入(wdf配置.."/pic/聊天框/"..数据.模型..".png","图片")
      end
      self.显示数据[i].丰富文本=require("script/系统类/丰富文本")(310,20)
      self.显示数据[i].丰富文本:清空()
      for n=1,#数据.记录[i].内容 do
          if 数据.记录[i].内容[n]~=nil and 数据.记录[i].内容[n]~="" then
             self.显示数据[i].丰富文本:添加文本("#H/"..数据.记录[i].内容[n])
          end
      end
      self.显示数据[i].丰富文本:置宽度(self.显示数据[i].丰富文本.显示表.宽度)
      self.显示数据[i].丰富文本:置高度(self.显示数据[i].丰富文本.显示表.高度)
      self.显示数据[i].字体宽度=self.显示数据[i].丰富文本.显示表.宽度
      self.显示数据[i].字体高度=self.显示数据[i].丰富文本.显示表.高度+20
      if self.显示数据[i].字体高度<#数据.记录[i].内容*18 then
         self.显示数据[i].字体高度=#数据.记录[i].内容*18
      end
      if self.显示数据[i].字体高度<50 then
         self.显示数据[i].字体高度=50
      end

       self.整体高度 =  self.整体高度 + self.显示数据[i].字体高度

     -- self.显示数据[i].文本背景={}
    end
  end
  if #self.显示数据>0 then
      table.sort(self.显示数据,function(a,b) return a.时间<b.时间 end )
  end
  self.开始=0
  self.结束=#self.显示数据
  if self.结束>0 then
     self:计算显示("下")
  end






end
function 好友消息类:计算显示(类型)
    local 临时计算 =0
    if 类型=="上" then
        for i=self.开始,self.开始+4 do
          if self.显示数据[i] then
             临时计算=临时计算+self.显示数据[i].字体高度
              if  临时计算<275 then
                  self.结束 = i
              else
                  break
              end
          end
        end
    else
         for i=self.结束,self.结束-4,-1 do
             if self.显示数据[i] then
                  临时计算=临时计算+self.显示数据[i].字体高度
                  if  临时计算<275 then
                    self.开始 = i
                 else
                      break
                 end
            end
          end
    end

    if self.开始 > 2 and self.整体高度>275 then
       self.资源组[6]:置起始点(取百分比转换(self.开始,0,#self.显示数据))
    end





end

function 好友消息类:显示(dt,x,y)
  self.焦点=false
  self.资源组[4]:更新(x,y)
  self.资源组[1]:显示(self.x,self.y)
  self.资源组[2]:显示(self.x+2,self.y+2)
  self.资源组[3]:显示(self.x+10,self.y+85)
  self.资源组[4]:显示(self.x+360,self.y+2)
  tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
  zts1:置字间距(3)
  zts1:置颜色(白色):显示(self.x+self.资源组[1].宽度/2-30,self.y+1,"好友聊天")
  zts1:置字间距(0)


  zts:置颜色(白色):显示(self.x+10,self.y+35,"昵称")
  self.等级背景:显示(self.x+50,self.y+34)
  zts:置颜色(黑色):显示(self.x+55,self.y+37,self.名称)
  zts:置颜色(白色):显示(self.x+10,self.y+60,"I D")
  self.等级背景:显示(self.x+50,self.y+59)
  zts:置颜色(黑色):显示(self.x+55,self.y+62,self.数字id)

  zts:置颜色(白色):显示(self.x+200,self.y+35,"等级")
  self.等级背景:显示(self.x+240,self.y+34)
  zts:置颜色(黑色):显示(self.x+245,self.y+37,self.等级)

  zts:置颜色(白色):显示(self.x+200,self.y+60,"友好")
  self.等级背景:显示(self.x+240,self.y+59)
  zts:置颜色(黑色):显示(self.x+245,self.y+62,self.友好)

  self.好友按钮:更新(x,y,not self.是否好友)
  self.历史按钮:更新(x,y)
  self.举报按钮:更新(x,y)
  self.颜色按钮:更新(x,y)
  self.好友按钮:显示(self.x+10,self.y+375)
  self.历史按钮:显示(self.x+90,self.y+375)
  self.举报按钮:显示(self.x+280,self.y+375)
  self.颜色按钮:显示(self.x+330,self.y+375)
  self.表情开关:显示(self.x+345,self.y+400)
  self.祝福按钮:更新(x,y)
  self.说话按钮:更新(x,y)
  self.发送按钮:更新(x,y)
  self.祝福按钮:显示(self.x+10,self.y+485)
  self.说话按钮:显示(self.x+145,self.y+485)
  self.发送按钮:显示(self.x+290,self.y+485)
  self.资源组[5]:显示(self.x+10,self.y+405)
   if self.资源组[4]:事件判断() then
      self:打开()
   elseif self.颜色按钮:事件判断() then
      self.颜色开始 =  not self.颜色开始
   elseif self.发送按钮:事件判断() and self.数字id~=nil  then
      local 发送内容 ={}
      for i=1,4 do
        if self.输入框[i]:取文本()~=nil and self.输入框[i]:取文本()~="" then
            发送内容[#发送内容+1]=self.输入框[i]:取文本()
        end
      end
      if #发送内容<=0 or 发送内容==nil then
        tp.常规提示:打开("#Y您想说点什么给对方听呢？")
      else
          请求服务(24,{id=self.数字id,数据=发送内容})
          for i=1,4 do
            self.输入框[i]:置文本("")
          end
          self.输入框[1]:置焦点(true)
      end
    elseif self.好友按钮:事件判断() and self.数字id~=nil  then
          请求服务(19,{id=self.数字id})




    end
 -- local 最后碰撞 = 1
  for i=1,4 do
    self.输入框[i]:置坐标(self.x+15,self.y+389+i*18)
    if self.输入框[i]._输入焦点 then
       self.当前碰撞=i
    end
     if i~=1  then
        if string.len(self.输入框[i-1]:取文本())>=6 then
           self.输入框[i]:置限制字数(50)
        else
           self.输入框[i]:置限制字数(0)
        end
    end
  end

  if 引擎.按键按下(KEY.ENTER) and  string.len(self.输入框[self.当前碰撞]:取文本())>=6 then
         if self.当前碰撞==#self.输入框 then
            self.输入框[1]:置焦点(true)
         else
             self.输入框[self.当前碰撞+1]:置焦点(true)
         end
  elseif 引擎.按键按下(0x08) and (self.输入框[self.当前碰撞]:取文本()=="" or string.len(self.输入框[self.当前碰撞]:取文本())<=0) and  self.当前碰撞~=1  then
        self.输入框[self.当前碰撞-1]:置焦点(true)
  end




 if self.表情开关:是否选中(x,y)  then
    self.表情开关:更新(dt)
    tp.按钮焦点 = true
    if 引擎.鼠标弹起(左键) then
      tp.窗口.表情窗口:打开()--打开表情窗口
    end
  else
    if self.表情开关.当前帧 ~= 2 then
       self.表情开关.当前帧 = 2
       self.表情开关:更新纹理()
    end
  end


if self.颜色开始 then
   self.颜色背景:显示(self.x+252,self.y+394)
    for n=1,#self.颜色表 do
      self.颜色精灵:置颜色(self.颜色表[n][2])
      self.颜色精灵:显示(self.x+240+n*15,self.y+400)
      self.包围盒:置坐标(self.x+240+n*15,self.y+400)
      if self.包围盒:检查点(x,y) then
        tp.提示:自定义(x,y+25,string.format("#Y/%s",self.颜色表[n][3]))
        tp.按钮焦点 = true
        if 引擎.鼠标弹起(左键) then
           self:输入添加文本(self.颜色表[n][1])
           self.颜色开始 = false
           break
        end
      end
    end
  end
  local zx = 0
  local 上次显示 = 0
  for i=self.开始,self.结束 do
      if self.显示数据[i]  then
             zx =zx + 1
             local 时间长度=(string.len(self.显示数据[i].时间显示)*7)/2
             local 显示Y=33+zx*55
             if i-self.开始>=1  then
                  显示Y=显示Y+上次显示
             end
             if self.显示数据[i].字体高度>55 then
                上次显示=上次显示+self.显示数据[i].字体高度-55
             end
             zts:置颜色(红色):显示(self.x+10+self.资源组[3].宽度/2-时间长度,self.y+显示Y,self.显示数据[i].时间显示)
             if self.显示数据[i].id == tp.队伍[1].数字id then
                self.显示数据[i].丰富文本:显示(self.x+self.资源组[3].宽度-36-self.显示数据[i].字体宽度,self.y+显示Y+17)
                self.显示数据[i].头像:显示(self.x+self.资源组[3].宽度-30,self.y+显示Y+17)
             else
                self.显示数据[i].丰富文本:显示(self.x+50,self.y+显示Y+17)
                 self.显示数据[i].头像:显示(self.x+15,self.y+显示Y+17)
             end
      end
  end



  if self.整体高度>275 then
      self.资源组[6]:显示(self.x+361,self.y+87,x,y,self.鼠标)
      if self.资源组[3]:是否选中(x,y) and 引擎.取鼠标滚轮() ==1 and self.开始 > 1 then
              self.开始=self.开始-1
              self:计算显示("上")
      elseif self.资源组[3]:是否选中(x,y) and 引擎.取鼠标滚轮() ==-1 and self.结束 < #self.显示数据 then
             self.结束=self.结束+1
             self:计算显示("下")
      end
  end



  self.控件类:更新(dt,x,y)
  self.控件类:显示(x,y)

    for i=1,4 do
        if self.输入框[i]._已碰撞  then
            self.焦点 = true
        end
    end
end

function 好友消息类:输入添加文本(文本)
  if self.当前碰撞==nil then self.当前碰撞=1 end

if self.输入框[self.当前碰撞+1] and string.len(self.输入框[self.当前碰撞]:取文本())>=48 then
   if  string.len(文本)<=2 then
       self.输入框[self.当前碰撞]:添加文本(文本)
       self.当前碰撞=self.当前碰撞+1
    else
       self.当前碰撞=self.当前碰撞+1
       self.输入框[self.当前碰撞]:添加文本(文本)
    end
elseif string.len(self.输入框[self.当前碰撞]:取文本())<48 then
     self.输入框[self.当前碰撞]:添加文本(文本)
end

     self.输入框[self.当前碰撞]:置焦点(true)



end

function 好友消息类:检查点(x,y)
  if self.可视 and self.资源组~=nil and self.资源组[1]:是否选中(x,y)  then
    return true
  end
end

function 好友消息类:初始移动(x,y)
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

function 好友消息类:开始移动(x,y)
  if self.鼠标 then
    self.x = x - self.xx
    self.y = y - self.yy
  end
end

return 好友消息类