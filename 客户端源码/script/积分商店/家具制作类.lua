-- @Author: baidwwy
-- @Date:   2024-01-15 17:52:41
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-01-23 22:26:01

local 家具制作类 = class()
local bw = require("gge包围盒")(0,0,225,35)
local box = 引擎.画矩形
local mouseb = 引擎.鼠标弹起
local tp,zts,zts1
local insert = table.insert
function 家具制作类:初始化(根)
    self.ID = 146
    self.x = 100+(全局游戏宽度-800)/2
    self.y = 170
    self.xx = 0
    self.yy = 0
    self.注释 = "家具制作类"
    self.可视 = false
    self.鼠标 = false
    self.焦点 = false
    self.可移动 = true
    local 按钮 = 根._按钮
    local 资源 = 根.资源
    local 自适应 = 根._自适应
    tp = 根
    zts = tp.字体表.描边字体
    zts1 = tp.字体表.普通字体
    self.资源组={

        [1] = 自适应.创建(0,1,510,360,3,9),
        [2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭
        [3] = 自适应.创建(1,1,506,18,1,3,nil,18),--标题背景
        [4] = 自适应.创建(2,1,240,260,3,9),
        [5] = 自适应.创建(4,1,240,320,3,nil),
        [6] =  tp._滑块.创建(自适应.创建(11,4,7,40,2,3,nil),4,14,258,2),
    }
    self.全部按钮=按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"  全部")
    self.一级按钮=按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"  一级")
    self.二级按钮=按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"  二级")
    self.制作按钮=按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"  制作")
    self.取消按钮=按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"  取消")
    self.文字背景=自适应.创建(3,1,160,18,1,3)
    self.boxh=35
    self.boxw=220
    self.窗口时间 = 0
    self.加入 = 0
    self.一级家具={"黑麻垂曼帘","桦木圆桌","桦木立柜","草编地毯","漆花竹凳","榛木床","印花屏风",
                   "文竹","君子兰","蝴蝶兰","水仙","仙人掌","银烛台","玉瓷画瓶","踏春图","漆花地板"}
    self.二级家具={"白鹤展翅帘","蓝绸绣花帘","红木八仙桌","嵌玉虎纹桌","双鱼吉庆柜","彩绘立柜","兽皮地毯",
                  "麻布地毯","桦木靠背椅","月牙凳","八卦镇邪榻","神仙帐","狮子图屏风","花鸟图屏风","天山云雪",
                  "龟鹤延年灯","长信宫灯","雕花马桶","彩绘花瓶","夕阳山水图","猛虎坐山图","桦木地板"}
     self.全部家具={}
    for i=1,#self.一级家具 do
          self.全部家具[#self.全部家具+1]=self.一级家具[i]
    end
    for i=1,#self.二级家具 do
        self.全部家具[#self.全部家具+1]=self.二级家具[i]
    end
    self.材料显示={
                  玉瓷画瓶={"灵巧手艺","陶瓷类"},
                  踏春图={"绘画工艺","普通手艺"},
                  桦木圆桌={"普通木材类","普通手艺"},
                  水仙={"装饰工艺","闲杂材料一","陶瓷类"},
                  文竹={"闲杂材料一","闲杂材料二","陶瓷类"},
                  君子兰={"装饰工艺","闲杂材料三","陶瓷类"},
                  蝴蝶兰={"普通木材类","闲杂材料三","陶瓷类"},
                  仙人掌={"闲杂材料二","闲杂材料三","陶瓷类"},
                  银烛台={"普通金属类","装饰工艺","普通手艺"},
                  月牙凳={"珍稀木材类","绘画工艺","灵巧手艺"},
                  榛木床={"普通木材类","普通木材类","普通木材类"},
                  桦木立柜={"普通木材类","普通木材类","普通手艺"},
                  草编地毯={"闲杂材料一","普通手艺","灵巧手艺"},
                  漆花竹凳={"普通木材类","印花工艺","普通手艺"},
                  兽皮地毯={"装饰工艺","灵巧手艺","闲杂材料三"},
                  麻布地毯={"普通布料类","灵巧手艺","闲杂材料二"},
                  印花屏风={"普通木材类","普通布料类","印花工艺"},
                  漆花地板={"普通木材类","印花工艺","闲杂材料一"},
                  彩绘花瓶={"绘画工艺","闲杂材料三","陶瓷类"},
                  桦木地板={"普通木材类","灵巧手艺","闲杂材料二"},
                  蓝绸绣花帘={"普通木材类","高级布料类","高级布料类"},
                  黑麻垂曼帘={"普通木材类","普通布料类","印染工艺"},
                  狮子图屏风={"珍稀木材类","绘画工艺","闲杂材料一"},
                  龟鹤延年灯={"普通金属类","雕花工艺","灵巧手艺"},
                  猛虎坐山图={"高级布料类","绘画工艺","灵巧手艺"},
                  神仙帐={"珍稀木材类","印花工艺","灵巧手艺","闲杂材料三"},
                  天山云雪={"装饰工艺","灵巧手艺","闲杂材料二","陶瓷类"},
                  长信宫灯={"普通金属类","珍稀木材类","灵巧手艺","宝石类"},
                  彩绘立柜={"珍稀木材类","绘画工艺","普通手艺","闲杂材料三"},
                  雕花马桶={"普通木材类","雕花工艺","装饰工艺","闲杂材料一"},
                  白鹤展翅帘={"普通布料类","珍稀木材类","高级布料类","闲杂材料一"},
                  红木八仙桌={"珍稀木材类","珍稀木材类","雕花工艺","普通手艺"},
                  嵌玉虎纹桌={"珍稀木材类","雕花工艺","普通手艺","宝石类"},
                  双鱼吉庆柜={"普通木材类","贵重金属类","雕花工艺","灵巧手艺"},
                  桦木靠背椅={"普通木材类","雕花工艺","灵巧手艺","闲杂材料三"},
                  八卦镇邪榻={"珍稀木材类","雕花工艺","宝石类","闲杂材料一"},
                  花鸟图屏风={"珍稀木材类","绘画工艺","普通手艺","闲杂材料二"},
                  夕阳山水图={"高级布料类","绘画工艺","普通手艺","闲杂材料二"}
              }

     self.消耗显示={
                  文竹={活力=55,银子=7000},
                  水仙={活力=75,银子=10000},
                  仙人掌={活力=75,银子=10000},
                  榛木床={活力=45,银子=5000},
                  君子兰={活力=65,银子=9000},
                  蝴蝶兰={活力=65,银子=9000},
                  银烛台={活力=85,银子=12000},
                  踏春图={活力=95,银子=14000},
                  神仙帐={活力=105,银子=20000},
                  月牙凳={活力=105,银子=20000},
                  桦木圆桌={活力=25,银子=1000},
                  桦木立柜={活力=35,银子=3000},
                  草编地毯={活力=35,银子=3000},
                  漆花竹凳={活力=45,银子=5000},
                  印花屏风={活力=55,银子=7000},
                  玉瓷画瓶={活力=85,银子=12000},
                  漆花地板={活力=95,银子=14000},
                  彩绘立柜={活力=105,银子=20000},
                  麻布地毯={活力=105,银子=20000},
                  天山云雪={活力=125,银子=30000},
                  长信宫灯={活力=125,银子=30000},
                  雕花马桶={活力=125,银子=30000},
                  彩绘花瓶={活力=125,银子=30000},
                  桦木地板={活力=125,银子=30000},
                  兽皮地毯={活力=105,银子=20000},
                  黑麻垂曼帘={活力=25,银子=1000},
                  蓝绸绣花帘={活力=105,银子=20000},
                  白鹤展翅帘={活力=105,银子=20000},
                  红木八仙桌={活力=105,银子=20000},
                  嵌玉虎纹桌={活力=105,银子=20000},
                  双鱼吉庆柜={活力=105,银子=20000},
                  桦木靠背椅={活力=105,银子=20000},
                  八卦镇邪榻={活力=105,银子=20000},
                  狮子图屏风={活力=105,银子=20000},
                  花鸟图屏风={活力=105,银子=20000},
                  龟鹤延年灯={活力=125,银子=30000},
                  夕阳山水图={活力=125,银子=30000},
                  猛虎坐山图={活力=125,银子=30000},
 }

end




function 家具制作类:打开()


    if self.可视 then
        self.可视 = false
        self.选中家具=nil
        self.状态="全部"
        self.加入= 0
        self.资源组[6]:置起始点(0)
    else
        self.状态="全部"
        self.加入 = 0
        self.选中家具=nil
        self.资源组[6]:置起始点(0)
        insert(tp.窗口_,self)
        tp.运行时间 = tp.运行时间 + 1
        self.窗口时间 = tp.运行时间
        self.可视 = true


    end
end



function 家具制作类:显示(dt,x,y)

    self.焦点 = false
    self.资源组[1]:显示(self.x,self.y)
    self.资源组[3]:显示(self.x+2,self.y+2)
    tp.窗口标题背景_[7]:显示(self.x+self.资源组[1].宽度/2-80,self.y+2)
    zts1:置颜色(0xFFFFFFFF):显示(self.x+self.资源组[1].宽度/2-40,self.y+2,"制作指定设计图")
    self.资源组[2]:更新(x,y)
    self.全部按钮:更新(x,y)
    self.一级按钮:更新(x,y)
    self.二级按钮:更新(x,y)
    self.制作按钮:更新(x,y)
    self.取消按钮:更新(x,y)

     self.资源组[2]:显示(self.x+490,self.y+2)
     self.资源组[4]:显示(self.x+10,self.y+90)
     self.资源组[5]:显示(self.x+260,self.y+30)
     self.全部按钮:显示(self.x+10,self.y+60,nil,nil,nil,self.状态 == "全部",2)
     self.一级按钮:显示(self.x+90,self.y+60,nil,nil,nil,self.状态 == "一级",2)
     self.二级按钮:显示(self.x+170,self.y+60,nil,nil,nil,self.状态 == "二级",2)
     self.制作按钮:显示(self.x+315,self.y+315)
     self.取消按钮:显示(self.x+395,self.y+315)


    if self.资源组[2]:事件判断()  then
        self:打开()
    elseif self.取消按钮:事件判断()  then
        self:打开()
    elseif self.全部按钮:事件判断()  then
        self.状态 = "全部"
        self.选中家具=nil
        self.资源组[6]:置起始点(0)
    elseif self.一级按钮:事件判断()  then
        self.状态 = "一级"
        self.选中家具=nil
        self.资源组[6]:置起始点(0)
    elseif self.二级按钮:事件判断()  then
        self.状态 = "二级"
        self.选中家具=nil
        self.资源组[6]:置起始点(0)
    elseif  self.选中家具~=nil and self.制作按钮:事件判断()   then
        请求服务(3789,{参数=self.选中家具})

    end

    zts1:置颜色(白色):显示(self.x+10,self.y +30,"请选择制作的图纸")
    zts1:置颜色(白色):显示(self.x+360,self.y +35,"配置盘")
    self.资源组[6]:显示(self.x+240,self.y+91,x,y,self.鼠标)
    zts1:置颜色(黑色):显示(self.x+265,self.y +265,"消耗金钱")
    self.文字背景:显示(self.x+330,self.y +262)
    zts1:置颜色(黑色):显示(self.x+265,self.y +290,"消耗活力")
    self.文字背景:显示(self.x+330,self.y +287)


     if self.选中家具~=nil and  self.材料显示[self.选中家具]~=nil then
      for i=1,#self.材料显示[self.选中家具] do
          zts1:置颜色(黑色):显示(self.x+265,self.y +35+i*35,self.材料显示[self.选中家具][i])
      end
      zts1:置颜色(黑色):显示(self.x+335,self.y +268,self.消耗显示[self.选中家具].银子)
      zts1:置颜色(黑色):显示(self.x+335,self.y +293,self.消耗显示[self.选中家具].活力)

    end

    if self.状态=="全部" then
        self.加入 = math.min(math.ceil((#self.全部家具-7)*self.资源组[6]:取百分比()),#self.全部家具-7)
        local XX = 1
        for n=1,7 do
            if self.全部家具[n+self.加入]~=nil then
                local zx,zy = self.x+14,self.y+XX*self.boxh+60
                bw:置坐标(zx,zy)
                if bw:检查点(x,y) then
                    if mouseb(0) then
                        self.选中家具 = self.全部家具[n+self.加入]
                    end
                    box(zx-2,zy-2,zx+self.boxw,zy+self.boxh,-1677721856)
                end
                if self.选中家具~=nil and self.选中家具 == self.全部家具[n+self.加入] then
                    box(zx-2,zy-2,zx+self.boxw,zy+self.boxh,1677721855)
                end
               zts1:置颜色(黑色):显示(self.x+15,self.y +70+n*35,self.全部家具[n+self.加入])
               XX= XX+1
            end
       end

      if self.资源组[6]:是否选中(x,y) and self.加入 > 0 then
          self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.加入,7,#self.全部家具))
      elseif  self.资源组[6]:是否选中(x,y) and self.加入 < #self.全部家具 - 7 then
          self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.加入,7,#self.全部家具))
      elseif self.资源组[4]:是否选中(x,y) and 引擎.取鼠标滚轮() ==1 and self.加入 > 0 then
          self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.加入-1,7,#self.全部家具))
      elseif self.资源组[4]:是否选中(x,y) and 引擎.取鼠标滚轮() ==-1 and self.加入 < #self.全部家具 - 7 then
          self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.加入+1,7,#self.全部家具))
      end



    elseif self.状态=="一级" then
      self.加入 = math.min(math.ceil((#self.一级家具-7)*self.资源组[6]:取百分比()),#self.一级家具-7)
        local XX = 1
        for n=1,7 do
            if self.一级家具[n+self.加入]~=nil then
                local zx,zy = self.x+14,self.y+XX*self.boxh+60
                bw:置坐标(zx,zy)
                if bw:检查点(x,y) then
                    if mouseb(0) then
                        self.选中家具 = self.一级家具[n+self.加入]
                    end
                    box(zx-2,zy-2,zx+self.boxw,zy+self.boxh,-1677721856)
                end
                if self.选中家具~=nil and self.选中家具 == self.一级家具[n+self.加入] then
                    box(zx-2,zy-2,zx+self.boxw,zy+self.boxh,1677721855)
                end
               zts1:置颜色(黑色):显示(self.x+15,self.y +70+n*35,self.一级家具[n+self.加入])
               XX= XX+1
            end
       end

      if self.资源组[6]:是否选中(x,y) and self.加入 > 0 then
          self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.加入,7,#self.一级家具))
      elseif  self.资源组[6]:是否选中(x,y) and self.加入 < #self.一级家具 - 7 then
          self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.加入,7,#self.一级家具))
      elseif self.资源组[4]:是否选中(x,y) and 引擎.取鼠标滚轮() ==1 and self.加入 > 0 then
          self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.加入-1,7,#self.一级家具))
      elseif self.资源组[4]:是否选中(x,y) and 引擎.取鼠标滚轮() ==-1 and self.加入 < #self.一级家具 - 7 then
          self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.加入+1,7,#self.一级家具))
      end

    elseif self.状态=="二级" then
      self.加入 = math.min(math.ceil((#self.二级家具-7)*self.资源组[6]:取百分比()),#self.二级家具-7)
        local XX = 1
        for n=1,7 do
            if self.二级家具[n+self.加入]~=nil then
                local zx,zy = self.x+14,self.y+XX*self.boxh+60
                bw:置坐标(zx,zy)
                if bw:检查点(x,y) then
                    if mouseb(0) then
                        self.选中家具 = self.二级家具[n+self.加入]
                    end
                    box(zx-2,zy-2,zx+self.boxw,zy+self.boxh,-1677721856)
                end
                if self.选中家具~=nil and self.选中家具 == self.二级家具[n+self.加入] then
                    box(zx-2,zy-2,zx+self.boxw,zy+self.boxh,1677721855)
                end
               zts1:置颜色(黑色):显示(self.x+15,self.y +70+n*35,self.二级家具[n+self.加入])
               XX= XX+1
            end
       end

      if self.资源组[6]:是否选中(x,y) and self.加入 > 0 then
          self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.加入,7,#self.二级家具))
      elseif  self.资源组[6]:是否选中(x,y) and self.加入 < #self.二级家具 - 7 then
          self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.加入,7,#self.二级家具))
      elseif self.资源组[4]:是否选中(x,y) and 引擎.取鼠标滚轮() ==1 and self.加入 > 0 then
          self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.加入-1,7,#self.二级家具))
      elseif self.资源组[4]:是否选中(x,y) and 引擎.取鼠标滚轮() ==-1 and self.加入 < #self.二级家具 - 7 then
          self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.加入+1,7,#self.二级家具))
      end



    end






  if self.资源组[6].接触 then
     self.焦点 = true
  end


end

function 家具制作类:检查点(x,y)
    if self.可视 and self.资源组[1]:是否选中(x,y)  then
        return true
    else
        return false
    end
end

function 家具制作类:初始移动(x,y)
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

function 家具制作类:开始移动(x,y)
    if self.鼠标 then
        self.x = x - self.xx
        self.y = y - self.yy
    end
end
function 家具制作类:更新(dt) end


return 家具制作类