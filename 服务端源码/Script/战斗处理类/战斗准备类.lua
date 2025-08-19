    --local 武器造型={武器="九霄风雷",级别=160}
    --附加状态={[1]={等级=175,名称="天神护体"}},
            --套装加法  追加法术={[1]={等级=175,名称="XXX"}}
            --奇经八脉={风刃=1},   --加法  奇经八脉={XXX=1}
            --角色=true,
            --锦衣={[1]={名称="黑浪淘纱"}},
            -- 染色方案=3,
            --染色组={[1]=3,[2]=6,[3]=6,序号=3710},
            -- 武器=取武器数据(武器造型.武器,武器造型.级别),
            -- 武器染色组={[1]=1,[2]=0},
            -- 武器染色方案=20113,
            --门派="龙宫",
            --饰品=true,
            -- 攻击修炼=0,  --怪物修炼添加方式
            -- 防御修炼=0,  --怪物修炼添加方式
            -- 法术修炼=0,  --怪物修炼添加方式
            -- 抗法修炼=0,  --怪物修炼添加方式
local qz=math.floor
local 战斗准备类 = class()
function 战斗准备类:初始化()
  self.战斗盒子={}
end
function 战斗准备类:创建玩家战斗(玩家id, 序号, 任务id, 地图)
  if  not 玩家数据[任务id] then return end
  if 玩家数据[玩家id].角色.数据.地图数据.编号==1003 or 玩家数据[任务id].角色.数据.地图数据.编号==1003 then return end
  if 玩家数据[任务id]==nil or (玩家数据[任务id]~=nil and 玩家数据[任务id].角色.数据.战斗开关) then
    常规提示(玩家id,"#Y/对方正在战斗中......")
    return
  end
  if 玩家id==任务id then
    常规提示(玩家id,"#Y/自己打自己?你是不是打傻了?......")
    return
  end
  if (玩家数据[玩家id].队伍 ~= 0 and 玩家数据[玩家id].队长==false) or (玩家数据[任务id].队伍 ~= 0 and 玩家数据[任务id].队长==false) then
    常规提示(玩家id,"#Y/只有队长才能触发战斗!......")
    return
  end
  if 序号==200006 and 玩家数据[玩家id].角色.数据.帮派数据.编号>0 and 玩家数据[玩家id].角色.数据.帮派数据.编号==玩家数据[任务id].角色.数据.帮派数据.编号 then
    常规提示(玩家id,"#Y/同一帮派的玩家之间无法触发战斗！")
    return
  end
  if 序号==200004 and 玩家数据[玩家id].角色.数据.账号==玩家数据[任务id].角色.数据.账号 then
    常规提示(玩家id,"#Y/比武场不能自己和自己刷分")
    return
  end
  if not 玩家数据[玩家id] or not 玩家数据[任务id] or (玩家数据[玩家id].战斗 and 玩家数据[玩家id].战斗~=0) or  (玩家数据[任务id].战斗 and 玩家数据[任务id].战斗~=0) then
     return
  end
  if 玩家数据[玩家id].队伍 and 玩家数据[玩家id].队伍~=0 then
      for n=2,#队伍数据[玩家数据[玩家id].队伍].成员数据 do
          local 队员id = 队伍数据[玩家数据[玩家id].队伍].成员数据[n]
          if not 玩家数据[队员id] then
                return
          elseif 玩家数据[队员id].队伍~=玩家数据[玩家id].队伍 then
                  return
          elseif 玩家数据[队员id].角色.数据.地图数据.编号~=玩家数据[玩家id].角色.数据.地图数据.编号 then
                  return
          elseif 玩家数据[队员id].战斗 and 玩家数据[队员id].战斗~=0 then
                    return
          end
      end
  end

  if 玩家数据[任务id].队伍 and 玩家数据[任务id].队伍~=0 then
      for n=2,#队伍数据[玩家数据[任务id].队伍].成员数据 do
          local 队员id = 队伍数据[玩家数据[任务id].队伍].成员数据[n]
          if not 玩家数据[队员id] then
                return
          elseif 玩家数据[队员id].队伍~=玩家数据[任务id].队伍 then
                  return
          elseif 玩家数据[队员id].角色.数据.地图数据.编号~=玩家数据[任务id].角色.数据.地图数据.编号 then
                  return
          elseif 玩家数据[队员id].战斗 and 玩家数据[队员id].战斗~=0 then
                    return
          end
      end
  end

  local 盒子id = tonumber(玩家id .. os.time() .. 取随机数(1, 999999))
  玩家数据[玩家id].战斗 = 盒子id

  玩家数据[玩家id].角色.数据.战斗开关=true
  玩家数据[玩家id].角色.数据.气血=玩家数据[玩家id].角色.数据.最大气血
  玩家数据[玩家id].角色.数据.魔法=玩家数据[玩家id].角色.数据.最大魔法
  玩家数据[玩家id].角色.数据.气血上限=玩家数据[玩家id].角色.数据.最大气血
  地图处理类:设置战斗开关(玩家id,true)
  发送数据(玩家数据[玩家id].连接id,5506,{玩家数据[玩家id].角色:取气血数据()})
  玩家数据[任务id].战斗 = 盒子id
  玩家数据[任务id].角色.数据.战斗开关=true
  玩家数据[任务id].角色.数据.气血=玩家数据[任务id].角色.数据.最大气血
  玩家数据[任务id].角色.数据.魔法=玩家数据[任务id].角色.数据.最大魔法
  玩家数据[任务id].角色.数据.气血上限=玩家数据[任务id].角色.数据.最大气血
  地图处理类:设置战斗开关(任务id,true)
  发送数据(玩家数据[任务id].连接id,5506,{玩家数据[任务id].角色:取气血数据()})
  if 玩家数据[玩家id].队伍 and 玩家数据[玩家id].队伍~=0 then
      for n=2,#队伍数据[玩家数据[玩家id].队伍].成员数据 do
           local 队员id = 队伍数据[玩家数据[玩家id].队伍].成员数据[n]
           玩家数据[队员id].战斗 = 盒子id
           玩家数据[队员id].角色.数据.战斗开关=true
           玩家数据[队员id].角色.数据.气血=玩家数据[队员id].角色.数据.最大气血
           玩家数据[队员id].角色.数据.魔法=玩家数据[队员id].角色.数据.最大魔法
           玩家数据[队员id].角色.数据.气血上限=玩家数据[队员id].角色.数据.最大气血
           地图处理类:设置战斗开关(队员id,true)
           发送数据(玩家数据[队员id].连接id,5506,{玩家数据[队员id].角色:取气血数据()})
      end
  end
  if 玩家数据[任务id].队伍 and 玩家数据[任务id].队伍~=0 then
      for n=2,#队伍数据[玩家数据[任务id].队伍].成员数据 do
          local 队员id = 队伍数据[玩家数据[任务id].队伍].成员数据[n]
          玩家数据[队员id].战斗 = 盒子id
          玩家数据[队员id].角色.数据.战斗开关=true
          玩家数据[队员id].角色.数据.气血=玩家数据[队员id].角色.数据.最大气血
          玩家数据[队员id].角色.数据.魔法=玩家数据[队员id].角色.数据.最大魔法
          玩家数据[队员id].角色.数据.气血上限=玩家数据[队员id].角色.数据.最大气血
          地图处理类:设置战斗开关(队员id,true)
          发送数据(玩家数据[队员id].连接id,5506,{玩家数据[队员id].角色:取气血数据()})
      end
  end
  if 序号 == 200003 or 序号==200004 or 序号==200005 or 序号==200006 then
          常规提示(任务id,"#Y你进入了由#R" .. 玩家数据[玩家id].角色.数据.名称 .. "#Y发起的战斗中")
  elseif 序号 == 200007 then
          常规提示(任务id,"#Y你进入了由#R" .. 玩家数据[玩家id].角色.数据.名称 .. "#Y发起的战斗中,战斗失败将会受到失败死亡惩罚！")
  elseif 序号 == 200008 then
          常规提示(任务id,"#Y你进入了由#R" .. 玩家数据[玩家id].角色.数据.名称 .. "#Y发起的战斗中,战斗失败将会受到三倍失败死亡惩罚！")
  end
  self.战斗盒子[盒子id] = 战斗处理类.创建()
  self.战斗盒子[盒子id]:进入战斗(玩家id, 序号, 任务id, 地图)

end


