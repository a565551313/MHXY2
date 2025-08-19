local 选择角色 = class()

local tp
local qtx = 引擎.取头像
local mouseb = 引擎.鼠标按下
local qmx = 引擎.取模型
local qzd = 引擎.取战斗模型
local bw = require("gge包围盒")(0,0,90,120)
local box = 引擎.画矩形

function 选择角色:初始化(根)
  local 资源 = 根.资源
  self.双击 = nil
  self.时间 = 0
  tp = 根

   self.标题背景 = 资源:载入('界面修复.wdf',"网易WDF动画",0xabcde003)
    self.场景覆盖 = 资源:载入('界面修复.wdf',"网易WDF动画",0xEB3FD8C3)
    self.场景计次 = self.场景覆盖.宽度
    self.场景覆盖:置区域(self.场景计次,0,全局游戏宽度,全局游戏高度)
    self.标题背景公告 = 根._按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0xD8632D23),0,0,3,true,true)
    self.特效覆盖 = 资源:载入('界面修复.wdf',"网易WDF动画",0xEC1A0419)
    self.特效计次 = self.特效覆盖.宽度
    self.特效覆盖:置区域(self.特效计次,0,全局游戏宽度,全局游戏高度)
  local dh = {0xDC739617,0x22E6E35C,0x16CC1B46,0xD8632D20}
    self.动画 = {}
  for n=1,4 do
      self.动画[n] = 资源:载入('登陆资源.wdf',"网易WDF动画",dh[n])
  end



  local 按钮 = 根._按钮
  self.上一步 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xAADDEE47),0,0,3,true,true)
  self.创建 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xDDFFCC02),0,0,3,true,true)
  self.下一步 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xAADDCC11),0,0,3,true,true)



  self.人物下框文字 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xAADDEE20)
  self.人物列表背景 = 资源:载入('界面修复.wdf',"网易WDF动画",0xF47516C0)
  self.角色数据={}
  self.角色信息={}
  self.角色选中号码=0
   self.boxh=120
   self.boxw=90
end

function 选择角色:置方向(方向,n)
  self.创建人物精灵[n]["静立"]:置方向(方向)
  self.创建人物精灵[n]["行走"]:置方向(方向)
  self.创建人物精灵[n]["攻击"]:置方向(取四至八方向(方向))
  self.创建人物精灵[n]["施法"]:置方向(取四至八方向(方向))
end

function 选择角色:置染色(人物ID,染色方案,染色ID,方向)
  self.创建人物精灵[人物ID]["静立"]:置染色(染色方案,染色ID,染色ID,染色ID)
  self.创建人物精灵[人物ID]["行走"]:置染色(染色方案,染色ID,染色ID,染色ID)
  self.创建人物精灵[人物ID]["攻击"]:置染色(染色方案,染色ID,染色ID,染色ID)
  self.创建人物精灵[人物ID]["施法"]:置染色(染色方案,染色ID,染色ID,染色ID)
  self:置方向(方向,人物ID)
end

function 选择角色:后退方向()
  if self.方向 < 7 then
    self.方向 = self.方向 + 1
    self:置方向(self.方向,self.选中人物)
  else
    self.方向 = 0
    self:置方向(self.方向,self.选中人物)
  end
end

function 选择角色:前进方向()
  if self.方向 >= 1 then
    self.方向 = self.方向 - 1
    self:置方向(self.方向,self.选中人物)
  else
    self.方向 = 7
    self:置方向(self.方向,self.选中人物)
  end
end

function 选择角色:更新(dt)

end

