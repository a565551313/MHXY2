-- @Author: baidwwy
-- @Date:   2023-10-04 01:10:19
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-06-08 16:40:19
--======================================================================--

--======================================================================--
local mp = require("script/连接网络/MessagePack")
local 回调 = require("script/连接网络/PackClient")()
回调.发送_ = 回调.发送
function 回调:发送(...)
    self:发送_(mp.pack{...})
end


local 数据记录=""

function 回调:初始化()
  self.连接账号 = ""
  self.连接密码 = ""
  self.连接结果 = false
end

function 回调:回调( ... )
  -- body
end
function 回调:数据到达2(序号,内容,时间)
  客户端:数据到达(序号)
end

function 回调:请求服务(序号,内容,数组转换) ---请求服务
  if 内容==nil then
    内容="1"
  end
  if 数组转换~=nil then
    内容.硬盘 = f函数.取硬盘序列号()
    内容=table.tostring(内容)
  end
  local 校验数据 = 取校验数据(序号,随机记录,随机1记录,时间记录)

  self.组合数据=序号..fgf..内容..fgf..时间记录..fgf..校验数据
  -- print(self.组合数据)
  -- if 数据记录==self.组合数据..时间 then return  end
 -- self:发送(jm(self.组合数据))
 self:发送(jm(self.组合数据))
  -- 数据记录=self.组合数据..时间
  -- print(self.组合数据)
end


function 取校验数据(序号,随机1,随机2,时间)
    local 协议号="xzcjasdiwsnfaasddwf"
    return  f函数.取MD5(序号..随机1..协议号..随机2..时间)
end

function 取回复量(a)
  return 3*a+12
end




function 回调:数据到达(数据内容)
  -- print(数据内容)
  -- local 收到内容 = jm1(数据内容)
  -- if not 收到内容 then return end
  local  data1 = mp.unpack(数据内容)
  if not data1 then return end
  local 内容 = data1[1]
   data1=nil
  --内容=jm1(内容)
  if 内容==nil or 内容=="" then return  end
  local 数据=table.loadstring(内容)
  if 数据==nil or 数据.序号==nil then return end
  数据.序号=数据.序号+0
  if 数据.序号 ~= 76541 and __gge.isdebug then
     print("收到序号:  "..数据.序号.."  收到内容:"..内容)
  end
  if 调试模式 and 数据.序号~=99 then
    -- print(内容)
     -- print(table.loadstring)
  end
    if tp == nil then
    tp = yq.场景
  end

  if 数据.序号<=1000 then
    self:系统处理(数据.序号,数据.内容,内容)
  elseif 数据.序号>1000 and 数据.序号<=1500 then
    self:地图处理(数据.序号,数据.内容)
  elseif 数据.序号>1500 and 数据.序号<=2000 then
    self:对话处理(数据.序号,数据.内容)
  elseif 数据.序号>3500 and 数据.序号<=4000 then
    self:道具处理(数据.序号,数据.内容)
  elseif 数据.序号>4000 and 数据.序号<=4500 then
    self:队伍处理(数据.序号,数据.内容)
  elseif 数据.序号>5500 and 数据.序号<=6000 then
    self:战斗处理(数据.序号,数据.内容)
  elseif 数据.序号>6000 and 数据.序号<=6100 then
    self:多角色处理(数据.序号,数据.内容)
  elseif 数据.序号>6200 and 数据.序号<=6300 then
    self:神器处理(数据.序号,数据.内容)
  elseif  数据.序号==76541 then
    时间记录=数据.内容.时间
    随机记录=取随机数(1,9999)
    随机1记录=取随机数(1,99999)
    if 数据.内容.服务状态==nil then  引擎.关闭() return end
    if 数据.内容.服务状态 ==0  then
        服务状态 =false
    else
        服务状态= true
    end
    --
    回调:请求服务(9527,随机记录..fgc..随机1记录)
    if 服务状态 and not 停止连接 and tp.场景 ~= nil and not 跨服模式  then
      停止连接 = true
      重新连接进入 = true
      断开游戏提示 = nil
      回调:请求服务(1.1,版本..fgc..系统参数.账号..fgc..系统参数.密码..fgc..版本)
      回调:请求服务(4.1,系统参数.选中玩家id..fgc..版本)
      tp.队伍数据={}
      if tp.窗口.队伍栏.可视 then
            tp.窗口.队伍栏:打开()
      end
      摊位名称=nil
      tp:关闭窗口()
      tp.场景.抓取物品 = nil
      tp.场景.抓取物品ID = nil
      tp.场景.抓取物品注释 = nil
    end
  elseif 数据.序号==76542 then
      服务状态= true
      时间记录=数据.内容
      回调:请求服务(1.5,取回复量(数据.内容))
      随机记录=取随机数(1,9999)
      随机1记录=取随机数(1,99999)
      回调:请求服务(9527,随机记录..fgc..随机1记录)
  elseif 数据.序号==76543 then
        if tp.场景 ~= nil  then
           停止连接 =  false
           if not 断开游戏提示 then
               断开游戏提示=1
               tp.常规提示:打开("#Y/断线重连中,请耐心等待,在提示连接成功前请不要进行操作,若连接时间较长，可以手动重启客户端")
            end
        end
  elseif 数据.序号==76544 then
         回调:请求服务(1.6,系统参数.账号..fgc..系统参数.密码..fgc..系统参数.名称..fgc..系统参数.数字id..fgc..系统参数.角色名称..fgc..f函数.取硬盘序列号())




  end
end

function 回调:神器处理(序号,内容) --6200 and 数据.序号<=6300
  if 序号 == 6202 then
    if tp.窗口.神器获得.可视==false then
        tp.窗口.神器获得:打开(内容.mp)

      -- if tp.窗口.成就提示.可视==false then
      --       tp.窗口.成就提示:打开({内容="上古神器",内容1="获得对应门派的神器"})
      --   else
      --        tp.窗口.成就提示:刷新({头像="飞燕女",标题="上古神器",说明="获得对应门派的神器"})
      --   end
    end
  elseif 序号==6205 then
      if tp.窗口.修复神器.可视 then
          tp.窗口.修复神器:放弃镶嵌(内容)
      end
  elseif 序号 == 6203 then
    if tp.窗口.法宝.可视 then
      tp.窗口.法宝:神器刷新(内容)
    end
  elseif 序号==6204 then
    if tp.窗口.修复神器.可视 then
        tp.窗口.修复神器:解锁区域(内容)
    end
  elseif 序号 == 6208 then
    if tp.窗口.神器查看.可视 == false then
        tp.窗口.神器查看:打开(内容)
    end
  elseif 序号 == 6210 then
    if tp.窗口.修复神器.可视==false then
      tp.窗口.修复神器:打开(内容)
    end
  elseif 序号==6215 then
    if tp.窗口.修复神器.可视 then
      tp.窗口.修复神器:激活插槽更新(内容)
    end
  elseif 序号==6216 then
    if tp.窗口.修复神器.可视 then
      tp.窗口.修复神器:更新(内容)
    end
  elseif 序号==6217 then
      if tp.窗口.修复神器.可视 then
      tp.窗口.修复神器:镶嵌完成(内容)
      end
  elseif 序号==6218 then
      if tp.窗口.合成灵犀玉.可视 == false then
      tp.窗口.合成灵犀玉:打开(内容)
    end
  elseif 序号==6219 then
    if tp.窗口.合成灵犀玉.可视 then
        tp.窗口.合成灵犀玉:合成开始(内容)
    end
  elseif 序号==6201 then
    if tp.窗口.神器更换五行.可视 == false then
      tp.窗口.神器更换五行:打开(内容)
    end
  elseif 序号==6207 then
      if tp.窗口.神器更换五行.可视 then
        tp.窗口.神器更换五行:新五行(内容)
      end
    elseif 序号==6209 then
    if tp.窗口.神器更换五行.可视 then
      tp.窗口.神器更换五行:更新(内容)
    end
  elseif 序号==6211 then
      tp.队伍[1].神器佩戴 = 内容.是否
      if tp.窗口.法宝.可视 then
         tp.窗口.法宝:神器刷新(tp.队伍[1].神器数据)
      end


  elseif 序号==6212 then
      tp.队伍[1].门派=内容
      if tp.窗口.法宝.可视 then
         tp.窗口.法宝:打开()
      end
      if tp.窗口.神器查看.可视 then
         tp.窗口.神器查看:打开()
      end
      if tp.窗口.修复神器.可视 then
         tp.窗口.修复神器:打开()
      end
  end
  内容=nil
end

function 回调:多角色处理(序号,内容)

  --  elseif 序号 == 115 then
  --   内容.角色 = tonumber(内容.角色)
  --   tp.多角色[内容.角色]=tp._队伍.创建()
  --   tp.多角色[内容.角色]:重置属性(内容.玩家数据)
  -- elseif 序号 == 116 then
  --   内容.角色 = tonumber(内容.角色)
  --   tp.多角色[内容.角色].宝宝列表=内容.召唤兽
  --   tp.多角色[内容.角色]:刷新宝宝技能()
  --   tp.多角色[内容.角色]:刷新宝宝认证技能()

