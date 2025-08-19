--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-19 05:38:00
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 队伍处理类 = class()

function 队伍处理类:初始化()end
function 队伍处理类:数据处理(连接id,序号,id,内容)
  if 玩家数据[id].摊位数据~=nil then return  end
  if 序号==4001 then
    if 玩家数据[id].队伍==0 then
        发送数据(连接id,4001)
    else
        self:索取队伍信息(id,4002)
    end
  elseif 序号==4002 then --创建、加入队伍
  	self:创建队伍(id,内容)


  elseif 序号==4003 then
    if 玩家数据[id].队长 then
        self:索取申请信息(连接id,id)
    else
      常规提示(id,"只有队长才可进行此操作")
    end
  elseif 序号==4004 then --同意加入队伍

    if 玩家数据[id].队长 then
       self:同意入队(id,内容)
    else
      常规提示(id,"只有队长才可进行此操作")
    end
  elseif 序号==4005 and 玩家数据[id].队长 then --删除申请列表
    --self:创建队伍(id,内容)
    if 玩家数据[队伍数据[玩家数据[id].队伍].申请数据[内容.序列].id]~=nil then
      常规提示(队伍数据[玩家数据[id].队伍].申请数据[内容.序列].id,取名称(id).."拒绝了你的入队申请")
    end
    table.remove(队伍数据[玩家数据[id].队伍].申请数据,内容.序列)
    发送数据(玩家数据[id].连接id,4011,队伍数据[玩家数据[id].队伍].申请数据)
  elseif 序号==4006 then --同意加入队伍
    self:退出队伍(id)
  elseif 序号==4007  then
    if 玩家数据[id].队长 then
      local 临时id=队伍数据[玩家数据[id].队伍].成员数据[内容.序列]
      if id==临时id and 内容.序列 == 1 then
        常规提示(id,"您不能将自己请离队伍")
        return
      else
        常规提示(临时id,"你被队长请离了队伍")
        self:退出队伍(临时id)
      end
    else
      常规提示(id,"只有队长才可进行此操作")
    end
  elseif 序号==4008  then
    if 玩家数据[id].队长 then
      发送数据(连接id,4013,玩家数据[id].角色.数据.阵法)
    else
      常规提示(id,"只有队长才可进行此操作")
    end
  elseif 序号==4009 then
    if 玩家数据[id].队长==false then
        常规提示(id,"只有队长才可进行更换阵法")
        return
    elseif 内容.名称 == "八卦阵" then
        -- 特殊处理八卦阵
        if not 玩家数据[id].角色.数据.高级阵法 or not 玩家数据[id].角色.数据.高级阵法.八卦阵 then
            常规提示(id,"您尚未学会八卦阵")
            return
        else
            local 队伍id = 玩家数据[id].队伍
            队伍数据[队伍id].阵型 = "八卦阵"
            for n=1,#队伍数据[队伍id].成员数据 do
                self:索取队伍信息(队伍数据[队伍id].成员数据[n],4004)
            end
            常规提示(id,"更改为"..内容.名称.."阵法成功！")
        end
    elseif 玩家数据[id].角色.数据.阵法[内容.名称]==nil then
        常规提示(id,"您尚未学会如何使用"..内容.名称.."阵法")

        return
    else
        -- 现有阵法处理逻辑
        local 队伍id = 玩家数据[id].队伍
        队伍数据[队伍id].阵型 = 内容.名称
        for n=1,#队伍数据[队伍id].成员数据 do
            self:索取队伍信息(队伍数据[队伍id].成员数据[n],4004)
        end
        常规提示(id,"更改为"..内容.名称.."阵法成功！")
    end
  elseif 序号==4010  then
    if 玩家数据[id].队长 then
      local 临时id=队伍数据[玩家数据[id].队伍].成员数据[内容.序列]
      if id==临时id then
        常规提示(id,"您不能将自己提升为队长")
        return
      elseif 玩家数据[临时id].子角色操作~=nil then
        常规提示(id,"该角色无法成为队长")
        return
      else
        队伍数据[玩家数据[id].队伍].新队长.开关=true
        队伍数据[玩家数据[id].队伍].新队长.id=临时id
        self.发送数据={}
        self.发送数据.模型=玩家数据[id].角色.数据.模型
        self.发送数据.名称=玩家数据[id].角色.数据.名称
        self.发送数据.对话=玩家数据[id].角色.数据.名称.."要把你提升为队长,你是否答应期要求?#94"
        self.发送数据.选项={"我同意当队长","我果断拒绝!"}
        发送数据(玩家数据[临时id].连接id,1501,self.发送数据)
      end
    else
      常规提示(id,"只有队长才可进行此操作")
    end
  elseif 序号==4011  then
    local 临时id=队伍数据[玩家数据[id].队伍].成员数据[内容.序列]
    if id==临时id then
      常规提示(id,"您不能查看自己!")
      return
    else
      local 查找数据=self:查找角色("",临时id)
      if 查找数据~=nil then
        发送数据(玩家数据[id].连接id,4015,查找数据)
       return
      else
        常规提示(id,"#Y这个角色并不存在或当前没有在线")
      end
    end
  elseif 序号==4012 then --同意加入队伍
        if 玩家数据[id].队长 then
          if 内容.序列==nil or #内容.序列~=2 then
            常规提示(id,"错误数据!")
            return
          elseif 内容.序列[1]+0>内容.序列[2]+0 then
            常规提示(id,"最低等级不能比最高等级低噢!")
            return
          end
          if 内容.序列[2]+0>175 then
            内容.序列[2]=175
          end
          队伍数据[玩家数据[id].队伍].限制等级[1]=内容.序列[1]+0
          队伍数据[玩家数据[id].队伍].限制等级[2]=内容.序列[2]+0
          常规提示(id,"设置成功!")
        else
          常规提示(id,"只有队长才可进行此操作")
        end
  elseif 序号 == 4013 then --更换队员位置
        if 玩家数据[id].队长 then
            local 临时id=队伍数据[玩家数据[id].队伍].成员数据[内容.序列]
            if id==临时id and 内容.序列 == 1 then
              常规提示(id,"您不能更换自己的位置")
              return
            elseif 内容.序列 ~= 1 and id == 临时id then
              self:更换位置(id,内容,1)
            elseif 内容.目标 ~= 1 and 队伍数据[玩家数据[id].队伍].成员数据[内容.目标] == id then
              self:更换位置(id,内容,1)
            else
               self:更换位置(id,内容)
            end
        else
          常规提示(id,"只有队长才可进行此操作")
        end

   elseif 序号==4014 then --对方没队伍的情况
      local 对方id = 内容.id+0
      if not 玩家数据[对方id] then
           常规提示(id,"#Y对方不在线")
          return
      end
      if 玩家数据[id].队伍==0 then
        if 玩家数据[id].角色.数据.地图数据.编号==6003 then
          常规提示(id,"#Y当前地图无法创建队伍")
          return
        end
        if 玩家数据[id].角色.数据.地图数据.编号==6004 and not 英雄大会:是否同组(id,对方id) then
           发送数据(玩家数据[id].连接id,7,"#Y/不是同组玩家无法操作")
           return
        end
        队伍数据[id]={成员数据={[1]=id},申请数据={},阵型="普通",限制等级={0,175},新队长={开关=false,id=0}}
        玩家数据[id].队长=true
        玩家数据[id].队伍=id
        self:索取队伍信息(id,4004)
        发送数据(玩家数据[id].连接id,4006)
        地图处理类:更改队伍图标(id,true)
        常规提示(id,"组队成功，你现在是队长了。")
        常规提示(id,"你已邀请"..玩家数据[对方id].角色.数据.名称.."加入队伍，请等待对方回应^^")
        发送数据(玩家数据[对方id].连接id,4018,{队长id=id,等级=玩家数据[id].角色.数据.等级,名称=玩家数据[id].角色.数据.名称,模型=玩家数据[id].角色.数据.模型,邀请id=id,状态="邀请入队"}) --发送邀请数据
      else
        if not 队伍数据[id] then
            return
        end
        if 玩家数据[对方id].队伍~=0 then--自己和对方都有队伍
          常规提示(id,"对方已经有了一个队伍了")
            return
        end
        for n=1,#队伍数据[id].成员数据 do
          if 队伍数据[id].成员数据[n]==对方id then
            return
          end
        end
        if 玩家数据[id].角色.数据.地图数据.编号==6004 and not 英雄大会:是否同组(id,对方id) then
           发送数据(玩家数据[id].连接id,7,"#Y/不是同组玩家无法操作")
           return
        end
        常规提示(id,"你已邀请"..玩家数据[对方id].角色.数据.名称.."加入队伍，请等待对方回应^^")
        发送数据(玩家数据[对方id].连接id,4018,{队长id=玩家数据[id].队伍,等级=玩家数据[id].角色.数据.等级,名称=玩家数据[id].角色.数据.名称,模型=玩家数据[id].角色.数据.模型,邀请id=id,状态="邀请入队"}) --发送邀请数据
      end

 elseif 序号==4015 then --直接进组
    local 队伍id = 内容.队伍id+0
    local 邀请id = 内容.邀请id+0
    if 玩家数据[id].队伍~=0 then
      常规提示(id,"#Y/你已经有了一个队伍了")
      return
    end
    if 玩家数据[id].角色.数据.地图数据.编号==6004 and not 英雄大会:是否同组(id,队伍id) then
       发送数据(玩家数据[id].连接id,7,"#Y/不是同组玩家无法操作")
       return
    end
    if 玩家数据[队伍id] then
      if 玩家数据[队伍id].队伍~=0 then
         if #队伍数据[队伍id].成员数据>=5 then
            常规提示(id,"#Y/对方队伍已满")
            return
         end
        for n=1,#队伍数据[队伍id].成员数据 do
          if 队伍数据[队伍id].成员数据[n]==id then
            return
          end
        end
        if 玩家数据[队伍id].战斗~=0 then
          常规提示(id,"#Y/对方正在战斗中")
          return
        elseif 玩家数据[队伍id].摊位数据~=nil then
          常规提示(id,"#Y/对方目前无法加入队伍")
          return
        end
        local 角色xy={x=x,y=y}
        local 对方xy={x=0,y=0}
        对方xy.x,对方xy.y=玩家数据[队伍id].角色.数据.地图数据.x,玩家数据[队伍id].角色.数据.地图数据.y
        角色xy.x,角色xy.y=玩家数据[id].角色.数据.地图数据.x,玩家数据[id].角色.数据.地图数据.y
        if 取两点距离(对方xy,角色xy)>=500 then
          常规提示(id,"对方离你太远了~")
          return
        elseif #队伍数据[队伍id].成员数据>=5 then
          常规提示(id,"队伍人数已满！")
          return
        end
        发送数据(玩家数据[id].连接id,4011,队伍数据[队伍id].申请数据)
        发送数据(玩家数据[id].连接id,1001,{x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20)})
        local 地图编号=玩家数据[id].角色.数据.地图数据.编号
        for i, v in pairs(地图处理类.地图玩家[地图编号]) do
          if i~=id and 玩家数据[i] then
            发送数据(玩家数据[i].连接id,1008,{数字id=id,路径={数字id=id,x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20)}})
          end
        end
        队伍数据[队伍id].成员数据[#队伍数据[队伍id].成员数据+1]=id
        玩家数据[id].队伍=队伍id
        玩家数据[id].队长=false
        if 玩家数据[邀请id] and 玩家数据[邀请id].队伍==队伍id then
            常规提示(邀请id,"#R"..玩家数据[id].角色.数据.名称.."#Y同意了你的邀请")
        end

        for n=1,#队伍数据[队伍id].成员数据 do
          self:索取队伍信息(队伍数据[队伍id].成员数据[n],4004)
        end
         if 玩家数据[队伍id].角色.数据.飞行 and self:检查飞行(id)  then
              玩家数据[id].角色.数据.飞行 =true
              发送数据(玩家数据[id].连接id,71)
              地图处理类:更新飞行(id,true)
         end
        常规提示(id,"你已经被同意加入队伍")
      else
        常规提示(id,"该队伍已经解散了")
      end
    end
 elseif 序号==4016 then --同意加入队伍
    if 玩家数据[id].队长 then
       self:申请同意入队(id,内容)
    else
        常规提示(id,"只有队长才可进行此操作")
    end
  elseif 序号==4017 then --邀请拒绝
      local 队伍id = 内容.队伍id+0
      if 玩家数据[队伍id] and 玩家数据[队伍id].队伍~=0  and 玩家数据[队伍id].队长 then
          常规提示(队伍id,"#R"..玩家数据[id].角色.数据.名称.."#Y拒绝了你的邀请")
      end
    elseif 序号==4018 and 玩家数据[id] and 玩家数据[id].队长 then --删除申请列表
           local 对方id = 内容.对方id+0
           local 申请序列 = 0
            for i,v in pairs(队伍数据[玩家数据[id].队伍].申请数据) do
               if 内容.对方id ==v.id then
                  申请序列 = i
               end
            end
            if 玩家数据[对方id]~=nil then
                常规提示(对方id,取名称(id).."拒绝了你的入队申请")
            end
            if 申请序列~= 0 then
                table.remove(队伍数据[玩家数据[id].队伍].申请数据,申请序列)
                发送数据(玩家数据[id].连接id,4011,队伍数据[玩家数据[id].队伍].申请数据)
            end






  end
end

function 队伍处理类:查找角色(名称,id)
  local 数据组={}
  if id~="" then id=id+0 end
  for i, v in pairs(玩家数据) do
    if 玩家数据[i].管理==nil and 玩家数据[i].角色.数据.名称==名称 or i==id then
      数据组.名称=玩家数据[i].角色.数据.名称
      数据组.等级=玩家数据[i].角色.数据.等级
      数据组.门派=玩家数据[i].角色.数据.门派
      数据组.称谓=玩家数据[i].角色.数据.当前称谓
      数据组.模型=玩家数据[i].角色.数据.模型
      数据组.帮派=玩家数据[i].角色.数据.帮派
      数据组.id=玩家数据[i].角色.数据.数字id
    end
  end
  return 数据组
end

function 队伍处理类:退出队伍(id,重组,多角色)
  if 玩家数据[id].战斗~=0 then
    常规提示(id,"#Y战斗中不允许进行此操作！")
    return
  end
  -- if 玩家数据[id].角色.数据.地图数据.编号>=6009 and 玩家数据[id].角色.数据.地图数据.编号<=6018 then
  -- 常规提示(id,"#Y当前地图无法退出队伍")
  -- return
  -- end
  local 队伍id=	玩家数据[id].队伍
  if 队伍id==0 or 队伍数据[队伍id]==nil then
    玩家数据[id].队伍=0
    return
  end
  if 玩家数据[id].队长 then
          if 重组==nil or (重组~=nil and 重组~="关闭") then
            广播队伍消息(队伍id,"本队伍已经被队长解散")
          end
          -- for n=1,#队伍数据[队伍id].成员数据 do
          --   if 玩家数据[队伍数据[队伍id].成员数据[n]]~=nil then
          --      玩家数据[队伍数据[队伍id].成员数据[n]].队伍=0
          --     发送数据(玩家数据[队伍数据[队伍id].成员数据[n]].连接id,4012)
          --   end
          -- end

           for n=1,#队伍数据[队伍id].成员数据 do
            if 玩家数据[队伍数据[队伍id].成员数据[n]]~=nil then
              玩家数据[队伍数据[队伍id].成员数据[n]].队伍=0
              if 玩家数据[队伍数据[队伍id].成员数据[n]].连接id ~= nil then
                发送数据(玩家数据[队伍数据[队伍id].成员数据[n]].连接id,4012)
              end
            end
          end
        if 玩家数据[id].角色.数据.多角色操作 and not 多角色 then
          local 填入内容={参数=id,文本="一键退出"}
          多开系统类:切换角色(id,填入内容)
        end
        玩家数据[id].队长=false
        地图处理类:更改队伍图标(id)
        发送数据(玩家数据[id].连接id,4008)
        发送数据(玩家数据[id].连接id,114)
  else
      local 队员序列=0
      for n=1,#队伍数据[队伍id].成员数据 do
        if id==队伍数据[队伍id].成员数据[n] then
          队员序列=n
        end
      end
      广播队伍消息(队伍id,取名称(id).."离开了队伍")
      table.remove(队伍数据[玩家数据[id].队伍].成员数据,队员序列)
      玩家数据[id].队伍=0
      if 玩家数据[id].连接id~=nil then
        发送数据(玩家数据[id].连接id,4012)
      end
      if 玩家数据[id].子角色操作~=nil then
         多开系统类:断开游戏(id)
      end
      if #队伍数据[队伍id].成员数据==1 then
           if 玩家数据[队伍数据[队伍id].成员数据[1]].角色.数据.多角色操作  then
              local 填入内容={参数=队伍数据[队伍id].成员数据[1],文本="一键退出"}
              多开系统类:切换角色(队伍数据[队伍id].成员数据[1],填入内容)
          end
          self:索取队伍信息(队伍数据[队伍id].成员数据[1],4004)
      else
          for n=1,#队伍数据[队伍id].成员数据 do
            self:索取队伍信息(队伍数据[队伍id].成员数据[n],4004)
          end
      end

  end
end

function 队伍处理类:更换位置(id,内容)
  if 内容.目标 == 1 then
      常规提示(id,"#Y无法替换队长的位置!!")
  else
    local 选中id=队伍数据[玩家数据[id].队伍].成员数据[内容.序列]
    local 目标id=队伍数据[玩家数据[id].队伍].成员数据[内容.目标]
    队伍数据[玩家数据[id].队伍].成员数据[内容.目标] = 选中id
    队伍数据[玩家数据[id].队伍].成员数据[内容.序列] = 目标id
    for n=1,#队伍数据[玩家数据[id].队伍].成员数据 do
      self:索取队伍信息(队伍数据[玩家数据[id].队伍].成员数据[n],4004)
    end
  end
end


function 队伍处理类:申请同意入队(id,内容,重组)



    local 申请序列 = 0
    for i,v in pairs(队伍数据[玩家数据[id].队伍].申请数据) do
       if 内容.对方id ==v.id then
          申请序列 = i
       end
    end
    if 申请序列==0 then
      常规提示(id,"#Y/对方不在申请列表")
      local 重排数据 = {}
      for i,v in pairs(队伍数据[玩家数据[id].队伍].申请数据) do
        table.insert(重排数据,队伍数据[玩家数据[id].队伍].申请数据[i])
      end
      队伍数据[玩家数据[id].队伍].申请数据 = 重排数据
      发送数据(玩家数据[id].连接id,4011,队伍数据[玩家数据[id].队伍].申请数据)
      常规提示(id,"#Y/该玩家申请入队数据错误请重新入队申请")
      return
  end

  if 队伍数据[玩家数据[id].队伍].申请数据[申请序列] == nil then
    local 重排数据 = {}
    for i,v in pairs(队伍数据[玩家数据[id].队伍].申请数据) do
      table.insert(重排数据,队伍数据[玩家数据[id].队伍].申请数据[i])
    end
    队伍数据[玩家数据[id].队伍].申请数据 = 重排数据
    发送数据(玩家数据[id].连接id,4011,队伍数据[玩家数据[id].队伍].申请数据)
    常规提示(id,"#Y/该玩家申请入队数据错误请重新入队申请")
    return
  end
  local 对方id=内容.对方id+0
  local 是否清除=false
  local 队伍id= 玩家数据[id].队伍
  if 玩家数据[对方id]==nil then
    常规提示(id,"#Y/这个玩家当前不在线")
    是否清除=true
  elseif 玩家数据[对方id].队伍~=0 then
    常规提示(id,"#Y/对方已经加入了其它队伍")
    是否清除=true
  elseif 玩家数据[对方id].战斗~=0 then
    常规提示(id,"#Y/对方正在战斗中")
    return
  elseif 玩家数据[对方id].摊位数据~=nil then
    常规提示(id,"#Y/对方目前无法加入队伍")
    是否清除=true
  end
  if 玩家数据[id].角色.数据.地图数据.编号==6004 and not 英雄大会:是否同组(id,对方id) then
     发送数据(玩家数据[id].连接id,7,"#Y/不是同组玩家无法操作")
     是否清除=true
  end



  if 玩家数据[id].角色.数据.地图数据.编号==6010 and 玩家数据[id].角色.数据.帮派数据.编号>0 and 玩家数据[id].角色.数据.帮派数据.编号~=玩家数据[对方id].角色.数据.帮派数据.编号 then
    常规提示(id,"#Y/当前地图无法组队其他帮派成员")
    是否清除=true
  end
  for n=1,#队伍数据[队伍id].成员数据 do
    if 队伍数据[队伍id].成员数据[n]==对方id then
      常规提示(id,"#Y/对方已经在队伍中了")
      是否清除=true
    end
  end
  if 是否清除 then
    table.remove(队伍数据[玩家数据[id].队伍].申请数据,申请序列)
    发送数据(玩家数据[id].连接id,4011,队伍数据[队伍id].申请数据)
    return
  end
  local 角色xy={x=0,y=0}
  local 对方xy={x=0,y=0}
  对方xy.x,对方xy.y=玩家数据[对方id].角色.数据.地图数据.x,玩家数据[对方id].角色.数据.地图数据.y
  角色xy.x,角色xy.y=玩家数据[id].角色.数据.地图数据.x,玩家数据[id].角色.数据.地图数据.y
  if 取两点距离(对方xy,角色xy)>=500 then
    常规提示(id,"对方离你太远了~")
    return
  elseif #队伍数据[队伍id].成员数据>=5 then
    常规提示(id,"队伍人数已满！")
    return
  end
  table.remove(队伍数据[玩家数据[id].队伍].申请数据,申请序列)
  发送数据(玩家数据[id].连接id,4011,队伍数据[队伍id].申请数据)
  发送数据(玩家数据[对方id].连接id,1001,{x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20),})
  local 地图编号=玩家数据[id].角色.数据.地图数据.编号
  for i, v in pairs(地图处理类.地图玩家[地图编号]) do
    if i~=对方id and 玩家数据[i]  then
      发送数据(玩家数据[i].连接id,1008,{数字id=对方id,路径={数字id=对方id,x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20),}})
    end
  end
  队伍数据[队伍id].成员数据[#队伍数据[队伍id].成员数据+1]=对方id
  玩家数据[对方id].队伍=队伍id
  玩家数据[对方id].队长=false
  if 玩家数据[id].角色.数据.飞行 and self:检查飞行(对方id)  then
      玩家数据[对方id].角色.数据.飞行 =true
      发送数据(玩家数据[对方id].连接id,71)
      地图处理类:更新飞行(对方id,true)
  end
  if 重组==nil or (重组~=nil and 重组~="关闭") then
    广播队伍消息(队伍id,取名称(对方id).."加入了队伍")
  end
  for n=1,#队伍数据[队伍id].成员数据 do
    self:索取队伍信息(队伍数据[队伍id].成员数据[n],4004)
  end
end



function 队伍处理类:同意入队(id,内容,重组)

  if 队伍数据[玩家数据[id].队伍].申请数据[内容.序列] == nil then
    local 重排数据 = {}
    for i,v in pairs(队伍数据[玩家数据[id].队伍].申请数据) do
      table.insert(重排数据,队伍数据[玩家数据[id].队伍].申请数据[i])
    end
    队伍数据[玩家数据[id].队伍].申请数据 = 重排数据
    发送数据(玩家数据[id].连接id,4011,队伍数据[玩家数据[id].队伍].申请数据)
    常规提示(id,"#Y/该玩家申请入队数据错误请重新入队申请")
    return
  end
  local 对方id=队伍数据[玩家数据[id].队伍].申请数据[内容.序列].id
  local 是否清除=false
  local 队伍id=	玩家数据[id].队伍
  if 玩家数据[对方id]==nil then
    常规提示(id,"#Y/这个玩家当前不在线")
    是否清除=true
  elseif 玩家数据[对方id].队伍~=0 then
    常规提示(id,"#Y/对方已经加入了其它队伍")
    是否清除=true
  elseif 玩家数据[对方id].战斗~=0 then
    常规提示(id,"#Y/对方正在战斗中")
    return
  elseif 玩家数据[对方id].摊位数据~=nil then
    常规提示(id,"#Y/对方目前无法加入队伍")
    是否清除=true
  end
  if 玩家数据[id].角色.数据.地图数据.编号==6004 and not 英雄大会:是否同组(id,对方id) then
     发送数据(玩家数据[id].连接id,7,"#Y/不是同组玩家无法操作")
     是否清除=true
  end

  if 玩家数据[id].角色.数据.地图数据.编号==6010 and 玩家数据[id].角色.数据.帮派数据.编号>0 and 玩家数据[id].角色.数据.帮派数据.编号~=玩家数据[对方id].角色.数据.帮派数据.编号 then
    常规提示(id,"#Y/当前地图无法组队其他帮派成员")
    是否清除=true
  end
  for n=1,#队伍数据[队伍id].成员数据 do
    if 队伍数据[队伍id].成员数据[n]==对方id then
      常规提示(id,"#Y/对方已经在队伍中了")
      是否清除=true
    end
  end
  if 是否清除 then
    table.remove(队伍数据[玩家数据[id].队伍].申请数据,内容.序列)
    发送数据(玩家数据[id].连接id,4011,队伍数据[队伍id].申请数据)
    return
  end
  local 角色xy={x=0,y=0}
  local 对方xy={x=0,y=0}
  对方xy.x,对方xy.y=玩家数据[对方id].角色.数据.地图数据.x,玩家数据[对方id].角色.数据.地图数据.y
  角色xy.x,角色xy.y=玩家数据[id].角色.数据.地图数据.x,玩家数据[id].角色.数据.地图数据.y
  if 取两点距离(对方xy,角色xy)>=500 then
    常规提示(id,"对方离你太远了~")
    return
  elseif #队伍数据[队伍id].成员数据>=5 then
    常规提示(id,"队伍人数已满！")
    return
  end
  table.remove(队伍数据[玩家数据[id].队伍].申请数据,内容.序列)
  发送数据(玩家数据[id].连接id,4011,队伍数据[队伍id].申请数据)
  发送数据(玩家数据[对方id].连接id,1001,{x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20),})
  local 地图编号=玩家数据[id].角色.数据.地图数据.编号
  for i, v in pairs(地图处理类.地图玩家[地图编号]) do
    if i~=对方id and 玩家数据[i] then
      发送数据(玩家数据[i].连接id,1008,{数字id=对方id,路径={数字id=对方id,x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20),}})
    end
  end
  队伍数据[队伍id].成员数据[#队伍数据[队伍id].成员数据+1]=对方id
  玩家数据[对方id].队伍=队伍id
  玩家数据[对方id].队长=false
  if 玩家数据[id].角色.数据.飞行 and self:检查飞行(对方id) then
        玩家数据[对方id].角色.数据.飞行 =true
        发送数据(玩家数据[对方id].连接id,71)
        地图处理类:更新飞行(对方id,true)
  end
  if 重组==nil or (重组~=nil and 重组~="关闭") then
    广播队伍消息(队伍id,取名称(对方id).."加入了队伍")
  end
  for n=1,#队伍数据[队伍id].成员数据 do
    self:索取队伍信息(队伍数据[队伍id].成员数据[n],4004)
  end
end


function 队伍处理类:检查飞行(id)
        if 玩家数据[id].角色.数据.坐骑 and 玩家数据[id].角色.数据.坐骑.祥瑞 then
           return true
        else
            if 玩家数据[id].队伍 and 玩家数据[id].队伍 ~= 0 then
                local 队伍id = 玩家数据[id].队伍
                for i=1,#队伍数据[队伍id].成员数据 do
                    local 临时id = 队伍数据[队伍id].成员数据[i]
                    if 玩家数据[临时id].角色.数据.飞行 then
                        玩家数据[临时id].角色.数据.飞行=false
                        发送数据(玩家数据[临时id].连接id,72)
                        地图处理类:更新飞行(临时id,false)
                        常规提示(临时id,"#Y/玩家#R/"..玩家数据[id].角色.数据.名称.."#Y/没有乘骑祥瑞已经自动降落")
                    end
                end
            end
            return false
        end
end





function 队伍处理类:索取申请信息(连接id,id)
  if 玩家数据[id].队长~=true then
    常规提示(id,"只有队长才可以查看申请列表哟~")
    return 0
  else
    local 队伍id=玩家数据[id].队伍
    发送数据(玩家数据[id].连接id,4010,队伍数据[队伍id].申请数据)
  end
end

function 队伍处理类:新任队长(原来id,玩家id)
  local xl临时队伍成员id = {}
  for n=1,#队伍数据[原来id].成员数据 do
    if 队伍数据[原来id].成员数据[n]~=nil then
      if 原来id == 队伍数据[原来id].成员数据[n] then
        xl临时队伍成员id[n] = 玩家id
      elseif 玩家id == 队伍数据[原来id].成员数据[n] then
        xl临时队伍成员id[n] = 原来id
      else
        xl临时队伍成员id[n] = 队伍数据[原来id].成员数据[n]
      end
    end
  end
  self:退出队伍(原来id,"关闭",1)--清除原来队伍
  玩家数据[原来id].队长=false
  玩家数据[原来id].队伍=0
  地图处理类:更改队伍图标(原来id,false)
  --==========
  local x内容 = {id=玩家id}--创建队伍
  self:创建队伍(玩家id,x内容,"关闭")
  for i=1,#xl临时队伍成员id do
    if xl临时队伍成员id[i]~=玩家id then
      x内容 = {id=玩家id}--原队人申请队伍
      self:创建队伍(xl临时队伍成员id[i],x内容,"关闭")
      --==============
      x内容 = {序列=1}--同意进队
      self:同意入队(玩家id,x内容,"关闭")
    end
  end
  xl临时队伍成员id = {}




end


function 队伍处理类:创建队伍(id,内容,重组)
  if 玩家数据[id]~=nil then
      if  玩家数据[id].角色:取任务(300)~=0  then--普通攻击
         常规提示(id,"#Y/你处于押镖任务中,无法组队")
         return
      end
      local 创建id=内容.id+0
      if 玩家数据[id].角色.数据.地图数据.编号==6009 or 玩家数据[id].角色.数据.地图数据.编号==6003 then
        常规提示(id,"#Y当前地图无法创建队伍")
        return
      end
      if id==创建id then -- 自己创建队伍
        if 玩家数据[id].队伍==0 then
          队伍数据[id]={成员数据={[1]=id},申请数据={},阵型="普通",限制等级={0,175},新队长={开关=false,id=0}}
          玩家数据[id].队长=true
          玩家数据[id].队伍=id
          self:索取队伍信息(id,4004)
          发送数据(玩家数据[id].连接id,4006)
          地图处理类:更改队伍图标(id,true)
          if 重组==nil or (重组~=nil and 重组~="关闭") then
            常规提示(id,"创建队伍成功！")
          end
        else
          常规提示(id,"你已经有一个队伍了")
          return 0
        end
      else
        if not 玩家数据[创建id] or 玩家数据[创建id].队伍==0 then
          常规提示(id,"对方不在队伍中！")
          return 0
        else
    	    local 地图=玩家数据[id].角色.数据.地图数据.编号
          if 地图==6003 then
              常规提示(id,"该地图无法组队")
              return 0
          end
          local 申请id= 玩家数据[创建id].队伍
          if 地图==6004 and not 英雄大会:是否同组(id,申请id) then
              发送数据(玩家数据[id].连接id,7,"#Y/不是同组玩家无法操作")
              return
          end
          if 玩家数据[id].角色.数据.等级<队伍数据[申请id].限制等级[1] or 玩家数据[id].角色.数据.等级>队伍数据[申请id].限制等级[2] then
            常规提示(id,"你的等级不满对方的要求！")
            return 0
          end
          if #队伍数据[申请id].成员数据>=5 then
            常规提示(id,"对方队伍已满员！")
            return 0
          elseif #队伍数据[申请id].申请数据>=5 then
            常规提示(id,"对方申请名单已经满了~请过一会儿再试")
            return 0
          else
            for n=1,#队伍数据[申请id].申请数据 do
              if 队伍数据[申请id].申请数据[n].id==id   then
                常规提示(id,"你已经在对方的申请名单中了，请勿重复申请")
                return 0
              end
            end
            队伍数据[申请id].申请数据[#队伍数据[申请id].申请数据+1]=DeepCopy(玩家数据[id].角色:取队伍信息(id))
            if 重组==nil or (重组~=nil and 重组~="关闭") and 队伍数据[申请id].申请数据[#队伍数据[申请id].申请数据].id ~= nil then
              常规提示(id,"入队申请提交成功，请耐心等候~")
              常规提示(申请id,玩家数据[id].角色.数据.名称.."申请加入你的队伍，请尽快处理！")
            end
             发送数据(玩家数据[申请id].连接id,4011,队伍数据[申请id].申请数据)
             发送数据(玩家数据[申请id].连接id,4018,{队长id=玩家数据[申请id].队伍,等级=玩家数据[id].角色.数据.等级,名称=玩家数据[id].角色.数据.名称,模型=玩家数据[id].角色.数据.模型,邀请id=id,状态="申请入队"})
          end
        end
      end
  end
end

function 队伍处理类:索取队伍信息(id,序号)
        if not id then return end
        if not 玩家数据[id] then
             __gge.print(true,12,"玩家数据,缺少id,未上线角色接受到数据,请注意,ID:"..id.."\n")
            return
        end
        local 队伍id=玩家数据[id].队伍
        local 发送信息={}
        if 队伍数据[队伍id]== nil then return  end
        for n=1,#队伍数据[队伍id].成员数据 do
          if 队伍数据[队伍id].成员数据[n] and 玩家数据[队伍数据[队伍id].成员数据[n]] then
            发送信息[#发送信息+1]=玩家数据[队伍数据[队伍id].成员数据[n]].角色:取队伍信息()
          end
        end
        发送信息.阵型=队伍数据[队伍id].阵型
        发送信息.限制等级=队伍数据[队伍id].限制等级
        -- 添加阵型数据，包含所有已学会的阵法
        local 阵型数据={}
        if 玩家数据[id].角色.数据.阵法 then
            for 阵法名称, 状态 in pairs(玩家数据[id].角色.数据.阵法) do
                阵型数据[阵法名称] = 状态
            end
        end
        -- 特殊处理八卦阵
        if 玩家数据[id].角色.数据.高级阵法 and 玩家数据[id].角色.数据.高级阵法.八卦阵 then
            阵型数据["八卦阵"] = 1
        end
        发送信息.阵型数据=阵型数据
        发送数据(玩家数据[id].连接id,序号,发送信息)
end
function 队伍处理类:更新(dt)end
function 队伍处理类:显示(x,y)end





return 队伍处理类