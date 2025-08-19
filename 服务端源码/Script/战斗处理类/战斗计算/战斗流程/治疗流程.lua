






function 战斗处理类:取基础治疗计算(编号,目标,名称,等级,系数)
          --系数= {初始系数=1,叠加系数=0,初始伤害=0,防御系数=1,忽视防御=0, ---初始计算
          --       暴击系数=1,暴击增加=0,暴伤系数=1,暴伤增加=0,            ---暴击计算
          --       结果系数=1,结果伤害=0,特效={}}                         ---最终计算
          if self.参战单位[编号].奇经八脉.施他 then
               local 增益 = self:取增益数量(编号)
               if 增益 and 增益>0 then
                  系数.初始伤害 = 系数.初始伤害 + 40
               end
          end
          if self.参战单位[编号].符石技能.万丈霞光 then
              系数.初始伤害 = 系数.初始伤害 +self.参战单位[编号].符石技能.万丈霞光
          end
          if self:取指定法宝(编号,"慈悲",1) then
               系数.初始系数 = 系数.初始系数 + self:取指定法宝(编号,"慈悲")*0.025
          end
          if self.参战单位[编号].奇经八脉.灵照 then
             local 添加 = 0
             for i=1,#self.参战单位 do
               if self.参战单位[i].队伍 ==  self.参战单位[编号].队伍 and  self:取增益数量(i)>1 then
                  添加 = 添加 + 1
               end
             end
             系数.初始伤害 = 系数.初始伤害 + 玩家数据[self.参战单位[编号].玩家id].经脉:武器伤害处理(添加*3)
          end
          if self.参战单位[编号].奇经八脉.护法 then
             local 添加 = 玩家数据[self.参战单位[编号].玩家id].经脉:武器伤害处理(4)
             for i=1,#self.参战单位 do
               if self.参战单位[i].队伍 ==  self.参战单位[编号].队伍 and  self.参战单位[i].法术状态.护盾 then
                  系数.初始伤害 = 系数.初始伤害 + 添加
               end
             end
          end
          if self.参战单位[编号].神器技能玉魄 and self.参战单位[编号].神器技能玉魄回合 and self.参战单位[编号].神器技能玉魄回合~=self.回合数 then
              系数.初始伤害 = 系数.初始伤害 + self.参战单位[编号].神器技能玉魄
          end

-------------------------------------------------结果加成

          if self.参战单位[目标].佛眷加成 then
              系数.结果系数 = 系数.结果系数 + 0.3
          end
          if self.参战单位[编号].奇经八脉.木精 then
               if self:取装备五行(编号,3)=="木" then
                  系数.结果系数 = 系数.结果系数 + 0.03
               end
               if self:取装备五行(编号,4)=="木" then
                  系数.结果系数 = 系数.结果系数 + 0.03
               end
          end
          if self.参战单位[编号].聚气加成 then
               if self.参战单位[编号].奇经八脉.聚念 then
                  系数.结果系数 = 系数.结果系数 + 0.75
               else
                  系数.结果系数 = 系数.结果系数 + 0.3
               end
          end
          if self.参战单位[目标].永恒 then --重写
              系数.结果系数 = 系数.结果系数 + self.参战单位[目标].永恒
          end
          if self.参战单位[目标].灵宝乾坤木卷 then
              系数.结果系数 = 系数.结果系数 + self.参战单位[目标].灵宝乾坤木卷
          end
          if self.参战单位[编号].奇经八脉.佛缘 and self:取装备五行(编号,3)~="无" then
               local 玩家五行 = self:取装备五行(编号,3)
               local 队友武器 = self:取装备五行(目标,3)
               local 队友衣服 = self:取装备五行(目标,4)
               if self:取五行相生(玩家五行,队友武器) then
                  系数.结果系数 = 系数.结果系数 + 0.02
               end
               if self:取五行相生(玩家五行,队友衣服) then
                  系数.结果系数 = 系数.结果系数 + 0.02
               end
          end
          if self.参战单位[编号].战斗赐福 and self.参战单位[编号].战斗赐福.治疗结果>0 then
             系数.结果系数 = 系数.结果系数 + self.参战单位[编号].战斗赐福.治疗结果/100
          end
          if self.参战单位[编号].奇经八脉.滋润 and self.参战单位[目标].气血>self.参战单位[目标].最大气血*0.7 then
              系数.结果系数 = 系数.结果系数 + 0.03
          end
          if self.参战单位[编号].奇经八脉.圣手  and self.参战单位[目标].气血>= self.参战单位[目标].最大气血*0.7 then
              系数.结果系数 = 系数.结果系数 + 0.03
          end
          if  self.参战单位[编号].神话词条 then
               if self.参战单位[编号].门派=="神木林" and self.参战单位[编号].神话词条.月神附体 then
                  if 取随机数()<=self.参战单位[编号].神话词条.月神附体*12 then
                        系数.结果系数 = 系数.结果系数 + 1
                  else
                        系数.结果伤害 = 系数.结果伤害 + self.参战单位[编号].等级 * self.参战单位[编号].神话词条.月神附体
                  end
               end
               if self.参战单位[编号].神话词条.无极命源 then
                  系数.结果系数 = 系数.结果系数 + self.参战单位[编号].神话词条.无极命源*0.04
               end
          end
          if self.参战单位[编号].奇经八脉.佛法 and self.参战单位[编号].法术状态.佛法无边 and self:取是否单独门派(编号) then
               系数.结果系数 = 系数.结果系数 + 0.3
          end

          if self.参战单位[编号].神器技能 and self.参战单位[编号].神器技能.名称=="挥毫" and self:取增益数量(目标)>1 then
              系数.结果伤害 = 系数.结果伤害 + self.参战单位[编号].神器技能.等级*25*self:取增益数量(目标)
          end