-- print(序号)
-- table.print(内容)
 if tp.多角色[内容.角色]==nil then 内容=nil return end
  if tp.窗口.物品加锁.可视 then tp.窗口.物品加锁:打开() end
  if 序号==6001 then
    tp.多角色[内容.角色]:重置属性(内容.角色属性)
    if tp.窗口.多角色状态栏.可视 then
       tp.窗口.多角色状态栏:刷新(内容.角色)
    else
       tp.窗口.多角色状态栏:打开(内容.角色)
    end
  elseif 序号==6002 then
    tp.多角色[内容.角色]:重置属性(内容.角色属性)
  elseif 序号==6003 then
      tp.多角色[内容.角色].辅助技能[内容.序列].等级=内容.等级
      if tp.窗口.多角色状态栏.可视 and tp.窗口.多角色状态栏.辅助技能[内容.序列]~=nil and tp.窗口.多角色状态栏.辅助技能[内容.序列].技能~=nil then
        tp.窗口.多角色状态栏.辅助技能[内容.序列].技能.等级=内容.等级
        local 临时消耗=生活技能消耗(内容.等级+1,1)
        if  tp.窗口.多角色状态栏.辅助技能[内容.序列].技能.名称 == "强壮" then
           临时消耗=生活技能消耗(内容.等级+1,2)
        end
        tp.窗口.多角色状态栏.辅助技能[内容.序列].技能.介绍= tp.窗口.多角色状态栏.辅助技能[内容.序列].技能.原介绍..'\n'.."#Y/学习消耗："..'\n#G'..临时消耗.经验.."#Y点人物经验"..'\n#G'..临时消耗.金钱.."#Y两银子"
      end
	  elseif 序号==6003.1 then
      tp.多角色[内容.角色].强化技能[内容.序列].等级=内容.等级
      if tp.窗口.多角色状态栏.可视 and tp.窗口.多角色状态栏.强化技能[内容.序列]~=nil and tp.窗口.多角色状态栏.强化技能[内容.序列].技能~=nil then
        tp.窗口.多角色状态栏.强化技能[内容.序列].技能.等级=内容.等级
        --local 临时消耗=生活技能消耗(内容.等级+1,2)
        --tp.窗口.多角色状态栏.强化技能[内容.序列].技能.介绍= tp.窗口.多角色状态栏.强化技能[内容.序列].技能.原介绍..'\n'.."#Y/学习消耗："..'\n#G'..临时消耗.经验.."#Y点人物经验"..'\n#G'..临时消耗.金钱.."#Y两银子"
      end
  elseif 序号==6004 then
      tp.多角色[内容.角色].修炼=内容.人物
      tp.多角色[内容.角色].bb修炼=内容.bb
  elseif 序号==6005 then
      if tp.窗口.多角色奇经八脉.可视 then
         tp.窗口.多角色奇经八脉:刷新(tp.多角色[内容.角色],内容.角色)
      else
         tp.窗口.多角色奇经八脉:打开(tp.多角色[内容.角色],内容.角色)
      end
   elseif 序号==6006 then
      if tp.窗口.多角色道具行囊.可视 then
         tp.窗口.多角色道具行囊:刷新(内容.角色)
      else
         tp.窗口.多角色道具行囊:打开(内容.角色)
      end
   elseif 序号==6007 then
       tp.多角色[内容.角色].道具列表=内容.道具.道具
       if tp.窗口.多角色道具行囊.可视 and tp.窗口.多角色道具行囊.点击类型=="道具" then
          tp.窗口.多角色道具行囊:刷新道具资源()
       end
   elseif 序号==6008 then
       tp.多角色[内容.角色].宝宝列表 = 内容.召唤兽
       tp.多角色[内容.角色]:刷新宝宝技能()
       tp.多角色[内容.角色]:刷新宝宝认证技能()
   elseif 序号==6009 then
       tp.多角色[内容.角色].行囊列表=内容.道具.道具
       if tp.窗口.多角色道具行囊.可视 and tp.窗口.多角色道具行囊.点击类型=="行囊" then
          tp.窗口.多角色道具行囊:刷新行囊资源()
       end
   elseif 序号==6010 then
      tp.多角色[内容.角色].法宝 = 内容.道具.法宝
      tp.多角色[内容.角色].法宝佩戴 = 内容.道具.佩戴
      if tp.窗口.多角色道具行囊.可视 and tp.窗口.多角色道具行囊.点击类型=="法宝" then
         tp.窗口.多角色道具行囊:刷新法宝资源()
      end
   elseif 序号==6011 then
       tp.窗口.多角色道具行囊:更新法宝经验(内容)
   elseif 序号==6012 then
      tp.窗口.多角色道具行囊:刷新装备()
   elseif 序号==6013 then
      if tp.窗口.多角色道具行囊.可视 then
          tp.窗口.多角色道具行囊:刷新灵饰()
          tp.窗口.多角色道具行囊.窗口="主人公"
          tp.窗口.多角色道具行囊.主人公分类="灵饰"
        end
   elseif 序号==6014 then
        if tp.窗口.多角色道具行囊.可视 then
          tp.窗口.多角色道具行囊:刷新锦衣()
          tp.窗口.多角色道具行囊.窗口="主人公"
          tp.窗口.多角色道具行囊.主人公分类="锦衣"
        end
   elseif 序号==6015 then
         tp.窗口.多角色道具行囊:置形象()
  elseif 序号==6016 then
        tp.多角色[内容.角色].坐骑=内容.坐骑
  elseif 序号==6017 then
        tp.窗口.多角色道具行囊:刷新坐骑饰品()
  elseif 序号==6018 then
        tp.窗口.多角色仓库类:打开(内容.道具.道具,内容.仓库总数,内容.召唤兽总数,内容.角色)
  elseif 序号==6019 then
       if 内容.数据类型=="道具" then
         tp.多角色[内容.角色].道具列表=内容.道具.道具
       else
         tp.多角色[内容.角色].行囊列表=内容.道具.道具
       end
        tp.窗口.多角色仓库类.道具类型=内容.道具.数据类型
  elseif 序号==6020 then
         tp.窗口.多角色仓库类:刷新道具()

  elseif 序号==6021 then
      if tp.窗口.多角色仓库类.仓库类型=="道具" then
        tp.窗口.多角色仓库类:刷新仓库(内容.道具.道具,内容.页数,内容.角色)
      elseif tp.窗口.多角色仓库类.仓库类型=="召唤兽" then
        tp.多角色[内容.角色].宝宝列表 = 内容.宝宝列表
        tp.窗口.多角色仓库类:刷新仓库(内容.召唤兽仓库数据,内容.页数,内容.角色)
      end
  elseif 序号==6022 then
     tp.窗口.多角色仓库类:刷新道具仓库总数(内容.道具.道具,内容.总数,内容.角色)
   elseif 序号==6023 then
    tp.多角色[内容.角色].宝宝列表 = 内容.召唤兽
    tp.窗口.多角色仓库类:刷新召唤兽仓库总数(内容.召唤兽仓库总数,内容.召唤兽仓库数据,内容.角色)
   elseif 序号==6024 then
     tp.窗口.多角色回收系统:刷新(内容)
  elseif 序号==6025 then--18
    for n=1,#tp.多角色[内容.角色].宝宝列表 do
       tp.多角色[内容.角色].宝宝列表[n].参战信息=nil
        if 内容.召唤兽.认证码 == tp.多角色[内容.角色].宝宝列表[n].认证码 then
          tp.多角色[内容.角色].宝宝列表[n].参战信息=1
        end
    end
   elseif 序号==6026 then
     tp.窗口.多角色召唤兽属性栏:刷新宝宝(内容.角色)
   elseif 序号==6027 then
      tp.多角色[内容.角色].宝宝列表[内容.序列].名称=内容.名称
  elseif 序号==6028 then
      tp.窗口.多角色召唤兽属性栏:放生()





  end
内容 = nil
end





function 回调:战斗处理(序号,内容)
  if 序号==5501 then
    --战斗类:进入战斗过度()
    tp.战斗中=true
    战斗类.队伍id=内容.id
    战斗类.单位总数=内容.总数
    收到流程=tonumber(内容.收到)
    发送流程=tonumber(内容.发送)
    战斗类:进入获取分辨率()
    self.地图音乐=nil
    if tp.音乐~=nil then
      tp.音乐:置音量(0)
    end
    local 战斗播放音效=引擎.取音效1(内容.音乐 or 100007)
    战斗音乐=tp.资源:载入(wdf配置.."/"..战斗播放音效,"音乐",nil)
    if 游戏音量>0 and tp.音乐开启 then
      战斗音乐:播放(true)
      战斗音乐:置音量(游戏音量)
    end
    if tp.场景.抓取物品 ~= nil then
      tp.场景.抓取物品 = nil
      tp.鼠标.置鼠标("普通")
    end
  elseif 序号==5502 then
    战斗类:加载单位(内容)
  elseif 序号==5503 then
    战斗类:设置命令回合(内容[1])
    --回合数传值的地方
    战斗类.回合数 = 内容[2]
  elseif 序号==5503.1 then
    战斗类:设置重连命令回合(内容[1],内容[3],内容[4])
    --回合数传值的地方
    战斗类.回合数 = 内容[2]
  elseif 序号==收到流程 then--5504
    战斗类:设置战斗流程(内容)
  elseif 序号==5505 then
    战斗类:退出战斗过度()
    tp.战斗中=false
    tp.窗口.战斗排行框.隐藏=true
    战斗类.我方阵型=nil
    战斗类.敌方阵型=nil

    战斗类.战斗单位={}
    战斗类.我方头像组={}
    战斗类.敌方头像组={}
    战斗类.观战模式=false
    战斗类.战斗类型=0
    战斗类.拼接特效=nil
    战斗类.背景状态=0
    战斗类.战斗流程={}
    战斗类.执行流程=0
    战斗类.进程=nil
    多角色操作数据={}
    战斗类:卸载()
    for v,k in pairs(tp.战斗音效序列) do
        k:停止()
    end
    tp.战斗音效序列={}
    if 战斗音乐~=nil then
      战斗音乐:停止()
      战斗音乐=nil
    end
    触碰延时=时间
    if tp.音乐~=nil then
      tp.音乐:置音量(游戏音量)
    end
    tp.鼠标.置鼠标("普通")
	  collectgarbage("collect")
  elseif 序号==5506 then
    if tp.战斗中 then
      return
    end
    if tp.队伍~=nil and tp.队伍[1]~=nil then
        tp.队伍[1].气血=内容[1].气血
		    tp.队伍[1].气血上限=内容[1].气血上限
        tp.队伍[1].最大气血=内容[1].最大气血
        tp.队伍[1].魔法=内容[1].魔法
        tp.队伍[1].最大魔法=内容[1].最大魔法
        tp.队伍[1].愤怒=内容[1].愤怒
        if 内容[2]~=nil then
          tp.队伍[1].参战宝宝.气血=内容[2].气血
          tp.队伍[1].参战宝宝.最大气血=内容[2].最大气血
          tp.队伍[1].参战宝宝.魔法=内容[2].魔法
          tp.队伍[1].参战宝宝.最大魔法=内容[2].最大魔法
        end
    end
  elseif 序号==5507 then
    战斗类:取消状态(内容)
  elseif 序号==5508 then
    战斗类:鬼魂复活(内容)
  elseif 序号==5509 then
    if 内容.玩家id ==tp.队伍[1].数字id then
         tp.战斗道具=内容.道具.道具
    else
         tp.多角色[内容.玩家id].战斗道具=内容.道具.道具
    end

    战斗类.战斗指令:设置道具(内容.玩家id,内容.无法使用)
  elseif 序号==5510 then
   if 内容.玩家id ==tp.队伍[1].数字id then
    tp.队伍[1].宝宝列表=内容.召唤兽.数据
    战斗类.战斗指令.召唤界面:打开(tp.队伍[1],内容.召唤兽.数量)
   else
     tp.多角色[内容.玩家id].宝宝列表 = 内容.召唤兽.数据
     战斗类.战斗指令.召唤界面:打开(tp.多角色[内容.玩家id],内容.召唤兽.数量)
   end

  elseif 序号==5511 then  --开启自动战斗后进入等待
    战斗类.进程="等待"
  elseif 序号==5512 then
    local 编号=内容.id
    if 战斗类.战斗单位[编号]==nil then return  end
    战斗类.战斗单位[编号].喊话:写入(战斗类.战斗单位[编号],战斗类.战斗单位[编号].动画.动画,内容.文本,nil,内容.特效)

  elseif 序号==5513 then
    for n=1,#内容 do
     战斗类.战斗单位[内容[n].id].数据.自动指令=内容[n].自动
    end
  elseif 序号==5514 then
    for n=1,#内容 do
     战斗类.战斗单位[内容[n].id].数据.自动战斗=内容[n].自动
    end
  elseif 序号==5515 then
           战斗类:加载单位(内容,"观战")
  --   if 内容==nil then
  --     return
  --   end
  --   for n=1,#内容 do
  --     战斗类:加载单位(内容[n])
  --   end
 -- elseif 序号==5516 then
 --    if 内容==nil then
 --      return
 --    end
 --    for n=1,#内容 do
 --     战斗类:加载单位(内容[n],"观战")
 --    end
  --elseif 序号==5517 then
    -- tp.队伍[1].参战宝宝.气血=内容.气血
    -- tp.队伍[1].参战宝宝.最大气血=内容.最大气血
    -- tp.队伍[1].参战宝宝.魔法=内容.魔法
    -- tp.队伍[1].参战宝宝.最大魔法=内容.最大魔法
  elseif 序号==5518 then
    战斗类:刷新技能(内容)
  elseif 序号==5519 or 序号==5519.1 then
         战斗类:状态同步(内容,序号)
  -- elseif 序号==5519 or 序号==5519.1 then

  --   -- print("================================")
  --   --table.print(内容)
  --   -- print("================================")
  --   战斗类.法术状态=内容
  --   for k,v in pairs(内容) do
  --       if v.战意~=nil then
  --           战斗类.战斗单位[k].战意= v.战意
  --       end
  --       if v.超级战意~=nil then
  --           战斗类.战斗单位[k].超级战意= v.超级战意
  --       end
  --       if v.风灵~=nil then
  --           战斗类.战斗单位[k].风灵= v.风灵
  --       end
  --       if v.剑意~=nil then
  --           战斗类.战斗单位[k].剑意= v.剑意
  --       end

  --       if v.灵药红~=nil then
  --           战斗类.战斗单位[k].灵药红= v.灵药红
  --           战斗类.战斗单位[k].灵药蓝= v.灵药蓝
  --           战斗类.战斗单位[k].灵药黄= v.灵药黄
  --       end

  --       if v.符咒~=nil then
  --           战斗类.战斗单位[k].符咒= v.符咒
  --       end
  --       if v.雷法崩裂~=nil then
  --           战斗类.战斗单位[k].雷法崩裂= v.雷法崩裂
  --           战斗类.战斗单位[k].雷法震煞= v.雷法震煞
  --           战斗类.战斗单位[k].雷法坤伏= v.雷法坤伏
  --           战斗类.战斗单位[k].雷法翻天= v.雷法翻天
  --           战斗类.战斗单位[k].雷法倒海= v.雷法倒海
  --       end
  --       if v.五行珠金~=nil then
  --           战斗类.战斗单位[k].五行珠金= v.五行珠金
  --           战斗类.战斗单位[k].五行珠木= v.五行珠木
  --           战斗类.战斗单位[k].五行珠水= v.五行珠水
  --           战斗类.战斗单位[k].五行珠火= v.五行珠火
  --           战斗类.战斗单位[k].五行珠土= v.五行珠土
  --       end
  --       if v.人参娃娃~=nil then
  --           战斗类.战斗单位[k].人参娃娃= v.人参娃娃
  --       end
  --       if 序号==5519.1 then
  --          if 战斗类.战斗单位[k].气血<=0 then
  --             if 战斗类.法术状态[k] and 战斗类.法术状态[k].复活  then
  --                 战斗类.战斗单位[k]:开启击退(2)
  --             else
  --                  战斗类.战斗单位[k]:开启击退(1)
  --             end
  --          elseif type(v)=="table" then
  --             for z,n in pairs(v) do
  --                 战斗类.战斗单位[k]:增加状态(z)
  --             end
  --          end
  --       end
  --   end

  elseif 序号==5520 then
    战斗类.我方头像组={}
    战斗类.敌方头像组={}
	  战斗类:设置血量同步(内容)
    for k=1,#内容 do
      for n,v in pairs(内容[k]) do
        战斗类.战斗单位[k].数据[n]= v
      end
      --战斗类:加载单位头像(战斗类.战斗单位[k],k)
    end
 elseif 序号==5521 then
    战斗类:设置魔法愤怒同步(内容)
 elseif 序号==5522 then
    if 内容~=nil then
       for k,v in pairs(内容) do
        if 战斗类.战斗单位[k]~=nil then
          战斗类.战斗单位[k].技能冷却 = 内容[k]
        end
       end
    end
