--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:02:35-
--======================================================================--
local 八卦阵升级界面 = class()

local floor = math.floor
local tp,zts,zts1
local insert = table.insert

function 八卦阵升级界面:初始化(根)
  self.ID = 58
  self.x = 400
  self.y = 300
  self.xx = 0
  self.yy = 0
  self.注释 = "八卦阵升级界面"
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
      [1] = 自适应.创建(0,1,380,300,3,9),--窗口大小
      [2] = 自适应.创建(1,1,376,18,1,3,nil,18),--不知道
      [3] = 自适应.创建(2,1,130,250,3,9),--介绍框
      [4] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
      [5] = 自适应.创建(3,1,75,18,1,3)--数值底框

    }
  self.按钮组 ={
      [1] =按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"升级伤害"),
      [2] =按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"升级法伤"),
      [3] =按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"升级固伤"),
      [4] =按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"升级兽伤"),
      [5] =按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"升级防御"),
      [6] =按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"升级法防"),
      [7] =按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"升级速度"),
}

for i=1,#self.按钮组 do
  self.按钮组[i]:绑定窗口_(self.ID)
  self.按钮组[i]:置偏移(1,-1)
end
  self.属性内容={"等级","伤害","法伤","固伤","召唤兽伤害","防御","法防","速度"}
  self.字体显示={"等级","伤害","法伤","固伤","宝宝","防御","法防","速度"}


  zts = tp.字体表.普通字体
  zts1 = tp.字体表.描边字体
  
  -- 颜色定义
  白色 = 0xFFFFFFFF
  黑色 = 0xFF000000
  灰色 = 0xFF808080
  黄色 = 0xFFFFFF00
end



function 八卦阵升级界面:显示(dt,x,y)
    self.焦点 = false
    self.资源组[1]:显示(self.x,self.y)
    self.资源组[2]:显示(self.x+2,self.y+2)
    tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
    zts1:置字间距(3)
    zts1:置颜色(白色):显示(self.x+self.资源组[1].宽度/2-30,self.y+1,"八卦阵升级")
    zts1:置字间距(0)
    self.资源组[4]:更新(x,y)
    self.资源组[4]:显示(self.x+360,self.y+2)
    self.资源组[3]:显示(self.x+15,self.y+30)

    -- 显示八卦阵属性
    -- 先处理数据，将服务端数据转换为本地格式
    local 八卦阵数据 = {}
    if self.显示数据 then
        for 序号, 属性配置 in pairs(self.显示数据) do
            八卦阵数据[self.属性内容[序号]] = 属性配置.数值
        end
    end
    
    for i=1,#self.字体显示 do
       zts:置颜色(白色):显示(self.x+160,self.y+6+i*29,self.字体显示[i])
       self.资源组[5]:显示(self.x+210,self.y+5+i*29)
       
       if 八卦阵数据[self.属性内容[i]] then
          local 显示值 = tostring(八卦阵数据[self.属性内容[i]])
          -- 等级不加%，其他属性加%
          if self.属性内容[i] == "等级" then
             zts:置颜色(黑色):显示(self.x+215,self.y+7+i*29,显示值)
          else
             zts:置颜色(黑色):显示(self.x+215,self.y+7+i*29,显示值 .. "%")
          end
       else
          local 显示值 = "0"
          -- 等级不加%，其他属性加%
          if self.属性内容[i] == "等级" then
             zts:置颜色(灰色):显示(self.x+215,self.y+7+i*29,显示值)
          else
             zts:置颜色(灰色):显示(self.x+215,self.y+7+i*29,显示值 .. "%")
          end
       end
    end

    -- 显示升级说明
    zts:置颜色(黄色):显示(self.x+20,self.y+35,"升级说明：")
    zts:置颜色(灰色):显示(self.x+20,self.y+55,"使用阵眼道具可提升\n八卦阵属性")
    zts:置颜色(灰色):显示(self.x+20,self.y+95,"每次升级消耗对应阵\n眼，属性+5%")
    zts:置颜色(灰色):显示(self.x+20,self.y+135,"天阵眼：可提升伤害")
    zts:置颜色(灰色):显示(self.x+20,self.y+155,"地阵眼：可提升防御\n及法防")
    zts:置颜色(灰色):显示(self.x+20,self.y+195,"风阵眼：可提升速度")
    zts:置颜色(灰色):显示(self.x+20,self.y+215,"雷阵眼：可提升召唤\n兽伤害及固伤")
    zts:置颜色(灰色):显示(self.x+20,self.y+255,"云阵眼：可提升法伤")

    -- 显示按钮 - 竖着排列，间距与资源组[5]一致
    for i=1,#self.按钮组 do
      self.按钮组[i]:更新(x,y)
      -- 等级在第一行且没有按钮，所以按钮从第二行开始，i+1
      -- 资源组[5]宽度调整后，按钮位置相应调整
      self.按钮组[i]:显示(self.x+210+80,self.y+5+(i+1)*29)
    end

    -- 事件处理
    if self.资源组[4]:事件判断() then
      self:打开()
      return
    elseif self.按钮组[1]:事件判断() and self.显示数据 then
        --请求服务(20,{id=tp.角色.数据.数字id,属性="伤害"})
        tp.常规提示:打开("#Y/右击道具使用")
    elseif self.按钮组[2]:事件判断() and self.显示数据 then
        --请求服务(20,{id=tp.角色.数据.数字id,属性="法伤"})
        tp.常规提示:打开("#Y/右击道具使用")
    elseif self.按钮组[3]:事件判断() and self.显示数据 then
        --请求服务(20,{id=tp.角色.数据.数字id,属性="固伤"})
        tp.常规提示:打开("#Y/右击道具使用")
    elseif self.按钮组[4]:事件判断() and self.显示数据 then
        --请求服务(20,{id=tp.角色.数据.数字id,属性="召唤兽伤害"})
        tp.常规提示:打开("#Y/右击道具使用")
    elseif self.按钮组[5]:事件判断() and self.显示数据 then
        --请求服务(20,{id=tp.角色.数据.数字id,属性="防御"})
        tp.常规提示:打开("#Y/右击道具使用")
    elseif self.按钮组[6]:事件判断() and self.显示数据 then
        --请求服务(20,{id=tp.角色.数据.数字id,属性="法防"})
        tp.常规提示:打开("#Y/右击道具使用")
    elseif self.按钮组[7]:事件判断() and self.显示数据 then
        --请求服务(20,{id=tp.角色.数据.数字id,属性="速度"})
        tp.常规提示:打开("#Y/右击道具使用")
    end





end

function 八卦阵升级界面:打开(数据)
    if self.可视 then
        self.可视 = false
    else
        insert(tp.窗口_,self)
        self.显示数据 = 数据
        tp.运行时间 = tp.运行时间 + 1
        self.窗口时间 = tp.运行时间
        self.可视 = true
    end
end

function 八卦阵升级界面:检查点(x,y)
  if self.可视 and self.资源组~=nil and self.资源组[1]:是否选中(x,y)  then
    return true
  end
end

function 八卦阵升级界面:初始移动(x,y)
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

function 八卦阵升级界面:开始移动(x,y)
  if self.鼠标 then
    self.x = x - self.xx
    self.y = y - self.yy
  end
end

return 八卦阵升级界面