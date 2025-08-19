



function 战斗处理类:物攻技能计算(编号,名称,等级,额外命令,伤害比,境界)
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
        if not 境界 and not 战斗技能[名称].消耗(self,编号,前置.目标数) then
            self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/未到达技能消耗要求,技能使用失败")
            return
        end
        if 战斗技能[名称].前置流程  then
             战斗技能[名称].前置流程(self,编号,等级,前置,"伤害",境界)
        end
        if 前置.结束流程 then return end
        if 前置.名称 then
            名称 = 前置.名称
        end
        if 前置.重复攻击 then
            local 临时目标=前置.目标组[1]
            前置.目标组={}
            for n=1,前置.目标数 do
              前置.目标组[n]=临时目标
            end
        end
        local function 添加流程(流程表)
              if not 判断是否为空表(流程表) then
                  for _, v in ipairs(流程表) do
                      table.insert(self.战斗流程, {流程=50,攻击方=编号,挨打方={v}})
                  end
              end
        end
        local 战斗终止=false
        for n=1,前置.目标数 do
                if 战斗终止 or not (前置.目标组[n] and self:取目标状态(编号, 前置.目标组[n], 1) and self:取行动状态(编号) ) then
                    if self.战斗流程[前置.流程] then
                      self.战斗流程[前置.流程].返回 = true
                    end
                    战斗终止 = true
                    break
                end
                前置.流程 = #self.战斗流程 + 1
                self.执行等待 = self.执行等待 + 5
                self.战斗流程[前置.流程] = {
                      流程 = 1,
                      攻击方 = 编号,
                      挨打方 = {}
                  }
                self:物攻循环处理(编号,前置.目标组[n],n,名称,前置.目标数,等级,前置.流程,1,伤害比,nil,境界)
                添加流程(self:物攻循环中处理(编号, 前置.目标组[n]))
                添加流程(self:取循环中处理(编号, 前置.目标组[n]))
                if n == 1 then
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
                elseif n == 前置.目标数 or not (前置.目标组[n+1] and self:取目标状态(编号, 前置.目标组[n+1], 1) and self:取行动状态(编号)) then
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
        if self.参战单位[编号].超级战意消耗 then
            self.参战单位[编号].超级战意消耗 = nil
            if self.参战单位[编号].奇经八脉.乘势  then
                self.参战单位[编号].奇经八脉强袭 = 4
            end
        end
end






function 战斗处理类:物攻循环处理(编号,目标,次数,名称,总数,等级,流程,挨打,伤害比,群体数据,境界)--编号,目标,次数,总数,等级,流程,挨打
      self.伤害输出 = 0
      -- if 战斗技能[名称].特技 then
      --     self.战斗流程[流程].特技名称 = 名称
      -- end
      self.战斗流程[流程].挨打方[挨打]={挨打方=目标,特效={}}
      local 基础 = DeepCopy(self.计算属性)
      local 数据 = {次数=次数,总数=总数,流程=流程,挨打=挨打}
      if 战斗技能[名称].基础计算 then
          战斗技能[名称].基础计算(self,编号,目标,等级,数据,基础,"伤害",境界)
      end
      基础.特效 = {}
      local 计算 = self:取基础物理伤害(编号,目标,名称,等级,基础)
      if 伤害比 then 计算 = 计算*伤害比 end
      计算 = math.floor(计算)
      local 输出 = self:取物理动作计算(编号,目标,名称,等级,基础) ---{暴击=暴击,动作=动作,保护=保护,编号=保护编号}
      local 结果 = self:取计算结果(编号,目标,计算,输出.暴击,流程,挨打,基础,名称,等级,"物伤",输出.保护)
      self.战斗流程[流程].挨打方[挨打].动作 = 输出.动作
      local 特效 = 战斗技能[名称].特效 and 战斗技能[名称].特效("伤害") or 名称
      self.战斗流程[流程].挨打方[挨打].特效[1] = 特效
      if 基础.特效 then
          for k,v in ipairs(基础.特效) do
              table.insert(self.战斗流程[流程].挨打方[挨打].特效, v)
          end
      end

      if 结果.类型~=2 and 结果.伤害<1 then
          结果.伤害=取随机数(self.参战单位[编号].伤害*0.05,self.参战单位[编号].伤害*0.1)
      end
      if 名称=="溅射" then
          self.战斗流程[流程].挨打方[挨打].特效={"被击中"}
          if self.参战单位[编号].溅射 then
              结果.伤害 = 结果.伤害 * self.参战单位[编号].溅射
          end
          if self.参战单位[编号].奇经八脉.风刃 and self.参战单位[编号].指令.类型=="攻击" then
              结果.伤害 = self.参战单位[编号].等级*3
              if self.参战单位[编号].法术状态.风魂 and 次数==1 then
                  结果.伤害 = 结果.伤害+1000
                  self:取消状态("风魂",编号)
                  self:处理流程状态(self.战斗流程[流程],"风魂")
              end
          end
      end
      结果.伤害 = math.floor(结果.伤害)
      if 结果.类型==2 then --恢复状态
          self:增加气血(目标,结果.伤害)
      else
          结果.伤害 = self:取物理结束计算(编号,目标,结果.伤害,输出.保护,输出.编号,流程,挨打,基础,群体数据)
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
      end
      self.战斗流程[流程].挨打方[挨打].伤害 = 结果.伤害
      self.战斗流程[流程].挨打方[挨打].类型 = 结果.类型
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
      self.战斗流程[流程].九黎连击 = self:九黎连击(self.参战单位[编号])
end