elseif 序号==5523 then   ------------------灵宝
      if 内容.玩家id ==tp.队伍[1].数字id then
           tp.队伍[1].灵宝佩戴=内容.灵宝佩戴
      else
           tp.多角色[内容.玩家id].灵宝佩戴=内容.灵宝佩戴
      end
        战斗类.战斗指令:设置灵宝(内容)


  end
end

function 回调:队伍处理(序号,内容)
  -- 4001 更改队伍图标
  -- 4002 创建队伍界面
  -- 4003 创建申请界面
  -- 4004 刷新队伍信息
  -- 4005 刷新队伍头像
  -- 4006 添加自身队伍图标
  -- 4007 添加玩家队伍图标
  -- 4008 删除自身队伍图标
  -- 4009 删除玩家队伍图标
  -- 4010 获取申请列表信息
  -- 4011 刷新申请列表
  -- 4012 清除队伍信息
  if 序号==4001 then
    tp.鼠标.置鼠标("组队")
  elseif 序号==4002 then
    tp.队伍数据=内容
    tp.窗口.队伍栏:打开()
    --tp.窗口.底图框:刷新队伍头像(内容)
  elseif 序号==4004 then
    tp.队伍数据=内容
    申请队伍=false
    if tp.窗口.队伍栏.可视 then
      tp.窗口.队伍栏:刷新人物()
    end
  elseif 序号==4006 then
    tp.场景.人物.队长开关=true
  elseif 序号==4007 then
    if 内容.逻辑==nil then
      内容.逻辑=false
    end
    tp.场景.玩家[内容.id].队长开关=内容.逻辑
  elseif 序号==4008 then
    tp.场景.人物.队长开关=false
  elseif 序号==4010 then
    tp.窗口.队伍申请表:打开(内容)
  elseif 序号==4011 then
    tp.窗口.队伍申请表:刷新(内容)
    申请队伍=true
  elseif 序号==4012 then
    tp.队伍数据={}
    if tp.窗口.队伍栏.可视 then
      tp.窗口.队伍栏:打开()
    end
    if tp.窗口.队伍申请表.可视 then
      tp.窗口.队伍申请表:打开()
    end
  elseif 序号==4013 then
    --tp.窗口.队伍申请表:刷新(内容)
    tp.窗口.队伍阵型栏:打开(内容)
  elseif 序号==4014 then
    if 内容.逻辑==nil then
      内容.逻辑=false
    end
    if not tp.场景.玩家[内容.id] then return end
    tp.场景.玩家[内容.id].战斗开关=内容.逻辑
  elseif 序号==4015 then
    tp.窗口.好友查看:打开(内容,nil,nil,true)
  elseif 序号==4018 then
     if tp.窗口.邀请组队.可视 then
        tp.窗口.邀请组队:刷新(内容)
     else
       tp.窗口.邀请组队:打开(内容)
     end
  end
end

function 回调:道具处理(序号,内容,原内容)
  if 序号==3501 then
    --tp.窗口.对话栏:文本(内容.模型,内容.名称,内容.对话,内容.选项)
    tp.金钱=内容.银子
    tp.储备=内容.储备
    tp.存银=内容.存银
    tp.总格=内容.总格
    内容.银子=nil
    内容.储备=nil
    内容.存银=nil
    tp.道具列表=内容.道具


      if 新道具行囊 then
          if  not tp.窗口.物品加锁.可视 and  tp.窗口.新道具行囊.可视==false then
                tp.窗口.新道具行囊:打开()
              else
                 if tp.窗口.新道具行囊.可视 then
                    tp.窗口.新道具行囊:刷新道具资源()
                    tp.窗口.新道具行囊.点击类型="道具"
                    if tp.窗口.新道具行囊.窗口 ~= "坐骑" and tp.窗口.新道具行囊.窗口 ~= "召唤兽" then
                      tp.窗口.新道具行囊.窗口="主人公"
                      tp.窗口.新道具行囊:置人物模型()
                    end
                  end
              end
           else
              if not tp.窗口.物品加锁.可视 and  tp.窗口.道具行囊.可视==false then
                tp.窗口.道具行囊:打开()
              else
                 if tp.窗口.道具行囊.可视 then
                    tp.窗口.道具行囊:刷新道具资源()
                    tp.窗口.道具行囊.点击类型="道具"
                    if tp.窗口.道具行囊.窗口 ~= "坐骑" and tp.窗口.道具行囊.窗口 ~= "召唤兽" then
                      tp.窗口.道具行囊.窗口="主人公"
                      local n = 引擎.取头像(tp.队伍[1].模型)
                      tp.窗口.道具行囊.资源组[4] = tp.资源:载入(n[7],"网易WDF动画",n[3])
                    end
                  end
              end
      end

    if tp.窗口.物品加锁.可视 then tp.窗口.物品加锁:刷新() end


  elseif 序号==3502 then
    --tp.窗口.对话栏:文本(内容.模型,内容.名称,内容.对话,内容.选项)
    tp.金钱=内容.银子
    tp.储备=内容.储备
    tp.存银=内容.存银
    内容.银子=nil
    内容.储备=nil
    内容.存银=nil
    tp.道具列表=内容.道具

    if 新道具行囊 then
      if not tp.窗口.物品加锁.可视 and tp.窗口.新道具行囊.可视==false then
          tp.窗口.新道具行囊:打开()
        else
          if tp.窗口.新道具行囊.可视 then
              tp.窗口.新道具行囊:刷新道具资源()
              if tp.窗口.新道具行囊.窗口 ~= "坐骑" and tp.窗口.新道具行囊.窗口 ~= "召唤兽"  then
                tp.窗口.新道具行囊.点击类型="行囊"
                tp.窗口.新道具行囊.窗口="主人公"
                tp.窗口.新道具行囊:置人物模型()
              end
           end
        end
        else
        if not tp.窗口.物品加锁.可视 and tp.窗口.道具行囊.可视==false then
          tp.窗口.道具行囊:打开()
        else
          if tp.窗口.道具行囊.可视 then
              tp.窗口.道具行囊:刷新道具资源()
              if tp.窗口.道具行囊.窗口 ~= "坐骑" and tp.窗口.道具行囊.窗口 ~= "召唤兽"  then
                tp.窗口.道具行囊.点击类型="行囊"
                tp.窗口.道具行囊.窗口="主人公"
                local n = 引擎.取头像(tp.队伍[1].模型)
                tp.窗口.道具行囊.资源组[4] = tp.资源:载入(n[7],"网易WDF动画",n[3])
              end
            end
         end
      end
       if tp.窗口.物品加锁.可视 then tp.窗口.物品加锁.道具小类="行囊"  tp.窗口.物品加锁:刷新() end
  elseif 序号==3503 then --更新装备
    tp.队伍[1].装备=内容
    if 新道具行囊 then
      tp.窗口.新道具行囊:刷新装备()
    else
      tp.窗口.道具行囊:刷新装备()
    end
     if tp.窗口.物品加锁.可视 then tp.窗口.物品加锁:刷新() end
  elseif 序号==3504 then --佩戴装备
    tp.场景.人物:置人物模型()
     if tp.窗口.物品加锁.可视 then tp.窗口.物品加锁:刷新() end
  elseif 序号==3505 then --佩戴装备
    tp.场景.人物:置人物模型()
     if tp.窗口.物品加锁.可视 then tp.窗口.物品加锁:刷新() end
  elseif 序号==3506 then --更新装备
    tp.队伍[1].灵饰=内容
     if 新道具行囊 then
        if  tp.窗口.新道具行囊.可视 then
          tp.窗口.新道具行囊:刷新灵饰()
          tp.窗口.新道具行囊.窗口="主人公"
          tp.窗口.新道具行囊.主人公分类="灵饰"
        end
    else
      if tp.窗口.灵饰.可视 then
         tp.窗口.灵饰:刷新()
      end
    end
     if tp.窗口.物品加锁.可视 then tp.窗口.物品加锁:刷新() end
  elseif 序号==3507 then
    --tp.窗口.对话栏:文本(内容.模型,内容.名称,内容.对话,内容.选项)
    tp.金钱=内容.道具.银子
    tp.储备=内容.道具.储备
    tp.存银=内容.道具.存银
    内容.银子=nil
    内容.储备=nil
    内容.存银=nil
    tp.道具列表=内容.道具.道具
    tp.窗口.给予:打开(nil,内容.名称,内容.等级,内容.类型)

     elseif 序号==3508 then
    tp.窗口.交易:设置我方数据(内容)
  elseif 序号==3509 then
  --  tp.窗口.交易.选择1:置打勾框(true)
  elseif 序号==3510 then
   tp.窗口.交易:设置对方数据(内容)


  elseif 序号==3511 then
    if tp.窗口.交易.可视 then
      tp.窗口.交易:打开()
    end
  elseif 序号==3512 then
    tp.队伍[1].宝宝列表=内容
    if tp.窗口.交易.可视 then
       tp.窗口.交易.bb={}
    end
     if tp.窗口.物品加锁.可视 then tp.窗口.物品加锁:刷新() end
  elseif 序号==3513 then
    tp.道具列表=内容.道具
    if tp.窗口.物品加锁.可视 then tp.窗口.物品加锁:刷新() end
 elseif 序号==3514 then
    tp.窗口.交易:打开(内容.名称,内容.等级)
 elseif 序号==3515 then
    tp.窗口.摊位出售:打开(内容.名称,内容.摊主名称,内容.id,内容.物品,内容.bb,内容.打造)
    摊位名称=内容.名称
 elseif 序号==3516 then --更改自己摊位名称
     摊位名称=内容
 elseif 序号==3517 then
    tp.窗口.摊位出售:刷新(内容.名称,内容.摊主名称,内容.id,内容.物品,内容.bb,内容.打造)
 elseif 序号==3518 then
   摊位名称=nil
   if tp.窗口.摊位出售.可视 then tp.窗口.摊位出售:打开() end
 elseif 序号==3519 then
   tp.场景.玩家[内容.id].摊位名称=内容.名称



 elseif 序号==3520 then
   tp.金钱=内容+0
 elseif 序号==3521 then
        if 新摆摊界面 then
           tp.窗口.新摊位购买:打开(内容.名称,内容.摊主名称,内容.id,内容.物品,内容.bb,内容.打造,内容.熟练度)
        else
           tp.窗口.摊位购买:打开(内容.名称,内容.摊主名称,内容.id,内容.物品,内容.bb,内容.打造,内容.熟练度)
        end
  elseif 序号==3522 then
         if 新摆摊界面 then
            tp.窗口.新摊位购买:刷新(内容.名称,内容.摊主名称,内容.id,内容.物品,内容.bb,内容.打造,内容.熟练度)
         else
            tp.窗口.摊位购买:刷新(内容.名称,内容.摊主名称,内容.id,内容.物品,内容.bb,内容.打造,内容.熟练度)
         end
  elseif 序号==3523 then
    tp.窗口.仓库类:打开(内容.道具.道具,内容.仓库总数,内容.召唤兽总数)
    if tp.窗口.共享仓库.可视 then
        tp.窗口.共享仓库:打开()
    end
   elseif 序号==3524 then
    if tp.窗口.仓库类.仓库类型=="道具" then
      tp.窗口.仓库类:刷新仓库(内容.道具.道具,内容.页数)
    elseif tp.窗口.仓库类.仓库类型=="召唤兽" then
      tp.队伍[1].宝宝列表 = 内容.宝宝列表
      tp.窗口.仓库类:刷新仓库(内容.召唤兽仓库数据,内容.页数)
    end
  elseif 序号==3525 then
    tp.窗口.仓库类:刷新道具()
    if tp.窗口.共享仓库.可视 then
        tp.窗口.共享仓库:打开()
    end
   elseif 序号==3526 then
    tp.队伍[1].宝宝列表=内容.召唤兽
    tp.窗口.仓库类:刷新召唤兽仓库总数(内容.召唤兽仓库总数,内容.召唤兽仓库数据)
    if tp.窗口.物品加锁.可视 then tp.窗口.物品加锁:刷新() end
  elseif 序号==3527 then
        tp.队伍[1].法宝 = 内容.法宝
        tp.队伍[1].灵宝 = 内容.灵宝
        tp.队伍[1].法宝佩戴 = 内容.佩戴
        tp.队伍[1].灵宝佩戴 = 内容.灵宝佩戴
        tp.队伍[1].神器佩戴 = 内容.神器佩戴
        tp.队伍[1].神器数据 = 内容.神器数据
        if tp.窗口.法宝.可视 then
           tp.窗口.法宝:刷新()
        else
           if not tp.窗口.物品加锁.可视 then
             tp.窗口.法宝:打开()
           end
        end
        if tp.窗口.物品加锁.可视 then tp.窗口.物品加锁:刷新() end

    -- if 新道具行囊 then
    --    tp.窗口.新道具行囊:刷新法宝资源()
    --     tp.窗口.新道具行囊.点击类型="法宝"
    --     tp.窗口.新道具行囊.窗口="法宝"
    -- else
    --     tp.窗口.道具行囊:刷新法宝资源()
    --     tp.窗口.道具行囊.点击类型="法宝"
    --     tp.窗口.道具行囊.窗口="法宝"
    -- end
 elseif 序号==3528 then
  if tp.窗口.法宝.可视 then
     tp.窗口.法宝:更新修炼(内容)
  end


   -- if 新道具行囊 then
   --    tp.窗口.新道具行囊:更新法宝经验(内容)
   --  else
   --     tp.窗口.道具行囊:更新法宝经验(内容)
   --  end
 elseif 序号==3529 then
   tp.窗口.合成旗:打开(内容)
 elseif 序号==3530 then --更新装备
     tp.队伍[1].锦衣=内容
     if 新道具行囊 then
        if  tp.窗口.新道具行囊.可视 then
          tp.窗口.新道具行囊:刷新锦衣()
          tp.窗口.新道具行囊.窗口="主人公"
          tp.窗口.新道具行囊.主人公分类="锦衣"
        end
    else
          if tp.窗口.锦衣.可视 then
          tp.窗口.锦衣:刷新()
        end
    end
     if tp.窗口.物品加锁.可视 then tp.窗口.物品加锁:刷新() end
  elseif 序号==3531 then --更新坐骑饰品
    if 新道具行囊 then
      tp.窗口.新道具行囊:刷新坐骑饰品()
    else
      tp.窗口.道具行囊:刷新坐骑饰品()
    end
  elseif 序号==3540 then
    tp.窗口.仓库类:刷新道具仓库总数(内容.道具.道具,内容.总数)
  elseif 序号==3529.1 then