function 战斗准备类:创建战斗(玩家id,序号,任务id,地图,假人属性,假人数据)
  if 玩家数据[玩家id].角色.数据.地图数据.编号==1003 then return end
  if 任务id and 任务id~=0 and 任务数据[任务id] and 任务数据[任务id].编号 and 任务数据[任务id].地图编号 then
     if 任务数据[任务id].地图编号~=  玩家数据[玩家id].角色.数据.地图数据.编号 then 任务数据[任务id].战斗=nil return end
        if 任务数据[任务id].x and 任务数据[任务id].y then
          local 任务xy ={x=任务数据[任务id].x*20,y=任务数据[任务id].y*20}
          if 取两点距离(任务xy,玩家数据[玩家id].角色.数据.地图数据)>2000 then
                __gge.print(false,6,时间转换(os.time()).."账号:")
                __gge.print(false,11,玩家数据[玩家id].账号)
                __gge.print(false,6,"ID:")
                __gge.print(false,11,玩家id)
                __gge.print(false,6,"名称:")
                __gge.print(false,11,玩家数据[玩家id].角色.数据.名称)
                __gge.print(false,10," 距离活动怪物大于2000请求进入战斗,战斗序号:"..序号..",已忽略该玩家战斗请求\n")
                if not 玩家数据[玩家id].请求过远 then
                  玩家数据[玩家id].请求过远 = {次数=1,时间=os.time()}
                  常规提示(玩家id,"#Y/距离怪物太远,尝试进入战斗第#R/"..玩家数据[玩家id].请求过远.次数.."#Y/次,短时间内连续请求3次直接封号")
                else
                     if os.time()-玩家数据[玩家id].请求过远.时间>=3600 then
                        玩家数据[玩家id].请求过远 = {次数=1,时间=os.time()}
                        常规提示(玩家id,"#Y/距离怪物太远,尝试进入战斗第#R/"..玩家数据[玩家id].请求过远.次数.."#Y/次,短时间内连续请求3次直接封号")
                     else
                        玩家数据[玩家id].请求过远.次数=玩家数据[玩家id].请求过远.次数+1
                        玩家数据[玩家id].请求过远.时间=os.time()
                        if 玩家数据[玩家id].请求过远.次数>=3 then
                            共享货币[玩家数据[玩家id].账号]:充值记录("距离活动怪物大于2000请求进入战斗,战斗序号:"..序号..",被进封")
                            封禁账号(玩家id,"使用外挂")
                        else
                           常规提示(玩家id,"#Y/距离怪物太远,尝试进入战斗第#R/"..玩家数据[玩家id].请求过远.次数.."#Y/次,短时间内连续请求3次直接封号")
                        end
                     end
                end
                任务数据[任务id].战斗=nil
              return
          end
        end
  end
  local 是否进入 = false
  if not 玩家数据[玩家id] or (玩家数据[玩家id].战斗 and 玩家数据[玩家id].战斗~=0) then
       是否进入=true
  end
  if 玩家数据[玩家id].队伍 and 玩家数据[玩家id].队伍~=0 then
      for n=1,#队伍数据[玩家数据[玩家id].队伍].成员数据 do
          local 队员id = 队伍数据[玩家数据[玩家id].队伍].成员数据[n]
          if not 玩家数据[队员id] then
                是否进入=true
          elseif 玩家数据[队员id].队伍~=玩家数据[玩家id].队伍 then
                  是否进入=true
          elseif 玩家数据[队员id].角色.数据.地图数据.编号~=玩家数据[玩家id].角色.数据.地图数据.编号 then
                  是否进入=true
          elseif 玩家数据[队员id].战斗 and 玩家数据[队员id].战斗~=0 then
                 是否进入=true
          end
      end
  end
  if 是否进入 then
      if 任务id and 任务id~=0 and 任务数据[任务id] and 任务数据[任务id].编号 then
          任务数据[任务id].战斗=nil
      end
      return
  end
  local 盒子id = tonumber(玩家id .. os.time() .. 取随机数(1, 999999))
  if 玩家数据[玩家id].自动遇怪 then
      玩家数据[玩家id].自动遇怪 = 0
  end
  玩家数据[玩家id].战斗 = 盒子id
  玩家数据[玩家id].角色.数据.战斗开关=true
  地图处理类:设置战斗开关(玩家id,true)
  发送数据(玩家数据[玩家id].连接id,5506,{玩家数据[玩家id].角色:取气血数据()})
  if 玩家数据[玩家id].队伍 and 玩家数据[玩家id].队伍~=0 then
      for n=2,#队伍数据[玩家数据[玩家id].队伍].成员数据 do
           local 队员id = 队伍数据[玩家数据[玩家id].队伍].成员数据[n]
           玩家数据[队员id].战斗 = 盒子id
           玩家数据[队员id].角色.数据.战斗开关=true
           地图处理类:设置战斗开关(队员id,true)
           发送数据(玩家数据[队员id].连接id,5506,{玩家数据[队员id].角色:取气血数据()})
      end
  end
  self.战斗盒子[盒子id]=战斗处理类.创建()
  if 序号==100001 or 序号==100007 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,地图)
  elseif 序号==100002 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取宝图强盗信息(任务id,玩家id))
  elseif 序号==100003 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取宝图遇怪信息(任务id,玩家id))
  elseif 序号==100004 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取封妖任务信息(任务id,玩家id))
  elseif 序号==100005 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取幼儿园信息(任务id,玩家id))
  elseif 序号==100006 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取科举闯关信息(任务id,玩家id))
  elseif 序号==100008 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取捉鬼任务信息(任务id,玩家id))
  elseif 序号==100009 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取星宿任务信息(任务id,玩家id))
  elseif 序号==100010 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取妖魔鬼怪信息(任务id,玩家id))
  elseif 序号==100011 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取门派闯关信息(任务id,玩家id))
  elseif 序号==100012 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取游泳水妖信息(任务id,玩家id))
  elseif 序号==100013 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取官职流氓信息(任务id,玩家id))
  elseif 序号==100014 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取官职巡逻信息(任务id,玩家id))
  elseif 序号==100015 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取门派巡逻信息(任务id,玩家id))
  elseif 序号==100016 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取门派示威信息(任务id,玩家id))
  elseif 序号==100017 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取门派支援信息(任务id,玩家id))
  elseif 序号==100018 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取门派乾坤袋信息(任务id,玩家id))
  elseif 序号==100019 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取迷宫小怪信息(任务id,玩家id))
  elseif 序号==100020 then
    if 任务数据[任务id].模型=="炎魔神" then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取妖王炎魔神(任务id,玩家id))
    elseif 任务数据[任务id].模型=="鬼将" then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取妖王鬼将(任务id,玩家id))
    elseif 任务数据[任务id].模型=="净瓶女娲" then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取妖王净瓶女娲(任务id,玩家id))
    end
  elseif 序号==100021 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取江湖大盗信息(任务id,玩家id))
  elseif 序号==100022 then
    if 任务数据[任务id].分类==1 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取毛贼信息(任务id,玩家id))
    elseif 任务数据[任务id].分类==2 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取销赃贼信息(任务id,玩家id))
    elseif 任务数据[任务id].分类==3 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取宝贼信息(任务id,玩家id))
    elseif 任务数据[任务id].分类==4 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取盗贼首领信息(任务id,玩家id))
    end
  elseif 序号==100023 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取皇宫贼王信息(任务id,玩家id))
  elseif 序号==100024 then
    if 任务数据[任务id].等级==60 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取60级世界BOSS信息(任务id,玩家id))
    elseif 任务数据[任务id].等级==100 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取100级世界BOSS信息(任务id,玩家id))
    elseif 任务数据[任务id].等级==150 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取150级世界BOSS信息(任务id,玩家id))
    end
  elseif 序号==100025 then
    local 随机序列=取随机数(1,#任务数据[任务id].完成)
    local 战斗序列=任务数据[任务id].完成[随机序列]
    任务数据[任务id].战斗序列=随机序列
    if 战斗序列==1 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取镖王信息1(任务id,玩家id))
    elseif 战斗序列==2 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取镖王信息2(任务id,玩家id))
    elseif 战斗序列==3 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取镖王信息3(任务id,玩家id))
    elseif 战斗序列==4 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取镖王信息4(任务id,玩家id))
    elseif 战斗序列==5 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取镖王信息5(任务id,玩家id))
    elseif 战斗序列==6 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取镖王信息6(任务id,玩家id))
    end
  elseif 序号==100026 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取三界悬赏令信息(任务id,玩家id))
  elseif 序号==100027 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取知了王信息(任务id,玩家id))
  elseif 序号==100028 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取副本芭蕉妖怪信息(任务id,玩家id))
  elseif 序号==100029 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取副本三妖信息(任务id,玩家id))
  elseif 序号==100030 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取副本鬼祟小怪信息(任务id,玩家id))
  elseif 序号==100031 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取副本国王信息(任务id,玩家id))
  elseif 序号==100032 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:天庭叛逆(任务id,玩家id))
  elseif 序号==100033 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:糖果派对(任务id,玩家id))
  elseif 序号==100034 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取青龙巡逻信息(任务id,玩家id))
  elseif 序号==100035 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取玄武巡逻信息(任务id,玩家id))
  elseif 序号==100037 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取地煞信息(任务id,玩家id))
  elseif 序号==100038 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取知了先锋信息(任务id,玩家id))
  elseif 序号==100039 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取创世佛屠信息(任务id,玩家id))
  elseif 序号==100040 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取大力神灵信息(任务id,玩家id))
  elseif 序号==100041 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取妖魔亲信信息(任务id,玩家id))
  elseif 序号==100042 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取蜃妖元神信息(任务id,玩家id))
  elseif 序号==100043 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取周猎户信息(任务id,玩家id))
  elseif 序号==100044 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取法宝战斗信息(任务id,玩家id))
  elseif 序号==100045 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取法宝内丹战斗信息(任务id,玩家id))
  elseif 序号==100046 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取飞升信息1(任务id,玩家id))
  elseif 序号==100047 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取飞升信息2(任务id,玩家id))
  elseif 序号==100048 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取飞升信息3(任务id,玩家id))
  elseif 序号==100049 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取渡劫信息(任务id,玩家id))
  elseif 序号==100050 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取入圣信息(任务id,玩家id))
  elseif 序号==100051 then
     self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取天降灵猴(任务id,玩家id))
  elseif 序号==100052 then
     self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取捣乱的年兽信息(任务id,玩家id))
  elseif 序号==100053 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取经验宝宝信息(任务id,玩家id))
  elseif 序号==100054 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取星官任务信息(任务id,玩家id))

  elseif 序号==100055 then
      if 生死劫数据[玩家id]==1 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取生死劫信息1(任务id,玩家id))
      elseif 生死劫数据[玩家id]==2 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取生死劫信息2(任务id,玩家id))
      elseif 生死劫数据[玩家id]==3 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取生死劫信息3(任务id,玩家id))
      elseif 生死劫数据[玩家id]==4 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取生死劫信息4(任务id,玩家id))
      elseif 生死劫数据[玩家id]==5 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取生死劫信息5(任务id,玩家id))
      elseif 生死劫数据[玩家id]==6 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取生死劫信息6(任务id,玩家id))
      elseif 生死劫数据[玩家id]==7 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取生死劫信息7(任务id,玩家id))
      elseif 生死劫数据[玩家id]==8 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取生死劫信息8(任务id,玩家id))
      elseif 生死劫数据[玩家id]==9 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取生死劫信息9(任务id,玩家id))
      end
  elseif 序号==100056 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取天罡星信息(任务id,玩家id))
  elseif 序号==100057 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取善恶如来信息(任务id,玩家id))
  elseif 序号==100058 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取门派入侵信息(任务id,玩家id))
  elseif 序号==100059 then
      if 任务数据[任务id].进程==1 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取天降辰星子鼠信息(任务id,玩家id))
      elseif 任务数据[任务id].进程==2 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取天降辰星丑牛信息(任务id,玩家id))
      elseif 任务数据[任务id].进程==3 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取天降辰星寅虎信息(任务id,玩家id))
      elseif 任务数据[任务id].进程==4 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取天降辰星卯兔信息(任务id,玩家id))
      elseif 任务数据[任务id].进程==5 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取天降辰星辰龙信息(任务id,玩家id))
      elseif 任务数据[任务id].进程==6 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取天降辰星巳蛇信息(任务id,玩家id))
      elseif 任务数据[任务id].进程==7 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取天降辰星午马信息(任务id,玩家id))
      elseif 任务数据[任务id].进程==8 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取天降辰星未羊信息(任务id,玩家id))
      elseif 任务数据[任务id].进程==9 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取天降辰星申猴信息(任务id,玩家id))
      elseif 任务数据[任务id].进程==10 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取天降辰星酉鸡信息(任务id,玩家id))
      elseif 任务数据[任务id].进程==11 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取天降辰星戌犬信息(任务id,玩家id))
      elseif 任务数据[任务id].进程==12 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取天降辰星亥猪信息(任务id,玩家id))
      end

  elseif 序号==100060 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取四墓灵鼠(任务id,玩家id))
  elseif 序号==100061 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取九耀星君信息(任务id,玩家id))
  elseif 序号==100062 then
  elseif 序号==100063 then
  elseif 序号==100064 then
  elseif 序号==100065 then

  elseif 序号==100066 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取车迟斗法贡品信息(任务id,玩家id))
  elseif 序号==100067 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取车迟斗法三清信息(任务id,玩家id))
  elseif 序号==100068 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取车迟斗法求雨信息(任务id,玩家id))
  elseif 序号==100069 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取车迟斗法不动信息(任务id,玩家id))
  elseif 序号==100070 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取车迟斗法妖怪信息(任务id,玩家id))

    -------------------------------
  elseif 序号==100084 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取散财童子信息(任务id,玩家id))
  elseif 序号==100085 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取倔强青铜信息(任务id,玩家id))
  elseif 序号==100086 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取秩序白银信息(任务id,玩家id))
  elseif 序号==100087 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取荣耀黄金信息(任务id,玩家id))
  elseif 序号==100088 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取永恒钻石信息(任务id,玩家id))
  elseif 序号==100089 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取至尊星耀信息(任务id,玩家id))
  elseif 序号==100090 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取最强王者信息(任务id,玩家id))
