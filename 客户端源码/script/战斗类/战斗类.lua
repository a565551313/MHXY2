--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-06-08 18:55:29
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 战斗类 = class()
local FSB = require("script/资源类/FSB")
local tp
local 精灵类 = require("script/资源类/gge精灵类")

function 战斗类:初始化(根)
    tp = 根
    self.纯色背景 = require("gge精灵类")(0,0,0,全局游戏宽度+500,全局游戏高度+300)
    self.纯色背景:置颜色(ARGB(160,3,20,70))
    self.黑幕背景 = require("gge精灵类")(0,0,0,全局游戏宽度+500,全局游戏高度+300)
    self.黑幕背景:置颜色(0xFF000000)
    self.蓝色背景 = require("gge精灵类")(0,0,0,全局游戏宽度+500,全局游戏高度+300)
    self.蓝色背景:置颜色(-1189208494)
    self.红色背景 = require("gge精灵类")(0,0,0,全局游戏宽度+500,全局游戏高度+300)
    self.红色背景:置颜色(-2189208494)
    self.战斗背景 = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x00D17553)
    self.蜈蚣精显示 = false
    self.蜈蚣精地图 = tp.资源:载入(wdf配置.."/pic/蜈蚣精地图.png", "图片")
    self.战斗圆背景 = tp.资源:载入('战斗背景.npk',"网易WDF动画","侵蚀底图")
    self.背景状态 = 0
    self.回合进程="加载"
    self.加载数量=0
    self.战斗单位={}
    self.回合数 = 0
    self.观战模式=false
    self.战斗类型=0
    self.观战按钮 = 根._按钮.创建(根._自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"退出观战")
    self.切换阵营 = 根._按钮.创建(根._自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"切换对阵")
    self.血条背景 = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x4D0A334C)
    self.血条栏 = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x4FD9FFF3)
    self.战斗指令=战斗指令类
    self.进程="等待"
    self.自动开关=false
    self.自动按钮=根._按钮.创建(根._自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"开启自动")
    self.数字图片=tp.战斗文字[5]
    self.请等待=tp.资源:载入('登陆资源.wdf',"网易WDF动画",0xEE1713AC)
    self.拼接偏移 = 生成XY()
    self.法宝图片 = tp.战斗文字[1]
    self.战斗快捷键法术=nil
    self.宠物战斗快捷键法术=nil
    self.我方阵型=nil
    self.敌方阵型=nil
    self.误差={x=0,y=0}
    self.横条 = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0XE03A06B3)
    self.竖条 = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0X17CE9691)
    -- self.我方头像开关=true
    -- self.敌方头像开关=true
    -- self.我方头像组={}
    -- self.敌方头像组={}
    self.连击背景=tp.资源:载入('jljnsc.wdf',"网易WDF动画",0x00000024)
    self.连击动画=tp.资源:载入('jljnsc.wdf',"网易WDF动画",0x00000025)
    self.过度纹理 = require("gge纹理类")():渲染目标(全局游戏宽度,全局游戏高度)
    self.多角色自动栏 = require("script/战斗类/多角色自动栏").创建(根)
    self.窗口 = {
        自动栏 = require("script/战斗类/战斗自动栏").创建(根)
      }
    self.窗口_ = {
        [1] = self.窗口.自动栏,
      }
    self.选中窗口 = 0
end

function 战斗类:进入获取分辨率()
  if 全局游戏宽度==800 and  全局游戏高度==600 then
    self.误差={x=0,y=0}
    elseif 全局游戏宽度==1024 and 全局游戏高度==768 then
    self.误差={x=87,y=74}
    elseif 全局游戏宽度==1280 and 全局游戏高度==720 then
    self.误差={x=215,y=50}
    elseif 全局游戏宽度==1280 and 全局游戏高度==768 then
    self.误差={x=215,y=74}
    elseif 全局游戏宽度==1280 and 全局游戏高度==800 then
    self.误差={x=215,y=90}
  else
    self.误差={x=0,y=0}
  end
end
function 战斗类:进入战斗过度()
          引擎.截图到纹理(self.过度纹理)
          self.过度精灵 = 精灵类(self.过度纹理)
          self.过度精灵1 = 精灵类(self.过度纹理)
          self.过度精灵1:置区域(0,0,全局游戏宽度/2,全局游戏高度/2)
          self.过度精灵2 = 精灵类(self.过度纹理)
          self.过度精灵2:置区域(全局游戏宽度/2,0,全局游戏宽度/2,全局游戏高度/2)
          self.过度精灵3 = 精灵类(self.过度纹理)
          self.过度精灵3:置区域(0,全局游戏宽度/2,全局游戏宽度/2,全局游戏高度/2)
          self.过度精灵4 = 精灵类(self.过度纹理)
          self.过度精灵4:置区域(全局游戏宽度/2,全局游戏高度/2,全局游戏宽度/2,全局游戏高度/2)
          self.过度坐标1 = {x=0,y=0}
          self.过度坐标2 = {x=全局游戏宽度/2,y=0}
          self.过度坐标3 = {x=0,y=全局游戏高度/2}
          self.过度坐标4 = {x = 全局游戏宽度/2,y = 全局游戏高度/2}
          self.过度进度 = 255
          self.过度时间 = 7
end
function 战斗类:退出战斗过度()
  引擎.截图到纹理(引擎.场景.场景.过度纹理)
  引擎.场景.场景.过度精灵 = 精灵类(引擎.场景.场景.过度纹理)
  引擎.场景.场景.过度进度 = 255
  引擎.场景.场景.过度时间 = 3
  引擎.场景.场景.过度减少 = 5
end





function 战斗类:设置命令回合(数据)
  self.战斗指令:更新类型(数据)
  self.进程="命令"
  self.命令数据={计时=时间,分=9,秒=9}
  if self.窗口.自动栏.可视 and self.窗口.自动栏.状态~= "开启" then
     self.窗口.自动栏.回合计数 =self.窗口.自动栏.回合计数-1
  end

end
function 战斗类:设置重连命令回合(数据,分,秒)
  self.战斗指令:更新类型(数据)
  self.进程="命令"
  self.命令数据={计时=时间,分=分,秒=秒}
  if self.窗口.自动栏.可视  then
     self.窗口.自动栏.回合计数 = 66
  end
end
function 战斗类:设置血量同步(数据)
  for k=1,#数据 do
    if self.战斗单位[k] and 数据[k] then
        self.战斗单位[k].最大气血= 数据[k].最大气血
        self.战斗单位[k].气血上限= 数据[k].气血上限
        self.战斗单位[k].气血=数据[k].气血
        self.战斗单位[k].魔法=数据[k].魔法
        self.战斗单位[k].最大魔法=数据[k].最大魔法
        self.战斗单位[k].愤怒=数据[k].愤怒
        if tp.队伍[1].数字id == self.战斗单位[k].数据.id then
          if self.战斗单位[k].数据.类型 == "角色" then
            tp.队伍[1].气血=数据[k].气血
            tp.队伍[1].气血上限=数据[k].气血上限
            tp.队伍[1].最大气血=数据[k].最大气血
            tp.队伍[1].魔法=数据[k].魔法
            tp.队伍[1].最大魔法=数据[k].最大魔法
            tp.队伍[1].愤怒=数据[k].愤怒
          elseif self.战斗单位[k].数据.类型 == "bb" then
            tp.队伍[1].参战宝宝.气血=数据[k].气血
            tp.队伍[1].参战宝宝.最大气血=数据[k].最大气血
            tp.队伍[1].参战宝宝.魔法=数据[k].魔法
            tp.队伍[1].参战宝宝.最大魔法=数据[k].最大魔法
          end
        end
    end
  end
end

function 战斗类:设置魔法愤怒同步(数据)
  for k=1,#数据 do
    if self.战斗单位[k]~=nil then
      self.战斗单位[k].魔法=数据[k].魔法
      self.战斗单位[k].最大魔法=数据[k].最大魔法
      self.战斗单位[k].愤怒=数据[k].愤怒
      if tp.队伍[1].数字id == self.战斗单位[k].数据.id then
        if self.战斗单位[k].数据.类型 == "角色" then
          tp.队伍[1].魔法=数据[k].魔法
          tp.队伍[1].最大魔法=数据[k].最大魔法
          tp.队伍[1].愤怒=数据[k].愤怒
        elseif self.战斗单位[k].数据.类型 == "bb" then
          tp.队伍[1].参战宝宝.魔法=数据[k].魔法
          tp.队伍[1].参战宝宝.最大魔法=数据[k].最大魔法
        end
      end
    end
  end
end





function 战斗类:是否开启自动()
          for k,v in pairs(self.战斗单位) do
              if v.类型=="角色" and v.数据.id==tp.队伍[1].数字id  then
                  if v.数据.自动战斗 then
                      self.自动开关=true
                  else
                      self.自动开关=false
                  end
              end
          end
end

function 战斗类:加载单位(数据,观战)
          local 编号 = #self.战斗单位+1
          self.战斗单位[编号]=战斗单位类()
          self.战斗单位[编号]:创建单位(数据,self.队伍id,编号)
          if 数据.模型 == "蜈蚣精" then
              self.蜈蚣精显示 = true
          end
          local 资源

          if not self.我方阵型 and self.战斗单位[编号].敌我==1 then
              self.我方阵型 = self.战斗单位[编号].数据.附加阵法
              local 资源 = 引擎.取阵法效果(self.战斗单位[编号].数据.附加阵法)
              self.我方阵法 = tp.资源:载入(资源[2],"网易WDF动画",资源[1])
          end
          if not self.敌方阵型 and self.战斗单位[编号].敌我==2 then
              self.敌方阵型 = self.战斗单位[编号].数据.附加阵法
              local 资源 = 引擎.取阵法效果(self.战斗单位[编号].数据.附加阵法)
              self.敌方阵法 = tp.资源:载入(资源[2],"网易WDF动画",资源[1])
          end
          --self:加载单位头像(self.战斗单位[编号],编号)
          if #self.战斗单位==self.单位总数 then
              请求服务(5501,{名称=tp.队伍[1].名称})
              self:是否开启自动()
          end
          if 观战~= nil then
              self.观战模式=true
               if 数据.战斗类型 ~= nil and ( 数据.战斗类型 == 410005 or 数据.战斗类型 == 200001  or 数据.战斗类型 == 200002 or 数据.战斗类型 == 200003 or 数据.战斗类型 == 200004 or 数据.战斗类型 == 200005 or 数据.战斗类型 == 200006 or 数据.战斗类型 == 200007 or 数据.战斗类型 == 200008 or 数据.战斗类型 == 200009)then
                 self.战斗类型=数据.战斗类型
               end
          end
end












