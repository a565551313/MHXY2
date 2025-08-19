--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:02:35
--======================================================================--
local 好友查看类 = class()

local floor = math.floor
local tp,zts,zts1
local insert = table.insert

function 好友查看类:初始化(根)
  self.ID = 58
  self.x = 全局游戏宽度/2-190
  self.y = 全局游戏高度/2-170
  self.xx = 0
  self.yy = 0
  self.注释 = "好友查看类"
  self.可视 = false
  self.鼠标 = false
  self.焦点 = false
  self.可移动 = true
  self.窗口时间 = 0
  tp = 根

  local 资源 = tp.资源
  local 按钮 = tp._按钮
  local 自适应 = tp._自适应
  self.资源组 = {
      [1] = 自适应.创建(0,1,380,360,3,9),
      [2] = 自适应.创建(1,1,376,18,1,3,nil,18),
      [3] = 自适应.创建(2,1,130,115,3,9),
      [4] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
      [5] =自适应.创建(3,1,150,18,1,3)

    }
  self.按钮组 ={
      [1] =按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"  断交"),
      [2] =按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"  历史"),
      [3] =按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"  分组"),
      [4] =按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"  私聊"),
      [5] =按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"  成就"),
      [6] =按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"  组队"),
      [7] =按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"  交易"),
      [8] =按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"  给予"),


}
self.备注背景=自适应.创建(3,1,115,18,1,3)
self.评价背景 = 自适应.创建(2,1,115,50,3,9)
for i=1,#self.按钮组 do
  self.按钮组[i]:绑定窗口_(self.ID)
  self.按钮组[i]:置偏移(1,-1)
end
  self.属性内容={"名称","数字ID","等级","门派","曾用名","帮派","称号","关系","好友度"}
  self.字体显示={"名  称","数字ID","等  级","门  派","曾用名","帮  派","称  谓","关  系","好友度"}


  zts = tp.字体表.普通字体
  zts1 = tp.字体表.描边字体




end

function 好友查看类:打开(内容,分组)
  if self.可视 then
    self.可视 = false
    self.显示数据={}
    self.分组={[1]={名称="自定义分组1",好友={}}}
    return
  else

    self.显示数据={}
    self.分组={[1]={名称="自定义分组1",好友={}}}
    if 内容 then
      self.显示数据=内容
    end
    if 分组 then
      self.分组=分组
    end
    local z = 引擎.取头像(tp.队伍[1].模型)
    if self.显示数据.模型 then
       z = 引擎.取头像(self.显示数据.模型)
    end
    self.人物头像 = tp.资源:载入(z[7],"网易WDF动画",z[3])
    insert(tp.窗口_,self)
    tp.运行时间 = tp.运行时间 + 1
    self.窗口时间 = tp.运行时间
    self.可视 = true
  end
end

function 好友查看类:显示(dt,x,y)
    self.焦点 = false
    self.资源组[1]:显示(self.x,self.y)
    self.资源组[2]:显示(self.x+2,self.y+2)
    tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
    zts1:置字间距(3)
    zts1:置颜色(白色):显示(self.x+self.资源组[1].宽度/2-30,self.y+1,"好友属性")
    zts1:置字间距(0)
    self.资源组[4]:更新(x,y)
    self.资源组[4]:显示(self.x+360,self.y+2)
    self.资源组[3]:显示(self.x+15,self.y+30)
    if self.人物头像 then
       self.人物头像:显示(self.x+15,self.y+30)
    end

    for i=1,#self.字体显示 do
       zts:置颜色(白色):显示(self.x+160,self.y+6+i*29,self.字体显示[i])
       self.资源组[5]:显示(self.x+210,self.y+5+i*29)
       if self.显示数据[self.属性内容[i]] then
          zts:置颜色(黑色):显示(self.x+215,self.y+7+i*29,self.显示数据[self.属性内容[i]])
       end
    end

    zts:置颜色(白色):显示(self.x+15,self.y+148,"好友备注")
    self.备注背景:显示(self.x+15,self.y+166)
    zts:置颜色(白色):显示(self.x+15,self.y+190,"好友评价")
    self.评价背景:显示(self.x+15,self.y+230)



    local zx = 0
    local zy = 0
    for i=1,#self.按钮组 do
      self.按钮组[i]:更新(x,y)
      self.按钮组[i]:显示(self.x+15+zx*89,self.y+300+zy*30)
      zx=zx+1
      if zx>=4 then
        zx = 0
        zy = zy + 1
      end
    end
    if self.资源组[4]:事件判断() then
      self:打开()
      return
    elseif self.按钮组[1]:事件判断() and self.显示数据 and self.显示数据.数字ID then
        请求服务(20,{id=self.显示数据.数字ID})
    elseif self.按钮组[3]:事件判断() and self.显示数据 and self.显示数据.数字ID then
        请求服务(21,{id=self.显示数据.数字ID})


    end



      -- if  self.资源组[20]:事件判断() then
      --   self.信息开关=false
      -- elseif  self.资源组[16]:事件判断() then
      --   请求服务(20,{类型=self.当前类型,序列=self.显示信息.序列})
      -- elseif  self.资源组[17]:事件判断() then
      --   请求服务(21,{id=self.显示信息.id})
      -- elseif  self.资源组[18]:事件判断() then
      --   请求服务(23,{id=self.显示信息.id,类型=self.当前类型})
      -- elseif  self.资源组[19]:事件判断() then
      --   请求服务(22,{id=self.显示信息.id})
      -- end
      -- zts:置颜色(黑色)
      -- zts:显示(self.x+572,self.y+190,self.显示信息.名称)
      -- zts:显示(self.x+572,self.y+214,self.显示信息.id)
      -- zts:显示(self.x+572,self.y+238,self.显示信息.等级)
      -- zts:显示(self.x+572,self.y+262,self.显示信息.门派)
      -- zts:显示(self.x+572,self.y+286,"无")
      -- if self.显示信息.帮派==nil then
      --   zts:显示(self.x+420,self.y+320,"无")
      -- else
      --   zts:显示(self.x+420,self.y+320,self.显示信息.帮派)
      -- end
      -- if self.显示信息.称谓==nil then
      --   zts:显示(self.x+420,self.y+344,"无")
      -- else
      --   zts:显示(self.x+420,self.y+344,self.显示信息.称谓)
      -- end
      -- zts:显示(self.x+625,self.y+319,self.显示信息.关系)
      -- if self.显示信息.好友度==nil then
      --   zts:显示(self.x+630,self.y+344,"0")
      -- else
      --   zts:显示(self.x+630,self.y+344,self.显示信息.好友度)
      -- end


end



function 好友查看类:检查点(x,y)
  if self.可视 and self.资源组~=nil and self.资源组[1]:是否选中(x,y)  then
    return true
  end
end

function 好友查看类:初始移动(x,y)
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

function 好友查看类:开始移动(x,y)
  if self.鼠标 then
    self.x = x - self.xx
    self.y = y - self.yy
  end
end

return 好友查看类