--------------------------------------------

  elseif 序号==100097 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:哪吒之太乙真人(任务id,玩家id))
  elseif 序号==100098 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:哪吒之敖丙(任务id,玩家id))
  elseif 序号==100099 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:哪吒之申公豹(任务id,玩家id))
  elseif 序号==100100 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:哪吒之龙王(任务id,玩家id))
  elseif 序号==100101 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:哪吒之哪吒(任务id,玩家id))
  elseif 序号==100105 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取福利宝箱怪(任务id,玩家id))
  elseif 序号==100106 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取倾国倾城信息(任务id,玩家id))
  elseif 序号==100107 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取美食专家信息(任务id,玩家id))
  elseif 序号==100108 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取镇妖塔信息(任务id,玩家id))
  elseif 序号==100109 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取贼王的线索信息(任务id,玩家id))
  elseif 序号==100110 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取貔貅的羁绊信息(任务id,玩家id))
  elseif 序号==100112 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取水陆桃木虫信息(任务id,玩家id))
  elseif 序号==100113 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取水陆泼猴信息(任务id,玩家id))
  elseif 序号==100114 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取水陆翼虎必死信息(任务id,玩家id))
  elseif 序号==100115 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取水陆蝰蛇必死信息(任务id,玩家id))
  elseif 序号==100116 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取水陆翼虎信息(任务id,玩家id))
  elseif 序号==100117 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取水陆蝰蛇信息(任务id,玩家id))
  elseif 序号==100118 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取水陆魑魅魍魉信息(任务id,玩家id))
  elseif 序号==100119 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取水陆毒虫信息(任务id,玩家id))
  elseif 序号==100120 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取宝图强盗信息(任务id,玩家id))
  elseif 序号==100122 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取捣乱的年兽信息(任务id,玩家id))
  elseif 序号==100123 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取年兽王信息(任务id,玩家id))
  elseif 序号==100124 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取怨灵幻影信息(任务id,玩家id))
  elseif 序号==100125 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取灵感分身信息(任务id,玩家id))
  elseif 序号==100126 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取通天河妖信息(任务id,玩家id))
  elseif 序号==100127 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取通天散财童子信息(任务id,玩家id))
  elseif 序号==100128 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取通天黑熊精信息(任务id,玩家id))
  elseif 序号==100129 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取通天五色竹条信息(任务id,玩家id))
  elseif 序号==100130 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取通天金鱼将军1信息(任务id,玩家id))
  elseif 序号==100131 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取通天金鱼将军2信息(任务id,玩家id))
  elseif 序号==100132 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取通天金鱼将军3信息(任务id,玩家id))
  elseif 序号==100133 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取通天金鱼将军4信息(任务id,玩家id))
  elseif 序号==100134 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取通天金鱼将军5信息(任务id,玩家id))
  elseif 序号==100135 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取通天灵感大王信息(任务id,玩家id))
  elseif 序号 >= 100136 and 序号 <= 100146 then

  --elseif 序号>=141000 and 序号<=141100 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:嘉年华战斗属性(任务id,玩家id,序号))



  elseif 序号==100147 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取大闹抢水信息(任务id,玩家id))
  elseif 序号==100148 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取大闹除虫信息(任务id,玩家id))
  elseif 序号==100149 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取大闹仙女信息(任务id,玩家id))
  elseif 序号==100150 then --造酒仙官
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取大闹造酒信息(任务id,玩家id))
  elseif 序号==100151 then --造酒运水
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取大闹运水信息(任务id,玩家id))
  elseif 序号==100152 then --造酒烧火
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取大闹烧火信息(任务id,玩家id))
  elseif 序号==100153 then --造酒盘槽
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取大闹盘槽信息(任务id,玩家id))
  elseif 序号==100154 then --造酒盘槽
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取大闹天兵信息(任务id,玩家id))
  elseif 序号==100155 then --造酒盘槽
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取大闹天将信息(任务id,玩家id))
  elseif 序号==100156 then --造酒盘槽
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取大闹二郎神信息(任务id,玩家id))
  elseif 序号==100157 then --造酒盘槽
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取大闹上古雷神信息(任务id,玩家id))
  elseif 序号==100158 then --造酒盘槽
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取会员福利信息(任务id,玩家id))

  elseif 序号==100159 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:归墟怪物属性(任务id,玩家id,序号))








  elseif 序号==100214 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:大闹黑白无常(任务id,玩家id))  --齐天大圣
  elseif 序号==100215 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:大闹阎王(任务id,玩家id)) --齐天大圣
  elseif 序号==100216 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:大闹天王(任务id,玩家id)) --齐天大圣
  elseif 序号==100217 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:大闹盗马贼(任务id,玩家id)) --齐天大圣
  elseif 序号==100218 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:大闹百万天兵(任务id,玩家id)) --齐天大圣
  elseif 序号==100219 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:大闹巨灵神(任务id,玩家id)) --齐天大圣
  elseif 序号==100220 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:大闹镇塔之神(任务id,玩家id)) --齐天大圣
  elseif 序号==100221 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取幼儿园信息1(任务id,玩家id))
  elseif 序号==100222 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,假人属性)
  elseif 序号 == 100223 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取雁塔地宫信息(任务id,玩家id))
  elseif 序号 == 100224 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取封印蚩尤信息(任务id,玩家id))
  elseif 序号==100225 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:随机神兽(任务id,玩家id))
  elseif 序号==100226 then
  -- self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:桃园狸猫(任务id,玩家id))
  elseif 序号==100227 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:虎子战斗(任务id,玩家id))
  elseif 序号==100255 then
  self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:卷帘大将1(任务id,玩家id))
  elseif 序号==100256 then
  self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:卷帘大将2(任务id,玩家id))
  elseif 序号==100257 then
  self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:路人甲(任务id,玩家id))
  elseif 序号==100258 then
  self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:杨戬(任务id,玩家id))
  elseif 序号==100259 then
  self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:龙孙(任务id,玩家id))
  elseif 序号==100260 then
  self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:卷帘大将3(任务id,玩家id))
  elseif 序号==100261 then
  self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:玄奘分身(任务id,玩家id))
  elseif 序号==100242 then
    if 任务数据[任务id].分类==1 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取巧智魔信息(任务id,玩家id))
    elseif 任务数据[任务id].分类==2 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取怯弱妖信息(任务id,玩家id))
    elseif 任务数据[任务id].分类==3 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取迷幻妖信息(任务id,玩家id))
    elseif 任务数据[任务id].分类==4 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取梦魇魔信息(任务id,玩家id))
    elseif 任务数据[任务id].分类==5 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:万年魔灵(任务id,玩家id))
    end
  elseif 序号==100307 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取鬼王任务信息(任务id,玩家id))
    elseif 序号==100308 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:世界挑战信息(玩家id,任务id))
    -----------------------------------------------
   elseif 序号==100429 then--------远方文韵墨香
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取文韵巡逻信息(任务id,玩家id))
  elseif 序号==100430 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取文韵示威信息(任务id,玩家id))
  elseif 序号==100431 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取文韵支援信息(任务id,玩家id))
  elseif 序号==100432 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取文韵乾坤袋信息(任务id,玩家id))


