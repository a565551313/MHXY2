-- @Author: 作者QQ2308873645
-- @Date:   2021-11-27 13:12:32
-- @Last Modified by:   作者QQ381990860
-- @Last Modified time: 2025-01-23 22:26:01
local 每日活动 = class()
local tp,zts

function 每日活动:初始化(根)
    self.ID = 111
    self.x = 280
    self.y = 90
    self.xx = 0
    self.yy = 0
    self.注释 = "每日活动"
    self.可视 = false
    self.鼠标 = false
    self.焦点 = false
    self.可移动 = true
    local 资源 = 根.资源
    local 按钮 = 根._按钮
    local 自适应 = 根._自适应
    self.资源组 = {
        [1] = 自适应.创建(0,1,380,405,3,9),
        [2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
        [3] = 自适应.创建(2,1,340,350,3,9),
        [4] = 自适应.创建(105,1,330,90,3,9),
        [5] = 自适应.创建(1,1,376,18,1,3,nil,18),

    }

       self.资源组[2]:绑定窗口_(111)
       self.顶部按扭={
        [1] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"每日消费"),
        [2] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"每日充值"),
        [3] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"神秘礼包"),
        [4] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"超值抢购"),
       }
       for i=1,4 do
        self.顶部按扭[i]:绑定窗口_(111)
       end

    tp = 根
    self.宝石字体= tp.字体表.描边字体__
    self.宝石字体:置颜色(0xFFFFFFFF)
    self.宝石字体:置描边颜色(0xfff741940)--xFFaf140c)
    zts=tp.字体表.普通字体

    self.窗口时间 = 0

    self.标题名称="每日消费"
    self.剩余时间 = 0
    self.开始 = 1
    self.结束 = 3
    self.物品 = {}
    self.物品数量 = {}
    self.完成进度 = 0
    self.总进度 = 0
    self.消费说明 = {}
    self.是否领取 ={每日消费={},每日充值={},神秘礼包={},超值抢购={}}
    self.剩余时间 = 0
    self.变色时间=os.time()
    self.字体颜色 = {0xFFFFFF00,0xFFFF0000,0xFFFFFFFF,0xFF00FF00}
    self.初始颜色 = 0xFFFFFF00


end

function 每日活动:打开(数据)
    if self.可视 then
        self.可视 = false
    else
        table.insert(tp.窗口_,self)
        tp.运行时间 = tp.运行时间 + 1
        self.窗口时间 = tp.运行时间
        self.可视 = true
      self.物品 ={}
      self.开始 = 1
      self.结束 = 3
      self.标题名称=数据.标题
      self.物品数量=数据.物品数量
      self.总进度 = 数据.需求积分
      self.消费说明 = 数据.消费说明
      self.是否领取[self.标题名称]=数据.是否领取[self.标题名称]
       self.剩余时间 = 数据.是否领取[self.标题名称].到期时间
       self.完成进度 = 数据.是否领取[self.标题名称].数额


      for i=1,#数据.物品 do
          self.物品[i]={}
          if 数据.物品[i]~=nil then
           for n=1,#数据.物品[i] do
             self.物品[i][n] ={}
              if 数据.物品[i][n]~=nil then
                 local 资源=引擎.取物品(数据.物品[i][n].名称)
                self.物品[i][n].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
                self.物品[i][n].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
                self.物品[i][n].名称=数据.物品[i][n].名称
                self.物品[i][n].数量=数据.物品[i][n].数量
                self.物品[i][n].介绍=资源[1]
             end
          end
        end
      end

      self.领取按钮={每日消费={},每日充值={},神秘礼包={},超值抢购={}}
      for y=1,#self.消费说明  do
        if self.标题名称=="神秘礼包" or self.标题名称=="超值抢购"  then
           self.领取按钮[self.标题名称][y] = tp._按钮.创建(tp._自适应.创建(12,4,42,20,1,3),0,0,4,true,true,"购买")
        else
           self.领取按钮[self.标题名称][y] = tp._按钮.创建(tp._自适应.创建(12,4,42,20,1,3),0,0,4,true,true,"领取")
        end
         self.领取按钮[self.标题名称][y]:绑定窗口_(111)
      end





    end
