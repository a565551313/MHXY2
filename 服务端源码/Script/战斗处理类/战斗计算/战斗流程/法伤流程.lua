


function 战斗处理类:法攻技能计算(编号,名称,等级,额外命令,伤害比,境界)
        local 前置 = {
            结尾 = 0,
            重复攻击 = false,
            目标数 = 1,
            目标 = 战斗技能[名称].目标(self, 编号, 额外命令 and 额外命令.目标 or self.参战单位[编号].指令.目标),
            流程 = #self.战斗流程
        }
        if 战斗技能[名称].人数 then
            前置.目标数 = 战斗技能[名称].人数(self, 编号,等级,境界)
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
        if not 境界 and not 战斗技能[名称].消耗(self, 编号, 前置.目标数) then
            self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/未到达技能消耗要求,技能使用失败")
            return
        end

        if 战斗技能[名称].前置流程 then
              战斗技能[名称].前置流程(self,编号,等级,前置,"伤害",境界)
        end
        if 前置.结束流程 then return end
        if 前置.名称 then
            名称 = 前置.名称
        end
        if 前置.结束流程 then return end
        if 前置.重复攻击 then
            local 临时目标=前置.目标组[1]
            前置.目标组={}
            for n=1,前置.目标数 do
              前置.目标组[n]=临时目标
            end
        end
        前置.流程 = #self.战斗流程 + 1
        self.执行等待 = self.执行等待 + 5
        self.战斗流程[前置.流程] = {
            流程 = 21,
            攻击方 = 编号,
            挨打方 = {}
        }
        if not 前置.技能提示 then
            self.战斗流程[前置.流程].提示 = {
                允许 = true,
                类型 = "法术",
                名称 =  名称
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
        end
        if 前置.取消状态 then
            self:解除状态组处理(编号,编号,前置.取消状态,名称,前置.流程)
        end
        if 前置.添加状态 then
            self:添加状态组处理(编号,编号,前置.添加状态,名称,等级,前置.流程)
        end

        if self.参战单位[编号].高级龙魂 then
           self.参战单位[编号].高级龙魂 = self.参战单位[编号].高级龙魂 + 1
        end
        if self.参战单位[编号].龙魂 then
           self.参战单位[编号].龙魂 = self.参战单位[编号].龙魂 + 1
        end
        if self.参战单位[编号].门派 =="魔王寨" then
            local 触发几率 = 50
            local 已触发 = false
            if self.参战单位[编号].法术状态.牛劲 and self.参战单位[编号].法术状态.牛劲.炙烤 then
              触发几率 = 触发几率 + 200
              已触发 = true
            end
            if self.参战单位[编号].奇经八脉烈焰 and not 已触发 then
              触发几率 = 触发几率 + 200
            end
            if (名称=="摇头摆尾" or 名称=="三昧真火") and  self.参战单位[编号].奇经八脉.狂劲 then
              触发几率 = 触发几率 * 1.08
            end
            if 取随机数(1,1000)<=触发几率 then
               self:添加状态("神焰",编号,编号,等级)
               self:处理流程状态(self.战斗流程[前置.流程],"神焰",编号)
               if self.参战单位[编号].法术状态.牛劲~=nil and self.参战单位[编号].法术状态.牛劲.炙烤~=nil then
                  self.参战单位[编号].法术状态.神焰.回合= self.参战单位[编号].法术状态.牛劲.回合
               end
               if self.参战单位[编号].奇经八脉.折服 then
                  self.参战单位[编号].奇经八脉折服=1
               end
               if self.参战单位[编号].奇经八脉.焰威 and not self.参战单位[编号].奇经八脉焰威 then
                  self:增加愤怒(编号,3)
                  self.参战单位[编号].奇经八脉焰威=1
               end
            end
        end
        local 群体回复 = {攻击方=编号}
        local 群体扣血 = {攻击方=编号}

        local function 添加流程(流程表)
              if not 判断是否为空表(流程表) then
                  for _, v in ipairs(流程表) do
                      if v.类型 == 2 then
                          table.insert(群体回复,v)
                      elseif v.类型 == 1 then
                          table.insert(群体扣血,v)
                      end
                  end
            end
        end

        self.参战单位[编号].法术吸血 = 0
        local 战斗终止=false
        for n=1,前置.目标数 do
            if 战斗终止 or not (前置.目标组[n] and self:取目标状态(编号, 前置.目标组[n], 1) and self:取行动状态(编号)) then
                  战斗终止 = true
                  break
            end
            if 前置.重复攻击 and n ~= 1 then
                前置.流程 = #self.战斗流程 + 1
                self.执行等待 = self.执行等待 + 5
                self.战斗流程[前置.流程] = {
                    流程 = 21,
                    攻击方 = 编号,
                    挨打方 = {},
                    提示 = {允许 = false}
                }
                if 前置.全屏动画 then
                    self.战斗流程[前置.流程].全屏动画=名称
                end
                if 前置.先手动画 then
                    self.战斗流程[前置.流程].先手动画 = 名称
                end
                self:法伤循环处理(编号,前置.目标组[n],n,名称,前置.目标数,等级,前置.流程,1,伤害比,境界)
            else
                self:法伤循环处理(编号,前置.目标组[n],n,名称,前置.目标数,等级,前置.流程,n,伤害比,境界)
            end
            添加流程(self:法伤循环中处理(编号, 前置.目标组[n]))
            添加流程(self:取循环中处理(编号, 前置.目标组[n]))
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



        if self.参战单位[编号].气血>0 and self.参战单位[编号].法术吸血> 0 then
            self:增加气血(编号,self.参战单位[编号].法术吸血)
            self.战斗流程[前置.流程].增加气血 = self.参战单位[编号].法术吸血
        end
        if self.参战单位[编号].气血>0 and 前置.结尾 and 前置.结尾>0 then
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
        if self.参战单位[编号].高级龙魂 and self.参战单位[编号].高级龙魂>=3  then
            self.参战单位[编号].高级龙魂 =0
            self:添加状态("龙魂",编号,编号,self.参战单位[编号].等级)
            self.参战单位[编号].法术状态.龙魂.回合 = 3
            self:处理流程状态(self.战斗流程[前置.流程],"龙魂",编号)
        end
        if self.参战单位[编号].龙魂 and self.参战单位[编号].龙魂>=3  then
           self.参战单位[编号].龙魂 =0
           self:添加状态("龙魂",编号,编号,self.参战单位[编号].等级)
           self:处理流程状态(self.战斗流程[前置.流程],"龙魂",编号)
           if self.参战单位[编号].奇经八脉.盘龙 then
              self.参战单位[编号].奇经八脉盘龙 =self.参战单位[编号].奇经八脉盘龙 +1
           end
        end
        if self.参战单位[编号].类型=="角色" and 玩家数据[self.参战单位[编号].玩家id] then
          玩家数据[self.参战单位[编号].玩家id].角色:耐久处理(self.参战单位[编号].玩家id,3)
        end
end








function 战斗处理类:法伤循环处理(编号,目标,次数,名称,总数,等级,流程,挨打,伤害比)
          self.伤害输出 = 0
          self.战斗流程[流程].挨打方[挨打]={特效={},挨打方=目标}
          self.战斗流程[流程].挨打方[挨打].特效[1] = 战斗技能[名称].特效 and 战斗技能[名称].特效("伤害") or 名称
          local 基础 = DeepCopy(self.计算属性)
          local 数据 = {次数=次数,总数=总数,流程=流程,挨打=挨打}
          if 战斗技能[名称].基础计算 then
              战斗技能[名称].基础计算(self,编号,目标,等级,数据,基础,"伤害",境界)
          end
          if self.参战单位[编号].神器技能 and self.参战单位[编号].神器技能.名称=="裂帛" and 次数==1 then
               基础.结果系数 = 基础.结果系数 + self.参战单位[编号].神器技能.等级 * 0.08
          end
          基础.特效 = {}
          local 计算 = self:取基础法伤伤害(编号,目标,名称,等级,基础)
          if 总数<=5 then
                计算 = 计算 * (1 - (总数-1) * 0.07)
          elseif 总数>5 and 总数<=7 then
                计算 = 计算 * (0.72 - (总数-5) * 0.05)
          else
              计算 = 计算 * (0.62 - (总数-7) * 0.03)
          end
          if 伤害比 then 计算 = 计算*伤害比 end
          计算 = math.floor(计算)
          local 输出 = self:取法伤动作计算(编号,目标,名称,等级,基础) ---{暴击=暴击,减免=减免}
          local 结果 = self:取计算结果(编号,目标,计算,输出.暴击,流程,挨打,基础,名称,等级,"法伤")
          if 结果.类型~=2 and 结果.伤害<1 then
              结果.伤害=取随机数(self.参战单位[编号].法伤*0.05,self.参战单位[编号].法伤*0.1)
          end
          结果.伤害 = math.floor(结果.伤害)
          if 结果.类型==2 then --恢复状态
              self:增加气血(目标,结果.伤害)
          else
              --结果.伤害 = self:取法伤结束计算(编号,目标,结果.伤害,流程,挨打,输出)
              self.伤害输出 = 结果.伤害
              self.战斗流程[流程].挨打方[挨打].死亡=self:减少气血(目标,结果.伤害,编号,名称)
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
              if 基础.法术吸血 then
                  self.参战单位[编号].法术吸血 = self.参战单位[编号].法术吸血 + math.floor(结果.伤害*基础.法术吸血)
              end
              if self.参战单位[目标].类型=="角色" and 玩家数据[self.参战单位[目标].玩家id] then
                  玩家数据[self.参战单位[目标].玩家id].角色:耐久处理(self.参战单位[目标].玩家id,4)
              end
          end

          self.战斗流程[流程].挨打方[挨打].伤害 = 结果.伤害
          self.战斗流程[流程].挨打方[挨打].类型 = 结果.类型
          if 输出.暴击 and 结果.类型~=2 then
             self.战斗流程[流程].挨打方[挨打].特效[2] = "法暴"
             self.战斗流程[流程].挨打方[挨打].类型 = 3
          end
          if 基础.特效 then
              for k,v in ipairs(基础.特效) do
                  table.insert(self.战斗流程[流程].挨打方[挨打].特效, v)
              end
          end
          if 基础.取消状态 then
               self:解除状态组处理(编号,目标,基础.取消状态,名称,流程,挨打)
          end
          if 基础.添加状态 then
              self:添加状态组处理(编号,目标,基础.添加状态,名称,等级,流程,挨打)
          end


          if 基础.造成伤势 and  self.参战单位[目标].类型=="角色" then
              local 伤势 = 结果.伤害
              if 基础.造成伤势.数额 then
                  伤势 = 伤势 + 基础.造成伤势.数额
              end
              if 基础.造成伤势.比例 then
                  伤势 = 伤势 * 基础.造成伤势.比例
              end
              if 伤势>0 then
                  if 基础.造成伤势.类型== 2 then
                      self:恢复伤势(目标,伤势)
                  else
                      self:造成伤势(目标,伤势)
                  end
                   self.战斗流程[流程].挨打方[挨打].伤势 = 伤势
                   self.战斗流程[流程].挨打方[挨打].伤势类型 = 基础.造成伤势.类型 or 1
              end
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

end

function 战斗处理类:法伤循环中处理(编号,目标)  ---------和固伤大部分相同
          local 添加流程={}
          if self.参战单位[目标].法术状态.混元伞 and self.伤害输出>0 and self:取目标状态(目标,目标,2)  then
               local 伤害 = math.floor(self.伤害输出 * (self.参战单位[目标[n]].法术状态.混元伞.境界*0.03+0.1))
               local 流程 = {挨打方=编号,类型=1,伤害=伤害}
               流程.死亡 = self:减少气血(编号,伤害,目标,"混元伞")
               table.insert(添加流程,流程)
          end

          if self.参战单位[目标].法术状态.幻镜术 and 取随机数()<=40 and self.伤害输出>0 and self:取目标状态(目标,目标,2) then
               local 流程 = {挨打方=编号,类型=1,伤害=self.伤害输出}
               流程.死亡 = self:减少气血(编号,self.伤害输出,目标,"幻镜术")
               table.insert(添加流程,流程)
          end
          if self.参战单位[目标].法术状态.天衣无缝 and self.伤害输出>0 and self:取目标状态(目标,目标,2) then
               local 伤害 = math.floor(self.伤害输出 * 0.5)

               local 流程 = {挨打方=编号,类型=1,伤害=伤害}
               流程.死亡 = self:减少气血(编号,伤害,目标,"天衣无缝")
               table.insert(添加流程,流程)
          end
          if self.参战单位[目标].法术状态.身似菩提 and self:取目标状态(编号,编号,2) and self.伤害输出>0 and self:取目标状态(目标,目标,2) then
              local 流程 = {挨打方=编号,类型=1,伤害=self.伤害输出}
              流程.死亡 = self:减少气血(编号,self.伤害输出,目标,"身似菩提")
              table.insert(添加流程,流程)
          end
          return 添加流程
end


