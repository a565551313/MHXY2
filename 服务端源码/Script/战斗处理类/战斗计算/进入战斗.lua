
function 战斗处理类:设置断线玩家(id)
       for k,v in pairs(self.参战玩家) do
          if v.id==id then
              v.断线=true
          end
      end
end



-- self:取目标状态(编号,目标1,1) 返回 true
-- self:取行动状态(编号) 返回 true
-- self:取封印状态(前置.目标1) 返回 false
-- self:取法宝封印状态(前置.目标组[n]) 返回 false

function 战斗处理类:设置断线重连(id)
  local 参战编号 = 0
  local 编号 = 0
  for k,v in pairs(self.参战玩家) do
      if v.id==id then
          参战编号 = k
          编号 = v.编号
          break
      end
  end
  if 编号~=0 and self.参战单位[编号] and 参战编号~=0 then
      self.参战玩家[参战编号].断线=false
      self.参战玩家[参战编号].连接id=玩家数据[id].连接id
      local 死亡计算={0,0}
      local 客户数据={状态={},气血={},冷却={}}
      发送数据(玩家数据[id].连接id,5501,{id=self.参战玩家[参战编号].队伍,音乐=50,总数=#self.参战单位,发送=战斗序号.收到,收到=战斗序号.发送})
      --local 代发 = {}
      for i,v in ipairs(self.参战单位) do
            --代发[i]=self:取加载信息(i)
            发送数据(玩家数据[id].连接id,5502,self:取加载信息(i))
            local 返回数据 = self:取战斗状态(v)
            客户数据.状态[i]=返回数据.状态 or {}
            客户数据.气血[i]=返回数据.气血 or {}
            客户数据.冷却[i]=返回数据.冷却 or {}
      end

      --发送数据(玩家数据[id].连接id,5516,代发)
      发送数据(玩家数据[id].连接id,5520,客户数据.气血)
      发送数据(玩家数据[id].连接id,5522,客户数据.冷却)
      发送数据(玩家数据[id].连接id,5519.1,客户数据.状态)
      if self.参战单位[编号].操作角色 then
          发送数据(玩家数据[id].连接id,113)
          for k,v in pairs(self.参战单位[编号].操作角色) do
              if self.参战单位[v].类型 == "角色" then
                  发送数据(玩家数据[id].连接id,115,{角色=self.参战单位[v].玩家id,玩家数据=玩家数据[self.参战单位[v].玩家id].角色:取总数据()})
                  发送数据(玩家数据[id].连接id,116,{角色=self.参战单位[v].玩家id,召唤兽=玩家数据[self.参战单位[v].玩家id].召唤兽.数据})
              end
          end
      elseif self.参战单位[编号].子角色操作 then
          local 操作 = self:取参战编号(self.参战单位[编号].子角色操作,"角色")
          if 操作 and self.参战单位[操作] and self.参战单位[操作].操作角色 then
              for i=#self.参战单位[操作].操作角色,1,-1 do
                  if self.参战单位[操作].操作角色[i] == 编号 then
                      table.remove(self.参战单位[操作].操作角色,i)
                  end
              end
              if self.参战单位[编号].召唤兽 then
                  for i=#self.参战单位[操作].操作角色,1,-1 do
                      if self.参战单位[操作].操作角色[i] == self.参战单位[编号].召唤兽 then
                          table.remove(self.参战单位[操作].操作角色,i)
                      end
                  end
              end
              if self.参战单位[操作].玩家id and 玩家数据[self.参战单位[操作].玩家id] then
                  发送数据(玩家数据[self.参战单位[操作].玩家id].连接id,118,{角色=id})
              end
          end
          self.参战单位[编号].子角色操作=nil
      end
      if self.回合进程=="命令回合" then
          local 剩余命令=101-(os.time()-self.等待起始)
          local 目标={编号}
          -- 此处判断玩家操作单位有哪些
          if self.参战单位[编号].召唤兽 then
              目标[2]=self.参战单位[编号].召唤兽
          end
          if self.参战单位[编号].操作角色 then
              for i,v in ipairs(self.参战单位[编号].操作角色) do
                  目标[#目标+1] = v
              end
          end
          发送数据(玩家数据[id].连接id,5503.1,{目标,self.回合数,math.floor(剩余命令/10),剩余命令%10})
      end
      if self.执行等待<=0 then
          self.执行等待=os.time()+5
          发送数据(玩家数据[id].连接id,38,{内容=format("#G你已经重新加入战斗，预计将在#Y%s#G秒后同步战斗操作。",self.执行等待-os.time()),频道="xt"})
      else
          发送数据(玩家数据[id].连接id,38,{内容=format("#G你已经重新加入战斗，预计将在#Y%s#G秒后可以下达战斗指令。当其他玩家进入下达命令回合时，您将提前结束等待。",self.执行等待-os.time()),频道="xt"})
      end
  end
end



function 战斗处理类:设置观战玩家(观战id,id)
    local 编号=0
    for k,v in pairs(self.参战玩家) do
        if v.id==观战id then
          编号=k
          break
        end
    end
    if 编号~=0 then
        发送数据(玩家数据[id].连接id,5501,{id=self.参战玩家[编号].队伍,音乐=self.战斗类型,总数=#self.参战单位,发送=战斗序号.收到,收到=战斗序号.发送})
        for i=1,#self.参战单位 do
            发送数据(玩家数据[id].连接id,5515,self:取加载信息(i))
        end
        --5502
        self.观战玩家[id]={数字id=id,连接id=玩家数据[id].连接id}
        if self.执行等待==0 then
            发送数据(玩家数据[id].连接id,38,{内容=format("#G你已经进入观战，预计将在#Y%s#G秒后同步观战方战斗操作。","5"),频道="xt"})
        else
            if self.执行等待-os.time()<0 then
              发送数据(玩家数据[id].连接id,38,{内容=format("#G你已经进入观战，预计将在#Y%s#G秒后同步观战方战斗操作。","30"),频道="xt"})
            else
              发送数据(玩家数据[id].连接id,38,{内容=format("#G你已经进入观战，预计将在#Y%s#G秒后同步观战方战斗操作。",self.执行等待-os.time()),频道="xt"})
            end
        end
    end

end

function 战斗处理类:删除观战玩家(观战id)
      self.观战玩家[观战id] = nil
      玩家数据[观战id].战斗=0
      玩家数据[观战id].观战=nil
      发送数据(玩家数据[观战id].连接id,5505)
end



function 战斗处理类:进入战斗(玩家id,序号,任务id,单位组,假人数据)
          local 归零参数 ={"回合数","加载数量","等待起始","执行等待"}
          local 置空列表 = {"参战单位","参战玩家","观战玩家","初始属性","发言数据","执行行动","执行复活","失败玩家"}
          self.任务id = 任务id
          self.战斗类型 = 序号
          self.玩家胜利 = false
          self.同门死亡 = false
          self.回合复活 = false
          self.进入玩家id=玩家id
          self.回合进程="加载回合"
          self.队伍数量={[1]=0,[2]=0}
          self.战斗地图 = 玩家数据[玩家id].角色.数据.地图数据.编号
          self.假人数据=假人数据
          for i,v in ipairs(置空列表) do
                self[v] = {}
          end
          for i,v in ipairs(归零参数) do
                self[v] = 0
          end
  --加载战斗脚本
          self.战斗脚本 = nil
          if 副本战斗类型[序号]~=nil then
              self.战斗脚本=副本战斗类型[序号]:创建()
              self.战斗脚本:加载战斗id(玩家数据[玩家id].战斗)
          end
  --加载队伍数量
          local 队伍1 =  玩家id
          if 玩家数据[玩家id].队伍 and 玩家数据[玩家id].队伍~=0 then
              队伍1=玩家数据[玩家id].队伍
          end
          self.队伍区分={[1]=队伍1,[2]=0}
          self.参战玩家[1] ={队伍=队伍1,id=玩家id,连接id=玩家数据[玩家id].连接id,断线=false,退出=false,位置=1,进入时间=os.time()+5}
          if 玩家数据[玩家id].队伍 and 玩家数据[玩家id].队伍~=0 then
              for n=2,#队伍数据[玩家数据[玩家id].队伍].成员数据 do
                  local 队员id = 队伍数据[玩家数据[玩家id].队伍].成员数据[n]
                  table.insert(self.参战玩家, {队伍=队伍1,id=队员id,连接id=玩家数据[队员id].连接id,断线=false,退出=false,位置=n,进入时间=os.time()+5})
              end
          end
          if 序号>=200000 and 玩家数据[任务id] then
                local 队伍2 = 任务id
                if 玩家数据[任务id].队伍 and 玩家数据[任务id].队伍~=0 then
                    队伍2=玩家数据[任务id].队伍
                end
                self.队伍区分[2] = 队伍2
                table.insert(self.参战玩家, {队伍=队伍2,id=任务id,连接id=玩家数据[任务id].连接id,断线=false,退出=false,位置=1,进入时间=os.time()+5})
                if 玩家数据[任务id].队伍 and 玩家数据[任务id].队伍~=0 then
                    for n=2,#队伍数据[玩家数据[任务id].队伍].成员数据 do
                        local 队员id = 队伍数据[玩家数据[任务id].队伍].成员数据[n]
                        table.insert(self.参战玩家, {队伍=队伍1,id=队员id,连接id=玩家数据[队员id].连接id,断线=false,退出=false,位置=n,进入时间=os.time()+5})
                    end
                end
          end
          local 好友度={}
          for i,v in ipairs(self.参战玩家) do
               for k,n in ipairs(self.参战玩家) do
                   if v.队伍==n.队伍 and v.id~=n.id and 玩家数据[v.id].好友.数据.好友[n.id] and  玩家数据[n.id].好友.数据.好友[v.id]
                      and (not 好友度[v.id] or not 好友度[v.id][n.id]) then
                        if not 好友度[v.id] then
                            好友度[v.id]={}
                        end
                        好友度[v.id][n.id] = true
                        if not 好友度[n.id] then
                              好友度[n.id]={}
                        end
                        好友度[n.id][v.id] = true
                        玩家数据[v.id].好友:添加好友度(n.id,1)
                        玩家数据[n.id].好友:添加好友度(v.id,1)
                   end
               end
          end

  --设定发起方单位
          self.加载数量=#self.参战玩家
          if 序号<200000 then
              if self.战斗类型==100001 or self.战斗类型==100007 then --野外单位
                  self:加载野怪单位()
              else
                  self:加载指定单位(单位组)
              end
          end
          for n,v in pairs(self.参战玩家) do
              self:加载单个玩家(v.id,v.位置,n)
          end
          self:重置单位属性()

          for n,v in pairs(self.参战玩家) do
              发送数据(v.连接id,5501,{id=v.队伍,音乐=self.战斗类型,总数=#self.参战单位,发送=战斗序号.收到,收到=战斗序号.发送})
              for i,z in ipairs(self.参战单位) do
                发送数据(v.连接id,5502,self:取加载信息(i))
              end
          end
          if self.战斗类型 == 100308 then
             self:世界BOOS刷新(1)
          end

          if self.战斗脚本 then
              self.战斗脚本:战斗准备后(self)
          end
end




function 战斗处理类:加载单个玩家(id,位置,参战)
      系统处理类:进入战斗检测(id)
      玩家数据[id].抽中编号 = nil
      local 编号 = #self.参战单位+1
      self.参战单位[编号]={}
      self.参战单位[编号]=DeepCopy(玩家数据[id].角色:取总数据())
      local 队伍id=玩家数据[id].队伍
      if not 队伍id or 队伍id == 0 then 队伍id = id end
      self.参战单位[编号].附加阵法="普通"
      --if 队伍数据[队伍id] and #队伍数据[队伍id].成员数据==5 then
      if 队伍数据[队伍id] then
        self.参战单位[编号].附加阵法=队伍数据[队伍id].阵型
      end
-----------------------------------------------------------------
      self.参战玩家[参战].队伍=队伍id
      self.参战玩家[参战].编号=编号
-----------------------------------------------------------------
      self.参战单位[编号].队伍=队伍id
      self.参战单位[编号].位置=位置
      self.参战单位[编号].类型="角色"
      self.参战单位[编号].编号=编号
      self.参战单位[编号].玩家id=id
      self.参战单位[编号].召唤兽=nil
      self.参战单位[编号].召唤数量={}
      self.参战单位[编号].奇经八脉 =DeepCopy(玩家数据[id].奇经八脉)
      self.参战单位[编号].奇经特效 =DeepCopy(玩家数据[id].奇经特效)
      if self.参战单位[编号].神器数据 and self.参战单位[编号].神器数据.神器技能 then
          self.参战单位[编号].神器技能= self.参战单位[编号].神器数据.神器技能
      end
      if 玩家数据[id].子角色操作~=nil then
          self.参战单位[编号].子角色操作 = 玩家数据[id].子角色操作
      end
      if not 玩家数据[id].角色.数据.自动指令 then
            玩家数据[id].角色.数据.自动指令={下达=false,类型="攻击",目标=0,敌我=0,参数="",附加=""}
      end
      self.参战单位[编号].自动指令=DeepCopy(玩家数据[id].角色.数据.自动指令)
      self:设置队伍区分(队伍id)
      if self.参战单位[编号].附加阵法~="普通" then
        if self.参战单位[编号].附加阵法 == "八卦阵" then
            -- 特殊处理八卦阵
            if self:取队伍奇经八脉(编号,"扶阵") then
                self:增加阵法属性(编号,"八卦阵",位置,0.03)
            else
                self:增加阵法属性(编号,"八卦阵",位置)
            end
        else
            -- 现有阵法处理逻辑
            if self:取队伍奇经八脉(编号,"扶阵") then
                self:增加阵法属性(编号,self.参战单位[编号].附加阵法,位置,0.03)
            else
                self:增加阵法属性(编号,self.参战单位[编号].附加阵法,位置)
            end
        end
    end
      if self.参战单位[编号].参战信息 and 玩家数据[id].召唤兽.数据[玩家数据[id].召唤兽:取编号(玩家数据[id].角色.数据.参战宝宝.认证码)] then
            local bb编号X=玩家数据[id].召唤兽:取编号(玩家数据[id].角色.数据.参战宝宝.认证码)
            if not bb编号X or bb编号X==0 then  return end
            local 临时bb=玩家数据[id].召唤兽.数据[bb编号X]
            if not 临时bb then return  end
            if 临时bb.忠诚<=80 and 取随机数()>=50 then
                  常规提示(id,"#Y你的召唤兽由于忠诚过低，不愿意参战")
                  return
            end
            if 临时bb.种类~="神兽" and 临时bb.寿命<=50 then
                for n=1,#玩家数据[id].召唤兽.数据 do
                  if 玩家数据[id].召唤兽.数据[n].认证码==玩家数据[id].角色.数据.参战宝宝.认证码 then
                    玩家数据[id].召唤兽.数据[n].参战信息=nil
                  end
                end
                玩家数据[id].角色.数据.参战宝宝={}
                玩家数据[id].角色.数据.参战信息=nil
                发送数据(玩家数据[id].连接id,18,玩家数据[id].角色.数据.参战宝宝)
                常规提示(id,"你的召唤兽由于寿命过低，不愿意参战")
                return
            end

            if 临时bb.种类~="神兽" and 临时bb.种类~="孩子" then
                玩家数据[id].召唤兽.数据[bb编号X].寿命=玩家数据[id].召唤兽.数据[bb编号X].寿命-1
            end
            local 宝宝编号 = 编号 + 1
            self.参战单位[宝宝编号]={}
            self.参战单位[宝宝编号]=DeepCopy(玩家数据[id].召唤兽:获取指定数据(bb编号X))
            self.参战单位[宝宝编号].队伍=队伍id
            self.参战单位[宝宝编号].位置=位置+5
            self.参战单位[宝宝编号].主人=编号
            self.参战单位[宝宝编号].类型="bb"
            self.参战单位[宝宝编号].玩家id=id
            self.参战单位[宝宝编号].编号=宝宝编号
            self.参战单位[宝宝编号].附加阵法=self.参战单位[编号].附加阵法
            self.参战单位[编号].召唤兽=宝宝编号
            self.参战单位[宝宝编号].自动战斗=self.参战单位[编号].自动战斗
            self.参战单位[编号].召唤数量[1]=bb编号X
            if self.参战单位[编号].宝宝阵法 then
              self.参战单位[宝宝编号].伤害=math.floor(self.参战单位[宝宝编号].伤害*self.参战单位[编号].宝宝阵法)
            end
            if self.参战单位[编号].宝宝阵法 then
              self.参战单位[宝宝编号].法伤=math.floor(self.参战单位[宝宝编号].法伤*self.参战单位[编号].宝宝阵法)
            end
            if not 玩家数据[id].召唤兽.数据[bb编号X].自动指令 then
                  玩家数据[id].召唤兽.数据[bb编号X].自动指令={下达=false,类型="攻击",目标=0,敌我=0,参数="",附加=""}
            end
            self.参战单位[宝宝编号].自动指令=DeepCopy(玩家数据[id].召唤兽.数据[bb编号X].自动指令)
            local 临时技能={}
            self:设置队伍区分(队伍id)
            self:添加召唤兽特性(宝宝编号)
      end

      self:加载系统角色(队伍id)
end



function 战斗处理类:加载野怪单位()
          local 数量 = 0
          if not 玩家数据[self.进入玩家id].队伍 or  玩家数据[self.进入玩家id].队伍==0 then
                数量=取随机数(2,3)
          else
              local 队伍 = 玩家数据[self.进入玩家id].队伍
              local 队伍数量 = #队伍数据[队伍].成员数据
              数量 =取随机数(队伍数量+1,队伍数量*2+1)
              数量 = math.min(数量, 10)
          end
          local 信息 = 取野怪(self.战斗地图)
          local 下限,上限 = 取场景等级(self.战斗地图)
          self.地图等级 = math.floor((下限+上限)/2)
          local 载入精灵 = false
          local 战斗单位 = {}
          local 主怪 = nil
          if self.战斗类型 == 100007 then
             for i,v in ipairs(信息) do
                  local 数据 = 取敌人信息(v)
                  if 数据[2]==任务数据[self.任务id].模型 then
                      主怪 = 取敌人信息(v)
                      break
                  end
             end
          end
          for i=1,数量 do
              local 野怪=取敌人信息(信息[取随机数(1,#信息)])
              if i==1 and 主怪 then
                  野怪 = 主怪
              end
              战斗单位[i]={
                  名称 = 野怪[2],
                  模型 = 野怪[2],
                  位置 = i,
                  技能 = {},
                  主动技能 = {},
                  等级 = 取随机数(下限,上限)
              }
              for k,n in ipairs(野怪[14]) do
                  if 取随机数()<=45 then
                      table.insert(战斗单位[i].技能,n)
                  end
              end
              if 取随机数(1,100)<=3 and not 载入精灵 then
                  载入精灵 =true
                  战斗单位[i].技能={"自爆"}
                  战斗单位[i].精灵 = true
                  战斗单位[i].不可封印=true
                  战斗单位[i].名称 = 野怪[2].."精灵"
              elseif 取随机数()<=20 then
                     战斗单位[i].头领 = true
                     战斗单位[i].名称=野怪[2].."头领"
              elseif 取随机数(1,1000)<=5 then
                      战斗单位[i].等级 = 1
                      战斗单位[i].变异 = true
                      战斗单位[i].分类 = "变异"
                      战斗单位[i].名称 = "变异"..野怪[2]
              elseif 取随机数(1,1000)<=10 then
                      战斗单位[i].等级 = 1
                      战斗单位[i].宝宝 = true
                      战斗单位[i].分类 = "宝宝"
                      战斗单位[i].名称 = 野怪[2].."宝宝"
              end
          end
        self:加载指定单位(战斗单位)
end




function 战斗处理类:加载指定单位(单位组)--------------首席争霸
      if not 单位组 then return end
      self.敌人数量 = 0
      local 战斗单位 = DeepCopy(单位组)
      self:初始怪物属性(战斗单位)
      for k,v in ipairs(战斗单位) do
          if  type(k)=="number" and type(v)=="table" then
              self.敌人数量 = self.敌人数量 + 1
              local 编号 = #self.参战单位+1
              self.参战单位[编号] = {}
              self.参战单位[编号].玩家id = 0
              self.参战单位[编号].编号 = 编号
              self.参战单位[编号].队伍 = v.队伍 or 0
              self.参战单位[编号].位置 = v.位置 or k
              self.参战单位[编号].类型 = v.类型 or "bb"
              self.参战单位[编号].分类 = v.分类 or "野怪"
              if v.角色 then
                 self.参战单位[编号].类型="系统角色"
              end
              if v.角色分类=="角色" then
                  self.参战单位[编号].类型="系统PK角色"
              end
              if v.五维属性 then
                  for i,n in ipairs(self.五维属性) do
                      self.参战单位[编号][n] = v.五维属性[n] or 0
                  end
              end
              for i,z in pairs(v) do
                  if not self.参战单位[编号][i] then
                      self.参战单位[编号][i] = z
                  end
              end
              if self.参战单位[编号].追加法术 and self.参战单位[编号].追加法术[1] then
                  self.参战单位[编号].追加概率=25
              end
              if self.参战单位[编号].捉鬼变异 then
                  self:添加发言(编号,"其实我内心是很善良得，你们可千万不要错杀好鬼呀#52")
              end
              if self.参战单位[编号].名称=="灵感分身" then
                  self:添加发言(编号,"别以为你们人多，看我分身大法")
              end
              if v.发言 then
                   self:添加发言(编号,v.发言)
              end
              if self.战斗类型==100108  then   --------------加
                      for i,n in ipairs(self.基础属性) do
                          self.参战单位[编号][n] = math.floor(v[n] * 服务端参数.镇妖塔难度)
                      end
              elseif self.战斗类型==100001 or self.战斗类型==100007 then
                  if v.精灵 then
                      self.参战单位[编号].精灵 = true
                      self.参战单位[编号].气血 = math.floor(v.气血 * 3)
                      self.参战单位[编号].最大气血 = math.floor(v.气血 * 3)
                      self:添加发言(编号,"我是一只小精灵,小啊小精灵!#52")
                  elseif v.变异 then
                      self:添加发言(编号,"诶啊..我..我..我什么变态了,不对是换色了,你们别抓我呀!#52")
                  elseif v.宝宝 then
                      self:添加发言(编号,"其实我一个小小的宝宝,你们别抓我呀!#52")
                  elseif v.头领 then
                        for i,n in ipairs(self.基础属性) do
                            if n~="气血" and n~="最大气血" then
                                self.参战单位[编号][n] = math.floor(v[n] * 1.15)
                            end
                        end
                        self.参战单位[编号].气血 = math.floor(v.气血 * 1.25)
                        self.参战单位[编号].最大气血 = math.floor(v.气血 * 1.25)
                  end
              elseif self.战斗类型==100005 or self.战斗类型==100221 then
                    if v.变异 then
                        self.参战单位[编号].分类="变异"
                    else
                        self.参战单位[编号].分类="宝宝"
                    end
              elseif self.战斗类型==100018 or self.战斗类型==100432 then
                      self.参战单位[编号].乾坤袋=true
              end
              self:设置队伍区分(v.队伍)
          end
      end
end


function 战斗处理类:重置单位属性()
      local 开始状态 = {}
      self.战斗流程={}
      for 编号,单位 in ipairs(self.参战单位) do
            self:加载初始属性(编号,单位)
            if 单位.类型=="角色" and 单位.队伍~=0 then
                    单位.攻击修炼=单位.修炼.攻击修炼[1]
                    单位.法术修炼=单位.修炼.法术修炼[1]
                    单位.防御修炼=单位.修炼.防御修炼[1]
                    单位.抗法修炼=单位.修炼.抗法修炼[1]
                    单位.猎术修炼=单位.修炼.猎术修炼[1]
                    if 单位.符石技能.无心插柳 then
                        单位.溅射 = 单位.溅射 + 单位.符石技能.无心插柳
                        单位.溅射人数 = 单位.溅射人数 + 3
                    end
                    local 临时套装={}
                    local 临时特技={}
                    if 单位.装备 then
                        for i,n in pairs(单位.装备) do
                              if n.特效 == "神佑" or n.第二特效 == "神佑" then
                                  单位.神佑 = (单位.神佑 or 0) + 5
                              end
                              if  n.特效 == "再生" or n.第二特效 == "再生" then
                                  单位.再生 = (单位.再生 or 0) + 单位.等级/3
                              end
                              if i == 3 and (n.特效 == "必中" or  n.第二特效 == "必中") then
                                  单位.武器必中 =  true
                              end
                              if i == 5 then
                                  if n.特效 == "愤怒" or  n.第二特效 == "愤怒" then
                                          单位.愤怒腰带 = true
                                  end
                                  if  n.特效 == "暴怒" or n.第二特效 == "暴怒" then
                                        单位.暴怒腰带 = true
                                  end
                                  if n.临时附魔 and  n.临时附魔.愤怒 and n.临时附魔.愤怒.数值 > 0 then
                                      self:增加愤怒(单位.编号,math.floor(n.临时附魔.愤怒.数值))
                                  end
                              end
                              if i~=3 and n.套装效果 then
                                if 临时套装[n.套装效果[2]] then
                                   临时套装[n.套装效果[2]].数量 = 临时套装[n.套装效果[2]].数量 + 1
                                else
                                    临时套装[n.套装效果[2]]={
                                        类型 = n.套装效果[1],
                                        数量 = 1
                                    }
                                end
                              end
                              if n.特技 then
                                 if not 临时特技[n.特技] then
                                    临时特技[n.特技] =true
                                 end
                              end
                        end
                    end
                    for k,v in pairs(临时特技) do
                        table.insert(单位.特技技能,{名称=k,等级=单位.等级})
                    end
                    for k,v in pairs(临时套装) do
                        if 单位.经脉流派=="虎贲上将" and v.类型=="追加法术" then
                            单位.追加概率 =单位.追加概率 + 5
                            local 等级 = 单位.等级
                            if v.数量>1 then
                               单位.追加概率 =单位.追加概率 +  (v.数量-1) * 5
                                if v.数量 >= 5 then
                                    等级 = 等级 + 10
                                elseif v.数量 >= 3 then
                                        等级 = 等级 + 5
                                end
                            end
                            table.insert(单位[v.类型],{名称=k,等级=等级})
                        elseif v.类型~="变身术之" and v.数量>=3 then
                                local 等级 = 单位.等级
                                单位.追加概率 = 15
                                if v.数量 >=5 then
                                      单位.追加概率 = 25
                                      等级 = 等级 + 10
                                end
                                table.insert(单位[v.类型],{名称=k,等级=等级})
                        end
                    end
                    if 单位.变身数据 and 变身卡数据[单位.变身数据] and 变身卡数据[单位.变身数据].技能~="" then
                        self:添加技能属性(编号,{变身卡数据[单位.变身数据].技能})
                    end
                    self:加载法宝(编号,单位.玩家id)
                    if 单位.等级<60 then
                          self:添加主动技能(单位,"牛刀小试",单位.等级+10)
                    end

                    if 单位.门派=="凌波城" then
                          单位.战意=2
                          if 单位.奇经特效.超级战意 and 取随机数()<=20 then
                              单位.超级战意 = 单位.超级战意 + 1
                          end
                    elseif 单位.门派=="方寸山" and 单位.奇经特效.咒符 then
                          单位.符咒 =取随机数(1,5)
                          if  单位.奇经八脉.咒诀 then
                              单位.符咒 =取随机数(3,5)
                          end
                    end
                    for i,n in ipairs(单位.师门技能) do
                        for j,z in ipairs(n.包含技能) do
                            if z.学会 and 战斗技能[z.名称] and not 战斗技能[z.名称].被动 and self.技能类型[战斗技能[z.名称].类型] then
                                if z.名称 == "分身术" then
                                    if not 单位.奇经八脉.怒霆 then
                                        self:添加主动技能(单位,z.名称,n.等级)
                                    end
                                elseif z.名称 == "天地同寿" then
                                        if not 单位.奇经八脉.守中 then
                                            self:添加主动技能(单位,z.名称,n.等级)
                                        end
                                else
                                    self:添加主动技能(单位,z.名称,n.等级)
                                end
                            end
                        end
                    end
                    self:加载奇经八脉(编号)
                    self:神话词条处理(编号)
                    if self.战斗类型==100001 or self.战斗类型==100007  then
                      for i,n in ipairs(单位.剧情技能) do
                          if n.名称=="妙手空空" then
                               self:添加主动技能(单位,n.名称,n.等级)
                          end
                      end
                    end
                    if 单位.子角色操作 then
                        local 操作单位 = self:取参战编号(单位.子角色操作,"角色")
                        if 单位.子角色操作 == self.参战单位[操作单位].玩家id then
                            if self.参战单位[操作单位].操作角色==nil then
                              self.参战单位[操作单位].操作角色 ={}
                            end
                            table.insert(self.参战单位[操作单位].操作角色, 单位.编号)
                            if self.参战单位[操作单位].自动战斗 then
                                玩家数据[单位.玩家id].角色.数据.自动战斗 = true
                                单位.自动战斗 = true
                            else
                                玩家数据[单位.玩家id].角色.数据.自动战斗 = false
                                单位.自动战斗 = false
                            end
                            if 单位.召唤兽~=nil then
                              table.insert(self.参战单位[操作单位].操作角色, 单位.召唤兽)
                              self.参战单位[单位.召唤兽].自动战斗 = 单位.自动战斗
                            end
                        end
                  end
            elseif 单位.类型 == "bb" then
                    local 临时技能=DeepCopy(单位.技能)
                    if 单位.超级赐福~=nil then
                        local 随机编号=取随机数(1,4)
                        local 随机名称= 单位.超级赐福[随机编号]
                        local 超级进化=0
                        for i=1,#临时技能 do
                            if 临时技能[i]==随机名称 then
                                超级进化=i
                            end
                        end
                        if 超级进化~=0 then
                            if 随机名称=="奔雷咒" or 随机名称=="泰山压顶"  or 随机名称=="水漫金山" or 随机名称=="地狱烈火" or 随机名称=="壁垒击破" then
                                临时技能[超级进化]="超级"..随机名称
                            else
                                local 临时进化 = 分割文本(随机名称,"高级")
                                临时技能[超级进化]="超级"..临时进化[2]
                            end
                            单位.超级进化=随机名称
                        end
                    end
                    if 单位.法术认证~=nil then
                         for i,n in ipairs(单位.法术认证) do
                              if n=="上古灵符" or n=="月光" or n=="死亡召唤" or n=="水攻" or n=="落岩"
                                  or n=="雷击" or n=="烈火" or n=="地狱烈火" or n=="奔雷咒" or n=="水漫金山"
                                  or n=="泰山压顶" or n=="善恶有报" or n=="壁垒击破" or n=="惊心一剑"
                                  or n=="夜舞倾城" or n=="力劈华山" then
                                    table.insert(临时技能,n)
                              end
                         end
                    end
                    if 单位.玩家id  and 单位.主人 and 玩家数据[单位.玩家id].召唤兽 and 玩家数据[单位.玩家id].召唤兽.数据 then
                            if 单位.装备 and 单位.装备[1] and 单位.装备[2] and 单位.装备[3] then
                                if 单位.装备[1].套装效果  and 单位.装备[2].套装效果  and 单位.装备[3].套装效果 then
                                    if 单位.装备[1].套装效果[2] == 单位.装备[2].套装效果[2] and 单位.装备[1].套装效果[2] == 单位.装备[3].套装效果[2] then
                                        if 单位.装备[1].套装效果[1] == "追加法术" then
                                            单位.追加法术={[1]={名称=单位.装备[1].套装效果[2],等级=单位.等级}}
                                            单位.追加概率=25
                                        elseif 单位.装备[1].套装效果[1] == "附加状态" then
                                            table.insert(临时技能,单位.装备[1].套装效果[2])
                                        end
                                    end
                                end
                            end
                    end
                    if 单位.统御 ~= nil then
                          local 坐骑编号 = 单位.统御
                          local 玩家id = 单位.玩家id
                          if 玩家数据[玩家id].角色.数据.坐骑列表[坐骑编号] ~= nil then
                              if 玩家数据[玩家id].角色.数据.坐骑列表[坐骑编号].忠诚 <= 50 and 玩家数据[玩家id].角色.数据.坐骑列表[坐骑编号].忠诚 > 2 then
                                玩家数据[玩家id].角色.数据.坐骑列表[坐骑编号].忠诚 = 玩家数据[玩家id].角色.数据.坐骑列表[坐骑编号].忠诚 - 2
                                发送数据(玩家数据[玩家id].连接id,38,{内容="你的坐骑#R"..玩家数据[玩家id].角色.数据.坐骑列表[坐骑编号].名称.."#W减少了2点饱食度"})
                              elseif 玩家数据[玩家id].角色.数据.坐骑列表[坐骑编号].忠诚 > 50 then
                                玩家数据[玩家id].角色.数据.坐骑列表[坐骑编号].忠诚 = 玩家数据[玩家id].角色.数据.坐骑列表[坐骑编号].忠诚 - 1
                                发送数据(玩家数据[玩家id].连接id,38,{内容="你的坐骑#R"..玩家数据[玩家id].角色.数据.坐骑列表[坐骑编号].名称.."#W减少了1点饱食度"})
                              end
                              if 玩家数据[玩家id].角色.数据.坐骑列表[坐骑编号].忠诚 <= 0 then
                                玩家数据[玩家id].角色:坐骑刷新(坐骑编号)
                                发送数据(玩家数据[玩家id].连接id,38,{内容="你的坐骑#R"..玩家数据[玩家id].角色.数据.坐骑列表[坐骑编号].名称.."#W已经饥饿难耐无法给予统御召唤兽加成了"})
                              else
                                  for k,v in ipairs(玩家数据[玩家id].角色.数据.坐骑列表[坐骑编号].技能) do
                                        table.insert(临时技能,v)
                                  end
                              end
                          end
                    end
                    临时技能=删除重复(临时技能)
                    self:添加技能属性(编号,临时技能)
                    if 单位.队伍~=0 then
                        单位.攻击修炼=玩家数据[单位.玩家id].角色.数据.bb修炼.攻击控制力[1]
                        单位.法术修炼=玩家数据[单位.玩家id].角色.数据.bb修炼.法术控制力[1]
                        单位.防御修炼=玩家数据[单位.玩家id].角色.数据.bb修炼.防御控制力[1]
                        单位.抗法修炼=玩家数据[单位.玩家id].角色.数据.bb修炼.抗法控制力[1]
                    end
                    self:添加内丹属性(编号,单位.内丹数据)
                    self:添加宝宝法宝属性(编号,单位.玩家id)
                    if 单位.特性 ~= nil and  单位.特性=="御风" then
                      self:添加状态特性(编号)
                    end
            else
                    self:添加技能属性(编号,单位.技能)
                    self:添加内丹属性(编号,单位.内丹数据)
                    if 单位.特性 and  单位.特性=="御风" then
                        self:添加状态特性(编号)
                    end
            end
            local 是否有 = false
            for k,v in pairs(单位.主动技能) do
                if 战斗技能[v.名称] then
                    if 单位.自动指令 and 单位.自动指令.类型 == "法术" and 单位.自动指令.参数==v.名称 then
                        是否有 = true
                    end
                    if 战斗技能[v.名称].冷却 then
                      local 返回 = 战斗技能[v.名称].冷却(self,编号)
                      if 返回.开始>0 then
                          单位[v.名称] =  返回.开始
                      end
                    end
                end
            end
            if 单位.自动指令.类型 == "法术" and not 是否有 then
                单位.指令 = {下达=false,类型="攻击",目标=0,敌我=0,参数="",附加=""}
                单位.自动指令 = {下达=false,类型="攻击",目标=0,敌我=0,参数="",附加=""}
            end
            if 单位.动物套属性 and 单位.动物套属性.名称~="无" and 单位.动物套属性.件数>=3 then
                local 取概率 = 单位.动物套属性.件数 * 20 - 5
                if 单位.变身数据==nil and 取随机数()<=取概率 then
                    self.执行等待=self.执行等待 + 3
                    if 变身卡数据[单位.动物套属性.名称]~=nil and 变身卡数据[单位.动物套属性.名称].技能~="" then
                        self:添加技能属性(编号,{变身卡数据[单位.动物套属性.名称].技能})
                    end
                    local 流程表 = {流程=40,攻击方=编号,参数=单位.动物套属性.名称,变身套=true,
                            提示 = {
                                允许 = true,
                                名称 = "变形"
                              }
                    }
                    table.insert(self.战斗流程,流程表)
                end
            end

            if #单位.附加状态>0 then
                for i,v in ipairs(单位.附加状态) do
                   table.insert(开始状态,{目标=编号,名称=v.名称,等级=v.等级,队伍=单位.队伍})
                end
            end
            if 单位.奇经八脉.震怒 and 单位.门派=="九黎城" then
                 table.insert(开始状态,{目标=编号,名称="怒哮",等级=单位.等级,队伍=单位.队伍})
            end
            if 单位.隐身 then
                 table.insert(开始状态,{目标=编号,名称="修罗隐身",等级=单位.等级,境界=单位.隐身,队伍=单位.队伍})
            end
            if 单位.盾气 then
                 table.insert(开始状态,{目标=编号,名称="盾气",等级=单位.等级,境界=单位.盾气,队伍=单位.队伍})
            end
            if 单位.浮云神马 then
                table.insert(开始状态,{目标=编号,名称="浮云神马",等级=单位.等级,队伍=单位.队伍})
                if 单位.主人 then
                  table.insert(开始状态,{目标=单位.主人,名称="浮云神马",等级=单位.等级,队伍=单位.队伍})
                end
            end
            self.初始属性[编号]=DeepCopy(单位)

      end
      if 开始状态 and 开始状态[1] then
         local 玩家组={}
         local 任务组={}
         for i,v in ipairs(开始状态) do
              if v.队伍 == self.进入玩家id then
                  table.insert(玩家组,v)
              else
                  table.insert(任务组,v)
              end
         end
         if 玩家组 and 玩家组[1] then
              local 执行 = self:取参战编号(self.进入玩家id,"角色")
              self.执行等待=self.执行等待+10
              local 流程 = #self.战斗流程+1
              self.战斗流程[流程] = {流程=27,攻击方=执行,
                                      挨打方={},
                                      提示={允许=true,
                                            类型="施法",
                                            名称="开启状态"
                                      }
                                    }
              for i,v in ipairs(玩家组) do
                    local 前置 = {结尾 = 0,重复攻击 = false,目标数 = 1,目标 =v.目标 ,流程 = 流程}
                    if 战斗技能[v.名称].前置流程 then
                        战斗技能[v.名称].前置流程(self,v.目标,v.等级,前置,"增益")
                        if 前置.取消状态 then
                            self:解除状态组处理(执行,v.目标,前置.取消状态,v.名称,流程,i)
                        end
                        if 前置.添加状态 then
                            self:添加状态组处理(执行,v.目标,前置.添加状态,v.名称,v.等级,流程,i)
                        end
                    end
                    self:增益循环处理(执行,v.目标,1,v.名称,1,v.等级,流程,i,v.境界)
                    if 战斗技能[v.名称].结束流程 then
                        local 返回 = {}
                        战斗技能[v.名称].结束流程(self,v.目标,self.伤害输出,v.等级,前置,返回,"增益")
                        if 返回.取消状态 then
                            self:解除状态组处理(执行,v.目标,返回.取消状态,v.名称,流程,i)
                        end
                        if 返回.添加状态 then
                            self:添加状态组处理(执行,v.目标,返回.添加状态,v.名称,v.等级,流程,i)
                        end
                    end
              end
         end
         if 任务组 and 任务组[1] then
            local 执行 = 1
            if 任务组[1].队伍~=0 and 任务组[1].队伍 == self.任务id then
                执行 = self:取参战编号(self.任务id,"角色")
            end
            self.执行等待=self.执行等待+10
            local 流程 = #self.战斗流程+1
            self.战斗流程[流程] = {流程=27,攻击方=执行,
                                      挨打方={},
                                      提示={允许=true,
                                            类型="施法",
                                            名称="开启状态"
                                      }
                                  }
            for i,v in ipairs(任务组) do
                  local 前置 = {结尾 = 0,重复攻击 = false,目标数 = 1,目标 =v.目标 ,流程 = 流程}
                  if 战斗技能[v.名称].前置流程 then
                      战斗技能[v.名称].前置流程(self,v.目标,v.等级,前置,"增益")
                      if 前置.取消状态 then
                          self:解除状态组处理(执行,v.目标,前置.取消状态,v.名称,流程,i)
                      end
                      if 前置.添加状态 then
                          self:添加状态组处理(执行,v.目标,前置.添加状态,v.名称,v.等级,流程,i)
                      end
                  end
                  self:增益循环处理(执行,v.目标,1,v.名称,1,v.等级,流程,i,v.境界)
                  if 战斗技能[v.名称].结束流程 then
                      local 返回 = {}
                      战斗技能[v.名称].结束流程(self,v.目标,self.伤害输出,v.等级,前置,返回,"增益")
                      if 返回.取消状态 then
                          self:解除状态组处理(执行,v.目标,返回.取消状态,v.名称,流程,i)
                      end
                      if 返回.添加状态 then
                          self:添加状态组处理(执行,v.目标,返回.添加状态,v.名称,v.等级,流程,i)
                      end
                  end
            end
         end
      end






end


function 战斗处理类:添加主动技能(单位,技能,等级)
          if not 技能 or  not 战斗技能[技能] then
              -- error("加载:"..v.名称.." 缺少技能,或技能名错误,序号:"..self.战斗类型..",ID:"..单位.玩家id.."名称:"..单位.名称)
                __gge.print(true,12,"加载:"..技能.." 缺少技能,或技能名错误,序号:"..self.战斗类型..",ID:"..单位.玩家id.."\n")
          elseif 战斗技能[技能].被动 then
                --error("加载:"..v.名称.."为被动技能,序号:"..self.战斗类型..",ID:"..单位.玩家id.."名称:"..单位.名称)
                 __gge.print(true,12,"加载:"..技能.."为被动技能,序号:"..self.战斗类型..",ID:"..单位.玩家id.."\n")
          elseif not self.技能类型[战斗技能[技能].类型] then
                --error("加载:"..v.名称.."未定义类型,序号:"..self.战斗类型..",ID:"..单位.玩家id.."名称:"..单位.名称)
                 __gge.print(true,12,"加载:"..技能.."未定义类型,序号:"..self.战斗类型..",ID:"..单位.玩家id.."\n")
          else
              table.insert(单位.主动技能,{名称=技能,等级 = 等级 or 单位.等级+1})
          end
end



function 战斗处理类:取加载信息(id)
      local 临时列表 = {"名称","模型","等级","位置","队伍","门派","类型","武器","变身","变异","气血","魔法","愤怒",
                        "战意","狮魂","风灵","符咒","剑意","灵药","雷法","五行珠","染色组","气血上限","最大气血",
                        "最大魔法","经脉流派","","奇经特效","奇经八脉","附加阵法","主动技能","特技技能","自动指令",
                        "超级战意","人参娃娃","自动战斗","变身数据","染色方案","饰品染色组","武器染色组","饰品染色方案",
                        "武器染色方案"}
      local 临时数据={
                      战斗类型 = self.战斗类型,
                      id=self.参战单位[id].玩家id,
                      显示饰品=self.参战单位[id].饰品,
                      锦衣数据=self.参战单位[id].锦衣
                    }
      local 返回数据 = self:取战斗状态(self.参战单位[id])
      临时数据.技能冷却 = 返回数据.冷却 or {}
      for i,v in ipairs(临时列表) do
            临时数据[v]=self.参战单位[id][v]
      end
      if self.参战单位[id].类型=="角色" then
          if self.参战单位[id].装备[3] then
              临时数据.武器={名称=self.参战单位[id].装备[3].名称,子类=self.参战单位[id].装备[3].子类,级别限制=self.参战单位[id].装备[3].级别限制,染色方案=self.参战单位[id].装备[3].染色方案,染色组=self.参战单位[id].装备[3].染色组}
          end
          if self.参战单位[id].装备[4] and self.参战单位[id].模型=="影精灵" and string.find(self.参战单位[id].装备[4].名称, "(坤)") then
              临时数据.副武器={名称=self.参战单位[id].装备[4].名称,子类=self.参战单位[id].装备[4].子类,级别限制=self.参战单位[id].装备[4].级别限制,染色方案=self.参战单位[id].装备[4].染色方案,染色组=self.参战单位[id].装备[4].染色组}
          end
      elseif self.参战单位[id].类型=="系统角色" then
              临时数据.武器=self.参战单位[id].武器
              临时数据.副武器=self.参战单位[id].副武器
      elseif self.参战单位[id].类型=="系统PK角色" then
              临时数据.武器=self.参战单位[id].武器
              临时数据.副武器=self.参战单位[id].副武器
      else
             if self.参战单位[id].认证码 ~= nil then
                临时数据.认证码 = self.参战单位[id].认证码
             end
             if self.参战单位[id].超级进化 ~= nil then
                临时数据.超级进化 = self.参战单位[id].超级进化
             end
      end
      return 临时数据
end



function 战斗处理类:设置队伍区分(id)
      if self.队伍区分[1]==id then
          self.队伍数量[1]=self.队伍数量[1]+1
      else
          self.队伍数量[2]=self.队伍数量[2]+1
      end
end


function 战斗处理类:世界BOOS刷新(序号)
  local BOOS排行数据 = {}
  local 临时发送数据 = {}
  local 是否隐藏 = false
  for i,v in pairs(世界挑战) do
    if i ~= "开启" and i ~= "气血"  and i ~= "最终一击" and  i ~= "奖励"  and 世界挑战[i].伤害 ~= nil and tonumber(世界挑战[i].伤害) ~= nil then
      BOOS排行数据[#BOOS排行数据+1] = DeepCopy(世界挑战[i])
    end
  end
  if #BOOS排行数据 >= 2 then
    table.sort(BOOS排行数据,function(a,b) return a.伤害>b.伤害 end )
  end
  for i=1,8 do
    if BOOS排行数据[i] ~= nil and BOOS排行数据[i].伤害 ~= 0 then
     临时发送数据[#临时发送数据+1] = BOOS排行数据[i]
    end
  end
  if 序号~=nil then
     是否隐藏 = true
  end
  for k,v in pairs(self.参战玩家) do
       发送数据(v.连接id,135,{数据=临时发送数据,隐藏=是否隐藏})
  end

end