-----------------------------------------削弱


          if not self.参战单位[目标].奇经八脉偷龙转凤 then
              if self.参战单位[编号].奇经八脉销武 then
                  系数.结果系数 = 系数.结果系数 - 0.5
              end
              if self.参战单位[目标].奇经八脉情劫 then
                  系数.结果系数 = 系数.结果系数 - 0.5
                  self.参战单位[目标].奇经八脉情劫 =nil
              end
              if self.参战单位[目标].法术状态.腾雷 then
                  系数.结果系数 = 系数.结果系数 - 0.5
              end
              if self.参战单位[目标].法术状态.瘴气 then
                  系数.结果系数 = 系数.结果系数 - 0.5
              end
              if self.参战单位[目标].法术状态.重创 then
                   系数.结果系数 = 系数.结果系数 - 0.5
              end

              if self.参战单位[编号].奇经八脉.木魂 then
                 系数.结果系数 = 系数.结果系数 - 0.5
              end
              if self.参战单位[编号].奇经特效.五行珠 then
                  系数.结果系数 = 系数.结果系数 - 0.5
              end

              if self.参战单位[目标].法术状态.谜毒之缚 then
                  系数.结果系数 = 系数.结果系数 - 0.2
              end
              if self.参战单位[编号].法术状态.莲心剑意 then
                  系数.结果系数 = 系数.结果系数 - 0.1
              end
              if self.参战单位[目标].法术状态.魔音摄魂 then
                   系数.结果系数 = 系数.结果系数 - 1
              end

          elseif self.参战单位[目标].奇经八脉偷龙转凤 and 系数.结果系数<1 then
                  系数.结果系数 = 1
          end

          if self.参战单位[编号].队伍==0 then
                if self.参战单位[编号].名称=="酒肉和尚帮凶" and self.战斗类型==110010 then
                      系数.结果系数 = 系数.结果系数 + 3
                elseif self.参战单位[编号].名称=="守门天将" and  self.战斗类型==110008 then
                      系数.结果系数 = 系数.结果系数 + 10
                elseif self.战斗类型==100055 and (self.参战单位[编号].名称=="护驾亲兵 " or self.参战单位[编号].名称=="云霄仙子 " or self.参战单位[编号].名称=="勾魂使者 " or self.参战单位[编号].名称=="泼法金刚 " or self.参战单位[编号].名称=="护法枷蓝 ") then
                      系数.结果系数 = 系数.结果系数 + 10
                elseif self.战斗类型==100056 and self.参战单位[编号].类型~="角色" then
                      系数.结果系数 = 系数.结果系数 + 10
                elseif self.战斗类型==110007 and self.参战单位[编号].名称=="赌徒喽罗" then
                      系数.结果系数 = 系数.结果系数 + 10
                elseif self.战斗类型==100257 and self.参战单位[编号].名称=="花妖喽罗" then
                      系数.结果系数 = 系数.结果系数 + 10
                elseif self.战斗类型==100258 and self.参战单位[编号].名称=="天兵喽罗" then
                      系数.结果系数 = 系数.结果系数 + 10
                elseif self.战斗类型==100259 and self.参战单位[编号].名称=="虾兵喽啰" then
                      系数.结果系数 = 系数.结果系数 + 10
                elseif self.战斗类型==100261 and (self.参战单位[编号].名称=="空度禅师" or self.参战单位[编号].名称=="地涌夫人") then
                      系数.结果系数 = 系数.结果系数 + 15
                end
          end

