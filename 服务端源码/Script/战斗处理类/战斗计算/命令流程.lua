

function 战斗处理类:设置命令处理()
  self.回合数=self.回合数+1
  if self.战斗脚本 then
     self.战斗脚本:命令回合前(self.回合数)
  end

  local 计算九黎城=function(单位)
          local 次数 = 2
          local 几率 = 40
          几率 = 几率 + (单位.奇经八脉.凌人 and 8 or 0)
          local 境界 = self:取指定法宝(单位.编号,"驭魔笼",1)
          if 境界 then
              local 增幅 = 境界*0.75
              增幅 = 单位.奇经八脉.驭魔 and math.ceil(增幅 * 1.25) or 增幅
              几率 = 几率 + 增幅
          end
          次数 = 次数 + (几率 <= 取随机数() and 1 or 0)
          次数 = 次数 + ((单位.九黎连击 and 取随机数(1, 200) <= 单位.九黎连击) and 1 or 0)
          次数 = 单位.奇经八脉野蛮 and math.max(次数, 3) or 次数
          次数 = math.min(次数, 4)
          单位.九黎连击 =0
          单位.九黎次数=次数
          单位.奇经八脉野蛮=nil
          return 次数
  end
  local 处理女儿村 = function(单位)
            单位.主动技能={}
            for k,v in ipairs(单位.师门技能) do
                for i,n in ipairs(v.包含技能) do
                    if n.学会 and 战斗技能[n.名称] and not 战斗技能[n.名称].被动 and self.技能类型[战斗技能[n.名称].类型] then
                        self:添加主动技能(单位,n.名称,v.等级)
                    end
                end
            end
            local function 添加技能(技能名称, 条件)
                if 条件 then
                    self:添加主动技能(单位, 技能名称)
                end
            end
            if 单位.奇经八脉.即兴 and self.回合数 <= 4 then
                添加技能("轻歌飘舞", 单位.奇经特效.轻歌飘舞)
                添加技能("翩跃飞舞", 单位.奇经特效.翩跃飞舞)
                添加技能("嫣然曼舞", 单位.奇经八脉.嫣然曼舞)
                添加技能("风回旋舞", 单位.奇经八脉.风回旋舞)
                添加技能("映日妙舞", 单位.奇经八脉.映日妙舞)
                添加技能("惊鸿起舞", 单位.奇经八脉.惊鸿起舞)
            elseif self.回合数 % 2 == 0 then
                添加技能("轻歌飘舞", 单位.奇经特效.轻歌飘舞)
                添加技能("嫣然曼舞", 单位.奇经八脉.嫣然曼舞)
                添加技能("风回旋舞", 单位.奇经八脉.风回旋舞)
            else
                添加技能("翩跃飞舞", 单位.奇经特效.翩跃飞舞)
                添加技能("映日妙舞", 单位.奇经八脉.映日妙舞)
                添加技能("惊鸿起舞", 单位.奇经八脉.惊鸿起舞)
            end
            添加技能("余韵索心", 单位.奇经八脉.余韵索心)

  end
  local 发言配置 = {
                李彪 = {回合 = 5, 战斗类型 = 110014, 内容 = "#Y刘洪#这废物\n留着何用?\n送你#R归西#吧"},
                -- 牛魔王 = {回合 = 4, 战斗类型 = 110002, 内容 = "胜利就在眼前了\n#大家加油\n老牛我发威了#4"},
                -- 大大王 = {回合 = 2, 战斗类型 = 110002, 内容 = "上古大神#G吊毛君\n你就放心躺好吧\n接下来交给我们#2"},
                -- 地涌夫人 = {回合 = 3, 战斗类型 = 110002, 内容 = "大家坚持住\n#G蚩尤#W已经变弱了\n我来给大家加个#YBUFF#1"}
    }


  local 玩家数量 = 0
  for k,v in pairs(self.参战玩家) do
      玩家数量=玩家数量 + 1
      for i,n in ipairs(self.发言数据) do
          发送数据(v.连接id,5512,{id=n.id,文本=n.内容})
      end
      self.发言数据={}
      local 编号=v.编号
      local 目标={编号}
      if self.参战单位[编号].类型=="角色" and self.参战单位[编号].门派=="九黎城" then
          目标={{目标=编号,法术次数=计算九黎城(self.参战单位[编号])}}
      end
      if self.参战单位[编号].召唤兽 then
          目标[2]=self.参战单位[编号].召唤兽
      end
      if self.参战单位[编号].操作角色 then
          for i,n in ipairs(self.参战单位[编号].操作角色) do
              if self.参战单位[n].类型 == "角色" and  self.参战单位[n].门派=="九黎城" then
                  table.insert(目标,{目标=n,法术次数=计算九黎城(self.参战单位[n])})
              else
                  table.insert(目标,n)
              end

          end
      end
      for i,n in ipairs(目标) do
           if type(n)=="table" then
               self.参战单位[n.目标].指令={下达=false,类型="",目标=0,敌我=0,参数="",附加="",编号=n.目标,法术次数=n.法术次数}
           else
               self.参战单位[n].指令={下达=false,类型="",目标=0,敌我=0,参数="",附加="",编号=n}
           end
      end
      发送数据(v.连接id,5503,{[1]=目标,[2]=self.回合数})
      if self.参战单位[编号].门派 == "女儿村" and self.参战单位[编号].经脉流派=="妙舞佳人" then
          处理女儿村(self.参战单位[编号])
          发送数据(v.连接id,5518,{id=编号,主动技能=self.参战单位[编号].主动技能})
          if self.参战单位[编号].子角色操作 then
              local 操作单位 = self:取参战编号(self.参战单位[编号].子角色操作,"角色")
              if self.参战单位[操作单位] and self.参战单位[操作单位].玩家id == self.参战单位[编号].子角色操作 then
                  发送数据(玩家数据[self.参战单位[操作单位].玩家id].连接id,5518,{id=编号,主动技能=self.参战单位[编号].主动技能})
              end
          end
      end
  end

  --清空一次怪物单位
  for k,v in pairs(self.参战单位) do
      local NPC发言 = 发言配置[v.名称]
      if NPC发言 and self.回合数 == NPC发言.回合 and self.战斗类型 == NPC发言.战斗类型 then
            self:添加发言(k, NPC发言.内容)
      end
      if v.指令 and v.指令.下达 then
            v.指令.下达=false
            v.指令.类型=""
            v.指令.目标=0
            v.指令.敌我=0
            v.指令.参数=""
            v.指令.附加=""
      else
          v.指令={下达=false,类型="",目标=0,敌我=0,参数="",附加="",编号=k}
      end
  end
  self.加载数量=玩家数量
  self.等待起始=os.time()
  self.回合进程="命令回合"
end


function 战斗处理类:执行回合处理()  --走这里
          local 临时速度={}
          self.执行对象={}
          if self.战斗脚本 then
             self.战斗脚本:刷新数据(self)
          end
          for k,v in pairs(self.参战单位) do
                if v.洞察特性 and  取随机数() <= v.洞察特性*5  and self:取玩家战斗() and v.主人 and self.参战单位[v.主人] then
                    local 临时敌人 = self:取单个敌方目标(k)
                    local 关键字 = "气血"
                    if 取随机数(1,2) == 1 then
                        关键字 = "魔法"
                    end
                    self:添加发言(k,self.参战单位[临时敌人].名称.."#Y/当前#G/"..关键字.."#Y/剩余#G/"..self.参战单位[临时敌人][关键字].."点")
                elseif v.灵动特性 ~= nil and v.灵动次数 <3 and 取随机数() <= v.灵动特性*5 then
                    v.灵动次数=v.灵动次数+1
                    local 临时友方 = self:取单个友方目标(k)
                    self:添加发言(k,self.参战单位[临时友方].名称.."大傻吊你睡觉了么#24")
                end
                local 当前速度 = v.速度
                if v.奇经八脉.夜行 and 昼夜参数==1 then
                   当前速度 = 当前速度 + 40
                end
                table.insert(临时速度,{速度=当前速度,编号=k})
                v.指令 = v.指令 or {下达=false,类型="",目标=0,敌我=0,参数="",附加=""}
                if not v.指令.下达 then
                    v.指令.下达=true
                    v.指令.类型="攻击"
                    v.指令.目标= self:取单个敌方目标(k)
                end
                if v.队伍==0 or v.类型=="召唤" then
                      local 数据 = self:智能施法(self.战斗类型,k,v.主动技能)
                      if self.战斗脚本 then
                          local 结果 = self.战斗脚本:NPC智能施法(k,v,self.回合数)
                          if 结果 and 结果.下达 then
                              数据 = 结果
                          end
                      end
                      if 数据.下达 then
                          v.指令.类型 = 数据.类型
                          v.指令.参数 = 数据.参数
                          v.指令.目标 = 数据.目标
                      end
                end
          end
          table.sort(临时速度,function(a,b) return a.速度>b.速度 end )
          for i=1,#临时速度 do
              self.执行对象[i]=临时速度[i].编号
          end
          self.战斗流程={}
          self.执行等待=os.time()+2
          self:执行计算处理()
          if self.回合复活 then
              self.回合复活=false
              local 减少={}
              self.执行复活=数组去重(self.执行复活)
              if #self.执行行动==0 then
                  self.执行复活={}
              else
                    for i,n in pairs(self.执行复活) do
                        for k,v in pairs(self.执行行动) do
                            if n==v then
                                table.insert(减少,v)
                            end
                        end
                    end
                    table.sort(减少,function(a,b) return self.参战单位[a].速度>self.参战单位[b].速度 end )
                    self.执行对象 = {}
                    for k,v in pairs(减少) do
                        if self.参战单位[v].奇经八脉.神躯  and  self.参战单位[v].战意<=1  then
                            self:凌波添加战意(self.参战单位[v],1)
                        end
                        for i,n in pairs(临时速度) do
                            if v == n.编号 then
                              self.执行对象[k]=n.编号
                            end
                        end
                    end
                    减少={}
                    self:执行命令计算(1)
              end
          end
          self.执行复活={}
          self.执行行动={}
          self.执行等待=self.执行等待+os.time()
          local 魔法数据 = {}
          local 冷却数据 = {}
          for k,v in pairs(self.参战单位) do
                if v.气血 < 0 then v.气血 = 0 end
                if v.魔法 < 0 then v.魔法 = 0 end
                if v.愤怒 < 0 then v.愤怒 = 0 end
                if v.气血上限 < 0 then v.气血上限 = 0 end
                if v.气血上限 > v.最大气血 then v.气血上限 = v.最大气血 end
                if v.气血>  v.气血上限 then v.气血 = v.气血上限 end
                local 返回数据 = self:取战斗状态(v)
                魔法数据[k]=返回数据.气血 or {}
                魔法数据[k].自动指令=v.自动指令
                魔法数据[k].自动战斗=v.自动战斗
                冷却数据[k]=返回数据.冷却 or {}
          end
          local 玩家数量 = 0
          for k,v in pairs(self.参战玩家) do
              发送数据(v.连接id,战斗序号.发送,self.战斗流程)
              发送数据(v.连接id,5521,魔法数据)
              发送数据(v.连接id,5522,冷却数据)
              玩家数量 = 玩家数量 + 1
          end
          for i,v in pairs(self.观战玩家) do
              if 玩家数据[i] ~= nil then
                  发送数据(玩家数据[i].连接id,战斗序号.发送,self.战斗流程)
              end
          end
          self.加载数量=玩家数量
          self.执行等待=os.time()+10+#self.战斗流程*6
          self.回合进程="执行回合"
end


