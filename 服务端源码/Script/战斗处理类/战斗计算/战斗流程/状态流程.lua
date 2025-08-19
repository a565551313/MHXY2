

function 战斗处理类:添加状态(名称,目标,编号,等级,境界)
          if not 战斗技能[名称] then return end
          local 状态 = DeepCopy(self.状态属性)
          if 战斗技能[名称].添加状态 then
              战斗技能[名称].添加状态(self,编号,目标,等级,境界,状态)
          end
          if 状态.不可添加 or self.参战单位[目标].法术状态[名称] then
              return
          end

          self.参战单位[目标].法术状态[名称]={编号=编号,境界=境界}
          local 状态处理 =function(状态组)
                for k,v in pairs(状态组) do
                    if type(v)=="table" then
                          状态处理(v)
                          状态组[k]=nil
                    else
                        self.参战单位[目标].法术状态[名称][k] = v
                    end
                end
          end
          状态处理(状态)
          for k,v in pairs(状态) do
            if k~="回合" and k~="类型" and self.状态属性[k] and self.参战单位[目标][k] and v ~=0  then
                if 状态.类型==1 then
                      self.参战单位[目标][k] = self.参战单位[目标][k] - v
                else
                      self.参战单位[目标][k] = self.参战单位[目标][k] + v
                end
            end
          end
end

function 战斗处理类:取消状态(名称,单位)
        if type(单位) == "table" then
            编号=单位.编号
        else
            编号=单位
        end-----------需修改全部
        if not self.参战单位[编号].法术状态[名称] then
           return
        end
        for k,v in pairs(self.状态属性) do
            if k~="回合" and k~="类型" and self.状态属性[k] and self.参战单位[编号][k] and self.参战单位[编号].法术状态[名称][k] and self.参战单位[编号].法术状态[名称][k]~=0 then
                if self.参战单位[编号].法术状态[名称].类型==2 then
                    self.参战单位[编号][k] = self.参战单位[编号][k] - self.参战单位[编号].法术状态[名称][k]
                else
                    self.参战单位[编号][k] = self.参战单位[编号][k] + self.参战单位[编号].法术状态[名称][k]
                end
            end
        end
        if self.参战单位[编号].气血>=self.参战单位[编号].最大气血 then
          self.参战单位[编号].气血=self.参战单位[编号].最大气血
        end
        if self.参战单位[编号].魔法>=self.参战单位[编号].最大魔法 then
          self.参战单位[编号].魔法=self.参战单位[编号].最大魔法
        end
        self.参战单位[编号].法术状态[名称]=nil
end