----------------------------------------------暴击加成

          if self.参战单位[编号].奇经八脉.归气 then
              local 生效 = false
              if self.参战单位[编号].奇经特效.明光  and 取随机数()<=18 then
                   系数.暴击系数 = 系数.暴击系数 + 0.18
                   生效 = true
              end
              if self.参战单位[编号].奇经特效.明光  and 取随机数()<=18 then
                   系数.暴击系数 = 系数.暴击系数 + 0.18
                   生效 = true
              end
              if 生效 then
                 系数.暴伤系数 = 系数.暴伤系数 - 0.4
              elseif self.参战单位[编号].奇经八脉佛显加成 then
                    系数.暴击系数 = 系数.暴击系数 + 0.18
                    系数.暴伤系数 = 系数.暴伤系数 - 0.4
              end
          elseif (self.参战单位[编号].奇经特效.明光  and 取随机数()<=18) or (self.参战单位[编号].奇经八脉佛显加成 and not self.参战单位[编号].奇经八脉.归气) then
                  系数.暴击系数 = 系数.暴击系数 + 0.18
          end


          -------------------------------------------------暴击
          local 暴击 = false
          local 暴击几率 = 1
          local 暴击数额 = self.参战单位[编号].法术暴击等级
          if 暴击数额>0 then
               暴击几率 = 暴击几率 + 暴击数额/30
          end
          暴击几率 = math.floor(暴击几率 * 系数.暴击系数 + 系数.暴击增加 + (self.参战单位[编号].法暴 or 0))
          if 暴击几率>=98 then
              暴击几率 = 98
          end
          if 暴击几率>=取随机数(1,100) then
              暴击 = true
              系数.结果系数 = 系数.结果系数 + 系数.暴伤系数 + 1
              系数.结果伤害 = 系数.结果伤害 + 系数.暴伤增加
          end
          if 系数.结果系数<=0 then 系数.结果系数 = 0.1 end

          local 气血 = (self.参战单位[编号].治疗能力 + 系数.初始伤害) * 系数.初始系数 + self.参战单位[目标].气血回复效果
          气血 = 气血 * (1+self.参战单位[编号].法术修炼*0.025+self.参战单位[编号].攻击修炼*0.01)
          气血 = math.floor(气血 * 系数.结果系数 + 系数.结果伤害)
          if 系数.固定结果 then
            气血 = math.floor(系数.固定结果)
          end
          return {气血=气血,暴击=暴击}
end