function 战斗处理类:执行计算处理()
         local 群体回复 = {}
         local 群体扣血 = {}
         local 添加流程 = function(流程表,编号)
                if not 判断是否为空表(流程表) then
                    if 流程表.类型 == 2 then
                        群体回复.攻击方 = 编号
                        table.insert(群体回复, 流程表)
                    elseif 流程表.类型 == 1 then
                          群体扣血.攻击方 = 编号
                          table.insert(群体扣血, 流程表)
                    end
                end
        end

        local 状态处理 ={
                    -- 汲魂=function(编号,单位)
                    --       local 基础 = DeepCopy(self.计算属性)
                    --       基础.初始伤害 = 单位.等级 * 2
                    --       local 结果=self:取基础治疗计算(单位.法术状态.汲魂.编号,编号,"汲魂",单位.等级,基础)
                    --       self:增加气血(编号,结果.气血)
                    --       添加流程({伤害=结果.气血,类型=2,挨打方=编号},编号)
                    -- end,
                    -- 不灭1=function(编号,单位)
                    --       local 基础 = DeepCopy(self.计算属性)
                    --       基础.初始伤害 = 单位.等级*4+10
                    --       local 结果=self:取基础治疗计算(单位.法术状态.不灭1.编号,编号,"不灭",单位.等级,基础)
                    --       self:增加气血(编号,结果.气血)
                    --       添加流程({伤害=结果.气血,类型=2,挨打方=编号},编号)
                    -- end,
                    生命之泉=function(编号,单位)
                          self:增加气血(编号,单位.法术状态.生命之泉.等级)
                          添加流程({伤害=单位.法术状态.生命之泉.等级,类型=2,挨打方=编号},编号)
                    end,
                    普渡众生=function(编号,单位)
                          local 结果=单位.法术状态.普渡众生.等级
                          self:增加气血(编号,结果)
                          self:恢复伤势(编号,结果)
                          添加流程({伤害=结果,类型=2,伤势=结果,伤势类型=2,挨打方=编号},编号)
                    end,

                    再生=function(编号,单位)
                          local 基础 = DeepCopy(self.计算属性)
                          基础.初始伤害 = 单位.再生
                          if 单位.超级再生 and 取随机数()<=20 then
                              基础.初始伤害 =单位.等级*12
                          end
                          local 结果=self:取基础治疗计算(编号,编号,"再生",单位.等级,基础)
                          self:增加气血(编号,结果.气血)
                          添加流程({伤害=结果.气血,类型=2,挨打方=编号},编号)
                    end,
                    炼气化神=function(编号,单位)
                          self:增加魔法(编号,math.floor(单位.法术状态.炼气化神.等级/2))
                    end,
                    魔息术=function(编号,单位)
                          self:增加魔法(编号,math.floor(单位.法术状态.魔息术.等级/2))
                    end,
                    冥思=function(编号,单位)
                          self:增加魔法(编号,math.floor(单位.冥思))
                    end,
                    超级冥思=function(编号,单位)
                          self:增加魔法(编号,math.floor(单位.等级/4))
                    end,
                    尸腐毒=function(编号,单位)
                           local 取编号=单位.法术状态.尸腐毒.编号
                           if 取编号 and self.参战单位[取编号] then
                                local 气血=单位.法术状态.尸腐毒.等级*4+self.参战单位[取编号].伤害*0.1
                                if 单位.符石技能.柳暗花明 then
                                    气血=math.floor(气血*(100-单位.符石技能.柳暗花明)/100)
                                end
                                local 流程表 = {挨打方=编号,伤害=气血,类型=1}
                                流程表.死亡 =self:减少气血(编号,气血,取编号,"尸腐毒")
                                流程表.伤势 = 气血
                                流程表.伤势类型 = 1
                                self:造成伤势(编号,气血)
                                添加流程(流程表,编号)
                                if self:取指定法宝(取编号,"九幽",1) then
                                    local 目标=self:取友方目标组(取编号,取编号,10,"尸腐毒")
                                    if #目标 == 0 then return end
                                    local 目标数 = #目标
                                    for i=1,目标数 do
                                        local 基础 = DeepCopy(self.计算属性)
                                        基础.初始伤害 =math.floor(self.参战单位[目标[i]].气血*0.006+气血*0.006*self:取指定法宝(取编号,"九幽"))
                                        local 结果=self:取基础治疗计算(取编号,目标[i],"法宝",self.参战单位[取编号].等级,基础)
                                        self:增加气血(目标[i],结果.气血)
                                        添加流程({伤害=结果.气血,类型=2,挨打方=目标[i]},目标[i])
                                    end
                                end


                           end
                    end,
                    宝烛=function(编号,单位)
                          local 境界= self:取指定法宝(编号,"宝烛",1)
                          if 境界 then
                            local 基础 = DeepCopy(self.计算属性)
                            基础.初始伤害 = 境界*10+8
                            local 结果=self:取基础治疗计算(编号,编号,"宝烛",单位.等级,基础)
                            self:增加气血(编号,结果.气血)
                            添加流程({伤害=结果.气血,类型=2,挨打方=编号},编号)
                          end
                    end,
                    千斗金樽=function(编号,单位)
                          local 境界= self:取指定法宝(编号,"千斗金樽",1)
                          if 境界 then
                              单位.物理暴击等级 = 单位.物理暴击等级 + math.floor(境界*5)
                          end
                    end,
                    宿幕星河=function(编号,单位)
                          local 境界= self:取指定法宝(编号,"宿幕星河",1)
                          if 境界 then
                              单位.法术暴击等级 = 单位.法术暴击等级 + math.floor(境界*5)
                          end
                    end,
                    紧箍咒=function(编号,单位)
                          local 取编号=单位.法术状态.紧箍咒.编号
                          if 取编号 and self.参战单位[取编号] then
                              if 单位.法术状态.紧箍咒.默诵 then
                                  单位.不加愤怒 = 1
                                  self:减少愤怒(单位.编号,6)
                              end
                              local 气血=单位.法术状态.紧箍咒.等级
                              if self.战斗类型==100308 and 单位.队伍 == 0 and 单位.名称 == "司法天神" and 气血>=400 then
                                   气血 = 400
                              end
                              local 流程表 = {挨打方=编号,伤害=气血,类型=1}
                              流程表.死亡 =self:减少气血(编号,气血,取编号,"紧箍咒")
                              流程表.伤势 = 气血
                              流程表.伤势类型 = 1
                              self:造成伤势(编号,气血)
                              添加流程(流程表,编号)

                          end
                    end,
                    雾杀=function(编号,单位)
                          local 取编号=单位.法术状态.雾杀.编号
                          if 取编号 and self.参战单位[取编号] then
                              local 气血=单位.法术状态.雾杀.等级

                              if self.参战单位[取编号].催化加成~=nil then
                                气血 = 气血*(1+self.参战单位[取编号].催化加成*0.06)
                              end
                              if 单位.法术状态.催化 then ----奇经八脉
                                气血 = 气血 * 2
                              end
                              if 单位.法术状态.雾杀.灵木 then ----奇经八脉
                                气血 = 气血 *3
                              end
                               if self.战斗类型==100308 and 单位.队伍 == 0 and 单位.名称 == "司法天神" and 气血>=400 then
                                 气血 = 400
                              end
                              local 流程表 = {挨打方=编号,伤害=气血,类型=1}
                              流程表.死亡 =self:减少气血(编号,气血,取编号,"雾杀")
                              流程表.伤势 = 气血
                              流程表.伤势类型 = 1
                              self:造成伤势(编号,气血)
                              添加流程(流程表,编号)
                          end
                    end,
                    摇头摆尾=function(编号,单位)
                          local 取编号=单位.法术状态.摇头摆尾.编号
                          if 取编号 and self.参战单位[取编号] then
                              local 气血=单位.法术状态.摇头摆尾.等级*5
                              if self.战斗类型==100308 and 单位.队伍 == 0 and 单位.名称 == "司法天神" and 气血>=400 then
                                 气血 = 400
                              end
                              local 流程表 = {挨打方=编号,伤害=气血,类型=1}
                              流程表.死亡 =self:减少气血(编号,气血,取编号,"摇头摆尾")
                              添加流程(流程表,编号)
                          end
                    end,
                    毒=function(编号,单位)
                          local 取编号=单位.法术状态.毒.编号
                          if 取编号 and self.参战单位[取编号] then
                              local 气血=math.floor(单位.法术状态.毒.等级 + 单位.气血*0.01)
                              if 单位.符石技能.柳暗花明 then
                                    气血=math.floor(气血*(100-单位.符石技能.柳暗花明)/100)
                              end
                              if self.战斗类型==100308 and 单位.队伍 == 0 and 单位.名称 == "司法天神" and 气血>=400 then
                                 气血 = 400
                              end
                              local 流程表 = {挨打方=编号,伤害=气血,类型=1}
                              流程表.死亡 =self:减少气血(编号,气血,取编号,"毒")
                              添加流程(流程表,编号)
                          end
                    end,
                    暗器毒=function(编号,单位)
                          local 取编号=单位.法术状态.暗器毒.编号
                          if 取编号 and self.参战单位[取编号] then
                              local 气血=math.floor(单位.法术状态.暗器毒.等级 + 单位.气血*0.01)
                              if 单位.符石技能.柳暗花明 then
                                    气血=math.floor(气血*(100-单位.符石技能.柳暗花明)/100)
                              end
                              if self.战斗类型==100308 and 单位.队伍 == 0 and 单位.名称 == "司法天神" and 气血>=400 then
                                 气血 = 400
                              end
                              if self.参战单位[取编号].奇经八脉.余韵 then
                                  self:减少魔法(单位.编号,30)
                              end
                              local 流程表 = {挨打方=编号,伤害=气血,类型=1}
                              流程表.死亡 =self:减少气血(编号,气血,取编号,"暗器毒")
                              添加流程(流程表,编号)
                          end
                    end,
                    冥火炼炉=function(编号,单位)
                          local 取编号=单位.法术状态.冥火炼炉.编号
                          if 取编号 and self.参战单位[取编号] then
                              local 气血=math.floor(单位.气血*单位.法术状态.冥火炼炉.境界)
                              if self.战斗类型==100308 and 单位.队伍 == 0 and 单位.名称 == "司法天神" and 气血>=400 then
                                 气血 = 400
                              end
                              local 流程表 = {挨打方=编号,伤害=气血,类型=1}
                              流程表.死亡 =self:减少气血(编号,气血,取编号,"冥火炼炉")
                              添加流程(流程表,编号)
                          end
                    end,
                    救命毫毛=function(编号,单位)
                        local 境界= self:取指定法宝(编号,"救命毫毛")
                        if 境界 then
                            local 次数 = 3
                            local 法伤= false
                            if 单位.奇经八脉.不灭 then
                                次数 = 6
                                法伤 = true
                            end
                            if 单位.奇经八脉.不倦 then
                                境界 = 境界 + 15
                            end
                            if 单位.奇经八脉.宝诀 and self.回合数<=8 then
                                境界 = 境界 +10*(9-self.回合数)
                            end
                            if 单位.奇经八脉.妙用 then
                                境界 = 境界 +15
                            end
                            if 单位.奇经八脉.精炼 and self.回合数<=8 then
                                境界 = 境界 +10*(9-self.回合数)
                            end
                            if 境界>=取随机数() and 单位.毫毛次数<次数 then
                                  local 气血=math.floor(单位.最大气血*0.2)
                                  self:增加气血(编号,气血)
                                  添加流程({挨打方=编号,伤害=气血,类型=2,特效={"救命毫毛"},复活=true},编号)
                                  单位.毫毛次数=单位.毫毛次数+1
                                  if 法伤 then
                                     单位.法伤 = 单位.法伤 + 40
                                  end
                            end
                        end
                    end,
              }
      --local 单位状态 = {"汲魂","不灭1","生命之泉","普渡众生","魔息术","炼气化神","尸腐毒","紧箍咒","雾杀","摇头摆尾","毒","暗器毒","冥火炼炉"}
      local 单位状态 = {"生命之泉","普渡众生","魔息术","炼气化神","尸腐毒","紧箍咒","雾杀","摇头摆尾","毒","暗器毒","冥火炼炉"}
      local 单位被动 = {"再生","冥思","超级冥思",}
      for 编号,单位 in pairs(self.参战单位) do
            if self:取目标状态(编号,编号,2) and 单位.气血>0  then
                for i,n in ipairs(单位被动) do
                    if 单位[n] and 状态处理[n] then
                        状态处理[n](编号,单位)
                    end
                end
                for i,n in ipairs(单位状态) do
                      if 单位.法术状态[n] and 状态处理[n] then
                          状态处理[n](编号,单位)
                      end

                end
                if  单位.最大气血*0.7 > 单位.气血 and self:取指定法宝(编号,"宝烛") then
                    状态处理.宝烛(编号,单位)
                end
                if 单位.类型=="角色" and self:取指定法宝(编号,"七宝玲珑灯",1) then
                    self:治疗技能计算(编号,"七宝玲珑灯",self:取指定法宝(编号,"七宝玲珑灯"))
                end
                if self:取指定法宝(编号,"千斗金樽") then
                    状态处理.千斗金樽(编号,单位)
                end
                if self:取指定法宝(编号,"宿幕星河") then
                    状态处理.宿幕星河(编号,单位)
                end

            end
            if 单位.气血<=0 and  单位.类型=="角色" and 单位.门派=="方寸山" and self:取指定法宝(编号,"救命毫毛",1) then
                状态处理.救命毫毛(编号,单位)
            end
            for i,n in pairs(战斗技能) do
                if n.冷却 and 单位[i] then
                    单位[i] = 单位[i] - 1
                    if 单位[i] <= 0 then
                        单位[i] = nil
                    end
                end
            end
            for i,n in pairs(self.冷却数据) do
                if 单位[n] then
                    单位[n] = 单位[n] - 1
                    if 单位[n] <= 0 then
                        单位[n] = nil
                    end
                end
            end
            if 单位.人参娃娃 and 单位.人参娃娃.回合>0 then
                 单位.人参娃娃.回合 = 单位.人参娃娃.回合 - 1
            end
            if 单位.奇经八脉淬芒 and 单位.奇经八脉淬芒.回合>0 then
                 单位.奇经八脉淬芒.回合 = 单位.奇经八脉淬芒.回合 - 1
                 if 单位.奇经八脉淬芒.回合<= 0 then
                    单位.奇经八脉淬芒.加成 = 0
                 end
            end
            if 单位.奇经八脉狂袭 and 单位.奇经八脉狂袭.回合>0 then
                 单位.奇经八脉狂袭.回合 = 单位.奇经八脉狂袭.回合 - 1
                 if 单位.奇经八脉狂袭.回合<= 0 then
                    单位.奇经八脉狂袭.加成 = 0
                 end
            end
            if 单位.骤雨 and 单位.骤雨.回合>0 then
                单位.骤雨.回合 = 单位.骤雨.回合 - 1
                if 单位.骤雨.回合<=0 then
                    单位.骤雨.回合 =0
                    单位.骤雨.层数 = 0
                end
            end
            if 单位.雷法削弱 and 单位.雷法削弱.回合>0 then
                 单位.雷法削弱.回合 = 单位.雷法削弱.回合 - 1
                 if 单位.雷法削弱.回合<=0 then
                    单位.雷法削弱=nil
                 end
            end
            if 单位.威仪九霄加成 then
                单位.威仪九霄加成 = 单位.威仪九霄加成 + 1
                if 单位.威仪九霄加成>=30 then
                   单位.威仪九霄加成 = 30
                end
            end
            if 单位.法术状态.波澜不惊 then
                单位.法术状态.波澜不惊.等级 = 0
            end
            if 单位.奇经八脉.乘胜 then
                local 倒地 = false
                for i=1,#self.参战单位 do
                    if self.参战单位[i]~=nil and self.参战单位[i].类型=="角色" and self.参战单位[i].队伍~=单位.队伍 and self.参战单位[i].气血<=0 then
                       倒地 = true
                    end
                end
                if 倒地 then
                   单位.奇经八脉乘胜 = 400
                end
            end
            if 单位.奇经八脉.涡流 and 取随机数()<=8 and 单位.战意>0 then
                单位.超级战意 = 单位.超级战意 + 单位.战意
                if 单位.神器技能 and 单位.神器技能.名称=="酣战" then
                    local 临时数额 =单位.神器技能.等级*30
                    if 单位.神器技能酣战==nil then
                        单位.神器技能酣战 = {数额=临时数额,层数=单位.战意}
                    else
                        单位.神器技能酣战.层数 = 单位.神器技能酣战.层数+单位.战意
                        if 单位.神器技能酣战.层数>=6 then
                          单位.神器技能酣战.层数=6
                        end
                    end
                end
                单位.战意 = 0
                if 单位.超级战意>=3 then 单位.超级战意 = 3 end
                self:添加提示(单位.玩家id,单位.编号,"#Y/你当前可使用的超级战意为#R/"..单位.超级战意.."#Y/点,战意为#R/"..单位.战意.."#Y/点")
            end
            if 单位.奇经八脉.破浪 and 取随机数()<=33 then
              单位.奇经八脉破浪 = 1
            end
            if 单位.奇经八脉.龙息 then
                单位.奇经八脉龙息 = (单位.奇经八脉龙息 or 0) + 1
            end
            if 单位.奇经八脉.激怒 and 取随机数()<=10 and not 单位.奇经八脉蚀天 then
                单位.奇经八脉蚀天 = 4
            end
            if 单位.奇经八脉.倩影 then
                单位.速度 = 单位.速度 + 2
            end
            if (单位.法术状态.含情脉脉~=nil and  单位.法术状态.含情脉脉.忘忧~=nil) or
              (单位.法术状态.天罗地网~=nil and  单位.法术状态.天罗地网.忘忧~=nil) then
                self:减少魔法(单位.编号,90)
                if 单位.魔法<= 0 then
                    local 流程列表 = {挨打方 = 编号,伤害 = 单位.等级 * 4,类型=1}
                    流程列表.死亡=self:减少气血(编号,单位.等级 * 4,单位.法术状态.含情脉脉.编号,"含情脉脉")
                    添加流程(流程列表,编号)
                end
            end
            if 单位.法术状态.瘴气~=nil and  单位.法术状态.瘴气.迷意 then
                self:减少魔法(单位.编号,40)
            end
            if 单位.奇经八脉.灵归  and 取随机数()<=50 then
               单位.风灵 = 单位.风灵+ 1
            end
            if 单位.气血>=0 then
                if 单位.奇经八脉.昂扬 and self.回合数/8==math.floor(self.回合数/8) then
                   local 取目标=self:取单个敌方目标(编号)
                   if self:取目标状态(编号,取目标,1) and self:取行动状态(编号)  then
                      战斗技能.披坚执锐.技能流程(self,编号,取目标)
                   end
                end
                if 单位.奇经八脉.补缺 and 单位.气血<=单位.最大气血*0.3 and 取随机数()<=35 then
                   if self:取行动状态(编号)  then
                      local 额外命令 = {目标=self:取单个敌方目标(编号),名称="凝神术"}
                      self:法术攻击处理(编号,额外命令)
                   end
                end
                if 单位.奇经八脉复仇 ~=nil then
                   if self:取行动状态(编号)  then
                      local 额外命令 = {目标=单位.奇经八脉复仇,名称="幼狮之搏"}
                      self:法术攻击处理(编号,额外命令)
                      单位.奇经八脉复仇 = nil
                   end
                end
                if 单位.奇经八脉.迅捷 and  单位.法术状态.变身==nil and 取随机数()<=20 then
                   if self:取行动状态(编号)  then
                      local 额外命令 = {目标=编号,名称="变身"}
                      self:法术攻击处理(编号,额外命令)
                   end
                end
                if 单位.奇经八脉.养生 and 单位.气血<单位.最大气血*0.7 and not 单位.法术状态.生命之泉 then
                   if self:取行动状态(编号)  then
                      local 额外命令 = {目标=编号,名称="生命之泉"}
                      self:法术攻击处理(编号,额外命令)
                   end
                end
                if 单位.奇经八脉雨润 then
                   self:增加气血(编号,单位.奇经八脉雨润)
                   self:恢复伤势(编号,单位.奇经八脉雨润)
                   添加流程({伤害=单位.奇经八脉雨润,类型=2,挨打方=编号,伤势=单位.奇经八脉雨润,伤势类型=2},编号)
                   单位.奇经八脉雨润 = nil
                end
                if 单位.奇经八脉.激活 and self.回合数/8==math.floor(self.回合数/8) then
                   if 单位.催化加成 ==nil then
                      单位.催化加成 = 0
                    end
                    单位.催化加成 = 单位.催化加成 + 1
                    if  单位.催化加成>=10 then
                      单位.催化加成 = 10
                    end
                end
            end
            if 单位.队伍==0 and 单位.气血>=1 then
                  if self:取封印状态(编号) and self:取友封印数量(编号)>=服务端参数.自动晶清 and 单位.类型~="角色" and not 单位.主人 then
                       self:治疗技能计算(编号,"晶清诀",单位.等级)
                  end
                  if self.战斗类型==100009 and self:取阵营数量(0)<=5 and 单位.名称~="喽罗" then
                        self:执行怪物召唤(编号,1,0,5-self:取阵营数量(0))
                  elseif self.战斗类型==100125 and self:取阵营数量(0)<=5 and 单位.名称~="灵感分身小弟"  then
                          self:执行怪物召唤(编号,5,0,5-self:取阵营数量(0))
                  elseif self.战斗类型==100054 and self:取阵营数量(0)<=5 and 单位.名称~="喽罗" then
                          self:执行怪物召唤(编号,1,0,5-self:取阵营数量(0))
                  elseif self.战斗类型==130041 and  self:取阵营数量(0)<=10 and 单位.名称~="挑战GM分身"  then
                          self:执行怪物召唤(编号,10,0,10-self:取阵营数量(0))
                  elseif self.战斗类型==100061 and self:取阵营数量(0)<=5 and 单位.名称~="护法天兵"  then
                          self:执行怪物召唤(编号,9,0,5-self:取阵营数量(0))
                  elseif self.战斗类型==110014 and self.回合数==6 and self:取阵营数量(0)<=5  then
                          self:执行怪物召唤(编号,8,0,5-self:取阵营数量(0))
                  elseif self.战斗类型==100001 then
                      if 单位.模型=="狂豹兽形" and 单位.最大气血*0.5<=单位.气血 and 取随机数()<=10   then
                              单位.模型="狂豹人形"
                              单位.名称="狂豹人形"
                              local 流程表 = {流程=40,攻击方=编号,参数="狂豹人形",
                              提示 = {
                                        允许 = true,
                                        名称 = "变形"
                                      }
                              }
                              table.insert(self.战斗流程,流程表)



                       elseif 单位.模型=="猫灵兽形" and 单位.最大气血*0.5<=单位.气血 and 取随机数()<=10 then
                              单位.模型="猫灵人形"
                              单位.名称="猫灵人形"
                              local 流程表 = {流程=40,攻击方=编号,参数="猫灵人形",
                              提示 = {
                                        允许 = true,
                                        名称 = "变形"
                                      }
                              }
                              table.insert(self.战斗流程,流程表)
                       elseif 单位.模型=="犀牛将军兽形" and 单位.最大气血*0.5<=单位.气血 and 取随机数()<=10 then
                              单位.模型="犀牛将军人形"
                              单位.名称="犀牛将军人形"
                              local 流程表 = {流程=40,攻击方=编号,参数="犀牛将军人形",
                              提示 = {
                                        允许 = true,
                                        名称 = "变形"
                                      }
                              }
                              table.insert(self.战斗流程,流程表)
                        end
                  elseif self.战斗类型==110014 then
                        if 单位.名称=="李彪" and self.回合数==5 then
                            单位.模型="骷髅怪"
                            单位.名称="李彪"
                            local 流程表 = {流程=40,攻击方=编号,参数="骷髅怪",
                            提示 = {
                                        允许 = true,
                                        名称 = "变形"
                                      }
                            }
                            table.insert(self.战斗流程,流程表)
                        end
                  end
            end

      end

      if not 判断是否为空表(群体回复) then
          local 流程列表 = {流程=50,攻击方=群体回复.攻击方,挨打方={}}
          for i,v in ipairs(群体回复) do
               流程列表.挨打方[i] = v
          end
          table.insert(self.战斗流程,流程列表)
      end
      if not 判断是否为空表(群体扣血) then
          local 流程列表 = {流程=50,攻击方=群体扣血.攻击方,挨打方={}}
          for i,v in ipairs(群体扣血) do
               流程列表.挨打方[i] = v
          end
          table.insert(self.战斗流程,流程列表)
      end
      self:执行命令计算()