function 战斗处理类:物攻循环中处理(编号,目标)
          local 添加流程={}
          if self.参战单位[编号].奇经八脉.化血 and 取随机数()<=30 and self:取目标状态(编号,编号,2) then
              local 气血=math.floor(self.伤害输出*0.16)
              self:增加气血(编号,气血)
              table.insert(添加流程,{伤害=气血,类型=2,挨打方=编号})
          end
          if self.参战单位[编号].奇经八脉.饮血 and 取随机数()<=30 and self:取目标状态(编号,编号,2) then
              local 气血=math.floor(self.伤害输出*0.16)
              self:增加气血(编号,气血)
              table.insert(添加流程,{伤害=气血,类型=2,挨打方=编号})
          end
          if self.参战单位[编号].奇经八脉.攫取 and 取随机数()<=50 and self:取目标状态(编号,编号,2) then
              local 气血=math.floor(self.伤害输出*0.16)
              self:增加气血(编号,气血)
              table.insert(添加流程,{伤害=气血,类型=2,挨打方=编号})
          end
          return 添加流程
end




function 战斗处理类:取是否反震(编号,目标)

  if self.参战单位[目标].气血 <=0 then
      return false
  elseif self.参战单位[编号].气血<=0 then
      return false
  elseif self.参战单位[编号].偷袭 then
        return false
  elseif self.参战单位[目标].法术状态.混元伞 then
          return true
  elseif self.参战单位[目标].法术状态.修罗咒 then
          return true
  elseif self.参战单位[目标].反震 and 取随机数()<=30  then
          return true
  end



  return false
end


function 战斗处理类:取是否反击(编号,目标)

  if self.参战单位[目标].气血 <=0 then
      return false
  elseif self.参战单位[编号].气血 <=0 then
        return false
  elseif self.参战单位[编号].偷袭 then
          return false
  elseif self.参战单位[目标].法术状态.魔王回首 then
          return true
  elseif self.参战单位[目标].法术状态.极度疯狂 then
          return true
  elseif self.参战单位[目标].反击 and 取随机数()<=30  then
          return true
  -- elseif self.参战单位[编号].法术状态.诱袭 then
  --         return 1
  end
  return false
end


function 战斗处理类:取是否合击(编号,目标)
  if self.参战单位[目标]==nil or self:取玩家战斗()==true then
    return false
  elseif self.参战单位[编号].队伍==0 or self.参战单位[编号].气血<=0 then
    return false
  elseif self.参战单位[目标].队伍==self.参战单位[编号].队伍 then
    return false
  elseif self.参战单位[目标].气血==0 or self.参战单位[目标].法术状态.楚楚可怜~=nil or self.参战单位[目标].法术状态.催眠符~=nil or self.参战单位[目标].法术状态.分身术~=nil then
    return false
  elseif self.参战单位[目标].指令.类型=="防御" then
    return false
  elseif 取随机数()<=10 then
  --检查是否有保护
    for n=1,#self.参战单位 do
        if self:取行动状态(n) and self.参战单位[目标].法术状态.惊魂掌==nil and self.参战单位[n].指令.类型=="保护" and  self.参战单位[n].队伍==self.参战单位[目标].队伍 and  self.参战单位[n].指令.目标==目标 then
            return false
        end
    end
  --检查有无相同攻击方
    local 队友组={}
    local 队友=0
    for n=1,#self.参战单位 do
      if n~=编号 and self:取行动状态(n) and self:取攻击状态(n) and self.参战单位[n].气血>0 and self.参战单位[n].队伍==self.参战单位[编号].队伍 and self.参战单位[n].指令.执行==nil and self.参战单位[n].指令.类型=="攻击" and self.参战单位[n].指令.目标==目标 then
        队友组[#队友组+1]=n
      end
    end
    if #队友组==0 then
        return false
    else
        队友=队友组[取随机数(1,#队友组)]
        self.战斗流程[#self.战斗流程+1]={流程=53,攻击方=编号,队友=队友,返回=true,挨打方={[1]={挨打方=目标,伤害=伤害,特效={}}}}
        local 基础 = DeepCopy(self.计算属性)
        local 计算 = self:取基础物理伤害(编号,目标,"普通攻击",self.参战单位[编号].等级,基础)
        local 队友基础 = DeepCopy(self.计算属性)
        local 队友计算 = self:取基础物理伤害(队友,目标,"普通攻击",self.参战单位[队友].等级,队友基础)
        local 结果总计 = math.floor(计算 + 队友计算)
        local 输出 = self:取物理动作计算(编号,目标,"普通攻击",self.参战单位[编号].等级,基础) ---{暴击=暴击,动作=动作,保护=保护,编号=保护编号}
        local 结果 = self:取计算结果(编号,目标,结果总计,输出.暴击,#self.战斗流程,1,基础,"普通攻击",self.参战单位[编号].等级,"合击",输出.保护)
        if 结果.类型==2 then
            self:增加气血(目标,结果.伤害)
        else
            结果.伤害 = self:取物理结束计算(编号,目标,结果.伤害,输出.保护,输出.保护编号,#self.战斗流程,1,基础)
            self.战斗流程[#self.战斗流程].挨打方[1].死亡= self:减少气血(目标,结果.伤害,编号,"合击")
        end
        self.战斗流程[#self.战斗流程].挨打方[1].伤害 = 结果.伤害
        self.战斗流程[#self.战斗流程].挨打方[1].类型 = 结果.类型
        self.参战单位[编号].指令.下达=true
        self.参战单位[编号].指令.类型=""
        self.参战单位[队友].指令.下达=true
        self.参战单位[队友].指令.类型=""
      return true
    end
  end
  return false
end






