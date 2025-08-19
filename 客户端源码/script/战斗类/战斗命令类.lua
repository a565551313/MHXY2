
local 战斗命令类 = class()

local tp = nil
local random = 引擎.取随机整数
local keyaz = 引擎.按键按住
local keyax = 引擎.按键按下
local keytq = 引擎.按键弹起
local mouse = 引擎.鼠标弹起
local KEY = KEY
local zts
function 战斗命令类:初始化(根)
  self.ID = 1
	self.x = 77
	self.y = 68
	self.xx = 0
	self.yy = 0
  self.道具栏 = require("script/战斗类/战斗道具栏").创建(根)
  self.灵宝栏 = require("script/战斗类/战斗灵宝类").创建(根)  ---灵宝
	self.注释 = "战斗"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	local 按钮 = require("script/系统类/按钮")
	self.人物资源组 = {
		[1] = 根.资源:载入('登陆资源.wdf',"网易WDF动画",0xF5A9A3F5),
		[2] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x839C6C7D),0,0,4,true),--法术
		[3] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x2E8F2187),0,0,4,true),--法宝
		[4] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x389DCCF5),0,0,4,true),--特技
		[5] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x1587C26E),0,0,4,true),--道具
		[6] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0xA662D44B),0,0,4,true),--防御
		[7] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x0467A0A8),0,0,4,true),--保护
		--[8] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x8A8A21AD),0,0,4,true),
		[9] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0xA2E2DC42),0,0,4,true),--召唤
		[10] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0xE1A79F93),0,0,4,true), --召还
		[11] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0xEFB4F757),0,0,4,true),--自动
		[12] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x2ACB414D),0,0,4,true),--捕捉
		[13] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x132041E1),0,0,4,true),--逃跑
    [14] = 按钮.创建(根.资源:载入('zztx.wdf',"网易WDF动画",0x00000001),0,0,4,true),--灵宝

	}
	self.召唤兽资源组 = {
		[1] = 根.资源:载入('登陆资源.wdf',"网易WDF动画",0xAABBCC8A),
		[2] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x839C6C7D),0,0,4,true),
		[3] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x1587C26E),0,0,4,true),
		[4] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0xA662D44B),0,0,4,true),
		[5] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x0467A0A8),0,0,4,true),
		[6] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x132041E1),0,0,4,true),
    [7] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0xEFB4F757),0,0,4,true),
    [8] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0xE1A79F93),0,0,4,true),
	}
  self.角色资源组 = {
    [1] = 根.资源:载入('登陆资源.wdf',"网易WDF动画",0xAABBCC8A),
    [2] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x839C6C7D),0,0,4,true),--法术
    [3] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x389DCCF5),0,0,4,true),--特技
    [4] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x1587C26E),0,0,4,true),--道具
    [5] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0xA662D44B),0,0,4,true),--防御
    [6] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x0467A0A8),0,0,4,true),--保护
    --[7] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0xEFB4F757),0,0,4,true),--自动
    [8] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x2E8F2187),0,0,4,true),--法宝
    [9] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0xA2E2DC42),0,0,4,true),--召唤
    [7] = 按钮.创建(根.资源:载入('zztx.wdf',"网易WDF动画",0x00000001),0,0,4,true),--灵宝
    [10] = 根.资源:载入('登陆资源.wdf',"网易WDF动画",0xAABBCC8A),
    [11] = 按钮.创建(根.资源:载入('登陆资源.wdf',"网易WDF动画",0x2ACB414D),0,0,4,true),--捕捉
  }
  self.法术序号={
    [1] = 根.资源:载入(wdf配置.."/pic/号1.png","图片"),
    [2] = 根.资源:载入(wdf配置.."/pic/号2.png","图片"),
    [3] = 根.资源:载入(wdf配置.."/pic/号3.png","图片"),
    [4] = 根.资源:载入(wdf配置.."/pic/号4.png","图片"),
}
	self.指令 = nil
	self.对象 = nil
	self.队形 = nil
	self.使用 = nil
	self.技能 = nil
	self.特技 = nil
	self.物品 = nil
	self.召唤兽 = nil
	self.物品对象 = nil
	self.窗口时间 = 0
	self.剩余时间 = nil
	self.格子 = nil
	tp = 根
  self.法术界面= require("script/战斗类/战斗技能栏").创建(根)
  self.召唤界面=require("script/战斗类/战斗召唤栏").创建(根)
  self.法术开关=false
  self.特技开关=false
  self.召唤开关=false
  self.默认法术={}
  zts = tp.字体表.描边字体
end

