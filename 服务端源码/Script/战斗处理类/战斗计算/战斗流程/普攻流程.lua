

function 战斗处理类:普通攻击计算(编号,名称,伤害比,等级,友伤,额外命令)--(编号,名称,等级)
          if self.参战单位[编号].指令.取消 then return end
          名称 = 名称 or "普通攻击"
          等级 = 等级 or self.参战单位[编号].等级
          if not 战斗技能[名称] then return end
          local 目标 = 额外命令 and 额外命令.目标 or self.参战单位[编号].指令.目标
          if not 目标 or not self:取目标状态(编号,目标,1) then
             目标 = self:取单个敌方目标(编号)
          end
          if not 目标 or 目标==0 then return end
          if self.参战单位[目标].法术状态.分身术 and not self.参战单位[目标].法术状态.分身术.破解 and 取随机数()<=50 then
              self.参战单位[目标].法术状态.分身术.破解=1
              return
          end
          if 战斗技能[名称].消耗 and not 战斗技能[名称].消耗(self, 编号, 1) then
              self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/未到达技能消耗要求,技能使用失败")
              return
          end
          local 前置 = {
              结尾 = 0,
              目标数 = 1,
              目标 = 目标,
              目标组 = {目标},
              重复攻击 = true,
              流程 = #self.战斗流程
          }
          if 战斗技能[名称].前置流程 then
                战斗技能[名称].前置流程(self,编号,等级,前置,"伤害")
          end
          if 前置.结束流程 then return end
          if 前置.名称 then
              名称 = 前置.名称
          end
          if 前置.重复攻击 then
              local 临时目标 = 前置.目标组[1]
              前置.目标组={}
              for n=1,前置.目标数 do
                  前置.目标组[n] = 临时目标
              end
          end
          local function 添加流程(流程表)
              if not 判断是否为空表(流程表) then
                  for _, v in ipairs(流程表) do
                       table.insert(self.战斗流程, {流程=50,攻击方=编号,挨打方={v}})
                  end
              end
          end
          local 战斗终止 = false
          for n=1,前置.目标数 do
                if 战斗终止 or not (前置.目标组[n] and self:取目标状态(编号, 前置.目标组[n], 1) and self:取行动状态(编号)) then
                      if self.战斗流程[前置.流程] then
                          self.战斗流程[前置.流程].返回 = true
                      end
                      战斗终止 = true
                      break
                end
                前置.流程 = #self.战斗流程 + 1
                self.执行等待 = self.执行等待 + 5
                self.战斗流程[前置.流程] = {流程 =  1,攻击方 = 编号,挨打方 = {}}
                self:普攻循环处理(编号,前置.目标组[n],n,名称,前置.目标数,等级,前置.流程,友伤,伤害比)
                if not self.战斗流程[前置.流程].躲避 and self.参战单位[编号].溅射人数 and self.参战单位[编号].溅射人数 ~= 0 then
                    self:物理同时多个攻击(编号, nil, 等级, {目标 = 前置.目标组[n], 人数 = self.参战单位[编号].溅射人数})
                end
                添加流程(self:物攻循环中处理(编号, 前置.目标组[n]))
                添加流程(self:取循环中处理(编号, 前置.目标组[n]))
                if n == 1 then
                      if 前置.技能提示 then
                          self.战斗流程[前置.流程].提示 = {
                              类型 = "被动",
                              名称 =  名称,
                              允许 = true
                          }
                          if 战斗技能[名称].特技 then
                              self.战斗流程[前置.流程].提示.类型 = "特技"
                          elseif 战斗技能[名称].法宝 then
                                  self.战斗流程[前置.流程].提示.类型 = "法宝"
                          elseif 战斗技能[名称].灵宝 then
                                  self.战斗流程[前置.流程].提示.类型 = "灵宝"
                          end
                      end
                      if 前置.全屏动画 then
                          self.战斗流程[前置.流程].全屏动画 = 名称
                      end
                      if 前置.先手动画 then
                          self.战斗流程[前置.流程].先手动画 = 名称
                          for i = 2, 前置.目标数 do
                              self.战斗流程[前置.流程].挨打方[i] = {挨打方 = 前置.目标组[i], 特效 = {}}
                          end
                      end
                      if 前置.取消状态 then
                          self:解除状态组处理(编号,编号,前置.取消状态,名称,前置.流程)
                      end
                      if 前置.添加状态 then
                          self:添加状态组处理(编号,编号,前置.添加状态,名称,等级,前置.流程)
                      end

                end
                if n ~= 前置.目标数 and 前置.中途返回 then
                      self.战斗流程[前置.流程].返回 = true
                elseif n == 前置.目标数 or not (self:取目标状态(编号, 前置.目标组[n+1], 1) and self:取行动状态(编号)) then
                    self.战斗流程[前置.流程].返回 = true
                    战斗终止 = true
                end
        end
        if self.参战单位[编号].气血>0 and 前置.结尾 and 前置.结尾>0 and self.战斗流程[前置.流程] then
            self.战斗流程[前置.流程].减少气血=前置.结尾
            self.战斗流程[前置.流程].死亡 = self:减少气血(编号,前置.结尾,编号,名称)
        end
        local 返回 = {}
        if 战斗技能[名称].结束流程 then
              战斗技能[名称].结束流程(self,编号,self.伤害输出,等级,前置,返回,"伤害")
        end
        if 返回.取消状态 then
            self:解除状态组处理(编号,编号,返回.取消状态,名称,前置.流程)
        end
        if 返回.添加状态 then
            self:添加状态组处理(编号,编号,返回.添加状态,名称,等级,前置.流程)
        end