end







function 战斗处理类:执行命令计算(复活计算)
    for n = 1, #self.执行对象 do
        local 编号 = self.执行对象[n]
        if not self.参战单位[编号] then goto continue end
        if self.参战单位[编号].法术状态 and self.参战单位[编号].法术状态.后发制人 then
            self.参战单位[编号].指令.类型 = ""
            self:物攻技能计算(编号, "后发制人", self:取技能等级(编号, "后发制人"))
            goto continue
        end
        if self.全局结束 == nil and self.参战单位[编号].气血<=0 and not 复活计算 then
            table.insert(self.执行行动, 编号)
            goto continue
        end
        if self.全局结束 == nil and self:取行动状态(编号) and self:是否结束战斗(编号) then
            self:处理单位指令(编号,self.参战单位[编号])
        end
        ::continue::
    end
    self:处理复仇标记()
end





-- 处理单位指令
function 战斗处理类:处理单位指令(编号,单位)
    if not 单位.指令 then
        单位.指令 = {下达 = false, 类型 = "", 目标 = 0, 敌我 = 0, 参数 = "", 附加 = ""}
    end
    if not 单位.指令.下达 then return end
    self:执行命令预处理(编号,单位)
    -- 处理多重施法（九黎城特殊逻辑）
    if 单位.指令.类型=="法术" and 单位.指令.多重施法 and 单位.类型 == "角色" and 单位.门派 == "九黎城" and 单位.九黎次数 then
        self:处理九黎城施法(编号,单位)
        return
    end

    -- 根据指令类型处理
    local 处理函数 = {
        攻击 = function() self:处理攻击指令(编号,单位) end,
        法术 = function() self:处理法术指令(编号,单位) end,
        特技 = function() self:处理法术指令(编号,单位) end,
        道具 = function()
                if not 单位.法术状态.煞气诀 then
                    self:道具计算(编号)
                end
        end,
        同门飞镖 = function()
                  if self:取目标状态(编号, 目标, 1) then
                      self:飞镖计算(编号, {[1] = {id = 目标, 伤害 = 500}})
                  end
        end,
        捕捉 = function()
              if 单位.类型 == "角色" then
                  self:捕捉计算(编号)
              end
        end,
        召唤 = function()
              if 单位.类型 == "角色" then
                  self:召唤计算(编号)
              end
        end,
        逃跑 = function() self:逃跑计算(编号, 50) end
    }

    if 处理函数[单位.指令.类型] then
        处理函数[单位.指令.类型]()
    end
end

