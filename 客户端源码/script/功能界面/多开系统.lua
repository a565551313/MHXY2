
local 多开系统 = class()
local bw = require("gge包围盒")(0,0,110,40)
local mouseb = 引擎.鼠标弹起
local box = 引擎.画矩形
local tp,zts,zts1
local insert = table.insert
function 多开系统:初始化(根)
    self.ID = 118
    self.x = 100+(全局游戏宽度-800)/2
    self.y = 170
    self.xx = 0
    self.yy = 0
    self.注释 = "多开系统"
    self.可视 = false
    self.鼠标 = false
    self.焦点 = false
    self.可移动 = true
    local 按钮 = 根._按钮
    local 资源 = 根.资源
    local 自适应 = 根._自适应
    tp = 根
    zts = tp.字体表.普通字体
    zts1 = tp.字体表.普通字体
    self.资源组={

         [1] = 自适应.创建(0,1,620,280,3,9),
        [2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭
        [3] = 自适应.创建(1,1,614,18,1,3,nil,18),--标题背景
         --[3]=自适应.创建(3,1,60,19,1,3),
         [4]=按钮.创建(自适应.创建(12,4,70,20,1,3),0,0,4,true,true,"创建角色"),
         [5]=按钮.创建(自适应.创建(12,4,70,20,1,3),0,0,4,true,true,"切换角色"),
         [6]=按钮.创建(自适应.创建(12,4,70,20,1,3),0,0,4,true,true,"角色参战"),
         [7]=按钮.创建(自适应.创建(12,4,70,20,1,3),0,0,4,true,true,"角色退出"),
         [8]=按钮.创建(自适应.创建(12,4,70,20,1,3),0,0,4,true,true,"一键退出"),
         [9] = 自适应.创建(3,1,117,18,1,3),
         [10]=按钮.创建(自适应.创建(12,4,70,20,1,3),0,0,4,true,true,"角色操作"),
         [11]=按钮.创建(自适应.创建(12,4,70,20,1,3),0,0,4,true,true,"一键参战"),


         -- [6]=资源:载入('mhbb.dll',"网易WDF动画",0xA1D2C500),
         -- [7]=资源:载入('JM.dll',"网易WDF动画",0x3906F9F1),
    }
    self.模型背景 = 自适应.创建(2,1,116,141,3,9)
    self.头像背景 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x360B8373)
    self.参战图标 = 资源:载入('新界面.wdf',"网易WDF动画",0x00000197)
    -- self.资源组[4]:置偏移(0,-1)
    -- self.资源组[5]:置偏移(0,-1)
   --- self.包围盒 = bw(0,0,110,40)
    self.boxh=50
    self.boxw=110+40
    self.数据={}
    self.窗口时间 = 0
    self.选中=0
    self.计次 = 0

   -- self.头像组={}
    self.队伍格子 = {}
    local 格子 = require("script/系统类/队伍_格子")
    for i=1,5 do
      self.队伍格子[i] = 格子.创建(0,0,i,tp)
      self.队伍格子[i]:置人物(nil)
      self.队伍格子[i].禁止 = false
    end


    --self.选择账号栏 = tp._滑块diy.创建(5,180,115,2,tp)
end


function 多开系统:打开(数据)


    if self.可视 then
        self.可视 = false
        self.选中=0
        self.计次 = 0
    else
        if 数据 == nil then 数据 = {} end
        self.数据={}
        for n=1,#数据 do
            self.数据[n] = 数据[n]
            self.数据[n].已参战 = false
            self.队伍格子[n]:置人物(self.数据[n])
            self.队伍格子[n].禁止 = false
           if 多角色操作 then
              for i=1,#tp.队伍数据 do
                if 数据[n].id ==tp.队伍数据[i].id then
                   self.数据[n].已参战 =true
                end
              end
           end
        end
        insert(tp.窗口_,self)
        tp.运行时间 = tp.运行时间 + 1
        self.窗口时间 = tp.运行时间
        self.可视 = true
        self.选中=0
        self.计次 = 0

    end
end

function 多开系统:刷新(数据)
    self.数据={}
     self.选中=0
     self.计次 = 0
    local 格子 = require("script/系统类/队伍_格子")
    for i=1,5 do
      self.队伍格子[i] = 格子.创建(0,0,i,tp)
      self.队伍格子[i]:置人物(nil)
      self.队伍格子[i].禁止 = false
    end

    self.数据={}
    self.数据={}
    for n=1,#数据 do
            self.数据[n] = 数据[n]
            self.数据[n].已参战 = false
            self.队伍格子[n]:置人物(self.数据[n])
            self.队伍格子[n].禁止 = false
           if 多角色操作 then
              for i=1,#tp.队伍数据 do
                if 数据[n].id ==tp.队伍数据[i].id then
                   self.数据[n].已参战 =true
                end
              end
           end
      end