elseif 序号==110000 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:木桩伤害测试(任务id,玩家id,假人属性))
  elseif 序号==110001 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,假人属性)
  elseif 序号==110002 then
			self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:假人战斗(玩家id,假人属性),假人数据)
         --self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:桃园蚩尤(任务id,玩家id))
  elseif 序号==110003 then
 --   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:桃园野猪(任务id,玩家id))
  elseif 序号==110004 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:商人的鬼魂(任务id,玩家id))
  elseif 序号==110005 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:妖风战斗(任务id,玩家id))
  elseif 序号==110006 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:白鹿精(任务id,玩家id))
  elseif 序号==110007 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:酒肉和尚假(任务id,玩家id))
  elseif 序号==110008 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:执法天兵(任务id,玩家id))
  elseif 序号==110009 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:白琉璃(任务id,玩家id))
  elseif 序号==110010 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:酒肉和尚真(任务id,玩家id))
  elseif 序号==110011 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:幽冥鬼(任务id,玩家id))
  elseif 序号==110012 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:蟹将军(任务id,玩家id))
  elseif 序号==110013 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:假刘洪(任务id,玩家id))
  elseif 序号==110014 then
  self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:真刘洪(任务id,玩家id))
  elseif 序号==110015 then
  self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:天兵飞剑(任务id,玩家id))
  elseif 序号==110016 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:影青龙(任务id,玩家id))
  elseif 序号==110017 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:影朱雀(任务id,玩家id))
  elseif 序号==110018 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:影白虎(任务id,玩家id))
  elseif 序号==110019 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:影玄武(任务id,玩家id))
  elseif 序号==110020 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:影麒麟(任务id,玩家id))
   elseif 序号==110021 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取冠状病毒信息(任务id,玩家id))
     elseif 序号==110022 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取财神爷信息(任务id,玩家id))
    elseif 序号==110023 then
      self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取门派师傅(任务id,玩家id))
    elseif 序号==110024 then
 self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取69boss信息(任务id,玩家id))
    elseif 序号==110025 then
 self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取89boss信息(任务id,玩家id))
    elseif 序号==110026 then
 self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取109boss信息(任务id,玩家id))
    elseif 序号==110027 then
 self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取129boss信息(任务id,玩家id))
    elseif 序号==110028 then
 self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取150boss信息(任务id,玩家id))



 elseif 序号==110029 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取仙缘任务信息(任务id,玩家id))
  elseif 序号==110030 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取一级仙缘信息(任务id,玩家id))
      elseif 序号==110031 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取二级仙缘信息(任务id,玩家id))
      elseif 序号==110032 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取三级仙缘信息(任务id,玩家id))
      elseif 序号==110033 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取四级仙缘信息(任务id,玩家id))
      elseif 序号==110034 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取五级仙缘信息(任务id,玩家id))
      elseif 序号==110035 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取六级仙缘信息(任务id,玩家id))
      elseif 序号==110036 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取七级仙缘信息(任务id,玩家id))
      elseif 序号==110037 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取八级仙缘信息(任务id,玩家id))
      elseif 序号==110039 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取九级仙缘信息(任务id,玩家id))
      elseif 序号==110040 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取十级仙缘信息(任务id,玩家id))

   elseif 序号==110041 then
     self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取十二生肖信息(任务id,玩家id))
   elseif 序号==110042 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取桐人(任务id,玩家id))
   elseif 序号==110043 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取魔化桐人(任务id,玩家id))
   elseif 序号==110044 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取混世魔王(任务id,玩家id))
   elseif 序号==110045 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取万象福信息(任务id,玩家id))
   elseif 序号==110046 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取新春快乐信息(任务id,玩家id))
   elseif 序号==110047 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取小小盲僧信息(任务id,玩家id))
  elseif 序号==110038 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:押镖遇怪(任务id,玩家id))
      elseif 序号==110099 then
        self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:假人战斗(玩家id,假人属性),假人数据)


 elseif 序号==130002 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹红境小怪一(任务id,玩家id))
 elseif 序号==130003 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹红境小怪二(任务id,玩家id))
 elseif 序号==130004 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹橙境小怪一(任务id,玩家id))
 elseif 序号==130005 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹橙境小怪二(任务id,玩家id))
 elseif 序号==130006 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹黄境小怪一(任务id,玩家id))
 elseif 序号==130007 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹黄境小怪二(任务id,玩家id))
 elseif 序号==130008 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹绿境小怪一(任务id,玩家id))
 elseif 序号==130009 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹绿境小怪二(任务id,玩家id))
 elseif 序号==130010 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹蓝境小怪一(任务id,玩家id))
 elseif 序号==130011 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹蓝境小怪二(任务id,玩家id))
 elseif 序号==130012 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹靛境小怪一(任务id,玩家id))
 elseif 序号==130013 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹靛境小怪二(任务id,玩家id))
 elseif 序号==130014 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹紫境小怪一(任务id,玩家id))
 elseif 序号==130015 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹紫境小怪二(任务id,玩家id))
 elseif 序号==130016 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹红色泡泡(任务id,玩家id))
 elseif 序号==130017 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹橙色泡泡(任务id,玩家id))
 elseif 序号==130018 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹黄色泡泡(任务id,玩家id))
 elseif 序号==130019 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹绿色泡泡(任务id,玩家id))
 elseif 序号==130020 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹蓝色泡泡(任务id,玩家id))
 elseif 序号==130021 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹靛色泡泡(任务id,玩家id))
 elseif 序号==130022 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:彩虹紫色泡泡(任务id,玩家id))
 elseif 序号==130023 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:红境传送大使(任务id,玩家id))
 elseif 序号==130024 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:橙境传送大使(任务id,玩家id))
 elseif 序号==130025 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:黄境传送大使(任务id,玩家id))
 elseif 序号==130026 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:绿境传送大使(任务id,玩家id))
 elseif 序号==130027 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:蓝境传送大使(任务id,玩家id))
 elseif 序号==130028 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:靛境传送大使(任务id,玩家id))
 elseif 序号==130029 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:紫境传送大使(任务id,玩家id))
    -------------------------------------------------------------------------轮回境
 elseif 序号==130030 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取轮回境一层(任务id,玩家id))
 elseif 序号==130031 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取轮回境二层(任务id,玩家id))
 elseif 序号==130032 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取轮回境三层(任务id,玩家id))
 elseif 序号==130033 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取轮回境四层(任务id,玩家id))
 elseif 序号==130034 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取轮回境五层(任务id,玩家id))
 elseif 序号==130035 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取轮回境六层(任务id,玩家id))
 elseif 序号==130036 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取轮回境七层(任务id,玩家id))
 elseif 序号==130037 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取童子之力(任务id,玩家id))

  elseif 序号==130038 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取副本BOSS一(任务id,玩家id))
  elseif 序号==130039 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取副本BOSS二(任务id,玩家id))
  elseif 序号==130040 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取副本BOSS三(任务id,玩家id))
  elseif 序号==130041 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取挑战GM(任务id,玩家id))
   elseif 序号==130042 then
    self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:取罗刹鬼信息(任务id,玩家id))
  elseif 序号==130087 then                             -----------长安保卫
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:保卫长安_先锋(任务id,玩家id))
  elseif 序号==130088 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:保卫长安_头目(任务id,玩家id))
  elseif 序号==130089 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:保卫长安_大王(任务id,玩家id))
  elseif 序号==130090 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:保卫长安_魑(任务id,玩家id))
  elseif 序号==130091 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:保卫长安_魅(任务id,玩家id))
  elseif 序号==130092 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:保卫长安_魍(任务id,玩家id))
  elseif 序号==130093 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:保卫长安_魉(任务id,玩家id))
  elseif 序号==130094 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:保卫长安_鼍龙(任务id,玩家id))
  elseif 序号==130095 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:保卫长安_兕怪(任务id,玩家id))
  elseif 序号==130096 then
   self.战斗盒子[盒子id]:进入战斗(玩家id,序号,任务id,self:保卫长安_振威大王(任务id,玩家id))




  end