end

function 每日活动:刷新(数据)

      self.物品 ={}
      self.开始 = 1
      self.结束 = 3
      self.领取按钮={每日消费={},每日充值={},神秘礼包={},超值抢购={}}
      self.标题名称=数据.标题
      self.物品数量=数据.物品数量
      self.总进度 = 数据.需求积分
      self.消费说明 = 数据.消费说明
      self.是否领取[self.标题名称]=数据.是否领取[self.标题名称]
      self.剩余时间 = 数据.是否领取[self.标题名称].到期时间
      self.完成进度 = 数据.是否领取[self.标题名称].数额
      for i=1,#数据.物品 do
         self.物品[i]={}
        if 数据.物品[i]~=nil then
          for n=1,#数据.物品[i] do
             self.物品[i][n] ={}
              if  数据.物品[i][n]~=nil then
                  local 资源=引擎.取物品(数据.物品[i][n].名称)
                  self.物品[i][n].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
                  self.物品[i][n].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
                  self.物品[i][n].名称=数据.物品[i][n].名称
                  self.物品[i][n].数量=数据.物品[i][n].数量
                  self.物品[i][n].介绍=资源[1]
             end
          end
        end
      end

      for y=1,#self.消费说明 do
        if self.标题名称=="神秘礼包" or self.标题名称=="超值抢购"  then
           self.领取按钮[self.标题名称][y] = tp._按钮.创建(tp._自适应.创建(12,4,42,20,1,3),0,0,4,true,true,"购买")
        else
           self.领取按钮[self.标题名称][y] = tp._按钮.创建(tp._自适应.创建(12,4,42,20,1,3),0,0,4,true,true,"领取")
        end
        self.领取按钮[self.标题名称][y]:绑定窗口_(111)
      end






end