function 战斗命令类:设置指令(编号)
  if self.命令类型=="攻击" and self.参战单位[编号].敌我==1 and keyaz(KEY.CTRL) == false then
    tp.常规提示:打开("#Y/选择友方目标请按住CTRL点击队友")
    return
  elseif self.命令类型=="攻击" and self.参战单位[编号].敌我==1 and keyaz(KEY.CTRL) and 编号 == self.单位编号[self.操作对象] then
    tp.常规提示:打开("#Y/不可以攻击自己")
    return
  end
  -- if self.参战单位[编号].敌我 == 2 and self.命令参数 == "普度众生" and self.参战单位[self.单位编号[self.操作对象]].敌我 == 1 then
  --   tp.常规提示:打开("#Y/截图给GM命令附加为"..self.命令附加.."目标为"..self.参战单位[编号].名称)
  -- end
  if not self.完成指令[self.操作对象] then self.完成指令[self.操作对象]={} end
  if self.法术次数[self.操作对象] and self.命令类型=="法术" then
      if  self.完成指令[self.操作对象].多重施法 and self.完成指令[self.操作对象].多重施法[1] then
          if #self.完成指令[self.操作对象].多重施法<self.法术次数[self.操作对象] then
            table.insert(self.完成指令[self.操作对象].多重施法,{类型=self.命令类型,目标=编号,敌我=0,参数=self.命令参数,附加=self.命令附加})
          end
      else
          self.完成指令[self.操作对象].多重施法={{类型=self.命令类型,目标=编号,敌我=0,参数=self.命令参数,附加=self.命令附加}}
      end
  end
  self.完成指令[self.操作对象].类型=self.命令类型
  self.完成指令[self.操作对象].目标=编号
  self.完成指令[self.操作对象].敌我=0
  self.完成指令[self.操作对象].参数=self.命令参数
  self.完成指令[self.操作对象].附加=self.命令附加
  local 继续执行=true
  if self.命令类型=="法术" and self.法术次数[self.操作对象] and  self.完成指令[self.操作对象].多重施法 and #self.完成指令[self.操作对象].多重施法<self.法术次数[self.操作对象] then
      继续执行=false
  end
  if 继续执行 then
      if self.操作对象>=self.对象上限 then
            请求服务(5502,self.完成指令)
            战斗类.进程="等待"
      else
          self.操作对象=self.操作对象+1
      end
  end
  self.命令参数=""
  self:重置高亮()
  self.命令版面=true
  tp.鼠标.置鼠标("普通")
  self.命令类型="攻击"
  self.命令附加=4
end

function 战斗命令类:设置指令1(编号)
  self.完成指令[self.操作对象]={类型=self.命令类型,目标=编号,敌我=0,参数=self.命令参数,附加=self.命令附加}
  if self.操作对象>=self.对象上限 then
    请求服务(5502,self.完成指令)
    战斗类.进程="等待"
    self:重置高亮()
  else
    self.操作对象=self.操作对象+1
    self:重置高亮()
    self.命令版面=true
    tp.鼠标.置鼠标("普通")
    self.命令类型="攻击"
    self.命令附加=4
  end
  self.命令版面=true
  tp.鼠标.置鼠标("普通")
end

function 战斗命令类:更新类型(编号)
  local x=全局游戏宽度-60
  local y=450
  local xx = 93
  local yy = 297
  if dx == 2 then
    xx = 93
    yy = 128
  end
  self.x = x - xx
  self.y = y - yy
  self.命令版面=true
  self.类型=1
  self.单位编号={}
  self.法术次数={}
  for k,v in pairs(编号) do
      if type(v)=="table" then
          self.单位编号[k]=v.目标
          self.法术次数[k]=v.法术次数
      else
          self.单位编号[k]=v
      end
  end
  self.操作对象=1
  self.完成指令={}
  self.对象上限=#编号
  self.参战单位=战斗类.战斗单位
  self.命令类型="攻击"
  self.命令附加=4
  self.命令参数=""
  self.鼠标更改=true
  self.法术开关=false
  self.道具开关=false
  self.法宝开关=false
  self.召唤开关=false
  for n=1,#编号 do
    self.完成指令[n]={}
  end
end

function 战斗命令类:设置道具参数(编号,对象)
  -- print(编号,对象)
  self.道具栏:打开()
  self.命令类型="道具"
  self.命令附加=对象
  self.命令参数=编号
  self.命令版面=false
  tp.鼠标.置鼠标("道具")

end


function 战斗命令类:设置灵宝参数(编号,对象)   ---------------灵宝
  -- print(对象)
  self.灵宝栏:打开()
  self.命令类型="道具"
  self.命令附加=对象
  self.命令参数=编号
  self.命令版面=false
  tp.鼠标.置鼠标("道具")
  if self.命令附加==66 then
    self:设置指令(self.单位编号[self.操作对象])
  end
end



function 战斗命令类:设置逃跑(id)
  self.完成指令[self.操作对象]={类型="逃跑",目标=1,敌我=0,参数=self.命令参数,附加=1}
  if self.操作对象>=self.对象上限 then
    请求服务(5502,self.完成指令)
    战斗类.进程="等待"
    self:重置高亮()
  else
    self.操作对象=self.操作对象+1
    self:重置高亮()
  end