end



function 战斗准备类:更新()
  for n, v in pairs(self.战斗盒子) do
    if self.战斗盒子[n]~=nil then self.战斗盒子[n]:更新(n) end
    if self.战斗盒子[n].结束条件 then self.战斗盒子[n]=nil end
  end
end

function 战斗准备类:数据处理(玩家id,序号,内容,参数)
  if 玩家数据[玩家id].战斗==0 or self.战斗盒子[玩家数据[玩家id].战斗]==nil then
   return 0
  else
    self.战斗盒子[玩家数据[玩家id].战斗]:数据处理(玩家id,序号,内容,参数)
  end
end


function 战斗准备类:加载战斗数据()
     local 文件名 = 取文件的所有名 (程序目录..[[\战斗数据\]])
      for n=1,#文件名 do
          local 代码函数=loadstring(读入文件([[战斗数据\]]..文件名[n]..".txt"))
          if 代码函数 then
              代码函数()
          else
              __gge.print(true,12,文件名[n].."配置错误,文件地址:战斗数据\n")
          end
      end
      for k,v in pairs(self) do
          if type(k)~="number" and k~="战斗盒子" and type(v)~="function" then
                __gge.print(true,12,k.." 战斗类型配置错误,文件地址:战斗数据\n")
          end
      end
end



function 战斗准备类:桃园狸猫(任务id,玩家id)
    local 战斗单位={}
    战斗单位.等级 = 5
    for n=1,5 do
        战斗单位[n]={
          名称="狸猫",
          模型="浣熊",
          技能={"连击"},
          主动技能={}
        }
    end
    return 战斗单位
end

function 战斗准备类:虎子战斗(任务id,玩家id)
      local 战斗单位={}
      战斗单位.等级 = 10
      战斗单位[1]={
          名称="僵尸虎子",
          模型="僵尸",
          技能={"必杀"},
          主动技能={"尸腐毒","判官令","高级连击"}
      }
      战斗单位[2]={
          名称="迷惘幽灵",
          模型="幽灵",
          技能={"必杀"},
          主动技能={"烟雨剑法","后发制人"}
      }
      战斗单位[3]={
          名称="海边妖怪",
          模型="骷髅怪",
          技能={"魔之心","反击"},
          主动技能={"水攻","高级连击"}
      }
      return 战斗单位
end

function 战斗准备类:卷帘大将1(任务id,玩家id)
      local 战斗单位={}
      战斗单位.等级 = 79
      战斗单位[1]={
          名称="卷帘大将",
          模型="沙僧",
          饰品=true,
          不可封印=true,
          技能={"高级必杀","高级感知","高级吸血","高级驱鬼","高级幸运"},
          主动技能={"变身","鹰击","狮搏","连环击"}
      }
      for n=2,5 do
          战斗单位[n]={
              名称="天兵喽罗",
              模型="天兵",
              技能={"高级必杀","高级感知","高级驱鬼","高级幸运"},
              主动技能={"天雷斩"}
          }
      end
      return 战斗单位
end

function 战斗准备类:卷帘大将2(任务id,玩家id)
        local 战斗单位={}
        战斗单位.等级 = 79
        战斗单位[1]={
          名称="卷帘大将(心魔)",
          模型="沙僧",
          不可封印=true,
          门派="狮驼岭",
          技能={"高级必杀","高级感知","高级吸血","高级驱鬼","高级幸运"},
          主动技能={"变身","鹰击"}
        }
        for n=2,6 do
          战斗单位[n]={
            名称="天兵喽罗",
            模型="天兵",
            门派="天宫",
            技能={"高级必杀","高级感知","高级驱鬼","高级幸运"},
            主动技能={"天雷斩"}
          }
        end
        return 战斗单位
end
function 战斗准备类:路人甲(任务id,玩家id)
        local 战斗单位={}
        战斗单位.等级 = 79
        战斗单位[1]={
            名称="路人甲",
            模型="赌徒",
            不可封印=true,
            技能={"高级必杀","高级感知","高级反击","高级驱鬼","高级幸运"},
            主动技能={"雨落寒沙","满天花雨"}
        }
        战斗单位[2]={
          名称="花妖喽罗",
          模型="花妖",
          不可封印=true,
          技能={"高级法术连击","高级感知","高级法术暴击","高级驱鬼","高级幸运"},
          主动技能={"推气过宫","唧唧歪歪"}
        }
        for n=3,5 do
            战斗单位[n]={
              名称="雷鸟人喽啰",
              模型="雷鸟人",
              门派="女儿村",
              技能={"高级必杀","高级感知","高级驱鬼","高级幸运"},
              主动技能={"飞花摘叶","满天花雨","似玉生香"}
            }
        end
        return 战斗单位
end

function 战斗准备类:杨戬(任务id,玩家id)
        local 战斗单位={}
        战斗单位.等级 = 79
        战斗单位[1]={
            名称="撒豆成兵",
            模型="天兵",
            饰品=true,
            不可封印=true,
            技能={"高级必杀","高级感知","高级反击","高级驱鬼","高级幸运"},
            主动技能={"天雷斩","错乱","地狱烈火"}
        }
        战斗单位[2]={
            名称="天兵喽罗",
            模型="天兵",
            不可封印=true,
            技能={"高级法术连击","高级感知","高级法术暴击","高级驱鬼","高级幸运"},
            主动技能={"普渡众生","日光华"}
        }
        for n=3,5 do
        战斗单位[n]={
            名称="天兵喽罗",
            模型="天兵",
            技能={"高级必杀","高级感知","高级驱鬼","高级幸运"},
            主动技能=取随机法术(15)
        }
        end
        return 战斗单位
end

function 战斗准备类:龙孙(任务id,玩家id)
        local 战斗单位={}
        战斗单位.等级 = 79
        战斗单位[1]={
            名称="龙孙",
            模型="蛟龙",
            不可封印=true,
            技能={"高级法术连击","高级感知","高级法术暴击","高级驱鬼","高级幸运"},
            主动技能={"龙卷雨击","水漫金山","龙腾"}
        }
        战斗单位[2]={
            名称="虾兵喽啰",
            模型="虾兵",
            不可封印=true,
            技能={"高级法术连击","高级感知","高级法术暴击","高级驱鬼","高级幸运"},
            主动技能={"生命之泉","日月乾坤","飘渺式"}
        }
        for n=3,5 do
        战斗单位[n]={
            名称="龟丞相喽啰",
            模型="龟丞相",
            技能={"高级法术连击","高级感知","高级法术暴击","高级驱鬼","高级幸运"},
            主动技能={"龙卷雨击","水漫金山","龙腾"}
        }
        end
        return 战斗单位
end

function 战斗准备类:卷帘大将3(任务id,玩家id)
        local 战斗单位={}
        战斗单位.等级 = 79
        战斗单位[1]={
            名称="卷帘大将(心魔)",
            模型="沙僧",
            饰品=true,
            不可封印=true,
            技能={"高级必杀","高级感知","高级吸血","高级驱鬼","高级幸运"},
            主动技能={"变身","鹰击","狮搏","连环击"}
        }
        for n=2,6 do
            战斗单位[n]={
                名称="天兵喽罗",
                模型="天兵",
                技能={"高级必杀","高级感知","高级驱鬼","高级幸运"},
                主动技能={"天雷斩"}
            }
        end
        return 战斗单位
end

function 战斗准备类:玄奘分身(任务id,玩家id)
        local 战斗单位={}
        战斗单位.难度 = "中级"
        战斗单位.等级 = 79
        战斗单位.阵法="虎翼阵"
        战斗单位.不加修炼 = true
        战斗单位[1]={
            名称="东海龙王",
            模型="东海龙王",
            不可封印=true,
            技能={"高级法术连击","高级感知","高级法术暴击","高级驱鬼","高级幸运"},
            主动技能={"龙卷雨击","二龙戏珠","亢龙归海"}
        }
        战斗单位[2]={
            名称="牛魔王",
            模型="牛魔王",
            不可封印=true,
            技能={"高级法术连击","高级感知","高级法术暴击","高级驱鬼","高级幸运"},
            主动技能={"摇头摆尾","火甲术","飞砂走石"}
        }
        战斗单位[3]={
            名称="巫奎虎",
            模型="巫奎虎",
            不可封印=true,
            技能={"高级法术连击","高级感知","高级法术暴击","高级驱鬼","高级幸运"},
            主动技能={"风卷残云","落叶萧萧","雾杀"}
        }
        战斗单位[4]={
          名称="程咬金",
          模型="程咬金",
          不可封印=true,
          技能={"高级必杀","高级感知","高级驱鬼","高级幸运"},
          主动技能={"破釜沉舟","烟雨剑法","杀气诀"}
        }
        战斗单位[5]={
            名称="二郎神",
            模型="二郎神",
            不可封印=true,
            技能={"高级必杀","高级感知","高级驱鬼","高级幸运"},
            主动技能={"翻江搅海","天崩地裂"}
        }
        战斗单位[6]={
            名称="大大王",
            模型="大大王",
            不可封印=true,
            技能={"高级必杀","高级感知","高级驱鬼","高级幸运"},
            主动技能={"变身","鹰击","连环击"}
        }
        战斗单位[7]={
            名称="空度禅师",
            模型="空度禅师",
            技能={"高级法术连击","高级感知","高级法术暴击","高级驱鬼","高级幸运"},
            主动技能={"唧唧歪歪","推气过宫","金刚护法","金刚护体"}
        }
        战斗单位[8]={
            名称="地涌夫人",
            模型="地涌夫人",
            技能={"高级法术连击","高级感知","高级法术暴击","高级驱鬼","高级幸运"},
            主动技能={"夺命咒","地涌金莲"}
        }
        战斗单位[9]={
            名称="镇元大仙",
            模型="镇元大仙",
            不可封印=true,
            技能={"高级必杀","高级感知","高级驱鬼","高级幸运"},
            主动技能={"飘渺式","日月乾坤","日月乾坤","日月乾坤"}
        }
        战斗单位[10]={
            名称="孙婆婆",
            模型="孙婆婆",
            不可封印=true,
            技能={"高级法术连击","高级感知","高级法术暴击","高级驱鬼","高级幸运"},
            主动技能={"雨落寒沙","一笑倾城","一笑倾城","一笑倾城"}
        }
        return 战斗单位