function 战斗处理类:治疗技能计算(编号,名称,等级,额外命令,境界)
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
        前置.目标组 = {}
        if 战斗技能[名称].类型=="复活" then
            前置.目标组 = self:取复活目标组(编号,前置.目标,名称,前置.目标数)
            if not 前置.目标组 or #前置.目标组==0 then
                self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/当前无可复活目标")
                return
            end
        else
              前置.目标组 = self:取友方目标组(编号,前置.目标,前置.目标数,名称)
        end
        前置.目标数=#前置.目标组
        if 前置.目标数==0 then return end
        if not 境界 and not 战斗技能[名称].消耗(self, 编号, 前置.目标数) then
            self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/未到达技能消耗要求,技能使用失败")
            return
        end
        if 战斗技能[名称].前置流程 then
             战斗技能[名称].前置流程(self,编号,等级,前置,"治疗",境界)
        end
        if 前置.结束流程 then return end
        if 前置.名称 then
            名称 = 前置.名称
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
                类型 = "加血",
                名称 = 名称
            }
            if 战斗技能[名称].特技 then
                self.战斗流程[前置.流程].提示.类型 = "特技"
            elseif 战斗技能[名称].法宝 then
                    self.战斗流程[前置.流程].提示.类型 = "法宝"
            elseif 战斗技能[名称].灵宝 then
                    self.战斗流程[前置.流程].提示.类型 = "灵宝"
            elseif 战斗技能[名称].类型=="复活" then
                self.战斗流程[前置.流程].提示.类型 = "复活"
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

        if 前置.重复攻击 and 战斗技能[名称].类型~="复活" then
            local 临时目标=前置.目标组[1]
            前置.目标组={}
            for n=1,前置.目标数 do
              前置.目标组[n]=临时目标
            end
        end

        local 战斗终止=false

        local function 执行治疗(目标1)
              if not 目标1 then
                   return false
              end
              if 战斗技能[名称].类型~="复活" then
                  return self:取目标状态(编号,目标1,2)
              end
              return true
        end

        for n=1,前置.目标数 do
              if 战斗终止 or not 执行治疗(前置.目标组[n]) then
                  战斗终止 =true
                  break
              end
              if 前置.重复攻击 and n~=1 then
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
                    self:治疗循环处理(编号,前置.目标组[n],n,名称,前置.目标数,等级,前置.流程,1,境界)
              else
                  self:治疗循环处理(编号,前置.目标组[n],n,名称,前置.目标数,等级,前置.流程,n,境界)
              end
        end
        if self.参战单位[编号].气血>0 and 前置.结尾 and 前置.结尾>0 then
            self.战斗流程[前置.流程].减少气血=前置.结尾
            self.战斗流程[前置.流程].死亡 = self:减少气血(编号,前置.结尾,编号,名称)
        end

        local 返回 = {}
        if 战斗技能[名称].结束流程 then
              战斗技能[名称].结束流程(self,编号,self.伤害输出,等级,前置,返回,"治疗")
        end
        if 返回.取消状态 then
            self:解除状态组处理(编号,编号,返回.取消状态,名称,前置.流程)
        end
        if 返回.添加状态 then
            self:添加状态组处理(编号,编号,返回.添加状态,名称,等级,前置.流程)
        end

end




function 战斗处理类:治疗循环处理(编号,目标,次数,名称,总数,等级,流程,挨打,境界)
          self.伤害输出 = 0
          self.战斗流程[流程].挨打方[挨打]={特效={},挨打方=目标}
          self.战斗流程[流程].挨打方[挨打].特效[1] = 战斗技能[名称].特效 and 战斗技能[名称].特效("治疗") or 名称
          local 基础 = DeepCopy(self.计算属性)
          local 数据 = {次数=次数,总数=总数,流程=流程,挨打=挨打}
          if 战斗技能[名称].基础计算 then
              战斗技能[名称].基础计算(self,编号,目标,等级,数据,基础,"治疗",境界)
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
              if 战斗技能[名称].类型=="复活" then
                  table.insert(self.执行复活,目标)
                  self.战斗流程[流程].挨打方[挨打].复活=true
                  self.回合复活=true
              end
              if self.参战单位[目标].神器技能 and self.参战单位[目标].神器技能.名称=="镜花水月" then
                  local 几率 = self.参战单位[目标].神器技能.等级*8
                  if 取随机数()<=几率 then
                    self:添加状态("护盾",目标,目标,结果.气血)
                    self:处理流程状态(self.战斗流程[流程].挨打方[挨打],"护盾",目标)
                  end
              end
              if self.参战单位[编号].神器技能 and self.参战单位[编号].神器技能.名称=="风起云墨" and 次数==1 then
                  self.参战单位[目标].神器技能风起云墨 = self.参战单位[编号].神器技能.等级*0.04
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
          end


          if 战斗技能[名称].循环结束 then
              战斗技能[名称].循环结束(self,编号,目标,self.伤害输出,等级,数据,"治疗")
          end
          if 数据.取消状态 then
               self:解除状态组处理(编号,目标,数据.取消状态,名称,流程,挨打)
          end
          if 数据.添加状态 then
                self:添加状态组处理(编号,目标,数据.添加状态,名称,等级,流程,挨打)
          end

end