end

function 战斗命令类:设置召唤(id)
  self.命令类型="召唤"
  self.完成指令[self.操作对象]={类型=self.命令类型,目标=id,敌我=0,参数=self.命令参数,附加=self.命令附加}
  if self.操作对象>=self.对象上限 then
    请求服务(5502,self.完成指令)
    战斗类.进程="等待"
    self:重置高亮()
  else
    self.操作对象=self.操作对象+1
    self:重置高亮()
  end
end

function 战斗命令类:设置道具(玩家id,无法使用)
  self.道具栏:打开(玩家id,无法使用)
end
function 战斗命令类:设置灵宝(数据)
  self.灵宝栏:打开(数据)
end

function 战斗命令类:设置捕捉(法术)
  self.命令类型="捕捉"
  --self.命令参数=法术.技能.名称
  self.命令附加=4
  self.命令版面=false
  self.法术开关=false
  tp.鼠标.置鼠标("捕捉")
end

function 战斗命令类:设置法术参数(法术)
    if 法术.技能==nil then
      return
    end
    local  查找主动 = false
    local 类型="法术"
    for k,v in pairs(self.参战单位[self.单位编号[self.操作对象]].主动技能) do
        if 法术.技能.名称 ==v.名称 then
            查找主动=true
            break
        end
    end
    if self.参战单位[self.单位编号[self.操作对象]].类型== "角色" and not 查找主动 then
        for k,v in pairs(self.参战单位[self.单位编号[self.操作对象]].特技技能) do
            if 法术.技能.名称 ==v.名称 then
                查找主动=true
                类型="特技"
                break
            end
        end
    end
  if  查找主动 then
      self.命令类型=类型
      self.命令参数=法术.技能.名称
      local 临时种类=引擎.取技能(法术.技能.名称)
      self.命令附加=临时种类[3]
      self.命令版面=false
      self.法术开关=false
      tp.鼠标.置鼠标("道具")
      if 法术.技能.名称=="妙手空空" then
          self.命令附加=4
      end
      if self.命令附加==66 then
          self:设置指令(self.单位编号[self.操作对象])
      end
  else
        tp.常规提示:打开("#Y/无法使用该法术")
        self.命令参数=""
        self:重置高亮()
        self.命令版面=true
        tp.鼠标.置鼠标("普通")
        self.命令类型="攻击"
        self.命令附加=4


  end
  -- print( self.命令类型,self.命令参数,self.命令附加)
end

function 战斗命令类:设置快捷法术参数(法术)
     if 法术==nil or 法术.名称==nil then
       return
     end
    local  查找主动 = false
    local 类型="法术"
    for k,v in pairs(self.参战单位[self.单位编号[self.操作对象]].主动技能) do
        if 法术.名称 ==v.名称 then
            查找主动=true
            break
        end
    end
    if self.参战单位[self.单位编号[self.操作对象]].类型== "角色" and not 查找主动 then
        for k,v in pairs(self.参战单位[self.单位编号[self.操作对象]].特技技能) do
            if 法术.名称 ==v.名称 then
                查找主动=true
                类型="特技"
                break
            end
        end
    end

    if 查找主动 then
        self.命令类型=类型
        self.命令参数=法术.名称
        local 临时种类=引擎.取技能(法术.名称)
        self.命令附加=临时种类[3]
        self.命令版面=false
        self.法术开关=false
        tp.鼠标.置鼠标("道具")
        if 法术.名称=="妙手空空" then
            self.命令附加=4
        end
        if self.命令附加==66 then
            self:设置指令(self.单位编号[self.操作对象])
        end
    else
          tp.常规提示:打开("#Y/无法使用该法术")
          self.命令参数=""
          self:重置高亮()
          self.命令版面=true
          tp.鼠标.置鼠标("普通")
          self.命令类型="攻击"
          self.命令附加=4
    end
end



function 战斗命令类:设置默认法术(法术,操作对象)
        self.默认法术[操作对象]=法术
end

function 战斗命令类:获取默认法术(操作对象)
  return self.默认法术[操作对象]
end