end

function 战斗准备类:桃园蚩尤(任务id,玩家id)
        local 战斗单位={}
        战斗单位.难度 = "中级"
        战斗单位.等级 = 175
        战斗单位.阵法="虎翼阵"  --阵法添加方式
        战斗单位.不加修炼 = true
        战斗单位[1]={
            名称="蚩尤",
            模型="进阶蚩尤",
            技能={"高级必杀","高级法术连击","高级法术暴击","鬼魂术"},
            主动技能={"武神怒击","刀光剑影","毁灭之光"}
        }
        战斗单位[2]={
            名称="厚土",
            模型="进阶持国巡守",
            饰品=true,
            技能={"高级必杀","高级法术连击","高级法术暴击"},
            主动技能=取随机法术新(18)
        }
        战斗单位[3]={
            名称="搻兹",
            模型="进阶毗舍童子",
            饰品=true,
            技能={"高级必杀","高级法术连击","高级法术暴击"},
            主动技能=取随机物理法术(13)
        }
        战斗单位[4]={
            名称="奢比尸",
            模型="进阶蜃气妖",
            饰品=true,
            技能={"高级必杀","高级法术连击","高级法术暴击"},
            主动技能=取随机法术新(18)
        }
         战斗单位[5]={
            名称="玄冥",
            模型="进阶真陀护法",
            饰品=true,
            技能={"高级必杀","高级法术连击","高级法术暴击"},
            主动技能=取随机物理法术(13)
        }
          战斗单位[6]={
            名称="强良",
            模型="进阶巨力神猿",
            饰品=true,
            技能={"高级必杀","高级法术连击","高级法术暴击"},
            主动技能=取随机物理法术(13)
        }
         战斗单位[7]={
            名称="祝融",
            模型="进阶凤凰",
            饰品=true,
            技能={"高级必杀","高级法术连击","高级法术暴击"},
            主动技能=取随机法术新(18)
        }
        战斗单位[8]={
            名称="共工",
            模型="进阶蛟龙",
            饰品=true,
            技能={"高级必杀","高级法术连击","高级法术暴击"},
            主动技能=取随机法术新(18)
        }
        战斗单位[9]={
            名称="蓐收",
            模型="进阶律法女娲",
            饰品=true,
            技能={"高级必杀","高级法术连击","高级法术暴击"},
            主动技能=取随机物理法术(13)
        }
        战斗单位[10]={
            名称="天昊",
            模型="进阶吸血鬼",
            饰品=true,
            技能={"高级必杀","高级法术连击","高级法术暴击"},
            主动技能=取随机物理法术(13)
        }
        return 战斗单位
end

function 战斗准备类:桃园野猪(任务id,玩家id)
        local 战斗单位={}
        战斗单位.等级 = 5
        战斗单位[1]={
            名称="大野猪",
            模型="野猪",
            技能={"高级必杀","高级法术暴击"},
            主动技能={"烟雨剑法","烈火"}
        }
          for n=2,3 do
          战斗单位[n]={
          名称="野猪"
          ,模型="野猪"
          ,技能={"高级必杀","高级法术暴击"}
          ,主动技能={"烈火"}
          }
          end
    return 战斗单位
end

function 战斗准备类:商人的鬼魂(任务id,玩家id)
        local 战斗单位={}
        战斗单位.等级=取队伍平均等级(玩家数据[玩家id].队伍,玩家id)+10
        战斗单位.阵法="天覆阵"  --阵法添加方式
        战斗单位[1]={
            名称="商人的鬼魂",
            模型="野鬼",
            技能={"高级毒","必杀","连击","高级鬼魂术","理直气壮"},
            主动技能={}
        }
        战斗单位[2]={
            名称="虾兵喽罗",
            模型="虾兵",
            技能={"高级必杀"},
            主动技能={"壁垒击破","惊心一剑"}
        }
        战斗单位[3]={
            名称="蟹将喽罗",
            模型="蟹将",
            技能={"感知"},
            主动技能={"水攻","靛沧海"}
        }
        战斗单位[4]={
            名称="巨蛙喽罗",
            模型="巨蛙",
            技能={"法术暴击"},
            主动技能={"水攻","推气过宫"}
        }
       战斗单位[5]={
            名称="大海龟喽罗",
            模型="大海龟",
            技能={"高级再生"},
            主动技能={"金刚护体","金刚护法","牛刀小试"}
        }
    return 战斗单位
end

function 战斗准备类:妖风战斗(任务id,玩家id)
        local 战斗单位={}
        战斗单位.等级= 25
        战斗单位.难度 = "中级"
        战斗单位.不加修炼 = true
        战斗单位[1]={
          名称="妖风",
          模型="吸血鬼",
          变异=true,
          技能={"高级毒","高级必杀","高级连击","理直气壮","苍鸾怒击","嗜血追击","高级吸血"},
          主动技能={}
        }
       return 战斗单位
end

function 战斗准备类:酒肉和尚真(任务id,玩家id)
          local 战斗单位={}
          战斗单位.等级= 40
          战斗单位[1]={
            名称="酒肉和尚",
            模型="雨师",
            变异=true,
            技能={"高级感知"},
            主动技能={"龙卷雨击","龙腾","二龙戏珠"}
          }
          for n=2,5 do
              战斗单位[n]={
                  名称="酒肉和尚帮凶",
                  模型="雨师",
                  等级=30,
                  技能={"高级感知"},
                  主动技能=取随机法术(26)
              }
          end
          return 战斗单位
end


function 战斗准备类:真刘洪(任务id,玩家id)
          local 战斗单位={}
          战斗单位.等级= 65
          战斗单位.难度 = "中级"
          战斗单位.不加修炼 = true
          战斗单位[1]={
              名称="刘洪",
              模型="护卫",
              技能={"高级必杀","高级感知"},
              主动技能={"烟雨剑法","后发制人","破釜沉舟","斩龙诀"}
          }
          战斗单位[2]={
              名称="李彪",
              模型="强盗",
              不可封印=true,
              技能={"高级必杀","高级感知","高级驱鬼"},
              主动技能={"阎罗令","判官令","百爪狂杀"}
          }
         return 战斗单位
end


function 战斗准备类:天兵飞剑(任务id,玩家id)
          local 战斗单位={}
          战斗单位.等级= 79
          战斗单位.难度 = "中级"
          战斗单位.不加修炼 = true
          战斗单位[1]={
              名称="天兵飞剑",
              模型="天兵",
              饰品=true,
              不可封印=true,
              技能={"高级必杀","高级感知","高级吸血","高级驱鬼","高级幸运"},
              主动技能={"翻江搅海","天崩地裂"}
          }
          战斗单位[2]={
            名称="蛟龙喽啰",
            模型="蛟龙",
            不可封印=true,
            技能={"高级法术连击","高级法术暴击","高级驱鬼","高级幸运"},
            主动技能={"水漫金山","龙卷雨击","龙腾"}
          }
          for n=3,5 do
              战斗单位[n]={
                  名称="天兵喽罗",
                  模型="天兵",
                  技能={"高级必杀","高级感知","高级驱鬼","高级幸运"},
                  主动技能={"天雷斩"}
              }
          end
          return 战斗单位
end


function 战斗准备类:假刘洪(任务id,玩家id)
          local 战斗单位={}
          战斗单位.等级= 55
          战斗单位.难度 = "中级"
          战斗单位.不加修炼 = true
          战斗单位[1]={
              名称="假刘洪",
              模型="护卫",
              变异=true,
              技能={"高级必杀","高级感知"},
              主动技能={"烟雨剑法","后发制人"}
          }
          for n=2,10 do
              战斗单位[n]={
                  名称="衙役",
                  模型="护卫",
                  技能={"高级必杀","高级感知"},
                  主动技能={"烟雨剑法","后发制人"}
              }
          end
          return 战斗单位
end