function 战斗处理类:增益技能计算(编号,名称,等级,额外命令,境界,套装)
        local 前置 = {
            结尾 = 0,
            重复攻击 = false,
            目标数 = 1,
            目标 = 战斗技能[名称].目标(self, 编号, 额外命令 and 额外命令.目标 or self.参战单位[编号].指令.目标),
            流程 = #self.战斗流程
        }
        if 套装 then
            前置.目标 = 编号
            前置.目标组 = {编号}
            前置.目标数 = 1
        else
            if 战斗技能[名称].人数 then
                前置.目标数 = 战斗技能[名称].人数(self, 编号,等级,境界)
            end
            前置.目标组 = {}
            if 战斗技能[名称].敌方 then
                前置.目标组 = self:取敌方目标组(编号,前置.目标,前置.目标数,名称)
            else
                前置.目标组 = self:取友方目标组(编号,前置.目标,前置.目标数,名称)
            end
            前置.目标数=#前置.目标组
            if 前置.目标数==0 then return end
            if not 境界 and not 战斗技能[名称].消耗(self, 编号,前置.目标数) then
                self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/未到达技能消耗要求,技能使用失败")
                return
            end
            if 战斗技能[名称].前置流程 then
                 战斗技能[名称].前置流程(self,编号,等级,前置,"增益")
            end
            if 前置.结束流程 then return end
            if 前置.名称 then
                名称 = 前置.名称
            end
        end
        if 前置.目标 and 前置.目标==编号 and not self:取目标状态(编号,前置.目标,2) then
            return
        end
        前置.流程 = #self.战斗流程 + 1
        self.执行等待=self.执行等待+5
        self.战斗流程[前置.流程] = {
            流程 = 27,
            攻击方 = 编号,
            挨打方 = {}
        }
        if not 前置.技能提示 then
            self.战斗流程[前置.流程].提示 = {
                允许 = true,
                类型 = "法术",
                名称 = 名称
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
        if 前置.重复攻击 then
            local 临时目标=前置.目标组[1]
            前置.目标组={}
            for n=1,前置.目标数 do
              前置.目标组[n]=临时目标
            end
        end
        local 战斗终止=false
        local function 执行增益(目标1)
            if not 目标1 then
                return false
            end
            if 战斗技能[名称].敌方 then
               return self:取目标状态(编号,目标1,1)
            else
                 return self:取目标状态(编号,目标1,2)
            end
        end
        for n=1,前置.目标数 do
              if not 战斗终止 and 执行增益(前置.目标组[n]) then
                  if 前置.重复攻击 and n~=1 then
                      if self:取行动状态(编号) then
                          前置.流程 = #self.战斗流程 + 1
                          self.执行等待 = self.执行等待 + 5
                          self.战斗流程[前置.流程] = {
                              流程 = 27,
                              攻击方 = 编号,
                              挨打方 = {},
                              提示 = {允许 = false}
                          }
                          if 前置.全屏动画 then
                              self.战斗流程[前置.流程].全屏动画 = 名称
                          end
                          if 前置.先手动画 then
                              self.战斗流程[前置.流程].先手动画 = 名称
                          end
                          self:增益循环处理(编号,前置.目标组[n],n,名称,前置.目标数,等级,前置.流程,1,境界)
                      else
                          战斗终止=true
                      end
                  else
                      self:增益循环处理(编号,前置.目标组[n],n,名称,前置.目标数,等级,前置.流程,n,境界)
                  end
              end
        end
        if self.参战单位[编号].气血>0 and 前置.结尾 and 前置.结尾>0 then
            self.战斗流程[前置.流程].减少气血=前置.结尾
            self.战斗流程[前置.流程].死亡 = self:减少气血(编号,前置.结尾,编号,名称)
        end
        local 返回 = {}
        if 战斗技能[名称].结束流程 then
              战斗技能[名称].结束流程(self,编号,self.伤害输出,等级,前置,返回,"增益")
        end
        if 返回.取消状态 then
            self:解除状态组处理(编号,编号,返回.取消状态,名称,前置.流程)
        end
        if 返回.添加状态 then
            self:添加状态组处理(编号,编号,返回.添加状态,名称,等级,前置.流程)
        end

end







function 战斗处理类:增益循环处理(编号,目标,次数,名称,总数,等级,流程,挨打,境界)
          self.伤害输出 = 0
          self.战斗流程[流程].挨打方[挨打]={特效={},挨打方=目标}
          self.战斗流程[流程].挨打方[挨打].特效[1] = 战斗技能[名称].特效 and 战斗技能[名称].特效("增益") or 名称
          local 基础 = DeepCopy(self.计算属性)
          local 数据 = {次数=次数,总数=总数,流程=流程,挨打=挨打}
          if 战斗技能[名称].基础计算 then
                战斗技能[名称].基础计算(self,编号,目标,等级,数据,基础,"增益",境界)
          end
          if 基础.初始伤害 and 基础.初始伤害 > 0 then
              local 结果=self:取基础治疗计算(编号,目标,名称,等级,基础) ---返回 暴击,最后结果
              if 总数<=5 then
                  结果.气血 = math.floor(结果.气血 *(1 - (总数-1) * 0.05))
              else
                  结果.气血 = math.floor(结果.气血 *(0.8 - (总数-5) * 0.02))
              end
              self.伤害输出 = 结果.气血
              self:增加气血(目标,结果.气血)
              self.战斗流程[流程].挨打方[挨打].伤害 = 结果.气血
              self.战斗流程[流程].挨打方[挨打].类型 = 2
              if 结果.暴击 then
                 self.战斗流程[流程].挨打方[挨打].特效[2]="法暴"
                 self.战斗流程[流程].挨打方[挨打].类型=5
              end
              if 基础.扣除魔法 then
                  self:减少魔法(目标,math.floor(结果.气血 * 基础.扣除魔法))
              end
          end
          if 基础.增加魔法 then
              self:增加魔法(目标,math.floor(基础.增加魔法))
          end
          if 基础.减少气血 then
              self.战斗流程[流程].挨打方[挨打].伤害1 = 基础.减少气血
              self.战斗流程[流程].挨打方[挨打].类型1 = 1
              self.战斗流程[流程].挨打方[挨打].死亡1 = self:减少气血(目标,基础.减少气血,编号,名称)
          end
          if 基础.造成伤势 and  self.参战单位[目标].类型=="角色" then
              local 伤势 = self.伤害输出
              if 基础.造成伤势.数额 then
                  伤势 = 伤势 + 基础.造成伤势.数额
              end
              if 基础.造成伤势.比例 then
                  伤势 = 伤势 * 基础.造成伤势.比例
              end
              if 伤势>0 then
                  if 基础.造成伤势.类型== 1 then
                      self:造成伤势(目标,伤势)
                  else
                       self:恢复伤势(目标,伤势)
                  end
                   self.战斗流程[流程].挨打方[挨打].伤势 = 伤势
                   self.战斗流程[流程].挨打方[挨打].伤势类型 = 基础.造成伤势.类型 or 2
              end
          end
          if 基础.取消状态 then
               self:解除状态组处理(编号,目标,基础.取消状态,名称,流程,挨打)
          end
          if 基础.添加状态 then
                self:添加状态组处理(编号,目标,基础.添加状态,名称,等级,流程,挨打)
          elseif not 基础.无需状态 then
                 self:添加状态(名称,目标,编号,等级,境界)
                 self:处理流程状态(self.战斗流程[流程].挨打方[挨打],名称,目标)
          end
          if 战斗技能[名称].循环结束 then
              战斗技能[名称].循环结束(self,编号,目标,self.伤害输出,等级,数据,"增益")
          end
          if 数据.取消状态 then
               self:解除状态组处理(编号,目标,数据.取消状态,名称,流程,挨打)
          end
          if 数据.添加状态 then
                self:添加状态组处理(编号,目标,数据.添加状态,名称,等级,流程,挨打)
          end

end


function 战斗处理类:减益技能计算(编号,名称,等级,额外命令,境界)
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
        前置.目标组 = self:取敌方目标组(编号,前置.目标,前置.目标数,名称)
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
             战斗技能[名称].前置流程(self,编号,等级,前置,"减益")
        end
        if 前置.结束流程 then return end
        if 前置.名称 then
            名称 = 前置.名称
        end
        前置.流程 = #self.战斗流程 + 1
        self.执行等待=self.执行等待+5
        self.战斗流程[前置.流程] = {
            流程 = 21,
            攻击方 = 编号,
            挨打方 = {}
        }
        if not 前置.技能提示 then
            self.战斗流程[前置.流程].提示 = {
                允许 = true,
                类型 = "法术",
                名称 = 名称
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
        if 前置.重复攻击 then
            local 临时目标=前置.目标组[1]
            前置.目标组={}
            for n=1,前置.目标数 do
              前置.目标组[n]=临时目标
            end
        end

        local 战斗终止=false
        for n=1,前置.目标数 do
               if 战斗终止 or not (前置.目标组[n] and self:取目标状态(编号, 前置.目标组[n], 1) and self:取行动状态(编号)) then
                    战斗终止 = true
                    break
                end
                  if 前置.重复攻击 and n~=1 then
                      前置.流程 = #self.战斗流程 + 1
                      self.执行等待 = self.执行等待 + 5
                      self.战斗流程[前置.流程] = {
                              流程 = 21,
                              攻击方 = 编号,
                              挨打方 = {},
                              提示 = {允许 = false}
                      }
                      if 前置.全屏动画 then
                          self.战斗流程[前置.流程].全屏动画 = 名称
                      end
                      if 前置.先手动画 then
                          self.战斗流程[前置.流程].先手动画 = 名称
                      end
                      self:减益循环处理(编号,前置.目标组[n],n,名称,前置.目标数,等级,前置.流程,1,境界)
                  else
                      self:减益循环处理(编号,前置.目标组[n],n,名称,前置.目标数,等级,前置.流程,n,境界)
                  end

        end
        if self.参战单位[编号].气血>0 and 前置.结尾 and 前置.结尾>0 then
            self.战斗流程[前置.流程].减少气血=前置.结尾
            self.战斗流程[前置.流程].死亡 = self:减少气血(编号,前置.结尾,编号,名称)
        end
        local 返回 = {}
        if 战斗技能[名称].结束流程 then
              战斗技能[名称].结束流程(self,编号,self.伤害输出,等级,前置,返回,"减益")
        end
        if 返回.取消状态 then
            self:解除状态组处理(编号,编号,返回.取消状态,名称,前置.流程)
        end
        if 返回.添加状态 then
            self:添加状态组处理(编号,编号,返回.添加状态,名称,等级,前置.流程)
        end




end











function 战斗处理类:减益循环处理(编号,目标,次数,名称,总数,等级,流程,挨打,境界)
          self.伤害输出 = 0
          self.战斗流程[流程].挨打方[挨打]={特效={},挨打方=目标}
          self.战斗流程[流程].挨打方[挨打].特效[1] = 战斗技能[名称].特效 and 战斗技能[名称].特效("减益") or 名称

          local 基础 = DeepCopy(self.计算属性)
          local 数据 = {次数=次数,总数=总数,流程=流程,挨打=挨打}
          if 战斗技能[名称].基础计算 then
               战斗技能[名称].基础计算(self,编号,目标,等级,数据,基础,"减益",境界)
          end
          if 基础.初始伤害 and 基础.初始伤害 > 0 then
              local 结果=self:取基础治疗计算(编号,目标,名称,等级,基础) ---返回 暴击,最后结果
              if 总数<=5 then
                  结果.气血 = math.floor(结果.气血 *(1 - (总数-1) * 0.05))
              else
                  结果.气血 = math.floor(结果.气血 *(0.8 - (总数-5) * 0.02))
              end
              self.伤害输出 = 结果.气血
              self:增加气血(目标,结果.气血)
              self.战斗流程[流程].挨打方[挨打].伤害 = 结果.气血
              self.战斗流程[流程].挨打方[挨打].类型 = 2
              if 结果.暴击 then
                 self.战斗流程[流程].挨打方[挨打].特效[2]="法暴"
                 self.战斗流程[流程].挨打方[挨打].类型=5
              end
              if 基础.扣除魔法 then
                  self:减少魔法(目标,math.floor(结果.气血 * 基础.扣除魔法))
              end
          end
          if 基础.减少气血 then
              self.战斗流程[流程].挨打方[挨打].伤害1 = 基础.减少气血
              self.战斗流程[流程].挨打方[挨打].类型1 = 1
              self.战斗流程[流程].挨打方[挨打].死亡1 = self:减少气血(目标,基础.减少气血,编号,名称)
          end
          if 基础.增加魔法 then
              self:增加魔法(目标,math.floor(基础.增加魔法))
          end
          if 基础.造成伤势 and  self.参战单位[目标].类型=="角色" then
              local 伤势 = self.伤害输出
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
          if 基础.取消状态 then
               self:解除状态组处理(编号,目标,基础.取消状态,名称,流程,挨打)
          end
          if 基础.添加状态 then
                self:添加状态组处理(编号,目标,基础.添加状态,名称,等级,流程,挨打)
          elseif not 基础.无需状态 then
                 self:添加状态(名称,目标,编号,等级,境界)
                 self:处理流程状态(self.战斗流程[流程].挨打方[挨打],名称,目标)
          end



          if 战斗技能[名称].循环结束 then
              战斗技能[名称].循环结束(self,编号,目标,self.伤害输出,等级,数据,"减益")
          end
          if 数据.取消状态 then
               self:解除状态组处理(编号,目标,数据.取消状态,名称,流程,挨打)
          end
          if 数据.添加状态 then
                self:添加状态组处理(编号,目标,数据.添加状态,名称,等级,流程,挨打)
          end

end