function 战斗命令类:自动使用默认法术(法术)
    if 法术==nil or 法术.名称==nil  then
      return
    end

    local  查找主动 = false
    local 类型="法术"
    for k,v in pairs(self.参战单位[self.单位编号[self.操作对象]].主动技能) do
        if 法术.名称 ==v.名称 then
            查找主动=true
            break
        end
    end
    if self.参战单位[self.单位编号[self.操作对象]].类型== "角色" and not 查找主动 then
        for k,v in pairs(self.参战单位[self.单位编号[self.操作对象]].特技技能) do
            if 法术.名称 ==v.名称 then
                查找主动=true
                类型="特技"
                break
            end
        end
    end
   if 查找主动 then
        self.敌方单位组 = {}
        self.我方单位组 = {}
        for n = 1, #self.参战单位, 1 do
            if self.参战单位[n].敌我 == 2 then
                self.敌方单位组[#self.敌方单位组 + 1] = n
            elseif self.参战单位[n].敌我 == 1 then
                self.我方单位组[#self.我方单位组 + 1] = n
            end
        end

        self.命令类型=类型
        self.命令参数=法术.名称
        local 临时种类=引擎.取技能(法术.名称)
        self.命令附加=临时种类[3]
        self.命令版面=false
        self.法术开关=false
        --tp.鼠标.置鼠标("道具")
        if 法术.名称=="妙手空空" then
          self.命令附加=4
        end
        if self.命令附加==66 then
          self:设置指令(self.单位编号[self.操作对象])
          return
        end
        local n=1
        --print( self.命令类型,self.命令参数,self.命令附加)
        if self.命令附加==4 then
            n = self.敌方单位组[取随机数(1, #self.敌方单位组)]
        elseif self.命令附加==3 or self.命令附加==5 or self.命令附加==6 then
            n = self.我方单位组[取随机数(1, #self.我方单位组)]
        end
        self:设置指令(n)
   else
        tp.常规提示:打开("#Y/无法使用该法术")
        self.命令参数=""
        self:重置高亮()
        self.命令版面=true
        tp.鼠标.置鼠标("普通")
        self.命令类型="攻击"
        self.命令附加=4
   end
end



function 战斗命令类:更新(dt,x,y,类型)
  if self.道具栏.可视 then
    self.道具栏:更新(dt,x,y)
  end
  if self.灵宝栏.可视  then
    self.灵宝栏:更新(dt,x,y)
  end
  local js = 0   ---------灵宝
  if self.命令版面 then

    if not self.参战单位 then return end
    if not self.单位编号 then return end
    if not self.单位编号[self.操作对象] then return end
    local 战斗单位 = self.参战单位[self.单位编号[self.操作对象]]
    if not 战斗单位 then return end
    if self.操作对象==1 then-------------------人物命令
      self.人物资源组[2]:更新1(x,y)
      self.人物资源组[3]:更新1(x,y)
      self.人物资源组[4]:更新1(x,y)
      self.人物资源组[5]:更新1(x,y)
      self.人物资源组[6]:更新1(x,y)
      self.人物资源组[7]:更新1(x,y)
      --self.人物资源组[8]:更新1(x,y)
      self.人物资源组[9]:更新1(x,y)
      self.人物资源组[10]:更新1(x,y)
      self.人物资源组[11]:更新1(x,y)
      self.人物资源组[12]:更新1(x,y)
      self.人物资源组[13]:更新1(x,y)
      self.人物资源组[14]:更新1(x,y)
      if (keyaz(KEY.ALT) and keyax(KEY.Q)) then
          if self.默认法术[self.操作对象] and 战斗单位.主动技能 then
            if 战斗单位.主动技能[self.默认法术[self.操作对象]] and 战斗单位.主动技能[self.默认法术[self.操作对象]].名称 then
                self:自动使用默认法术(战斗单位.主动技能[self.默认法术[self.操作对象]])
            else
                tp.常规提示:打开("#Y/未设置快捷键技能!自动转为普通攻击...")
                self:设置指令1(0)
            end
          else
              tp.常规提示:打开("#Y/未设置快捷键技能!自动转为普通攻击...")
              self:设置指令1(0)
          end
      elseif keyaz(KEY.ALT) and keytq(KEY.S) then
          if self.默认法术[self.操作对象]~=nil and  战斗单位.主动技能~=nil then
            if 战斗单位.主动技能[self.默认法术[self.操作对象]] and 战斗单位.主动技能[self.默认法术[self.操作对象]].名称 then
                self:设置快捷法术参数(战斗单位.主动技能[self.默认法术[self.操作对象]])
              else
                tp.常规提示:打开("#Y/未设置快捷键技能!自动转为普通攻击...")
                self:设置指令1(0)
              end
          else
              tp.常规提示:打开("#Y/未设置快捷键技能!自动转为普通攻击...")
              self:设置指令1(0)
          end
      elseif (keyaz(KEY.ALT) and keyax(KEY.A)) then
        self:设置指令1(0)
      elseif self.人物资源组[7]:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.T)) then
          self.命令版面=false
          self.命令类型="保护"
          tp.鼠标.置鼠标("保护")
          js=1  ------------灵宝
      elseif self.人物资源组[2]:事件判断() or (keyaz(KEY.ALT) and keytq(KEY.W)) then
          tp.鼠标.置鼠标("普通")
          self.法术界面:打开(战斗单位.主动技能,"法术",self.操作对象,战斗单位)
      elseif self.人物资源组[4]:事件判断() or (keyaz(KEY.ALT) and keytq(KEY.Z)) then
          tp.鼠标.置鼠标("普通")
          self.法术界面:打开(战斗单位.特技技能,"特技",self.操作对象,战斗单位)
     elseif self.人物资源组[3]:事件判断() then --法宝
          请求服务(5508)

      elseif self.人物资源组[5]:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.E)) then --道具
          请求服务(5599)
      elseif self.人物资源组[6]:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.D)) then --防御
        self.命令类型="防御"
        self:设置指令1(0)
      elseif self.人物资源组[9]:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.R)) then --宠物
        if self.召唤界面.可视 then
          self.召唤界面:打开(tp.队伍[1])
        else
          请求服务(5505)
        end
      elseif self.人物资源组[11]:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.X)) then --自动战斗
        if not 多角色操作 then
          if 战斗类.自动开关 then
            战斗类.自动开关=false
          else
            战斗类.自动开关=true
          end
        end
      elseif self.人物资源组[12]:事件判断() then
        self:设置捕捉()
      elseif self.人物资源组[13]:事件判断() then
        self:设置逃跑()
      elseif self.人物资源组[14]:事件判断() then --灵宝
        请求服务(5523)
       -- 请求服务(5523)
      elseif (keyaz(KEY.ALT) and keyax(KEY.G)) then
        self:设置捕捉(法术)
      end
    else
        if 战斗单位.数据.类型=="bb" then
            self.召唤兽资源组[2]:更新1(x,y)
            self.召唤兽资源组[3]:更新1(x,y)
            self.召唤兽资源组[4]:更新1(x,y)
            self.召唤兽资源组[5]:更新1(x,y)
            self.召唤兽资源组[6]:更新1(x,y)
            self.召唤兽资源组[7]:更新1(x,y)
            self.召唤兽资源组[8]:更新1(x,y)
              if (keyaz(KEY.ALT) and keyax(KEY.Q)) then
              if self.默认法术[self.操作对象] and  战斗单位.主动技能 then
                  if 战斗单位.主动技能[self.默认法术[self.操作对象]] and 战斗单位.主动技能[self.默认法术[self.操作对象]].名称 then
                    self:自动使用默认法术(战斗单位.主动技能[self.默认法术[self.操作对象]])
                  else
                    tp.常规提示:打开("#Y/未设置快捷键技能!自动转为普通攻击...")
                    self:设置指令1(0)
                  end
                else
                  tp.常规提示:打开("#Y/未设置快捷键技能!自动转为普通攻击...")
                  self:设置指令1(0)
                end
              elseif keyaz(KEY.ALT) and keytq(KEY.S) then
                    if self.默认法术[self.操作对象] and 战斗单位.主动技能 then
                      if 战斗单位.主动技能[self.默认法术[self.操作对象]] and 战斗单位.主动技能[self.默认法术[self.操作对象]].名称l then
                          self:自动使用默认法术(战斗单位.主动技能[self.默认法术[self.操作对象]])
                        else
                          tp.常规提示:打开("#Y/未设置快捷键技能!自动转为普通攻击...")
                          self:设置指令1(0)
                        end
                    else
                        tp.常规提示:打开("#Y/未设置快捷键技能!自动转为普通攻击...")
                        self:设置指令1(0)
                    end






              elseif (keyaz(KEY.ALT) and keyax(KEY.A)) then
                self:设置指令1(0)
              elseif self.召唤兽资源组[5]:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.T)) then
                self.命令版面=false
                self.命令类型="保护"
                tp.鼠标.置鼠标("保护")
              elseif self.召唤兽资源组[2]:事件判断() or (keyaz(KEY.ALT) and keytq(KEY.W)) then
                tp.鼠标.置鼠标("普通")

                self.法术界面:打开(战斗单位.主动技能,"法术",self.操作对象,战斗单位)
              elseif self.召唤兽资源组[3]:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.E)) then
                请求服务(5504,{玩家=战斗单位.编号})
              elseif self.召唤兽资源组[4]:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.D)) then
                self.命令类型="防御"
                self:设置指令1(0)
              elseif self.召唤兽资源组[6]:事件判断() then
                self:设置逃跑()
              end
        else
             if self.完成指令[1].类型 == "逃跑" then
                self:设置逃跑()
              end
              self.角色资源组[2]:更新1(x,y) --法术
              self.角色资源组[3]:更新1(x,y) --特技
              self.角色资源组[4]:更新1(x,y) --道具
              self.角色资源组[5]:更新1(x,y) --防御
              self.角色资源组[6]:更新1(x,y) --保护
              self.角色资源组[8]:更新1(x,y) --法宝
              self.角色资源组[9]:更新1(x,y) --召唤
              self.角色资源组[7]:更新1(x,y) --灵宝
              self.角色资源组[11]:更新1(x,y) --捕捉
              if (keyaz(KEY.ALT) and keyax(KEY.Q)) then
                if self.默认法术[self.操作对象] and 战斗单位.主动技能 then
                  if 战斗单位.主动技能[self.默认法术[self.操作对象]] and 战斗单位.主动技能[self.默认法术[self.操作对象]].名称 then
                    self:自动使用默认法术(战斗单位.主动技能[self.默认法术[self.操作对象]])
                  else
                    tp.常规提示:打开("#Y/未设置快捷键技能!自动转为普通攻击...")
                    self:设置指令1(0)
                  end
                else
                  tp.常规提示:打开("#Y/未设置快捷键技能!自动转为普通攻击...")
                  self:设置指令1(0)
                end
              elseif keyaz(KEY.ALT) and keytq(KEY.S) then
                    if self.默认法术[self.操作对象] and 战斗单位.主动技能 then
                      if 战斗单位.主动技能[self.默认法术[self.操作对象]] and 战斗单位.主动技能[self.默认法术[self.操作对象]].名称 then
                          self:设置快捷法术参数(战斗单位.主动技能[self.默认法术[self.操作对象]])
                      else
                          tp.常规提示:打开("#Y/未设置快捷键技能!自动转为普通攻击...")
                          self:设置指令1(0)
                      end
                    else
                        tp.常规提示:打开("#Y/未设置快捷键技能!自动转为普通攻击...")
                        self:设置指令1(0)
                    end
              elseif (keyaz(KEY.ALT) and keyax(KEY.A)) then
                self:设置指令1(0)
              elseif self.角色资源组[6]:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.T)) then
                self.命令版面=false
                self.命令类型="保护"
                tp.鼠标.置鼠标("保护")
              elseif self.角色资源组[2]:事件判断() or (keyaz(KEY.ALT) and keytq(KEY.W)) then --法术
                tp.鼠标.置鼠标("普通")
                self.法术界面:打开(战斗单位.主动技能,"法术",self.操作对象,战斗单位)
              elseif self.角色资源组[3]:事件判断() then
                tp.鼠标.置鼠标("普通")
                self.法术界面:打开(战斗单位.特技技能,"特技",self.操作对象,战斗单位)
              elseif self.角色资源组[4]:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.E)) then
                请求服务(5599,{玩家=战斗单位.编号})
              elseif self.角色资源组[8]:事件判断()  then
                请求服务(5508,{玩家=战斗单位.编号})
              elseif self.角色资源组[9]:事件判断()  then
                  if self.召唤界面.可视 then
                    self.召唤界面:打开(tp.多角色[战斗单位.id])
                  else
                    请求服务(5505,{玩家=战斗单位.编号})
                  end
              elseif self.角色资源组[7]:事件判断()  then
                    请求服务(5523,{玩家=战斗单位.编号})
              elseif self.角色资源组[11]:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.G))  then
                    self:设置捕捉()
              elseif self.角色资源组[5]:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.D)) then
                self.命令类型="防御"
                self:设置指令1(0)
              end

        end
    end
 	end
  if 引擎.鼠标弹起(右键) then
    if self.命令类型=="保护" or self.命令类型=="捕捉" or self.命令类型=="法术" or self.命令类型=="特技" or self.命令类型=="道具"  then
       self.命令版面=true
       self.命令类型="攻击"
    end
    tp.鼠标.置鼠标("普通")
  end
   self:选择单位(x,y)
  if not self.道具栏.可视  and  not self.灵宝栏.可视 and go then --and not 战斗类.自动栏.鼠标    ---灵宝
    if js~=0 then
      js=js-0.5
      else
        self:选择单位(x,y)
    end
  end