function 战斗处理类:处理九黎城施法(编号,单位)
          单位.指令.执行 = true
          单位.九黎连击 = 0
          单位.九黎连击数 = 0
          单位.奇经八脉生风 = nil
          单位.奇经八脉飞扬 = nil
          if self:取法术状态(编号) and self:取行动状态(编号) then
              self:增益技能计算(编号,"炎魂",单位.等级)
          end
          local 多重 = 单位.指令.多重施法
          local function 检查经脉()
              return 单位.奇经八脉.飞扬 and 多重 and #多重 >= 3
                     and (多重[#多重].参数 == "力劈苍穹" or 多重[#多重].参数 == "魔神之刃")
                     and 多重[#多重-1].参数 == "三荒尽灭"
                     and 多重[#多重-2].参数 == "三荒尽灭"
          end
          if 检查经脉() then
              单位.奇经八脉飞扬 = 1
          end
          for k = 1, 单位.九黎次数 do
              if 多重[k] then
                  单位.指令.目标 = 多重[k].目标
                  单位.指令.附加 = 多重[k].附加
                  单位.指令.参数 = 多重[k].参数
                  if 多重[k].类型 == "法术" and self:取法术状态(编号) and self:取行动状态(编号) then
                      self:处理技能冷却(编号,单位,多重[k].参数,多重[k].目标)
                  end
              end
          end
          local 添加流程 ={流程 = 50,攻击方=编号,挨打方={}}
          self:取消状态("炎魂",编号)
          self:取消状态("怒哮",编号)
          table.insert(添加流程.挨打方,{挨打方=编号,取消状态={"炎魂","怒哮"}})
          if 单位.取消浮空 then
              for k,v in pairs(单位.取消浮空) do
                  if self.参战单位[v] then
                      self:取消状态("浮空",v)
                      table.insert(添加流程.挨打方,{挨打方=v,取消状态="浮空"})
                  end
              end
              单位.取消浮空 = nil
          end
          table.insert(self.战斗流程,添加流程)
          单位.指令.类型 = ""
          单位.九黎连击数 = nil
end


function 战斗处理类:处理攻击指令(编号,单位)
          单位.指令.执行 = true
          local 目标 = 单位.指令.目标
          if not self:取攻击状态(编号) or self:取是否合击(编号,目标) then return end
          if self.参战单位[目标] and not 单位.法术状态.反间之计 and self.参战单位[目标].队伍 == 单位.队伍 then
              单位.指令.目标 = self:取单个敌方目标(编号)
              目标 = 单位.指令.目标
          end
          local 类型 = "普通攻击"
          if 单位.理直气壮 and 取随机数() <= 40 then
              类型 = "理直气壮"
          elseif 单位.连击 and 取随机数() <= 单位.连击 then
              类型 = 单位.超级连击 and "超级连击" or (单位.连击 >= 50 and "高级连击" or "连击")
          end
          if 目标 and self.参战单位[目标] and self.参战单位[目标].超级反震 then
              类型 = "普通攻击"
          end
          self:普通攻击计算(编号,类型)
          if 单位.超级敏捷 and self:取攻击状态(编号) and 取随机数() <= 5 then
              self:普通攻击计算(编号,"超级敏捷")
          end
          self:处理嗜血幡(编号,单位,目标)
          self:处理怒击效果(编号,单位,目标)
          self:处理嗜血追击(编号,单位,目标)

end
function 战斗处理类:处理法术指令(编号,单位)
    单位.指令.执行 = true
    local 名称 = 单位.指令.参数
    local 目标 = 单位.指令.目标
     if not 战斗技能[名称] then return end
    local 可施法 = (not 战斗技能[名称].特技 and self:取法术状态(编号, 名称))
                  or (战斗技能[名称].特技 and self:取特技状态(编号))
    if not 可施法 then return end
    名称 = 单位.指令.参数
    if (名称 == "狮搏" or 名称 == "鹰击" or 名称 == "连环击" or 名称 == "象形")
       and not 单位.法术状态.变身 then
        单位.指令.参数 = "变身"
        self:法术攻击处理(编号)
        self:添加提示(单位.玩家id, 单位.编号, "#Y/没有变身效果，本回合自动变身")
        return
    end
    self:处理技能冷却(编号,单位,名称,目标)
    if 战斗技能[名称] and (战斗技能[名称].类型 == "物攻" or 战斗技能[名称].类型 == "群体物攻") then
         self:处理嗜血幡(编号,单位,目标)
         self:处理怒击效果(编号,单位,目标)
         self:处理嗜血追击(编号,单位,目标)
    end
end


function 战斗处理类:处理嗜血幡(编号,单位,目标)
          if self:取攻击状态(编号) and self:取指定法宝(编号,"嗜血幡",1) then
              local 新目标 = self:取单个敌方目标(编号)
              if 新目标 and 新目标~=0 then
                  单位.指令.目标 = 新目标
                  self:普通攻击计算(编号,"嗜血幡")
                  单位.指令.目标 = 目标
              end
          end
end

function 战斗处理类:处理怒击效果(编号,单位,目标)
          if 单位.怒击效果 and 单位.怒击触发 and self:取攻击状态(编号) then
              local 新目标 = self:取单个敌方目标(编号)
              if 新目标 and 新目标~=0 then
                单位.指令.目标 = 新目标
                self:普通攻击计算(编号,"苍鸾怒击")
                单位.指令.目标 = 目标
              end
          end
end

function 战斗处理类:处理嗜血追击(编号,单位,目标)
          if 单位.嗜血追击 and self:取攻击状态(编号) and (取随机数()<=10 or 单位.嗜血触发) then
              local 新目标 = self:取单个敌方目标(编号)
              if 新目标 and 新目标~=0 then
                单位.指令.目标 = 新目标
                self:普通攻击计算(编号,"嗜血追击")
                单位.指令.目标 = 目标
              end
          end
end

function 战斗处理类:处理技能冷却(编号,单位,名称,目标)
          if 战斗技能[名称].冷却 then
              if 单位[名称] then
                  self:添加提示(单位.玩家id, 单位.编号, "#Y该技能当前处于冷却中还需："..单位[名称].."回合后才可使用")
                  return
              else
                  local 冷却 = 战斗技能[名称].冷却(self,编号)
                  if 战斗技能[名称].技能流程 then
                      战斗技能[名称].技能流程(self,编号,目标)
                  else
                      self:法术攻击处理(编号)
                  end
                  if 冷却 and 冷却.使用 > 0 then
                      单位[名称] = 冷却.使用
                  end
                  if (名称=="秘传飞砂走石" or 名称=="秘传三昧真火") and  self.参战单位[编号].奇经八脉.旋阳 and 取随机数()<=50 then
                      self.参战单位[编号][名称] = self.参战单位[编号][名称] - 2
                  end
              end
          elseif 战斗技能[名称].技能流程 then
              战斗技能[名称].技能流程(self,编号,目标)
          else
              self:法术攻击处理(编号)
          end
end




function 战斗处理类:处理复仇标记()
      for n = 1, #self.执行对象 do
          local 编号 = self.执行对象[n]
          if  self.参战单位[编号] and self.参战单位[编号].复仇标记 ~= nil and self:取目标状态(编号, self.参战单位[编号].复仇标记, 1) and self.参战单位[编号].气血 >= 10 then
              self.参战单位[编号].指令.目标 = self.参战单位[编号].复仇标记
              self:普通攻击计算(编号)
          end
      end
end


function 战斗处理类:执行命令预处理(编号,单位)
      if 单位.法术状态.疯狂 and 取随机数()<=50 then
         单位.指令.类型="攻击"
         单位.指令.目标=self:取单个友方目标(编号)
      end
      if 单位.法术状态.反间之计 and 取随机数()<=50 then
          local 临时友方 = self:取单个友方目标(编号)
          if 临时友方 ~= 0 then
              单位.指令.类型="攻击"
              单位.指令.目标=临时友方
          else
              单位.指令.类型="防御"
              单位.指令.目标=0
          end
      end
      if 单位.法术状态.发瘟匣 then
           if 单位.指令.类型~="防御" then
              单位.指令.类型="攻击"
              单位.指令.目标=self:取单个友方目标(编号)
           end
      end
      if 单位.法术状态.落魄符 and 取随机数()<=50 then
           单位.指令.类型="攻击"
           单位.指令.目标=self:取单个友方目标(编号)
      end

      if 单位.法术状态.错乱 and 取随机数()<=50 then
           单位.指令.类型="攻击"
           单位.指令.目标=self:取单个友方目标(编号)
      end

      if 单位.法术状态.锋芒毕露  then
         单位.指令.目标=单位.法术状态.目标id
      end
      if 单位.法术状态.诱袭 then
         单位.指令.类型="攻击"
         单位.指令.目标=单位.法术状态.目标id
      end
      if (单位.法术状态.无魂傀儡 and 取随机数()<=30) or (单位.法术状态.断线木偶 and 取随机数()<=30) then
          单位.指令.类型="攻击"
          if 单位.法术状态.无魂傀儡 then
              单位.指令.目标= 单位.法术状态.无魂傀儡.编号
          else
              单位.指令.目标=单位.法术状态.断线木偶.编号
          end
      end
      if 单位.法术状态.鬼泣 and 单位.类型~="角色" and 取随机数()<= 单位.法术状态.境界*2 then
          单位.指令.类型="逃跑"
      elseif 单位.法术状态.惊魂铃 and 单位.类型~="角色" and 取随机数()<= 单位.法术状态.境界*2 then
          单位.指令.类型="逃跑"
      end
      if 单位.指令.类型=="攻击" and 单位.指令.附加 == "友伤" then--普通攻击
          if self:取攻击状态(编号) then
              self:普通攻击计算(编号,nil,nil,nil,true)
          end
      end


end



function 战斗处理类:是否结束战斗(编号)
          local 数量= 0
          for n=1,#self.参战单位 do
              if self.参战单位[n].队伍~= self.参战单位[编号].队伍 and ( self.参战单位[n].气血<=0 or self.参战单位[n].捕捉 or self.参战单位[n].逃跑) then
                  数量=数量 + 1
              end
          end
          if self.参战单位[编号].队伍==self.队伍区分[1] and 数量==self.队伍数量[2] then
              return false
          elseif self.参战单位[编号].队伍==self.队伍区分[2] and 数量==self.队伍数量[1] then
                  return false
          end
          return true
end









function 战斗处理类:更新(dt) --自动时间
          local 时间 = os.time()
          if self.回合进程=="命令回合" then
              if 时间-self.等待起始>=3 then
                for k,v in pairs(self.参战单位) do
                    if v.自动战斗 and v.指令.下达==false  then
                        if v.自动指令 then
                            v.指令=DeepCopy(v.自动指令)
                            if v.门派 == "九黎城" and v.自动指令.九黎挂机 and v.九黎次数 then
                                v.指令.多重施法 = v.指令.多重施法 or {}
                                if v.九黎次数>4 then
                                   v.九黎次数 = 4
                                end
                                if v.自动指令.九黎挂机[v.九黎次数] then
                                    v.指令.多重施法=DeepCopy(v.自动指令.九黎挂机[v.九黎次数])
                                end
                                if #v.指令.多重施法> v.九黎次数 then
                                   for i=v.九黎次数+1,#v.指令.多重施法 do
                                       v.指令.多重施法[i] = nil
                                   end
                                end
                                for i,n in ipairs(v.指令.多重施法) do
                                      if n.类型=="法术" then
                                          local 临时技能=取法术技能(n.参数)
                                          if 临时技能[3]==4 then
                                              n.目标=self:取单个敌方目标(k)
                                          else
                                              n.目标=self:取单个友方目标(k)
                                          end
                                      else
                                          v.指令.类型 = "攻击"
                                          v.指令.目标 = self:取单个敌方目标(k)
                                      end
                                end
                            else
                                v.指令.多重施法 = nil
                            end
                            if v.指令.类型=="法术" then
                                if v.指令.参数=="" then
                                    v.指令.类型="攻击"
                                    v.指令.目标=self:取单个敌方目标(k)
                                else
                                    local 临时技能=取法术技能(v.指令.参数)
                                    if 临时技能[3]==4 then
                                        v.指令.目标=self:取单个敌方目标(k)
                                    else
                                        v.指令.目标=self:取单个友方目标(k)
                                    end
                                end
                            else
                                v.指令.多重施法 = nil
                            end
                            if not self.参战单位[v.指令.目标] and  v.指令.类型~="防御" then
                                v.指令.类型="攻击"
                                v.指令.目标=self:取单个敌方目标(k)
                            end
                            if self.参战单位[v.指令.目标]==nil and v.指令.类型~="防御" then
                              v.指令.类型="攻击"
                              v.指令.目标=self:取单个敌方目标(k)
                            end
                        else
                            v.指令.类型="攻击"
                            v.指令.目标=self:取单个敌方目标(k)
                        end
                        v.指令.下达=true
                        if 玩家数据 and v.玩家id and 玩家数据[v.玩家id] then
                            发送数据(玩家数据[v.玩家id].连接id,5511)
                        end
                        if v.队伍~=0 and v.类型=="角色"  then
                          self.加载数量=self.加载数量-1
                        end
                    end
                end
              end
              if self.加载数量<=0 then
                self.回合进程="计算回合"
                self:执行回合处理()
              end
              if 时间-self.等待起始>=101 then
                self.回合进程="计算回合"
                self:执行回合处理()
              end
          elseif self.回合进程=="执行回合" and 时间>=self.执行等待 and self.回合进程~="结束回合" then
                  self.回合进程="结束回合"
                  self:结算流程处理()
          end
end




-- function 战斗处理类:更新(dt) --自动时间
--           local 时间 = os.time()
--           if self.回合进程=="命令回合" then
--               if 时间-self.等待起始>=3 then
--                 for k,v in pairs(self.参战单位) do
--                     if v.自动战斗 and v.指令.下达==false  then
--                         if v.自动指令 then
--                             v.指令=DeepCopy(v.自动指令)
--                             if v.指令.类型=="法术" and v.类型=="角色" and v.门派=="九黎城" and v.九黎次数 then
--                                   v.指令.多重施法 = v.指令.多重施法 or {}
--                                   if v.自动指令.九黎挂机 and v.自动指令.九黎挂机[v.九黎次数] then
--                                       v.指令.多重施法=DeepCopy(v.自动指令.九黎挂机[v.九黎次数])
--                                   end
--                                   for i,v in ipairs(v.指令.多重施法) do
--                                         if v.类型=="法术" then
--                                             local 临时技能=取法术技能(v.参数)
--                                             if 临时技能[3]==4 then
--                                                 v.目标=self:取单个敌方目标(k)
--                                             else
--                                                 v.目标=self:取单个友方目标(k)
--                                             end
--                                         else
--                                               v.指令.类型="攻击"
--                                               v.指令.目标=self:取单个敌方目标(k)
--                                         end
--                                   end
--                             else
--                                 if v.指令.类型=="法术" then
--                                     if v.指令.参数=="" then
--                                         v.指令.类型="攻击"
--                                         v.指令.目标=self:取单个敌方目标(k)
--                                     else
--                                         local 临时技能=取法术技能(v.指令.参数)
--                                         if 临时技能[3]==4 then
--                                             v.指令.目标=self:取单个敌方目标(k)
--                                         else
--                                             v.指令.目标=self:取单个友方目标(k)
--                                         end
--                                     end
--                                 end
--                             end
--                             if self.参战单位[v.指令.目标]==nil and v.指令.类型~="防御" then
--                               v.指令.类型="攻击"
--                               v.指令.目标=self:取单个敌方目标(k)
--                             end
--                         else
--                             v.指令.类型="攻击"
--                             v.指令.目标=self:取单个敌方目标(k)
--                         end
--                         v.指令.下达=true
--                         if 玩家数据 and v.玩家id and 玩家数据[v.玩家id] then
--                             发送数据(玩家数据[v.玩家id].连接id,5511)
--                         end
--                         if v.队伍~=0 and v.类型=="角色"  then
--                           self.加载数量=self.加载数量-1
--                         end
--                     end
--                 end
--               end
--               if self.加载数量<=0 then
--                 self.回合进程="计算回合"
--                 self:执行回合处理()
--               end
--               if 时间-self.等待起始>=101 then
--                 self.回合进程="计算回合"
--                 self:执行回合处理()
--               end
--           elseif self.回合进程=="执行回合" and 时间>=self.执行等待 and self.回合进程~="结束回合" then
--                   self.回合进程="结束回合"
--                   self:结算流程处理()
--           end
-- end



function 战斗处理类:结算流程处理()
          local 死亡计算={0,0}
          for 编号,单位 in pairs(self.参战单位) do
              if 单位.气血<=0 or 单位.捕捉 or 单位.逃跑 then
                  单位.电光火石 = 10 ---奇经八脉
                  if 单位.队伍==self.队伍区分[1] then
                    死亡计算[1]=死亡计算[1]+1
                  else
                    死亡计算[2]=死亡计算[2]+1
                  end
              end
          end
          if 死亡计算[1]==self.队伍数量[1] then
              self.回合进程="结束回合"
              self:结束战斗处理(self.队伍区分[2],self.队伍区分[1],nil,假人数据)
              return
          elseif 死亡计算[2]==self.队伍数量[2] then
              self.回合进程="结束回合"
              self:结束战斗处理(self.队伍区分[1],self.队伍区分[2],nil,假人数据)
              return
          end
          local 单独发送={}
          local 客户数据={状态={},气血={},冷却={}}
          for 编号,单位 in pairs(self.参战单位) do
               单位.法术状态 = 单位.法术状态 or {}
                if 单位.法宝已扣 then
                    单位.法宝已扣 = {}
                end
                if 单位.神迹==1 then
                    for i,v in ipairs(self.技能数据.异常) do
                        if 单位.法术状态[v] then
                            table.insert(单独发送,{id=编号,名称=v,序号=5507})
                            self:取消状态(v,编号)
                        end
                    end
                end
                if 单位.神迹==3 and 单位.主人 and self.参战单位[单位.主人] and self.参战单位[单位.主人].气血>0 and self.参战单位[单位.主人].法术状态 then
                      local 状态名称=DeepCopy(self.技能数据.异常)
                      for i,v in ipairs(状态名称) do
                          if 单位.法术状态[v] then
                              table.insert(单独发送,{id=单位.主人,名称=v,序号=5507})
                              self:取消状态(v,单位.主人)
                          end
                      end
                end
                for 名称, 状态 in pairs(单位.法术状态) do
                      if not 状态.回合 then
                           -- error("状态:"..名称..",玩家id:"..单位.玩家id.." 缺少状态回合数")
                            __gge.print(true,12,"状态:"..名称..",玩家id:"..单位.玩家id.." 缺少回合数")
                            self:取消状态(名称, 编号)
                      else
                          local 回合减少 = not ((名称 == "变身" or 名称 == "狂怒") and
                                            单位.气血 <= 0 and
                                            单位.奇经八脉 and
                                            单位.奇经八脉.屏息 and
                                            取随机数() <= 70)
                          if 回合减少 then
                              状态.回合 = 状态.回合 - 1
                          end
                          if 状态.回合 <= 0 then
                              --self:处理到期状态(单位, 编号, 名称, 状态, 单独发送)
                                if 名称 ~= "复活" then
                                    table.insert(单独发送, {id = 编号, 名称 = 名称, 序号 = 5507})
                                    if 名称 == "乾坤玄火塔" then
                                        local 增加 = math.floor(150 * (math.floor(状态.境界 / 5) * 0.02 + 0.02))
                                        self:增加愤怒(单位.编号,增加)
                                    elseif 名称 == "分身术" then
                                        状态.破解 = nil
                                    elseif 名称 == "无尘扇" then
                                        单位.愤怒 = math.max(math.floor(单位.愤怒 * 0.9), 0)
                                    elseif 名称 == "渡劫金身" and 单位.气血 > 0 then
                                        单位.气血 = math.min(单位.气血 * 2, 单位.气血上限)
                                        table.insert(单独发送, {id = 编号,气血 = 单位.气血,序号 = 5508})
                                    end
                                    self:取消状态(名称, 编号)
                                else
                                    单位.气血 = 单位.最大气血
                                    单位.法术状态[名称] = nil
                                    table.insert(单独发送, {id = 编号,气血 = 单位.最大气血,序号 = 5508})
                                end
                          end
                      end
                end
                if 单位.类型=="角色" and 单位.玩家id and 单位.玩家id~=0 and 单位.灵元
                  and 单位.灵宝佩戴 and self.回合数%(单位.灵元.回合-1)==0 then
                    单位.灵元.数值 = 单位.灵元.数值+1
                    self:添加提示(单位.玩家id,单位.编号,"#Y当前灵元增加了1点,可用灵元:"..单位.灵元.数值)
                end
                 --单位.灵元.数值 = 单位.灵元.数值+10
               self:回合结束处理(单位,单独发送) ----奇经八脉
               local 返回数据 = self:取战斗状态(单位)
               客户数据.状态[编号]=返回数据.状态 or {}
               客户数据.气血[编号]=返回数据.气血 or {}
               客户数据.冷却[编号]=返回数据.冷却 or {}
          end

          for k,v in pairs(self.参战玩家) do
              for i,n in ipairs(单独发送) do
                  发送数据(v.连接id,n.序号,n)
              end
              发送数据(v.连接id,5519,客户数据.状态)
              发送数据(v.连接id,5522,客户数据.冷却)
              发送数据(v.连接id,5520,客户数据.气血)
          end
          self:设置命令处理()
          for k,v in pairs(self.观战玩家) do
                if 玩家数据[k] then
                    for i,n in ipairs(单独发送) do
                        发送数据(玩家数据[k].连接id,n.序号,n)
                    end
                    发送数据(玩家数据[k].连接id,5519,客户数据.状态)
                end
          end



end

function 战斗处理类:回合结束处理(单位,单独发送)
          local 添加表 = {流程=50,攻击方=单位.编号,挨打方={}}
          if 单位.奇经八脉悟彻 then
              单位.谆谆教诲 = nil
              单位.奇经八脉悟彻 = nil
          end
          if 单位.奇经八脉催迫完成 then
              单位.奇经八脉催迫完成 = nil
              单位.奇经八脉催迫加成 = nil
          end
          if 单位.奇经八脉扑袭前置 then
              单位.奇经八脉扑袭 = 1
              单位.奇经八脉扑袭前置 = nil
          end

          if 单位.奇经八脉.薪火 then
              if self:取装备五行(单位.编号, 3) == "火" then
                  单位.法伤 = (单位.法伤 or 0) + 2
              end
              if self:取装备五行(单位.编号, 4) == "火" then
                  单位.法伤 = (单位.法伤 or 0) + 2
              end
          end

          if 单位.奇经八脉.灵威 and 取随机数() <= 20 then
              self:增加愤怒(单位.编号,12)
              table.insert(添加表.挨打方, {挨打方=单位.编号,特效={"加蓝"}})
          end
          if 单位.奇经八脉.剑气 then
              单位.物理暴击等级 = (单位.物理暴击等级 or 0) + 4
          end
          if 单位.奇经八脉.静岳 and not 单位.法术状态.护盾 then
              self:添加状态("护盾", 单位.编号, 单位.编号, 单位.等级)
              table.insert(添加表.挨打方, {挨打方=单位.编号,添加状态={
                    护盾={
                      回合=单位.法术状态.护盾.回合,
                      护盾值=单位.法术状态.护盾.护盾值
                    },
                }})
          end
          if 单位.奇经八脉.心浪 and 单位.愤怒 and 单位.愤怒 < 50 then
              self:增加愤怒(单位.编号,取随机数(1, 15))
              table.insert(添加表.挨打方, {挨打方=单位.编号,特效={"加蓝"}})
          end
          if 单位.法术状态.钟馗论道 then
              if 单位.法术状态.锢魂术 then
                  单位.法术状态.锢魂术.回合 = 单位.法术状态.锢魂术.回合 - 1
              end
              if 单位.法术状态.死亡禁锢 then
                  单位.法术状态.死亡禁锢.回合 = 单位.法术状态.死亡禁锢.回合 - 1
              end
          end

          if 单位.奇经八脉.燎原 and 单位.法术状态.牛劲 then
              if 单位.秘传三昧真火 then 单位.秘传三昧真火 = 单位.秘传三昧真火 - 1 end
              if 单位.秘传飞砂走石 then 单位.秘传飞砂走石 = 单位.秘传飞砂走石 - 1 end
          end
          if 单位.奇经特效.风灵 and self.回合数 % 2 == 0 and not 单位.奇经八脉.法身 then
              单位.风灵 = (单位.风灵 or 0) + 1
          end


          if 单位.奇经八脉.慈心 and 单位.气血 > 0 then
              local 移除异常 = {"死亡召唤", "锢魂术"}
              for i = 1, #self.参战单位 do
                  if i ~= 单位.编号 and self.参战单位[i].队伍 == 单位.队伍 then
                      local 目标 = self.参战单位[i]
                      if (目标.法术状态.死亡召唤 and 目标.法术状态.死亡召唤.回合 <= 2) or
                         (目标.法术状态.锢魂术 and 目标.法术状态.锢魂术.回合 <= 2) then
                          self:解除状态组(单位.编号, i, 移除异常)
                          单位.奇经八脉慈心 = 5
                          if 目标.法术状态.死亡召唤 and 目标.法术状态.死亡召唤.回合 <= 2 then
                              self:取消状态("死亡召唤", 单位.编号)
                              table.insert(单独发送,{id=单位.编号,名称="死亡召唤",序号=5507})
                          end
                          if 目标.法术状态.锢魂术 and 目标.法术状态.锢魂术.回合 <= 2 then
                              self:取消状态("锢魂术", 单位.编号)
                              table.insert(单独发送,{id=单位.编号,名称="锢魂术",序号=5507})
                          end
                      end
                  end
              end
          end




          if 单位.奇经八脉.调息 and 单位.法术状态.分身术 then
              local 气血恢复 = math.floor(单位.最大气血 * 0.05)
              self:增加气血(单位.编号, 气血恢复)
              self:增加魔法(单位.编号, math.floor(单位.最大魔法 * 0.03))
              table.insert(添加表.挨打方, {挨打方=单位.编号,伤害=气血恢复,类型=2})
          end

          if 单位.奇经八脉.轮回 and self:取是否单独门派(单位.编号) then
              local 状态数量 = 0
              for i = 1, #self.参战单位 do
                  if self.参战单位[i].队伍 ~= 单位.队伍 and self.参战单位[i].法术状态.尸腐毒 then
                      状态数量 = 状态数量 + 1
                  end
              end
              if 状态数量 >= 6 then
                  self:取消状态("轮回",单位.编号)
                  self:添加状态("轮回", 单位.编号, 单位.编号, 单位.等级)
                  table.insert(添加表.挨打方, {挨打方=单位.编号,添加状态={
                    轮回={
                      回合=单位.法术状态.轮回.回合,
                      护盾值=单位.法术状态.轮回.护盾值
                    },
                }})
              end
          end
          if 单位.奇经八脉苏醒 and 单位.气血 > 0 and 单位.奇经八脉苏醒 >= 单位.最大气血 * 0.3 then

              单位.奇经八脉苏醒 = nil
              单位.奇经八脉慧眼 = nil
              table.insert(添加表.挨打方, {挨打方=单位.编号,取消状态=self:解除状态组(单位.编号, 单位.编号, self.技能数据.封印)})
          end
          if 单位.风灵 then
              local 最大风灵 = 6
              if 单位.法术状态 and 单位.法术状态.风舞心经 and 单位.法术状态.风舞心经.境界 > 4 then
                  最大风灵 = 单位.法术状态.风舞心经.境界
              end
              单位.风灵 = math.min(单位.风灵, 最大风灵)
          end
          if 单位.奇经八脉.结阵 then
              for i = 1, #self.参战单位 do
                  if self.初始属性[i] and self.参战单位[i] and self.参战单位[i].队伍 ~= 单位.队伍 and
                     self.参战单位[i].速度 > self.初始属性[i].速度 * 0.8 then
                      self.参战单位[i].速度 = self.参战单位[i].速度 - 2
                  end
              end
          end

          if 单位.奇经八脉.蓄志 and 单位.法术状态.炼气化神 and 单位.法术状态.生命之泉 then
              self:增加愤怒(单位.编号,3)
          end
          if 单位.奇经八脉羁绊 and 单位.气血 > 0 then
              self:增加气血(单位.编号, 单位.奇经八脉羁绊)
              table.insert(添加表.挨打方, {挨打方=单位.编号,伤害=单位.奇经八脉羁绊,类型=2})
              单位.奇经八脉羁绊 = nil
          end
          if 单位.神器技能 then
              if 单位.神器技能.名称 == "澄明" then
                  local 临时数额 = 单位.神器技能.等级 * 3
                  单位.抵抗封印等级 = (单位.抵抗封印等级 or 0) + 临时数额
              elseif 单位.神器技能.名称 == "相思" then
                      if (单位.神器技能.等级 == 1 and self.回合数 % 2 == 0) or 单位.神器技能.等级 == 2 then
                          单位.速度 = (单位.速度 or 0) + 3
                      end
              elseif 单位.神器技能.名称 == "弦外之音" then
                      local 临时数额 = 单位.神器技能.等级 * 3
                      local 数量 = 0
                      for i = 1, 4 do
                          if 单位.法宝佩戴[i] and self:取主动法宝(单位.法宝佩戴[i].名称) then
                              数量 = 数量 + 1
                          end
                      end
                      self:增加愤怒(单位.编号,math.floor(临时数额 * 数量))
                      table.insert(添加表.挨打方, {挨打方=单位.编号,特效={"加蓝"}})
              end
          end
          if 单位.奇经八脉.利刃 then
            for i = 1, #self.参战单位 do
                if self.参战单位[i] and self.参战单位[i].队伍 ~= 单位.队伍 and self.参战单位[i].气血 > 0 then
                    self:减少魔法(i,30)
                    table.insert(添加表.挨打方, {挨打方=i,特效={"加蓝"}})
                end
            end
          end

          if 单位.奇经八脉.意境 then
              for i = 1, #self.参战单位 do
                  if self.参战单位[i] and self.参战单位[i].气血 > 0 and self.参战单位[i].队伍 == 单位.队伍 then
                      self:增加魔法(i,24)
                      self:增加愤怒(i,1)
                       table.insert(添加表.挨打方, {挨打方=i,特效={"加蓝"}})
                  end
              end
          end

          if 单位.门派 == "凌波城" then
              if 单位.法术状态.智眼 then
                   self:凌波添加战意(单位,1)
              end
              if 单位.法术状态.真君显灵 then
                  self:凌波添加战意(单位,1)
              end
          elseif 单位.门派 == "方寸山" and 单位.奇经特效.咒符 then
                单位.符咒 = (单位.符咒 or 0) + 取随机数(1, 5)
                if 单位.奇经八脉.咒诀 then
                    local 加持 = 0
                    for _, v in pairs(单位.雷法 or {}) do
                        if v ~= 0 then 加持 = 加持 + 1 end
                    end
                    if 加持 <= 0 then
                        单位.符咒 = 单位.符咒 + 取随机数(3, 5)
                    end
                    单位.符咒 = math.min(单位.符咒, 5)
                end
          end
          if 单位.法术状态.瘴气 and 单位.法术状态.天罗地网 and 单位.法术状态.天罗地网.编号 and 取随机数() <= 32 then
              local 攻击单位 = 单位.法术状态.天罗地网.编号
              if 攻击单位 and self.参战单位[攻击单位] and self.参战单位[攻击单位].奇经八脉 and self.参战单位[攻击单位].奇经八脉.障眼 then
                  单位.法术状态.天罗地网.回合 = 单位.法术状态.天罗地网.回合 + 1
              end
          end


          if 单位.法术状态.含情脉脉 and 单位.法术状态.含情脉脉.编号 then
              local 攻击单位 = 单位.法术状态.含情脉脉.编号
              if self.参战单位[攻击单位] and self.参战单位[攻击单位].奇经八脉 and self.参战单位[攻击单位].奇经八脉.安抚 then
                  self:增加愤怒(攻击单位,4)
                  table.insert(添加表.挨打方, {挨打方=攻击单位,特效={"加蓝"}})
              end
          end
          if 单位.法术状态.魔音摄魂 and 单位.法术状态.魔音摄魂.编号 then
              local 攻击单位 = 单位.法术状态.魔音摄魂.编号
              if self.参战单位[攻击单位] and self.参战单位[攻击单位].奇经八脉 and self.参战单位[攻击单位].奇经八脉.安抚 then
                  self:增加愤怒(攻击单位,4)
                  table.insert(添加表.挨打方, {挨打方=攻击单位,特效={"加蓝"}})
              end
          end
          if 单位.奇经八脉致命 and 单位.气血 < 单位.最大气血 * 0.08 then
              if 单位.类型 == "角色" then
                  local 死亡状态 = self:减少气血(单位.编号, 单位.气血, 单位.奇经八脉致命, "奇经八脉")
                  table.insert(添加表.挨打方, {挨打方=单位.编号,伤害=单位.气血,类型=1,死亡=死亡状态})
              else
                  local 气血 = self.参战单位[单位.奇经八脉致命].等级 * 8
                  local 死亡状态 = self:减少气血(单位.编号, 气血, 单位.奇经八脉致命, "奇经八脉")
                  table.insert(添加表.挨打方, {挨打方=单位.编号,伤害=气血,类型=1,死亡=死亡状态})
              end
          end
          table.insert(self.战斗流程, 添加表)
          if 单位.气血 <= 0 and 单位.召唤兽 and 单位.奇经八脉.救主 and  self.参战单位[单位.召唤兽] and self.参战单位[单位.召唤兽].气血 > 0 and
              self:取行动状态(单位.召唤兽) then
              if 单位.门派 == "狮驼岭" and 取随机数() <= 50 and
                 not 单位.法术状态.魔音摄魂 and not 单位.法术状态.死亡召唤 and not 单位.法术状态.锢魂术 then

                  local 是否找到 = 0
                  local 背包id = 0
                  for n, v in pairs(玩家数据[单位.玩家id].角色.数据.道具) do
                      if 玩家数据[单位.玩家id].道具.数据[v] and 玩家数据[单位.玩家id].道具.数据[v].名称 == "九转回魂丹" then
                          是否找到 = v
                          背包id = n
                          break
                      end
                  end

                  if 是否找到 ~= 0 then
                      local 临时数值 = 玩家数据[单位.玩家id].道具:取加血道具1("九转回魂丹", 是否找到)
                      local 基础 = DeepCopy(self.计算属性)
                      基础.初始伤害 = 临时数值
                      local 结果 = self:取基础治疗计算(单位.召唤兽, 单位.编号, "九转回魂丹", 单位.等级, 基础)

                      self:恢复伤势(单位.编号,结果.气血)
                      self:增加气血(单位.编号,结果.气血)

                      local 流程 = {流程 = 27,攻击方 = 单位.召唤兽,
                          挨打方 = {{
                              挨打方 = 单位.编号,
                              特效 = {"加血"},
                              伤势 = 结果.气血,
                              伤势类型 = 2,
                              伤害 = 结果.气血,
                              类型 = 2,
                              复活 = true
                          }},
                          提示 = {
                              允许 = true,
                              类型 = "复活",
                              名称 = "九转回魂丹"
                          }
                      }
                      table.insert(self.战斗流程, 流程)
                      table.insert(self.执行复活, 单位.编号)
                      self.回合复活 = true
                      if 玩家数据[单位.玩家id].道具.数据[是否找到].数量 then
                          玩家数据[单位.玩家id].道具.数据[是否找到].数量 = 玩家数据[单位.玩家id].道具.数据[是否找到].数量 - 1
                          if 玩家数据[单位.玩家id].道具.数据[是否找到].数量 <= 0 then
                              玩家数据[单位.玩家id].道具.数据[是否找到] = nil
                              玩家数据[单位.玩家id].角色.数据.道具[背包id] = nil
                          end
                      else
                          玩家数据[单位.玩家id].道具.数据[是否找到] = nil
                          玩家数据[单位.玩家id].角色.数据.道具[背包id] = nil
                      end
                  end
              end

        -- 神木林救人
              if 单位.门派 == "神木林" and not 单位.奇经八脉神木救人 then
                  local 救人编号 = 单位.召唤兽
                  self.参战单位[救人编号].灵药 = self.参战单位[救人编号].灵药 or {红=0, 蓝=0, 黄=0}
                  self.参战单位[救人编号].奇经八脉 = self.参战单位[救人编号].奇经八脉 or {}
                  self.参战单位[救人编号].灵药.红 = self.参战单位[救人编号].灵药.红 + 1
                  self.参战单位[救人编号].灵药.蓝 = self.参战单位[救人编号].灵药.蓝 + 1
                  self.参战单位[救人编号].灵药.黄 = self.参战单位[救人编号].灵药.黄 + 1
                  local 额外命令 = {目标 = 单位.编号, 名称 = "百草复苏"}
                  self:法术攻击处理(救人编号, 额外命令)
              end
          end
          local 处理状态 = {
              "奇经八脉天照", "奇经八脉再战", "奇经八脉追袭", "奇经八脉骇浪", "奇经八脉奉还加成",
              "奇经八脉摧心前置", "琴音三叠", "奇经八脉炼魂", "映日妙舞减伤", "轻歌飘舞加成",
              "乐韵加成", "奇经八脉戏珠", "奇经八脉破浪", "奇经八脉连营", "奇经八脉折服",
              "奇经八脉焰威", "奇经八脉花护", "奇经八脉磐石", "奇经八脉跃动", "奇经八脉情劫",
              "奇经八脉倾情", "奇经八脉秘术", "奇经八脉秘术前置", "奇经八脉慧眼", "奇经八脉冰锥",
              "奇经八脉追击", "奇经八脉伏毒", "奇经八脉苍埃", "奇经八脉羁绊", "奇经八脉苏醒",
              "奇经八脉守势", "奇经八脉陷阱削弱", "奇经八脉致命", "奇经八脉狮驼怒火",
              "奇经八脉凌波混元", "神器技能风起云墨", "神器技能魂魇"
          }
          for _, v in ipairs(处理状态) do
              单位[v] = nil
          end


end


function 战斗处理类:飞镖计算(编号,id组)
      self.执行等待=self.执行等待+5
      local 流程={流程=57,攻击方=编号,挨打方={}}
      for n=1,#id组 do
          if self:取目标状态(编号,id组[n].id,1) then
              流程.挨打方[#流程.挨打方+1]={挨打方=id组[n].id,伤害=id组[n].伤害}
              流程.挨打方[#流程.挨打方].死亡=self:减少气血(id组[n].id,id组[n].伤害,编号,"飞镖")
          end
      end
      table.insert(self.战斗流程,流程)
end

function 战斗处理类:妙手空空计算(编号, 名称, 等级)
    local 目标 = self.参战单位[编号].指令.目标
    local id = self.参战单位[编号].玩家id
    if not 目标 or not self.参战单位[目标] or self.参战单位[目标].气血 <= 0 then
        self:添加提示(id, 编号, "#Y/对方已经死了，你忍心从尸体上偷东西？")
        return
    end
    if self.战斗类型 ~= 100001 and self.战斗类型 ~= 100007 then
        return
    end
    if self.参战单位[目标].偷盗 then
        self:添加提示(id, 编号, "#Y/对方身上已经没有宝物了")
        return
    end
    if not self:魔法消耗(编号,self.参战单位[目标].等级,1,"妙手空空") then
        return
    end

    self.执行等待 = self.执行等待 + 5
    if not self.参战单位[目标].精灵 then
        self.参战单位[目标].偷盗 = true
        self:添加提示(id, 编号, "对方发觉了你这个行为，机灵地躲过去了！")
        return
    end
    if 等级 * 10 >= 取随机数() then
        if 取随机数(1, 100) <= 50 and 变身卡数据[self.参战单位[目标].模型] then
            玩家数据[id].道具:给予道具(id, "怪物卡片", 变身卡数据[self.参战单位[目标].模型].等级, self.参战单位[目标].模型)
            self:添加提示(id, 编号, "你得到了#R/怪物卡片")
        else
            self:添加提示(id, 编号, "对方发觉了你这个行为，机灵地躲过去了！")
        end
        self.参战单位[目标].偷盗 = true
    else
        self:添加提示(id, 编号, "对方发觉了你这个行为，机灵地躲过去了！")
    end
end


function 战斗处理类:添加提示(id,编号,内容)
          if not 编号 then
               __gge.print(true,12,"提示缺少编号,内容:"..内容..",序号:"..self.战斗类型..",ID:"..id.."\n")
          elseif not self.战斗流程 then
                  __gge.print(true,12,"提示缺少流程,内容:"..内容..",序号:"..self.战斗类型..",ID:"..id.."\n")
          elseif not  self.参战单位[编号] then
                  __gge.print(true,12,"提示缺少单位,内容:"..内容..",序号:"..self.战斗类型..",ID:"..id.."\n")
          elseif self.参战单位[编号].队伍~=0 and id~=0 then
                  table.insert(self.战斗流程,{流程=52,攻击方=编号,id=id,内容=内容})
          end




end


function 战斗处理类:添加聊天提示(id,编号,内容)
        if not 编号 then
               __gge.print(true,12,"聊天缺少编号,内容:"..内容..",序号:"..self.战斗类型..",ID:"..id.."\n")
        elseif not  self.参战单位[编号] then
                __gge.print(true,12,"聊天缺少单位,内容:"..内容..",序号:"..self.战斗类型..",ID:"..id.."\n")
        elseif self.参战单位[编号].队伍~=0 then
                发送数据(玩家数据[id].连接id,38,内容)
        end
end



function 战斗处理类:添加发言(编号,文本)
        if not 编号 then
              __gge.print(true,12,"发言缺少编号,内容:"..文本..",序号:"..self.战斗类型.."\n")
        elseif not  self.参战单位[编号] then
              __gge.print(true,12,"发言缺少单位,内容:"..文本..",序号:"..self.战斗类型.."\n")
        elseif self.参战单位[编号].队伍~=0 then
              table.insert(self.发言数据, {id=编号,内容=文本})
        end

end
function 战斗处理类:添加即时发言(编号,文本)
        if not 编号 then
              __gge.print(true,12,"发言缺少编号,内容:"..文本..",序号:"..self.战斗类型.."\n")
        elseif not  self.参战单位[编号] then
              __gge.print(true,12,"发言缺少单位,内容:"..文本..",序号:"..self.战斗类型.."\n")
        else
            for k,v in pairs(self.参战玩家) do
              发送数据(v.连接id,5512,{id=编号,文本=文本})
            end
        end
end

function 战斗处理类:添加危险发言(编号,类型)
        if self.参战单位[编号].队伍~=0 then
            local 已发言=false
            for n=1,#self.参战单位 do
                if 已发言==false and self.参战单位[n].队伍==self.参战单位[编号].队伍 then
                    if self.参战单位[n].预知特性~=nil  then
                        if self.参战单位[n].预知次数<3 and self.参战单位[n].预知特性*7>=取随机数() then
                          self.参战单位[n].预知次数=self.参战单位[n].预知次数+1
                           self:添加发言(n,self:取危险发言内容(self.参战单位[编号].名称,类型))
                           已发言=true
                        end
                    end
                end
            end
            for k,v in pairs(self.参战玩家) do
                for i,n in ipairs(self.发言数据) do
                  发送数据(v.连接id,5512,{id=n.id,文本=n.内容})
                end
            end
            self.发言数据 = {}
        end
end

function 战斗处理类:取危险发言内容(名称,类型)
  local 发言内容={}
  if 类型==1 then --死亡
    发言内容={format("#G/%s#W我的直觉告诉我你活不过本回合#74",名称),format("让我们高歌欢舞恭送#G/%s#83",名称),format("唢呐吹起来，锣鼓敲起来，我们的#G/%s#W/倒下来#42",名称)}
  elseif 类型==2 then --重伤
    发言内容={format("#G/%s#W看起来伤势很重啊#52",名称),format("#G/%s#W你再不注意加血，当心我在你坟头上蹦迪哈#24",名称),format("#G/%s#W/你是长相有问题还是内心太黑暗呢#55",名称)}
  end
  return 发言内容[取随机数(1,#发言内容)]
end





function 战斗处理类:取行动状态(编号)
    if self.参战单位[编号].气血 <= 0 or self.参战单位[编号].捕捉 or self.参战单位[编号].逃跑 then
        return false
    end
    local 法术状态 = self.参战单位[编号].法术状态 or {}
    if 法术状态.横扫千军
       or 法术状态.誓血之祭
       or 法术状态.破釜沉舟
       or 法术状态.乾坤妙法
       or 法术状态.落花成泥
       or 法术状态.飞花摘叶
    then
        return false
    end
    if (法术状态.催眠符 and not (self.参战单位[编号].指令 and self.参战单位[编号].指令.类型 == "召唤")) or
       (self.参战单位[编号].精灵 and self.回合数 == 1) or
        self.参战单位[编号].类型 == "测试" then
        return false
    end

    return true
end


function 战斗处理类:取攻击状态(编号)
    local 法术状态 = self.参战单位[编号].法术状态 or {}
    if  法术状态.鹰击
        or 法术状态.象形
        or 法术状态.威慑
        or 法术状态.连环击
        or 法术状态.冰川怒
        or 法术状态.煞气诀
        or 法术状态.催眠符
        or 法术状态.追魂符
        or 法术状态.定身符
        or 法术状态.如花解语
        or 法术状态.似玉生香
        or 法术状态.百万神兵
        or 法术状态.日月乾坤
        or 法术状态.含情脉脉
        or 法术状态.落花成泥
        or 法术状态.飞花摘叶
        or 法术状态.横扫千军
        or 法术状态.誓血之祭
        or 法术状态.楚楚可怜
    then
        return false
    end
    if self.参战单位[编号].奇经八脉 and self.参战单位[编号].奇经八脉.慧眼 then
        return false
    end
    return true
end

function 战斗处理类:取法术状态(编号, 名称)
    local 法术状态 = self.参战单位[编号].法术状态 or {}
    if 法术状态.鹰击
        or 法术状态.象形
        or 法术状态.威慑
        or 法术状态.诱袭
        or 法术状态.错乱
        or 法术状态.连环击
        or 法术状态.冰川怒
        or 法术状态.煞气诀
        or 法术状态.催眠符
        or 法术状态.落魄符
        or 法术状态.失心符
        or 法术状态.离魂符
        or 法术状态.失魂符
        or 法术状态.夺魄令
        or 法术状态.反间之计
        or 法术状态.似玉生香
        or 法术状态.修罗隐身
        or 法术状态.日月乾坤
        or 法术状态.含情脉脉
        or 法术状态.落花成泥
        or 法术状态.飞花摘叶
        or 法术状态.横扫千军
        or 法术状态.誓血之祭
        or 法术状态.楚楚可怜
        or 法术状态.锋芒毕露
        or 法术状态.一笑倾城
        or 法术状态.莲步轻舞
        or 法术状态.妖风四起
        or 法术状态.顺势而为
    then
        return false
    end
    if self.参战单位[编号].奇经八脉慧眼 then
        return false
    end
    return true
end

function 战斗处理类:取特技状态(编号)
    local 法术状态 = self.参战单位[编号].法术状态 or {}
    if 法术状态.鹰击
        or 法术状态.象形
        or 法术状态.诱袭
        or 法术状态.连环击
        or 法术状态.冰川怒
        or 法术状态.煞气诀
        or 法术状态.催眠符
        or 法术状态.失忆符
        or 法术状态.娉婷袅娜
        or 法术状态.反间之计
        or 法术状态.锋芒毕露
        or 法术状态.日月乾坤
        or 法术状态.横扫千军
        or 法术状态.誓血之祭
        or 法术状态.楚楚可怜
    then
        return false
    end

    return true
end


function 战斗处理类:取休息状态(编号)
        return self.参战单位[编号].法术状态.横扫千军 or false
end

function 战斗处理类:取可否防御(挨打方)
          local 法术状态 = self.参战单位[挨打方].法术状态 or {}
          if 法术状态.催眠符
              or 法术状态.横扫千军
              or 法术状态.楚楚可怜
              or 法术状态.破釜沉舟
          then
             return false
          end
          return true
end




function 战斗处理类:解除所有经脉异常(目标)
          for i,v in ipairs(self.技能数据.经脉异常) do
              if self.参战单位[目标][v] then
                  self.参战单位[目标][v] = nil
              end
          end
end




function 战斗处理类:取异常数量(目标)
        local 数量 = 0
        for i,v in ipairs(self.技能数据.异常) do
            if self.参战单位[目标].法术状态[v] then
                数量 = 数量 + 1
            end
        end
        for i,v in ipairs(self.技能数据.经脉异常) do
            if self.参战单位[目标][v] then
                数量 = 数量 + 1
            end
        end
      return 数量
end

function 战斗处理类:随机对方增益状态(目标)
          local 临时技能 = {}
          for i,v in ipairs(self.技能数据.增益) do
              if self.参战单位[目标].法术状态[v] then
                  table.insert(临时技能,v)
              end
          end
          if #临时技能 > 0 then
            return 临时技能[取随机数(1,#临时技能)]
          end
end


function 战斗处理类:随机取消经脉增益(目标)
          local 临时 = {}
          for i,v in ipairs(self.技能数据.经脉增益) do
              if self.参战单位[目标][v] then
                  table.insert(临时,v)
              end
          end
          if #临时 > 0 then
             self.参战单位[目标][临时[取随机数(1,#临时)]] = nil
          end
end

function 战斗处理类:取增益数量(目标)
        local 数量 = 0
        for i,v in ipairs(self.技能数据.增益) do
            if self.参战单位[目标].法术状态[v] then
                数量 = 数量 + 1
            end
        end
        for i,v in ipairs(self.技能数据.经脉增益) do
              if self.参战单位[目标][v] then
                  数量 = 数量 + 1
              end
        end
        return 数量
end


function 战斗处理类:取封印状态(编号)
              for i,v in ipairs(self.技能数据.封印) do
                   if self.参战单位[编号].法术状态[v] then
                        return true
                   end
              end
          return false
end




function 战斗处理类:取友封印数量(编号)
          local 数量 = 0
          for i,v in ipairs(self.参战单位) do
              if v.气血>=1 and v.队伍==self.参战单位[编号].队伍 and self:取封印状态(i) then
                     数量=数量+1
              end
          end
          return 数量
end



function 战斗处理类:取法宝封印状态(编号)
    for i,v in ipairs(self.技能数据.法宝异常) do
         if self.参战单位[编号].法术状态[v] then
          return true
         end
    end
    return false
end

function 战斗处理类:取门派封印法术(门派)
    if 门派=="方寸山" then
      return {"催眠符","失心符","落魄符","失忆符","追魂符","离魂符","失魂符","定身符"}
    elseif  门派=="女儿村" then
      return {"莲步轻舞","如花解语","似玉生香","一笑倾城"}
    elseif  门派=="盘丝洞" then
      return {"含情脉脉","魔音摄魂","天罗地网"}
    elseif  门派=="无底洞" then
      return {"夺魄令","煞气诀","惊魂掌","摧心术"}
    elseif  门派=="天宫" then
      return {"错乱","百万神兵"}
    elseif  门派=="神木林" then
      return {"冰川怒"}
    end
end


function 战斗处理类:取主动法宝(名称)
      for i,v in ipairs(self.技能数据.主动法宝) do
            if 名称 == v then
              return true
            end
      end
     return false
end





--==============================================================================================灵宝
function 战斗处理类:取装备宝石数量(编号,序号,名称)
          local 数量 = 0
          if self.参战单位[编号].类型 =="角色" and self.参战单位[编号].装备l  then
            if self.参战单位[编号].装备[序号] and self.参战单位[编号].装备[序号].镶嵌类型~=nil then
                for i=1,#self.参战单位[编号].装备[序号].镶嵌类型 do
                  if self.参战单位[编号].装备[序号].镶嵌类型[i] == 名称 then
                     数量 = 数量 + 1
                   end
                end
            end
          end
    return  数量
end

function 战斗处理类:取装备五行(编号,序号)
          local 数量 = "无"
          if self.参战单位[编号].类型 =="角色" and self.参战单位[编号].装备  then
              if self.参战单位[编号].装备[序号]~=nil and self.参战单位[编号].装备[序号].五行~=nil then
                  数量 = self.参战单位[编号].装备[序号].五行
              end
          end
    return 数量
end



function 战斗处理类:取队伍奇经八脉(编号,名称)
         local 找到 = false
          if 编号~=nil and 编号~=0 and self.参战单位[编号] and self.参战单位[编号].玩家id~=0 and 玩家数据[self.参战单位[编号].玩家id]~=nil then
                if 玩家数据[self.参战单位[编号].玩家id].队伍~=nil and 玩家数据[self.参战单位[编号].玩家id].队伍 ~= 0 then
                     local 队伍id = 玩家数据[self.参战单位[编号].玩家id].队伍
                     for i=1,#队伍数据[队伍id].成员数据 do
                          local 临时id = 队伍数据[队伍id].成员数据[i]
                          if 玩家数据[临时id].奇经八脉[名称]~=nil then
                             return true
                          end
                      end
                elseif 玩家数据[self.参战单位[编号].玩家id].奇经八脉[名称] then
                    return true
                end
          end
          return false
end



function 战斗处理类:取五行克制(攻击, 挨打)
    local 五行克制 = {
        金 = "木",
        木 = "土",
        水 = "火",
        土 = "水",
        火 = "金"
    }
    return 五行克制[攻击] == 挨打
end

function 战斗处理类:取五行相生(攻击, 挨打)
    local 五行相生 = {
        金 = "水",
        木 = "火",
        水 = "木",
        火 = "土",
        土 = "金"
    }
    return 五行相生[攻击] == 挨打
end



function 战斗处理类:取是否单独门派(编号)
         local 找到 = true
          for i=1,#self.参战单位 do
              if self.参战单位[i]~=nil and  i~=编号 and  self.参战单位[i].队伍id ==self.参战单位[编号].队伍id then
                 if self.参战单位[i].门派~=nil  and self.参战单位[i].门派 == self.参战单位[编号].门派 then
                   找到=false
                 end
             end
          end

      return 找到
end




function 战斗处理类:套装触发几率(编号,概率)
          if not 概率 then 概率 = 0 end
          if self.参战单位[编号].奇经八脉.笃志 then
             概率 = 概率+15
          end
          if self.参战单位[编号].奇经八脉.肃杀 and self.参战单位[编号].法术状态.杀气诀 then
             概率 = 概率*1.32
          end
          if self.参战单位[编号].奇经八脉.破刃 and 取随机数()<=50 then
             概率 = 概率*1.2
          end
          if self.参战单位[编号].奇经八脉潜心~=nil then
             概率 = 概率*2
          end
  return math.floor(概率)
end


function 战斗处理类:取玩家战斗()
    if self.战斗类型==200001 or self.战斗类型==200002 or self.战斗类型==200003
       or self.战斗类型==200004 or self.战斗类型==200005 or self.战斗类型==200006
       or self.战斗类型==200003 or self.战斗类型==200007 or self.战斗类型==200008
       or self.战斗类型==110001 or self.战斗类型==410005 then
        return true
    else
        return false
    end
end

function 战斗处理类:取副本战斗()
    if self.战斗类型==130038 or self.战斗类型==130039 or self.战斗类型==130040  then
        return true
    else
        return false
    end
end


function 战斗处理类:取指定法宝(编号,名称,数额, 扣除)
          if not 编号 or not self.参战单位[编号] then
              return false
          end
          if self.参战单位[编号].类型 == "角色" and (not self.参战单位[编号].玩家id or not 玩家数据[self.参战单位[编号].玩家id]) then
              return false
          end
          local id = self.参战单位[编号].玩家id
          local 佩戴法宝 = self.参战单位[编号].法宝佩戴
          for n, 法宝 in pairs(佩戴法宝) do
              if 法宝.名称 == 名称 then
                  local 法宝id = 法宝.序列
                  local 境界 = 法宝.境界
                  if 数额 then
                      if (名称 == "金甲仙衣" and math.floor(境界*3) < 取随机数()) or
                         (名称 == "降魔斗篷" and math.floor(境界*3) < 取随机数()) or
                         (名称 == "嗜血幡" and math.floor(境界*3) < 取随机数()) then
                          return false
                      end
                  end
                  if not 数额 or 扣除 or (self.参战单位[编号].法宝已扣 and self.参战单位[编号].法宝已扣[名称]) then
                      return 境界
                  end
                  if 玩家数据[id].道具.数据[法宝id].魔法 >= 数额 then
                      玩家数据[id].道具.数据[法宝id].魔法 = 玩家数据[id].道具.数据[法宝id].魔法 - 数额
                      发送数据(id, 38, {内容=string.format("你的法宝[%s]灵气减少了%d点", 玩家数据[id].道具.数据[法宝id].名称, 数额)})
                      self.参战单位[编号].法宝已扣 = self.参战单位[编号].法宝已扣 or {}
                      self.参战单位[编号].法宝已扣[名称] = true
                      return 境界
                  end
                  return false
              end
          end
          return false
end

-- function 战斗处理类:扣除法宝灵气(编号,序列,数额,类型)
--     local 扣除id=self.参战单位[编号].法宝佩戴[序列].序列
--     local id=self.参战单位[编号].玩家id

--     if 类型==nil then
--         if 玩家数据[id].道具.数据[扣除id].魔法<数额 then
--           return false
--         else
--             玩家数据[id].道具.数据[扣除id].魔法=玩家数据[id].道具.数据[扣除id].魔法-数额
--             发送数据(玩家数据[id].连接id,38,{内容="你的法宝["..玩家数据[id].道具.数据[扣除id].名称.."]灵气减少了"..数额.."点"})
--           return true
--         end
--       else
--           if 玩家数据[id].道具.数据[扣除id].魔法<取灵气上限(玩家数据[id].道具.数据[扣除id].分类) then
--             玩家数据[id].道具.数据[扣除id].魔法=玩家数据[id].道具.数据[扣除id].魔法+数额
--             发送数据(玩家数据[id].连接id,38,{内容="你的法宝["..玩家数据[id].道具.数据[扣除id].名称.."]灵气增加了"..数额.."点"})
--           else
--             发送数据(玩家数据[id].连接id,38,{内容="你的法宝["..玩家数据[id].道具.数据[扣除id].名称.."]灵气已经满了，无法再获得灵气"})
--           end
--     end
-- end

function 战斗处理类:魔法消耗(编号, 数值, 数量, 名称)
    local 消耗 = math.floor(数值 * 数量)
    if self.参战单位[编号].奇经八脉 and self.参战单位[编号].奇经八脉.威仪九霄 then
        消耗 = 消耗 + 100
    end
    if self.参战单位[编号].慧根 then
        消耗 = math.floor(消耗 * self.参战单位[编号].慧根)
        if self.参战单位[编号].超级慧根 and 取随机数() <= 30 then
            消耗 = 0
        end
    end
    if self.参战单位[编号].符石技能 and self.参战单位[编号].符石技能.飞檐走壁 then
        消耗 = math.floor(消耗 * (1 - self.参战单位[编号].符石技能.飞檐走壁 / 100))
    end
    if self.参战单位[编号].奇经八脉仁心 then
        消耗 = 消耗 + 140
    end
    if self.参战单位[编号].法术状态 and self.参战单位[编号].法术状态.魔息术 and self.参战单位[编号].法术状态.魔息术.魔息 then
        消耗 = 1
    end
    if self.参战单位[编号].魔法 < 消耗 then
        return false
    end
    self.参战单位[编号].魔法 = self.参战单位[编号].魔法 - 消耗
    if self.参战单位[编号].魔法 < 0 then self.参战单位[编号].魔法 = 0 end
    return true
end


function 战斗处理类:增加气血(编号,数额)
        self.参战单位[编号].气血=self.参战单位[编号].气血 + 数额
        if self.参战单位[编号].气血>self.参战单位[编号].最大气血 then
          self.参战单位[编号].气血=self.参战单位[编号].最大气血
        end
        if self.参战单位[编号].类型 == "角色" and  self.参战单位[编号].召唤兽~=nil and self.参战单位[编号].奇经八脉.羁绊 then
           local 参战编号 = self.参战单位[编号].召唤兽
           if 参战编号~=nil and  self.参战单位[参战编号]~=nil and self.参战单位[参战编号].气血>0 then
               self.参战单位[参战编号].奇经八脉羁绊 = math.floor(数额*0.15)
           end
        end
        if self.参战单位[编号].类型 == "bb" and  self.参战单位[编号].主人~=nil  then
           local 参战编号 = self.参战单位[编号].主人
           if 参战编号~=nil and  self.参战单位[参战编号]~=nil and self.参战单位[参战编号].气血>0 and self.参战单位[参战编号].奇经八脉.羁绊 then
               self.参战单位[参战编号].奇经八脉羁绊 = math.floor(数额*0.15)
           end
        end
end

function 战斗处理类:恢复伤势(编号,数额)
      if self.参战单位[编号].类型~="角色" then
          return
      end
      self.参战单位[编号].气血上限=self.参战单位[编号].气血上限+数额
      if self.参战单位[编号].气血上限>self.参战单位[编号].最大气血 then
        self.参战单位[编号].气血上限=self.参战单位[编号].最大气血
      end
end

function 战斗处理类:增加魔法(编号,数额)
      if self.参战单位[编号].法术状态.魔音摄魂~=nil  and self.参战单位[编号].法术状态.魔音摄魂.迷意~=nil then
          self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/你当前状态无法恢复魔法!")
          return
      end
      if self.参战单位[编号].法术状态.瘴气~=nil and self.参战单位[编号].法术状态.瘴气.迷意~=nil then
         数额 = 数额 * 0.7
      end


      self.参战单位[编号].魔法=self.参战单位[编号].魔法+数额
      if self.参战单位[编号].魔法>=self.参战单位[编号].最大魔法 then
         self.参战单位[编号].魔法=self.参战单位[编号].最大魔法
      end
end


function 战斗处理类:减少魔法(编号,数额)
          self.参战单位[编号].魔法=self.参战单位[编号].魔法-数额
          if self.参战单位[编号].魔法<0 then self.参战单位[编号].魔法=0 end

end
function 战斗处理类:增加愤怒(编号,数额)
          self.参战单位[编号].愤怒 = self.参战单位[编号].愤怒 or 0
          self.参战单位[编号].愤怒 = self.参战单位[编号].愤怒 + 数额
          if self.参战单位[编号].愤怒>150 and (self.参战单位[编号].类型=="角色" or self.参战单位[编号].主人)  then
               self.参战单位[编号].愤怒 = 150
          end
end

function 战斗处理类:减少愤怒(编号,数额)
          self.参战单位[编号].愤怒=self.参战单位[编号].愤怒-数额
          if self.参战单位[编号].愤怒<0 then self.参战单位[编号].愤怒=0 end
end

function 战斗处理类:愤怒消耗(编号, 数值, 名称)
    self.参战单位[编号].愤怒 = self.参战单位[编号].愤怒 or 0
    local 消耗 = 数值
    if self.参战单位[编号].愤怒腰带 then
        消耗 = math.floor(消耗 * 0.8)
    end
    if self.参战单位[编号].奇经八脉.傲娇 then
        消耗 = 消耗 - 4
    end
    if self.参战单位[编号].奇经八脉.天威 then
        消耗 = 消耗 - 8
    end
    if 名称 ~= "慈航普渡" and self.参战单位[编号].奇经八脉.修心
       and self.参战单位[编号].愤怒 < 消耗 and not self.参战单位[编号].奇经八脉修心 then
        local 扣除魔法 = 消耗 - self.参战单位[编号].愤怒
        消耗 = 消耗 - 扣除魔法
        if self.参战单位[编号].魔法 < 扣除魔法 then
            return false
        else
            self.参战单位[编号].魔法 = self.参战单位[编号].魔法 - 扣除魔法
            self.参战单位[编号].奇经八脉修心 = 1
        end
    end
    if self.参战单位[编号].愤怒 < 消耗 then
        return false
    end
    if 名称 and 战斗技能[名称] and 战斗技能[名称].特技  then
        self:特技相关效果(编号, 消耗)
        if self.参战单位[编号].奇经八脉.鬼火 and 消耗 <= 90 then
            消耗 = 消耗 - 16
        end
    end
    self.参战单位[编号].愤怒 = self.参战单位[编号].愤怒 - 消耗

    if self.参战单位[编号].神器技能 ~= nil and self.参战单位[编号].神器技能.名称 == "玉魄" then
        self.参战单位[编号].神器技能玉魄 = self.参战单位[编号].神器技能.等级 * 消耗
        self.参战单位[编号].神器技能玉魄回合 = self.回合数
    end
    if self.参战单位[编号].愤怒 <= 0 then
        self.参战单位[编号].愤怒 = 0
    end
    if self.参战单位[编号].愤怒 >= 150 and (self.参战单位[编号].类型 == "角色" or self.参战单位[编号].主人) then
        self.参战单位[编号].愤怒 = 150
    end

    return true
end

function 战斗处理类:特技相关效果(编号, 消耗)
        if self.参战单位[编号].奇经八脉.亢强 then
            self.参战单位[编号].奇经八脉亢强 = 3 * 消耗
        end
        if self.参战单位[编号].奇经八脉.催迫 and 消耗 >= 120 then
            self.参战单位[编号].奇经八脉催迫加成 = 1
        end
        if self.参战单位[编号].奇经八脉.聚气 and 消耗 >= 60 then
            self:凌波添加战意(self.参战单位[编号],1)
        end
        if self.参战单位[编号].奇经八脉.不忿 then
            self.参战单位[编号].奇经八脉不忿 = 1
        end
        if self.参战单位[编号].奇经八脉.烬藏 and 消耗 >= 120 then
            if self.参战单位[编号].秘传三昧真火 ~= nil then
                self.参战单位[编号].秘传三昧真火 = self.参战单位[编号].秘传三昧真火 - 1
            end
            if self.参战单位[编号].秘传飞砂走石 ~= nil then
                self.参战单位[编号].秘传飞砂走石 = self.参战单位[编号].秘传飞砂走石 - 1
            end
        end
        if self.参战单位[编号].奇经八脉.重明 then
            self.参战单位[编号].自矜加成 = 1
        end
        if self.参战单位[编号].奇经八脉.空灵 then
            self.参战单位[编号].奇经八脉空灵 = 3
        end
        if self.参战单位[编号].奇经八脉.趁虚 then
            self.参战单位[编号].奇经八脉趁虚 = 4
        end
        if self.参战单位[编号].奇经八脉.存雄 then
            self.参战单位[编号].奇经八脉存雄 = 4
        end
        if self.参战单位[编号].奇经八脉.怒电 and 消耗 >= 120 and 取随机数() <= 50 then
            self.参战单位[编号].奇经八脉怒电 = 1
        end

        if self.参战单位[编号].奇经八脉.静心 and self.参战单位[编号].门派 == "女儿村"
           and 消耗 >= 80 and self.参战单位[编号].乐韵 ~= nil then
            self.参战单位[编号].乐韵 = self.参战单位[编号].乐韵 + 1
        end
end


function 战斗处理类:造成伤势(编号,数额)
    if self.参战单位[编号].类型~="角色" then
      return
    end
    self.参战单位[编号].气血上限=self.参战单位[编号].气血上限-数额
    if self.参战单位[编号].气血上限 <= 0 then
      self.参战单位[编号].气血上限 = 0
    end
end


function 战斗处理类:减少气血(编号, 数额, 攻击, 名称)
    self.参战单位[编号].气血 = self.参战单位[编号].气血 - 数额
    if self.战斗类型 == 100308 and self.参战单位[编号].队伍 == 0 and self.参战单位[编号].名称 == "司法天神" then
        if 数额 >= self.参战单位[编号].最大气血 * 0.000001 then
            数额 = 取随机数(self.参战单位[编号].最大气血 * 0.0000005, self.参战单位[编号].最大气血 * 0.000001)
        end
        if 世界挑战.气血.当前 > 0 then
            世界挑战.气血.当前 = 世界挑战.气血.当前 - math.floor(数额)
        end

        if 攻击 and self.参战单位[攻击].玩家id and 世界挑战[self.参战单位[攻击].玩家id] then
            世界挑战[self.参战单位[攻击].玩家id].伤害 = 世界挑战[self.参战单位[攻击].玩家id].伤害 + math.floor(数额)
        end
        self:世界BOOS刷新()
        if 世界挑战.气血.当前 <= 0 then
            结束世界挑战()
            if 攻击 and self.参战单位[攻击].玩家id and not 世界挑战.最终一击 then
                世界挑战.最终一击 = self.参战单位[攻击].玩家id
            end
        end
    end
    if self.参战单位[编号].类型 == "测试" and self.参战单位[编号].气血 <= 0 then
        self.参战单位[编号].气血 = 99999999999999999999
    end
    if self.参战单位[编号].气血 <= self.参战单位[编号].最大气血 * 0.2 then
        self:添加危险发言(编号, 2)
    end
    if (self.参战单位[编号].类型 == "角色" or self.参战单位[编号].类型 == "系统PK角色") and not self.参战单位[编号].不加愤怒 then
        local 临时愤怒 = 3
        if 数额 <= self.参战单位[编号].最大气血 * 0.05 then
            临时愤怒 = 取随机数(3, 4)
        elseif 数额 > self.参战单位[编号].最大气血 * 0.05 and 数额 <= self.参战单位[编号].最大气血 * 0.1 then
            临时愤怒 = 取随机数(10, 11)
        elseif 数额 > self.参战单位[编号].最大气血 * 0.1 and 数额 <= self.参战单位[编号].最大气血 * 0.2 then
            临时愤怒 = 取随机数(15, 16)
        elseif 数额 > self.参战单位[编号].最大气血 * 0.2 and 数额 <= self.参战单位[编号].最大气血 * 0.35 then
            临时愤怒 = 取随机数(16, 25)
        elseif 数额 > self.参战单位[编号].最大气血 * 0.35 and 数额 <= self.参战单位[编号].最大气血 * 0.55 then
            临时愤怒 = 取随机数(25, 41)
        elseif 数额 > self.参战单位[编号].最大气血 * 0.55 then
            临时愤怒 = 取随机数(41, 56)
        end
        if self.参战单位[编号].暴怒腰带 then
            临时愤怒 = 临时愤怒 + math.floor(临时愤怒 * 0.25)
        end
        if self.参战单位[编号].奇经八脉.怒火 and self.参战单位[编号].门派 == "天宫" and 临时愤怒 >= 10 then
            临时愤怒 = 临时愤怒 + 4
        end
        self:增加愤怒(编号, math.floor(临时愤怒))
    end
    if self.参战单位[编号].不加愤怒 then
        self.参战单位[编号].不加愤怒 = nil
    end
    local 返回死亡 = 0
    if self.参战单位[编号].气血 <= 0 then
        self.参战单位[编号].神器技能惊锋 = nil
        self.参战单位[编号].神器技能狂战 = nil
        self.参战单位[编号].神器技能酣战 = nil
        self.参战单位[编号].神器技能鸣空 = nil
        self.参战单位[编号].神器技能凭虚御风 = nil
        if 攻击 ~= 编号 then
            if 战斗技能[名称] and 战斗技能[名称].死亡处理 then
                返回死亡 = 战斗技能[名称].死亡处理(self,攻击,编号)
            end
            self.参战单位[编号].奇经八脉勇武加成 = nil
            if self.参战单位[编号].奇经八脉炼魂 then
                self.参战单位[编号].炼魂虚弱 = 1
            end
            if self.参战单位[攻击].奇经八脉.傲视 then
                self.参战单位[攻击].奇经八脉傲视 = 4
            end
            if self.参战单位[编号].奇经八脉.死地 then
                self.参战单位[编号].奇经八脉死地 = 1
            end
            if self.参战单位[攻击].奇经八脉.野蛮 then
                self.参战单位[攻击].奇经八脉野蛮 = true
            end
            if self.参战单位[编号].奇经八脉秘术前置 then
                self.参战单位[编号].奇经八脉秘术 = 1
                self.参战单位[编号].奇经八脉秘术前置 = nil
            end
            if self.参战单位[编号].奇经八脉摧心前置 then
                self.参战单位[编号].奇经八脉摧心 = 4
                self.参战单位[编号].奇经八脉摧心前置 = nil
            end

            if self.参战单位[攻击].奇经八脉.困兽 and 取随机数() <= 50 then
                self.参战单位[编号].奇经八脉秘术 = 1
            end
            if self.参战单位[编号].奇经八脉追袭 then
                self:添加状态("腾雷", 编号, 攻击, self.参战单位[攻击].等级)
            end
            if self.参战单位[编号].奇经八脉凌波混元 and 取随机数() <= 70 then
                self:添加状态("腾雷", 编号, 攻击, self.参战单位[攻击].等级)
            end
            if self.参战单位[编号].类型 == "角色" and self.参战单位[攻击].奇经八脉.狩猎 then
                self.参战单位[攻击].奇经八脉狩猎 = 1
            end
             if self.参战单位[编号].类型 == "角色" and self.参战单位[攻击].奇经八脉.逞凶 then
                self.参战单位[攻击].奇经八脉逞凶 = 1
            end
            if self.参战单位[攻击].奇经八脉.恶焰 and self.参战单位[编号].法术状态.尸腐毒 then
                self.参战单位[攻击].奇经八脉恶焰 = 6
            end
            if self.参战单位[攻击].神器技能 and self.参战单位[攻击].神器技能.名称 == "静笃" then
                local 临时数额 = self.参战单位[攻击].神器技能.等级 * 60
                self.参战单位[攻击].伤害 = self.参战单位[攻击].伤害 + 临时数额
            end
            if self:取封印状态(编号) then
                local 封印 = {}
                for i, v in ipairs(self.技能数据.封印) do
                    if self.参战单位[编号].法术状态[v] and self.参战单位[编号].法术状态[v].攻击 then
                        local 攻击单位 = self.参战单位[编号].法术状态[v].攻击
                        if self.参战单位[攻击单位] and self.参战单位[攻击单位].奇经八脉.专神 then
                            封印[#封印 + 1] = 攻击单位
                        end
                    end
                end

                封印 = 删除重复(封印)
                for i = 1, #封印 do
                    if self.参战单位[封印[i]] then
                        self.参战单位[封印[i]].奇经八脉专神 = 4
                    end
                end
            end

            if self.参战单位[攻击].法术状态.变身 and self.参战单位[攻击].法术状态.变身.宁息 and 取随机数() <= 15 then
                self.参战单位[攻击].法术状态.变身.回合 = self.参战单位[攻击].法术状态.变身.回合 + 1
            end
            if self.参战单位[编号].奇经八脉.舍利 and not self.参战单位[编号].奇经八脉舍利 then
                for i = 1, #self.参战单位 do
                    if i ~= 编号 and self.参战单位[i].气血 > 0 and self.参战单位[i].队伍 == self.参战单位[编号].队伍 then
                        self:增加愤怒(i, 取随机数(20, 100))
                    end
                end
                self.参战单位[编号].奇经八脉舍利 = 1
            end
            if self.参战单位[编号].类型 == "角色" and self.参战单位[攻击].奇经八脉.追命 and self:取是否单独门派(攻击) then
                self:添加状态("锢魂术", 编号, 攻击, self.参战单位[攻击].等级)
                self.参战单位[编号].法术状态.锢魂术.回合 = 4
            end
            if self.参战单位[编号].奇经八脉.不动 and self.参战单位[编号].战意 <= 3 and self:取是否单独门派(编号) then
                self:凌波添加战意(self.参战单位[编号],1)
            end
            if self.参战单位[攻击].奇经八脉.杀罚 and 取随机数() <= 60 and
               (self.参战单位[攻击].法术状态.天眼 or self.参战单位[攻击].法术状态.怒眼 or self.参战单位[攻击].法术状态.智眼) then
                self:添加状态("腾雷", 编号, 攻击, self.参战单位[攻击].等级)
            end

            if  self.参战单位[编号].类型 ~= "角色" and self.参战单位[攻击].主人 and self.参战单位[self.参战单位[攻击].主人].奇经八脉.狂啸 then
                self:添加状态("狂怒", 攻击, 攻击, self.参战单位[攻击].等级)
                self.参战单位[攻击].法术状态.狂怒.回合 = 4
            end
            if self.参战单位[攻击].法术状态.电芒 and self.参战单位[攻击].法术状态.电芒.雷波 and self.参战单位[攻击].法术状态.电芒.攻击 then
                local 玩家编号 = self.参战单位[攻击].法术状态.电芒.编号
                for i = 1, #self.参战单位 do
                    if i ~= 攻击 and self.参战单位[i].队伍 == self.参战单位[攻击].队伍 and not self.参战单位[i].法术状态.电芒 and self.参战单位[i].气血 > 0 then
                        self:添加状态("电芒", i, 玩家编号, self.参战单位[玩家编号].等级)
                    end
                end
            end

            if  self.参战单位[编号].类型 == "角色" and self.参战单位[编号].奇经八脉.复仇 and self.参战单位[编号].召唤兽 and self.参战单位[self.参战单位[编号].召唤兽] then
                self.参战单位[self.参战单位[编号].召唤兽].奇经八脉复仇 = 攻击
            end
        end
        for i = 1, #self.参战单位 do
            if self.参战单位[i].气血 > 0 and self.参战单位[i].队伍 ~= self.参战单位[编号].队伍 and self.参战单位[i].奇经八脉.汲魂 then
                self:增加气血(i, self.参战单位[i].等级 * 6)
            end
        end
        self:添加危险发言(编号, 1)
        self.执行等待 = self.执行等待 + 5
        self.参战单位[编号].气血 = 0
        self:造成伤势(编号, self.参战单位[编号].最大气血)
        if self.战斗脚本 then
            self.战斗脚本:单位死亡(编号)
        end
        if self.参战单位[编号].同门单位 then
            self.同门死亡 = true
        end
        if self.参战单位[编号].类型 == "角色" then
            self:设置复仇对象(编号, 攻击)
            self.参战单位[编号].愤怒 = 0
            return 2
        else
            if not self.参战单位[编号].血债偿 then
                for n = 1, #self.参战单位 do
                    if not self.参战单位[n].鬼魂 and self.参战单位[n].队伍 == self.参战单位[编号].队伍 and self.参战单位[n].血债偿 and (not self.参战单位[n].血债偿计次 or self.参战单位[n].血债偿计次 > 0) then
                        self.参战单位[n].法伤 = self.参战单位[n].法伤 + self.参战单位[n].血债偿
                        self.参战单位[n].血债偿计次 = (self.参战单位[n].血债偿计次 or 4) - 1
                    end
                end
            end
            if not self.参战单位[编号].鬼魂  then
                if self.参战单位[编号].主人 and self.参战单位[self.参战单位[编号].主人] then
                    local 查找编号 = {}
                    for k = 1, #self.参战单位 do
                        if self.参战单位[k].类型 == "角色" and self.参战单位[k].队伍 == self.参战单位[self.参战单位[编号].主人].队伍 and self.参战单位[k].神器技能 and self.参战单位[k].神器技能.名称 == "狂战" then
                            查找编号[#查找编号 + 1] = k
                        end
                    end

                    for v = 1, #查找编号 do
                        if self.参战单位[查找编号[v]] and self.参战单位[查找编号[v]].气血 > 0 then
                            if not self.参战单位[查找编号[v]].神器技能狂战 then
                                self.参战单位[查找编号[v]].神器技能狂战 = {数额 = self.参战单位[查找编号[v]].神器技能.等级 * 30, 层数 = 1}
                            else
                                self.参战单位[查找编号[v]].神器技能狂战.层数 = math.min(self.参战单位[查找编号[v]].神器技能狂战.层数 + 1, 4)
                            end
                        end
                    end
                end
                return 1
            else
                if 返回死亡 == 1 then
                    return 1
                elseif self.参战单位[攻击].法术状态.灵断 then
                    return 1
                elseif self.参战单位[攻击].符石技能.风卷残云 and 取随机数() <= self.参战单位[攻击].符石技能.风卷残云 then
                    return 1
                elseif self.参战单位[攻击].驱鬼 then
                    return 1
                else
                    self.参战单位[编号].法术状态.复活 = {回合 = self.参战单位[编号].鬼魂}
                    return 2
                end
            end
        end
    end
end

function 战斗处理类:设置复仇对象(编号,攻击)
      local id=self.参战单位[编号].召唤兽
      if id==nil or id==0 or self.参战单位[id]==nil then
        return
      elseif self.参战单位[id].复仇特性~=nil and  self.参战单位[id].复仇特性*20>=取随机数(1,10) then
        self.参战单位[id].复仇标记=攻击
      end
end


function 战斗处理类:取参战编号(id,类型)
          for i,v in ipairs(self.参战单位) do
              if v.类型 == 类型 and v.玩家id==id then
                  return i
              end
          end
end


function 战斗处理类:取目标状态(攻击, 挨打, 类型)
    if not self.参战单位[挨打] then
        return false
    end
    if (self.参战单位[挨打].气血 <= 0 or self.参战单位[挨打].捕捉 or self.参战单位[挨打].逃跑) and (类型 == 2 or 类型 == 1) then
       return false
    end
    if 类型 == 1 then
        if not self.参战单位[挨打].法术状态 then
           return true
        elseif self.参战单位[挨打].法术状态.修罗隐身 then
            return self.参战单位[攻击].感知
                    or self.参战单位[攻击].超级感知
                    or  self.参战单位[攻击].法术状态.幽冥鬼
                    or (self.参战单位[攻击].法术状态.牛劲 and self.参战单位[攻击].法术状态.牛劲.感知)
        elseif self.参战单位[挨打].法术状态.楚楚可怜 then
            return self.参战单位[攻击].感知 or self.参战单位[攻击].超级感知
        elseif  self.参战单位[挨打].法术状态.煞气诀 then
            return false
        end
    elseif 类型 == 3 and self.参战单位[挨打].气血 <= 0 then
        return false
    end
    return true
end






function 战斗处理类:取我方伤害最高(编号)
  local 目标组={}
  local 伤害={id=0,伤害=0}
  for n=1,#self.参战单位 do
    if self.参战单位[n].队伍==self.参战单位[编号].队伍 and self:取目标状态(编号,n,1) then
      if self.参战单位[n].伤害>伤害.伤害 then
        伤害.伤害=self.参战单位[n].伤害
        伤害.id=n
      end
    end
  end
  if 伤害.id==0 then
     return 编号
  else
    return 伤害.id
  end
end


function 战斗处理类:取召唤兽可用法术(编号)
      local 可用法术 = {水攻 = true,烈火 = true,雷击 = true,落岩 = true,月光 = true,奔雷咒 = true,
                        水漫金山 = true,地狱烈火 = true,泰山压顶 = true,上古灵符 = true,八凶法阵 = true,
                        流沙轻音 = true,食指大动 = true,天降灵葫 = true,叱咤风云 = true,超级奔雷咒 = true,
                        超级水漫金山 = true,超级三昧真火 = true,超级地狱烈火 = true,超级泰山压顶 = true}

      local 技能组 = {}
      for _, 技能 in ipairs(self.参战单位[编号].主动技能) do
          if 可用法术[技能.名称] then
              技能组[#技能组 + 1] = 技能.名称
          end
      end
      if #技能组 > 0 then
          return 技能组[取随机数(1, #技能组)]
      end
end



function 战斗处理类:取我方气血最低(编号)
    local 最低气血 = {id = 编号, 气血 = self.参战单位[编号].气血}
    for i, 单位 in ipairs(self.参战单位) do
        if 单位.队伍 == self.参战单位[编号].队伍 and self:取目标状态(编号, i, 1) then
            if 单位.气血 < 最低气血.气血 then
                最低气血.id = i
                最低气血.气血 = 单位.气血
            end
        end
    end

    return 最低气血.id
end




function 战斗处理类:取阵营数量(队伍)
    local 数量 = 0
    for _, 单位 in ipairs(self.参战单位) do
        if 单位.队伍 == 队伍
           and 单位.气血 >= 1
           and not 单位.捕捉
           and not 单位.逃跑 then
            数量 = 数量 + 1
        end
    end
    return 数量
end





function 战斗处理类:取阵亡id组(队伍)
    local 队伍表 = {}
    local 存活数量 = 0
    for 编号, 单位 in ipairs(self.参战单位) do
        if 单位.队伍 == 队伍 then
            if 单位.类型 ~= "角色"
               and 单位.类型 ~= "系统pk角色"
               and not 单位.法术状态.复活
               and (单位.气血 <= 0
                    or 单位.逃跑
                    or 单位.捕捉)
               then
                队伍表[#队伍表 + 1] = 编号
            else
                存活数量 = 存活数量 + 1
            end
        end
    end
    return 队伍表, 存活数量
end