-- function 战斗类:加载单位头像(单位,编号)
--   if 单位.数据.类型=="角色" or 单位.数据.类型=="系统角色" or 单位.数据.类型=="系统PK角色" then
--     if 单位.敌我==1 then
--       local x = 引擎.取头像(单位.模型)
--       self.我方头像组[#self.我方头像组+1]=tp._按钮.创建(tp.资源:载入(x[7],"网易WDF动画",x[2]),0,0,1)
--       self.我方头像组[#self.我方头像组].num=编号
--       self.我方头像组[#self.我方头像组].敌我=单位.敌我
--       self.我方头像组[#self.我方头像组].名称=单位.数据.名称
--       self.我方头像组[#self.我方头像组].门派=单位.数据.门派
--       self.我方头像组[#self.我方头像组].等级=单位.数据.等级
--       self.我方头像组[#self.我方头像组].气血=单位.数据.气血
--       self.我方头像组[#self.我方头像组].最大气血=单位.数据.最大气血
--       self.我方头像组[#self.我方头像组].魔法=单位.数据.魔法
--       self.我方头像组[#self.我方头像组].最大魔法=单位.数据.最大魔法
--       self.我方头像组[#self.我方头像组].愤怒=单位.数据.愤怒
--     else
--       local x = 引擎.取头像(单位.模型)
--       self.敌方头像组[#self.敌方头像组+1]=tp._按钮.创建(tp.资源:载入(x[7],"网易WDF动画",x[2]),0,0,1)
--       self.敌方头像组[#self.敌方头像组].num=编号
--       self.敌方头像组[#self.敌方头像组].敌我=单位.敌我
--       self.敌方头像组[#self.敌方头像组].名称=单位.数据.名称
--       self.敌方头像组[#self.敌方头像组].门派=单位.数据.门派
--       self.敌方头像组[#self.敌方头像组].等级=单位.数据.等级
--     end
--   end
-- end

function 战斗类:设置战斗流程(内容)
  self.战斗流程=内容

  for n=1,#self.战斗流程 do
    if self.战斗流程[n] then
        self.战斗流程[n].执行=false
        self.战斗流程[n].允许=false
    end
  end
  if #self.战斗流程==0 then
      self.进程="等待"
      请求服务(发送流程)
      return
  end
 self.进程="计算"
end

function 战斗类:鬼魂复活(内容)
  self.战斗单位[内容.id].停止更新=false
  self.战斗单位[内容.id]:换动作("待战")
  self.战斗单位[内容.id]:设置掉血(内容.气血,2)
end


function 战斗类:取消状态(内容)
    if 内容.id and 内容.名称 and self.战斗单位[内容.id] then
        self.战斗单位[内容.id]:取消状态(内容.名称)
    end
end

function 战斗类:刷新技能(内容)
  self.战斗单位[内容.id].主动技能=内容.主动技能
end



function 战斗类:状态同步(内容,序号)
    local 不是状态 ={ 战意=true,超级战意=true,风灵=true,剑意=true,灵药红=true,灵药蓝=true,灵药黄=true,
                     符咒=true,雷法崩裂=true,雷法震煞=true,雷法坤伏=true,雷法翻天=true,雷法倒海=true,
                     五行珠金=true,五行珠木=true,五行珠水=true,五行珠火=true,五行珠土=true,人参娃娃=true,
                     护盾=true,护体灵盾=true
    }


    for k,v in pairs(内容) do
        if type(v) =="table" and self.战斗单位[k] then
            for z,n in pairs(v) do
                if not 不是状态[z] and self.战斗单位[k].状态特效  then
                    if self.战斗单位[k].状态特效[z] and n.回合 and type(self.战斗单位[k].状态特效[z])=="table"  then
                        self.战斗单位[k].状态特效[z].回合=n.回合
                    end
                else
                    if z=="护盾" or z=="护体灵盾" then
                        if self.战斗单位[k].状态特效.护盾 then
                            if n.回合 then
                                self.战斗单位[k].状态特效.护盾.回合 = n.回合
                            end
                            if n.护盾值 and n.护盾值~=0 then
                                self.战斗单位[k].状态特效.护盾.护盾值 = n.护盾值
                            else
                                 self.战斗单位[k]:取消状态("护盾")
                            end
                        end
                    elseif 不是状态[z] and  self.战斗单位[k][z] then
                            self.战斗单位[k][z]  = n
                    end

                end
            end
            for z,n in pairs(self.战斗单位[k].状态特效) do
                if type(n)=="table" and  not n.回合 then
                    self.战斗单位[k]:取消状态(z)
                end
            end
            if 序号 and 序号==5519.1 then
                if self.战斗单位[k].气血<=0 then
                    if self.战斗单位[k].状态特效
                       and (self.战斗单位[k].状态特效.复活
                       or self.战斗单位[k].类型=="角色"
                       or self.战斗单位[k].类型=="系统角色"
                       or self.战斗单位[k].类型=="系统pk角色")
                    then
                        self.战斗单位[k]:开启击退(2)
                    else
                        self.战斗单位[k]:开启击退(1)
                    end
                else
                    for z,n in pairs(v) do
                      if not 不是状态[z] then
                          self.战斗单位[k]:增加状态(z)
                      end
                    end
                end
            end
        end
    end



end






function 战斗类:更新(dt,x,y)
          table.sort(self.窗口_,UI排序)
          if 引擎.鼠标按下(0) and self.选中窗口 ~= 0  and self.窗口_[self.选中窗口].可移动 and not tp.消息栏焦点 then
            self.窗口_[self.选中窗口]:初始移动(x,y)
          end
          if 引擎.鼠标弹起(0)  or self.隐藏UI or self.消息栏焦点 then
              self.移动窗口 = false
          end
          if self.移动窗口 then
              self.窗口_[#self.窗口_]:开始移动(x,y)
          end
          if 引擎.鼠标弹起(0) then
              self.移动窗口 = false
          end
          for n=1,#self.窗口_ do
              if self.选中窗口 ~= 0 and self.窗口_[self.选中窗口].ID == self.窗口_[n].ID then
                  self.窗口_[n].鼠标 = true
              else
                  self.窗口_[n].鼠标 = false
              end
              if not tp.隐藏UI then
                  self.窗口_[n]:更新(dt,x,y)
              else
                  if self.窗口_[n].ID == 1 then
                      self.窗口_[n]:更新(dt,x,y)
                  end
                  if self.窗口_[n].ID == 106 then
                      self.窗口_[n]:显示(dt,x,y)
                  end
              end
          end
          --战斗窗口更新结束
          local 单位选中=0
          local 选中单位 = nil
          for i=1,#self.战斗单位 do
              self.战斗单位[i]:更新(dt)
              if self.战斗单位[i]:是否选中(x,y) and 选中单位~=true then
                  选中单位=true
                  单位选中=i
                  if 引擎.鼠标弹起(右键) then
                      self.提示=i
                  end
              end

          end
          if 单位选中==0 then
              self.提示=nil
          end
          -- if 引擎.鼠标弹起(0x2) and 1==2 then
          --     local 敌方位置={}
          --     local 我方位置={}
          --     for n=1,#self.战斗单位 do
          --         if self.战斗单位[n].敌我==1 then
          --           我方位置[self.战斗单位[n].数据.位置]={x=self.战斗单位[n].显示xy.x,y=self.战斗单位[n].显示xy.y}
          --         else
          --           敌方位置[self.战斗单位[n].数据.位置]={x=self.战斗单位[n].显示xy.x,y=self.战斗单位[n].显示xy.y}
          --         end
          --     end
          -- end
          if self.进程=="命令" then
              self.战斗指令:更新(dt,x,y)
          elseif self.进程=="计算" and self.战斗流程 and self.战斗流程[1] then
                  if self.战斗流程[1].允许==false then
                      if self.战斗流程[1].提示 and self.战斗流程[1].提示.允许 then
                          self.战斗单位[self.战斗流程[1].攻击方]:提示技能(self.战斗流程[1].提示)
                      end
                      self.战斗流程[1].允许=true
                      self.执行流程=self.战斗流程[1].流程
                      self.进程="执行"
                  end
          elseif self.进程=="执行" then
                    self:流程更新()
                    self:拼接动画(dt)
                    if self.掉血流程 and (not self.拼接特效 or #self.拼接特效==0) then
                        if not self.战斗流程[1].挨打方 then
                            self.掉血流程 = nil
                        else
                            local 通过 = #self.战斗流程[1].挨打方
                            for k,v in pairs(self.战斗流程[1].挨打方) do
                                if not v.挨打方 or not self.战斗单位[v.挨打方]  or self.战斗单位[v.挨打方]:取法术状态() then
                                    通过 = 通过 - 1
                                end
                            end
                            if 通过<=0 then
                                self.掉血流程 = nil
                            end
                        end
                    end
          end
end




function 战斗类:拼接动画(dt)
    if not self.拼接特效 then return end
    for n=1,#self.拼接特效 do
      if self.拼接特效[n] then
        if self.是否延迟 then
          if self.拼接特效[n].延迟  then
            self:拼接延迟计算(n)
            break
          else
            self:拼接动画处理(n,dt)
          end
        else
          self:拼接动画处理(n,dt)
          if #self.拼接特效==self.掉血流程 then self.掉血流程=nil end
        end
      end
    end
    if #self.拼接特效==0 then self.拼接特效=nil self.背景状态=nil  end
end












function 战斗类:拼接延迟计算(n)
  if self.拼接特效[n].延迟时间==nil then
    self.拼接特效[n].延迟时间=os.clock()+self.拼接特效[n].延迟
  elseif self.拼接特效[n].延迟时间-os.clock()<=0 then
    self.拼接特效[n].延迟=nil
    self.拼接特效[n].延迟时间=nil
  end
end



function 战斗类:拼接动画处理(n,dt)
    self.拼接特效[n].特效:更新(dt*self.全屏加速)
    if type(self.掉血流程)=="number" and n>=self.掉血流程 then
        if self.掉血帧 and self.拼接特效[n].特效.当前帧 >= self.掉血帧 then
          self.掉血流程=nil
        elseif not self.掉血帧 and self.拼接特效[n].特效.当前帧>=self.拼接特效[n].特效.结束帧 then
          self.掉血流程=nil
        end
    end
    if self.拼接特效[n].特效.当前帧>=self.拼接特效[n].特效.结束帧 then
        self.拼接特效[n].特效=nil
        table.remove(self.拼接特效,n)
    end
end


--这里写太复杂了 官方不是按这样来的 晚点改
function 战斗类:取攻击位置(编号,目标)  --by老猫~~~~~
  local 攻击方,挨打方=self.战斗单位[编号],self.战斗单位[目标]
  local 临时模型=攻击方.模型
  if 攻击方.变身数据 ~= nil then
    临时模型=攻击方.变身数据
  end
  local Position=挨打方.数据.位置
  local x,y=self:攻击坐标调整(临时模型,攻击方.武器子类)
  local offset=生成XY(x,y)
  local AttackPos=两点算近战攻击坐标(挨打方.显示xy,攻击方.显示xy,offset)
  return AttackPos.x,AttackPos.y
end

function 战斗类:攻击坐标调整(模型,zl)--以防万一
  if 模型=="蛤蟆精" then
    return 30,15
  elseif 模型=="兔子怪" or 模型=="进阶蝴蝶仙子" or 模型=="风伯" or 模型=="镜妖" or 模型=="进阶芙蓉仙子" or 模型=="净瓶女娲" or 模型=="进阶画魂" then
    return 40,20
  elseif 模型=="巨蛙" or 模型=="强盗" or 模型=="浣熊" or 模型=="进阶凤凰" or 模型=="进阶鲛人" or 模型=="进阶蛟龙" or 模型=="鼠先锋" or 模型=="阴阳伞"
  or 模型=="机关鸟" or 模型=="机关人" or 模型=="进阶律法女娲" or 模型=="进阶吸血鬼" or 模型=="进阶龙龟" or 模型=="蝎子精" or 模型=="进阶狂豹人形"
  or 模型=="进阶蝎子精" or 模型=="进阶曼珠沙华" or 模型=="进阶金身罗汉" or 模型=="进阶毗舍童子" or 模型=="大大王" or (模型=="杀破狼" and zl==15)
  or (模型=="玄彩娥" and zl==5) or (模型=="英女侠" and zl==10) or (模型=="骨精灵" and zl==8) or (模型=="狐美人" and zl==10) or (模型=="鬼潇潇" and zl==6)
  or (模型=="桃夭夭" and zl==18)  then
    return 60,30
  elseif 模型=="野猪" or 模型=="大海龟" or 模型=="树怪" or 模型=="赌徒" or 模型=="大蝙蝠" or 模型=="护卫" or 模型=="章鱼" or 模型=="骷髅怪" or 模型=="狐狸精"
  or 模型=="老虎" or 模型=="野鬼" or 模型=="蜘蛛精" or 模型=="黑熊精" or 模型=="龟丞相" or 模型=="马面" or 模型=="黑山老妖" or 模型=="进阶古代瑞兽"
  or 模型=="进阶雷鸟人" or 模型=="碧水夜叉" or 模型=="进阶天将" or 模型=="进阶地狱战神" or 模型=="进阶风伯" or 模型=="如意仙子" or 模型=="犀牛将军人形" or 模型=="犀牛将军兽形"
  or 模型=="进阶锦毛貂精" or 模型=="进阶犀牛将军兽形" or 模型=="进阶野猪精" or 模型=="画魂" or 模型=="吸血鬼" or 模型=="踏云兽" or 模型=="葫芦宝贝" or 模型=="幽萤娃娃"
  or 模型=="灵鹤" or 模型=="机关兽" or 模型=="进阶灵符女娲" or 模型=="进阶踏云兽" or 模型=="进阶灵鹤" or 模型=="进阶机关鸟" or 模型=="进阶葫芦宝贝"  or 模型=="进阶机关兽"
  or 模型=="猫灵兽形" or 模型=="狂豹人形" or 模型=="狂豹兽形" or 模型=="蜃气妖" or 模型=="曼珠沙华" or 模型=="修罗傀儡鬼" or 模型=="修罗傀儡妖" or 模型=="毗舍童子"
  or 模型=="进阶混沌兽" or 模型=="进阶长眉灵猴" or 模型=="进阶巨力神猿" or 模型=="进阶蔓藤妖花" or 模型=="进阶修罗傀儡妖" or 模型=="进阶般若天女" or 模型=="超级麒麟"
  or 模型=="超级白泽" or 模型=="超级灵鹿" or 模型=="超级大象" or 模型=="超级神虎" or 模型=="超级海豚" or 模型=="超级人参娃娃" or 模型=="超级腾蛇" or 模型=="超级土地公公"
  or 模型=="超级六耳猕猴" or 模型=="镇元大仙" or 模型=="地涌夫人" or 模型=="空度禅师" or 模型=="牛魔王" or (模型=="神天兵" and zl==9) or (模型=="偃无师" and zl==16)
  or (模型=="偃无师" and zl==3) or (模型=="舞天姬" and zl==5) or (模型=="舞天姬" and zl==11) or (模型=="玄彩娥" and zl==5) or (模型=="英女侠" and zl==4)
  or (模型=="飞燕女" and zl==11) or (模型=="狐美人" and zl==6) or (模型=="桃夭夭" and zl==5) or 模型=="龙马" then
    return 70,35
  elseif 模型=="山贼" or 模型=="羊头怪" or 模型=="狼" or 模型=="蟹将" or 模型=="雷鸟人" or 模型=="天兵" or 模型=="地狱战神" or 模型=="凤凰" or 模型=="进阶天兵"
  or 模型=="进阶碧水夜叉" or 模型=="星灵仙子" or 模型=="进阶巡游天神" or 模型=="进阶百足将军" or 模型=="琴仙" or 模型=="金铙僧" or 模型=="进阶炎魔神"
  or 模型=="进阶大力金刚" or 模型=="进阶机关人" or 模型=="进阶夜罗刹" or 模型=="进阶琴仙" or 模型=="长眉灵猴" or 模型=="持国巡守" or 模型=="进阶蜃气妖" or 模型=="进阶持国巡守"
  or 模型=="进阶灵灯侍者" or 模型=="超级孔雀" or 模型=="超级灵狐" or 模型=="超级青鸾" or 模型=="超级神鸡" or 模型=="超级神蛇" or 模型=="东海龙王" or (模型=="逍遥生" and zl==3)
  or (模型=="龙太子" and zl==1) or (模型=="巨魔王" and zl==2) or (模型=="巨魔王" and zl==12) or (模型=="虎头怪" and zl==9) or (模型=="虎头怪" and zl==2)
  or (模型=="飞燕女" and zl==4) or (模型=="骨精灵" and zl==6) then
    return 80,40
  elseif 模型=="古代瑞兽" or 模型=="蝴蝶仙子" or 模型=="芙蓉仙子" or 模型=="百足将军" or 模型=="进阶阴阳伞" or 模型=="炎魔神" or 模型=="龙龟" or 模型=="鬼将"
    or 模型=="进阶巴蛇" or 模型=="进阶噬天虎" or 模型=="进阶连弩车" or 模型=="进阶金铙僧" or 模型=="巨力神猿" or 模型=="金身罗汉" or 模型=="真陀护法" or 模型=="增长巡守"
    or 模型=="灵灯侍者" or 模型=="般若天女" or 模型=="进阶狂豹兽形" or 模型=="进阶修罗傀儡鬼" or 模型=="进阶增长巡守" or 模型=="超级神龙" or 模型=="超级赤焰兽"
    or 模型=="超级大熊猫" or 模型=="超级泡泡" or 模型=="超级神牛" or 模型 == "超级小白龙" or 模型=="超级玉兔" or 模型=="超级神马" or 模型=="超级筋斗云" or 模型=="超级神猪" then
    return 90,45
  elseif 模型=="进阶犀牛将军人形" or 模型=="进阶真陀护法" or 模型=="超级神猴" or 模型=="超级神羊" or 模型=="巫奎虎" or (模型=="剑侠客" and zl==3)
    or (模型=="剑侠客" and zl==12) or (模型=="神天兵" and zl==1) then
    return 100,50
  elseif 模型=="牛妖" or 模型=="巡游天神" or 模型=="飞天" then
    return 110,55
  elseif 模型=="大力金刚" or 模型=="连弩车" or 模型=="二郎神" then
    return 130,65
  elseif 模型=="进阶蚩尤" or 模型=="沙僧" then
    return 140,70
  elseif 模型=="超级神鼠" then
    return 200,100
  end
  return 50,25
end




function 战斗类:设置状态(编号,流程)

          if not 编号 or not self.战斗单位[编号] or not 流程 then
              return
          end
          if 流程.添加状态 then
              if type(流程.添加状态)=="string" then
                   self.战斗单位[编号]:增加状态(流程.添加状态)
              elseif type(流程.添加状态)=="table" then
                    for k,v in pairs(流程.添加状态) do
                        if type(k) =="string" and type(v) =="table" then

                            self.战斗单位[编号]:增加状态(k,v)
                        elseif type(k) =="number" and type(v) =="string" then
                              self.战斗单位[编号]:增加状态(v)
                        end
                    end
              end
          end
          if 流程.取消状态 then
              if type(流程.取消状态)=="string" then
                  self.战斗单位[编号]:取消状态(流程.取消状态)
              elseif type(流程.取消状态)=="table" then
                    for k,v in pairs(流程.取消状态) do
                        if type(v)=="string" then
                            self.战斗单位[编号]:取消状态(v)
                        end
                    end
              end
          end
          if 流程.增加气血 then
              self:设置气血(编号,流程.增加气血,2)
          end
          if 流程.扣除气血 then
              self:设置气血(编号,流程.扣除气血,1)
          end
          if 流程.多人状态 then
              for k,v in pairs(流程.多人状态) do
                  if v.状态 and  self.战斗单位[v.挨打方] and not self.战斗单位[v.挨打方].状态特效[v.状态] then
                     if v.特效 then
                        self:设置特效(v.挨打方,v.特效)
                     end
                      self.战斗单位[v.挨打方]:增加状态(v.状态)
                  end

              end
          end
          if 流程.多人取消 then
              for k,v in pairs(流程.多人取消) do
                  if v.状态 and  self.战斗单位[v.挨打方] then
                      self.战斗单位[v.挨打方]:取消状态(v.状态)
                  end
              end
          end
          流程.扣除气血 = nil
          流程.增加气血 = nil
          流程.添加状态 = nil
          流程.取消状态 = nil
          流程.多人状态 = nil
end

function 战斗类:设置特效(编号,特效,法术)
          if not 特效 or not 编号 or not self.战斗单位[编号] then return end
          if type(特效)=="string" then
              if 法术 then
                  self.战斗单位[编号]:添加法术特效(特效)
              else
                  self.战斗单位[编号]:添加攻击特效(特效)
              end
          elseif type(特效)=="table" then
                  for k,v in pairs(特效) do
                      if type(v)=="string" then
                          if 法术 then
                              self.战斗单位[编号]:添加法术特效(v)
                          else
                              self.战斗单位[编号]:添加攻击特效(v)
                          end
                      end
                  end
          end
end



function 战斗类:设置动作(编号,动作,复原,更新)
          if not 动作 or not 编号 or not self.战斗单位[编号] then return end
          self.战斗单位[编号]:换动作(动作,复原,更新)
end

function 战斗类:设置攻击帧(编号,动作)
          if not 编号 or not self.战斗单位[编号] then return end
          if 动作 then
              self.战斗单位[编号]:置帧率(动作,0.11)
          else
              self.战斗单位[编号]:置帧率("攻击",0.11)
          end

end

function 战斗类:设置气血(编号,掉血,类型,护盾,伤势,伤势类型)
          if not 编号 or not self.战斗单位[编号] then return end
          if 掉血 then
              if 类型 then
                  self.战斗单位[编号]:设置掉血(掉血,类型,护盾)
              else
                  self.战斗单位[编号]:设置掉血(掉血,1,护盾)
              end
          end
          if 伤势 then
              if 伤势类型 then
                  self.战斗单位[编号]:设置伤势(伤势,伤势类型)
              else
                  self.战斗单位[编号]:设置伤势(伤势,1)
              end
          end

end

function 战斗类:设置抖动(编号,停止)
           if not 编号 or not self.战斗单位[编号] then return end
           if 停止 then
              self.战斗单位[编号]:停止抖动()
           else
               self.战斗单位[编号]:开始抖动()
           end
end

function 战斗类:设置击退(编号,死亡)
          if not 编号 or not self.战斗单位[编号] then return end
          self.战斗单位[编号]:开启击退(死亡)
end

function 战斗类:设置死亡(编号,死亡)
          if not 编号 or not self.战斗单位[编号] then return end
          self.战斗单位[编号]:设置死亡(死亡)
end

function 战斗类:取状态(编号)
        return 编号 and self.战斗单位[编号] and self.战斗单位[编号]:取状态()
end

function 战斗类:取进攻完毕(编号)
        return self:取状态(编号) and self.战斗单位[编号].动作~="攻击" and self.战斗单位[编号].动作~="暴击"
end

function 战斗类:开启移动(编号,目标)
          if self.战斗单位[编号].移动开关 then return end
          self.战斗单位[编号].移动开关=true
          self.战斗单位[编号].移动坐标.x,self.战斗单位[编号].移动坐标.y = self:取攻击位置(编号,目标)
          local 速度 = 取两点距离(生成XY(self.战斗单位[目标].初始xy.x,self.战斗单位[目标].初始xy.y),生成XY(self.战斗单位[编号].初始xy.x,self.战斗单位[编号].初始xy.y))
          self.战斗单位[编号].移动速度=math.max(速度/25,15)
end

function 战斗类:中路移动(编号)
        if self.战斗单位[编号].移动开关 then return end
        self.战斗单位[编号].移动开关=true
        self.战斗单位[编号].移动坐标.x,self.战斗单位[编号].移动坐标.y=math.floor(全局游戏宽度/2),math.floor(全局游戏高度/2)
        local Distancce=取两点距离(生成XY(self.战斗单位[编号].移动坐标.x,self.战斗单位[编号].移动坐标.y),生成XY(self.战斗单位[编号].初始xy.x,self.战斗单位[编号].初始xy.y))
        self.战斗单位[编号].移动速度=math.max(Distancce/25,15)


end

function 战斗类:开启返回(编号)
          if self.战斗单位[编号].返回开关 then return end
          self.战斗单位[编号].返回开关=true
          self.战斗单位[编号].移动坐标.x=self.战斗单位[编号].初始xy.x
          self.战斗单位[编号].移动坐标.y=self.战斗单位[编号].初始xy.y

end


function 战斗类:开启分身(编号,挨打)
          self.战斗单位[编号]:关闭影子()
          if 挨打 and 挨打[1] then
              for k,v in pairs(挨打) do
                  local 坐标={x=0,y=0}
                  坐标.x,坐标.y=self:取攻击位置(编号,v.挨打方)
                  local 速度 = 取两点距离(生成XY(self.战斗单位[v.挨打方].初始xy.x,self.战斗单位[v.挨打方].初始xy.y),生成XY(self.战斗单位[编号].初始xy.x,self.战斗单位[编号].初始xy.y))
                  local 移动速度 = math.max(速度/25,15)
                  local 移动表={移动坐标=坐标,移动速度=移动速度}
                  self.战斗单位[编号]:设置影子动画(移动表,k)
              end
              self.战斗单位[编号]:开启影子(#挨打)
          end
end



function 战斗类:单位方向(编号,目标)
          local Angle=取两点角度(生成XY(self.战斗单位[编号].显示xy.x,self.战斗单位[编号].显示xy.y),生成XY(self.战斗单位[目标].显示xy.x,self.战斗单位[目标].显示xy.y))
          return 角度算四方向(Angle)
end




function 战斗类:取物理攻击中(编号)
          if not 编号 or not self.战斗单位[编号] then return true end
          return self.战斗单位[编号]:取间隔() >= self.战斗单位[编号]:取中间()+(self.战斗单位[编号].攻击帧 or 0)
end

function 战斗类:取法术攻击中(编号)
          if not 编号 or not self.战斗单位[编号] then return true end
          return self.战斗单位[编号]:取间隔() >= self.战斗单位[编号]:取中间()
end



function 战斗类:取停止移动(编号)
          if not 编号 or not self.战斗单位[编号] then return true end
          return  not self.战斗单位[编号].移动开关 and not self.战斗单位[编号].影子移动
end



function 战斗类:物理特效处理(流程)
          local 返回 = "攻击"
          for k,v in pairs(流程.特效) do
              if v=="力劈华山" or v=="暴击" then
                  返回 = "暴击"
              end
          end
          if 流程.类型 == 3 and 返回 ~= "暴击" then
              table.insert(流程.特效,"暴击")
              返回 = "暴击"
          end
          return 返回
end





function 战斗类:躲避流程处理(编号)
          self.战斗单位[编号]:开启躲避()
          self:设置抖动(编号,1)
          self:设置动作(编号,"待战",nil,true)
end


function 战斗类:反震反击开始(编号,流程,挨打)
          if  self:取进攻完毕(编号) then
              if 流程.反震伤害 then
                    self:设置特效(编号,"反震")
                    self:设置动作(编号,"挨打",nil,true)
                    self:设置气血(编号,流程.反震伤害,1)
                    self:设置击退(编号)
                    流程.反震伤害 = nil
                    return  17
              elseif 流程.反击伤害 then
                      for k,v in pairs(挨打) do
                          self:设置攻击帧(v.挨打方)
                      end
                      return 5
              else
                    return  17
              end
          end
          return false
end

function 战斗类:反击流程开始(编号,挨打)
          local 通过 = #挨打
          for k,v in pairs(挨打) do
              if v.死亡 or v.死亡1 or self:取状态(v.挨打方) then
                  if not v.死亡 and not v.死亡1 then
                    self:设置动作(v.挨打方,"攻击",true)
                  end
                  通过 = 通过 - 1
              end
          end
          if 通过<=0 then
              return true
          else
              return false
          end
end





function 战斗类:反击流程动作(编号,流程,挨打)
           local 通过 = #挨打
            for k,v in pairs(挨打) do
                if v.死亡 or v.死亡1 or self:取物理攻击中(v.挨打方) then
                    通过 = 通过 - 1
                end
            end
          if 通过<=0 then
              self:设置特效(编号,"被击中")
              self:设置动作(编号,"挨打",nil,true)
              self:设置气血(编号,流程.反击伤害,1)
              self:设置击退(编号)
              流程.反击伤害 = nil
              return true
          end
          return false
end

function 战斗类:反击流程结束(挨打)
          local 通过 = #挨打
          for k,v in pairs(挨打) do
              if self:取进攻完毕(v.挨打方) then
                  通过 = 通过 - 1
              end
          end
          if 通过<=0 then
              return true
          else
              return false
          end
end


function 战斗类:保护流程开始(编号,目标,保护)
            self:设置特效(保护,"保护",1)
            self.战斗单位[保护].移动开关=true
            local 保护坐标=两点算保护坐标(self.战斗单位[目标].显示xy,self.战斗单位[编号].显示xy)
            self.战斗单位[保护].移动坐标=保护坐标
            self.战斗单位[保护].移动速度= 10
            local 临时音乐=引擎.取音效("保护")
            if 游戏音效>0 and 临时音乐~=nil then
                self:音效类(临时音乐.文件,临时音乐.资源,'1')
            end
            self.执行流程=11
end


function 战斗类:保护流程动作(编号,保护,挨打)
          if self:取停止移动(保护) then
              self.战斗单位[保护].方向 = self.战斗单位[保护].初始方向
              self.战斗单位[保护]:换方向(self.战斗单位[保护].初始方向)
              self:设置动作(保护,"待战",nil,true)
              local 动作 = self:物理特效处理(挨打)
              self:设置动作(编号,动作,true)
              self:设置攻击帧(编号,动作)
              self.执行流程 = 12
          end
end

function 战斗类:保护流程攻击(编号,目标,保护,挨打)
           if self:取物理攻击中(编号) then
                self:设置物理掉血(目标,挨打)
                self:设置特效(保护.编号,"被击中")
                self:设置动作(保护.编号,"挨打",nil,true)
                self:设置气血(保护.编号,保护.伤害,挨打.类型)
                self:设置击退(保护.编号)
                self.执行流程 = 13
          end
end

function 战斗类:保护流程返回(编号,保护)
          if self:取进攻完毕(编号) then
              self.战斗单位[保护].返回开关=true
              self.战斗单位[保护].移动坐标.x=self.战斗单位[保护].初始xy.x
              self.战斗单位[保护].移动坐标.y=self.战斗单位[保护].初始xy.y
              self.战斗单位[保护].移动速度 = 10
              self.执行流程 = 14
          end
end

function 战斗类:保护流程结束(保护,流程)
           if self:取状态(保护.编号) then
              self.战斗单位[保护.编号].方向 = self.战斗单位[保护.编号].初始方向
              self.战斗单位[保护.编号]:换方向(self.战斗单位[保护.编号].初始方向)
              self.战斗单位[保护.编号].显示xy.x=self.战斗单位[保护.编号].初始xy.x
              self.战斗单位[保护.编号].显示xy.y=self.战斗单位[保护.编号].初始xy.y
              if 保护.死亡 then
                  self:设置死亡(保护.编号,保护.死亡)
              end
              if 流程.反震伤害 or 流程.反击伤害 then
                  self.执行流程=4
                else
                  self.执行流程=17
              end
          end
end

function 战斗类:物理返回流程(编号,流程,挨打)
          if self:取进攻完毕(编号) then
              for k,v in pairs(挨打) do
                  if v.死亡 then
                      self:设置死亡(v.挨打方,v.死亡)
                  end
                  if v.死亡1 then
                      self:设置死亡(v.挨打方,v.死亡1)
                  end
              end
              self:设置气血(编号,流程.减少气血,1)
              if 流程.反击死亡 or 流程.反震死亡 or 流程.返回 then
                  if self.战斗单位[编号].影子开关 then
                      self.战斗单位[编号].影子返回=true
                      return 38
                  else
                      self:开启返回(编号)
                      return 18
                  end
              else
                   return 20
              end
          end
          return false
end








function 战斗类:物理结束流程(编号,流程,挨打)
          local 通过 = #挨打
          for k,v in pairs(挨打) do
              if self:取状态(v.挨打方) then
                 通过 = 通过 - 1
              end
          end

          if self:取状态(编号) and 通过<=0 then
              self.战斗单位[编号].方向 = self.战斗单位[编号].初始方向
              self.战斗单位[编号]:换方向(self.战斗单位[编号].初始方向)
              if 流程.队友 then
                  self.战斗单位[流程.队友].方向 = self.战斗单位[流程.队友].初始方向
                  self.战斗单位[流程.队友]:换方向(self.战斗单位[流程.队友].初始方向)
              end
              if 流程.反震死亡 then
                    self:设置死亡(编号,流程.反震死亡)
              elseif 流程.反击死亡 then
                    self:设置死亡(编号,流程.反击死亡)
              elseif 流程.死亡 then
                    self:设置死亡(编号,流程.死亡)
              end
              return true
          end
          return false
end


function 战斗类:浮空检测(挨打)
        for k,v in pairs(挨打) do
          if v.挨打方 and self.战斗单位[v.挨打方]
            and self.战斗单位[v.挨打方].气血>0
            and self.战斗单位[v.挨打方].状态特效
            and self.战斗单位[v.挨打方].状态特效.浮空 then
              return true
          end
        end
        return false
end








function 战斗类:施法前检测(挨打)
        for i=#挨打,1,-1 do
              if not 挨打[i].挨打方 or 挨打[i].挨打方==0 or not self.战斗单位[挨打[i].挨打方] then
                table.remove(挨打,i)
              end
        end
end

function 战斗类:施法流程开始(编号,挨打,流程,法术)
        self:施法前检测(挨打)
        if 流程.全屏动画 then
            self:设置动作(编号,"施法",true)
            self:置全屏特效(流程.全屏动画,self.战斗单位[挨打[1].挨打方])
            if 法术 then
                for k,v in pairs(挨打) do
                    self:设置抖动(v.挨打方)
                    self.战斗单位[v.挨打方].受击名称 = v.特效[1]
                end
            else
                流程.全屏动画 = nil
            end
            return true
        elseif 流程.先手动画 then
              self:设置动作(编号,"施法",true)
              for k,v in pairs(挨打) do
                  self:设置特效(v.挨打方,流程.先手动画,1)
              end
              流程.先手动画 = nil
              return true
        else
            self:设置动作(编号,"施法",true)
             return true
        end
        return false
end


function 战斗类:施法流程完成(编号,挨打,流程)
          local 通过=#挨打
          for k,v in pairs(挨打) do
              if self:取状态(v.挨打方) then
                    通过 = 通过 - 1
              end
          end
          if 通过<=0 then
              return true
          end
          return false
end



function 战斗类:设置物理掉血(目标,挨打,抖动)
        if not 抖动 then
           self:设置抖动(目标,1)
        end
        self:设置动作(目标,"挨打",nil,true)
        self:设置气血(目标,挨打.伤害,挨打.类型,挨打.护盾值,挨打.伤势,挨打.伤势类型)
        self:设置击退(目标)
        self:设置气血(目标,挨打.伤害1,挨打.类型1)
        self:设置状态(目标,挨打)

end


function 战斗类:设置法术掉血(目标,挨打,抖动)
        if not 抖动 then
           self:设置抖动(目标,1)
        end
        self:设置动作(目标,"挨打",nil,true)
        self:设置气血(目标,挨打.伤害,挨打.类型,挨打.护盾值,挨打.伤势,挨打.伤势类型)
        self:设置击退(目标,挨打.死亡)
        self:设置气血(目标,挨打.伤害1,挨打.类型1)
        if 挨打.死亡1 then
           self:设置死亡(目标,挨打.死亡1)
        end
        self:设置状态(目标,挨打)
end




function 战斗类:单体物理流程(编号,挨打,流程)
          if self.执行流程==1 then --物理攻击
              if 流程.先手动画 then
                  if self:施法流程开始(编号,挨打,流程) then
                      self.执行流程=19
                  end
              elseif 流程.全屏动画 then
                  if self:施法流程开始(编号,挨打,流程) then
                      self.执行流程=19
                  end
              elseif self.战斗单位[编号].动画.攻击方式==1 then  --判断是否是弓弩
                    self:设置动作(编号,"攻击",true)
                    self.执行流程=15
              elseif self.战斗单位[编号].模型=="蜈蚣精" then
                      self.战斗单位[编号].移动开关=false
                      self.执行流程=2
              elseif self:取状态(挨打[1].挨打方) and self:取状态(编号) then --保持原有旧的操作
                      self:开启移动(编号,挨打[1].挨打方)
                      self.执行流程=2
              end
          elseif self.执行流程==2 and self:取停止移动(编号) then
                if not 流程.保护数据 then
                    self.战斗单位[编号].方向=self:单位方向(编号,挨打[1].挨打方)
                    self.战斗单位[编号]:换方向(self.战斗单位[编号].方向)
                    self.战斗单位[挨打[1].挨打方].击退角度 = 取两点孤度(生成XY(self.战斗单位[挨打[1].挨打方].初始xy.x,self.战斗单位[挨打[1].挨打方].初始xy.y),生成XY(self.战斗单位[编号].初始xy.x,self.战斗单位[编号].初始xy.y))
                    local 动作 = self:物理特效处理(挨打[1])
                    self:设置动作(编号,动作,true)
                    if self:浮空检测(挨打) then
                        self.战斗单位[编号].攻击偏移={x=-12,y=-70}
                    end
                    if 挨打[1].死亡 then
                       self:设置攻击帧(编号,动作)
                    end
                    self.执行流程=3
                else
                    self.执行流程=10
                end
           elseif self.执行流程==3 and self:取物理攻击中(编号) then
                    if 流程.躲避 then
                        self:躲避流程处理(挨打[1].挨打方)
                        self.执行流程=17
                    else
                        local 方向 = self:单位方向(挨打[1].挨打方,编号)
                        if self.战斗单位[挨打[1].挨打方].方向~=方向 then
                            self.战斗单位[挨打[1].挨打方].方向=方向
                            self.战斗单位[挨打[1].挨打方]:换方向(方向)
                        end
                        self:设置特效(挨打[1].挨打方,挨打[1].特效)
                        self:设置物理掉血(挨打[1].挨打方,挨打[1])
                        self:设置状态(编号,流程)
                        if 流程.反震伤害 or 流程.反击伤害 then
                            self.执行流程=4
                        else
                            self.执行流程=17
                        end
                    end
            elseif self.执行流程 == 4  then
                    local 结束 = self:反震反击开始(编号,流程,挨打)
                    if 结束 then
                        self.执行流程 = 结束
                    end
            elseif self.执行流程 == 5 and self:反击流程开始(编号,挨打) then
                    self.执行流程 = 6
            elseif self.执行流程 == 6 and self:反击流程动作(编号,流程,挨打)then
                    self.执行流程 = 7
            elseif self.执行流程 == 7 and self:反击流程结束(挨打) then
                    self.执行流程 = 17

            elseif self.执行流程==10 then
                    self:保护流程开始(编号,挨打[1].挨打方,流程.保护数据.编号)
            elseif self.执行流程==11 then
                    self:保护流程动作(编号,流程.保护数据.编号,挨打[1])
            elseif self.执行流程==12 then
                    self:保护流程攻击(编号,挨打[1].挨打方,流程.保护数据,挨打[1])
            elseif self.执行流程==13 then
                    self:保护流程返回(编号,流程.保护数据.编号)
            elseif self.执行流程==14 then
                    self:保护流程结束(流程.保护数据,流程)
            elseif self.执行流程==15 and self:取物理攻击中(编号) then
                    self.战斗单位[挨打[1].挨打方]:设置弓弩(self.战斗单位[编号].显示xy,self.战斗单位[编号].初始方向)
                    self.战斗单位[编号].移动开关=false
                    self.执行流程 = 16
            elseif self.执行流程== 16 and not self.战斗单位[挨打[1].挨打方].弓弩开关 then
                    if not 流程.保护数据 then
                        if 流程.躲避 then
                            self:躲避流程处理(挨打[1].挨打方)
                            self.执行流程=17
                        else
                            self:设置特效(挨打[1].挨打方,挨打[1].特效)
                            self:设置物理掉血(挨打[1].挨打方,挨打[1])
                            self:设置状态(编号,流程)
                            if 流程.反震伤害 or 流程.反击伤害 then
                                self.执行流程=4
                            else
                                self.执行流程=17
                            end
                        end
                    else
                       self.执行流程=10
                    end
            elseif self.执行流程== 17 then
                    local 返回 = self:物理返回流程(编号,流程,挨打)
                    if 返回 then
                        self.执行流程= 返回
                    end
            elseif self.执行流程== 18 and self:物理结束流程(编号,流程,挨打) then
                      self.执行流程 = 20
            elseif self.执行流程== 19 and self.战斗单位[编号].动作=="待战" then
                    self.执行流程= 1

            end
end


function 战斗类:群体物理流程(编号,挨打,流程)
          if self.执行流程==30 then
                if #挨打==0 then
                    self.执行流程=20
                else
                    for k,v in pairs(挨打) do
                        self:设置特效(v.挨打方,v.特效)
                        self:设置物理掉血(v.挨打方,v)
                    end

                end
                if 流程.反震伤害 or 流程.反击伤害 then
                    self.执行流程=4
                else
                    self.执行流程=31
                end
          elseif self.执行流程==31 and self:施法流程完成(编号,挨打,流程) then
                  self:设置状态(编号,流程)
                  if 流程.保护数据 then
                      for k,v in pairs(流程.保护数据) do
                          if type(v)=="table" and v.编号 then
                              self.设置气血(v.编号,v.伤害,1)
                              self.设置击退(v.编号,v.死亡)
                          end
                      end
                  end
                  self.执行流程=20
          elseif self.执行流程==32 then
                  self:施法前检测(挨打)
                  if #挨打 <= 0 then
                        self.执行流程=20
                        return
                  end
                  if 流程.分身攻击 then
                      if self.战斗单位[编号].影子开关 then
                          self.战斗单位[编号].影子移动=false
                          self.执行流程=36
                      else
                         self:开启分身(编号,挨打)
                         self.执行流程=35
                      end
                  else
                      self:中路移动(编号)
                      self.执行流程=33
                  end

          elseif self.执行流程==33 and self:取停止移动(编号) then
                      self.战斗单位[编号].方向=self.战斗单位[编号].初始方向
                      self.战斗单位[编号]:换方向(self.战斗单位[编号].初始方向)
                      self:设置动作(编号,"施法",true)
                      self.执行流程=34
          elseif self.执行流程==34 and self:取法术攻击中(编号) then
                    for k,v in pairs(挨打) do
                        self:设置特效(v.挨打方,v.特效)
                        self:设置物理掉血(v.挨打方,v)
                    end
                    if 流程.保护数据 then
                        for k,v in pairs(流程.保护数据) do
                            if type(v)=="table" and v.编号 then
                              self.设置气血(v.编号,v.伤害,1)
                              self.设置击退(v.编号,v.死亡)
                            end
                        end
                    end
                    self.执行流程=34.1
          elseif self.执行流程==34.1 and self:施法流程完成(编号,挨打,流程) then
                    self:设置状态(编号,流程)
                    if #挨打 <= 0 then
                          self.执行流程=20
                    else
                        if 流程.反震伤害 or 流程.反击伤害 then
                            self.执行流程=4
                        else
                            self.执行流程=17
                        end
                    end
            elseif self.执行流程==35 and self.战斗单位[编号].影子开关 then
                    self.战斗单位[编号].影子移动=true
                    self.执行流程=36
            elseif self.执行流程==36 and not self.战斗单位[编号].影子移动 then
                    self:设置动作(编号,"攻击",true)
                    if self:浮空检测(挨打) then
                        self.战斗单位[编号].攻击偏移={x=-12,y=-70}
                    end
                    self.执行流程=37
            elseif self.执行流程==37 and self:取物理攻击中(编号) then
                    for k,v in pairs(挨打) do
                        self:设置特效(v.挨打方,v.特效)
                        self:设置物理掉血(v.挨打方,v)
                    end
                    self:设置状态(编号,流程)
                    if 流程.保护数据 then
                        for k,v in pairs(流程.保护数据) do
                            if type(v)=="table" and v.编号 then
                              self.设置气血(v.编号,v.伤害,1)
                              self.设置击退(v.编号,v.死亡)
                            end
                        end
                    end
                    if 流程.反震伤害 or 流程.反击伤害 then
                        self.执行流程=4
                    else
                        self.执行流程=17
                    end
            elseif self.执行流程== 38 and not self.战斗单位[编号].影子返回 then
                    self.战斗单位[编号]:关闭影子()
                    self.执行流程=18
          end
end

function 战斗类:法术流程处理(编号,挨打,流程)
        if self.执行流程==21 and self:施法流程开始(编号,挨打,流程,1) then
            self.执行流程=22
        elseif self.执行流程==22 then
                if 流程.全屏动画 then
                    self.执行流程=23
                    流程.全屏动画 = nil
                elseif self:取法术攻击中(编号) then
                        if #挨打 <= 0 then
                            self.执行流程=20
                            return
                        end
                        self.掉血流程=挨打[1].特效[1]
                        for k,v in pairs(挨打) do
                            self:设置抖动(v.挨打方)
                            self:设置动作(v.挨打方,"待战",nil,true)
                            self:设置特效(v.挨打方,v.特效[1],1)
                            self.战斗单位[v.挨打方].受击名称 = v.特效[1]
                        end
                        self.执行流程=23

                end
        elseif self.执行流程==23 and not self.掉血流程 then
                for k,v in pairs(挨打) do
                      v.特效[1]=nil
                      self:设置特效(v.挨打方,v.特效)
                      self:设置法术掉血(v.挨打方,v) --(编号,目标,挨打,流程,法术,特效,抖动)
                end
                self.执行流程=24
        elseif self.执行流程==24 and self:施法流程完成(编号,挨打,流程) then
                self.执行流程 = 25
        elseif self.执行流程==25 and not self.拼接特效 then
                self:设置状态(编号,流程)
                self.执行流程 = 26
        elseif self.执行流程==26 then
                  self:设置气血(编号,流程.减少气血,1)
                  if 流程.死亡 then
                      self:设置击退(编号,流程.死亡)
                  end
                  self.执行流程=20
        elseif self.执行流程==27 and self:施法流程开始(编号,挨打,流程) then
                self.执行流程 = 28
        elseif self.执行流程==28 and self:取法术攻击中(编号) then
                for k,v in pairs(挨打) do
                    self:设置特效(v.挨打方,v.特效[1],1)
                end
                self.执行流程 = 29
         elseif self.执行流程==29 and not self.掉血流程 then
                for k,v in pairs(挨打) do
                    v.特效[1]=nil
                    self:设置特效(v.挨打方,v.特效,1)
                    self:设置气血(v.挨打方,v.伤害,v.类型,v.护盾值,v.伤势,v.伤势类型)
                    self:设置气血(v.挨打方,v.伤害1,v.类型1)
                    self:设置状态(v.挨打方,v)
                    if v.死亡 then
                        self:设置动作(v.挨打方,"挨打",nil,true)
                        self:设置击退(v.挨打方,v.死亡)
                    end
                    if v.死亡1 then
                         self:设置死亡(v.挨打方,v.死亡1)
                    end
                    if v.复活 then
                        self:设置动作(v.挨打方,"待战")
                        self.战斗单位[v.挨打方].停止更新=false
                    end
                end
                if 流程.受益方 then
                   for k,v in pairs(流程.受益方) do
                      self:设置气血(v.受益方,v.伤害,2)
                   end
                end
                self.执行流程 = 24
        end

end





function 战斗类:结束计算()
        for k,v in pairs(self.战斗单位) do
            if not v:取状态() or not v:取法术状态() then
              return
            end
        end
        table.remove(self.战斗流程,1)
        self.执行流程=0
        self.进程 = "计算"
        if #self.战斗流程==0 then
            self.进程="等待"
            请求服务(发送流程)
        end
end










function 战斗类:流程更新()
          if not self.战斗流程[1] then return end
          if not self.执行流程 then return  end
          if self.执行流程 == 20 then
              self:结束计算()
          elseif self.执行流程>=1 and self.执行流程 <= 19 then
                 self:单体物理流程(self.战斗流程[1].攻击方,self.战斗流程[1].挨打方,self.战斗流程[1])

          elseif self.执行流程>=21 and self.执行流程 <= 29 then
                   self:法术流程处理(self.战斗流程[1].攻击方,self.战斗流程[1].挨打方,self.战斗流程[1])
          elseif self.执行流程>=30 and self.执行流程 <= 38 then
                   self:群体物理流程(self.战斗流程[1].攻击方,self.战斗流程[1].挨打方,self.战斗流程[1])
          elseif self.执行流程==39 then
                if self.战斗流程[1].提示 then
                    self:设置动作(self.战斗流程[1].攻击方,"施法",true)
                end
                self.执行流程 = 39.1
          elseif self.执行流程==39.1 and self.战斗单位[self.战斗流程[1].攻击方].动作=="待战" then
                  self.战斗单位[self.战斗流程[1].挨打方.挨打方]=战斗单位类()
                  self.战斗单位[self.战斗流程[1].挨打方.挨打方]:创建单位(self.战斗流程[1].挨打方.数据,self.战斗流程[1].挨打方.队伍,self.战斗流程[1].挨打方.挨打方)
                  self.战斗流程[1].延时等待=os.time()
                  self.执行流程 = 39.2
          elseif self.执行流程==39.2 and os.time()-self.战斗流程[1].延时等待>=1 then
                  self.执行流程=20
          elseif self.执行流程==40 then --套装变身
                  if not self.战斗流程[1].变身套 or 变身显示 then
                       self:设置动作(self.战斗流程[1].攻击方,"施法",true)
                       self:设置特效(self.战斗流程[1].攻击方,"动物套效果")
                  end
                  self.执行流程=41
           elseif self.执行流程==41 and self.战斗单位[self.战斗流程[1].攻击方].动作=="待战" then
                  if not self.战斗流程[1].变身套 or 变身显示 then
                      self.战斗单位[self.战斗流程[1].攻击方]:更改模型(self.战斗流程[1].参数,1)
                  end
                  if self.战斗流程[1].死亡 then
                     self:设置死亡(self.战斗流程[1].攻击方,self.战斗流程[1].死亡)
                  end
                  self.执行流程=20
          elseif self.执行流程==42 then
               self.战斗单位[self.战斗流程[1].攻击方]:设置抓捕动画(self.战斗流程[1].挨打方.挨打方,self.战斗流程[1].宝宝,self.战斗流程[1].捕捉成功,self.战斗流程[1].名称,self.战斗流程[1].目标)
               self.执行流程=43
          elseif self.执行流程==43 and not self.战斗单位[self.战斗流程[1].攻击方].抓捕开关 then
                self.执行流程=20
          elseif self.执行流程==44 then
                  self.战斗单位[self.战斗流程[1].攻击方].方向 = self.战斗单位[self.战斗流程[1].攻击方].逃跑方向
                  self:设置动作(self.战斗流程[1].攻击方,"返回")
                  self.战斗流程[1].等待计时=os.time()
                  self.执行流程=45
          elseif self.执行流程==45 and os.time()-self.战斗流程[1].等待计时>=3 then
                  if not self.战斗流程[1].成功 then
                      self.执行流程=46
                  else
                      self.执行流程=48
                      self.战斗单位[self.战斗流程[1].攻击方].逃跑开关=true
                      if self.战斗流程[1].追加 then
                        self.战斗单位[self.战斗流程[1].追加].方向 = self.战斗单位[self.战斗流程[1].追加].逃跑方向
                        self:设置动作(self.战斗流程[1].追加,"返回")
                        self.战斗单位[self.战斗流程[1].追加].逃跑开关=true
                      end
                  end
          elseif self.执行流程==46 then
                  self.战斗流程[1].等待计时=os.time()
                  self.战斗流程[1].初始方向=self.战斗单位[self.战斗流程[1].攻击方].逃跑方向
                  self:设置动作(self.战斗流程[1].攻击方,"待战")
                  self.执行流程=47
          elseif self.执行流程==47 then
                  self.战斗流程[1].初始方向 = self.战斗流程[1].初始方向 +1
                  if self.战斗流程[1].初始方向>=4 then self.战斗流程[1].初始方向 = 0 end
                  self.战斗单位[self.战斗流程[1].攻击方].方向 = self.战斗流程[1].初始方向
                  self:设置动作(self.战斗流程[1].攻击方,"待战")
                  if os.time()-self.战斗流程[1].等待计时>=1 then
                      self.战斗单位[self.战斗流程[1].攻击方].方向 = self.战斗单位[self.战斗流程[1].攻击方].初始方向
                      self:设置动作(self.战斗流程[1].攻击方,"待战")
                      self.执行流程 = 20
                  end
          elseif self.执行流程==48 then
                  self.战斗单位[self.战斗流程[1].攻击方].显示xy.x=self.战斗单位[self.战斗流程[1].攻击方].显示xy.x+self.战斗单位[self.战斗流程[1].攻击方].逃跑坐标
                  self.战斗单位[self.战斗流程[1].攻击方].显示xy.y=self.战斗单位[self.战斗流程[1].攻击方].显示xy.y+self.战斗单位[self.战斗流程[1].攻击方].逃跑坐标
                  if not self.战斗流程[1].追加 then
                      if 取两点距离(生成XY(self.战斗单位[self.战斗流程[1].攻击方].显示xy.x,self.战斗单位[self.战斗流程[1].攻击方].显示xy.y),生成XY(self.战斗单位[self.战斗流程[1].攻击方].初始xy.x,self.战斗单位[self.战斗流程[1].攻击方].初始xy.y))>=500 then
                        self.执行流程 = 49
                      end
                  else
                      self.战斗单位[self.战斗流程[1].追加].显示xy.x=self.战斗单位[self.战斗流程[1].追加].显示xy.x+self.战斗单位[self.战斗流程[1].追加].逃跑坐标
                      self.战斗单位[self.战斗流程[1].追加].显示xy.y=self.战斗单位[self.战斗流程[1].追加].显示xy.y+self.战斗单位[self.战斗流程[1].追加].逃跑坐标
                      if 取两点距离(生成XY(self.战斗单位[self.战斗流程[1].攻击方].显示xy.x,self.战斗单位[self.战斗流程[1].攻击方].显示xy.y),生成XY(self.战斗单位[self.战斗流程[1].攻击方].初始xy.x,self.战斗单位[self.战斗流程[1].攻击方].初始xy.y))>=500 and 取两点距离(生成XY(self.战斗单位[self.战斗流程[1].追加].显示xy.x,self.战斗单位[self.战斗流程[1].追加].显示xy.y),生成XY(self.战斗单位[self.战斗流程[1].追加].初始xy.x,self.战斗单位[self.战斗流程[1].追加].初始xy.y))>=500 then
                       self.执行流程=49
                      end

                  end
         elseif self.执行流程==49 then
                  self.战斗单位[self.战斗流程[1].攻击方].是否显示=false
                  if self.战斗流程[1].追加 then
                    self.战斗单位[self.战斗流程[1].追加].是否显示=false
                  end
                  if self.战斗流程[1].结束 and tp.队伍[1].数字id==self.战斗流程[1].id then
                      请求服务(5506)
                      self.执行流程=0
                  else
                      self.执行流程=20
                  end

          elseif self.执行流程==50 then
                 for k,v in pairs(self.战斗流程[1].挨打方) do
                      self:设置特效(v.挨打方,v.特效,1)
                      self:设置气血(v.挨打方,v.伤害,v.类型,v.护盾值,v.伤势,v.伤势类型)
                      self:设置状态(v.挨打方,v)
                      if v.类型==1 then
                        self:设置动作(v.挨打方,"挨打",nil,true)
                        self:设置击退(v.挨打方,v.死亡)
                      end
                      if v.复活 then
                          self:设置动作(v.挨打方,"待战")
                      end
                 end
                 if self.战斗流程[1].受益方 then
                     for k,v in pairs(self.战斗流程[1].受益方) do
                        self:设置气血(v.受益方,v.伤害,2)
                     end
                  end
                  self.执行流程 = 51
           elseif self.执行流程==51 and self:施法流程完成(self.战斗流程[1].攻击方,self.战斗流程[1].挨打方,self.战斗流程[1]) then
                  self:设置状态(self.战斗流程[1].攻击方,self.战斗流程[1])
                  self.执行流程 = 20

          elseif self.执行流程==52 then
                  if self.战斗流程[1].id==tp.队伍[1].数字id or self.战斗流程[1].id==0 then
                      tp.常规提示:打开(self.战斗流程[1].内容)
                  end
                  self.执行流程=20

          elseif self.执行流程==53 then --合击
                  self:开启移动(self.战斗流程[1].攻击方,self.战斗流程[1].挨打方[1].挨打方)
                  self:开启移动(self.战斗流程[1].队友,self.战斗流程[1].挨打方[1].挨打方)
                  self.执行流程=54
          elseif self.执行流程==54 and self:取停止移动(self.战斗流程[1].攻击方) and self:取停止移动(self.战斗流程[1].队友) then
                  self:设置动作(self.战斗流程[1].攻击方,"攻击",true)
                  self:设置动作(self.战斗流程[1].队友,"攻击",true)
                  self.执行流程=55
          elseif self.执行流程==55 and self:取物理攻击中(self.战斗流程[1].攻击方) then -- and self:取物理攻击中(self.战斗流程[1].队友)
                    self:设置特效(self.战斗流程[1].挨打方[1].挨打方,self.战斗流程[1].挨打方[1].特效)
                    self:设置物理掉血(self.战斗流程[1].挨打方[1].挨打方,self.战斗流程[1].挨打方[1])
                    self:设置状态(self.战斗流程[1].攻击方,self.战斗流程[1])
                    self.执行流程 = 56
          elseif self.执行流程==56 and self:取进攻完毕(self.战斗流程[1].队友) then
                      self:开启返回(self.战斗流程[1].队友)
                      if self.战斗流程[1].反震伤害 or self.战斗流程[1].反击伤害 then
                          self.执行流程=4
                      else
                          self.执行流程=17
                      end
          elseif self.执行流程==57 then
                    self:施法前检测(self.战斗流程[1].挨打方)
                    if #self.战斗流程[1].挨打方 <= 0 then
                          self.执行流程=20
                          return
                    end
                    self:设置动作(self.战斗流程[1].攻击方,"施法",true)
                    for k,v in pairs(self.战斗流程[1].挨打方) do
                        self.战斗单位[v.挨打方]:设置飞镖(self.战斗单位[self.战斗流程[1].攻击方].显示xy,self.战斗单位[self.战斗流程[1].攻击方].初始方向,v.伤害,v.死亡)
                        self:设置状态(v.挨打方,v)
                    end
                    self.执行流程=24

          end

end





function 战斗类:音效类(文件号,资源包,子类)
  if 文件号 ~= nil and 文件号 ~= 0 and  游戏音效>0 and tp~=nil and tp.音效开启 then
    -- FSB(tp.资源:读数据(资源包,文件号)):播放(false):置音量(游戏音效)
    --储存音效进一个变量 好做退出战斗时候 停止操作
    tp.战斗音效序列[#tp.战斗音效序列+1]=FSB.创建(tp.资源:读数据(资源包,文件号))
    tp.战斗音效序列[#tp.战斗音效序列]:播放(false):置音量(游戏音效)
  end
end


function 战斗类:置全屏特效(技能, 单位)
    local 临时音乐 = 引擎.取音效(技能)
    if 游戏音效 > 0 and 临时音乐 ~= nil then
        self:音效类(临时音乐.文件, 临时音乐.资源, '1')
    end

    -- 初始化默认值
    self.全屏加速 = 1.5
    self.掉血流程 = 0
    self.掉血帧 = nil
    self.是否延迟 = false
    self.拼接特效 = {}
    local qp = false

    -- 定义特效配置表
    local 特效配置 = {
        龙卷雨击 = {
            数量 = 7,
            特效前缀 = "龙卷雨击",
            偏移 = {
                {x=-50,y=-100}, {x=-50,y=-100}, {x=-200,y=-100},
                {x=-50,y=0}, {x=-200,y=0}, {x=-50,y=50,延迟=1},
                {x=-100,y=-50}
            },
            背景状态 = 1,
            掉血流程 = 6,
            掉血帧 = 43,
            全屏加速 = 2.5,
            延迟 = true
        },
        龙吟 = {
            数量 = 5,
            特效前缀 = "龙吟",
            偏移 = {
                {x=-80,y=-40}, {x=-80,y=-80}, {x=-80,y=-30,延迟=0.1},
                {x=-80,y=-80}, {x=-80,y=-80}
            },
            背景状态 = 1,
            掉血流程 = 5,
            掉血帧 = 6,
            全屏加速 = 2,
            延迟 = true
        },
        雨落寒沙 = {
            数量 = 1,
            特效前缀 = function() return 单位.敌我 == 1 and "雨落寒沙_我方" or "雨落寒沙_敌方" end,
            偏移 = {
                function() return {x=单位.敌我 == 1 and -130 or -100, y=-30} end
            },
            掉血流程 = 1,
            掉血帧 = 10,
            全屏加速 = 1,
            延迟 = true
        },
        子母神针 = {
            数量 = 1,
            特效前缀 = function() return 单位.敌我 == 1 and "雨落寒沙_我方" or "雨落寒沙_敌方" end,
            偏移 = {
                function() return {x=单位.敌我 == 1 and -130 or -100, y=-30} end
            },
            掉血流程 = 1,
            掉血帧 = 10,
            全屏加速 = 1,
            延迟 = true
        },
        破釜沉舟 = {
            数量 = 1,
            特效前缀 = function() return 单位.敌我 == 1 and "破釜沉舟_我方" or "破釜沉舟_敌方" end,
            偏移 = {
                function() return {x=单位.敌我 == 1 and -300 or 100, y=单位.敌我 == 1 and -250 or 100} end
            },
            全屏加速 = 1
        },
        翻江搅海 = {
            数量 = 1,
            特效前缀 = "翻江搅海1",
            偏移 = {{x=-100,y=0}},
            全屏加速 = 1
        },
        武神怒击 = {
            数量 = 2,
            特效前缀 = "武神怒击",
            偏移 = {
                {x=-255,y=-200}, {x=-200,y=-150}
            },
            背景状态 = 3,
            全屏加速 = 1
        },
        飞砂走石 = {
            数量 = 5,
            特效前缀 = "飞砂走石",
            偏移 = {
                {x=-90,y=50}, {x=-90,y=10}, {x=30,y=-50,延迟=0.3},
                {x=-180,y=30,延迟=0.2}, {x=-180,y=30}
            },
            掉血流程 = 3,
            掉血帧 = 15,
            全屏加速 = 2,
            延迟 = true
        },
        秘传飞砂走石 = {
            数量 = 5,
            特效前缀 = "飞砂走石",
            偏移 = {
                {x=-90,y=50}, {x=-90,y=10}, {x=30,y=-50,延迟=0.3},
                {x=-180,y=30,延迟=0.2}, {x=-180,y=30}
            },
            掉血流程 = 3,
            掉血帧 = 15,
            全屏加速 = 2,
            延迟 = true
        },
        摇头摆尾 = {
            数量 = 1,
            特效前缀 = "摇头摆尾",
            偏移 = {{x=-50,y=20}},
            掉血流程 = 1,
            掉血帧 = 15,
            全屏加速 = 1.5,
            延迟 = true
        },
        绝幻魔音 = {
            数量 = 1,
            特效前缀 = "绝幻魔音",
            偏移 = {{x=-100,y=-50}},
            掉血流程 = 1,
            掉血帧 = 12,
            全屏加速 = 1,
            延迟 = true
        },
        碎甲术 = {
            数量 = 1,
            特效前缀 = "碎甲术",
            偏移 = {{x=-200,y=-200}},
            掉血流程 = 1,
            掉血帧 = 17,
            全屏加速 = 0.8,
            延迟 = true
        },
        雷浪穿云 = {
            数量 = 1,
            特效前缀 = "雷浪穿云",
            偏移 = {{x=-50,y=-50}},
            背景状态 = 1,
            掉血流程 = 1,
            掉血帧 = 10,
            全屏加速 = 1,
            延迟 = true
        },
        刀光剑影 = {
            数量 = 3,
            特效前缀 = "刀光剑影",
            偏移 = {
                {x=-255,y=-200}, {x=-200,y=-150}, {x=-50,y=20,延迟=0.5}
            },
            背景状态 = 3,
            掉血流程 = 3,
            掉血帧 = 15,
            全屏加速 = 1,
            延迟 = true
        },
        毁灭之光 = {
            数量 = 3,
            特效前缀 = "毁灭之光",
            偏移 = {
                {x=-255,y=-200}, {x=-200,y=-150}, {x=-50,y=20,延迟=0.5}
            },
            背景状态 = 3,
            掉血流程 = 3,
            掉血帧 = 8,
            全屏加速 = 1,
            延迟 = true
        },
        叱咤风云 = {
            数量 = 1,
            特效前缀 = "叱咤风云",
            偏移 = {{x=-50,y=-50}},
            背景状态 = 1,
            掉血流程 = 1,
            掉血帧 = 23,
            全屏加速 = 1.5,
            延迟 = true
        },
        八凶法阵 = {
            数量 = 1,
            特效前缀 = "八凶法阵",
            偏移 = {{x=-80,y=-50}},
            背景状态 = 3,
            掉血流程 = 1,
            掉血帧 = 10,
            全屏加速 = 1.2,
            延迟 = true
        },
        天降灵葫 = {
            数量 = 1,
            特效前缀 = "天降灵葫",
            偏移 = {{x=-80,y=-20}},
            掉血流程 = 1,
            掉血帧 = 10,
            全屏加速 = 1.5,
            延迟 = true
        },
        河东狮吼 = {
            数量 = 1,
            特效前缀 = "河东狮吼",
            偏移 = {{x=-50,y=20}},
            掉血流程 = 1,
            掉血帧 = 10,
            全屏加速 = 0.8
        },
        侵掠如火 = {
            数量 = 1,
            特效前缀 = "侵掠如火",
            偏移 = {{x=-50,y=20}},
            全屏加速 = 1
        },
        其徐如林 = {
            数量 = 1,
            特效前缀 = "其徐如林",
            偏移 = {{x=-50,y=20}},
            全屏加速 = 1
        },
        不动如山 = {
            数量 = 1,
            特效前缀 = "不动如山",
            偏移 = {{x=-50,y=20}},
            全屏加速 = 1
        },
        其疾如风 = {
            数量 = 1,
            特效前缀 = "其疾如风",
            偏移 = {{x=-50,y=20}},
            全屏加速 = 1
        },
        停陷术 = {
            数量 = 1,
            特效前缀 = "停陷术",
            偏移 = {{x=-80,y=-20}},
            掉血流程 = 1,
            掉血帧 = 18
        },
        巨岩破 = {
            数量 = 1,
            特效前缀 = 技能,
            偏移 = {{x=0,y=0}}
        },
        日光华 = {
            数量 = 1,
            特效前缀 = 技能,
            偏移 = {{x=0,y=0}}
        },
        靛沧海 = {
            数量 = 1,
            特效前缀 = 技能,
            偏移 = {{x=0,y=0}}
        },
        苍茫树 = {
            数量 = 1,
            特效前缀 = 技能,
            偏移 = {{x=0,y=0}}
        },
        地裂火 = {
            数量 = 1,
            特效前缀 = 技能,
            偏移 = {{x=0,y=0}}
        },
        奔雷咒 = {
            数量 = 9,
            特效前缀 = "奔雷咒",
            偏移 = {
                {x=-150,y=20}, {x=10,y=-50}, {x=-60,y=-20,延迟=0.1},
                {x=-120,y=10,延迟=0.1}, {x=30,y=-50,延迟=0.1},
                {x=-60,y=-20,延迟=0.1}, {x=-150,y=20}, {x=10,y=-50},
                {x=-60,y=-20}
            },
            背景状态 = 1,
            掉血流程 = 9,
            掉血帧 = 1,
            全屏加速 = 2,
            延迟 = true
        },
        超级奔雷咒 = {
            数量 = 9,
            特效前缀 = "奔雷咒",
            偏移 = {
                {x=-150,y=20}, {x=10,y=-50}, {x=-60,y=-20,延迟=0.1},
                {x=-120,y=10,延迟=0.1}, {x=30,y=-50,延迟=0.1},
                {x=-60,y=-20,延迟=0.1}, {x=-150,y=20}, {x=10,y=-50},
                {x=-60,y=-20}
            },
            背景状态 = 1,
            掉血流程 = 9,
            掉血帧 = 1,
            全屏加速 = 2,
            延迟 = true


        },
        泰山压顶 = {
            数量 = 2,
            特效前缀 = "泰山压顶",
            偏移 = {
                {x=-50,y=10}, {x=-50,y=10,延迟=0.3}
            },
            背景状态 = 2,
            掉血流程 = 2,
            掉血帧 = 5,
            全屏加速 = 2,
            延迟 = true
        },
        超级泰山压顶 = {
            数量 = 2,
            特效前缀 = "泰山压顶",
            偏移 = {
                {x=-50,y=10}, {x=-50,y=10,延迟=0.3}
            },
            背景状态 = 2,
            掉血流程 = 2,
            掉血帧 = 5,
            全屏加速 = 2,
            延迟 = true
        },
        水漫金山 = {
            数量 = 8,
            特效前缀 = "水漫金山",
            偏移 = {
                {x=-150,y=-150}, {x=-200,y=-150}, {x=0,y=-100,延迟=0.1},
                {x=50,y=-100}, {x=-150,y=0,延迟=0.1}, {x=-200,y=0},
                {x=-50,y=-100}, {x=-100,y=-100}
            },
            背景状态 = 2,
            掉血流程 = 8,
            掉血帧 = 10,
            全屏加速 = 2,
            延迟 = true
        },
        超级水漫金山 = {
            数量 = 8,
            特效前缀 = "水漫金山",
            偏移 = {
                {x=-150,y=-150}, {x=-200,y=-150}, {x=0,y=-100,延迟=0.1},
                {x=50,y=-100}, {x=-150,y=0,延迟=0.1}, {x=-200,y=0},
                {x=-50,y=-100}, {x=-100,y=-100}
            },
            背景状态 = 2,
            掉血流程 = 8,
            掉血帧 = 10,
            全屏加速 = 2,
            延迟 = true
        },
        风卷残云 = {
            数量 = 1,
            特效前缀 = "风卷残云",
            偏移 = {{x=-50,y=20}},
            掉血流程 = 1,
            掉血帧 = 12,
            全屏加速 = 1.1,
            延迟 = true
        },
        枯木逢春 = {
            数量 = 1,
            特效前缀 = "风卷残云",
            偏移 = {{x=-50,y=20}},
            掉血流程 = 1,
            掉血帧 = 12,
            全屏加速 = 1.1,
            延迟 = true
        },
        落叶萧萧 = {
            数量 = 10,
            特效前缀 = "落叶萧萧",
            偏移 = {
                {x=-70,y=-30}, {x=-150,y=0,延迟=0.5}, {x=-90,y=-10,延迟=0.1},
                {x=-90,y=50,延迟=0.1}, {x=-150,y=40,延迟=0.1}, {x=-70,y=0,延迟=0.1},
                {x=-20,y=0,延迟=0.1}, {x=-20,y=30,延迟=0.1}, {x=20,y=-30,延迟=0.1},
                {x=-70,y=-30,延迟=0.1}
            },
            掉血流程 = 6,
            掉血帧 = 1,
            全屏加速 = 0.8,
            延迟 = true
        },
        地狱烈火 = {
            数量 = 31,
            特效前缀 = "地狱烈火",
            偏移 = {
                {x=-300,y=50}, {x=-300,y=-60,延迟=0.2}, {x=-300,y=-60},
                {x=-300,y=50}, {x=-300,y=50}, {x=-300,y=150},
                {x=-300,y=150,延迟=0.2}, {x=-150,y=-110}, {x=-150,y=-110},
                {x=-150,y=0}, {x=-150,y=0}, {x=-150,y=80},
                {x=-150,y=80,延迟=0.2}, {x=0,y=-140}, {x=0,y=-140},
                {x=0,y=-60}, {x=0,y=-60}, {x=0,y=20},
                {x=0,y=20,延迟=0.2}, {x=150,y=-180}, {x=150,y=-180},
                {x=150,y=-100}, {x=150,y=-100}, {x=150,y=-20},
                {x=150,y=-20,延迟=0.3}, {x=300,y=-230}, {x=300,y=-230},
                {x=300,y=-150}, {x=300,y=-150}, {x=300,y=-70},
                {x=300,y=-70}
            },
            背景状态 = 3,
            掉血流程 = 15,
            掉血帧 = 15,
            全屏加速 = 3,
            延迟 = true
        },
        超级地狱烈火 = {
            数量 = 31,
            特效前缀 = "地狱烈火",
            偏移 = {
                {x=-300,y=50}, {x=-300,y=-60,延迟=0.2}, {x=-300,y=-60},
                {x=-300,y=50}, {x=-300,y=50}, {x=-300,y=150},
                {x=-300,y=150,延迟=0.2}, {x=-150,y=-110}, {x=-150,y=-110},
                {x=-150,y=0}, {x=-150,y=0}, {x=-150,y=80},
                {x=-150,y=80,延迟=0.2}, {x=0,y=-140}, {x=0,y=-140},
                {x=0,y=-60}, {x=0,y=-60}, {x=0,y=20},
                {x=0,y=20,延迟=0.2}, {x=150,y=-180}, {x=150,y=-180},
                {x=150,y=-100}, {x=150,y=-100}, {x=150,y=-20},
                {x=150,y=-20,延迟=0.3}, {x=300,y=-230}, {x=300,y=-230},
                {x=300,y=-150}, {x=300,y=-150}, {x=300,y=-70},
                {x=300,y=-70}
            },
            背景状态 = 3,
            掉血流程 = 15,
            掉血帧 = 15,
            全屏加速 = 3,
            延迟 = true
        }
    }

    -- 从配置表中获取当前技能配置
    local 当前配置 = 特效配置[技能]

    if 当前配置 then
        -- 创建特效
        for s = 1, 当前配置.数量 do
            local 特效名称 = type(当前配置.特效前缀) == "function" and 当前配置.特效前缀() or
                          (当前配置.数量 > 1 and 当前配置.特效前缀..s or 当前配置.特效前缀)

            local 偏移数据 = 当前配置.偏移[s]
            if type(偏移数据) == "function" then
                偏移数据 = 偏移数据()
            end

            self.拼接特效[s] = {
                特效 = 单位:加载特效(特效名称),
                偏移 = 偏移数据 or {x=0,y=0}
            }

            if 偏移数据 and 偏移数据.延迟 then
                self.拼接特效[s].延迟 = 偏移数据.延迟
            end
        end

        -- 设置属性
        self.是否延迟 = 当前配置.延迟 or false
        self.背景状态 = 当前配置.背景状态 or nil
        self.掉血流程 = 当前配置.掉血流程 or 0
        self.掉血帧 = 当前配置.掉血帧 or 0
        self.全屏加速 = 当前配置.全屏加速 or 1.5
        qp = true
    end

    -- 设置拼接偏移
    if qp then
        if 单位.敌我 == 1 then
            self.拼接偏移.x, self.拼接偏移.y = 全局游戏宽度/2+220, 全局游戏高度/2+130
        else
            self.拼接偏移.x, self.拼接偏移.y = 全局游戏宽度/2-75, 全局游戏高度/2-75
        end
    end
end





function 战斗类:取鼠标所在窗口(x,y)
  if not tp.隐藏UI then
    for n=#self.窗口_, 1,-1 do
          if self.窗口_[n]:检查点(x,y)  then
            tp.选中UI = true
            return n
          end
    end
  end
  return 0
end


local function 排序(a,b) return a.y < b.y end   ----9.19修复


local a = {}

function 战斗类:显示(dt,x,y)
          self.纯色背景:显示(0,0)
         -- self.战斗圆背景:更新(dt)
          if self.蜈蚣精显示 then
              self.蜈蚣精地图:显示(全局游戏宽度/2-390,全局游戏高度/2-315)
          end
          self.战斗背景:显示(全局游戏宽度/2-235,全局游戏高度/2-125)
         -- self.战斗圆背景:显示(全局游戏宽度/2-20,全局游戏高度/2+25)
         -- self.战斗圆背景:显示(全局游戏宽度/2+13,全局游戏高度/2+13) ---新加1
         -- self.战斗圆背景:显示(全局游戏宽度/2-205,全局游戏高度/2-130)
          if self.背景状态 == 1 then
            self.黑幕背景:显示(0,0)
          -- elseif self.背景状态 == 2 then
          --     self.蓝色背景:显示(0,0)
          -- elseif self.背景状态 == 3 then
          --     self.红色背景:显示(0,0)
          end
          if self.观战模式 then
              tp.字体表.普通字体:置颜色(黄色):显示(10,全局游戏高度-275," 观 战 模 式")
              self.观战按钮:更新1(x,y)
              self.观战按钮:显示(20,全局游戏高度-215)
              if self.战斗类型 ~= 0 then
                 self.切换阵营:更新1(x,y)
                 self.切换阵营:显示(20,全局游戏高度-245)
              end
              if self.观战按钮:事件判断() then
                   请求服务(5510)
              elseif self.切换阵营:事件判断() then
                    for i=1,#self.战斗单位 do
                      if self.战斗单位[i].队伍 ~= self.队伍id then
                         self.队伍id = self.战斗单位[i].队伍
                         break
                      end
                    end
                    for i=1,#self.战斗单位 do
                        self.战斗单位[i]:创建单位(self.战斗单位[i],self.战斗单位[i].队伍,i)
                    end
              end
              tp.字体表.普通字体:置颜色(白色)
          end
          ---------------你改你的这里
          a = {}
          for n=1,#self.战斗单位 do                           ----------9.17修复
              local p = {y=0,k=0}
              p.y = self.战斗单位[n].显示xy.y
              p.k = n
              table.insert(a,p)
          end
          table.sort(a,排序)
          for n=1,#self.战斗单位 do
              self.战斗单位[a[n].k]:显示(dt,x,y)
          end
          for n=1,#self.战斗单位 do
              self.战斗单位[n]:血条显示(x,y)
              if self.战斗单位[n].弓弩开关 then
                  self.战斗单位[n].弓弩动画:显示(self.战斗单位[n].弓弩xy.x,self.战斗单位[n].弓弩xy.y-30)   --发射出去的特效的X坐标 和Y坐标
              end
          end
          if self.进程=="命令" then
              self.战斗指令:显示(dt,x,y)
              self.秒显示=0
              self.分显示=0
              self.结果=时间-self.命令数据.计时
              self.显示时间=0
              --print(self.结果)
              if self.结果>=1 then
                  self.命令数据.计时=时间
                  self.命令数据.秒=self.命令数据.秒-1
                  if self.命令数据.秒<0 then
                      if self.命令数据.分<=0 and self.命令数据.秒<=0 then
                        self.战斗指令:结束()
                        self.进程="等待"
                        self.显示时间=1
                      elseif self.命令数据.秒<=0 then
                        self.命令数据.秒=9
                        self.命令数据.分=self.命令数据.分-1
                      end
                  end
              end
              if self.显示时间==0 then
                  self.分显示=self.命令数据.分+1
                  if self.分显示>20 then
                      self.分显示=1
                  end
                  self.秒显示=self.命令数据.秒+1
                  if self.秒显示>20 then
                      self.秒显示=1
                  end
                  if self.分显示 and self.秒显示
                    and self.数字图片[self.分显示]
                    and self.数字图片[self.秒显示] then
                      self.数字图片[self.分显示]:显示(全局游戏宽度/2-20,15)
                      self.数字图片[self.秒显示]:显示(全局游戏宽度/2+30,15)
                  end
              end
          elseif self.进程=="等待" then
                  self.请等待:显示(全局游戏宽度/2-40,30)
          elseif self.进程=="执行" then
                if self.拼接特效 ~= nil then
                    for n=1,#self.拼接特效 do
                        if self.是否延迟 then
                          if self.拼接特效[n].延迟==nil then
                            self.拼接特效[n].特效:显示(self.拼接偏移.x + self.拼接特效[n].偏移.x ,self.拼接偏移.y + self.拼接特效[n].偏移.y)
                          else
                            break
                          end
                        else
                          self.拼接特效[n].特效:显示(self.拼接偏移.x + self.拼接特效[n].偏移.x ,self.拼接偏移.y + self.拼接特效[n].偏移.y)
                        end
                    end
                      if self.是否拼接 ~= true then
                        self.是否拼接 = true
                      end
                end
                if self.战斗流程[1].九黎连击  then
                    self.连击背景:显示(全局游戏宽度-180,140)
                    if self.战斗流程[1].九黎连击<10 then
                        tp.字体表.九黎连击:置颜色(白色):显示(全局游戏宽度-155,94,self.战斗流程[1].九黎连击)
                    else
                        tp.字体表.九黎连击:置颜色(白色):显示(全局游戏宽度-167,94,self.战斗流程[1].九黎连击)
                    end
                end
          end
          local 我方状态 = {}
          for k,v in pairs(self.战斗单位) do
              if v.掉血开关 then
                  if v.伤害类型==1  then
                      v:掉血显示()
                  elseif v.伤害类型==3 or v.伤害类型==4 then
                          v:暴击显示()
                  elseif v.伤害类型==5 then
                          v:回血暴击()
                  else
                      v:加血显示()
                  end
              end
              if 引擎.外部 and v.敌我 == 1 and v.类型== "角色" then
                  table.insert(我方状态, {模型 =v.模型, 名称 =v.名称,法术状态 = v.状态特效})
              end
              if 多角色操作 and v.敌我==1 then
                  多角色操作数据[v.数据.位置] = {}
                  if v.数据.自动指令~= nil then
                    if v.数据.自动指令.类型 == "法术" then
                        多角色操作数据[v.数据.位置].参数 = v.数据.自动指令.参数
                    else
                        多角色操作数据[v.数据.位置].参数 = v.数据.自动指令.类型
                    end
                  else
                      多角色操作数据[v.数据.位置].参数 = "攻击"
                  end
                  多角色操作数据[v.数据.位置].编号 = v.编号
              end
          end
          if 引擎.外部 then
                引擎.场景.窗口.消息框:添加战斗状态(我方状态)
          end
          if 多角色操作 then
              self.多角色自动栏.鼠标=false
              self.多角色自动栏:检查点(x,y)
              self.多角色自动栏:显示(dt,x,y)
              self.自动按钮:更新1(x,y)
              self.自动按钮:显示(self.多角色自动栏.x+8,self.多角色自动栏.y-95)
              if self.自动开关 then
                self.自动按钮:置文字("取消自动")
              else
                self.自动按钮:置文字("开启自动")
              end
              if self.自动按钮:事件判断() then
                  if self.自动开关 then
                      self.自动开关 = false
                  else
                      self.自动开关 = true
                  end
                 请求服务(5507)
              end
              if self.窗口.自动栏.可视 then
                  self.窗口.自动栏:打开()
              end
          elseif self.自动开关 and not 多角色操作数据[1] and not self.窗口.自动栏.可视 then
                  self.窗口.自动栏:打开()

          end
          if self.提示 and self.提示 ~= "" and self.战斗单位[self.提示] and not 判断是否为空表(self.战斗单位[self.提示].状态特效) then
                tp.提示:战斗提示(x,y,self.战斗单位[self.提示].状态特效)
          end
          if self.我方阵型 and self.敌方阵型 then
              self.我方阵法:显示(全局游戏宽度/2+110,20)
              if self.我方阵法:是否选中(x,y) then
                  tp.提示:阵法(全局游戏宽度/2+100,35,self.我方阵型,self.敌方阵型,1)
              end
              self.敌方阵法:显示(全局游戏宽度/2-100,20)
              if self.敌方阵法:是否选中(x,y) then
                tp.提示:阵法(全局游戏宽度/2-100,35,self.敌方阵型,self.我方阵型,2)
              end
          end
          tp.字体表.描边字体:置颜色(白色):显示(全局游戏宽度/2-15,80,"回合计数:")
          tp.字体表.描边字体:置颜色(黄色):显示(全局游戏宽度/2+70,80,self.回合数)--(x,y,显示内容)
          tp.字体表.描边字体:置颜色(白色)
          self.横条:显示(全局游戏宽度/2-102,5)
          self.竖条:显示(全局游戏宽度-19,全局游戏高度/2-130)

    -- if self.竖条:是否选中(x,y) and 引擎.鼠标弹起(左键) then
    --   if self.我方头像开关 then
    --     self.我方头像开关=false
    --   else
    --     self.我方头像开关=true
    --   end
    -- end
    -- if self.横条:是否选中(x,y) and 引擎.鼠标弹起(左键) then
    --   if self.敌方头像开关 then
    --     self.敌方头像开关=false
    --   else
    --     self.敌方头像开关=true
    --   end
    -- end
    -- if self.我方头像开关 and  self.进程=="命令" then
    --   for i=1,#self.我方头像组 do
    --     tp.人物头像背景_:显示(全局游戏宽度-75,全局游戏高度/2-130+(i-1)*55)
    --     self.我方头像组[i]:更新(x,y)
    --     self.我方头像组[i]:显示(全局游戏宽度-72,全局游戏高度/2-127+(i-1)*55,true)
    --     if self.我方头像组[i]:是否选中(x,y) then
    --       tp.提示:自定义(全局游戏宽度-72,全局游戏高度/2-133+(i-1)*55,"#Y/名称:"..self.我方头像组[i].名称.."\n#Y/等级:"..(self.我方头像组[i].等级 or 0).."\n#Y/门派:"..(self.我方头像组[i].门派 or "无").."\n#P/血量:"..self.我方头像组[i].气血.."/"..self.我方头像组[i].最大气血.."\n#S/魔法:"..self.我方头像组[i].魔法.."/"..self.我方头像组[i].最大魔法.."\n#G/愤怒:"..self.我方头像组[i].愤怒.."/150",93)
    --     end
    --   end
    -- end
    -- if self.敌方头像开关 and  self.进程=="命令" then
    --   for i=1,#self.敌方头像组 do
    --     tp.人物头像背景_:显示(全局游戏宽度/2-133+(i-1)*55,23)
    --     self.敌方头像组[i]:更新(x,y)
    --     self.敌方头像组[i]:显示(全局游戏宽度/2-130+(i-1)*55,26,true)
    --     if self.敌方头像组[i]:是否选中(x,y) then
    --       tp.提示:自定义(全局游戏宽度/2-170+(i-1)*55,76,"#Y/名称:"..self.敌方头像组[i].名称.."\n#Y/等级:"..(self.敌方头像组[i].等级 or 0).."\n#Y/门派:"..(self.敌方头像组[i].门派 or "无"))
    --     end
    --   end
    -- end


  if self.过度精灵 ~= nil then
    self.过度时间 = self.过度时间 - 0.55
    if self.过度时间 <= 0 then
      self.过度进度 = self.过度进度 - (10)
      self.过度时间 = 0
      if self.过度进度 <= 0 then
        self.过度进度 = 0
      end
    end
    self.过度坐标1.x,self.过度坐标1.y = self.过度坐标1.x -6,self.过度坐标1.y -6
    self.过度坐标2.x,self.过度坐标2.y = self.过度坐标2.x +6,self.过度坐标2.y -6
    self.过度坐标3.x,self.过度坐标3.y = self.过度坐标3.x -6,self.过度坐标3.y +6
    self.过度坐标4.x,self.过度坐标4.y = self.过度坐标4.x +6,self.过度坐标4.y +6
    --self.场景.过度精灵:置颜色(ARGB(self.场景.过度进度,255,255,255))
    --self.场景.过度精灵:显示()
    self.过度精灵1:显示(self.过度坐标1.x,self.过度坐标1.y)
    self.过度精灵2:显示(self.过度坐标2.x,self.过度坐标2.y)
    self.过度精灵3:显示(self.过度坐标3.x,self.过度坐标3.y)
    self.过度精灵4:显示(self.过度坐标4.x,self.过度坐标4.y)
    if self.过度进度 <= 0 then
      --self.过度精灵:释放()
      self.过度精灵 = nil
      self.过度精灵1= nil
      self.过度精灵2= nil
      self.过度精灵3= nil
      self.过度精灵4= nil
      self.过度减少 = nil
    end
  end
  --战斗窗口显示
  for n=1,#self.窗口_ do
    if self.窗口_[n].可视 then
      self.窗口_[n]:显示(dt,x,y)
    end
  end
    ---
end





function 战斗类:卸载()
    self.我方阵型=nil
    self.敌方阵型=nil

    for k,v in pairs(self.战斗单位) do
      v:卸载()
    end
    if self.拼接特效 then
      for k,v in pairs(self.拼接特效) do
        if v.特效 then
            v.特效:释放()
        end
      end
      递归清空(self.拼接特效)
    end

    -- for k,v in pairs(self.我方头像组) do
    --     if v.释放 then
    --         v:释放()
    --     end
    -- end
     for k,v in pairs(self.敌方头像组) do
        if v.释放 then
            v:释放()
        end
    end
    --递归清空(self.法术状态)
    self.战斗单位={}
    -- self.我方头像组={}
    -- self.敌方头像组={}
    self.观战模式=false
    self.战斗类型=0
    --self.拼接特效=nil
    self.背景状态=0
    self.战斗流程={}
    self.执行流程=0
    self.进程=nil
end







return 战斗类