end

function 战斗命令类:重置高亮(x,y)
  local 单位选中=0
  for n=1,#self.参战单位 do
    if self.参战单位[n].高亮显示 then
      self.参战单位[n]:取消高亮()
      self.参战单位[n].高亮显示=nil
    end
  end
  tp.鼠标.置鼠标("普通")
end

function 战斗命令类:取类型选择(敌我)
  if self.命令类型=="法术" or self.命令类型=="特技" or self.命令类型=="道具" or self.命令类型=="灵宝" then
    if 敌我==2 and  (self.命令附加==4 or self.命令附加==99) then
      return true
    elseif 敌我==1 and (self.命令附加==5 or self.命令附加==6 or self.命令附加==3 or self.命令附加==99) then
      return true
    elseif 敌我~=nil and (self.命令附加==88) then
      return true
    end
  elseif self.命令类型=="攻击" or self.命令类型=="捕捉" then
    if 敌我==2 then
      return true
    end
  end
  return false
end

function 战斗命令类:界面重叠(x,y)
  if self.法术开关 and self.法术界面:检查点(x,y) then
    return true
  end
  return false
end

function 战斗命令类:选择单位(x,y)
  local 单位选中=0
  local 选中单位 = nil

  --print(self.道具开关,self.法术开关,self.召唤开关)
  -- for i=1,#战斗类.敌方头像组 do
  --     if 战斗类.敌方头像组[i]:是否选中(x,y) and 选中单位~=true and self:界面重叠(x,y)==false and self.法术开关==false and self.召唤开关==false and self.道具开关==false then
  --         选中单位=true
  --         local 允许选择=self:取类型选择(战斗类.敌方头像组[i].敌我)
  --         if self.命令类型=="攻击" and 允许选择 then
  --           tp.鼠标.置鼠标("攻击")
  --         end
  --         if 允许选择 and 引擎.鼠标弹起(左键)  then
  --            self:设置指令(战斗类.敌方头像组[i].num)
  --         end
  --     end
  --   end
  --   for i=1,#战斗类.我方头像组 do
  --     if 战斗类.我方头像组[i]:是否选中(x,y) and 选中单位~=true and self:界面重叠(x,y)==false and self.法术开关==false and self.召唤开关==false and self.道具开关==false then
  --         选中单位=true
  --         local 允许选择=self:取类型选择(战斗类.我方头像组[i].敌我)
  --         if self.命令类型=="攻击" and 允许选择 then
  --           tp.鼠标.置鼠标("攻击")
  --         end
  --         if 允许选择 and 引擎.鼠标弹起(左键)  then
  --           self:设置指令(战斗类.我方头像组[i].num)
  --         end
  --     end
  --   end
  for n=#self.参战单位,1,-1 do
    if self.参战单位[n]:是否选中(x,y) and 选中单位~=true and self:界面重叠(x,y)==false and self.法术开关==false and self.召唤开关==false and self.道具开关==false and self.灵宝栏.可视 == false then--and self:取类型选择(self.参战单位[n].敌我)
      选中单位=true
      单位选中=n
      self.参战单位[n]:置高亮()
      self.参战单位[n].高亮显示=true
      -- 战斗类.提示=self.参战单位[n].名称
      local 允许选择=false
      if self.命令类型=="攻击" and (self.参战单位[n].敌我==2 or keyaz(KEY.CTRL)) and self:取类型选择(self.参战单位[n].敌我) then
        tp.鼠标.置鼠标("攻击")
        允许选择=true
      elseif self.命令类型=="保护" and self.参战单位[n].敌我==1 and n~=self.单位编号[self.操作对象] then
        允许选择=true
      elseif (self.命令类型=="法术" or self.命令类型=="特技") and self:取类型选择(self.参战单位[n].敌我) then
        允许选择=true
      elseif self.命令类型=="道具" and self:取类型选择(self.参战单位[n].敌我) then
        允许选择=true
      elseif self.命令类型=="灵宝" and self:取类型选择(self.参战单位[n].敌我) then
        允许选择=true
      -- elseif self.参战单位[n].敌我==2 and self.命令类型=="捕捉"  and n~=self.操作对象 and self:取类型选择(self.参战单位[n].敌我) then
      --   允许选择=true
      -- end
      ----------------摩托修改C位不能捕捉   删除and n~=self.操作对象
      elseif self.参战单位[n].敌我==2 and self.命令类型=="捕捉" and self:取类型选择(self.参战单位[n].敌我) then
        允许选择=true
      end
      if 允许选择 and 引擎.鼠标弹起(左键) then
         self:设置指令(n)
      elseif keyaz(KEY.CTRL) and 引擎.鼠标弹起(左键) then
          self.命令类型="攻击"
          self.命令附加= "友伤"
          self:设置指令(n)
      end
    elseif self.参战单位[n].高亮显示 then
      self.参战单位[n]:取消高亮()
      self.参战单位[n].高亮显示=nil
    end
  end
  if 单位选中==0 then  战斗类.提示=nil end
  if self.命令类型=="攻击" and 单位选中==0 then
    tp.鼠标.置鼠标("普通")
  end