function 战斗准备类:蟹将军(任务id,玩家id)
          local 战斗单位={}
          战斗单位.等级= 65
          战斗单位.难度 = "中级"
          战斗单位.不加修炼 = true
          战斗单位[1]={
              名称="蟹将军",
              模型="蟹将",
              变异=true,
              不可封印=true,
              技能={"高级法术连击","高级法术暴击","高级法术波动","高级感知"},
              主动技能={"龙卷雨击","水漫金山","罗汉金钟","剑荡四方"}
          }
          for n=2,3 do
              战斗单位[n]={
                  名称="虾兵喽罗",
                  模型="虾兵",
                  等级=55,
                  不可封印=true,
                  技能={"高级必杀","高级反击","嗜血追击","高级连击","苍鸾怒击"},
                  主动技能={"烟雨剑法"}
              }
          end
          for n=4,5 do
                战斗单位[n]={
                    名称="蟹将喽罗",
                    模型="蟹将",
                    等级=55,
                    技能={},
                    主动技能={"失心符","落雷符","落魄符"}
                }
          end
          return 战斗单位
end

function 战斗准备类:幽冥鬼(任务id,玩家id)
          local 战斗单位={}
          战斗单位.等级= 55
          战斗单位.难度 = "中级"
          战斗单位.不加修炼 = true
          战斗单位[1]={
              名称="幽冥鬼",
              模型="巡游天神",
              饰品=true,
              不可封印=true,
              技能={"高级鬼魂术","高级吸血","高级感知"},
              主动技能={"判官令","阎罗令","尸腐毒","百爪狂杀"}
          }
          for n=2,5 do
              战斗单位[n]={
                  名称="僵尸喽罗",
                  模型="僵尸",
                  等级=50,
                  技能={"鬼魂术","高级反击","高级反震","高级吸血"},
                  主动技能={"弱点击破","破血狂攻","尸腐毒"}
              }
          end
          return 战斗单位
end

function 战斗准备类:白琉璃(任务id,玩家id)
          local 战斗单位={}
          战斗单位.等级= 35
          战斗单位.难度 = "中级"
          战斗单位.不加修炼 = true
          战斗单位[1]={
              名称="白琉璃",
              模型="星灵仙子",
              气血=100000,
              饰品=true,
              技能={},
              主动技能={"地涌金莲","推气过宫","生命之泉","普渡众生"}
          }
          for n=2,5 do
            战斗单位[n]={
                名称="狐狸精喽罗",
                模型="狐狸精",
                技能={},
                主动技能=取随机法术(26)
            }
          end
          return 战斗单位
end

function 战斗准备类:执法天兵(任务id,玩家id)
          local 战斗单位={}
          战斗单位.等级= 35
          战斗单位.难度 = "中级"
          战斗单位.不加修炼 = true
          战斗单位[1]={
              名称="执法天兵",
              模型="天兵",
              技能={},
              主动技能={"天雷斩","天诛地灭","镇妖"}
          }
          战斗单位[2]={
              名称="守门天兵",
              模型="天兵",
              技能={},
              主动技能={"破血狂攻","破碎无双","烟雨剑法","后发制人"}
          }
          战斗单位[3]={
              名称=" 守门天兵 ",
              模型="天兵",
              技能={},
              主动技能={"鹰击","连环击"}
          }
      战斗单位[4]={
          名称="守门天将",
          模型="天将",
          技能={},
          主动技能={"龙腾","龙卷雨击"}
      }
      战斗单位[5]={
          名称="守门天将",
          模型="天将",
          技能={},
          主动技能={"唧唧歪歪","推气过宫","达摩护体"}
      }
     return 战斗单位
end


function 战斗准备类:酒肉和尚假(任务id,玩家id)
          local 战斗单位={}
          战斗单位.等级= 35
          战斗单位.难度 = "中级"
          战斗单位.不加修炼 = true
          战斗单位[1]={
              名称="酒肉和尚",
              模型="雨师",
              技能={"高级魔之心","高级法术波动","高级法术暴击","高级法术连击"},
              主动技能={"龙卷雨击","龙腾","神龙摆尾"}
          }
          战斗单位[2]={
              名称="赌徒喽罗",
              模型="赌徒",
              技能={"高级毒","高级必杀","高级连击","理直气壮","苍鸾怒击","嗜血追击","高级吸血"},
              主动技能={"后发制人","反间之计","烟雨剑法"}
          }
          战斗单位[3]={
            名称="赌徒喽罗",
            模型="赌徒",
            技能={"高级法术连击","高级法术暴击"},
            主动技能={"唧唧歪歪","推气过宫","金刚护体","金刚护法"}
          }
          return 战斗单位
end


function 战斗准备类:白鹿精(任务id,玩家id)
          local 战斗单位={}
          战斗单位.等级= 30
          战斗单位.难度 = "中级"
          战斗单位.不加修炼 = true
          战斗单位.阵法="龙飞阵"  --阵法添加方式
          战斗单位[1]={
              名称="白鹿精",
              模型="赌徒",
              变异=true,
              技能={"高级必杀","高级吸血"},
              主动技能={"反间之计","烟雨剑法","后发制人"}
          }
          战斗单位[2]={
              名称="玉面狐狸",
              模型="狐狸精",
              技能={"高级法术连击","高级法术暴击"},
              主动技能={"天罗地网","含情脉脉","勾魂"}
          }
          for n=3,10 do
              战斗单位[n]={
                名称="花妖喽罗",
                模型="花妖",
                技能={},
                主动技能={"落岩","推气过宫"}
              }
          end
          return 战斗单位
end
    --local 武器造型={武器="九霄风雷",级别=160}
    --附加状态={[1]={等级=175,名称="天神护体"}},
            --套装加法  追加法术={[1]={等级=175,名称="XXX"}}
            --奇经八脉={风刃=1},   --加法  奇经八脉={XXX=1}
            --角色=true,
            --锦衣={[1]={名称="黑浪淘纱"}},
            -- 染色方案=3,
            --染色组={[1]=3,[2]=6,[3]=6,序号=3710},
            -- 武器=取武器数据(武器造型.武器,武器造型.级别),
            -- 武器染色组={[1]=1,[2]=0},
            -- 武器染色方案=20113,
            --门派="龙宫",
            --饰品=true,
            -- 攻击修炼=0,  --怪物修炼添加方式
            -- 防御修炼=0,  --怪物修炼添加方式
            -- 法术修炼=0,  --怪物修炼添加方式
            -- 抗法修炼=0,  --怪物修炼添加方式

-- 战斗配置
local 战斗配置 = {
    阵法数据 = {"八卦阵","天覆阵","龙飞阵","风扬阵","虎翼阵","云垂阵","鸟翔阵","地载阵","蛇蟠阵","鹰啸阵","雷绝阵","普通"},
    基础属性列表 = {"力量", "耐力", "敏捷", "体质", "魔力", "伤害", "气血", "魔法", "命中", "法伤", "法防", "速度", "防御", "最大气血", "最大魔法"},
    修炼属性列表 = {"攻击修炼", "防御修炼", "法术修炼", "抗法修炼"},
    召唤兽属性列表 = {"伤害", "魔法", "命中", "气血", "法伤", "法防", "速度", "防御", "最大气血", "最大魔法", "体质", "魔力", "力量", "耐力", "敏捷"},
    修炼映射 = {
        攻击修炼 = "攻击控制力",
        防御修炼 = "防御控制力", 
        法术修炼 = "法术控制力",
        抗法修炼 = "抗法控制力"
    },
    神兽选择 = {
        [1] = function() return 取一代神兽() end,
        [2] = function() return 取二代神兽() end,
        [3] = function() return 取三代神兽() end,
        [4] = function() return 取四代神兽() end
    }
}

