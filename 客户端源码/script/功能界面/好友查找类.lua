--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:02:35
--======================================================================--
local 好友查找类 = class()

local floor = math.floor
local tp,zts,zts1
local insert = table.insert

function 好友查找类:初始化(根)
  self.ID = 147
  self.x = 全局游戏宽度/2-172
  self.y = 全局游戏高度/2-135
  self.xx = 0
  self.yy = 0
  self.注释 = "好友查找类"
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
      [1] = 自适应.创建(0,1,345,270,3,9),
      [2] = 自适应.创建(1,1,341,18,1,3,nil,18),
      [3] = 自适应.创建(2,1,325,140,3,9),
      [4] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
      [5] =自适应.创建(3,1,110,18,1,3),
      [6] =自适应.创建(3,1,85,18,1,3),

    }
  self.搜索玩家=按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"搜索玩家")
  self.搜索队伍=按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"搜索队伍")
  self.查找按钮=按钮.创建(自适应.创建(12,4,26,20,1,3),0,0,4,true,true,"查")
  self.按钮组 ={
      [1] =按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"加为好友"),
      [2] =按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"临时好友"),
      [3] =按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"设为私聊"),
      [4] =按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,true,true,"屏蔽名单"),
}

for i=1,#self.按钮组 do
  self.按钮组[i]:绑定窗口_(self.ID)
  self.按钮组[i]:置偏移(1,-1)
end
self.查找按钮:绑定窗口_(self.ID)
self.查找按钮:置偏移(-1,-1)
self.搜索玩家:置偏移(1,-1)
self.搜索队伍:置偏移(1,-1)
  zts = tp.字体表.普通字体
  zts1 = tp.字体表.描边字体
  self.控件类 = require("ggeui/加载类")()
  local 总控件 = self.控件类:创建控件('查找好友总控件')
  总控件:置可视(true,true)
  self.输入框 = 总控件:创建输入("查找好友输入",0,0,105,14)
  self.输入框:置可视(false,false)
  self.输入框:置限制字数(20)
  self.输入框:置光标颜色(-16777216)
  self.输入框:置文字颜色(-16777216)
  self.输入框1 = 总控件:创建输入("查找ID输入",0,0,80,14)
  self.输入框1:置可视(false,false)
  self.输入框1:置限制字数(20)
  self.输入框1:置光标颜色(-16777216)
  self.输入框1:置文字颜色(-16777216)




end

function 好友查找类:打开()
  if self.可视 then
    self.可视 = false
    self.显示数据={}

    self.输入框:置焦点(false)
    self.输入框:置可视(false,false)
    self.输入框1:置焦点(false)
    self.输入框1:置可视(false,false)
    self.输入框:置文本("")
    self.输入框1:置文本("")
    return
  else
    self.输入框:置可视(true,true)
    self.输入框1:置可视(true,true)
    self.输入框:置文本("")
    self.输入框1:置文本("")
    self.显示数据={}
    insert(tp.窗口_,self)
    tp.运行时间 = tp.运行时间 + 1
    self.窗口时间 = tp.运行时间
    self.可视 = true
  end
end
function 好友查找类:刷新(内容)
  self.显示数据={}

  if 内容 and 内容.名称 and 内容.数字ID then
    self.显示数据 = 内容
  end

end

function 好友查找类:显示(dt,x,y)
    self.焦点 = false
    self.资源组[1]:显示(self.x,self.y)
    self.资源组[2]:显示(self.x+2,self.y+2)
    tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
    zts1:置字间距(3)
    zts1:置颜色(白色):显示(self.x+self.资源组[1].宽度/2-30,self.y+1,"在线查询")
    zts1:置字间距(0)
    self.资源组[4]:更新(x,y)
    self.搜索玩家:更新(x,y)
    self.搜索队伍:更新(x,y)
    self.资源组[4]:显示(self.x+325,self.y+2)
    self.资源组[3]:显示(self.x+10,self.y+90)
    self.搜索玩家:显示(self.x+10,self.y+30,nil,nil,nil,true,2)
    self.搜索队伍:显示(self.x+95,self.y+30)
    zts:置颜色(白色):显示(self.x+10,self.y+60,"昵称")
    self.资源组[5]:显示(self.x+45,self.y+59)
    self.输入框:置坐标(self.x+50,self.y+61)
    zts:置颜色(白色):显示(self.x+165,self.y+60,"数字ID")
    self.资源组[6]:显示(self.x+215,self.y+59)
    self.输入框1:置坐标(self.x+220,self.y+61)
    self.查找按钮:更新(x,y)
    self.查找按钮:显示(self.x+308,self.y+59)
    if self.显示数据 and  self.显示数据.名称 and self.显示数据.数字ID then
       zts:置颜色(黑色):显示(self.x+15,self.y+95,"名字："..self.显示数据.名称.."("..self.显示数据.数字ID..")")
       zts:置颜色(黑色):显示(self.x+15,self.y+115,"种族："..self.显示数据.种族)
       zts:置颜色(黑色):显示(self.x+15,self.y+135,"性别："..self.显示数据.性别)
       zts:置颜色(黑色):显示(self.x+15,self.y+155,"等级："..self.显示数据.等级)
       zts:置颜色(黑色):显示(self.x+15,self.y+175,"曾用名")

    end



    for i=1,#self.按钮组 do
      self.按钮组[i]:更新(x,y,self.显示数据 and self.显示数据.数字ID and self.显示数据.数字ID~=tp.队伍[1].数字id)
      self.按钮组[i]:显示(self.x-76+i*85,self.y+240)
    end
    if self.资源组[4]:事件判断() then
      self:打开()
      return

    elseif self.查找按钮:事件判断() and ((self.输入框:取文本()~="" and self.输入框:取文本()~=nil) or (self.输入框1:取文本()~="" and self.输入框1:取文本()~=nil) ) then
          self.显示数据={}
          请求服务(22,{名称=self.输入框:取文本(),id=self.输入框1:取文本()})
    elseif self.按钮组[1]:事件判断() and self.显示数据  and self.显示数据.数字ID then
          请求服务(19,{id=self.显示数据.数字ID})
    elseif self.按钮组[2]:事件判断() and self.显示数据  and self.显示数据.数字ID  then
          请求服务(18,{id=self.显示数据.数字ID})
    elseif self.按钮组[4]:事件判断() and self.显示数据  and self.显示数据.数字ID  then
          请求服务(23,{id=self.显示数据.数字ID,数据=self.显示数据})


    end






 self.控件类:更新(dt,x,y)
  self.控件类:显示(x,y)
if self.输入框._已碰撞 or self.输入框1._已碰撞 then
    self.焦点 = true
 end


end



function 好友查找类:检查点(x,y)
  if self.可视 and self.资源组~=nil and self.资源组[1]:是否选中(x,y)  then
    return true
  end
end

function 好友查找类:初始移动(x,y)
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

function 好友查找类:开始移动(x,y)
  if self.鼠标 then
    self.x = x - self.xx
    self.y = y - self.yy
  end
end

return 好友查找类