end

function 战斗命令类:结束()
  tp.鼠标.置鼠标("普通")
end

function 战斗命令类:显示(dt,x,y,类型)
  if self.道具栏.可视 then
    self.道具栏:显示(dt,x,y)
  end
   if self.灵宝栏.可视 then
    self.灵宝栏:显示(dt,x,y)
  end
  if self.命令版面 then
          if self.操作对象==1 then
            -- self.人物资源组[1]:显示(self.x + 67,self.y)
            -- self.人物资源组[2]:显示(self.x + 70,self.y + 4)
            -- self.人物资源组[3]:显示(self.x + 70,self.y + 4 + 24)
            -- self.人物资源组[4]:显示(self.x + 70,self.y + 4 + 24 * 2)
            -- self.人物资源组[5]:显示(self.x + 70,self.y + 4 + 24 * 3)
            -- self.人物资源组[6]:显示(self.x + 70,self.y + 4 + 24 * 4)
            -- self.人物资源组[7]:显示(self.x + 70,self.y + 4 + 24 * 5)
            -- self.人物资源组[8]:显示(self.x + 70,self.y + 4 + 24 * 6)
            -- self.人物资源组[9]:显示(self.x + 70,self.y + 4 + 24 * 7)
            -- self.人物资源组[10]:显示(self.x + 70,self.y + 4 + 24 * 8)
            -- self.人物资源组[11]:显示(self.x + 70,self.y + 4 + 24 * 9)
            -- self.人物资源组[12]:显示(self.x + 70,self.y + 4 + 24 * 10)
            -- self.人物资源组[13]:显示(self.x + 70,self.y + 4 + 24 * 11)






            self.人物资源组[1]:显示(self.x + 67,self.y)
            self.人物资源组[2]:显示(self.x + 70,self.y + 4)
            self.人物资源组[3]:显示(self.x + 70,self.y + 4 + 24)
            self.人物资源组[4]:显示(self.x + 70,self.y + 4 + 24 * 2)
            self.人物资源组[5]:显示(self.x + 70,self.y + 4 + 24 * 4)
            self.人物资源组[6]:显示(self.x + 70,self.y + 4 + 24 * 5)
            self.人物资源组[7]:显示(self.x + 70,self.y + 4 + 24 * 6)
           -- self.人物资源组[8]:显示(self.x + 70,self.y + 4 + 24 * 7)
            self.人物资源组[9]:显示(self.x + 70,self.y + 4 + 24 * 7)
            self.人物资源组[10]:显示(self.x + 70,self.y + 4 + 24 * 8)
            self.人物资源组[11]:显示(self.x + 70,self.y + 4 + 24 * 9)
            self.人物资源组[12]:显示(self.x + 70,self.y + 4 + 24 * 10)
            self.人物资源组[13]:显示(self.x + 70,self.y + 4 + 24 * 11)
            self.人物资源组[14]:显示(self.x + 4,self.y -40 + 24 * 3)   ---灵宝





          else
            if self.参战单位[self.单位编号[self.操作对象]].数据.类型=="bb" then
               if self.操作对象~=2 then
                 zts:显示(self.x+70,self.y-20,self.参战单位[self.单位编号[self.操作对象]].名称)
               end
               self.召唤兽资源组[1]:显示(self.x + 67,self.y)
               self.召唤兽资源组[2]:显示(self.x + 70,self.y)
               self.召唤兽资源组[3]:显示(self.x + 70,self.y + 20)
               self.召唤兽资源组[4]:显示(self.x + 70,self.y + 20 + 24)
               self.召唤兽资源组[5]:显示(self.x + 70,self.y + 20 + 24 * 2)
               self.召唤兽资源组[8]:显示(self.x + 70,self.y + 20 + 24 * 3)
               self.召唤兽资源组[6]:显示(self.x + 70,self.y + 20 + 24 * 4)
               self.召唤兽资源组[7]:显示(self.x + 70,self.y + 20 + 24 * 5)
             else
                zts:显示(self.x+70,self.y-20,self.参战单位[self.单位编号[self.操作对象]].名称)
                self.角色资源组[1]:显示(self.x + 67,self.y-2)
                self.角色资源组[10]:显示(self.x + 67,self.y+48)
                self.角色资源组[2]:显示(self.x + 70,self.y)
                self.角色资源组[8]:显示(self.x + 70,self.y + 20)
                self.角色资源组[3]:显示(self.x + 70,self.y + 20+ 24)
                self.角色资源组[7]:显示(self.x + 4,self.y + 24)
                self.角色资源组[6]:显示(self.x + 70,self.y + 20 + 24 * 3)
                self.角色资源组[4]:显示(self.x + 70,self.y + 20 + 24 * 4)
                self.角色资源组[5]:显示(self.x + 70,self.y + 20 + 24 * 5)
                self.角色资源组[9]:显示(self.x + 70,self.y + 20 + 24 * 6)
                self.角色资源组[11]:显示(self.x + 70,self.y + 20 + 24 * 7)


              end
          end








          if self.法术次数[self.操作对象] then
             if self.完成指令[self.操作对象] and self.完成指令[self.操作对象].多重施法 then
                  self.法术序号[self.法术次数[self.操作对象]-#self.完成指令[self.操作对象].多重施法]:显示(self.x+112,self.y-2)
             else
                  self.法术序号[self.法术次数[self.操作对象]]:显示(self.x+112,self.y-2)
             end

          end






      if self.法术开关 then
        self.法术界面:显示(dt,x,y)
      end
      if self.召唤开关 then
        self.召唤界面:更新(dt,x,y)
        self.召唤界面:显示(dt,x,y)
      end
  end
end

function 战斗命令类:检查点(x,y)
  if self.资源组[1]:是否选中(x,y)  then
      return true
   else
      return false
  end
end

return 战斗命令类