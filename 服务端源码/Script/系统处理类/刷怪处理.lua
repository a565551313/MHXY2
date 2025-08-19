local 刷怪处理 = class()
local 星期=  os.date("%w")

function 刷怪处理:初始化(id)
  -- self.数据={}
end

function 刷怪处理:开启周一宝藏山()
 local 星期=  os.date("%w")
    if 星期=="1"  then
     任务处理类:开启宝藏山()
  end
end

function 刷怪处理:关闭宝藏山()
 -- local 星期=  os.date("%w")
 --    if 星期=="1"  then
    宝藏山数据.开关=false
    广播消息({内容="#G/宝藏山活动已经结束，处于场景内的玩家将被自动传送出场景。",频道="xt"})
    地图处理类:清除地图玩家(5001,1226,115,15)
 -- end
end


function 刷怪处理:开启周一迷宫()
 local 星期=  os.date("%w")
    if 星期=="1"  then
     任务处理类:开启迷宫()
  end
end

function 刷怪处理:关闭周一迷宫()
 local 星期=  os.date("%w")
    if 星期=="1"  then
    迷宫数据.开关=false
    广播消息({内容="#G/迷宫活动已经结束",频道="xt"})
  end
end

function 刷怪处理:开启周二镖王()
 local 星期=  os.date("%w")
    if 星期=="2"  then

     任务处理类:开启镖王活动()
  end
end


function 刷怪处理:关闭周二镖王()
 local 星期=  os.date("%w")
    if 星期=="2"  then
      for n, v in pairs(战斗准备类.战斗盒子) do
        if 战斗准备类.战斗盒子[n].战斗类型==100025 then
          战斗准备类.战斗盒子[n]:结束战斗处理(0,0,1)
        end
      end
      for n, v in pairs(玩家数据) do
        if 玩家数据[n].角色:取任务(208)~=0 then
          玩家数据[n].角色:取消任务(玩家数据[n].角色:取任务(208))
          常规提示(n,"#Y你的镖王任务已经被自动取消")
        end
      end
      for n, v in pairs(任务数据) do
        if 任务数据[n].类型==208 then
          local id=任务数据[n].玩家id
          任务数据[n]=nil
        end
      end
      镖王活动.开关=false
     广播消息({内容="#G/镖王活动已经结束",频道="xt"})

  end
end


function 刷怪处理:开启周五宝藏山()
 local 星期=  os.date("%w")
    if 星期=="5"  then
     任务处理类:开启宝藏山()
  end
end

function 刷怪处理:关闭周五宝藏山()
 local 星期=  os.date("%w")
    if 星期=="5"  then
    宝藏山数据.开关=false
    广播消息({内容="#G/宝藏山活动已经结束，处于场景内的玩家将被自动传送出场景。",频道="xt"})
    地图处理类:清除地图玩家(5001,1226,115,15)
  end
end

function 刷怪处理:开启周五门派闯关()
 local 星期=  os.date("%w")
    if 星期=="5"  then
       任务处理类:开启门派闯关()
  end
end

function 刷怪处理:关闭周五门派闯关()

   local 星期=  os.date("%w")
    if 星期=="5" then
    闯关参数={开关=false,起始=0,记录={}}
    广播消息({内容="#G/十五门派闯关活动已经结束，已处战斗中的玩家在战斗结束后依然可以获得奖励。",频道="xt"})
    end
    for n, v in pairs(战斗准备类.战斗盒子) do
      if 战斗准备类.战斗盒子[n].战斗类型==100011 then
        战斗准备类.战斗盒子[n]:结束战斗处理(0,0,1)
      end
    end
    for n, v in pairs(玩家数据) do
      if 玩家数据[n].管理==nil and 玩家数据[n].角色:取任务(107)~=0 then
        玩家数据[n].角色:取消任务(玩家数据[n].角色:取任务(107))
        常规提示(n,"你的闯关任务已经被自动取消")
      end
    end
    for n, v in pairs(任务数据) do
      if 任务数据[n]~=nil and 任务数据[n].类型 == 107 then
        任务数据[n]=nil
      end
    end
end





function 刷怪处理:开启周六镖王()
 local 星期=  os.date("%w")
    if 星期=="6"  then

     任务处理类:开启镖王活动()
  end
end


function 刷怪处理:关闭周六镖王()
 local 星期=  os.date("%w")
    if 星期=="6"  then
      for n, v in pairs(战斗准备类.战斗盒子) do
        if 战斗准备类.战斗盒子[n].战斗类型==100025 then
          战斗准备类.战斗盒子[n]:结束战斗处理(0,0,1)
        end
      end
      for n, v in pairs(玩家数据) do
        if 玩家数据[n].角色:取任务(208)~=0 then
          玩家数据[n].角色:取消任务(玩家数据[n].角色:取任务(208))
          常规提示(n,"#Y你的镖王任务已经被自动取消")
        end
      end
      for n, v in pairs(任务数据) do
        if 任务数据[n].类型==208 then
          local id=任务数据[n].玩家id
          任务数据[n]=nil
        end
      end
      镖王活动.开关=false
     广播消息({内容="#G/镖王活动已经结束",频道="xt"})

  end
end

function 刷怪处理:开启周六剑会()
 local 星期=  os.date("%w")
    if 星期=="6"  then
      游戏活动类:开启剑会天下()
  end
end
function 刷怪处理:关闭周六剑会()
 local 星期=  os.date("%w")
    if 星期=="6"  then
      游戏活动类:关闭剑会天下()
  end
end







function 刷怪处理:开启周日门派闯关()
 local 星期=  os.date("%w")
    if 星期=="7" or  星期=="0" then
       任务处理类:开启门派闯关()
  end
end

function 刷怪处理:关闭周日门派闯关()

   local 星期=  os.date("%w")
    if 星期=="7" or  星期=="0" then
    闯关参数={开关=false,起始=0,记录={}}
    广播消息({内容="#G/十五门派闯关活动已经结束，已处战斗中的玩家在战斗结束后依然可以获得奖励。",频道="xt"})
    end
    for n, v in pairs(战斗准备类.战斗盒子) do
      if 战斗准备类.战斗盒子[n].战斗类型==100011 then
        战斗准备类.战斗盒子[n]:结束战斗处理(0,0,1)
      end
    end
    for n, v in pairs(玩家数据) do
      if 玩家数据[n].管理==nil and 玩家数据[n].角色:取任务(107)~=0 then
        玩家数据[n].角色:取消任务(玩家数据[n].角色:取任务(107))
        常规提示(n,"你的闯关任务已经被自动取消")
      end
    end
    for n, v in pairs(任务数据) do
      if 任务数据[n]~=nil and 任务数据[n].类型 == 107 then
        任务数据[n]=nil
      end
    end
end

return 刷怪处理