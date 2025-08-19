

function 战斗处理类:法术攻击处理(编号,额外命令)
        local 名称=self.参战单位[编号].指令.参数
        local 目标=self.参战单位[编号].指令.目标
        if 额外命令~=nil then
            名称 = 额外命令.名称
            目标 = 额外命令.目标
        end

        if not 战斗技能[名称] then return end

        local 等级=self:取技能等级(编号,名称)
        if (战斗技能[名称].类型 == "物伤" or 战斗技能[名称].类型 == "群体物伤" or 战斗技能[名称].类型 == "法伤") and self.参战单位[编号].出其不意 then
             if self.参战单位[编号].出其首次==nil then
                self.参战单位[编号].出其首次 ={}
              end
              local 找到技能=true
              for i=1,#self.参战单位[编号].出其首次 do
                if 名称==self.参战单位[编号].出其首次[i] then
                   找到技能 =false
                end
              end
              if 找到技能 then
                  self.参战单位[编号].出其首次[#self.参战单位[编号].出其首次+1] = 名称
                  self.参战单位[编号].出其不意加成 = 1
              else
                   self.参战单位[编号].出其不意加成 = nil
              end
        end

        self:技能使用处理(编号,名称,等级,额外命令)
        if 战斗技能[名称].连击处理 then
            local 返回 = {次数=0,比列=1}
            战斗技能[名称].连击处理(self,编号,等级,返回)
            if 返回.次数 and 返回.次数>0 then
                for i=1,返回.次数 do
                    self:技能使用处理(编号,名称,等级,额外命令,返回.比例)
                end
            end
        end
        if self.参战单位[编号].奇经八脉倾情 and 取随机数()<=50 then
            self:技能使用处理(编号,"含情脉脉",等级,额外命令)
            self.参战单位[编号].奇经八脉倾情 = nil
        end
        if self.参战单位[编号].奇经八脉补血前置 then
            self.参战单位[编号].奇经八脉补血 = 1
            self.参战单位[编号].奇经八脉补血前置 = nil
            if not 额外命令 then 额外命令 ={} end
            额外命令.目标 = self.参战单位[编号].奇经八脉补血前置
            self:技能使用处理(编号,"滋养",等级,额外命令)
        end
        if self.参战单位[编号].奇经八脉连营 then
            for i=1,self.参战单位[编号].奇经八脉连营 do
                self:技能使用处理(编号,"摇头摆尾",self.参战单位[编号].等级,额外命令,0.4)
            end
        end
        if 战斗技能[名称].类型 == "法伤" and self.参战单位[编号].法连 and self.参战单位[编号].法连>=取随机数() then
              local  临时降低= 0.5
              if self.参战单位[编号].超级法连 then
                      临时降低= 0.8
              end
              if self.参战单位[编号].双星暴 then
                      临时降低 = 临时降低+self.参战单位[编号].双星暴
              end
              self:技能使用处理(编号,名称,等级,额外命令,临时降低)
        end
        if self.参战单位[编号].神话词条 and  self.参战单位[编号].神话词条.道法自然 and 取随机数()<=self.参战单位[编号].神话词条.道法自然*4 then
            self:技能使用处理(编号,名称,等级,额外命令)
        end
        if self.参战单位[编号].战斗赐福 and self.参战单位[编号].战斗赐福.技能连击>0 and 取随机数()<=self.参战单位[编号].战斗赐福.技能连击 then
            self:技能使用处理(编号,名称,等级,额外命令)
        elseif self.参战单位[编号].超级敏捷 and self:取行动状态(编号) and 取随机数()<=5 then
            self:技能使用处理(编号,名称,等级,额外命令)
        end
        if self.参战单位[编号].神器技能玉魄 and self.参战单位[编号].神器技能玉魄回合 and self.参战单位[编号].神器技能玉魄回合~=self.回合数 then
           self.参战单位[编号].神器技能玉魄 =nil
           self.参战单位[编号].神器技能玉魄回合 = nil
        end
end

function 战斗处理类:技能使用处理(编号,名称,等级,额外命令,伤害比)

      if 战斗技能[名称].类型 == "普攻" then
              self:普通攻击计算(编号,名称,nil,等级,nil,额外命令)
      elseif 战斗技能[名称].类型 == "物伤" then
              self:物攻技能计算(编号,名称,等级,额外命令)
      elseif 战斗技能[名称].类型 == "群体物伤" then
              self:物理同时多个攻击(编号,名称,等级,额外命令)
      elseif 战斗技能[名称].类型 == "法伤" then
              self:法攻技能计算(编号,名称,等级,额外命令,伤害比)
      elseif 战斗技能[名称].类型 == "固伤" then
              self:固伤技能计算(编号,名称,等级,额外命令,伤害比)
      elseif 战斗技能[名称].类型 == "减益" then
              self:减益技能计算(编号,名称,等级,额外命令)
      elseif 战斗技能[名称].类型 == "封印" then
              self:封印技能计算(编号,名称,等级,额外命令)
      elseif 战斗技能[名称].类型 == "增益" then
              self:增益技能计算(编号,名称,等级,额外命令)
      elseif 战斗技能[名称].类型 == "恢复" or  战斗技能[名称].类型 == "复活" then
              self:治疗技能计算(编号,名称,等级,额外命令)
      end

end

function 战斗处理类:九黎连击(单位)
      if 单位.门派=="九黎城" then
          单位.九黎连击 = 单位.九黎连击+1
          if 单位.神话词条 and 单位.神话词条.五马分尸 and 取随机数()<=单位.神话词条.五马分尸*8 then
                单位.九黎连击 = 单位.九黎连击 + 单位.神话词条.五马分尸
          end
          if 单位.奇经八脉飞扬 and 单位.取消浮空 and #单位.取消浮空>=5 then
              单位.奇经八脉飞扬=单位.奇经八脉飞扬+1
              if 单位.奇经八脉飞扬>=4 then
                    单位.奇经八脉飞扬=4
              end
          end
           if not 单位.九黎连击数 then  单位.九黎连击数=0 end
          单位.九黎连击数= 单位.九黎连击数 + 1
          return 单位.九黎连击数
      end
end


function 战斗处理类:神木消耗风灵(单位,数量)
      if not 数量 then 数量 = 1 end
      if 单位.风灵 and 单位.风灵 >数量 then
          单位.风灵 = 单位.风灵 - 数量
          self:添加提示(单位.玩家id,单位.编号,"#Y/你当前可使用的风灵为#R/"..单位.风灵.."#Y/点")
          if 单位.奇经八脉.星光  then
              self:增加愤怒(单位.编号,10)
          end
          if 单位.神器技能 and 单位.神器技能.名称=="凭虚御风" then
            local 数额 = 单位.神器技能.等级*40
            if 单位.神器技能凭虚御风 ==nil then
                单位.神器技能凭虚御风 ={数额=数额,层数=1}
            else
                单位.神器技能凭虚御风.层数=单位.神器技能凭虚御风.层数+1
                if 单位.神器技能凭虚御风.层数>=3 then
                    单位.神器技能凭虚御风.层数 = 3
                end
            end
          end
      end
end


function 战斗处理类:神木消耗灵药(单位,扣除)
          if not 扣除 then 扣除 = {红=1,蓝=1,蓝=1} end
          for k,v in pairs(扣除) do
              local 数额 = v
              if 单位.奇经八脉.残余 and 单位.灵药[k]<=2 then
                  数额 = 0
              end
              if 单位.奇经八脉.灵精 and 取随机数()<=30 then
                  数额 = 数额 - 1
                  if 数额<=0 then 数额=0 end
              end
              if 数额>0 and 单位.灵药[k]>= v then
                  单位.灵药[k] = 单位.灵药[k] - v
              end
          end
end

function 战斗处理类:神木灵药判断(单位,扣除)
          if not 扣除 then 扣除 = {红=1,蓝=1,蓝=1} end
          for k,v in pairs(扣除) do
              local 数额 = v
              if 单位.奇经八脉.残余 and 单位.灵药[k]<=2 then
                  数额 = 0
              end
              if 单位.灵药[k]< 数额 then
                  return true
              end
          end
          return false
end

function 战斗处理类:凌波消耗战意(单位,数量)
          if not 数量 then 数量 = 1 end
          if 单位.战意 + 单位.超级战意 >= 数量 then
              if 单位.超级战意 >= 数量 then
                  单位.超级战意 = 单位.超级战意 - 数量
                   单位.超级战意消耗 = 数量
              else
                  if 单位.超级战意 > 0 then
                      数量 = 数量 - 单位.超级战意
                      单位.超级战意消耗 = 单位.超级战意
                      单位.超级战意 = 0
                  end
                  if 单位.战意>=数量 then
                      单位.战意=单位.战意-数量
                      if 单位.神器技能 and 单位.神器技能.名称=="酣战" then
                          local 数额 =单位.神器技能.等级*30
                          if 单位.神器技能酣战==nil then
                              单位.神器技能酣战 = {数额=数额,层数=1}
                          else
                              单位.神器技能酣战.层数 = 单位.神器技能酣战.层数+1
                              if 单位.神器技能酣战.层数>=6 then
                                单位.神器技能酣战.层数=6
                              end
                          end
                      end
                  end
              end
              if 单位.超级战意消耗 and 单位.超级战意消耗>0 then
                 self:添加提示(单位.玩家id,单位.编号,"#Y/你当前可使用的超级战意为#R/"..单位.超级战意.."#Y/点,战意为#R/"..单位.战意.."#Y/点")
              else
                  self:添加提示(单位.玩家id,单位.编号,"#Y/你当前可使用的战意为#R/"..单位.战意.."#Y/点")
              end
        end
end

function 战斗处理类:凌波添加战意(单位,数量)
          if 单位.战意 and 单位.战意<6 then
            单位.战意 = 单位.战意 + 数量
            if 单位.奇经特效.超级战意 and 取随机数()<=20 then
                单位.超级战意 = math.min((单位.超级战意 or 0) + 1, 3)
                self:添加提示(单位.玩家id,单位.编号,"#Y/你当前可使用的超级战意为#R/"..单位.超级战意.."#Y/点,战意为#R/"..单位.战意.."#Y/点")
            else
               self:添加提示(单位.玩家id,单位.编号,"#Y/你当前可使用的战意为#R/"..单位.战意.."#Y/点")
            end
          end
end








function 战斗处理类:取敌方目标组(编号,目标,数量,名称)

        local 目标组={目标}
        if not 目标 or 目标==0 or not self:取目标状态(编号,目标,1) then
          目标组={}
        elseif self.参战单位[目标].队伍==self.参战单位[编号].队伍 then
          目标组={}
        end

        if #目标组>=数量 then
          return 目标组
        end

        local 临时组 = {}
        local 剩余组 = {}
        for k,v in pairs(self.参战单位) do
            if v.队伍 ~= self.参战单位[编号].队伍 and self:取目标状态(编号,k,1) and k~=目标 then
                local 临时速度 = v.速度
                if v.奇经八脉.夜行 and 昼夜参数==1 then
                    临时速度=临时速度+40
                end
                if 名称=="三荒尽灭" or 名称=="铁火双扬" then
                    if not v.法术状态 or not v.法术状态.浮空 then
                         table.insert(临时组,{编号=k,速度=临时速度})
                    else
                        table.insert(剩余组,{编号=k,速度=临时速度})
                    end
                else
                    table.insert(临时组,{编号=k,速度=临时速度})
                end

            end
        end

        table.sort(临时组,function(a,b) return a.速度 > b.速度 end)
        table.sort(剩余组,function(a,b) return a.速度 > b.速度 end)
        if #目标组 < 数量 then
            for i,v in ipairs(临时组) do
                if #目标组 < 数量 then
                     table.insert(目标组,v.编号)
                end
            end
            if #目标组 < 数量 and #剩余组>0 then
                 for i,v in ipairs(剩余组) do
                    if #目标组 < 数量 then
                         table.insert(目标组,v.编号)
                    end
                end
            end

        end
        return 目标组
end


function 战斗处理类:取友方目标组(编号,目标,数量,名称)-------只有增益治疗
          local 目标组={目标}
          if not 目标 or 目标==0 or not self:取目标状态(编号,目标,2) then
             目标组={}
          elseif self.参战单位[目标].队伍~=self.参战单位[编号].队伍 then
              目标组={}
          end
          if #目标组>=数量 then
             return 目标组
          end
          local 临时组={}
          for k,v in pairs(self.参战单位) do
              if v.队伍 == self.参战单位[编号].队伍 and self:取目标状态(编号,k,2) and not v.法术状态[名称] and k~=目标 then
                   if 名称 == "北冥之渊" then
                      if v.类型~="角色" then
                          table.insert(临时组,{id=k,气血=v.气血/v.最大气血*100,伤害=v.伤害,防御=v.防御,法伤=v.法伤,法防=v.法防,速度=v.速度})
                      end
                   else
                        table.insert(临时组,{id=k,气血=v.气血/v.最大气血*100,伤害=v.伤害,防御=v.防御,法伤=v.法伤,法防=v.法防,速度=v.速度})
                   end
              end
          end
          if 名称=="逆鳞" or 名称=="碎星诀" or 名称=="镇魂诀" or 名称=="杀气诀" or 名称=="金刚护法"  then
                table.sort(临时组,function(a,b) return a.伤害>b.伤害 end )
          elseif 名称=="安神诀" or 名称=="韦陀护法" or 名称=="定心术"  then
                  table.sort(临时组,function(a,b) return a.法伤>b.法伤 end )
          elseif 名称=="修罗咒" or 名称=="明光宝烛" or 名称=="金刚护体" or 名称=="天神护法" or 名称=="盘丝阵"  then
                  table.sort(临时组,function(a,b) return a.防御<b.防御 end )
          elseif 名称=="天衣无缝" then
                  table.sort(临时组,function(a,b) return a.法防<b.法防 end )
          elseif 名称=="红袖添香"  or 名称=="流云诀" or 名称=="一苇渡江" or 名称=="乘风破浪" or 名称=="乾坤妙法" or 名称=="幽冥鬼眼"  then
                  table.sort(临时组,function(a,b) return a.速度>b.速度 end )
          else
              table.sort(临时组,function(a,b) return a.气血<b.气血 end )
          end
          if #目标组 < 数量 then
              for i,v in ipairs(临时组) do
                  if #目标组 < 数量 then
                       table.insert(目标组,v.id)
                  end
              end
          end
          return 目标组
end



function 战斗处理类:取单个敌方目标(编号)
      local 目标组={}
      for n=1,#self.参战单位 do
         if  self.参战单位[n].队伍~=self.参战单位[编号].队伍 and self:取目标状态(编号,n,1) then
             目标组[#目标组+1]=n
         end
      end
      if #目标组==0 then
          return 0
      else
          return 目标组[取随机数(1,#目标组)]
      end
end



function 战斗处理类:取单个友方目标(编号,类型,自己)
        if 类型==nil then 类型 = 2 end
        local 目标组={}
        for n=1,#self.参战单位 do
            if n~=编号 and self.参战单位[n].队伍==self.参战单位[编号].队伍 and self:取目标状态(编号,n,类型) then
                 目标组[#目标组+1]=n
            end
        end
        if 自己 then
            目标组[#目标组+1]=编号
        end
        if #目标组==0 then
           return 0
        else
           return 目标组[取随机数(1,#目标组)]
        end
end



function 战斗处理类:取封印目标组(编号,目标,数量,名称,法宝)
        local 目标组={目标}
        if not 目标 or 目标==0 or not self:取目标状态(编号,目标,1) then
          目标组={}
        elseif self:取封印状态(目标) then
          目标组={}
        elseif 法宝 and self:取法宝封印状态(目标) then
          目标组={}
        elseif self.参战单位[目标].队伍==self.参战单位[编号].队伍 then
          目标组={}
        end
        if #目标组>=数量 then
          return 目标组
        end
        --获取敌人目标
        local 临时组 = {}
        for k,v in pairs(self.参战单位) do
            if v.队伍~=self.参战单位[编号].队伍 and self:取目标状态(编号,k,1) and not self:取封印状态(k)
               and k ~= 目标 and (not 法宝 or not self:取法宝封印状态(k)) then
                table.insert(临时组, k)
            end
        end
        if #目标组 < 数量 then
            for i,v in ipairs(临时组) do
                if #目标组 < 数量 then
                     table.insert(目标组,v)
                end
            end
        end
        return 目标组
end


function 战斗处理类:取复活目标组(编号,目标,名称,数量)
          local 目标组={目标}
          if not 目标 or 目标==0 or not self:取是否复活(编号,目标,名称) then
              目标组={}
          elseif self.参战单位[目标].气血>0 then
                目标组={}
          elseif self.参战单位[目标].队伍~=self.参战单位[编号].队伍 then
                目标组={}
          end
          if #目标组>=数量 then
             return 目标组
          end
          local 临时组 = {}
         for k,v in pairs(self.参战单位) do
             if self:取是否复活(编号,k,名称) then
                table.insert(临时组,k)
             end
         end
         if #目标组 < 数量 then
            for i,v in ipairs(临时组) do
                if #目标组 < 数量 then
                     table.insert(目标组,v)
                end
            end
        end
         return 目标组
end

function 战斗处理类:处理流程状态(流程,状态,添加)
          if not 流程 or not 状态 then return end
          local 类型= ""
          if 添加 then
              类型="添加状态"
          else
              类型="取消状态"
          end
          if 类型~="" then
              if not 流程[类型] then
                  流程[类型] = {}
              end
              local 法术状态 = {}
              if 类型 == "添加状态" then
                  法术状态 = DeepCopy(self.参战单位[添加].法术状态)
              end
              if type(状态)=="string" then
                  if type(流程[类型])=="string" then
                      local 本次状态 = 流程[类型]
                      流程[类型] ={}
                      if 类型 == "取消状态" then
                          table.insert(流程[类型], 本次状态)
                          table.insert(流程[类型], 状态)
                      else
                          if 法术状态[本次状态] then
                              流程[类型][本次状态]={}
                              流程[类型][本次状态].回合 = 法术状态[本次状态].回合
                              流程[类型][本次状态].护盾值 = 法术状态[本次状态].护盾值
                          end
                          if 法术状态[状态] then
                              流程[类型][状态]={}
                              流程[类型][状态].回合 = 法术状态[状态].回合
                              流程[类型][状态].护盾值 = 法术状态[状态].护盾值
                          end
                      end
                  elseif type(流程[类型])=="table" then
                        if 类型 == "取消状态" then
                            table.insert(流程[类型], 状态)
                        else
                            if 法术状态[状态] then
                                流程[类型][状态]={}
                                流程[类型][状态].回合 = 法术状态[状态].回合
                                流程[类型][状态].护盾值 = 法术状态[状态].护盾值
                            end
                        end
                  end
              elseif type(状态)=="table" then
                      if type(流程[类型])=="string" then
                          local 本次状态 = 流程[类型]
                          流程[类型] ={}
                          if 类型 == "取消状态" then
                              table.insert(流程[类型], 本次状态)
                              for i,v in pairs(状态) do
                                  table.insert(流程[类型], v)
                              end
                          else
                              if 法术状态[本次状态] then
                                  流程[类型][本次状态]={}
                                  流程[类型][本次状态].回合 = 法术状态[本次状态].回合
                                  流程[类型][本次状态].护盾值 = 法术状态[本次状态].护盾值
                              end
                              for i,v in pairs(状态) do
                                  if 法术状态[v] then
                                      流程[类型][v]={}
                                      流程[类型][v].回合 = 法术状态[v].回合
                                      流程[类型][v].护盾值 = 法术状态[v].护盾值
                                  end
                              end
                          end
                      elseif type(流程[类型])=="table" then
                             if 类型 == "取消状态" then
                                  for i,v in pairs(状态) do
                                      table.insert(流程[类型], v)
                                  end
                              else
                                  for i,v in pairs(状态) do
                                      if 法术状态[v] then
                                          流程[类型][v]={}
                                          流程[类型][v].回合 = 法术状态[v].回合
                                          流程[类型][v].护盾值 = 法术状态[v].护盾值
                                      end
                                  end
                              end
                      end
              end
          end
end

function 战斗处理类:解除状态组(编号,目标,状态组,名称,流程,挨打)
        if not 状态组 or #状态组==0 then return {} end
        local 解除={}
        for k,v in pairs(状态组) do
            if self.参战单位[目标].法术状态[v] then
                local 取编号 =  self.参战单位[目标].法术状态[v].编号
                local 数据 = {流程=流程,挨打=挨打,编号=取编号}
                if 战斗技能[v] and 战斗技能[v].解除生效 then
                      战斗技能[v].解除状态(self,编号,目标,名称,数据)
                end
                if self.参战单位[取编号].奇经八脉.情劫 then
                     self.参战单位[目标].奇经八脉情劫 = 1
                end
                if not 数据.不可解除 then
                    self:取消状态(v,目标)
                    table.insert(解除,v)
                end
            end
        end
        return 解除
end


function 战斗处理类:解除状态组处理(编号,目标,状态组,名称,流程,挨打)--目标==编号给自己加
                    if type(状态组)=="string" then
                        local 解除 = self:解除状态组(编号,目标,{状态组},名称,流程,挨打)
                        if 目标==编号 then
                           self:处理流程状态(self.战斗流程[流程],解除)
                        else
                            self:处理流程状态(self.战斗流程[流程].挨打方[挨打],解除)
                        end
                    elseif type(状态组)=="table" then
                            local 临时解除 ={}
                            for k,v in pairs(状态组) do
                                if type(v)=="string" and k~="目标" then
                                    table.insert(临时解除,v)
                                end
                            end
                            local 解除 = self:解除状态组(编号,目标,临时解除,名称,流程,挨打)
                            if 状态组.目标==编号 then
                                  self:处理流程状态(self.战斗流程[流程],解除)
                            else
                                  self:处理流程状态(self.战斗流程[流程].挨打方[挨打],解除)
                            end
                    end
end

function 战斗处理类:添加状态组处理(编号,目标,状态组,名称,等级,流程,挨打)

          if not 状态组 then return end
          if 状态组.名称 or 状态组.等级 or 状态组.目标 or 状态组.编号 then
              local 添加目标 = 状态组.目标 or 目标
              local 添加名称 = 状态组.名称 or 名称
              self:添加状态(添加名称,添加目标,状态组.编号 or 编号,状态组.等级 or 等级,状态组.境界)
              if 状态组.回合 and 添加目标 and 添加名称 then
                  self.参战单位[添加目标].法术状态[添加名称].回合 = 状态组.回合
              end
              if 添加目标 == 编号 then
                   self:处理流程状态(self.战斗流程[流程],添加名称,添加目标)
              else
                   self:处理流程状态(self.战斗流程[流程].挨打方[挨打],添加名称,添加目标)
              end
          end
          for k,v in pairs(状态组) do
              if type(v)=="table" and (v.名称 or v.等级 or v.目标 or v.编号) then
                  local 子目标 = v.目标 or 目标
                  local 子名称 = v.名称 or 名称
                  self:添加状态(子名称,子目标,v.编号 or 编号,v.等级 or 等级,v.境界)
                  if v.回合 and 子目标 and 子名称 then
                      self.参战单位[子目标].法术状态[子名称].回合 = 状态组.回合
                  end
                  if 子目标 == 编号 then
                      self:处理流程状态(self.战斗流程[流程],子名称,子目标)
                  else
                      self:处理流程状态(self.战斗流程[流程].挨打方[挨打],子名称,子目标)
                  end
              end
          end
end


function 战斗处理类:取技能等级(编号,名称)
       for i,v in ipairs(self.参战单位[编号].主动技能) do
            if v.名称 == 名称 then
                return v.等级
            end
       end
       for i,v in ipairs(self.参战单位[编号].附加状态) do
            if v.名称 == 名称 then
                return v.等级
            end
       end
       for i,v in ipairs(self.参战单位[编号].追加法术) do
            if v.名称 == 名称 then
                return v.等级
            end
       end
       return self.参战单位[编号].等级
end


function 战斗处理类:智能施法(战斗类型, 编号, 怪物技能)
    local 返回数据 = {类型="", 目标=0, 参数="", 下达=false}
    local 临时技能 = {}

    for _, 技能 in ipairs(怪物技能) do
        if 战斗技能[技能.名称]  then
            if 战斗技能[技能.名称].特技 and self:取特技状态(编号) then
                table.insert(临时技能, 技能.名称)
            else
                if self:取法术状态(编号) then
                     table.insert(临时技能, 技能.名称)
                end
            end
        end
    end
    local 是晶清 = false
    local 是观照 = false
    local 是四海 = false
    local 是恢复 = false
    for i=#临时技能,1,-1 do
        local 技能类型 = 取法术技能(临时技能[i])
        local 目标类型 = (技能类型[3] == 4) and "敌方" or "友方"
        if 战斗技能[临时技能[i]].类型 == "封印" and self:智能取可封印单位(编号)==0 then
              table.remove(临时技能,i)
        elseif 战斗技能[临时技能[i]].类型 == "复活" and self:智能取可复活(编号, 临时技能[i])==0 then
              table.remove(临时技能,i)
        elseif 战斗技能[临时技能[i]].类型 == "恢复" and self:智能取可恢复(编号)==0 then
                table.remove(临时技能,i)
        elseif 战斗技能[临时技能[i]].类型 == "增益" then
                local 目标 =self:智能取增益状态(编号, 临时技能[i], 目标类型)
                if 战斗技能[临时技能[i]].目标 then
                    目标 = 战斗技能[临时技能[i]].目标(self,编号,目标)
                end
                if 目标==0 or 取随机数()<=50 or (目标==编号 and self.参战单位[编号].法术状态[临时技能[i]]) then
                  table.remove(临时技能,i)
                end
        else
            if 临时技能[i]=="晶清诀" then
                  是晶清 = true
            elseif 临时技能[i]=="观照万象" then
                    是观照 = true
            elseif 临时技能[i]=="四海升平" then
                    是四海 = true
            elseif 战斗技能[临时技能[i]].类型 == "恢复" and not 战斗技能[临时技能[i]].特技 then
                    是恢复 = true
            end
        end
    end
    local 使用技能 = ""
    if 是晶清 and 取随机数()<=40 and self:取特技状态(编号) and not self.参战单位[编号].智能特技
       and (self:取封印状态(编号) or self:取友封印数量(编号)>=服务端参数.自动晶清) then
          使用技能 = "晶清诀"
          self.参战单位[编号].智能特技 = 取随机数(1,3)
    elseif 是四海 and self:取特技状态(编号) and self:智能取使用恢复(编号,1)
      and 取随机数()<=40 and not self.参战单位[编号].智能特技 then
            使用技能 = "四海升平"
            self.参战单位[编号].智能特技 = 取随机数(1,3)
    elseif 是观照 and not self.参战单位[编号].观照万象 and 取随机数()<=50 then
              使用技能 = "观照万象"
    elseif 是恢复 and self:智能取使用恢复(编号) then
            for i=#临时技能,1,-1 do
                if 战斗技能[临时技能[i]].类型 ~= "恢复" or 战斗技能[临时技能[i]].特技 then
                    table.remove(临时技能,i)
                end
            end
    end
    if not 使用技能 or 使用技能 == "" then
        使用技能 = 临时技能[取随机数(1, #临时技能)]
    end
    if 使用技能 and 使用技能 ~= "" then
        local 目标 = 0
        local 技能类型 = 取法术技能(使用技能)
        local 目标类型 = (技能类型[3] == 4) and "敌方" or "友方"
        if 战斗技能[使用技能].类型 == "封印" then
                目标 = self:智能取可封印单位(编号)
        elseif 战斗技能[使用技能].类型 == "复活"then
                  目标 = self:智能取可复活(编号,使用技能)
        elseif 战斗技能[使用技能].类型 == "恢复" then
                目标 = self:智能取可恢复(编号)
        elseif 战斗技能[使用技能].类型 == "增益" then
                目标 =self:智能取增益状态(编号,使用技能, 目标类型)
        else
              目标 = (技能类型[3] == 4) and self:取单个敌方目标(编号) or self:取单个友方目标(编号)
        end
        if 目标 ~= 0 then
            返回数据 = {
                  类型 = ( 战斗技能[使用技能].类型 == "特技") and "特技" or "法术",
                  参数 = 使用技能,
                  目标 = 目标,
                  下达 = true
            }
        end
    end
    -- 默认行为
    if not 返回数据.下达 then
        if self:取攻击状态(编号) or self:取休息状态(编号) then
            返回数据 = {类型="攻击", 目标=self:取单个敌方目标(编号), 参数="", 下达=true}
        else
            返回数据 = {类型="防御", 目标=0, 参数="", 下达=true}
        end
    end
    -- 特殊战斗逻辑
    local 战斗处理 = {
        [100004] = function() -- 封妖活动
            if self.参战单位[编号].变异 and self.回合数 >= 3 then
                return {类型="逃跑", 目标=0, 参数="", 下达=true}
            end
        end,
        -- [110002] = function() -- 蚩尤战斗
        --     if self.参战单位[编号].名称 == "蚩尤" and self.回合数 == 1 then
        --         self:添加发言(编号, "不要做无畏挣扎\n赶紧#R/受死吧!")
        --     end
        -- end,
        [110005] = function() -- 妖风战斗
            if self.参战单位[编号].名称 == "妖风" and self.回合数 == 1 then
                self:添加发言(编号, "不不不\n这#R/不可能!")
            end
        end,
        [100225] = function() -- 神兽战斗
            if self.参战单位[编号].门派 == "神兽" then
                if self.回合数 == 1 then
                    self:添加发言(编号, "小东西\n想抓我?#3")
                elseif self.回合数 == 3 then
                    self:添加发言(编号, "拜拜了\n看我逃跑#4")
                elseif self.回合数 >= 4 then
                    return {类型="逃跑", 目标=0, 参数="", 下达=true}
                end
            end
        end,
        [100017] = function() -- 门派救援
            local 同门编号 = 0
            for i, 单位 in ipairs(self.参战单位) do
                if 单位.同门单位 then
                    同门编号 = i
                    单位.指令.类型 = ""
                    break
                end
            end
            if 同门编号 == 0 then
                同门编号 = self:取单个敌方目标(编号)
            end
            return {类型="同门飞镖", 目标=同门编号, 下达=true}
        end
    }

    if 战斗处理[战斗类型] then
        local 特殊行为 = 战斗处理[战斗类型]()
        if 特殊行为 then
            返回数据 = 特殊行为
        end
    end

    -- 通用特殊行为
    if self.参战单位[编号].捉鬼变异 and self.回合数 >= 2 then
        返回数据 = {类型="逃跑", 目标=0, 参数="", 下达=true}
    elseif self.参战单位[编号].精灵 and self.回合数 == 2 then
        返回数据 = {类型="法术", 目标=self:取单个敌方目标(编号), 参数="自爆", 下达=true}
    elseif self.战斗类型 == 110000 and self.参战单位[编号].名称 == "谛听" and self.回合数 == 1 then
        返回数据 = {类型="法术", 目标=self:取单个敌方目标(编号), 参数="观照万象", 下达=true}
    end
    return 返回数据
end

function 战斗处理类:智能取可封印单位(编号)
    local 目标组 = {}
    for n, 单位 in ipairs(self.参战单位) do
        if 单位.队伍 ~= self.参战单位[编号].队伍
           and self:取目标状态(编号, n, 1)
           and not 单位.不可封印
           and not 单位.鬼魂
           and not 单位.精神
           and not 单位.信仰
           and not self:取封印状态(n) then
            table.insert(目标组, n)
        end
    end
    if not 目标组[1] then
        return 0
    end
    return 目标组[取随机数(1, #目标组)]
end


function 战斗处理类:智能取增益状态(编号, 状态名称, 类型)
    local 目标组 = {}
    for n, 单位 in ipairs(self.参战单位) do
        local 符合条件 = false
        if 类型 == "友方" then
            符合条件 = 单位.队伍 == self.参战单位[编号].队伍
                     and self:取目标状态(编号, n, 1)
                     and not 单位.法术状态[状态名称]
        else
            符合条件 = 单位.队伍 ~= self.参战单位[编号].队伍
                     and self:取目标状态(编号, n, 1)
                     and not 单位.法术状态[状态名称]
        end

        if 符合条件 then
            table.insert(目标组, n)
        end
    end
    if not 目标组[1] then
        return 0
    end
    return 目标组[取随机数(1, #目标组)]
end




function 战斗处理类:智能取可复活(编号, 名称)
            local 目标组 = {}
            for n, 单位 in ipairs(self.参战单位) do
                if self:取是否复活(编号,n,名称) then
                    table.insert(目标组, n)
                end
            end
            if not 目标组[1] then
                return 0
            end
            return 目标组[取随机数(1, #目标组)]
end

function 战斗处理类:智能取可恢复(编号)
            local 目标组 = {}
            for n, 单位 in ipairs(self.参战单位) do
                if 单位.队伍 == self.参战单位[编号].队伍
                  and self:取目标状态(编号,n,2)
                  and 单位.气血< 单位.最大气血 then
                    table.insert(目标组, n)
                end
            end
            if not 目标组[1] then
                return 0
            end
            return 目标组[取随机数(1, #目标组)]
end

function 战斗处理类:智能取使用恢复(编号,四海)
            local 数量 = 0
            local 人数 = 0
            for n, 单位 in ipairs(self.参战单位) do
                if 单位.队伍 == self.参战单位[编号].队伍 and self:取目标状态(编号,n,2) then
                    人数 = 人数 + 1
                    if 四海 and 单位.气血<=math.ceil(单位.最大气血*0.5) then
                        数量 = 数量 + 1
                    elseif 单位.气血<=math.ceil(单位.最大气血*0.7) then
                            数量 = 数量 + 1
                    end
                end
            end
            if 数量 >= math.floor(人数/2) then
                return true
            else
                return false
            end
end