--  tp.窗口.图鉴系统:打开(内容)
  elseif 序号==3529.2 then
  -- if tp.窗口.图鉴系统.可视 then
  -- tp.窗口.图鉴系统:刷新图鉴(内容)
  -- end
  elseif 序号==3548 then
    if tp.窗口.附魔宝珠.可视 then
        tp.窗口.附魔宝珠:刷新(内容.道具.道具)
    else
        tp.窗口.附魔宝珠:打开(内容.道具.道具)
        tp.窗口.附魔宝珠.宝珠数据 = 内容.宝珠数据
    end
  elseif 序号==3549 then
    if tp.窗口.附魔宝珠.可视 then
      tp.窗口.附魔宝珠:打开()
    end
  elseif 序号==3550 then
    if tp.窗口.符石镶嵌.可视 then
      tp.窗口.符石镶嵌:刷新符石(内容.装备,内容.星石操作)
    else
      tp.窗口.符石镶嵌:打开(内容.装备)
    end
  elseif 序号==3552 then
    tp.金钱=内容.道具.银子
    if tp.窗口.符石合成.可视 then
      tp.窗口.符石合成:刷新(内容.道具.道具)
    else
      tp.窗口.符石合成:打开(内容.道具.道具)
    end
  elseif 序号==3699 then --刷新道具数据
    if 新道具行囊 then
         if tp.窗口.新道具行囊.可视 then
            tp.场景.抓取物品 = nil
            tp.场景.抓取物品ID = nil
            tp.场景.抓取物品注释 = nil
            if tp.窗口.新道具行囊.点击类型=="道具" then
              请求服务(3699)
            elseif tp.窗口.新道具行囊.点击类型=="行囊" then
              请求服务(3700)
            elseif tp.窗口.新道具行囊.点击类型=="法宝" then
              请求服务(3732)
            end
          end
    else
         if tp.窗口.道具行囊.可视 then
            tp.场景.抓取物品 = nil
            tp.场景.抓取物品ID = nil
            tp.场景.抓取物品注释 = nil
            if tp.窗口.道具行囊.点击类型=="道具" then
              请求服务(3699)
            elseif tp.窗口.道具行囊.点击类型=="行囊" then
              请求服务(3700)
            elseif tp.窗口.道具行囊.点击类型=="法宝" then
              请求服务(3732)
            end
          end
    end

    if tp.窗口.打造.可视 then
      请求服务(3707)
    elseif tp.窗口.附魔.可视 then
      tp.窗口.附魔:打开()
    end
    if tp.窗口.符石合成.可视 then
        请求服务(3805)
    end
    if tp.窗口.附魔宝珠.可视 then
        请求服务(3767)
    end
  elseif 序号 == 3700 then
    --tp.窗口.商城类:打开(内容)
     tp.窗口.回收系统:刷新(内容)
  elseif 序号 == 3701 then
    --tp.窗口.活跃商城:打开(内容)


  elseif 序号 == 3703 then
          if 内容.类型 == 1 or 内容.类型 == 2 then
               tp.窗口.藏宝阁出售:打开(内容)
          else
               tp.窗口.藏宝阁出售:刷新(内容)
          end
  elseif 序号 == 3704 then
         tp.窗口.藏宝阁类:打开(内容.数据,内容.点卡)
  elseif 序号==3705 then
         tp.窗口.藏宝阁类:刷新(内容.数据,内容.类型,内容.点卡)
  elseif 序号==3706 then
     --tp.窗口.物品加锁:打开()
  elseif 序号==3707 then
    tp.窗口.物品密码:打开()
  elseif 序号==3708 then
    local wb={}
    wb[1] = "“全面解锁”可解除需频繁操作的锁定，如果每天从钱庄和家里取出来金钱积累不超过500万只需“部分解锁”。仅有涉及加锁道具转移等操作需要“全面解锁”。"
    local xx = {"部分解锁","全面解锁","取消"}
    tp.窗口.对话栏:文本(tp.队伍[1].模型,tp.队伍[1].名称,wb[引擎.取随机整数(1,#wb)],xx)



  elseif 序号==3711 then
        if 内容.类型 == 1 or 内容.类型 == 2 then
             tp.窗口.藏宝阁出售寄存:打开(内容)
        else
             tp.窗口.藏宝阁出售寄存:刷新(内容)
        end
  elseif 序号==3712 then
        if 内容.类型 == 1 or 内容.类型 == 2 then
             tp.窗口.藏宝阁购买寄存:打开(内容)
        else
             tp.窗口.藏宝阁购买寄存:刷新(内容)
        end
  elseif 序号==3713 then
        tp.窗口.藏宝阁上架货币:打开(内容.类型,内容.数量)
  elseif 序号==3714 then
        tp.窗口.藏宝阁类:物品数据刷新(内容.道具,内容.编号+0)

  elseif 序号==3800 then
     if 新道具行囊 then
        tp.窗口.新道具行囊:清除抓取道具()
    else
        tp.窗口.道具行囊:清除抓取道具()
    end
  elseif 序号==3900 then
     tp.窗口.铃铛界面:打开(内容)
  elseif 序号==3901 then
     tp.窗口.铃铛界面:刷新(内容)
  elseif 序号==3902 then
     local 动画编号=内容.编号
     local 人物组,事件组,初始镜头坐标 = 引擎.取剧情动画(动画编号)
     if #人物组==0 or #事件组==0 then
       tp.常规提示:打开("#Y/引擎动画缺失，播放失败")
     else
	     tp.第二场景:载入显示(人物组,事件组,初始镜头坐标)
     end
  elseif 序号==3910 then
--    tp.窗口.交易中心:打开(内容)
  elseif 序号==3911 then
  --  tp.窗口.交易中心:更新数据(内容)
  --剧情信息
  elseif 序号==3532 then
    local 人物组 = {{名称="唐太宗",模型="皇帝",X=40,Y=20,方向=0,编号=1},{名称="玄奘法师",模型="唐僧",X=47,Y=20,方向=0,编号=2},{主角=true,X=45,Y=22,方向=2,编号=3}}
    local 事件组 = {
      [1]={[[引擎.场景.第二场景:加入文本(50,tp.队伍[1].模型,"#G"..tp.队伍[1].名称.."#:恭喜你完成了副本")]]}}
    tp.第二场景:载入显示(人物组,事件组)
  elseif 序号==3532.1 then
    local 人物组,事件组 = tp.窗口.对话栏:获取任务事件("枯萎金莲",1)
    tp.第二场景:载入显示(人物组,事件组)
  elseif 序号==3532.2 then
    local 人物组,事件组 = tp.窗口.对话栏:获取任务事件("枯萎金莲",2)
    tp.第二场景:载入显示(人物组,事件组)
  elseif 序号==3532.3 then
    local 人物组,事件组 = tp.窗口.对话栏:获取任务事件("桃园浣熊",1)
    tp.第二场景:载入显示(人物组,事件组)
  elseif 序号==3532.4 then
    local 人物组,事件组 = tp.窗口.对话栏:获取任务事件("枯萎金莲",3)
    tp.第二场景:载入显示(人物组,事件组)
  elseif 序号==3532.5 then
    local 人物组,事件组 = tp.窗口.对话栏:获取任务事件("枯萎金莲",4)
    tp.第二场景:载入显示(人物组,事件组)
  elseif 序号==3532.6 then
    local 人物组,事件组 = tp.窗口.对话栏:获取任务事件("枯萎金莲",5)
    tp.第二场景:载入显示(人物组,事件组)
  elseif 序号==3532.7 then
    local 人物组,事件组 = tp.窗口.对话栏:获取任务事件("枯萎金莲",6)
    tp.第二场景:载入显示(人物组,事件组)
  elseif 序号==3532.8 then
    local 人物组,事件组 = tp.窗口.对话栏:获取任务事件("枯萎金莲",7)
    tp.第二场景:载入显示(人物组,事件组)
  elseif 序号==3532.9 then
    local 人物组,事件组 = tp.窗口.对话栏:获取任务事件("枯萎金莲",8)
    tp.第二场景:载入显示(人物组,事件组)
  elseif 序号==3533.1 then
    local 人物组,事件组 = tp.窗口.对话栏:获取任务事件("枯萎金莲",9)
    tp.第二场景:载入显示(人物组,事件组)
  elseif 序号==3533.2 then
    local 人物组,事件组 = tp.窗口.对话栏:获取任务事件("枯萎金莲",10)
    tp.第二场景:载入显示(人物组,事件组)

  end
end

-- 3699 刷新所有跟道具有关的界面
function 回调:对话处理(序号,内容)
  if 序号==1501 then
    tp.窗口.对话栏:文本(内容.模型,内容.名称,内容.对话,内容.选项)
  elseif 序号==1502 then
    tp.窗口.对话栏:文本(内容.模型,内容.名称,内容.对话,内容.选项,nil,nil,true)
  end
end

function 回调:地图处理(序号,内容)
  if 序号==1001 then
      if tp.场景.人物 then
          tp.场景.人物:设置路径(内容)
      end
  elseif  序号==1003 then
      if 内容.NPC then
          tp.场景:设置假人(内容.NPC)
      end
      if 内容.传送 then
          if tp.场景.人物 then
              tp.场景.人物:停止移动(1)
          end
          tp.场景:设置传送(内容.传送)
      end
  elseif  序号==1004 then
          if not 内容.地图 then return end
          if 内容.NPC and not NPC列表[内容.地图] then
              NPC列表[内容.地图] = 内容.NPC
          end
          if 内容.传送 and not 传送数据[内容.地图] then
              传送数据[内容.地图] = 内容.传送
          end
          if not tp.窗口.世界地图分类小地图.可视 then
              tp.窗口.世界地图分类小地图:打开(内容.地图,内容.超级)
          end



      -- if tp.场景.人物~=nil then
      --     tp.场景.人物:停止移动(1)
      -- end
      --tp.场景:设置传送(内容)
  elseif 序号==1005 then
          tp.场景:传送至(内容[1],内容[2],内容[3],true)
          if 坐标显示 then
            tp.窗口.消息框:添加文本("地图编号:"..内容[1])
          end
          tp.队伍[1].地图数据.编号 = 内容[1]
          if tp.窗口.仓库类.可视 then --可要可不要,传送关闭仓库
             tp.窗口.仓库类:打开()
          end
          if tp.窗口.共享仓库.可视 then
             tp.窗口.共享仓库:打开()
          end
          if tp.窗口.打造.可视 then -- 防止刷摆摊刷物品
            tp.窗口.打造:打开(tp.道具列表)
          end
  elseif  序号==1006 then  --地图添加玩家
    tp.场景:添加玩家(内容)
  elseif  序号==1007 then--删除玩家
    if tp.场景.玩家[内容.id]==nil then
      return
    end
    tp.场景:删除玩家(内容.id)
  elseif  序号==1008 then
    if 内容~=nil and 内容.路径~=nil  and 内容.路径.数字id~=nil and  tp.场景.玩家[内容.路径.数字id+0]~=nil then
       内容.路径.id=内容.路径.数字id+0
       tp.场景:更新行走(内容.路径,内容.路径.id)
    end
  elseif  序号==1009 then
     if tp.场景.玩家[内容.id]==nil then
        return
      end
      tp.场景.玩家[内容.id].武器=内容.武器
      if tp.场景.玩家[内容.id].武器=="1" then tp.场景.玩家[内容.id].武器=nil end
      tp.场景.玩家[内容.id]:置人物模型()
  elseif  序号==1009.1 then
     if tp.场景.玩家[内容.id]==nil then
        return
      end
      tp.场景.玩家[内容.id].副武器=内容.武器
      if tp.场景.玩家[内容.id].副武器=="1" then tp.场景.玩家[内容.id].副武器=nil end
      tp.场景.玩家[内容.id]:置人物模型()
   elseif  序号==1014 then
     if tp.场景.玩家[内容.id]==nil then
      return
    end
    tp.场景.玩家[内容.id].锦衣=内容.锦衣
    if tp.场景.玩家[内容.id].锦衣=="1" then tp.场景.玩家[内容.id].锦衣=nil end
    tp.场景.玩家[内容.id]:置人物模型()


  elseif  序号==1010 then
    tp.场景.玩家[内容.id]:设置动画(内容.类型)
  elseif  序号==1010.1 then
    if tp.场景.玩家[内容.id]==nil then
      return
    end
    tp.场景.玩家[内容.id]:改变飞行(内容.飞行)
  elseif  序号==1011 then
      if tp.场景.人物~=nil then
        tp.场景.人物:设置坐标(内容)
      end
  elseif  序号==1012 then
      if tp.场景.玩家[内容.id]==nil then
        return
      end
      tp.场景.玩家[内容.id]:设置坐标(内容)
  elseif  序号==1013 then
    if tp.场景.玩家[内容.id]==nil then
      return
    end
    tp.场景.玩家[内容.id].玩家["静立"]:置染色(内容.染色方案,内容.染色组[1],内容.染色组[2],内容.染色组[3],0)
    tp.场景.玩家[内容.id].玩家["行走"]:置染色(内容.染色方案,内容.染色组[1],内容.染色组[2],内容.染色组[3],0)
  elseif  序号==1015 then
          tp.场景:添加单位(内容)
  elseif  序号==1015.1 then
    tp.场景:更改单位(内容)
  elseif  序号==1016 then  --删除编号
      tp.场景:删除单位(内容.编号,内容.序列)
 elseif  序号==1017 then --添加喊话
    tp.喊话:写入(tp.场景.人物,tp.场景.人物.人物,内容.文本,nil,内容.特效)
  elseif  序号==1018 then
    内容.id=内容.id+0
    if tp.场景.玩家[内容.id]==nil then
      return
    end
    tp.场景.玩家[内容.id].喊话:写入(tp.场景.玩家[内容.id],tp.场景.玩家[内容.id].玩家,内容.文本,nil,内容.特效)


  elseif  序号==1019 then
        if tp.场景.玩家[内容.id]==nil then
          return
        end
        tp.场景.玩家[内容.id].坐骑=内容.坐骑
        if tp.场景.玩家[内容.id].坐骑=="1" then tp.场景.玩家[内容.id].坐骑=nil end
        tp.场景.玩家[内容.id]:置人物模型()


  elseif  序号==1020 then
    if tp.场景.玩家[内容.id]==nil then
        return
    end
    if 内容.当前称谓==nil then
      内容.当前称谓=""
    end
    tp.场景.玩家[内容.id]:更改称谓(内容)
  elseif  序号==1021 then
    if 内容==nil then
      return
    end
    for i=1,#内容 do
      tp.场景:添加单位(内容[i])
    end
    collectgarbage("collect")
  elseif  序号==1022 then  --地图添加玩家
    if 内容==nil then
      return
    end
    for i=1,#内容 do
      tp.场景:添加玩家(内容[i])-- tp.场景:添加玩家(内容)
    end
  elseif 序号==1023 then
    if tp.场景.玩家[内容.id]==nil then
      return
    end
    tp.场景.玩家[内容.id].pk开关 = 内容.开关
  elseif 序号==1024 then
    if tp.场景.玩家[内容.id]==nil then
      return
    end
    tp.场景.玩家[内容.id].变身=内容.变身
    tp.场景.玩家[内容.id].变异=内容.变异
    if tp.场景.玩家[内容.id].变身=="1" then tp.场景.玩家[内容.id].变身=nil end
    if tp.场景.玩家[内容.id].变异=="1" then tp.场景.玩家[内容.id].变异=nil end
    tp.场景.玩家[内容.id]:置人物模型()

  elseif 序号==1025 then
    tp.场景.玩家[内容.id].强p开关 = 内容.开关

  elseif 序号==1026 then
        tp.房屋数据 = 内容[1]
        tp.场景.地图:新载地图特效()
  elseif  序号==1027 then
          tp.场景.地图:房屋特效(内容[1],true)
  elseif  序号==1028 then
          tp.如意符 = true
  elseif 序号==1029 then
          if 内容[2] == "庭院" then
            tp.房屋数据.庭院装饰 = 内容[1]
          elseif 内容[2] == "室内" then
            tp.房屋数据.室内装饰 = 内容[1]
          elseif 内容[2] == "阁楼" then
             tp.房屋数据.阁楼装饰 = 内容[1]
          elseif 内容[2] == "牧场" then
             tp.房屋数据.牧场装饰 = 内容[1]
          end
          tp.场景.地图:新载地图特效()
  elseif 序号==1030 then
          if 内容[2] == "庭院" then
            tp.房屋数据.庭院装饰 = 内容[1]
          elseif 内容[2] == "室内" then
            tp.房屋数据.室内装饰 = 内容[1]
           elseif 内容[2] == "阁楼" then
             tp.房屋数据.阁楼装饰 = 内容[1]
          elseif 内容[2] == "牧场" then
             tp.房屋数据.牧场装饰 = 内容[1]
          end
  elseif 序号==1031 then
      tp.窗口.房屋拜访:打开()

  elseif  序号==1032 then
        if tp.场景.玩家[内容.id]==nil then
          return
        end
        tp.场景.玩家[内容.id].离线摆摊=true
        tp.场景.玩家[内容.id]:置人物模型()
  elseif  序号==1033 then
        if tp.场景.玩家[内容.id]==nil then
          return
        end
        tp.场景.玩家[内容.id].离线摆摊=nil
        tp.场景.玩家[内容.id]:置人物模型()

  end
end








function 回调:系统处理(序号,内容,数据)
  if 序号==1 and 内容.用户==nil then
      self:请求服务(1,版本..fgc..系统参数.账号..fgc..系统参数.密码..fgc..版本)
  elseif 序号==2 then --选择角色
    tp.进程 = 2
  elseif 序号==3 then--创建角色
    tp.进程 = 3
  elseif 序号==4 then --选择角色 加载数据
    tp.读取:添加角色信息(内容)
  elseif 序号==5 then
    停止连接 = true
    全局游戏宽度 = 读配置("./config.ini","mhxy","宽度")+0
    全局游戏高度 = 读配置("./config.ini","mhxy","高度")+0
    全局游戏音量 = math.ceil(读配置("./config.ini","mhxy","音量"))
    引擎.置宽高(全局游戏宽度,全局游戏高度)
    tp.场景 = require("script/全局/主显").创建(tp)
    tp.第二场景 = require("script/场景类/第二场景").创建(tp)
    tp.提示误差=0
    tp.队伍[1]=tp._队伍.创建(tp)
    tp.队伍[1]:重置属性(内容)
    tp.宠物=内容.宠物
    tp.月卡加速=1
    tp.名字变色 = false
    if 内容.月卡.开通 then
       tp.月卡加速 = 1.1
       tp.名字变色 = true
    end

    withs = 全局游戏宽度
    hegts = 全局游戏高度
    with = 全局游戏宽度/2
    hegt = 全局游戏高度/2
    tp.常规提示.x=全局游戏宽度/2-465
    tp.常规提示.y=全局游戏高度/2-340
    tp.音乐:停止()
    tp.场景:转移(内容.地图数据.编号,内容.地图数据.x,内容.地图数据.y)
    tp.游戏进程=1
    全局登陆内容()
    if 重新连接进入 then
       重新连接进入 = nil
       tp.常规提示:打开("#G/重连成功祝您游戏愉快！")
    end
    local 地图等级={}
    地图等级[1],地图等级[2]=引擎.取场景等级(tp.当前地图)
    if 地图等级[1]~=nil then
      tp.场景.场景最低等级=地图等级[1]
      tp.场景.场景最高等级=地图等级[2]
      tp.窗口.消息框:添加文本("#Y/本场景等级为"..地图等级[1].."-"..地图等级[2].."级","xt")
    else
      tp.场景.场景最低等级=nil
      tp.场景.场景最高等级=nil
    end
    -- if 内容.多角色操作 then
    --   多角色操作 = true
    -- end
    tp.缓冲 = nil
    tp.标题 = nil
    tp.注册 = nil
    tp.分区 = nil
    tp.登陆 = nil
    tp.充值 = nil
    tp.创建 = nil
    tp.读取 = nil
    tp.退出 = nil
    local 音乐开启 = 读配置("./config.ini","mhxy","音乐播放")
    if 音乐开启 == "false" then
      tp.音乐开启 =false
      tp.音乐:停止()
    else
      tp.音乐开启 =true
    end
    local 音效开启 = 读配置("./config.ini","mhxy","音效开启")
    if 音效开启 == "false" then
      tp.音效开启 = false
    else
      tp.音效开启 = true
    end
    多角色操作 = 内容.多角色操作


    ---特赦令牌 --5宝
        -- 引擎.置标题(全局游戏标题.."-[ "..tp.队伍[1].数字id.." ]")


    collectgarbage("collect")

  elseif 序号==5.1 then
     写出文件([[data\标题配置.txt]],内容.文本)


  elseif 序号==6 then
   tp.窗口.宠物领养栏:打开()
  elseif 序号==7 then
    if 内容 == "#Y创建账号成功！" then
       tp.进程 = 7
    end
     tp.常规提示:打开(内容)
   elseif 序号==8 then --检查宠物领养
    tp.宠物=内容
    if tp.窗口.宠物状态栏.可视 then
     tp.窗口.宠物状态栏:打开()
     tp.窗口.宠物状态栏:打开()
    end
  elseif 序号==9 then --商店
    tp.金钱=内容.银子
    tp.窗口.商店:打开(内容.商品,内容.名称)
  elseif 序号==9.1 then --钓鱼积分商店
    tp.钓鱼积分=内容.钓鱼积分
    tp.窗口.钓鱼积分商店:打开(内容.商品,内容.名称)
  elseif 序号==10 then  --更新人物界面
    self.临时装备=table.loadstring(table.tostring(tp.队伍[1].装备))
    tp.队伍[1]:重置属性(内容,1)
    --tp.队伍[1].装备=table.loadstring(table.tostring(self.临时装备))
    -- if tp.窗口.人物状态栏.可视==false then
    --  tp.窗口.人物状态栏:打开()
    -- end
  elseif 序号==11 then
   tp.场景.人物:加入动画("升级")
  elseif 序号==12 then
    if tp.窗口.人物状态栏.可视 then
      请求服务(7)
    end
  elseif 序号==13 then
    tp.窗口.飞行符:打开()
  elseif 序号==14 then
    tp.金钱=内容.银子
     tp.道具列表=内容.道具
    if tp.窗口.打造.可视==false then
      tp.窗口.打造:打开(内容.道具)
    else
      tp.窗口.打造:刷新道具(内容.道具)
    end
 elseif 序号==14.1 then
     tp.金钱=内容.银子
     tp.道具列表=内容.道具
    if tp.窗口.打造.可视==false then
      tp.窗口.打造:打开(内容.道具,内容.当前打开方式)
    else
      tp.窗口.打造:刷新道具(内容.道具)
    end


  elseif 序号==15 then
    if tp.队伍[1].体力==nil then
      return
    end
    tp.队伍[1].体力=内容.体力
    tp.队伍[1].活力=内容.活力

    if tp.窗口.制作仙露.可视 then
        tp.窗口.制作仙露:刷新道具()
    end


  elseif 序号==16 then
    -- print(内容,tp.队伍[1])
     tp.队伍[1].宝宝列表=内容
     tp.队伍[1]:刷新宝宝技能()
     tp.队伍[1]:刷新宝宝认证技能()


  elseif 序号==16.1 then
    tp.队伍[1]:刷新宝宝技能(内容[1],内容[2].技能)
    if tp.窗口.召唤兽资质栏.可视 then
      tp.窗口.召唤兽资质栏:刷新数据(内容[2])
    end
  elseif 序号==17 then
    tp.队伍[1].宝宝列表=内容
    tp.队伍[1]:刷新宝宝技能()
    tp.队伍[1]:刷新宝宝认证技能()
    tp.窗口.召唤兽属性栏:打开()
  elseif 序号==17.1 then
   tp.队伍[1].宝宝列表=内容
  elseif 序号==17.2 then
   tp.队伍[1].子女列表=内容
  elseif 序号==18 then
    --print(#内容)
    for n=1,#tp.队伍[1].宝宝列表 do
      tp.队伍[1].宝宝列表[n].参战信息=nil
      if 内容.认证码 == tp.队伍[1].宝宝列表[n].认证码 then
        tp.队伍[1].宝宝列表[n].参战信息=1
      end
    end
    tp.队伍[1].参战宝宝=内容
  elseif 序号==19 then
    tp.队伍[1].宝宝列表[内容.序列].名称=内容.名称
    --tp.窗口.召唤兽属性栏.bb.名称=内容.名称
  elseif 序号==20 then
    --print(#内容)
    for n=1,#tp.队伍[1].宝宝列表 do
      if 内容.认证码== tp.队伍[1].宝宝列表[n].认证码 then
        tp.队伍[1].宝宝列表[n]=内容
      end
    end
  elseif 序号==21 then
    tp.窗口.召唤兽属性栏:放生()
  elseif 序号==22 then
    tp.宠物=内容
    tp.窗口.宠物状态栏:打开()
  elseif 序号==22.1 then
    tp.成就=内容
    tp.窗口.成就系统栏:打开()
  elseif 序号==23 then
     --tp.窗口.宠物炼妖栏:打开(内容.道具)
     tp.窗口.宠物洗练栏:打开(内容.道具)
  elseif 序号==24 then
    tp.窗口.宠物洗练栏:刷新道具(内容.道具)
  elseif 序号==25 then
    tp.窗口.宠物洗练栏:清除()
  elseif 序号==26 then
    tp.窗口.宠物合宠栏:清除()
  elseif 序号==27 then  --聊天框文本
    tp.窗口.消息框:添加文本(内容.文本,内容.频道,内容.超链)
  elseif 序号==28 then
    if 新道具行囊 then
        tp.窗口.新道具行囊:置形象()
    else
        tp.窗口.道具行囊:置形象()
    end
  elseif 序号==29 then
    tp.窗口.染色:打开()
  elseif 序号==30 then
    --tp.窗口.染色:打开()
    tp.队伍[1].染色组 = 内容
    tp.场景.人物:置染色(tp.队伍[1].染色方案,内容[1],内容[2],内容[3])
  elseif 序号==31 then  --更新人物界面
    self.临时装备=table.loadstring(table.tostring(tp.队伍[1].装备))
    -- print(table.tostring(内容))
    tp.队伍[1]:重置属性(内容)
    tp.金钱=内容.银子
    tp.储备=内容.储备
    tp.存银=内容.存银
  elseif 序号==32 then
    tp.窗口.技能学习:打开()
  elseif 序号==33 then
    self.临时装备=table.loadstring(table.tostring(tp.队伍[1].装备))
    tp.队伍[1]:重置属性(内容)
  elseif 序号==34 then --更新辅助技能
    tp.队伍[1].辅助技能[内容.序列].等级=内容.等级
    if tp.窗口.人物状态栏.可视 and tp.窗口.人物状态栏.辅助技能[内容.序列]~=nil and tp.窗口.人物状态栏.辅助技能[内容.序列].技能~=nil then
      tp.窗口.人物状态栏.辅助技能[内容.序列].技能.等级=内容.等级
      local 临时消耗=生活技能消耗(内容.等级+1,1)
      if  tp.窗口.人物状态栏.辅助技能[内容.序列].技能.名称 == "强壮" then
         临时消耗=生活技能消耗(内容.等级+1,2)
      end
      tp.窗口.人物状态栏.辅助技能[内容.序列].技能.介绍= tp.窗口.人物状态栏.辅助技能[内容.序列].技能.原介绍..'\n'.."#Y/学习消耗："..'\n#G'..临时消耗.经验.."#Y点人物经验"..'\n#G'..临时消耗.金钱.."#Y两银子"
    end
  elseif 序号==34.1 then
    tp.队伍[1].强化技能[内容.序列].等级=内容.等级
    if tp.窗口.人物状态栏.可视 and tp.窗口.人物状态栏.强化技能[内容.序列]~=nil and tp.窗口.人物状态栏.强化技能[内容.序列].技能~=nil then
        tp.窗口.人物状态栏.强化技能[内容.序列].技能.等级=内容.等级
        local 临时消耗=生活技能消耗(内容.等级+1,2)
        tp.窗口.人物状态栏.强化技能[内容.序列].技能.介绍= tp.窗口.人物状态栏.强化技能[内容.序列].技能.原介绍..'\n'.."#Y/学习消耗："..'\n#G'..临时消耗.经验.."#Y点人物经验"..'\n#G'..临时消耗.金钱.."#Y两银子"
    end
  elseif 序号==35 then
    tp.金钱=内容.银子
    tp.储备=内容.储备
    tp.存银=内容.存银
    tp.队伍[1].当前经验=内容.经验
  elseif 序号==36 then
    tp.场景.人物:加入动画(内容.动画)
  elseif 序号==37 then
    if 内容=="1" then 内容.变身数据=nil end
    tp.队伍[1].变身数据=内容.变身数据
    tp.队伍[1].变异=内容.变异
    tp.场景.人物:置模型()
  elseif 序号==38 then
    if 内容.频道 == "cw" and 屏蔽系统消息 then

    elseif 内容.频道 == "hd" and 屏蔽活动消息 then

    else
      tp.窗口.消息框:添加文本(内容.内容,内容.频道,内容.超链)
    end
  elseif 序号==39 then
    if tp.窗口.任务栏.可视 then
      请求服务(10)
    end
  elseif 序号==40 then
    if tp.窗口.任务栏.可视 then
      tp.窗口.任务栏:打开()
    end
    tp.窗口.任务栏:打开(内容)
  elseif 序号==41 then
    tp.窗口.快捷技能栏:刷新(内容)
  elseif 序号==42 then
    tp.窗口.快捷技能栏:刷新(内容,1)
  elseif 序号==43 then
   tp.窗口.时辰.序列=内容.时辰
  elseif 序号==44 then
   tp.队伍[1].修炼=内容.人物
   tp.队伍[1].bb修炼=内容.bb
  elseif 序号==45 then
    tp.窗口.召唤兽属性栏:放生(1)
 elseif 序号==46 then
   tp.窗口.任务追踪栏:刷新(内容[1],内容[2],内容[3],内容[4])
 elseif 序号==47 then
   tp.窗口.任务追踪栏.介绍文本:清空()
   tp.窗口.任务追踪栏.数据记录={}
 elseif 序号==48 then
--   tp.队伍[1].自动遇怪=内容.遇怪
 elseif 序号==49 then
   tp.窗口.排行榜:打开(内容)


 elseif 序号==50 then
   tp.窗口.好友列表:打开(内容)---好友

  elseif 序号==51 then
      if tp.窗口.好友列表.可视 then
         tp.窗口.好友列表:更新数据(内容)
      end
  elseif 序号==52 then
    if tp.窗口.好友列表.可视 then
       请求服务(19)
    end
  elseif 序号==53 then
    if tp.窗口.好友查找.可视 then
       tp.窗口.好友查找:刷新(内容.数据)
    end




  elseif 序号==54 then

     if tp.窗口.好友消息.可视 then
        tp.窗口.好友消息:加载数据(内容.数据)
     else
        tp.窗口.好友消息:打开(内容.数据)
      end
  elseif 序号==55 then
    if 内容.道具~=nil then
        tp.道具列表=内容.道具.道具
    end
    if 内容.召唤兽~=nil then
        tp.队伍[1].宝宝列表=内容.召唤兽
    end
     if tp.窗口.超级赐福.可视 then
        tp.窗口.超级赐福:刷新()
     else
        tp.窗口.超级赐福:打开()
     end


  elseif 序号==56 then
   消息闪烁=true
  elseif 序号==57 then
   消息闪烁=false
  elseif 序号==58 then
      if 内容.道具 then
        tp.道具列表=内容.道具.道具
      end
      if tp.窗口.超级赐福.可视 and 内容.技能  then
         tp.窗口.超级赐福:刷新赐福(内容.技能)
      end

    -- tp.窗口.好友消息:打开(内容.名称,内容.id,内容.好友度,内容.等级,内容.模型,1,消息)
    -- tp.窗口.好友消息.丰富文本:添加文本("#R"..内容.信息)
    -- tp.窗口.好友消息.丰富文本:添加文本("#H"..内容.内容)
    -- local 临时内容=读入文件([[data\]]..tp.队伍[1].数字id..[[\]]..内容.id..[[\记录.txt]])
    -- 临时内容=临时内容.."\n".."#R"..内容.信息.."\n".."#H"..内容.内容
    -- local file =io.open([[data\]]..tp.队伍[1].数字id..[[\]]..内容.id..[[\记录.txt]],"w")
    -- file:write(临时内容)
    -- file:close()


  elseif 序号==59 then
    tp.窗口.消息框:添加文本(内容.内容,内容.频道)
    游戏公告:添加公告(内容)
   elseif 序号==59.1 then
    游戏传音:添加公告(内容)
  elseif 序号==59.2 then
    tp.窗口.传音打开:打开(内容)

  elseif 序号==60 then
    tp.队伍[1].坐骑=内容
    if tp.队伍[1].坐骑=="1" then tp.队伍[1].坐骑=nil end
    tp.场景.人物:置人物模型()

  elseif 序号==61 then
    tp.坐骑列表=内容
     if tp.窗口.坐骑属性栏.可视 then
        tp.窗口.坐骑属性栏:打开()
     end
  elseif 序号==61.2 then
    tp.坐骑列表=内容
    tp.窗口.坐骑属性栏:打开()
  elseif 序号==61.1 then
    if 内容.编号 and 内容.数据 then
      tp.坐骑列表[内容.编号]=内容.数据
      if tp.窗口.坐骑属性栏.可视 then
        tp.窗口.坐骑属性栏:刷新统御()
      end
      if tp.窗口.坐骑技能栏.可视 then
        tp.窗口.坐骑技能栏:刷新技能(tp.坐骑列表[内容.编号],内容.编号)
      end
    end
  elseif 序号 == 62 then
    tp.窗口.装备开运:打开(内容)
  elseif 序号 == 63 then
    tp.窗口.装备开运:刷新(内容)
  elseif 序号 == 64 then
    tp.窗口.鉴定:打开(内容)


  elseif 序号 == 65 then
    tp.窗口.附魔:打开(内容)
  elseif 序号 == 66 then --对话输入框系统
    tp.窗口.组合输入框:打开("创建帮派",{"为你的帮派取一个好听的名字吧,创建帮派需5亿银子",ARGB(255,255,255,0)})
  elseif 序号 == 67 then --对话输入框系统
    if tp.窗口.帮派查看.可视 then
      tp.窗口.帮派查看:刷新(内容)
    else
      tp.窗口.帮派查看:打开(内容)
    end

  elseif 序号 == 68 then --加入帮派
    tp.窗口.帮派申请:打开(内容)
  elseif 序号 == 69 then --1 帮派数据 2 称谓数据 3 退出帮派
    if 内容.项目 == "1" then
        tp.队伍[1].帮派数据 = 内容
    elseif 内容.项目 == "2" then
      tp.称谓 = 内容.称谓
      if tp.窗口.人物称谓栏.可视 then
         tp.窗口.人物称谓栏:刷新()
      end
    elseif 内容.项目 == "3" then
        tp.队伍[1].帮派数据 = nil
    end
  elseif 序号 == 70 then
    tp.窗口.跑商商店:打开(内容.商品,内容.银子,内容.道具)
   elseif 序号 == 71 then
    tp.场景.地图:飞行坐骑(true)
    tp.场景.人物:改变飞行(true)
    tp.常规提示:打开("#Y/你飞起来了........")
  elseif 序号 == 72 then
    tp.场景.地图:飞行坐骑(false)
    tp.场景.人物:改变飞行(false)
    tp.常规提示:打开("#Y/你降落了........")
  elseif 序号 == 73 then
    tp.进程 = 7
  elseif 序号 == 74 then
    tp.窗口.帮派点修:打开(内容.银子,内容.存银)
  elseif 序号 == 75 then
    tp.窗口.帮派技能学习:打开(内容.银子,内容.储备,内容.帮派数据)
  elseif 序号 == 76 then
    tp.窗口.武器染色:打开(内容)
  elseif 序号 == 77 then
    if  tp.窗口.奇经八脉.可视 then
       tp.窗口.奇经八脉:刷新(内容)
    else
       tp.窗口.奇经八脉:打开(内容)
    end
  elseif 序号==78 then
    红尘进度=内容.进度
  elseif 序号==79 then
    tp.窗口.符石合成:打开(内容)
  elseif 序号==79.1 then
    tp.窗口.钟灵石合成:打开(内容)
  elseif 序号==80 then
--    tp.窗口.坐骑染色:打开(内容)
  elseif 序号==81 then
    --tp.窗口.坐骑饰品染色:打开(内容)
  elseif 序号==82 then
    tp.窗口.人物称谓栏:打开()
  elseif 序号==83 then
    tp.窗口.法宝合成:打开(内容)
  elseif 序号==84.1 then
    tp.窗口.碎星锤:打开(内容)
  elseif 序号==84.2 then
    tp.窗口.灵箓:打开(内容)
  elseif 序号==85 then
    if tp.窗口.神秘宝箱.可视 then
      tp.窗口.神秘宝箱:打开()
    end
    tp.窗口.神秘宝箱:打开(内容)
  elseif 序号 == 86 then
        收到流程 = tonumber(内容.收到)
        发送流程 = tonumber(内容.发送)
  elseif 序号 == 87 then
    tp.窗口.生死劫:打开()
  elseif 序号 == 88 then
    if tp.窗口.会员福利.可视 then
        tp.窗口.会员福利:刷新(内容)
      else
        tp.窗口.会员福利:打开(内容)
      end

  elseif 序号 == 89 then
    tp.窗口.组合输入框:打开("帮派竞赛报名",{"请输入报名帮费(最低费用50W)",ARGB(255,255,255,0)})
  elseif 序号 == 90 then
     if tp.窗口.梦幻指引.可视 then
        tp.窗口.梦幻指引:刷新(内容)
     else
        tp.窗口.梦幻指引:打开(内容)
     end
  elseif 序号==90.1 then
      tp.窗口.攻略查看:打开(内容)
  elseif 序号==90.2 then


  elseif 序号==91 then
   if  tp.窗口.仙玉商城类.可视 then  tp.窗口.仙玉商城类:打开() end
    tp.窗口.仙玉商城类:打开(内容)
  elseif 序号==92 then
    tp.窗口.仙玉商城类:刷新(内容)
  elseif 序号==92.1 then
  tp.窗口.召唤兽查看栏:打开(内容)
  elseif 序号==92.2 then
  tp.窗口.仙玉商城类:刷新货币(内容)
  elseif 序号==93 then
    tp.pk开关 = 内容.开关
  elseif 序号==94 then
    tp.强p开关 = 内容.开关
  elseif 序号==95 then
  tp.窗口.宠物打书内丹栏:清除()
  elseif 序号==96 then
  tp.窗口.宠物打书内丹栏:刷新道具(内容.道具)
  elseif 序号==99 then---=================屏蔽fwd向客户端发送时间
    local 临时数据=table.loadstring(数据)
    if 临时数据.内容~=nil and 临时数据.内容.内容~=nil and 临时数据.内容.频道~=nil then
      tp.窗口.消息框:添加文本(临时数据.内容.内容,临时数据.内容.频道)
    end
  elseif 序号==100 then
     tp.跨地图寻径开关=false
     tp.跨地图寻径={}
     tp.跨地图寻径=Greedy类:getShortPath(tp.当前地图+0,内容.地图+0)
      if tp.跨地图寻径 ~= nil and #tp.跨地图寻径>0 then
          table.insert(tp.跨地图寻径,{当前地图=内容.地图+0,x=内容.x+0,y=内容.y+0})
          tp.跨地图寻径开关=true
          local 内容1={x=tp.跨地图寻径[1].x+0,y=tp.跨地图寻径[1].y+0,距离=0}
          tp.常规提示:打开("#Y/自动寻路中…………")
          请求服务(1001,生成XY(tp.跨地图寻径[1].x+0,tp.跨地图寻径[1].y+0),1)
          tp.场景.人物:设置路径(内容1,true)
          table.remove(tp.跨地图寻径,1)
        else
           tp.跨地图寻径={}
           tp.常规提示:打开("#Y/目标位置无法通过传送点自动到达")
       end
   elseif 序号==100.1 then
       tp.场景.人物:设置路径(内容,true)
  elseif 序号==101 then
      if tp.窗口.自动抓鬼.可视 then
            tp.窗口.自动抓鬼:刷新(内容)
        else
            tp.窗口.自动抓鬼:打开(内容)
        end

  elseif 序号==102 then

        tp.窗口.自选系统:打开(内容)
  elseif 序号==102.1 then
        tp.窗口.自选灵饰系统:打开(内容)
  elseif 序号==103 then --获取助战物品数据
    if tp.窗口.每日活动.可视 then
      tp.窗口.每日活动:刷新(内容)
    else
      tp.窗口.每日活动:打开(内容)
    end

  elseif 序号==104 then
    if tp.窗口.每日查看.可视 then
      tp.窗口.每日查看:刷新(内容)
    else
      tp.窗口.每日查看:打开(内容)
    end

  elseif 序号==105 then
    tp.窗口.多开系统:打开(内容)

  elseif 序号==106 then
    if tp.窗口.签到界面.可视 then
       tp.窗口.签到界面:刷新(内容)
    else
       tp.窗口.签到界面:打开(内容)
    end


  elseif 序号==107 then
    tp.窗口.多开系统:刷新(内容)

  elseif 序号==108 then
    tp.窗口.炼丹炉:打开(内容)
  elseif 序号==108.1 then
    tp.窗口.炼丹炉:更新数据(内容)
  elseif 序号==108.2 then
    tp.窗口.炼丹炉:开奖(内容)
  elseif 序号==109 then
    tp.窗口.炼丹炉:刷新(内容)
  elseif 序号==110 then
          tp.队伍[1].携带宠物 = tonumber(内容.数量)
          if tp.窗口.召唤兽属性栏.可视 then
             tp.窗口.召唤兽属性栏.携带数量 = tonumber(内容.数量)
          end
  elseif 序号==111 then
   -- tp.房屋数据 = 内容
    tp:关闭窗口()
    tp.场景.抓取物品 = nil
    tp.场景.抓取物品ID = nil
    tp.场景.抓取物品注释 = nil
  elseif 序号==112 then --打开藏宝阁
    if tp.窗口.多开创建.可视 then
       tp.窗口.多开创建:打开()
     end

  elseif 序号 == 113 then
      多角色操作 = true
      if 内容~=nil and 内容.选择角色~= nil then
         系统参数.选中玩家id = tonumber(内容.选择角色)
      end
  elseif 序号 == 114 then
    多角色操作 = false
    多角色操作数据={}
  elseif 序号 == 115 then
    内容.角色 = tonumber(内容.角色)
    tp.多角色[内容.角色]=tp._多开队伍.创建(tp)
    tp.多角色[内容.角色]:重置属性(内容.玩家数据)
  elseif 序号 == 116 then
    内容.角色 = tonumber(内容.角色)
    tp.多角色[内容.角色].宝宝列表=内容.召唤兽
    tp.多角色[内容.角色]:刷新宝宝技能()
    tp.多角色[内容.角色]:刷新宝宝认证技能()
  elseif 序号 == 117 then
    tp.窗口.角色查看:打开(内容)
  elseif 序号 == 118 then
      if 内容~=nil and 内容.角色~=nil then
         内容.角色 = tonumber(内容.角色)
         if tp.多角色[内容.角色]~=nil then
            tp.多角色[内容.角色] =nil
         end
      end
  elseif 序号 == 119 then
    if tp.窗口.世界大地图.可视 then
       tp.窗口.世界大地图:打开()
    else
       tp.窗口.世界大地图:打开(true)
    end
    if tp.窗口.超级传送.可视 then
       tp.窗口.超级传送:打开()
    end

  elseif 序号 == 120 then
      tp.窗口.超级传送:打开()
      if tp.窗口.世界大地图.可视 then
         tp.窗口.世界大地图:打开()
      end


  elseif 序号==124 then
--    tp.窗口.孩子技能学习:打开(内容)
      tp.窗口.角色转换:打开(内容.模式)
  elseif 序号==125 then
   -- tp.窗口.孩子技能学习:刷新数据(内容)
  --剑会天下
  elseif 序号==126 then --打开界面
    tp.窗口.剑会天下:打开()
    tp.窗口.剑会天下:加载数据(内容)
  elseif 序号==127 then --打开匹配界面
    tp.窗口.剑会天下.右键关闭 = 1
    tp.窗口.剑会天下.匹配 = true
    tp.窗口.剑会匹配:打开(内容)
  elseif 序号==128 then --关闭匹配界面
    tp.窗口.剑会天下.右键关闭 = nil
    tp.窗口.剑会天下.匹配 = false
    if tp.窗口.剑会匹配.可视 then
      tp.窗口.剑会匹配:打开()
    end
  elseif 序号==129 then --刷新面板积分数据
    -- table.print(内容)
    if tp.窗口.剑会天下.可视 then
      tp.窗口.剑会天下:加载数据(内容)
    end
  elseif 序号==130 then
    tp.窗口.商店召唤兽:打开(内容)
 elseif 序号==130.1 then
    tp.窗口.商店变异召唤兽:打开(内容)
  elseif 序号==131 then
    tp.窗口.商店召唤兽:更新数据(内容)
  elseif 序号==131.1 then
    tp.窗口.商店变异召唤兽:更新数据(内容)
  elseif 序号==132 then
    tp.窗口.组合输入框:打开(内容.操作,{内容.说明,白色,内容.回调[1],内容.回调[2],内容.回调[3],内容.回调[4],内容.回调[5]})
  elseif 序号 == 133 then
    if tp.窗口.抽奖系统.可视 then
      tp.窗口.抽奖系统:刷新(内容)
    else
      tp.窗口.抽奖系统:打开(内容)
    end
  elseif 序号==134 then
     tp.窗口.BOOS挑战:打开(内容)

  elseif 序号==135 then
    if 内容.隐藏 then
       tp.窗口.战斗排行框.隐藏=false
    end
    if tp.窗口.战斗排行框.隐藏 == false then
       tp.窗口.战斗排行框:刷新数据(内容.数据)
    end


elseif 序号==136 then
    tp.金钱=内容.银子
    if tp.窗口.幻化界面.可视==false then
      tp.窗口.幻化界面:打开(内容.道具)
    else
      tp.窗口.幻化界面:刷新道具(内容.道具)
    end
  elseif 序号==137 then
    tp.窗口.组合输入框:打开("帮费设置",{"帮主你好，请输入贵帮需要设置的帮费！",ARGB(255,255,255,0)})
  elseif 序号==142 then
    tp.窗口.组合输入框:打开("改名",{"为你的角色取一个好听的名字吧，费用5000仙玉。",ARGB(255,255,255,0)})
  elseif 序号==142.1 then
    tp.窗口.组合输入框:打开("输入安全码",{"请输入你的安全码，如果没有设置安全码请先设置安全码。",ARGB(255,255,255,0)})

  elseif 序号==143 then    ---注意这个编号  211   212是打开文件  211是服务端转发到客户端
      if not tp.窗口.钓鱼.可视 then
          tp.窗口.钓鱼:打开()
        end
  elseif 序号==143.1 then
      if tp.窗口.钓鱼.可视 then
          tp.窗口.钓鱼:打开()
        end


  elseif 序号==144  then ---------内置GM工具玩家信息
    if tp.窗口.功德录备份.可视 then
      tp.窗口.功德录备份:刷新(内容)
    else
    tp.窗口.功德录备份:打开(内容)
    end


  elseif 序号==145 then ---------内置GM工具打开gm工具界面
    if tp.窗口.靓号设定.可视 then
       tp.窗口.靓号设定:刷新(内容.编号)
    else
        tp.窗口.靓号设定:打开(内容.编号)
    end

  elseif 序号==146 then
    tp.窗口.好友观察:打开(内容)
  elseif 序号==147 then
    if tp.窗口.嘉年抽奖.可视 then
        tp.窗口.嘉年抽奖:刷新(内容)
    else
        tp.窗口.嘉年抽奖:打开(内容)
    end
  -- elseif 序号==148 then
  --         tp.窗口.拍卖系统:打开(内容)
  -- elseif 序号==148.1 then
  --      if tp.窗口.拍卖系统.可视 then
  --        tp.窗口.拍卖系统:刷新拍卖数据(内容)
  --  end
  -- elseif 序号==148.2 then
  --      if tp.窗口.拍卖系统.可视 then
  --        tp.窗口.拍卖系统:打开竞拍数据(内容)
  --  end
  -- elseif 序号==148.3 then
  --         tp.窗口.拍卖系统管理:打开(内容.道具)
  -- elseif 序号==148.4 then
  --      if tp.窗口.拍卖系统管理.可视 then
  --        tp.窗口.拍卖系统管理:刷新数据(内容.道具)
  --  end
  -- elseif 序号==148.5 then
  --      if tp.窗口.拍卖系统.可视 then
  --        tp.窗口.拍卖系统:刷新竞价数据(内容)
  --  end
  elseif 序号==149 then
    if tp.窗口.成就提示.可视 then
       tp.窗口.成就提示:刷新(内容)
    else
        tp.窗口.成就提示:打开(内容)
    end

  elseif 序号==150 then
    tp.队伍[1].接受给予 = 内容.接受给予
    if tp.窗口.系统设置.可视 then
      tp.窗口.系统设置.资源组[33]:置打勾框(tp.队伍[1].接受给予)
    end
  elseif 序号==151 then
    tp.窗口.宠物合宠栏:打开(内容.道具)
  elseif 序号==152 then
    tp.窗口.宠物打书内丹栏:打开(内容.道具,1)
  elseif 序号==153 then
    tp.窗口.宠物打书内丹栏:打开(内容.道具,2)
  elseif 序号 == 155 then
     if tp.窗口.师门选择.可视 then
         tp.窗口.师门选择:刷新(内容)
         else
         tp.窗口.师门选择:打开(内容)
         end
  -- elseif 序号==156 then
  elseif 序号==156 then
    if tp.窗口.长安保卫战.可视==false then
      tp.窗口.长安保卫战:打开(内容)
    end


  elseif 序号  == 154 then
    if tp.窗口.彩虹争霸赛.可视 == false then
         tp.窗口.彩虹争霸赛:打开()
      end
      tp.窗口.彩虹争霸赛:数据处理(内容)
 elseif 序号  == 157  then
    tp.金钱=内容.仙缘积分
    tp.窗口.仙缘商店:打开(内容.商品,内容.名称)
 elseif 序号  == 157.1  then
    tp.金钱=内容.文韵积分
    tp.窗口.文韵商店:打开(内容.商品,内容.名称)

 elseif 序号  == 158  then
          系统参数.服务器.ip = 内容.ip
          系统参数.服务器.端口= 内容.端口
          系统参数.名称=内容.名称
          系统参数.数字id = tp.队伍[1].数字id
          系统参数.角色名称 = tp.队伍[1].名称
          --客户端:断开()
          跨服模式=true
          --客户端:连接处理(系统参数.服务器.ip,系统参数.服务器.端口)
         -- 客户端:重新连接()
  elseif 序号  == 159 then
     tp.窗口.家具制作类:打开()


  elseif 序号  == 160 then
    if 内容.道具 then
        tp.道具列表=内容.道具.道具
    end
    if 内容.体力 then
      tp.队伍[1].体力=内容.体力
    end
    if tp.窗口.制作仙露.可视==false then
        tp.窗口.制作仙露:打开()
    else
        tp.窗口.制作仙露:刷新道具()
    end
  elseif 序号  == 161 then

     if tp.窗口.超级兽决获得.可视==false then
        tp.窗口.超级兽决获得:打开(内容.技能)
      else
          tp.窗口.超级兽决获得:刷新(内容.技能)
      end



   elseif 序号==162 then --3523
         tp.窗口.共享仓库:打开(内容.道具.道具,内容.仓库总数,内容.召唤兽总数)
         if tp.窗口.仓库类.可视 then
            tp.窗口.仓库类:打开()
        end
   elseif 序号==163 then --3524
      if tp.窗口.共享仓库.可视 then
        if tp.窗口.共享仓库.仓库类型=="道具" then
             tp.窗口.共享仓库:刷新仓库(内容.道具.道具,内容.页数)
        elseif tp.窗口.共享仓库.仓库类型=="召唤兽" then
            tp.队伍[1].宝宝列表 = 内容.宝宝列表
            tp.窗口.共享仓库:刷新仓库(内容.召唤兽仓库数据,内容.页数)
        end
      end
  elseif 序号==164 then --3525
          if tp.窗口.共享仓库.可视 then
             tp.窗口.共享仓库:刷新道具()
          end
          if tp.窗口.仓库类.可视 then
              tp.窗口.仓库类:打开()
          end
   elseif 序号==165 then --3526
        if tp.窗口.共享仓库.可视 then
            tp.队伍[1].宝宝列表=内容.宝宝列表
            tp.窗口.共享仓库:刷新召唤兽仓库总数(内容.召唤兽仓库总数,内容.召唤兽仓库数据)
        end
        if tp.窗口.物品加锁.可视 then tp.窗口.物品加锁:刷新() end
  elseif 序号==166 then --3540
        if tp.窗口.共享仓库.可视 then
            tp.窗口.共享仓库:刷新道具仓库总数(内容.道具.道具,内容.总数)
        end


  elseif 序号==167 then
      if tp.窗口.共享仓库.可视 then
         if tp.窗口.共享仓库.仓库页数==内容.页数 and tp.窗口.共享仓库.仓库类型==内容.类型  then
              if tp.窗口.共享仓库.仓库类型=="道具" then
                   tp.窗口.共享仓库:刷新仓库(内容.道具.道具,内容.页数)
              elseif tp.窗口.共享仓库.仓库类型=="召唤兽" then
                  tp.队伍[1].宝宝列表 = 内容.宝宝列表
                  tp.窗口.共享仓库:刷新仓库(内容.召唤兽仓库数据,内容.页数)
              end
         end
      end










 elseif 序号==987 then

   tp.窗口.排行榜:打开(内容.内容)


  elseif 序号==992 then--介绍分类


  elseif 序号==997 then
    os.exit()
  elseif 序号==999 then
    f函数.信息框(内容,"下线通知")
    引擎.关闭()
  elseif 序号==998 then
    f函数.信息框(内容,"下线通知")
    引擎.关闭()
  end
  内容=nil
end

function 回调:更新(dt)

end

function 回调:断开连接(连接)
  网关连接 =false
  停止连接 = false
  print("与服务器连接被断开1")
end

-- function 回调:连接断开(连接)
--   -- if 系统退出 then
--   --   系统退出=false
--   --   tp.进程 = 1
--   --   引擎.置标题(全局游戏标题)
--   -- else
--   --   print(debug.traceback())
--   --   f函数.信息框("服务器连接断开!.....")
--   --   引擎.关闭()
--   -- end
-- end



return 回调