end

function 多开系统:显示(dt,x,y)

    self.焦点 = false
    self.资源组[1]:显示(self.x,self.y)
    self.资源组[3]:显示(self.x+2,self.y+2)
    tp.窗口标题背景_[5]:显示(self.x+self.资源组[1].宽度/2-68,self.y+2)
    zts1:置颜色(0xFFFFFFFF):显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"多角色操作")
     self.资源组[2]:更新(x,y)
    self.资源组[2]:显示(self.x+600,self.y+2)
  --  self.资源组[9]:显示(self.x+12,self.y+29)

    if self.资源组[2]:事件判断()  then
        self:打开()
    end

    self.资源组[4]:更新(x,y,#self.数据<5)
    self.资源组[5]:更新(x,y,self.选中~=nil)
    self.资源组[6]:更新(x,y,self.选中~=nil)
    self.资源组[7]:更新(x,y,self.选中~=nil)
    self.资源组[8]:更新(x,y)
    self.资源组[10]:更新(x,y,self.选中~=nil)
    self.资源组[11]:更新(x,y,#self.数据>0)
    self.资源组[4]:显示(self.x+10,self.y+250)
    self.资源组[5]:显示(self.x+90,self.y+250)
    self.资源组[6]:显示(self.x+170,self.y+250)
    self.资源组[7]:显示(self.x+250,self.y+250)
    self.资源组[10]:显示(self.x+330,self.y+250)
    self.资源组[11]:显示(self.x+410,self.y+250)
    self.资源组[8]:显示(self.x+490,self.y+250)
    for i=1,5 do
        self.模型背景:显示(self.x-110+i*120,self.y+25)
        self.资源组[9]:显示(self.x-110+i*120,self.y+170)
        self.资源组[9]:显示(self.x-110+i*120,self.y+194)
        self.资源组[9]:显示(self.x-110+i*120,self.y+218)
    end
    if self.计次时间 and os.time()-self.计次时间>=1 then
      self.计次= 0
      self.计次时间 = nil
    end
    for n=1,#self.数据 do
          self.队伍格子[n]:置坐标(self.x -110+n*120,self.y +25)
          self.队伍格子[n]:显示(dt,x,y,self.鼠标,self.数据,-8,-5)
          if self.数据[n].已参战 then
              self.参战图标:显示(self.x -35+n*120,self.y +30)
              if self.参战图标:是否选中(x,y) then
                  tp.提示:自定义(x,y,"#Y/该角色已参战")
              end
          end

          if self.队伍格子[n].事件 then
              if self.选中 ~= nil and self.选中 ~= 0 and self.选中 ~= n then
                  self.队伍格子[self.选中].禁止 = false
              end
              if self.选中 ~= nil and self.选中 ~= 0 and self.选中 == n then
                  self.队伍格子[self.选中].禁止 = true
                  self.计次 = self.计次 +1
                  self.计次时间 = os.time()
                  if self.计次>=2 then
                      self.计次 = 0
                      请求服务(63,{参数=self.数据[self.选中].id,文本="角色参战"})
                      self:打开()
                  end
              else
                  self.选中 = n
                  self.队伍格子[n].禁止 = true
                  self.计次 = 1
                  self.计次时间 = os.time()
              end
          end
      end
      if 引擎.按键按住(KEY.ALT) and not tp.战斗中 then
          if 引擎.按键按下(KEY._2) and self.数据[1] then
                  if self.选中 ~= nil and self.选中 ~= 0 and self.选中~=1 then
                      self.队伍格子[self.选中].禁止 = false
                  end
                  self.选中 = 1
                  self.队伍格子[1].禁止 = true
                  if self.数据[1].已参战 then
                        请求服务(63,{参数=self.数据[1].id,文本="角色操作"})
                  else
                        请求服务(63,{参数=self.数据[1].id,文本="角色参战"})
                  end
          elseif 引擎.按键按下(KEY._3) and self.数据[2]  then
                  if self.选中 ~= nil and self.选中 ~= 0 and self.选中~=2 then
                      self.队伍格子[self.选中].禁止 = false
                  end
                  self.选中 = 2
                  self.队伍格子[2].禁止 = true
                  if self.数据[2].已参战 then
                        请求服务(63,{参数=self.数据[2].id,文本="角色操作"})
                  else
                        请求服务(63,{参数=self.数据[2].id,文本="角色参战"})
                  end
          elseif 引擎.按键按下(KEY._4) and self.数据[3] then
                  if self.选中 ~= nil and self.选中 ~= 0 and self.选中~=3 then
                      self.队伍格子[self.选中].禁止 = false
                  end
                  self.选中 = 3
                  self.队伍格子[3].禁止 = true
                  if self.数据[3].已参战 then
                        请求服务(63,{参数=self.数据[3].id,文本="角色操作"})
                  else
                        请求服务(63,{参数=self.数据[3].id,文本="角色参战"})
                  end
          elseif 引擎.按键按下(KEY._5) and self.数据[4] then
                  if self.选中 ~= nil and self.选中 ~= 0 and self.选中~=4 then
                      self.队伍格子[self.选中].禁止 = false
                  end
                  self.选中 = 4
                  self.队伍格子[4].禁止 = true
                  if  self.数据[4].已参战  then
                        请求服务(63,{参数=self.数据[4].id,文本="角色操作"})
                  else
                        请求服务(63,{参数=self.数据[4].id,文本="角色参战"})
                  end
          elseif 引擎.按键按下(KEY._6) and self.数据[5] then
                  if self.选中 and self.选中 ~= 0 and self.选中~=5 then
                      self.队伍格子[self.选中].禁止 = false
                  end
                  self.选中 = 5
                  self.队伍格子[5].禁止 = true
                  if self.数据[5].已参战 then
                        请求服务(63,{参数=self.数据[5].id,文本="角色操作"})
                  else
                        请求服务(63,{参数=self.数据[5].id,文本="角色参战"})
                  end
          end
      end


   if self.资源组[4]:事件判断() then
        tp.窗口.多开创建:打开()
        self:打开()
    elseif self.资源组[5]:事件判断() then
        if self.选中 ~= nil and self.选中 ~= 0 and self.数据[self.选中] and self.数据[self.选中].id  then
             请求服务(63,{参数=self.数据[self.选中].id,文本="切换角色"})
        else
          tp.常规提示:打开("#Y/请选择角色")
        end
    elseif self.资源组[6]:事件判断() then
         if self.选中 ~= nil and self.选中 ~= 0 and self.数据[self.选中] and self.数据[self.选中].id then
             请求服务(63,{参数=self.数据[self.选中].id,文本="角色参战"})
        else
          tp.常规提示:打开("#Y/请选择角色")
        end
    elseif self.资源组[7]:事件判断() then
         if self.选中 ~= nil and self.选中 ~= 0 and self.数据[self.选中] and self.数据[self.选中].id then
             请求服务(63,{参数=self.数据[self.选中].id,文本="角色退出"})
        else
          tp.常规提示:打开("#Y/请选择角色")
        end

    elseif self.资源组[10]:事件判断() then
         if self.选中 ~= nil and self.选中 ~= 0 and self.数据[self.选中] and self.数据[self.选中].id then
             请求服务(63,{参数=self.数据[self.选中].id,文本="角色操作"})
              self:打开()
        else
          tp.常规提示:打开("#Y/请选择角色")
        end

    elseif self.资源组[11]:事件判断() then
        -- 一键参战：让所有未参战的角色同时参战
        local 未参战角色 = {}
        local 循环次数 = 0
        for i=1,#self.数据 do
            if self.数据[i] and self.数据[i].id and not self.数据[i].已参战 then
                table.insert(未参战角色, self.数据[i].id)
            end
        end
        
        if #未参战角色 > 0 then
            if #未参战角色 > 4 then
                循环次数 = 4
            else
                循环次数 = #未参战角色
            end
            -- 依次让所有未参战角色参战
            for i=1,循环次数 do
                请求服务(63,{参数=未参战角色[i],文本="角色参战"})
            end
            tp.常规提示:打开("#G/已发送一键参战指令，共" .. #未参战角色 .. "个角色")
        else
            tp.常规提示:打开("#Y/所有角色都已参战")
        end
    elseif self.资源组[8]:事件判断() then
       请求服务(63,{参数=tp.队伍[1].数字id,文本="一键退出"})
    end

end


function 多开系统:检查点(x,y)
    if self.可视 and self.资源组[1]:是否选中(x,y)  then
        return true
    else
        return false
    end
end

function 多开系统:初始移动(x,y)
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

function 多开系统:开始移动(x,y)
    if self.鼠标 then
        self.x = x - self.xx
        self.y = y - self.yy
    end
end
function 多开系统:更新(dt) end


return 多开系统