function 战斗处理类:取是否复活(编号,目标,名称)
        if not self.参战单位[目标] then
              return false
        elseif self.参战单位[目标].队伍~=self.参战单位[编号].队伍 then
               return false
        elseif self.参战单位[目标].气血>0 then
                return false
        elseif self.参战单位[目标].奇经八脉秘术 then
                return false
        elseif self.参战单位[目标].鬼魂 and 名称~="莲花心音" then
                return false
        elseif self.参战单位[目标].类型 ~= "角色"
              and self.参战单位[目标].类型 ~= "系统pk角色"
              and not self.参战单位[目标].鬼魂 then
                return false
        elseif self.参战单位[目标].类型 == 战斗技能[名称].无效类型 then
                return false
        end
        if  self.参战单位[目标].法术状态.死亡召唤 then
               if 名称=="百草复苏" or 名称 == "百草神木复苏" then
                    if not self.参战单位[目标].奇经八脉.破军 and (not self.参战单位[编号].奇经八脉.润泽 or self.参战单位[目标].法术状态.死亡召唤.回合<=3)  then
                         return false
                    elseif not self.参战单位[编号].奇经八脉.润泽 and self.参战单位[目标].奇经八脉.破军  and  self.参战单位[目标].剑意<23  then
                          return false
                    elseif self.参战单位[编号].奇经八脉.润泽 and self.参战单位[目标].奇经八脉.破军  and  self.参战单位[目标].剑意<23 and self.参战单位[目标].法术状态.死亡召唤.回合<=3 then
                           return false
                    end
                elseif 名称=="由己渡人"  then
                      if not self.参战单位[目标].奇经八脉.破军 and (not self.参战单位[编号].奇经八脉.灵通 or self.参战单位[目标].法术状态.死亡召唤.回合<=3)  then
                           return false
                      elseif not self.参战单位[编号].奇经八脉.灵通 and self.参战单位[目标].奇经八脉.破军  and  self.参战单位[目标].剑意<23  then
                            return false
                      elseif self.参战单位[编号].奇经八脉.灵通 and self.参战单位[目标].奇经八脉.破军  and  self.参战单位[目标].剑意<23 and self.参战单位[目标].法术状态.死亡召唤.回合<=3 then
                               return false
                      end
                elseif 名称=="杨柳甘露" then
                       if  not self.参战单位[目标].奇经八脉.破军 and  self.参战单位[目标].法术状态.死亡召唤.回合<=3 then
                           return false
                       elseif self.参战单位[目标].奇经八脉.破军 and self.参战单位[目标].剑意<23 and self.参战单位[目标].法术状态.死亡召唤.回合<=3  then
                              return false
                       end
               else
                   if not self.参战单位[目标].奇经八脉.破军 or (self.参战单位[目标].奇经八脉.破军 and self.参战单位[目标].剑意<23) then
                      return false
                   end
               end
        end
        if  self.参战单位[目标].法术状态.锢魂术 then
                if 名称=="百草复苏" or 名称 == "百草神木复苏" then
                    if not self.参战单位[目标].奇经八脉.破军 and (not self.参战单位[编号].奇经八脉.润泽 or self.参战单位[目标].法术状态.锢魂术.回合<=4)  then
                         return false
                    elseif not self.参战单位[编号].奇经八脉.润泽 and self.参战单位[目标].奇经八脉.破军  and  self.参战单位[目标].剑意<23  then
                          return false
                    elseif self.参战单位[编号].奇经八脉.润泽 and self.参战单位[目标].奇经八脉.破军  and  self.参战单位[目标].剑意<23 and self.参战单位[目标].法术状态.锢魂术.回合<=4 then
                             return false
                    end
               elseif 名称=="由己渡人"  then
                      if not self.参战单位[目标].奇经八脉.破军 and (not self.参战单位[编号].奇经八脉.灵通 or self.参战单位[目标].法术状态.锢魂术.回合<=4)  then
                           return false
                      elseif not self.参战单位[编号].奇经八脉.灵通 and self.参战单位[目标].奇经八脉.破军 and  self.参战单位[目标].剑意<23  then
                            return false
                      elseif self.参战单位[编号].奇经八脉.灵通 and self.参战单位[目标].奇经八脉.破军  and  self.参战单位[目标].剑意<23 and self.参战单位[目标].法术状态.锢魂术.回合<=4 then
                               return false
                      end
                elseif 名称=="杨柳甘露" then
                       if  not self.参战单位[目标].奇经八脉.破军 and self.参战单位[目标].法术状态.死亡召唤.回合<=4 then
                           return false
                       elseif self.参战单位[目标].奇经八脉.破军 and self.参战单位[目标].剑意<23 and self.参战单位[目标].法术状态.死亡召唤.回合<=4  then
                              return false
                       end
               else
                   if not self.参战单位[目标].奇经八脉.破军 or (self.参战单位[目标].奇经八脉.破军 and self.参战单位[目标].剑意<23) then
                      return false
                   end
               end
        end
        return true
end