function 战斗准备类:假人战斗(玩家id, 假人列表)
    -- 参数验证
    if not 玩家id or not 假人列表 or #假人列表 == 0 then
        print("[错误] 假人战斗参数无效")
        return {}
    end
    
    local 战斗单位 = {}
    
    -- 初始化战斗单位基础信息
    战斗单位.等级 = 取队伍平均等级(玩家数据[玩家id].队伍, 玩家id) + 5
    战斗单位.阵法 = 战斗配置.阵法数据[取随机数(1, #战斗配置.阵法数据)]
    
    -- 创建假人单位 (位置1-5)
    for n = 1, 5 do
        if n <= #假人列表 then
            -- 使用真实假人数据
            战斗单位[n] = self:创建假人单位(假人列表[n])
        else
            -- 假人不足，创建助战
            战斗单位[n] = self:创建随机助战(假人列表)
        end
    end
    
    -- 创建召唤兽单位 (位置6-10)
    for n = 6, 10 do
        local 随机假人 = 假人列表[取随机数(1, #假人列表)]
        战斗单位[n] = self:创建召唤兽单位(随机假人)
    end
    
    return 战斗单位
end

-- 创建假人单位
function 战斗准备类:创建假人单位(假人数据)
    -- 参数验证
    if not 假人数据 then
        print("[错误] 假人数据为空")
        return {}
    end
    
    local 单位 = {
        名称 = 假人数据.名称,
        模型 = 假人数据.模型,
        愤怒 = 99999,
        武器 = 取武器数据(假人数据.武器, 假人数据.武器级别),
        锦衣 = 假人数据.锦衣,
        染色方案 = 假人数据.染色方案,
        染色组 = 假人数据.染色组,
        角色 = true,
        饰品 = true,
        技能 = {"高级感知"},
        主动技能 = 假人数据.主动技能
    }
    
    -- 复制基础属性
    for _, 属性名 in ipairs(战斗配置.基础属性列表) do
        单位[属性名] = 假人数据[属性名] or 0
    end
    
    -- 复制修炼属性
    for _, 修炼名 in ipairs(战斗配置.修炼属性列表) do
        单位[修炼名] = 假人数据[修炼名] or 0
    end
    
    return 单位
end

-- 创建随机助战
function 战斗准备类:创建随机助战(假人列表)
    if #假人列表 == 0 then
        print("[错误] 假人列表为空，无法创建随机助战")
        return {}
    end
    
    local 随机假人 = 假人列表[取随机数(1, #假人列表)]
    local 助战单位 = self:创建假人单位(随机假人)
    助战单位.名称 = 助战单位.名称 .. "助战"
    return 助战单位
end

-- 创建召唤兽单位
function 战斗准备类:创建召唤兽单位(假人数据)
    if not 假人数据 then
        print("[错误] 假人数据为空")
        return {}
    end
    
    local 代数 = 取随机数(1, 4)
    local 召唤兽名称 = 战斗配置.神兽选择[代数]()
    
    print("[调试] 创建召唤兽单位，假人:", 假人数据.名称, "召唤兽:", 召唤兽名称)
    
    local 单位 = {
        名称 = 召唤兽名称 .. "宝宝",
        模型 = 召唤兽名称,
        技能 = {},
        主动技能 = {}
    }
    
    -- 如果有召唤兽数据，复制属性
    if 假人数据.召唤兽 then
        单位.技能 = 假人数据.召唤兽.被动技能 or {}
        单位.主动技能 = 假人数据.召唤兽.主动技能 or {}
        
        -- 复制召唤兽属性
        for _, 属性名 in ipairs(战斗配置.召唤兽属性列表) do
            单位[属性名] = 假人数据.召唤兽[属性名] or 0
        end
        
        -- 复制召唤兽修炼属性
        for 修炼名, 控制力名 in pairs(战斗配置.修炼映射) do
            单位[修炼名] = 假人数据.召唤兽[控制力名] or 0
        end
    else
        -- 没有召唤兽数据，使用默认属性
        print("[警告] 假人", 假人数据.名称, "没有召唤兽数据，使用默认属性")
        
        -- 设置默认召唤兽属性
        for _, 属性名 in ipairs(战斗配置.召唤兽属性列表) do
            单位[属性名] = 1000 -- 默认属性值
        end
        
        -- 设置默认修炼属性
        for 修炼名, _ in pairs(战斗配置.修炼映射) do
            单位[修炼名] = 10 -- 默认修炼值
        end
    end
    
    print("[调试] 召唤兽单位创建完成:", 单位.名称, "模型:", 单位.模型)
    return 单位
end

-- 创建召唤兽战斗单位 (如果需要单独创建召唤兽)
function 战斗准备类:创建召唤兽战斗单位(假人列表)
    local 战斗单位 = {}
    
    for n = 1, 5 do
        local 随机假人 = 假人列表[取随机数(1, #假人列表)]
        战斗单位[n] = self:创建召唤兽单位(随机假人)
    end
    
    return 战斗单位
end

-- 调试函数：显示战斗单位信息
function 战斗准备类:显示战斗单位信息(战斗单位)
    print("=== 战斗单位信息 ===")
    print("等级:", 战斗单位.等级)
    print("阵法:", 战斗单位.阵法)
    print("")
    
    -- 显示假人单位 (位置1-5)
    print("--- 假人单位 (位置1-5) ---")
    for i = 1, 5 do
        if 战斗单位[i] then
            print(string.format("位置%d: %s (%s)", i, 战斗单位[i].名称, 战斗单位[i].模型))
        else
            print(string.format("位置%d: 空", i))
        end
    end
    
    print("")
    -- 显示召唤兽单位 (位置6-10)
    print("--- 召唤兽单位 (位置6-10) ---")
    for i = 6, 10 do
        if 战斗单位[i] then
            print(string.format("位置%d: %s (%s)", i, 战斗单位[i].名称, 战斗单位[i].模型))
        else
            print(string.format("位置%d: 空", i))
        end
    end
    print("==================")
end

-- 验证战斗单位完整性
function 战斗准备类:验证战斗单位(战斗单位)
    local 错误信息 = {}
    
    -- 检查基础信息
    if not 战斗单位.等级 then
        table.insert(错误信息, "缺少等级信息")
    end
    if not 战斗单位.阵法 then
        table.insert(错误信息, "缺少阵法信息")
    end
    
    -- 检查假人单位 (位置1-5)
    for i = 1, 5 do
        if not 战斗单位[i] then
            table.insert(错误信息, "位置" .. i .. "缺少假人单位")
        elseif not 战斗单位[i].名称 then
            table.insert(错误信息, "位置" .. i .. "假人单位缺少名称")
        end
    end
    
    -- 检查召唤兽单位 (位置6-10)
    for i = 6, 10 do
        if not 战斗单位[i] then
            table.insert(错误信息, "位置" .. i .. "缺少召唤兽单位")
        elseif not 战斗单位[i].名称 then
            table.insert(错误信息, "位置" .. i .. "召唤兽单位缺少名称")
        end
    end
    
    if #错误信息 > 0 then
        print("[错误] 战斗单位验证失败:")
        for _, 错误 in ipairs(错误信息) do
            print("  - " .. 错误)
        end
        return false
    end
    
    return true
end

-- 测试召唤兽创建
function 战斗准备类:测试召唤兽创建(假人列表)
    print("=== 测试召唤兽创建 ===")
    
    if not 假人列表 or #假人列表 == 0 then
        print("[错误] 假人列表为空")
        return
    end
    
    for i = 1, math.min(3, #假人列表) do
        local 假人数据 = 假人列表[i]
        print("测试假人", i, ":", 假人数据.名称)
        print("  召唤兽数据:", 假人数据.召唤兽 and "存在" or "不存在")
        
        if 假人数据.召唤兽 then
            print("  召唤兽属性:")
            for _, 属性名 in ipairs(战斗配置.召唤兽属性列表) do
                print("    " .. 属性名 .. ":", 假人数据.召唤兽[属性名] or "nil")
            end
        end
        
        local 召唤兽单位 = self:创建召唤兽单位(假人数据)
        if 召唤兽单位 and 召唤兽单位.名称 then
            print("  创建成功:", 召唤兽单位.名称, "模型:", 召唤兽单位.模型)
        else
            print("  创建失败")
        end
        print("")
    end
    
    print("=== 测试完成 ===")
end

function 战斗准备类:取门派乾坤袋信息(任务id,玩家id)
          local 战斗单位={}
          战斗单位.等级=取队伍平均等级(玩家数据[玩家id].队伍,玩家id)+5
          战斗单位.名称组={任务数据[任务id].名称}
          战斗单位.模型组={任务数据[任务id].模型}
          return 战斗单位
end



function 战斗准备类:取门派示威信息(任务id,玩家id)
          local 战斗单位={}
          战斗单位.等级=取队伍平均等级(玩家数据[玩家id].队伍,玩家id)+5
          战斗单位[1]={
            名称=任务数据[任务id].名称,
            模型=任务数据[任务id].模型,
            武器=取武器数据(任务数据[任务id].武器,任务数据[任务id].武器等级),
            角色=true,
            技能={"高级感知"},
            主动技能=Q_门派法术[任务数据[任务id].门派],
          }
        local 模型=取随机怪(30,战斗单位.等级)
        战斗单位[2]={
            名称="帮凶",
            模型=模型[2],
            技能={"高级感知"},
            主动技能=取随机法术(3),
        }
        return 战斗单位
end
function 战斗准备类:取门派支援信息(任务id,玩家id)
          local 战斗单位={}
          local 范围={"人","魔","仙"}
          if 玩家数据[玩家id].角色.数据.种族=="人" then
              范围={"魔","仙"}
          elseif 玩家数据[玩家id].角色.数据.种族=="魔" then
                  范围={"人","仙"}
          elseif 玩家数据[玩家id].角色.数据.种族=="仙" then
                  范围={"魔","人"}
          end
          模型范围=模型范围[取随机数(1,2)]
          local 模型=""
          if 范围=="人" then
              模型=Q_随机模型[取随机数(1,5)]
          elseif 范围=="仙" then
                  模型=Q_随机模型[取随机数(6,10)]
          elseif 范围=="魔" then
                  模型=Q_随机模型[取随机数(11,15)]
          end
          战斗单位.等级=取队伍平均等级(玩家数据[玩家id].队伍,玩家id)+5
          战斗单位[1]={
              名称="敌人",
              模型=模型,
              角色=true,
              不可封印=true,
              主动技能={}
          }
          return 战斗单位
end




function 战斗准备类:取门派巡逻信息(任务id,玩家id)
            local 战斗单位={}
            战斗单位.等级= 取队伍平均等级(玩家数据[玩家id].队伍,玩家id)-5
            local 模型=取随机怪(1,战斗单位.等级)
            战斗单位.名称组={"捣乱的"..模型[2]}
            战斗单位.模型组={模型[2]}
            模型=取随机怪(1,战斗单位.等级)
            战斗单位.名称组[2]=模型[2].."帮凶"
            战斗单位.模型组[2]=模型[2]
            return 战斗单位
end




function 战斗准备类:木桩伤害测试(任务id,玩家id)
            local 战斗单位={}
            战斗单位.等级=1
            for n=1,10 do
              战斗单位[n]={
                名称="木桩",
                模型="木桩",
                气血=99999999999999,
                防御=1,
                法防=1,
                技能={},
                主动技能={},
                类型="测试"
              }
            end
            return 战斗单位
end




return 战斗准备类