function 每日活动:显示(dt,x,y)
    self.资源组[2]:更新(x,y)
    if self.资源组[2]:事件判断()  then
       self:打开()
    end
    self.焦点 = false
    self.资源组[1]:显示(self.x,self.y)
    self.资源组[5]:显示(self.x+2,self.y+2)
    tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
    zts:置字间距(3)
    zts:置颜色(白色):显示(self.x+self.资源组[1].宽度/2-30,self.y+2,self.标题名称)
    zts:置字间距(0)
    self.资源组[2]:显示(self.x+360,self.y+2)
   -- self.资源组[3]:显示(self.x+20,self.y+60)
    local zy = 0
    for i=1,3 do
    self.资源组[4]:显示(self.x+25,self.y+85+zy*105)
     引擎.画线(self.x+30,self.y+110+zy*105,self.x+350,self.y+110+zy*105,0xFFFFFFFF)
    zy =zy +1
    end
    local  时间显示 = "已到期"
    local 时间计算 = self.剩余时间-os.time()
    local 天 = 0
    local 时 = 0
    local 分 = 0
    local 秒 = 0
    if 时间计算<=0 then
        时间显示 = "已到期"
   else
     天 = math.floor(时间计算/86400)
    if 天<=0 then
       天=0
    end
    时 = math.floor((时间计算 - 86400*天)/3600)
    分 = math.floor((时间计算 - 86400*天-3600*时)/60)
    秒 = math.floor((时间计算 - 86400*天-3600*时-60*分))
    时间显示=天.."天"..时.."时"..分.."分"..秒.."秒"
   end
    zts:置颜色(黄色):显示(self.x+30,self.y+60,"活动剩余时间:   "..时间显示)
    local jy = 0
    for i = self.开始,self.结束 do
        zts:置颜色(绿色):显示(self.x+30,self.y+90+jy*105,self.消费说明[i])
        if self.标题名称=="神秘礼包" or self.标题名称 =="超值抢购" then
           zts:置颜色(绿色):显示(self.x+250,self.y+90+jy*105,self.总进度[i])
        else
           zts:置颜色(绿色):显示(self.x+250,self.y+90+jy*105,self.完成进度.."/"..self.总进度[i])
        end

       if self.领取按钮[self.标题名称][i]~=nil then
        self.领取按钮[self.标题名称][i]:更新(x,y)
        self.领取按钮[self.标题名称][i]:显示(self.x+300,self.y+140+jy*105,true,nil,nil, self.是否领取[self.标题名称][i],3)
        if  self.领取按钮[self.标题名称][i]:事件判断()  then
            if  not  self.是否领取[self.标题名称][i] then
              请求服务(45,{文本="每日领取",标题=self.标题名称,编号=i})
            end
        end
       end

        local jx = 0
        for n =1,self.物品数量[i] do
           tp.物品格子背景_:显示(self.x+40+jx*60,self.y+115+jy*105)
           if self.物品[i]~=nil and self.物品[i][n]~=nil and self.物品[i][n].小动画~=nil then
             self.物品[i][n].小动画:显示(self.x+41+jx*60,self.y+116+jy*105)

              self.宝石字体:显示(self.x+60+jx*60,self.y+150+jy*105,"x"..self.物品[i][n].数量)
              if  self.物品[i][n].小动画:是否选中(x,y) then
                tp.提示:商城提示(x,y,self.物品[i][n].名称,self.物品[i][n].介绍,self.物品[i][n].大动画)

              end

           end

           jx = jx +1
        end
       jy = jy +1
    end



    if  self.资源组[1]:是否选中(x,y) or self.资源组[4]:是否选中(x,y) then
        if 引擎.取鼠标滚轮() >0 and  self.结束>3 then--鼠标上滚动
            self.开始=self.开始 - 1
             self.结束 = self.开始 +2
             if  self.结束>#self.消费说明 then
                self.结束=#self.消费说明
                self.开始 = self.结束 - 2
            end
          elseif 引擎.取鼠标滚轮() <0  and self.开始<#self.消费说明-2 then--鼠标下滚动
            self.开始=self.开始 + 1
            self.结束 = self.开始 +2
            if self.开始 <=1 then--关闭按钮
                self.开始 = 1
                self.结束=3
            end
         end
    end


   local xx = 0
   for i=1,4 do
    self.顶部按扭[i]:更新(x,y)
    self.顶部按扭[i]:显示(self.x+20+xx*90,self.y+30,true,nil,nil,self.标题名称 == self.顶部按扭[i].按钮文字,2)
     if self.顶部按扭[i]:事件判断()  then
     请求服务(45,{文本=self.顶部按扭[i].按钮文字})
    end


    xx =xx + 1
    end

    local  箭头y = 62
    if  os.time()-self.变色时间>=1 then
        self.变色时间 = os.time()
        self.初始颜色=self.字体颜色[取随机数(1,#self.字体颜色)]
        if  箭头y == 62 then
          箭头y = 65
        else
          箭头y = 62
        end
    end
    zts:置颜色(self.初始颜色):显示(self.x+310,self.y+箭头y,"↓↓↓")
end

function 每日活动:检查点(x,y)
  if self.可视 and self.资源组[1]:是否选中(x,y)  then
    return true
  end
  return false
end

function 每日活动:初始移动(x,y)
  tp.运行时间 = tp.运行时间 + 1
  if not tp.消息栏焦点 then
    self.窗口时间 = tp.运行时间
  end
  if not self.焦点 then
    tp.移动窗口 = true
  end
  if self.可视 and self.鼠标 and  not self.焦点 then
    self.xx = x - self.x
    self.yy = y - self.y
  end
end

function 每日活动:开始移动(x,y)
  if self.鼠标 then
    self.x = x - self.xx
    self.y = y - self.yy
  end
end



return 每日活动