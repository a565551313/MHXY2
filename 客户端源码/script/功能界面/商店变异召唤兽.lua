local 商店召唤兽类 = class()

local 名称数据={}
local 包围盒 = require("gge包围盒")(0,0,520,20)
local 选中编号=0
local 临时编号=0
local tp

function 商店召唤兽类:初始化(根)
  self.ID = 96
  self.x = 202
  self.y = 88
  self.xx = 0
  self.yy = 0
  self.注释 = "给予类"
  self.可视 = false
  self.鼠标 = false
  self.焦点 = false
  self.可移动 = true
  self.右键关闭=1
  self.窗口时间 = 0
  tp = 根
end

function 商店召唤兽类:打开(内容)
 if self.可视 then
    self.选中人物 = 0
    self.可视 = false
    self.资源组 = nil
    self.数据 = nil
    self.名称 = nil
    self.刷新 = nil
    内容 = nil
    按钮 = nil
    自适应 = nil
    return
  else
    table.insert(tp.窗口_,self)
    local 按钮 = tp._按钮
    local 自适应 = tp._自适应
    local 资源 = tp.资源
    self.资源组 = {
    [1] = 自适应.创建(0,1,350,360,3,9),
    [2] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"购买"),
    [3] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"刷新"),
    [4] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
    [5] = 资源:载入(wdf配置.."/pic/界面/列表背景.png", "图片"),
    [6] = 资源:载入(wdf配置.."/pic/界面/选择条.png", "图片"),
    [7] = 自适应.创建(1,1,346,18,1,3,nil,18),

    }
      tp.运行时间 = tp.运行时间 + 1
    self.窗口时间 = tp.运行时间
    self.可视 = true
    self.资源组[3]:置偏移(5,0)
        self.数据=内容
        self.名称={}
        self.刷新=内容.刷新
        self.资源组[3].按钮文字="刷新("..self.刷新..")"
        for i=1,#self.数据 do

          self.名称[#self.名称+1]={名称=self.数据[i].模型,价格=self.数据[i].价格}
         -- print(self.数据[i])


         end

      选中编号=0
      临时编号=0



    end


end
function 商店召唤兽类:更新数据(内容)
  self.数据=内容
        self.名称={}
        self.刷新=内容.刷新
        self.资源组[3].按钮文字="刷新("..self.刷新..")"
        for i=1,#self.数据 do

          self.名称[#self.名称+1]={名称=self.数据[i].模型,价格=self.数据[i].价格}
         -- print(self.数据[i])


         end

 end
function 商店召唤兽类:更新(dt)

end


function 商店召唤兽类:显示(dt,x,y)
  --print(8888888)
 self.资源组[1]:显示(self.x,self.y)
 self.资源组[5]:显示(self.x+5,self.y+25)
 self.资源组[7]:显示(self.x+2,self.y+2)
 tp.窗口标题背景_[5]:显示(self.x+self.资源组[1].宽度/2-68,self.y+2)
 tp.字体表.标题字体:置颜色(白色):显示(self.x+self.资源组[1].宽度/2-38,self.y+2,"商会召唤兽")
 self.资源组[4]:更新(x,y)
 self.资源组[2]:更新(x,y,选中编号~=0)
 self.资源组[3]:更新(x,y)
 self.资源组[2]:显示(self.x+192-110,self.y+332)
 self.资源组[3]:显示(self.x+312-110,self.y+332)
 self.资源组[4]:显示(self.x+330,self.y+2)


   if self.资源组[4]:事件判断() then
     self:打开()
     return
   elseif self.资源组[2]:事件判断() then
     if 选中编号==0 then

        tp.常规提示:打开("#Y请先选择要购买的召唤兽")
      else

       请求服务(53.1,{名称=选中编号})
       end
    elseif self.资源组[3]:事件判断() then
     请求服务(54.1,{名称=选中编号})
    elseif self.资源组[1]:是否选中(x,y) and 引擎.鼠标弹起(右键) then

      self:打开()
      return

     end
 local 字体=tp.字体表.普通字体



 字体:置颜色(黑色)
 tp.字体表.排行字体:置颜色(白色):显示(self.x+12,self.y+32,"召唤兽名称")
 tp.字体表.排行字体:置颜色(白色):显示(self.x+140,self.y+32,"召唤兽类型")
 --字体:显示(self.x+185,self.y+52,"职务")
 --字体:显示(self.x+255,self.y+52,"帮贡")
 tp.字体表.排行字体:置颜色(白色):显示(self.x+286,self.y+32,"价格")
 --字体:显示(self.x+435,self.y+52,"离线日期")
 --显示12行
 local 位置=0
 for n=1,12 do
     位置=位置+1
     --print(self.名称[n])
      if self.名称[n]~=nil then

         local 颜色=黑色
         if 选中编号==n then 颜色=红色 end
         包围盒:置坐标(self.x+20,self.y+34+位置*23)
         if 包围盒:检查点(x,y) then
          --  print(66666)
               临时编号=n
           if 引擎.鼠标弹起(左键) then
             if 选中编号==n then
                选中编号=0
             else
               选中编号=n

               end

             end
           end

          if 选中编号==n then
         self.资源组[6]:显示(self.x+6,self.y+29+位置*23)
         tp.字体表.排行字体1:置颜色(颜色):显示(self.x-10+ ((100 - tp.字体表.排行字体1:置颜色(颜色):取宽度(self.名称[n].名称))/2)+8,self.y+34+位置*23,self.名称[n].名称)
         tp.字体表.排行字体1:置颜色(颜色):显示(self.x+165,self.y+34+位置*23,"变异")
         tp.字体表.排行字体1:置颜色(颜色):显示(self.x+276,self.y+34+位置*23,self.名称[n].价格)
         elseif 临时编号==n then
         tp.字体表.排行字体1:置颜色(绿色):显示(self.x-10+ ((100 - tp.字体表.排行字体1:置颜色(绿色):取宽度(self.名称[n].名称))/2)+8,self.y+34+位置*23,self.名称[n].名称)
         tp.字体表.排行字体1:置颜色(绿色):显示(self.x+165,self.y+34+位置*23,"变异")
         tp.字体表.排行字体1:置颜色(绿色):显示(self.x+276,self.y+34+位置*23,self.名称[n].价格)
         else
         tp.字体表.排行字体1:置颜色(黑色):显示(self.x-10+ ((100 - tp.字体表.排行字体1:置颜色(黑色):取宽度(self.名称[n].名称))/2)+8,self.y+34+位置*23,self.名称[n].名称)
         tp.字体表.排行字体1:置颜色(黑色):显示(self.x+165,self.y+34+位置*23,"变异")
         tp.字体表.排行字体1:置颜色(黑色):显示(self.x+276,self.y+34+位置*23,self.名称[n].价格)
         end
         tp.字体表.排行字体1:置颜色(白色)

         end



   end
end
function 商店召唤兽类:初始移动(x,y)
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

function 商店召唤兽类:开始移动(x,y)
  if self.鼠标 then
    self.x = x - self.xx
    self.y = y - self.yy


  end
end
function 商店召唤兽类:检查点(x,y)
  if self.可视 and self.资源组[1]:是否选中(x,y)  then
    return true
  else
    return false
  end
end

return 商店召唤兽类