function 选择角色:显示(dt,x,y)
  self.标题背景:置区域(self.特效计次,0,全局游戏宽度,全局游戏高度)
    self.标题背景:显示(0,-200)
  self.场景计次 = self.场景计次 - 0.3
  self.场景覆盖:置区域(self.场景计次,0,全局游戏宽度,全局游戏高度)
   self.场景覆盖:显示(0,550)
  for n=1,4 do
    self.动画[n]:更新(dt)
      self.动画[n]:显示(全局游戏宽度-600 + (n-1) *110,全局游戏高度-100)
  end
  if self.特效覆盖 ~= nil then
    self.特效计次 = self.特效计次 - 0.7
    self.特效覆盖:置区域(self.特效计次,0,全局游戏宽度,全局游戏高度)
    self.特效覆盖:显示(0,全局游戏高度)
  end

   self.人物下框文字:显示(165,475)
    self.人物列表背景:显示(260,160)
    self.上一步:更新(x,y)
    self.下一步:更新(x,y)
    self.创建:更新(x,y)
    self.创建:显示(800-160,600-150)
    self.上一步:显示(800-160,600-100)


    local xx = 0
    local yy = 0
    for i=1,6 do
       if self.角色数据[i]~=nil then
          self.角色数据[i]:更新(全局dt)
          self.角色数据[i]:显示(310+xx*100,260+yy*130)
          local zx,zy = 265+xx*100,165+yy*(self.boxh+10)
          bw:置坐标(zx,zy)
            if bw:检查点(x,y) then
                if 引擎.鼠标弹起(0) then
                  self.角色选中号码=i

                end
                box(zx-2,zy-2,zx+self.boxw,zy+self.boxh,1677721855)
            end
            if self.角色选中号码 == i then
                box(zx-2,zy-2,zx+self.boxw,zy+self.boxh,1677721855)
            end
          xx =xx +1
          if xx>=3 then
            xx = 0
            yy = yy +1
          end
        end
    end


    for n=1,#self.角色数据 do
         if self.角色选中号码==n then
                if 引擎.鼠标弹起(0) then
                      if self.双击 == nil then
                        self.事件 = true
                        self.双击 = 1
                        self.角色选中=self.角色选中号码
                      else
                        self.事件 = nil
                        self.载入 = 1
                      end
                end
                if self.双击 == 1 then
                      self.时间 = self.时间 + 1
                      if self.时间 >= 16 then
                        self.双击 = nil
                        self.时间 = 0
                      end
                end
                if self.载入 ~= nil then
                    if self.角色选中~=self.角色选中号码 then
                      self.双击 = nil
                      self.时间 = 0
                      self.载入 = nil
                      return
                    else
                      系统参数.选中玩家id = self.角色选中号码
                      客户端:请求服务(4,self.角色选中号码..fgc..f函数.取硬盘序列号())
                      全局登陆内容()
                      self.载入 = nil
                    end
                end
          end
    end


    if self.角色选中号码~=0 then
      tp.字体表.普通字体:置颜色(白色)
      tp.字体表.普通字体:显示(101+140,527-45,self.角色信息[self.角色选中号码].名称)
      tp.字体表.普通字体:显示(338+140,527-45,self.角色信息[self.角色选中号码].id)
      tp.字体表.普通字体:显示(101+140,562-45,self.角色信息[self.角色选中号码].等级)
      tp.字体表.普通字体:显示(338+140,562-45,self.角色信息[self.角色选中号码].门派)
      self.下一步:显示(800-160,600-50)
    end
 self.下一步:显示(800-160,600-50)


  if self.创建:事件判断() then
    tp.创建:刷新位置()
    客户端:请求服务(2)
    tp.创建.种族选中 = "人"
    tp.创建.选中人物 = 1
  elseif self.上一步:事件判断() then
    self.焦点 = 0
    self.上一焦点 = 0
    self.角色选中号码=0
    tp.进程 = 7
    tp.登陆.账号输入框:置可视(true,true)
    tp.登陆.密码输入框:置可视(true,true)
    系统退出=true
  elseif self.下一步:事件判断() then
    if self.角色选中号码==0 then
      tp.常规提示:打开("#y/请先选择一个角色")
      return 0
    else
      系统参数.选中玩家id = self.角色选中号码
      客户端:请求服务(4,self.角色选中号码..fgc..f函数.取硬盘序列号())
    end
  end
end

function 选择角色:添加角色信息(信息)
  self.角色数据={}
  self.角色信息={}
  for n=1,#信息 do
    self.角色数据[n]= require("script/初系统/选择角色动画")(1,tp,信息[n].造型,信息[n].武器数据,信息[n].染色组,信息[n].染色方案,信息[n].锦衣数据,信息[n].光环数据,信息[n].足迹数据,信息[n].称号数据,信息[n].魂兽数据) --信息[n].武器数据
    self.角色信息[n]=信息[n]
  end
  tp.进程 = 2
  tp.选中窗口 = nil
end

return 选择角色