end




function 战斗处理类:普攻循环处理(编号,目标,次数,名称,总数,等级,流程,友伤,伤害比)--编号,目标,次数,总数,等级,流程,挨打
          self.伤害输出 = 0
          self.战斗流程[流程].挨打方[1]={挨打方=目标,特效={}}
          local  躲避 = false
          local 概率 = math.floor(self.参战单位[目标].躲闪/((self.参战单位[目标].等级+1)*2))
          if self.参战单位[编号].弑神特性 then
              if self.参战单位[编号].弑神特性<=2 then
                 概率 = 概率 + 40
              else
                  概率 = 概率 + 20
              end
          end
          if self.参战单位[目标].躲避减少 and self.参战单位[目标].躲避减少>0 then
              概率 = math.floor(概率*self.参战单位[目标].躲避减少)
          end
          if 取随机数(1,100)<=概率 then
              躲避=true
          elseif  self.参战单位[目标].气血>=1 and 取随机数(1,100)<=1 then
               躲避=true
          end
          if self.参战单位[编号].类型 == "角色" and self.参战单位[编号].武器必中 then
              躲避=false
          end
          if 躲避 then
             self.战斗流程[流程].躲避 = true
             return
          end
          local 基础 = DeepCopy(self.计算属性)
          local 数据 = {次数=次数,总数=总数,流程=流程,挨打=挨打}
          if 战斗技能[名称].基础计算 then
              战斗技能[名称].基础计算(self,编号,目标,等级,数据,基础,"伤害")
          end
          基础.特效 = {}
          local 计算 = self:取基础物理伤害(编号,目标,名称,等级,基础)
          local 输出 = self:取物理动作计算(编号,目标,名称,等级,基础) ---{暴击=暴击,动作=动作,保护=保护,编号=保护编号}
           if self.参战单位[编号].奇经八脉.罗网 then
              计算 = 计算*1.1
              self:添加状态("天罗地网",目标,编号,self.参战单位[编号].等级)
              self:处理流程状态(self.战斗流程[流程].挨打方[1],"天罗地网",目标)
          end
          if 友伤 then
              计算=计算 * 0.1
              self.参战单位[编号].指令.类型=""
              self.参战单位[编号].指令.参数=""
              self.参战单位[编号].指令.下达=true
              友伤=nil
          end
          if 伤害比 then 计算 = 计算 * 伤害比 end
          计算 = math.floor(计算)
          local 结果 = self:取计算结果(编号,目标,计算,输出.暴击,流程,1,基础,名称,等级,"物伤",输出.保护)
          self.战斗流程[流程].挨打方[1].动作 = 输出.动作
          local 特效 = 战斗技能[名称].特效 and 战斗技能[名称].特效("伤害") or "被击中"
          self.战斗流程[流程].挨打方[1].特效[1] = 特效
          if 基础.特效 then
              for k,v in ipairs(基础.特效) do
                  table.insert(self.战斗流程[流程].挨打方[1].特效, v)
              end
          end
          if 结果.类型~=2 and 结果.伤害<1 then
              结果.伤害=取随机数(self.参战单位[编号].伤害*0.05,self.参战单位[编号].伤害*0.1)
          end
          结果.伤害 = math.floor(结果.伤害)
          if 结果.类型==2 then --恢复状态
              self:增加气血(目标,结果.伤害)
          else
              结果.伤害 = self:取物理结束计算(编号,目标,结果.伤害,输出.保护,输出.编号,流程,1,基础)
              self.伤害输出 = 结果.伤害
              self.战斗流程[流程].挨打方[1].死亡=self:减少气血(目标,结果.伤害,编号,名称)
              if 结果.伤害 >= self.参战单位[目标].最大气血*0.1 and self.参战单位[编号].千钧一怒
               and self.参战单位[编号].类型 == "bb" and self.参战单位[编号].主人  and self.参战单位[self.参战单位[编号].主人] then
                self:增加愤怒(self.参战单位[编号].主人,10)
              end
              if 基础.扣除魔法 then
                   self:减少魔法(目标,math.floor(结果.伤害 * 基础.扣除魔法))
              end
              if 基础.增加魔法 then
                  self:增加魔法(目标,math.floor(基础.增加魔法))
              end
              if 基础.减少气血 then
                  self.战斗流程[流程].挨打方[挨打].伤害1 = 基础.减少气血
                  self.战斗流程[流程].挨打方[挨打].类型1 = 1
                  self.战斗流程[流程].挨打方[挨打].死亡1 = self:减少气血(目标,基础.减少气血,编号,名称)
              end
              if self.参战单位[编号].毒~=nil and self.参战单位[编号].毒 >=取随机数() then
                 self:取消状态("毒",目标)
                 self:添加状态("毒",目标,编号,self.参战单位[编号].等级)
                 self:处理流程状态(self.战斗流程[流程].挨打方[1],"毒",目标)
              end
              if self.参战单位[目标].气血<=0 then
                  if self.参战单位[编号].自恋特性 and not self.参战单位[编号].自恋次数 and self.参战单位[编号].自恋特性*20>=取随机数(1,20) then
                      self.参战单位[编号].自恋次数=1
                      self:添加发言(编号,"我这一顿乱打下去，神仙都扛不住#24")
                  end
                  if self.参战单位[编号].嗜血追击 and not self.参战单位[编号].嗜血触发 then
                      self.参战单位[编号].嗜血触发 = 1
                  end
              end
              if self.参战单位[目标].法术状态.火甲术 and self.参战单位[目标].气血>0 then
                  self:法术攻击处理(目标,{名称="三昧真火",目标=编号})
              end
              if 输出.暴击 and self.参战单位[编号].怒击效果 and not self.参战单位[编号].怒击触发 then
                  self.参战单位[编号].怒击触发 = 1
              end
          end
          self.战斗流程[流程].挨打方[1].伤害 = 结果.伤害
          self.战斗流程[流程].挨打方[1].类型 = 结果.类型
          if 基础.取消状态 then
               self:解除状态组处理(编号,目标,基础.取消状态,名称,流程,挨打)
          end
          if 基础.添加状态 then
              self:添加状态组处理(编号,目标,基础.添加状态,名称,等级,流程,挨打)
          end



          if 战斗技能[名称].循环结束 then
              战斗技能[名称].循环结束(self,编号,目标,self.伤害输出,等级,数据,"伤害")
          end
          if 数据.取消状态 then
               self:解除状态组处理(编号,目标,数据.取消状态,名称,流程,挨打)
          end
          if 数据.添加状态 then
                self:添加状态组处理(编号,目标,数据.添加状态,名称,等级,流程,挨打)
          end
          local 触发概率=self:套装触发几率(编号,self.参战单位[编号].追加概率)
          if 名称=="摧枯拉朽" then
              触发概率 = 100
          end
          if #self.参战单位[编号].追加法术>0 and 取随机数()<=触发概率 and self:取攻击状态(编号)  then
              if self.参战单位[编号].奇经八脉.奉还  then
                  self.参战单位[编号].奇经八脉奉还加成 = 1
              end
              local 套装触发 ={目标 =self:取单个敌方目标(编号),
                              名称 = self.参战单位[编号].追加法术[取随机数(1,#self.参战单位[编号].追加法术)].名称}
              self:法术攻击处理(编号,套装触发)
          end

end





function 战斗处理类:物理同时多个攻击(编号,名称,等级,额外)
          if self.参战单位[编号].指令.取消 then return end
          额外 = 额外 or {}
          名称 = 名称 or "溅射"
          额外.次数 = 额外.次数 or 1
          额外.人数 = 额外.人数 or 1
          等级 = 等级 or self.参战单位[编号].等级
          额外.目标 = 额外.目标 or self.参战单位[编号].指令.目标
          if not 战斗技能[名称] then return end
          if 战斗技能[名称].目标 then
                额外.目标 = 战斗技能[名称].目标(self,编号,额外.目标)
          end

          if 战斗技能[名称].次数 then
                额外.次数=战斗技能[名称].次数(self,编号,等级)
          end
          local 最终流程 = #self.战斗流程
          local 前置 = {
                      结尾 = 0,
                      目标 = 额外.目标,
                      重复攻击 =false,
                      流程 = #self.战斗流程,
                      目标数 = 额外.人数,
                      目标组 = {}
                  }
          if 名称~="溅射" then
              if 战斗技能[名称].人数 then
                 前置.目标数 = 战斗技能[名称].人数(self, 编号,等级,消耗)
              end

              前置.目标组 = self:取敌方目标组(编号, 前置.目标, 前置.目标数, 名称)
              local 目标重置 = {}
              for k,v in pairs(前置.目标组) do
                    if self.参战单位[v].法术状态.分身术 and not self.参战单位[v].法术状态.分身术.破解 and 取随机数()<=50 then
                        self.参战单位[v].法术状态.分身术.破解=1
                    else
                        table.insert(目标重置,v)
                    end
              end
              前置.目标组=目标重置
              前置.目标数=#目标重置
              if 前置.目标数==0 then return end
              if 战斗技能[名称].消耗 and not 战斗技能[名称].消耗(self, 编号, 额外.人数) then
                  self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/未到达技能消耗要求,技能使用失败")
                  return
              end
          end

          for i=1,额外.次数 do
                  前置.结尾 = 0
                  前置.重复攻击 =false
                  if 战斗技能[名称].前置流程 then
                       战斗技能[名称].前置流程(self,编号,等级,前置,"伤害")
                  end
                  if 前置.结束流程 then
                      if self.战斗流程[前置.流程] then
                          self.战斗流程[前置.流程].返回 = true
                      end
                    return
                  end
                  if 前置.名称 then
                      名称 = 前置.名称
                  end
                  前置.流程 = #self.战斗流程 + 1
                  最终流程 = 前置.流程
                  self.执行等待=self.执行等待+5
                  self.战斗流程[前置.流程] = {
                      攻击方 = 编号,
                      挨打方 = {},
                      返回 = (i == 额外.次数) or nil
                  }
                  if 名称=="溅射" then
                      self.战斗流程[前置.流程].流程 = 30
                  else
                      self.战斗流程[前置.流程].流程 = 32
                  end
                  if 前置.分身攻击 then
                      self.战斗流程[前置.流程].分身攻击 = 1
                  end
                  if 前置.重复攻击 then
                      self.战斗流程[前置.流程].流程 = 1
                      local 临时目标=前置.目标组[1]
                      前置.目标组={}
                      for n=1,前置.目标数 do
                        前置.目标组[n]=临时目标
                      end
                  end
                  if i == 1 then
                      if not 前置.技能提示 and 名称~="溅射" then
                          self.战斗流程[前置.流程].提示 = {
                              类型 = "法术",
                              名称 = 名称,
                              允许 = true
                          }
                          if 战斗技能[名称].特技 then
                               self.战斗流程[前置.流程].提示.类型 = "特技"
                          elseif 战斗技能[名称].法宝 then
                                   self.战斗流程[前置.流程].提示.类型 = "法宝"
                          elseif 战斗技能[名称].灵宝 then
                                   self.战斗流程[前置.流程].提示.类型 = "灵宝"
                          end
                      end
                      if 前置.全屏动画 then
                          self.战斗流程[前置.流程].全屏动画 = 名称
                      end
                      if 前置.先手动画 then
                          self.战斗流程[前置.流程].先手动画 = 名称
                          for i = 2, 前置.目标数 do
                              self.战斗流程[前置.流程].挨打方[i] = {挨打方 = 前置.目标组[i], 特效 = {}}
                          end
                      end
                      if 前置.取消状态 then
                          self:解除状态组处理(编号,编号,前置.取消状态,名称,前置.流程)
                      end
                      if 前置.添加状态 then
                          self:添加状态组处理(编号,编号,前置.添加状态,名称,等级,前置.流程)
                      end

                  end

                  local 群体回复 = {攻击方=编号}
                  local 群体扣血 = {攻击方=编号}
                  local function 添加流程(流程表,重复)
                        if not 判断是否为空表(流程表) then
                            for _, v in ipairs(流程表) do
                                if 重复 then
                                     table.insert(self.战斗流程, {流程=50,攻击方=编号,挨打方={v}})
                                else
                                    if v.流程 == 2 then
                                        table.insert(群体回复,v)
                                    elseif v.流程 == 1 then
                                        table.insert(群体扣血,v)
                                    end
                                end
                            end
                      end
                  end
                  local 战斗终止 = false
                  local 群体数据={反震伤害=0,反击伤害=0,增加气血=0}
                  for n=1,前置.目标数 do
                        if 战斗终止 or not (前置.目标组[n] and self:取目标状态(编号, 前置.目标组[n], 1) and self:取行动状态(编号)) then
                            if self.战斗流程[前置.流程] then
                                self.战斗流程[前置.流程].返回 = true
                            end
                            战斗终止 = true
                            break
                        end
                        if 前置.重复攻击 and n~=1 then
                            前置.流程 = #self.战斗流程 + 1
                            最终流程 = 前置.流程
                            self.执行等待 = self.执行等待 + 5
                            self.战斗流程[前置.流程] = {
                                  流程 = 1,
                                  攻击方 = 编号,
                                  挨打方 = {},
                              }
                            self:物攻循环处理(编号,前置.目标组[n],n,名称,前置.目标数,等级,前置.流程,1)
                        else
                            self:物攻循环处理(编号,前置.目标组[n],n,名称,前置.目标数,等级,前置.流程,n,1,群体数据)
                            if 前置.重复攻击 and (群体数据.反震伤害>0 or 群体数据.反击伤害>0 or 群体数据.增加气血>0 or 群体数据.保护数据) then
                                if 群体数据.反震伤害>0 then
                                    self.战斗流程[前置.流程].反震伤害 = 群体数据.反震伤害
                                    self.战斗流程[前置.流程].反震死亡 = 群体数据.反震死亡
                                end
                                if 群体数据.反击伤害>0 then
                                    self.战斗流程[前置.流程].反击伤害 = 群体数据.反击伤害
                                    self.战斗流程[前置.流程].反击死亡 = 群体数据.反击死亡
                                end
                                if 群体数据.增加气血>0 then
                                    self.战斗流程[前置.流程].增加气血 = 群体数据.增加气血
                                end
                                if 群体数据.保护数据 then
                                    self.战斗流程[前置.流程].保护数据 = 群体数据.保护数据
                                end
                            end
                        end
                        if 战斗技能[名称].群体结尾 then
                            local 返回={}
                            战斗技能[名称].群体结尾(self,编号,n,等级,前置,返回)
                            if 返回.取消状态 then
                                  self:解除状态组处理(编号,编号,返回.取消状态,名称,前置.流程)
                            end
                            if 返回.添加状态 then
                                  self:添加状态组处理(编号,编号,返回.添加状态,名称,等级,前置.流程)
                            end
                        end
                        添加流程(self:物攻循环中处理(编号, 前置.目标组[n]),前置.重复攻击)
                        添加流程(self:取循环中处理(编号, 前置.目标组[n]),前置.重复攻击)
                        if n ~= 前置.目标数 and 前置.中途返回 and 前置.重复攻击 then
                            self.战斗流程[前置.流程].返回 = true
                        elseif n == 前置.目标数 or not (前置.目标组[n + 1] and self:取目标状态(编号, 前置.目标组[n + 1], 1) and self:取行动状态(编号)) then
                            战斗终止 = true
                            if 前置.中途返回 then
                              self.战斗流程[前置.流程].返回 = true
                            end
                        end
                end
                if not 前置.重复攻击 and (群体数据.反震伤害>0 or 群体数据.反击伤害>0 or 群体数据.增加气血>0 or 群体数据.保护数据) then
                    if 群体数据.反震伤害>0 then
                        self.战斗流程[前置.流程].反震伤害 = 群体数据.反震伤害
                        self.战斗流程[前置.流程].反震死亡 = 群体数据.反震死亡
                    end
                    if 群体数据.反击伤害>0 then
                        self.战斗流程[前置.流程].反击伤害 = 群体数据.反击伤害
                        self.战斗流程[前置.流程].反击死亡 = 群体数据.反击死亡
                    end
                    if 群体数据.增加气血>0 then
                        self.战斗流程[前置.流程].增加气血 = 群体数据.增加气血
                    end
                    if 群体数据.保护数据 then
                        self.战斗流程[前置.流程].保护数据 = 群体数据.保护数据
                    end
                end


                if #群体回复 > 1 then
                    table.insert(self.战斗流程, {
                          流程 = 50,
                          攻击方 = 群体回复.攻击方,
                          挨打方 = {}
                      })
                      for z, 回复 in ipairs(群体回复) do
                          self.战斗流程[#self.战斗流程].挨打方[z] = 回复
                      end
                end

                if #群体扣血 > 1 then
                      table.insert(self.战斗流程, {
                          流程 = 50,
                          攻击方 = 群体扣血.攻击方,
                          挨打方 = {}
                      })
                      for z, 扣血 in ipairs(群体扣血) do
                          self.战斗流程[#self.战斗流程].挨打方[z] = 扣血
                      end
                end
                if self.参战单位[编号].气血>0 and 前置.结尾 and 前置.结尾>0 and self.战斗流程[前置.流程] then
                    self.战斗流程[前置.流程].减少气血=前置.结尾
                    self.战斗流程[前置.流程].死亡 = self:减少气血(编号,前置.结尾,编号,名称)
                end
                local 返回 = {}
                if 战斗技能[名称].结束流程 then
                        战斗技能[名称].结束流程(self,编号,self.伤害输出,等级,前置,返回,"伤害")
                end
                if 返回.取消状态 then
                      self:解除状态组处理(编号,编号,返回.取消状态,名称,前置.流程)
                end
                if 返回.添加状态 then
                      self:添加状态组处理(编号,编号,返回.添加状态,名称,等级,前置.流程)
                end

          end
          local 返回 = {}
          if 战斗技能[名称].最终结束 then
                战斗技能[名称].最终结束(self,编号,最终流程,返回,"伤害")
          end
          if 返回.取消状态 then
              self:解除状态组处理(编号,编号,返回.取消状态,名称,最终流程)
          end
          if 返回.添加状态 then
              self:添加状态组处理(编号,编号,返回.添加状态,名称,等级,最终流程)
          end


end








