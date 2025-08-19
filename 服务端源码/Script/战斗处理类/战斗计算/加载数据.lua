
function 战斗处理类:加载初始属性(编号,属性组)
                  for k,v in pairs(self.基础加载) do
                      if not self.参战单位[编号][k] then
                          if 属性组[k] then
                              self.参战单位[编号][k] = 属性组[k]
                          else
                              self.参战单位[编号][k] = v
                          end
                      end
                  end
                  for i,v in ipairs(self.基础属性) do
                      if not self.参战单位[编号][v] then
                          if 属性组[v] then
                              self.参战单位[编号][v] = 属性组[v]
                          else
                              self.参战单位[编号][v] = self.参战单位[编号].等级
                          end
                      end
                  end
                  if self:取玩家战斗() then
                      self.参战单位[编号].观照万象=5
                  end
                  self.参战单位[编号].愤怒 = self.参战单位[编号].愤怒 or 属性组.愤怒 or 0
                  if self.参战单位[编号].愤怒>150 and (self.参战单位[编号].类型=="角色" or self.参战单位[编号].主人) then
                      self.参战单位[编号].愤怒=150
                  end
                  self.参战单位[编号].命中 = self.参战单位[编号].命中 or 属性组.伤害
                  self.参战单位[编号].气血上限 = self.参战单位[编号].气血上限 or 属性组.最大气血
                  self.参战单位[编号].躲闪 = self.参战单位[编号].躲闪 or 属性组.躲闪 or 属性组.躲避 or self.参战单位[编号].等级 * 4
                  for k,v in pairs(self.重置加载) do
                      if type(v)=="table" then
                          self.参战单位[编号][k] = DeepCopy(v)
                      else
                          self.参战单位[编号][k] = v
                      end
                  end
                  for i,v in ipairs(self.重置空表) do
                        self.参战单位[编号][v] = {}
                  end
                   for i,v in ipairs(self.加载需求) do
                       if not self.参战单位[编号][v] and 属性组[v] then
                              self.参战单位[编号][v] = 属性组[v]
                       end
                  end
                  for i,v in ipairs(self.判断空表) do
                      if not self.参战单位[编号][v] then
                          if 属性组[v] then
                              self.参战单位[编号][v] = 属性组[v]
                          else
                              self.参战单位[编号][v] = {}
                          end
                      end
                  end

                  for i,v in ipairs(self.修炼类型) do
                      if not self.参战单位[编号][v] then
                          if 属性组[v] then
                              self.参战单位[编号][v] = 属性组[v]
                          else
                              self.参战单位[编号][v] = 0
                          end
                      end
                  end
                  for i,v in ipairs(self.灵饰属性) do
                      if not self.参战单位[编号][v] then
                          if 属性组[v] then
                              self.参战单位[编号][v] = 属性组[v]
                          else
                              self.参战单位[编号][v] = 0
                          end
                      end
                  end
                  for i,v in ipairs(self.五维属性) do
                      if not self.参战单位[编号][v] then
                          if 属性组[v] then
                              self.参战单位[编号][v] = 属性组[v]
                          else
                              self.参战单位[编号][v] = 10 + self.参战单位[编号].等级 * 2
                          end
                      end
                  end
                  if self.参战单位[编号].类型=="系统角色" then
                      self.参战单位[编号].战意=999
                  end
                  if not self.参战单位[编号].自动指令  then
                        if 属性组.自动指令 then
                            self.参战单位[编号].自动指令 = DeepCopy(属性组.自动指令)
                        else
                            self.参战单位[编号].自动指令 = {下达=false,类型="攻击",目标=0,敌我=0,参数="",附加=""}
                        end
                  end
                  self.参战单位[编号].指令=DeepCopy(self.参战单位[编号].自动指令)
                  self.参战单位[编号].指令.下达=false
                  self.参战单位[编号].战斗赐福 = self.参战单位[编号].战斗赐福 or{伤害结果=0,法伤结果=0,物伤结果=0,固伤结果=0,治疗结果=0,伤害减免=0,物伤减免=0,法伤减免=0,固伤减免=0,技能连击=0}
end


function 战斗处理类:初始怪物属性(单位组)
      local 单位等级 = 单位组.等级
      if not 单位等级 and 单位组[1] then
          for _, v in pairs(单位组) do
              if type(v) == "table" and v.等级 then
                  单位等级 = v.等级
                  break
              end
          end
      end
      单位等级 = 单位等级 or 取随机数(10,155)
      单位组.等级 = nil
      if 单位组.名称组 and type(单位组.名称组)=="table" then
          for i,v in ipairs(单位组.名称组) do
              if not 单位组[i] then 单位组[i]={} end
              if not 单位组[i].名称 then
                  单位组[i].名称 = v
              end
              if not 单位组[i].模型 then
                  if 单位组.模型组 and type(单位组.模型组)=="table" and 单位组.模型组[i] then
                      单位组[i].模型 =  单位组.模型组[i]
                  else
                      local 模型=取随机怪(1,150)
                      单位组[i].模型 = 模型[2]
                  end
              end
              if not 单位组[i].等级 and 单位组.等级组 and type(单位组.等级组)=="table" and 单位组.等级组[i] then
                  单位组[i].等级 = 单位组.等级组[i]
              end
              if not 单位组[i].加载 and 单位组.加载组 and type(单位组.加载组)=="table" and 单位组.加载组[i] then
                  单位组[i].加载 = 单位组.加载组[i]
              end
              if not 单位组[i].变异 and 单位组.变异组 and type(单位组.变异组)=="table" and 单位组.变异组[i] then
                  单位组[i].变异 = true
              end
              if not 单位组[i].技能 and 单位组.技能组 and type(单位组.技能组)=="table" and 单位组.技能组[i]  and type(单位组.技能组[i])=="table" then
                  单位组[i].技能 = {}
                  for k,n in ipairs(单位组.技能组[i]) do
                      if type(n)=="string" then
                         table.insert(单位组[i].技能, n)
                      end
                  end
              end
              if not 单位组[i].主动技能 and 单位组.主动组 and type(单位组.主动组)=="table" and 单位组.主动组[i] and type(单位组.主动组[i])=="table" then
                  单位组[i].主动技能 = {}
                  for k,n in ipairs(单位组.主动组[i]) do
                      if type(n)=="string" then
                         table.insert(单位组[i].主动技能, n)
                      end
                  end
              end
          end
          单位组.名称组 = nil
          单位组.模型组 = nil
          单位组.等级组 = nil
          单位组.加载组 = nil
          单位组.技能组 = nil
          单位组.主动组 = nil
      end
      local 加载 ={气血=1,伤害=10,法伤=9,防御=5,法防=4.5,速度=3,修炼 = 0.5}
      if 单位组.难度 == "中级" then
            加载 ={气血=6,伤害=22,法伤=20,防御=7,法防=6.5,速度=5,修炼 = 1}
      elseif 单位组.难度 == "高级" then
              加载 ={气血=13,伤害=42,法伤=40,防御=12,法防=10,速度=10,修炼 = 1.2}
      elseif 单位组.难度 == "困难" then
              加载 ={气血=20,伤害=62,法伤=60,防御=17,法防=15,速度=15,修炼 = 1.4}
      elseif 单位组.难度 == "顶级" then
              加载 ={气血=27,伤害=82,法伤=80,防御=22,法防=20,速度=20,修炼 = 1.8}
      end
      单位组.难度 = nil
      if 单位组.系数 then
          for k,v in pairs(单位组.系数) do
              if 加载[k] then
                  加载[k] = v
              end
          end
      end
      单位组.系数 = nil
      if 加载.修炼 and 加载.修炼 * 10 > 12 and math.floor((单位等级)/10) > 10 then
          加载.修炼 = 加载.修炼 - 0.05 * (math.floor((单位等级)/10) - 10)
      end
      local 修炼等级 = math.floor(取人物修炼等级上限(单位等级) * 加载.修炼)
      修炼等级 = (修炼等级 < 2 or 单位组.不加修炼) and 2 or 修炼等级
      单位组.不加修炼 = nil
      local function 计算成长(基础值, 增幅率,阶段)
            return 基础值 * (1 + 增幅率) ^ 阶段
      end
      local function 处理怪物类型(v, 属性)
        local 类型处理 = {
            法术 = function()
                v.魔力 = v.魔力 or (20 + v.等级 * 6)
                v.气血 = v.气血 or math.floor(属性.气血 * 0.85)
                v.伤害 = v.伤害 or math.floor(属性.伤害 * 0.5)
                v.防御 = v.防御 or math.floor(属性.防御 * 0.5)
                v.攻击修炼 = v.攻击修炼 or math.floor(修炼等级 / 2)
                v.防御修炼 = v.防御修炼 or math.floor(修炼等级 / 2)
                if not v.技能 then
                    v.技能 = {"高级感知","高级魔之心","高级法术连击","高级法术暴击","高级法术波动"}
                    if 取随机数()<=15 then
                        table.insert(v.技能,"高级神佑复生")
                    end
                    if 取随机数()<=20 then
                        table.insert(v.技能,"高级驱鬼")
                    end
                end
                if not v.主动技能 then
                    v.主动技能 =  取随机法术新(6)
                    if 取随机数()<=35 then
                        table.insert(v.主动技能 ,"龙吟")
                    end
                end
            end,
            点杀 = function()
                v.力量 = v.力量 or (20 + v.等级 * 6)
                v.法伤 = v.法伤 or math.floor(属性.法伤 * 0.5)
                v.法防 = v.法防 or math.floor(属性.法防 * 0.5)
                v.法术修炼 = v.法术修炼 or math.floor(修炼等级 / 2)
                v.抗法修炼 = v.抗法修炼 or math.floor(修炼等级 / 2)
                v.主动技能 = v.主动技能 or {"横扫千军","烟雨剑法","破血狂攻","壁垒击破","善恶有报","力劈华山"}
                if not v.技能 then
                    v.技能 = {"高级感知","高级反击","高级偷袭","高级必杀","高级连击","高级吸血","高级毒"}
                    if 取随机数()<=15 then
                        table.insert(v.技能,"高级神佑复生")
                    end
                    if 取随机数()<=20 then
                        table.insert(v.技能,"高级驱鬼")
                    end
                end
            end,
            群杀 = function()
                v.力量 = v.力量 or (20 + v.等级 * 6)
                v.伤害 = v.伤害 or math.floor(属性.伤害 * 0.95)
                v.防御 = v.防御 or math.floor(属性.防御 * 0.7)
                v.法伤 = v.法伤 or math.floor(属性.法伤 * 0.6)
                v.法防 = v.法防 or math.floor(属性.法防 * 0.5)
                v.攻击修炼 = v.攻击修炼 or math.floor(修炼等级 / 2)
                v.防御修炼 = v.防御修炼 or math.floor(修炼等级 / 4)
                v.法术修炼 = v.法术修炼 or math.floor(修炼等级 / 2)
                v.抗法修炼 = v.抗法修炼 or math.floor(修炼等级 / 4)
                v.主动技能 = v.主动技能 or {"浪涌","天雷斩","飘渺式","剑荡四方","鹰击"}
                if not v.技能 then
                    v.技能 = {"高级感知","高级反击","高级偷袭","高级必杀","高级吸血","高级毒"}
                    if 取随机数()<=15 then
                        table.insert(v.技能,"高级神佑复生")
                    end
                    if 取随机数()<=20 then
                        table.insert(v.技能,"高级驱鬼")
                    end
                end
            end,
            辅助 = function()
                v.体质 = v.体质 or (20 + v.等级 * 3)
                v.耐力 = v.耐力 or (20 + v.等级 * 3)
                v.敏捷 = v.敏捷 or (20 + v.等级 * 2)
                v.伤害 = v.伤害 or math.floor(属性.伤害 * 0.6)
                v.防御 = v.防御 or math.floor(属性.防御 * 0.7)
                v.法伤 = v.法伤 or math.floor(属性.法伤 * 0.9)
                v.法防 = v.法防 or math.floor(属性.法防 * 0.7)
                v.攻击修炼 = v.攻击修炼 or math.floor(修炼等级 / 4)
                v.防御修炼 = v.防御修炼 or math.floor(修炼等级 / 2)
                v.法术修炼 = v.法术修炼 or math.floor(修炼等级 / 4)
                v.抗法修炼 = v.抗法修炼 or math.floor(修炼等级 / 2)
                v.技能 = v.技能 or {"高级感知","高级防御","高级鬼魂术"}
                if not v.治疗能力 then
                    v.治疗能力 = math.floor(v.等级 * 7)
                end
                if not v.主动技能 then
                    v.主动技能 =  {"生命之泉","推气过宫","地涌金莲","金刚护体","金刚护法","一苇渡江","罗汉金钟","圣灵之甲","龙吟"}
                    if 取随机数()<=20 then
                        table.insert(v.主动技能 ,"晶清诀")
                    elseif 取随机数()<=25 then
                        table.insert(v.主动技能 ,"四海升平")
                    end
                end
            end,
            固伤 = function()
                v.敏捷 = v.敏捷 or (20 + v.等级 * 6)
                v.伤害 = v.伤害 or math.floor(属性.伤害 * 0.6)
                v.法伤 = v.法伤 or math.floor(属性.法伤 * 0.6)
                v.攻击修炼 = v.攻击修炼 or math.floor(修炼等级 / 4)
                v.防御修炼 = v.防御修炼 or math.floor(修炼等级)
                v.法术修炼 = v.法术修炼 or math.floor(修炼等级 / 4)
                v.抗法修炼 = v.抗法修炼 or math.floor(修炼等级)
                if not v.固定伤害 then
                    v.固定伤害 = math.floor(v.等级 * 7)
                end
                if not v.技能 then
                    v.技能 = {"高级感知","高级鬼魂术"}
                    if 取随机数()<=20 then
                        table.insert(v.技能,"高级驱鬼")
                    end
                    if 取随机数()<=20 then
                        table.insert(v.技能,"高级反震")
                    end
                end
                if not v.主动技能 then
                    v.主动技能 =  取随机固伤法术(5)
                    if 取随机数()<=20 then
                        table.insert(v.主动技能,"生命之泉")
                        if not v.治疗能力 then
                            v.治疗能力 = math.floor(v.等级 * 7)
                        end
                    elseif 取随机数()<=15 then
                        table.insert(v.主动技能 ,"晶清诀")
                    end
                end
            end,
            封印 = function()
                v.敏捷 = v.敏捷 or (20 + v.等级 * 6)
                v.伤害 = v.伤害 or math.floor(属性.伤害 * 0.6)
                v.防御 = v.防御 or math.floor(属性.防御 * 0.8)
                v.法伤 = v.法伤 or math.floor(属性.伤害 * 0.6)
                v.法防 = v.法防 or math.floor(属性.法防 * 0.8)
                v.攻击修炼 = v.攻击修炼 or math.floor(修炼等级 / 4)
                v.防御修炼 = v.防御修炼 or math.floor(修炼等级 / 2)
                v.法术修炼 = v.法术修炼 or math.floor(修炼等级 / 4)
                v.抗法修炼 = v.抗法修炼 or math.floor(修炼等级 / 2)
                if not v.技能 then
                    v.技能 = {"高级感知","高级神佑复生"}
                    if 取随机数()<=20 then
                        table.insert(v.技能,"高级反震")
                    end
                end
                if not v.主动技能 then
                    v.主动技能 =  取随机封印法术(8)
                    if 取随机数()<=35 then
                        table.insert(v.主动技能 ,"龙吟")
                    end
                    if 取随机数()<=15 then
                        table.insert(v.主动技能 ,"晶清诀")
                    elseif 取随机数()<=15 then
                        table.insert(v.主动技能 ,"四海升平")
                    end
                end
            end
        }
        if v.加载 and 类型处理[v.加载] then
            类型处理[v.加载]()
        end
    end
    -- 处理所有单位
      local 类型 = {"点杀","群杀","法术","辅助","固伤","封印"}
      for k, v in pairs(单位组) do
          if type(k)=="number" and type(v) == "table" then
                v.等级 = v.等级 or 单位等级
                if v.等级<10 then v.等级 = 10 end
                local 成长 = 计算成长(15, 0.03,math.min(math.floor(v.等级 / 10),10))
                local 属性 = {气血 = math.floor((math.floor(v.等级 / 10) * 690 + 成长 * v.等级) * 加载.气血),
                              伤害 = math.floor(v.等级 * 加载.伤害),
                              法伤 = math.floor(v.等级 * 加载.法伤),
                              防御 = math.floor(v.等级 * 加载.防御),
                              法防 = math.floor(v.等级 * 加载.法防),
                              速度 = math.floor(v.等级 * 加载.速度)
                              }
                if self.战斗类型~=100001 and self.战斗类型~=100007 then
                    if k ~= 1 then
                        v.加载 = v.加载 or 类型[取随机数(1,#类型)]
                        处理怪物类型(v,属性)
                    else
                        for i, n in pairs(属性) do
                            if not v[i] then
                                v[i] = n
                            end
                        end
                        if v.加载 then
                           处理怪物类型(v,属性)
                        else
                            v.技能 = v.技能 or 取随机兽决被动(5)
                            v.主动技能 = v.主动技能 or 取随机法术(8)
                        end
                    end
                    for _, n in ipairs(self.五维属性) do
                        if not v[n] then
                            v[n] = 20 + v.等级 * 2
                        end
                    end
                    for _, n in ipairs(self.修炼类型) do
                        if not v[n] then
                           v[n] =  修炼等级
                        end
                    end
                end
                for i, n in pairs(属性) do
                  if not v[i] then
                      if k ~= 1 and self.战斗类型~=100001 and self.战斗类型~=100007 then
                          v[i] = math.floor(n * 0.85)
                      else
                          v[i] = n
                      end
                  end
                end
              --  v.法宝 = v.法宝  ---------------------------法宝佩戴改--初始会归空
                v.最大气血 = v.气血
                v.命中 = v.命中 or v.伤害
                v.愤怒 = v.愤怒 or 9999
                v.躲闪 = v.躲闪 or v.等级 * 4
                v.魔法 = v.魔法 or 20000000
                v.最大魔法 = v.魔法
                v.武器伤害 = v.武器伤害 or v.等级 * 3
                v.附加阵法 = v.附加阵法 or 单位组.阵法 or "普通"
                for i,n in ipairs(v.主动技能) do
                  if type(i)=="number" and type(n)=="string" then
                      table.insert(v.技能, n)
                  end
                end
                v.主动技能 = nil
          end
      end
      单位组.阵法 = nil
      if 单位组[1] and 单位组[1].气血 < 5000 then
          for i,v in ipairs(self.参战玩家) do
              v.进入时间 = v.进入时间 - 1
          end
      end

end












function 战斗处理类:神话词条处理(编号)
          if self.参战单位[编号].神话词条 then
              if self.参战单位[编号].门派=="方寸山" and self.参战单位[编号].神话词条.卫灵神咒  then
                      if 取随机数()<=self.参战单位[编号].神话词条.卫灵神咒 *12 then
                            self.参战单位[编号].封印命中等级=math.floor(self.参战单位[编号].封印命中等级*(1+self.参战单位[编号].神话词条.卫灵神咒*0.08))
                      else
                            self.参战单位[编号].封印命中等级=math.floor(self.参战单位[编号].封印命中等级+self.参战单位[编号].等级*self.参战单位[编号].神话词条.卫灵神咒*0.6)
                      end

              elseif self.参战单位[编号].门派=="龙宫" and self.参战单位[编号].神话词条.沧溟龙魄  then
                      if 取随机数()<=self.参战单位[编号].神话词条.沧溟龙魄 *10 then
                            self.参战单位[编号].法伤=math.floor(self.参战单位[编号].法伤*(1+self.参战单位[编号].神话词条.沧溟龙魄*0.08))
                      else
                            self.参战单位[编号].法伤 = math.floor(self.参战单位[编号].法伤 + self.参战单位[编号].等级*self.参战单位[编号].神话词条.沧溟龙魄*0.8)
                      end
              elseif self.参战单位[编号].门派=="女儿村"  then
                      if self.参战单位[编号].神话词条.花语倾城 then
                            if 取随机数()<=self.参战单位[编号].神话词条.花语倾城 *12 then
                                self.参战单位[编号].速度=math.floor(self.参战单位[编号].速度*(1+self.参战单位[编号].神话词条.花语倾城*0.15))
                            else
                                self.参战单位[编号].速度 = self.参战单位[编号].速度 + self.参战单位[编号].等级*self.参战单位[编号].神话词条.花语倾城
                            end
                      end
                      if self.参战单位[编号].神话词条.一笑倾国 then
                            if 取随机数()<=self.参战单位[编号].神话词条.一笑倾国 *12 then
                                self.参战单位[编号].伤害 = math.floor(self.参战单位[编号].伤害*(1+self.参战单位[编号].神话词条.一笑倾国*0.15))
                            else
                                self.参战单位[编号].伤害 = self.参战单位[编号].伤害 + self.参战单位[编号].等级*self.参战单位[编号].神话词条.一笑倾国
                            end
                      end
              elseif self.参战单位[编号].门派=="阴曹地府" and self.参战单位[编号].神话词条.无常索命 then
                      if 取随机数()<=self.参战单位[编号].神话词条.无常索命 *12 then
                            self.参战单位[编号].固定伤害=self.参战单位[编号].固定伤害*(1+self.参战单位[编号].神话词条.无常索命*0.1)
                      else
                            self.参战单位[编号].固定伤害 = self.参战单位[编号].固定伤害 + self.参战单位[编号].等级*self.参战单位[编号].神话词条.无常索命
                      end
              elseif self.参战单位[编号].门派=="普陀山" and self.参战单位[编号].神话词条.慧眼观世 then
                      if 取随机数()<= self.参战单位[编号].神话词条.慧眼观世*12 then
                            self.参战单位[编号].固定伤害 = math.floor(self.参战单位[编号].固定伤害 + (1+self.参战单位[编号].神话词条.慧眼观世*0.08))
                      else
                            self.参战单位[编号].固定伤害 = math.floor(self.参战单位[编号].固定伤害 +self.参战单位[编号].等级*self.参战单位[编号].神话词条.慧眼观世*0.5)
                      end

              elseif self.参战单位[编号].门派=="盘丝洞" and self.参战单位[编号].神话词条.天网蛛狩 then
                      if 取随机数()<=self.参战单位[编号].神话词条.天网蛛狩 *15 then
                            self.参战单位[编号].封印命中等级=math.floor(self.参战单位[编号].封印命中等级*(1+self.参战单位[编号].神话词条.天网蛛狩*0.08))
                      else
                            self.参战单位[编号].封印命中等级=math.floor(self.参战单位[编号].封印命中等级+self.参战单位[编号].等级*self.参战单位[编号].神话词条.天网蛛狩*0.5)
                      end
              elseif self.参战单位[编号].门派=="凌波城" and self.参战单位[编号].神话词条.超级战息 then
                      if 取随机数()<=self.参战单位[编号].神话词条.超级战息 *15 then
                            self.参战单位[编号].物理暴击等级=math.floor(self.参战单位[编号].物理暴击等级*(1+self.参战单位[编号].神话词条.超级战息*0.08))
                      else
                            self.参战单位[编号].物理暴击等级=math.floor(self.参战单位[编号].物理暴击等级+self.参战单位[编号].等级*self.参战单位[编号].神话词条.超级战息*0.6)
                      end
              end
          end

end

function 战斗处理类:加载法宝(编号,id)
    if not 编号 or not self.参战单位[编号] then return end
    local 玩家 = 玩家数据[id]
    local 角色 = 玩家.角色
    for n = 1, 4 do
        local 道具id = 角色.数据.法宝佩戴[n]
        if 道具id ~= nil and 玩家.道具.数据[道具id] ~= nil then
            local 道具 = 玩家.道具.数据[道具id]
            local 名称 = 道具.名称
            local 境界 = 道具.气血
            local 五行 = 道具.五行

            -- 添加法宝佩戴信息
            table.insert(self.参战单位[编号].法宝佩戴, {
                名称 = 名称,
                境界 = 境界,
                五行 = 五行,
                玩家id = id,
                序列 = 道具id
            })

            local 法宝序列 = #self.参战单位[编号].法宝佩戴
            if 法宝序列 and 战斗技能[名称] and 战斗技能[名称].角色 and 战斗技能[名称].加载法宝 and (not 战斗技能[名称].门派 or self.参战单位[编号].门派 == 战斗技能[名称].门派) then
                if 玩家数据[id].道具.数据[道具id].魔法>=1 then
                    玩家数据[id].道具.数据[道具id].魔法 = 玩家数据[id].道具.数据[道具id].魔法 -1
                     发送数据(玩家数据[id].连接id,38,{内容="你的法宝["..名称.."]灵气减少了1点"})
                    战斗技能[名称].加载法宝(self,编号,境界,五行)
                end
            end
        end
    end
end


function 战斗处理类:添加宝宝法宝属性(编号,id)
  if not 编号 or not self.参战单位[编号] or not self.参战单位[编号].主人 or not self.参战单位[self.参战单位[编号].主人]  then
    return
  end
  local 主人 = self.参战单位[编号].主人
  for i,v in ipairs(self.参战单位[主人].法宝佩戴) do
      local 名称 = v.名称
      local 境界 = v.境界
      local 五行 = v.五行
      local 序列 = v.序列
      if 战斗技能[名称] and 战斗技能[名称].宝宝 and 战斗技能[名称].加载法宝  and (not 战斗技能[名称].门派 or self.参战单位[主人].门派 == 战斗技能[名称].门派) then
          if 玩家数据[self.参战单位[self.参战单位[编号].主人].玩家id].道具.数据[序列].魔法>=1 then
            玩家数据[self.参战单位[self.参战单位[编号].主人].玩家id].道具.数据[序列].魔法 = 玩家数据[self.参战单位[self.参战单位[编号].主人].玩家id].道具.数据[序列].魔法 -1
            发送数据(玩家数据[self.参战单位[self.参战单位[编号].主人].玩家id].连接id,38,{内容="你的法宝["..名称.."]灵气减少了1点"})
            战斗技能[名称].加载法宝(self,编号,境界,五行,主人)
          end
      end
  end
end


--主动技能

function 战斗处理类:加载奇经八脉(编号)
          if self.参战单位[编号].奇经八脉 then
              for k,v in pairs(self.参战单位[编号].奇经八脉) do
                  if 战斗技能[k] and not 战斗技能[k].被动 and 战斗技能[k].奇经八脉 then
                      self:添加主动技能(self.参战单位[编号],k,self.参战单位[编号].等级+10)
                      if k =="潜龙在渊" then
                          self.参战单位[编号].潜龙在渊加成 ={龙魂=0,龙腾=0,龙卷雨击=0}
                      elseif k =="威仪九霄" then
                          self.参战单位[编号].威仪九霄加成 = 0
                      end
                  end
              end
          end

          if self.参战单位[编号].奇经八脉.祛除 then
              self:添加主动技能(self.参战单位[编号],"百草定神",self.参战单位[编号].等级+10)
              self:添加主动技能(self.参战单位[编号],"百草红雪",self.参战单位[编号].等级+10)
              self:添加主动技能(self.参战单位[编号],"百草十香",self.参战单位[编号].等级+10)
          end
          if self.参战单位[编号].奇经八脉.净化 then
              self:添加主动技能(self.参战单位[编号],"百草回春龙沙",self.参战单位[编号].等级+10)
          end
          if self.参战单位[编号].奇经特效 then
              if self.参战单位[编号].奇经特效.龙魂 and not self.参战单位[编号].奇经八脉.龙啸 then
                  self.参战单位[编号].龙魂=0
              end
              if self.参战单位[编号].奇经特效.乐韵 then
                  self.参战单位[编号].乐韵=0
              end
              if self.参战单位[编号].奇经特效.骤雨 then
                  self.参战单位[编号].骤雨={层数=0,回合=0}
              end
              for k,v in pairs(self.参战单位[编号].奇经特效) do
                  if k == "翩鸿一击"  then
                      if not self.参战单位[编号].奇经八脉.长驱直入 and not self.参战单位[编号].奇经八脉.摧枯拉朽 then
                           self:添加主动技能(self.参战单位[编号],k,self.参战单位[编号].等级+10)
                      end
                  elseif 战斗技能[k] and not 战斗技能[k].被动 and 战斗技能[k].奇经特效 then
                        self:添加主动技能(self.参战单位[编号],k,self.参战单位[编号].等级+10)
                  end
              end
          end


         if self.参战单位[编号].奇经八脉.风刃  then
            self.参战单位[编号].溅射人数= self.参战单位[编号].溅射人数+2
            self.参战单位[编号].溅射 = self.参战单位[编号].溅射 + 0.001
         end
         if self.参战单位[编号].奇经八脉.傲翔 and self:取是否单独门派(编号)  then
            self.参战单位[编号].防御 = self.参战单位[编号].防御 - self.参战单位[编号].魔力*0.2
            self.参战单位[编号].法术伤害结果 = self.参战单位[编号].法术伤害结果 + self.参战单位[编号].魔力*0.09
         end
         if self.参战单位[编号].奇经八脉.龙息 then
            self.参战单位[编号].奇经八脉龙息 =0
         end
         if self.参战单位[编号].奇经八脉.盘龙 then
            self.参战单位[编号].奇经八脉盘龙 =0
         end
         if self.参战单位[编号].奇经八脉.升温 then
            self.参战单位[编号].奇经八脉升温 =0
         end
         if self.参战单位[编号].奇经八脉.国色 and self.参战单位[编号].召唤兽~=nil  then
            local 召唤兽编号 = self.参战单位[编号].召唤兽
            if self.参战单位[编号].速度>=self.参战单位[召唤兽编号].等级*5 then
               self.参战单位[编号].速度 = self.参战单位[编号].速度 *1.12
            end
         end
         if self.参战单位[编号].奇经八脉.淬芒 then
            self.参战单位[编号].奇经八脉淬芒={回合=0,加成=0}
         end
         if self.参战单位[编号].奇经八脉.狂袭 then
            self.参战单位[编号].奇经八脉狂袭={回合=0,加成=0}
         end
         if self.参战单位[编号].奇经八脉.风行 then
            for k,v in pairs(self.参战单位) do
                if v.类型 == "角色" and v.队伍 == self.参战单位[编号].队伍 then
                    v.速度 = v.速度 + 8
                end
            end
         end

         if self.参战单位[编号].奇经八脉.叶护 then
            local 判断 =true
            for k,v in pairs(self.参战单位) do
              if k~=编号 and v.类型 == "角色" and v.队伍 == self.参战单位[编号].队伍 and v.速度>=self.参战单位[编号].速度 then
                判断 = false
              end
            end
            if 判断 then
               self.参战单位[编号].奇经八脉叶护 = 1
            end
         end
         if self.参战单位[编号].奇经八脉.低眉 and self:取是否单独门派(编号) then
            self.参战单位[编号].伤害=self.参战单位[编号].伤害 +  玩家数据[self.参战单位[编号].玩家id].经脉:取师门技能等级("莲花宝座") * 2
         end
         if self.参战单位[编号].奇经八脉.药颂 then
            self.参战单位[编号].灵药={红=2,蓝=2,黄=2}
         end
         if self.参战单位[编号].奇经八脉.九天 and self:取是否单独门派(编号) then
            self.参战单位[编号].伤害=self.参战单位[编号].伤害 +  玩家数据[self.参战单位[编号].玩家id].经脉:取师门技能等级("大鹏展翅")*2
         end
         if self.参战单位[编号].奇经八脉.惊霆 then
            self:添加状态("霹雳弦惊",编号,编号,self.参战单位[编号].等级)
            self.参战单位[编号].法术状态.霹雳弦惊.回合=4
         end
         if self.参战单位[编号].奇经八脉.妖法 and self:取指定法宝(编号,"宝烛",1) then
               self.参战单位[编号].速度= math.floor(self.参战单位[编号].速度 * (1+self:取指定法宝(编号,"宝烛")*0.01))
         end
         if self.参战单位[编号].奇经八脉.独一 and self:取是否单独门派(编号)  then
            self.参战单位[编号].固定伤害= self.参战单位[编号].固定伤害 +100
         end
         if self.参战单位[编号].奇经八脉.道果 then
            self.参战单位[编号].人参娃娃 ={层数=1,回合=3}
         end
        if self.参战单位[编号].奇经八脉.静心 and self.参战单位[编号].门派=="普陀山" then
            for i=1,#self.参战单位 do
                if self.参战单位[i].队伍==self.参战单位[编号].队伍 and self.参战单位[i].类型=="角色" and not self.参战单位[i].奇经八脉普陀静心 then
                    self.参战单位[i].抵抗封印等级 =self.参战单位[i].抵抗封印等级+30
                    self.参战单位[i].奇经八脉普陀静心 =true
                end
            end
        end
end



function 战斗处理类:增加阵法属性(编号, 名称, 位置, 阵法加成)
    if not 编号 or not self.参战单位[编号] then return end
    local 队伍id = self.参战单位[编号].队伍
    if not 队伍id or  not 队伍数据[队伍id] or #队伍数据[队伍id].成员数据 < 1 then
        return
    end
    local 属性={ 伤害=1,法伤=1,防御=1,法防=1,速度=1,固定伤害=1}
    local 实际加成 = 阵法加成 or 0
    local 阵法效果 = {
        天覆阵 = function()
              属性.伤害 = 属性.伤害 + 0.2 + 实际加成
              属性.法伤 = 属性.法伤 + 0.2 + 实际加成
              属性.速度 = 属性.速度 - 0.1 + 实际加成
              属性.固定伤害 = 属性.固定伤害 + 0.2 + 实际加成
        end,
        风扬阵 = function()
            if 位置 == 1 then
                  属性.伤害 = 属性.伤害 + 0.2 + 实际加成
                  属性.法伤 = 属性.法伤 + 0.2 + 实际加成
                  属性.速度 = 属性.速度 + 0.05 + 实际加成
                  属性.固定伤害 = 属性.固定伤害 + 0.2 + 实际加成
             else
                  属性.伤害 = 属性.伤害 + 0.1 + 实际加成
                  属性.法伤 = 属性.法伤 + 0.1 + 实际加成
                  属性.固定伤害 = 属性.固定伤害 + 0.1 + 实际加成
            end
        end,
        虎翼阵 = function()
            if 位置 == 1 then
                  属性.伤害 = 属性.伤害 + 0.25 + 实际加成
                  属性.法伤 = 属性.法伤 + 0.25 + 实际加成
                  属性.固定伤害 = 属性.固定伤害 + 0.25 + 实际加成
            elseif 位置 == 2 or 位置 == 3 then
                    属性.防御 = 属性.防御 + 0.2 + 实际加成
                    属性.法防 = 属性.法防 + 0.2 + 实际加成
            else
                    属性.伤害 = 属性.伤害 + 0.2 + 实际加成
            end
        end,
        云垂阵 = function()
            if 位置 == 1 then
                属性.伤害 = 属性.伤害 + 0.25 + 实际加成
                属性.法伤 = 属性.法伤 + 0.25 + 实际加成
                属性.固定伤害 = 属性.固定伤害 + 0.25 + 实际加成
            elseif 位置 == 2 then
                属性.防御 = 属性.防御 + 0.1 + 实际加成
            elseif 位置 == 3 then
                属性.伤害 = 属性.伤害 + 0.2 + 实际加成
                属性.法伤 = 属性.法伤 + 0.2 + 实际加成
                属性.固定伤害 = 属性.固定伤害 + 0.2 + 实际加成
            else
                属性.速度 = 属性.速度 + 0.1 + 实际加成
            end
        end,
        鸟翔阵 = function()
            if 位置 == 1 then
                属性.速度 = 属性.速度 + 0.2 + 实际加成
            elseif 位置 == 2 or 位置 == 3 then
                属性.速度 = 属性.速度 + 0.1 + 实际加成
            else
                属性.速度 = 属性.速度 + 0.15 + 实际加成
            end
        end,
        地载阵 = function()
            if 位置 == 1 or 位置 == 3 or 位置 == 4 then
                属性.防御 = 属性.防御 + 0.15 + 实际加成
                属性.法防 = 属性.法防 + 0.15 + 实际加成
            elseif 位置 == 2 then
                属性.伤害 = 属性.伤害 + 0.15 + 实际加成
                属性.法伤 = 属性.法伤 + 0.15 + 实际加成
                属性.固定伤害 = 属性.固定伤害 + 0.15 + 实际加成
            else
                属性.速度 = 属性.速度 + 0.1 + 实际加成
            end
        end,
        龙飞阵 = function()
            if 位置 == 1 then
                属性.法防 = 属性.法防 + 0.2 + 实际加成
            elseif 位置 == 2 then
                属性.防御 = 属性.防御 + 0.2 + 实际加成
            elseif 位置 == 3 then
                属性.速度 = 属性.速度 + 0.2 + 实际加成
            elseif 位置 == 4 then
                属性.法伤 = 属性.法伤 + 0.2 + 实际加成
            elseif 位置 == 5 then
                属性.伤害 = 属性.伤害 + 0.1 + 实际加成
                属性.法伤 = 属性.法伤 + 0.1 + 实际加成
                属性.固定伤害 = 属性.固定伤害 + 0.1 + 实际加成
            end
        end,
        蛇蟠阵 = function()
            if 位置 == 1 or 位置 == 2 or 位置 == 3 then
                属性.法伤 = 属性.法伤 + 0.15 + 实际加成
            else
                属性.伤害 = 属性.伤害 + 0.1 + 实际加成
                属性.法伤 = 属性.法伤 + 0.1 + 实际加成
                属性.固定伤害 = 属性.固定伤害 + 0.1 + 实际加成
            end
        end,
        鹰啸阵 = function()
            if 位置 == 1 then
                属性.防御 = 属性.防御 + 0.1 + 实际加成
            elseif 位置 == 2 or 位置 == 3 then
                属性.速度 = 属性.速度 + 0.15 + 实际加成

            elseif 位置 == 4 then
                属性.伤害 = 属性.伤害 + 0.15 + 实际加成
                属性.法伤 = 属性.法伤 + 0.15 + 实际加成
                属性.固定伤害 = 属性.固定伤害 + 0.15 + 实际加成
            else
                属性.伤害 = 属性.伤害 + 0.1 + 实际加成
                属性.法伤 = 属性.法伤 + 0.1 + 实际加成
                属性.固定伤害 = 属性.固定伤害 + 0.1 + 实际加成
            end
        end,
        八卦阵 = function()
            -- 获取队长的八卦阵数据
            local 八卦阵数据 = nil
            local 队伍id = self.参战单位[编号].队伍
            if 队伍id and 队伍数据[队伍id] and 队伍数据[队伍id].成员数据 and 队伍数据[队伍id].成员数据[1] then
                local 队长id = 队伍数据[队伍id].成员数据[1]
                if 玩家数据[队长id] and 玩家数据[队长id].角色.数据.高级阵法 and 玩家数据[队长id].角色.数据.高级阵法.八卦阵 then
                    八卦阵数据 = 玩家数据[队长id].角色.数据.高级阵法.八卦阵
                end
            end
            
            if not 八卦阵数据 then return end
            
            -- 属性名称映射表
            local 属性映射 = {
                伤害 = "伤害",
                法伤 = "法伤", 
                固伤 = "固定伤害",
                召唤兽伤害 = "召唤兽伤害",
                防御 = "防御",
                法防 = "法防",
                速度 = "速度"
            }
            
            -- 应用所有属性加成，按照高级阵法配置格式
            for 序号, 属性配置 in pairs(八卦阵数据) do
                if 属性配置.类型 ~= "等级" then
                    local 属性名称 = 属性映射[属性配置.类型]
                    if 属性配置.类型 == "召唤兽伤害" then
                        self.参战单位[编号].宝宝阵法 = 1 + (属性配置.数值 / 100) + 实际加成
                    elseif 属性名称 and 属性[属性名称] then
                        属性[属性名称] = 属性[属性名称] + (属性配置.数值 / 100) + 实际加成
                    end
                end
            end
        end,
        雷绝阵 = function()
            属性.固定伤害 = 属性.固定伤害 + ((位置 <= 3) and 0.2 or 0.1) + 实际加成
            self.参战单位[编号].宝宝阵法 = 1.1 + 实际加成
        end
    }
    if 阵法效果[名称] then
        阵法效果[名称]()
    end
    for k,v in pairs(属性) do
        if self.参战单位[编号][k] then
          self.参战单位[编号][k]=math.floor(self.参战单位[编号][k]*v)
        end
    end



end



function 战斗处理类:添加召唤兽特性(编号)
    if not 编号 or not self.参战单位[编号] or not self.参战单位[编号].特性 then
        return
    end
    local 特性 = self.参战单位[编号].特性
    local 几率 = self.参战单位[编号].特性几率 or 0
    local 属性 = {伤害 = 1,法伤 = 1,防御 = 1,法防 = 1,速度 = 1}
    local 特性效果 = {
        预知 = function()
            self.参战单位[编号].预知特性 = 几率
            self.参战单位[编号].预知次数 = 0
            return true -- 需要属性惩罚
        end,
        灵动 = function()
            self.参战单位[编号].灵动特性 = 几率
            self.参战单位[编号].灵动次数 = 0
            return true
        end,
        识物 = function()
            self.参战单位[编号].识物特性 = 几率
            return true
        end,
        抗法 = function()
            self.参战单位[编号].抗法特性 = 几率
            return false
        end,
        抗物 = function()
            self.参战单位[编号].抗物特性 = 几率
            return false
        end,
        洞察 = function()
            self.参战单位[编号].洞察特性 = 几率
            return true
        end,
        弑神 = function()
            self.参战单位[编号].弑神特性 = 几率
            return false
        end,
        顺势 = function()
            self.参战单位[编号].顺势特性 = 几率
            return false
        end,
        复仇 = function()
            self.参战单位[编号].复仇特性 = 几率
            self.参战单位[编号].复仇次数 = 0
            return false
        end,
        自恋 = function()
            self.参战单位[编号].自恋特性 = 几率
            return false
        end,
        暗劲 = function()
            self.参战单位[编号].暗劲特性 = 几率
            return false
        end,
        识药 = function()
            self.参战单位[编号].识药特性 = 几率
            return false
        end,
        吮魔 = function()
            self.参战单位[编号].吮魔特性 = 几率
            return false
        end,
        争锋 = function()
            self.参战单位[编号].争锋特性 = 几率
            return false
        end,
        力破 = function()
            self.参战单位[编号].力破特性 = 几率
            return false
        end,
        巧劲 = function()
            self.参战单位[编号].巧劲特性 = 几率
            return false
        end
    }

    -- 应用特性效果
    if 特性效果[特性] then
        local 需要 = 特性效果[特性]()
        if 需要 then
            for k,v in pairs(属性) do
                属性[k] = 0.95
            end
        end
    end
    for k,v in pairs(属性) do
        if self.参战单位[编号][k] then
            self.参战单位[编号][k] = math.floor(self.参战单位[编号][k] * v)
        end
    end
end


function 战斗处理类:添加状态特性(编号)
    if not 编号 or not self.参战单位[编号] or not self.参战单位[编号].特性 then
        return
    end
    local 特性 = self.参战单位[编号].特性
    local 几率 = self.参战单位[编号].特性几率 or 0
    local 触发值 = ({33, 50, 66, 83, 100})[几率] or 0
    local 防御惩罚 = 几率 >= 3 and 5 or 10
    local 添加状态 = false
    local 触发流程 = function()
          local 气血 = math.floor(self.参战单位[编号].气血 * 0.3)
          local 流程 = {流程=50,攻击方=编号,挨打方{
                        {挨打方=编号,伤害=气血,类型=1,
                         死亡 = self:减少气血(编号,气血,编号,"特效")}
                        }}
          table.insert(self.战斗流程,流程)
    end
    local 特性效果 = {
       御风 = function()
            if self.参战单位[编号].主人 then
                self:添加状态(特性,self.参战单位[编号].主人,编号,几率)
            end
        end,
        灵刃 = function()
            if 触发值 >= 取随机数() then
                触发流程()
                self:添加状态(特性,编号,编号,几率)
            end
        end,
        灵法 = function()
            self:添加状态(特性,编号,编号,几率)
            self:添加状态("灵法1",编号,编号,几率)
        end,

        阳护 = function()
            if 触发值 >= 取随机数() then
                for i = 1, #self.参战单位 do
                    if i ~= 编号 and self.参战单位[i] and self.参战单位[i].队伍 == self.参战单位[编号].队伍
                    and self.参战单位[编号].法术状态.死亡召唤 then
                        self.参战单位[编号].法术状态.死亡召唤.回合 = math.max(self.参战单位[编号].法术状态.死亡召唤.回合 - 2, 1)
                    end
                end
            end
        end,
        护佑 = function()
            if 取随机数(1, 10) < 几率 then
                self:添加状态(特性,self:取我方气血最低(编号),编号,几率)
            end
        end,
        怒吼 = function()
            if 取随机数(1, 10) < 几率 then
                self.参战单位[编号].防御 = math.floor(self.参战单位[编号].防御 * 0.9)
                local 目标 = self:取我方伤害最高(编号)
                if 目标 then
                    self:添加状态(特性,编号,编号,几率)
                    self:添加状态("怒吼1",编号,编号,几率)
                end
            end
        end,
        灵断 = function()
            if 触发值 >= 取随机数() then
                触发流程()
                self:添加状态(特性,编号,编号,几率)
            end
        end,

        瞬击 = function()
            if 触发值 >= 取随机数() then
                self.参战单位[编号].防御 = math.floor(self.参战单位[编号].防御 * (1 - 防御惩罚 / 100))
                self.参战单位[编号].指令.目标 = self:取单个敌方目标(编号)
                self:普通攻击计算(编号)
            end
        end,
        瞬法 = function()
            if  触发值 >= 取随机数(1, 100) then
                local 名称 = self:取召唤兽可用法术(编号)
                if 名称 then
                    self.参战单位[编号].最大气血 = math.floor(self.参战单位[编号].最大气血 * (1 - 防御惩罚 / 100))
                    self.参战单位[编号].气血 = math.min(self.参战单位[编号].气血, self.参战单位[编号].最大气血)
                    self:法攻技能计算(编号, 名称, self:取技能等级(编号, 名称), {
                        目标 = self:取单个敌方目标(编号)
                    })
                end
            end
        end
    }


    if 特性效果[特性] then
        特性效果[特性]()
    end
end


function 战斗处理类:添加内丹属性(编号, 内丹列表)
    if not 编号 or not self.参战单位[编号] or not 内丹列表 or type(内丹列表) ~= "table" then
        return
    end
    local 内丹效果 = {
        深思 = function(v)
            if self.参战单位[编号].冥思 and self:取技能重复(编号,{"高级冥思","冥思","超级冥思"}) then
                self.参战单位[编号].冥思 = self.参战单位[编号].冥思 + v.等级 * 5
            end
        end,
        淬毒 = function(v)
            if self.参战单位[编号].毒 and self:取技能重复(编号,{"毒","高级毒","超级毒"}) then
                self.参战单位[编号].毒 = self.参战单位[编号].毒 + v.等级 * 5
            end
        end,
        连环 = function(v)
            if self.参战单位[编号].连击 and self:取技能重复(编号,{"连击","高级连击","超级连击"}) then
                self.参战单位[编号].连击 = self.参战单位[编号].连击 + v.等级 * 2
            end
        end,
        圣洁 = function(v)
            if self.参战单位[编号].驱鬼 and self:取技能重复(编号,{"驱鬼","高级驱鬼","超级驱鬼"}) then
                self.参战单位[编号].驱鬼 = self.参战单位[编号].驱鬼 + math.floor(v.等级 * 10 / 100)
            end
        end,
        坚甲 = function(v)
            if self:取技能重复(编号,{"反震","高级反震","超级反震"}) then
                self.参战单位[编号].反震1 = v.等级 * 100
            end
        end,
        狂怒 = function(v)
            self.参战单位[编号].狂怒 = 60 + v.等级 * 20
        end,
        阴伤 = function(v)
            self.参战单位[编号].阴伤 = 40 + v.等级 * 10
        end,

        撞击 = function(v)
            self.参战单位[编号].撞击 = v.等级
        end,
        钢化 = function(v)
            if self:取技能重复(编号,{"防御","高级防御","超级防御"}) then
                self.参战单位[编号].防御 = math.floor(self.参战单位[编号].防御 + self.参战单位[编号].等级 * 0.2 * v.等级)
            end
            self.参战单位[编号].钢化 = 1
        end,
        玄武躯 = function()
            self.参战单位[编号].玄武躯 = 1
        end,
        龙胄铠 = function()
            self.参战单位[编号].龙胄铠 = 1
        end,

        擅咒 = function(v)
            self.参战单位[编号].法术伤害结果 = self.参战单位[编号].法术伤害结果 + math.floor(12 * v.等级)
        end,
        狙刺 = function(v)
            self.参战单位[编号].法伤 = self.参战单位[编号].法伤 + math.floor(self.参战单位[编号].等级 * 0.15) * v.等级
        end,

        碎甲刃 = function(v)
            self.参战单位[编号].碎甲刃 = v.等级
        end,
        舍身击 = function(v)
            self.参战单位[编号].舍身击 = math.floor((self.参战单位[编号].力量 - self.参战单位[编号].等级) * 0.05) * v.等级
        end,
        生死决 = function(v)
            self.参战单位[编号].狂暴等级 = self.参战单位[编号].狂暴等级 + 3 * 25 + math.floor(25 * 0.75 * v.等级)
        end,
        催心浪 = function(v)
            if self.参战单位[编号].法波 then
                self.参战单位[编号].法波 = self.参战单位[编号].法波 + v.等级 * 3
            end
        end,
        隐匿击 = function(v)
            self.参战单位[编号].隐匿击 = v.等级
        end,
        灵身 = function(v)
            self.参战单位[编号].灵身 = v.等级
        end,
        腾挪劲 = function(v)
            self.参战单位[编号].腾挪劲 = v.等级
        end,
        血债偿 = function(v)
            self.参战单位[编号].血债偿 = (self.参战单位[编号].魔力 - self.参战单位[编号].等级) * 0.04 * v.等级
        end,
        通灵法 = function(v)
            self.参战单位[编号].通灵法 = v.等级
        end,
        慧心 = function(v)
            self.参战单位[编号].慧心 = v.等级
        end,
        无畏 = function(v)
            self.参战单位[编号].无畏 = 1 + v.等级 * 0.2
        end,
        愤恨 = function(v)
            self.参战单位[编号].愤恨 = 1 + v.等级 * 0.2
        end,
        玉砥柱 = function(v)
            self.参战单位[编号].玉砥柱 = v.等级 * 0.07
        end,
        双星暴 = function(v)
            self.参战单位[编号].双星暴 = v.等级 * 0.1
        end,
        电魂闪 = function(v)
            self.参战单位[编号].电魂闪 = v.等级 * 9
        end
    }

    -- 处理每个内丹
    for _, 内丹 in ipairs(内丹列表) do
        if 内丹.技能 and 内丹效果[内丹.技能] then
            内丹效果[内丹.技能](内丹)
        end
    end
end





function 战斗处理类:添加技能属性(编号, 技能组)
    if not 编号 or not self.参战单位[编号] or not 技能组 or type(技能组) ~= "table" then
        return
    end
    if self.参战单位[编号].类型 == "bb" and self.参战单位[编号].主人 and self.参战单位[self.参战单位[编号].主人].经脉流派 == "万兽之王" then
        self.参战单位[编号].狮魂 = 0
        self:添加主动技能(self.参战单位[编号],"幼狮之搏")
        self:添加主动技能(self.参战单位[编号],"鹰击长空")
        if self.参战单位[self.参战单位[编号].主人].奇经八脉.健壮 then
            self.参战单位[编号].最大气血 = math.floor(self.参战单位[编号].最大气血 * 1.1)
            self.参战单位[编号].气血 = math.floor(self.参战单位[编号].气血 * 1.1)
        end
    end
    if self.参战单位[编号].类型 == "bb" and self.参战单位[编号].主人 and self.参战单位[self.参战单位[编号].主人].奇经八脉.御兽 then
        if self.参战单位[self.参战单位[编号].主人].速度 > self.参战单位[编号].等级 * 3 then
            self.参战单位[编号].速度 = self.参战单位[编号].速度 + self.参战单位[编号].等级 * 0.7
            self.参战单位[编号].法防 = self.参战单位[编号].法防 + self.参战单位[编号].等级
        end
    end


    -- 定义技能分类
    local 技能分类 = {
          -- 临时主动 ={自爆=1,水攻=1,落岩=1,雷击=1,烈火=1,月光=1,龙腾=1,雾杀=1,蜜润=1,活血=1,威慑=1,勾魂=1,裂石=1,治疗=1,
          --           奔雷咒=1,五雷咒=1,天雷斩=1,杀气诀=1,夺命咒=1,判官令=1,阎罗令=1,还魂咒=1,日光华=1,定身符=1,
          --           观照万象=1,上古灵符=1,泰山压顶=1,地狱烈火=1,水漫金山=1,八凶法阵=1,叱咤风云=1,天降灵葫=1,流沙轻音=1,食指大动=1,扶摇万里=1,
          --           龙卷雨击=1,飞砂走石=1,三昧真火=1,唧唧歪歪=1,谆谆教诲=1,五雷轰顶=1,不动如山=1,
          --           死亡召唤=1,善恶有报=1,惊心一剑=1,壁垒击破=1,剑荡四方=1,力劈华山=1,哼哼哈兮=1,水击三千=1,神来气旺=1,无畏布施=1,北冥之渊=1,
          --           横扫千军=1,烟雨剑法=1,后发制人=1,蚩尤之搏=1,夜舞倾城=1,
          --           法术防御=1,峰回路转=1,金刚护体=1,百毒不侵=1,修罗隐身=1,楚楚可怜=1,四面埋伏=1,极度疯狂=1,姐妹同心=1,金身舍利=1,
          --           杨柳甘露=1,炼气化神=1,地涌金莲=1,仙人指路=1, 普渡众生=1,推气过宫=1,
          --           超级奔雷咒=1,超级三昧真火=1,超级地狱烈火=1,超级水漫金山=1,超级泰山压顶=1,超级壁垒击破=1},
        临时被动 = {
            千钧一怒=1, 从天而降=1, 理直气壮=1, 移花接木=1, 凝光炼彩=1,
            弱点雷=1, 弱点火=1, 弱点水=1, 弱点土=1, 嗜血追击=1,浮云神马=1,
            凭风借力=1, 虎虎生威=1, 狂莽一击=1, 出其不意=1,
            风起龙游=1, 气贯长虹=1
        },
        直接添加 = {
            迟钝=1, 神出鬼没=1, 昼伏夜出=1, 大快朵颐=1, 超级毒=1,
            超级驱怪=1, 超级夜战=1, 超级反击=1, 超级反震=1, 超级吸血=1,
            超级连击=1, 超级飞行=1, 超级隐身=1, 超级感知=1, 超级再生=1,
            超级冥思=1, 超级驱鬼=1, 超级慧根=1, 超级必杀=1, 超级幸运=1,
            超级盾气=1, 超级合纵=1, 超级强力=1, 超级防御=1, 超级招架=1,
            超级永恒=1, 超级敏捷=1, 超级偷袭=1, 超级魔之心=1, 超级法术连击=1,
            超级进击必杀=1, 超级进击法暴=1, 超级法术暴击=1, 超级法术波动=1,
            超级否定信仰=1, 超级法术抵抗=1, 超级水属性吸收=1, 超级雷属性吸收=1,
            超级火属性吸收=1, 超级土属性吸收=1
        },
        低级被动 = {
            毒=1, 驱怪=1, 夜战=1, 反击=1, 反震=1, 吸血=1, 连击=1,
            飞行=1, 隐身=1, 感知=1, 再生=1, 冥思=1, 驱鬼=1, 慧根=1,
            必杀=1, 幸运=1, 盾气=1, 合纵=1, 强力=1, 防御=1, 招架=1,
            永恒=1, 敏捷=1, 偷袭=1, 魔之心=1, 鬼魂术=1, 神佑复生=1,
            法术连击=1, 法术暴击=1, 法术波动=1, 否定信仰=1, 进击必杀=1,
            进击法暴=1, 水属性吸收=1, 雷属性吸收=1, 火属性吸收=1, 土属性吸收=1
        },
        高级被动 = {
            高级毒="超级毒", 高级驱怪="超级驱怪", 高级夜战="超级夜战",
            高级反击="超级反击", 高级反震="超级反震", 高级吸血="超级吸血",
            高级连击="超级连击", 高级飞行="超级飞行", 高级隐身="超级隐身",
            高级感知="超级感知", 高级再生="超级再生", 高级冥思="超级冥思",
            高级驱鬼="超级驱鬼", 高级慧根="超级慧根", 高级必杀="超级必杀",
            高级幸运="超级幸运", 高级盾气="超级盾气", 高级合纵="超级合纵",
            高级强力="超级强力", 高级防御="超级防御", 高级招架="超级招架",
            高级永恒="超级永恒", 高级敏捷="超级敏捷", 高级偷袭="超级偷袭",
            高级魔之心="超级魔之心", 高级法术连击="超级法术连击",
            高级法术暴击="超级法术暴击", 高级法术波动="超级法术波动",
            高级否定信仰="超级否定信仰", 高级进击必杀="超级进击必杀",
            高级进击法暴="超级进击法暴", 高级水属性吸收="超级水属性吸收",
            高级雷属性吸收="超级雷属性吸收", 高级火属性吸收="超级火属性吸收",
            高级土属性吸收="超级土属性吸收", 高级法术抵抗="超级法术抵抗",
            高级鬼魂术="超级鬼魂术", 高级神佑复生="超级神佑复生"
        }
    }

    -- 特殊技能处理函数
    local function 特殊技能(v)
        -- if v == "浮云神马" then
        --     self:添加状态("浮云神马",编号,编号,self.参战单位[编号].等级)
        --     if self.参战单位[编号].主人 then
        --         self:添加状态("浮云神马",self.参战单位[编号].主人,self.参战单位[编号].主人,self.参战单位[编号].等级)
        --     end
        -- else
        if v == "高级龙魂" then
            self.参战单位[编号].高级龙魂 = 0
        elseif v == "苍鸾怒击" then
            self.参战单位[编号].怒击效果 = true
        end
    end

    -- 处理精神集中和神迹系列技能
    local function 互斥技能(v)
        local 否定技能 = {"否定信仰", "高级否定信仰", "超级否定信仰"}
        if (v == "精神集中" or v == "高级精神集中" or v == "超级精神集中") and
           not self:取技能重复(编号,否定技能) then
            if v == "精神集中" and not self:取技能重复(编号,{"高级精神集中","超级精神集中"},技能组) then
                table.insert(self.参战单位[编号].已加技能, v)
            elseif v == "高级精神集中" and not self:取技能重复(编号,"超级精神集中",技能组) then
                table.insert(self.参战单位[编号].已加技能, v)
            elseif v == "超级精神集中" then
                table.insert(self.参战单位[编号].已加技能, v)
            end
        elseif (v == "神迹" or v == "高级神迹" or v == "超级神迹") and
               not self:取技能重复(编号,否定技能) then
            if v == "神迹" and not self:取技能重复(编号,{"高级神迹","超级神迹"},技能组) then
                table.insert(self.参战单位[编号].已加技能, v)
            elseif v == "高级神迹" and not self:取技能重复(编号,"超级神迹",技能组) then
                table.insert(self.参战单位[编号].已加技能, v)
            elseif v == "超级神迹" then
                table.insert(self.参战单位[编号].已加技能, v)
            end
        end
    end

    -- 处理每个技能
    for _, v in ipairs(技能组) do
        if 战斗技能[v] and not 战斗技能[v].被动 and  self.技能类型[战斗技能[v].类型] then --技能分类.临时主动[v]  then
            self:添加主动技能(self.参战单位[编号],v)
            if v == "叱咤风云" or v == "超级三昧真火" then
                table.insert(self.参战单位[编号].已加技能, v)
            elseif v == "食指大动" then
                self.参战单位[编号].食指大动 = 1
            end
        elseif 技能分类.临时被动[v] then
            self.参战单位[编号][v] = 1
        elseif 技能分类.直接添加[v] then
            table.insert(self.参战单位[编号].已加技能, v)
        elseif 技能分类.高级被动[v] and not self:取技能重复(编号,技能分类.高级被动[v],技能组) then
            table.insert(self.参战单位[编号].已加技能, v)
        elseif 技能分类.低级被动[v] and
               not self:取技能重复(编号,"高级"..v,技能组) and
               not self:取技能重复(编号,"超级"..v,技能组) then
            table.insert(self.参战单位[编号].已加技能, v)
        else
            特殊技能(v)
            互斥技能(v)
        end
    end

    -- 去重并添加被动属性
    self.参战单位[编号].已加技能 = 删除重复(self.参战单位[编号].已加技能)
    self:添加被动属性(编号)
end





function 战斗处理类:添加被动属性(编号)

    if not 编号 or not self.参战单位[编号] or not self.参战单位[编号].已加技能  or type(self.参战单位[编号].已加技能) ~= "table" then
        return
    end
    local 加成 = {
        气血 = 0, 伤害 = 0, 法伤 = 0, 防御 = 0, 法防 = 0,
        速度 = 0, 躲闪 = 0, 法连 = 0, 法暴 = 0, 连击 = 0, 必杀 = 0
    }
    local 计算合纵数量=function()
        local 数量 = 0
        for k,v in pairs(self.参战单位) do
            if v.类型 == "bb" and v.队伍 == self.参战单位[编号].队伍 and
               v.模型 ~= self.参战单位[编号].模型 then
                数量 = 数量 + 1
            end
        end
        return math.min(数量, 4)
    end
    local 技能效果 = {
        叱咤风云 = function() 加成.法连 = 加成.法连 + 10 end,
        超级三昧真火 = function() 加成.法伤 = 加成.法伤 + self.参战单位[编号].耐力 * 0.3 end,
        迟钝 = function() 加成.速度 = 加成.速度 - self.参战单位[编号].速度 * 0.2 end,
        神出鬼没 = function()
            self.参战单位[编号].隐身 = 4
            加成.伤害 = 加成.伤害 + self.参战单位[编号].伤害 * 0.1
        end,
        昼伏夜出 = function()
            self.参战单位[编号].夜战 = 2
            加成.伤害 = 加成.伤害 + self.参战单位[编号].伤害 * 0.1
        end,
        大快朵颐 = function()
            加成.连击 = 加成.连击 + 10
            加成.必杀 = 加成.必杀 + 10
        end,

        -- 驱怪系列
        驱怪 = function() self.参战单位[编号].驱怪 = 1 end,
        高级驱怪 = function() self.参战单位[编号].驱怪 = 2 end,
        超级驱怪 = function() self.参战单位[编号].驱怪 = 3 end,

        -- 夜战系列
        夜战 = function() self.参战单位[编号].夜战 = 1 end,
        高级夜战 = function()
            self.参战单位[编号].夜战 = 2
            加成.躲闪 = 加成.躲闪 + self.参战单位[编号].躲闪 * 0.2
        end,
        超级夜战 = function()
            self.参战单位[编号].夜战 = 2
            加成.伤害 = 加成.伤害 + self.参战单位[编号].伤害 * 0.1
            加成.躲闪 = 加成.躲闪 + self.参战单位[编号].躲闪 * 0.2
        end,

        -- 反击系列
        反击 = function() self.参战单位[编号].反击 = 0.5 end,
        高级反击 = function() self.参战单位[编号].反击 = 1 end,
        超级反击 = function()
            self.参战单位[编号].反击 = 1
            self.参战单位[编号].超级反击 = 1
        end,

        -- 连击系列
        连击 = function() 加成.连击 = 加成.连击 + 45 end,
        高级连击 = function() 加成.连击 = 加成.连击 + 55 end,
        超级连击 = function()
            self.参战单位[编号].超级连击 = 1
            加成.连击 = 加成.连击 + 55
        end,

        -- 飞行系列
        飞行 = function()
            加成.伤害 = 加成.伤害 + self.参战单位[编号].伤害 * 0.05
            加成.法伤 = 加成.法伤 + self.参战单位[编号].法伤 * 0.05
            加成.防御 = 加成.防御 - self.参战单位[编号].防御 * 0.2
            加成.法防 = 加成.法防 - self.参战单位[编号].法防 * 0.2
        end,
        高级飞行 = function()
            加成.伤害 = 加成.伤害 + self.参战单位[编号].伤害 * 0.05
            加成.法伤 = 加成.法伤 + self.参战单位[编号].法伤 * 0.05
            加成.防御 = 加成.防御 - self.参战单位[编号].防御 * 0.1
            加成.法防 = 加成.法防 - self.参战单位[编号].法防 * 0.1
        end,
        超级飞行 = function()
            加成.伤害 = 加成.伤害 + self.参战单位[编号].伤害 * 0.1
            加成.法伤 = 加成.法伤 + self.参战单位[编号].法伤 * 0.1
        end,

        -- 隐身系列
        隐身 = function() self.参战单位[编号].隐身 = 取随机数(1, 3) end,
        高级隐身 = function() self.参战单位[编号].隐身 = 取随机数(3, 5) end,
        超级隐身 = function()
            self.参战单位[编号].超级隐身 = 1
            self.参战单位[编号].隐身 = 取随机数(3, 5)
        end,

        -- 感知系列
        感知 = function() self.参战单位[编号].感知 = 0.45 end,
        高级感知 = function()
            self.参战单位[编号].感知 = 0.55
            加成.气血 = 加成.气血 + self.参战单位[编号].最大气血 * 0.05
        end,
        超级感知 = function()
            self.参战单位[编号].感知 = 0.55
            加成.气血 = 加成.气血 + self.参战单位[编号].最大气血 * 0.1
            if self.参战单位[编号].类型 == "bb" and self.参战单位[编号].主人 and self.参战单位[self.参战单位[编号].主人]
              and self.参战单位[self.参战单位[编号].主人].气血 > 0 then
                self.参战单位[self.参战单位[编号].主人].超级感知 = 5
            end
        end,

        -- 慧根系列
        慧根 = function() self.参战单位[编号].慧根 = 0.75 end,
        高级慧根 = function() self.参战单位[编号].慧根 = 0.5 end,
        超级慧根 = function()
            self.参战单位[编号].慧根 = 0.5
            self.参战单位[编号].超级慧根 = 1
        end,

        -- 必杀系列
        必杀 = function() 加成.必杀 = 加成.必杀 + 10 end,
        高级必杀 = function() 加成.必杀 = 加成.必杀 + 20 end,
        超级必杀 = function()
            self.参战单位[编号].超级必杀 = 1
            加成.必杀 = 加成.必杀 + 30
        end,

        -- 幸运系列
        幸运 = function() self.参战单位[编号].幸运 = 0.25 end,
        高级幸运 = function() self.参战单位[编号].幸运 = 0.5 end,
        超级幸运 = function()
            self.参战单位[编号].幸运 = 0.5
            self.参战单位[编号].超级幸运 = 1
        end,

        -- 盾气系列
        盾气 = function() self.参战单位[编号].盾气 = 1.2 end,
        高级盾气 = function() self.参战单位[编号].盾气 = 1.5 end,
        超级盾气 = function() self.参战单位[编号].盾气 = 3 end,

        -- 强力系列
        强力 = function()
            self.参战单位[编号].强力被动 = 0.2
            加成.伤害 = 加成.伤害 + self.参战单位[编号].伤害 * 0.05
        end,
        高级强力 = function()
            self.参战单位[编号].强力被动 = 0.1
            加成.伤害 = 加成.伤害 + self.参战单位[编号].伤害 * 0.1
        end,
        超级强力 = function()
            self.参战单位[编号].超级强力 = 1
            加成.伤害 = 加成.伤害 + self.参战单位[编号].伤害 * 0.15
        end,

        -- 招架系列
        招架 = function() self.参战单位[编号].招架 = 0.05 end,
        高级招架 = function() self.参战单位[编号].招架 = 0.1 end,
        超级招架 = function()
            self.参战单位[编号].招架 = 0.1
            self.参战单位[编号].超级招架 = 1
        end,

        -- 永恒系列
        永恒 = function() self.参战单位[编号].永恒 = 0.3 end,
        高级永恒 = function() self.参战单位[编号].永恒 = 0.5 end,
        超级永恒 = function() self.参战单位[编号].永恒 = 1 end,

        -- 敏捷系列
        敏捷 = function() 加成.速度 = 加成.速度 + self.参战单位[编号].速度 * 0.1 end,
        高级敏捷 = function() 加成.速度 = 加成.速度 + self.参战单位[编号].速度 * 0.2 end,
        超级敏捷 = function()
            self.参战单位[编号].超级敏捷 = 1
            加成.速度 = 加成.速度 + self.参战单位[编号].速度 * 0.3
        end,

        -- 偷袭系列
        偷袭 = function() self.参战单位[编号].偷袭 = 0.05 end,
        高级偷袭 = function() self.参战单位[编号].偷袭 = 0.1 end,
        超级偷袭 = function() self.参战单位[编号].偷袭 = 0.2 end,

        -- 魔之心系列
        魔之心 = function() self.参战单位[编号].魔之心 = 0.1 end,
        高级魔之心 = function() self.参战单位[编号].魔之心 = 0.2 end,
        超级魔之心 = function() self.参战单位[编号].魔之心 = 0.3 end,

        -- 法术连击系列
        法术连击 = function() 加成.法连 = 加成.法连 + 15 end,
        高级法术连击 = function() 加成.法连 = 加成.法连 + 30 end,
        超级法术连击 = function()
            self.参战单位[编号].超级法连 = 1
            加成.法连 = 加成.法连 + 50
        end,

        -- 法术暴击系列
        法术暴击 = function() 加成.法暴 = 加成.法暴 + 10 end,
        高级法术暴击 = function() 加成.法暴 = 加成.法暴 + 20 end,
        超级法术暴击 = function()
            self.参战单位[编号].超级法暴 = 1
            加成.法暴 = 加成.法暴 + 30
        end,

        -- 法术波动系列
        法术波动 = function()
            self.参战单位[编号].法波 = 50
            self.参战单位[编号].法术波动 = 120
        end,
        高级法术波动 = function()
            self.参战单位[编号].法波 = 50
            self.参战单位[编号].法术波动 = 140
        end,
        超级法术波动 = function()
            self.参战单位[编号].法波 = 80
            self.参战单位[编号].法术波动 = 160
        end,

        -- 进击必杀系列
        进击必杀 = function() self.参战单位[编号].进击必杀 = 1 end,
        高级进击必杀 = function() self.参战单位[编号].进击必杀 = 2 end,
        超级进击必杀 = function() self.参战单位[编号].进击必杀 = 5 end,

        -- 进击法暴系列
        进击法暴 = function() self.参战单位[编号].进击法暴 = 1 end,
        高级进击法暴 = function() self.参战单位[编号].进击法暴 = 2 end,
        超级进击法暴 = function() self.参战单位[编号].进击法暴 = 5 end,

        -- 否定信仰系列
        否定信仰 = function() self.参战单位[编号].信仰 = 1 end,
        高级否定信仰 = function() self.参战单位[编号].信仰 = 2 end,
        超级否定信仰 = function() self.参战单位[编号].信仰 = 3 end,

        -- 属性吸收系列
        水属性吸收 = function() self.参战单位[编号].水吸 = 15 end,
        高级水属性吸收 = function() self.参战单位[编号].水吸 = 30 end,
        超级水属性吸收 = function() self.参战单位[编号].水吸 = 100 end,
        雷属性吸收 = function() self.参战单位[编号].雷吸 = 15 end,
        高级雷属性吸收 = function() self.参战单位[编号].雷吸 = 30 end,
        超级雷属性吸收 = function() self.参战单位[编号].雷吸 = 100 end,
        火属性吸收 = function() self.参战单位[编号].火吸 = 15 end,
        高级火属性吸收 = function() self.参战单位[编号].火吸 = 30 end,
        超级火属性吸收 = function() self.参战单位[编号].火吸 = 100 end,
        土属性吸收 = function() self.参战单位[编号].土吸 = 15 end,
        高级土属性吸收 = function() self.参战单位[编号].土吸 = 30 end,
        超级土属性吸收 = function() self.参战单位[编号].土吸 = 100 end,

        -- 神迹系列
        神迹 = function() self.参战单位[编号].神迹 = 1 end,
        高级神迹 = function() self.参战单位[编号].神迹 = 2 end,
        超级神迹 = function() self.参战单位[编号].神迹 = 3 end,

        -- 精神集中系列
        精神集中 = function() self.参战单位[编号].精神 = 1 end,
        高级精神集中 = function()
            self.参战单位[编号].精神 = 1
            加成.法伤 = 加成.法伤 + self.参战单位[编号].法伤 * 0.1
        end,
        超级精神集中 = function()
            self.参战单位[编号].精神 = 1
            self.参战单位[编号].超级精神 = 1
            加成.法伤 = 加成.法伤 + self.参战单位[编号].法伤 * 0.1
        end,

        -- 鬼魂术系列
        鬼魂术 = function() self.参战单位[编号].鬼魂 = 5 end,
        高级鬼魂术 = function() self.参战单位[编号].鬼魂 = 5 end,

        -- 神佑复生系列
        神佑复生 = function() self.参战单位[编号].神佑 = 15 end,
        高级神佑复生 = function() self.参战单位[编号].神佑 = 30 end,

        -- 法术抵抗系列
        高级法术抵抗 = function()
            self.参战单位[编号].法伤减少 = (self.参战单位[编号].法伤减少 or 1) - 0.1
            if self.参战单位[编号].法伤减少 <= 0 then
                self.参战单位[编号].法伤减少 = 0.9
            end
        end,
        超级法术抵抗 = function()
            self.参战单位[编号].法伤减少 = (self.参战单位[编号].法伤减少 or 1) - 0.2
            if self.参战单位[编号].法伤减少 <= 0 then
                self.参战单位[编号].法伤减少 = 0.8
            end
            self.参战单位[编号].超级抵抗 = 3
        end,

        -- 防御系列
        防御 = function()
            self.参战单位[编号].防御被动 = 1
            加成.法伤 = 加成.法伤 - self.参战单位[编号].法伤 * 0.1
            加成.防御 = 加成.防御 + self.参战单位[编号].防御 * 0.08
        end,
        高级防御 = function()
            self.参战单位[编号].防御被动 = 1
            加成.法伤 = 加成.法伤 - self.参战单位[编号].法伤 * 0.1
            加成.防御 = 加成.防御 + self.参战单位[编号].防御 * 0.16
        end,
        超级防御 = function()
            self.参战单位[编号].防御被动 = 1
            加成.防御 = 加成.防御 + self.参战单位[编号].防御 * 0.25
        end,

        -- 合纵系列
        合纵 = function()
            local 数量 = 计算合纵数量()
            if 数量 > 0 then
                self.参战单位[编号].合纵 = 0.01 * 数量
            end
        end,
        高级合纵 = function()
            local 数量 = 计算合纵数量()
            if 数量 > 0 then
                self.参战单位[编号].合纵 = 0.02 * 数量
            end
        end,
        超级合纵 = function()
            local 数量 = 计算合纵数量()
            if 数量 > 0 then
                self.参战单位[编号].合纵 = 0.04 * 数量
            end
        end,

        -- 驱鬼系列
        驱鬼 = function() self.参战单位[编号].驱鬼 = (self.参战单位[编号].驱鬼 or 0) + 0.5 end,
        高级驱鬼 = function() self.参战单位[编号].驱鬼 = (self.参战单位[编号].驱鬼 or 0) + 1 end,
        超级驱鬼 = function() self.参战单位[编号].驱鬼 = (self.参战单位[编号].驱鬼 or 0) + 1.5 end,

        -- 冥思系列
        冥思 = function() self.参战单位[编号].冥思 = math.floor((self.参战单位[编号].冥思 or 0) + self.参战单位[编号].等级 / 4) end,
        高级冥思 = function() self.参战单位[编号].冥思 = math.floor((self.参战单位[编号].冥思 or 0) + self.参战单位[编号].等级 / 2) end,
        超级冥思 = function()
            self.参战单位[编号].冥思 = math.floor((self.参战单位[编号].冥思 or 0) + self.参战单位[编号].等级 / 2)
            if self.参战单位[编号].类型 == "bb" and self.参战单位[编号].主人 and self.参战单位[self.参战单位[编号].主人] and self.参战单位[self.参战单位[编号].主人].气血 > 0 then
                self.参战单位[self.参战单位[编号].主人].超级冥思 = 5
            end
        end,

        -- 再生系列
        再生 = function() self.参战单位[编号].再生 = math.floor((self.参战单位[编号].再生 or 0) + self.参战单位[编号].等级 * 2) end,
        高级再生 = function() self.参战单位[编号].再生 = math.floor((self.参战单位[编号].再生 or 0) + self.参战单位[编号].等级 * 3) end,
        超级再生 = function()
            self.参战单位[编号].超级再生 = 1
            self.参战单位[编号].再生 = math.floor((self.参战单位[编号].再生 or 0) + self.参战单位[编号].等级 * 3)
        end,

        -- 吸血系列
        吸血 = function() self.参战单位[编号].吸血 = (self.参战单位[编号].吸血 or 0) + 0.25 end,
        高级吸血 = function() self.参战单位[编号].吸血 = (self.参战单位[编号].吸血 or 0) + 0.3 end,
        超级吸血 = function()
            self.参战单位[编号].超级吸血 = 1
            self.参战单位[编号].吸血 = (self.参战单位[编号].吸血 or 0) + 0.3
        end,

        -- 反震系列
        反震 = function() self.参战单位[编号].反震 = (self.参战单位[编号].反震 or 0) + 0.25 end,
        高级反震 = function() self.参战单位[编号].反震 = (self.参战单位[编号].反震 or 0) + 0.5 end,
        超级反震 = function()
            self.参战单位[编号].超级反震 = 1
            self.参战单位[编号].反震 = (self.参战单位[编号].反震 or 0) + 0.6
        end,

        -- 毒系列
        毒 = function()
            self.参战单位[编号].低级毒 = true
            self.参战单位[编号].毒 = (self.参战单位[编号].毒 or 0) + 15
        end,
        高级毒 = function()
            self.参战单位[编号].高级毒 = true
            self.参战单位[编号].毒 = (self.参战单位[编号].毒 or 0) + 30
        end,
        超级毒 = function()
            self.参战单位[编号].超级毒 = true
            self.参战单位[编号].毒 = (self.参战单位[编号].毒 or 0) + 30
        end

        -- 浮云神马 = function()
        --     self.参战单位[编号].浮云神马 = true
        -- end,
        -- 超级浮云神马 = function()
        --     self.参战单位[编号].超级浮云 = true
        -- end






    }

    for _, 技能 in pairs(self.参战单位[编号].已加技能) do
        if 技能效果[技能] then
            技能效果[技能]()
        end
    end


    for k, v in pairs(加成) do
        if self.参战单位[编号][k] then
            self.参战单位[编号][k] = math.floor(self.参战单位[编号][k] + v)
        end
    end

    self.参战单位[编号].最大气血 = math.floor(self.参战单位[编号].最大气血 + 加成.气血)
    self.参战单位[编号].气血上限 = math.floor(self.参战单位[编号].气血上限 + 加成.气血)
end






function 战斗处理类:取技能重复(编号,技能, 技能组)
    -- 参数有效性检查
    if  not 编号 or not self.参战单位[编号] or not 技能 then
        return false
    end

    local function 检查技能(技能表, 目标)
        if not 技能表 then return false end
        for _, s in pairs(技能表) do
            if s == 目标 then
                return true
            end
        end
        return false
    end

    -- 处理技能为表的情况
    if type(技能) == "table" then
        for _, s in pairs(技能) do
            if 检查技能(self.参战单位[编号].已加技能, s) or
               (技能组 and 检查技能(技能组, s)) then
                return true
            end
        end
    -- 处理技能为字符串的情况
    elseif type(技能) == "string" then
        return 检查技能(self.参战单位[编号].已加技能, 技能) or
               (技能组 and 检查技能(技能组, 技能))
    end

    return false
end







function 战斗处理类:执行怪物召唤(编号,类型,队伍,次数)
      local id组=self:取阵亡id组(队伍)
      if not 次数 then 次数 = 1 end
      for n=1,次数 do
          local 位置组 = {}
          for i,v in ipairs(self.参战单位) do
              if v.队伍==队伍 and (v.气血>0 or v.法术状态.复活) and not v.逃跑 and not v.捕捉 then
                  位置组[v.位置] = true
              end
          end
          local 位置=0
          local id=id组[n]
          if not id then --新增位置
              id=#self.参战单位+1
              for i=1,16 do
                  if not 位置组[i] then
                      位置 = i
                      break
                  end
              end
          else
               位置 = self.参战单位[id].位置
          end
          if 位置==0 or 位置 >= 16 then
              if self.参战单位[编号].玩家id and self.参战单位[编号].玩家id~=0 then
                  self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/无法召唤更多宠物")
              end
              return
          end
          local 临时数据=self:召唤数据设置(类型,self.参战单位[编号].等级,编号)
          self.执行等待=self.执行等待+7
          self.参战单位[id]={}
          self.参战单位[id].编号 = id
          self.参战单位[id].玩家id = 0
          self.参战单位[id].队伍 = 队伍
          self.参战单位[id].位置 = 位置
          self.参战单位[id].类型 = 临时数据.类型 or "召唤"
          self.参战单位[id].分类 = 临时数据.分类 or "野怪"
          if 临时数据.角色 then
                  self.参战单位[id].类型="系统角色"
          end
          local 战斗单位 = {DeepCopy(临时数据)}
          if 类型==6 or 类型==7 then
              战斗单位.难度 = "中级"
              战斗单位.系数 = {气血=2}
          end
          self:初始怪物属性(战斗单位)
          self:加载初始属性(id,战斗单位[1])
          self:添加技能属性(id,self.参战单位[id].技能)
          self.初始属性[id] = DeepCopy(self.参战单位[id])
          if not id组[n] then
              self:设置队伍区分(队伍)
          end
          local 流程表 = {流程=39,攻击方=编号,
                    提示 = {
                        允许 = true,
                        名称 = "召唤"
                      }
            }
          流程表.挨打方 = {
              挨打方=id,
              队伍=队伍,
              数据=self:取加载信息(id),
          }
          table.insert(self.战斗流程, 流程表)
        end
end






-- function 战斗处理类:执行怪物召唤(编号,类型,队伍,次数)
--       local id组=self:取阵亡id组(队伍)
--       if not 次数 then 次数 = 1 end
--       for n=1,次数 do
--           local 位置=0
--           for i,v in ipairs(self.参战单位) do
--               if v.队伍==队伍 and (v.气血>0 or v.鬼魂) and 位置 <= v.位置 then
--                   位置 = v.位置 + 1
--               end
--           end
--           if 位置>=16 then
--               if self.参战单位[编号].玩家id and self.参战单位[编号].玩家id~=0 then
--                   self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/无法召唤更多宠物")
--               end
--               return
--           end
--           local id=id组[n]
--           if not id then --新增位置
--                id=#self.参战单位+1
--           else
--                位置 = self.参战单位[id].位置
--           end
--           local 临时数据=self:召唤数据设置(类型,self.参战单位[编号].等级,编号)
--           self.执行等待=self.执行等待+7
--           self.参战单位[id]={}
--           self.参战单位[id].玩家id=0
--           self.参战单位[id].编号=id
--           self.参战单位[id].队伍=队伍
--           self.参战单位[id].位置=位置
--           self.参战单位[id].类型=临时数据.类型 or "召唤"
--           self.参战单位[id].分类=临时数据.分类 or "野怪"
--           if 临时数据.角色 then
--                   self.参战单位[id].类型="系统角色"
--           end
--           local 战斗单位 = {DeepCopy(临时数据)}
--           if 类型==6 or 类型==7 then
--               战斗单位.难度 = "中级"
--               战斗单位.系数 = {气血=2}
--           end
--           self:初始怪物属性(战斗单位)
--           self:加载初始属性(id,战斗单位[1])
--           self:添加技能属性(id,self.参战单位[id].技能)
--           self.初始属性[id] = DeepCopy(self.参战单位[id])
--           if not id组[n] then
--               self:设置队伍区分(队伍)
--           end
--           local 流程表 = {流程=39,攻击方=编号,
--                     提示 = {
--                         允许 = true,
--                         名称 = "召唤"
--                       }
--             }
--           流程表.挨打方 = {
--               挨打方=id,
--               队伍=队伍,
--               数据=self:取加载信息(id),
--           }
--           table.insert(self.战斗流程, 流程表)
--         end
-- end





function 战斗处理类:召唤数据设置(类型,等级,编号)
    if not 等级 or 等级<1 then 等级=1 end
  if 类型==1 then --星宿的天兵
        return {
          名称="喽罗",
          模型="天兵",
          等级=等级,
          主动技能=取随机法术(3)
        }
  elseif 类型==2 then
          return {
              名称="怨灵",
              模型="进阶幽灵",
              等级=等级
            }
  elseif 类型==3 then
        return {
            名称="幻魔",
            模型="巴蛇",
            等级=等级
          }
  elseif 类型==4 then
          return {
                名称="猴子猴孙",
                模型="巨力神猿",
                伤害=1,--等级*10
                等级=等级
            }
  elseif 类型==5 then
        return {
            名称="灵感分身小弟",
            模型="神天兵",
            角色=true,
            武器=取武器数据("雷神",100),
            等级=等级,
            技能={"高级感知"},
            主动技能=取随机法术(5)
          }
  elseif 类型==6 then
          return {
                名称="牛虱",
                模型="牛虱",
                等级=等级,
                技能={"高级必杀","高级连击","高级强力","高级感知","高级偷袭"}
              }
  elseif 类型==7 then
          return {
              名称="牛幺",
              模型="牛幺",
              等级=等级,
              技能={"法术连击","法术暴击"},
              主动技能={"烈火"}
          }
  elseif 类型==8 then
        return {
          名称="野鬼喽罗",
          模型="野鬼",
          等级=65,
          技能={},
          主动技能=取随机固伤法术(8)
        }
  elseif 类型==9 then --九耀星君
        return {
              名称="护法天兵",
              模型="天兵",
              等级=self.参战单位[编号].等级-5,
              伤害=self.参战单位[编号].伤害,
              气血=self.参战单位[编号].最大气血,
              法伤=self.参战单位[编号].法伤,
              法防=self.参战单位[编号].法防,
              速度=self.参战单位[编号].速度,
              防御=self.参战单位[编号].防御,
          }
  elseif 类型==10 then --挑战GM召唤
          return self:取挑战GM召唤(编号)
  elseif 类型==11 then
          return {
              名称="牛头",
              模型="牛头",
              等级=等级,
              技能={"高级感知"},
              主动技能=取随机法术(5)
            }
  elseif 类型==12 then
        return {
              名称="野鬼",
              模型="野鬼",
              等级=等级,
              技能={"高级感知"},
              主动技能=取随机法术(5)
        }
  end
end



function 战斗处理类:取挑战GM召唤(编号)
     local 临时加载={"点杀","法术","群杀","固伤","封印","辅助"}
     local 召唤单位={
          名称="挑战GM分身",
          模型="剑侠客",
          愤怒=99999,
          武器染色方案=2065,
          武器染色组={[1]=1,[2]=0},
          武器 = 取武器数据("鸣鸿",160),
          锦衣={[1]={名称="冰寒绡月白"}},
          等级=self.参战单位[编号].等级-5,
          伤害=self.参战单位[编号].伤害,
          气血=self.参战单位[编号].最大气血,
          法伤=self.参战单位[编号].法伤,
          法防=self.参战单位[编号].法防,
          速度=self.参战单位[编号].速度,
          防御=self.参战单位[编号].防御,
          角色=true,
          饰品=true,
          攻击修炼 = 30,
          防御修炼 = 30,
          法术修炼 = 30,
          抗法修炼 = 30,
          技能={"高级感知"},
          加载 = 临时加载[取随机数(1, #临时加载)]
      }
    return 召唤单位
 end






function 战斗处理类:召唤计算(编号)
      local id = self.参战单位[编号].召唤兽
      local 目标 = self.参战单位[编号].指令.目标
      local 玩家id= self.参战单位[编号].玩家id
      if 玩家数据[玩家id] == nil then
        print("玩家数据玩家ID为NIL,玩家ID为"..玩家id)
        return
      elseif 玩家数据[玩家id].召唤兽.数据[目标] == nil then
        print("召唤兽为NIL,目标为"..目标)
        return
      elseif 玩家数据[玩家id].召唤兽.数据[目标].等级 == nil then
        print("召唤时等级为NIL,召唤目标为"..目标)
        return
      end
      self.参战单位[编号].召唤数量=self.参战单位[编号].召唤数量 or {}
      if id~=nil and self.参战单位[id].法术状态.复活~=nil then
          self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/你有召唤兽尚在复活中，暂时无法召唤新的召唤兽")
          return
      elseif #self.参战单位[编号].召唤数量>=7 then
            self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/你在本次战斗中可召唤的数量已达上限")
            return
      elseif 玩家数据[玩家id].召唤兽.数据[目标].参战信息 then
            self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/出战中")
            return
      -- elseif 玩家数据[玩家id].召唤兽.数据[目标].参战等级>玩家数据[玩家id].角色.数据.等级 then
      --   self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/你不能召唤参战等级高于你的召唤兽")
      --   return
      elseif 玩家数据[玩家id].召唤兽.数据[目标].寿命<=50 then
              self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/你的召唤兽由于寿命过低，不愿意参战")
            return
      elseif 玩家数据[玩家id].召唤兽.数据[目标].等级 > 玩家数据[玩家id].角色.数据.等级+10 then
            self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/以你目前的实力还无法驾驭该等级的召唤兽")
            return
      end
      for n=1,#self.参战单位[编号].召唤数量 do
        if self.参战单位[编号].召唤数量[n]==目标 then
            self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/这只召唤兽已经出战过了")
            return
        end
      end
      self.执行等待=self.执行等待+5
      if id==nil then
          self:设置队伍区分(self.参战单位[编号].队伍)
          id=#self.参战单位+1
      else
          local bb编号X=玩家数据[玩家id].召唤兽:取编号(self.参战单位[id].认证码)
          玩家数据[玩家id].召唤兽.数据[bb编号X].参战信息=nil
      end
      self.参战单位[id]={}
      self.参战单位[id]=玩家数据[玩家id].召唤兽:获取指定数据(目标)
      self.参战单位[id].队伍=self.参战单位[编号].队伍
      self.参战单位[id].位置=self.参战单位[编号].位置+5
      self.参战单位[id].类型="bb"
      self.参战单位[id].主人=编号
      self.参战单位[id].编号 = id
      self.参战单位[id].玩家id=玩家id
      self.参战单位[id].附加阵法=self.参战单位[编号].附加阵法
      self.参战单位[id].自动战斗 = self.参战单位[编号].自动战斗
      self.参战单位[编号].召唤兽 = id
      self.参战单位[编号].召唤数量[#self.参战单位[编号].召唤数量+1]=目标
      if not 玩家数据[玩家id].召唤兽.数据[目标].自动指令 then
          玩家数据[玩家id].召唤兽.数据[目标].自动指令={下达=false,类型="攻击",目标=0,敌我=0,参数="",附加=""}
          self.参战单位[id].自动指令={下达=false,类型="攻击",目标=0,敌我=0,参数="",附加=""}
      end
      self:添加宝宝法宝属性(id,玩家id)
      if self.参战单位[编号].子角色操作 ~= nil then
          local 操作单位 = self:取参战编号(self.参战单位[编号].子角色操作, "角色")
          if self.参战单位[编号].子角色操作 == self.参战单位[操作单位].玩家id then
              for k = #self.参战单位[操作单位].操作角色, 1, -1 do
                  if self.参战单位[self.参战单位[操作单位].操作角色[k]] == nil then
                      table.remove(self.参战单位[操作单位].操作角色, k)
                  end
              end
              local 找到 = true
              for k = 1, #self.参战单位[操作单位].操作角色 do
                  if self.参战单位[操作单位].操作角色[k] == id then
                      找到 = false
                      break
                  end
              end
              if 找到 then
                  self.参战单位[操作单位].操作角色[#self.参战单位[操作单位].操作角色 + 1] = id
              end
          end
      end

      玩家数据[玩家id].角色.数据.参战宝宝={}
      玩家数据[玩家id].角色.数据.参战宝宝=DeepCopy(玩家数据[玩家id].召唤兽:取存档数据(目标))
      玩家数据[玩家id].角色.数据.参战信息=1
      玩家数据[玩家id].召唤兽.数据[目标].参战信息=1
      发送数据(玩家数据[玩家id].连接id,18,玩家数据[玩家id].角色.数据.参战宝宝)
      if self.参战单位[编号].灵宝青狮獠牙~=nil then
            if not self.参战单位[id].原最大气血 then
                self.参战单位[id].原最大气血 = self.参战单位[id].最大气血
            end
            self.参战单位[id].最大气血 = math.floor(self.参战单位[id].原最大气血*(1-self.参战单位[编号].灵宝青狮獠牙/100))
            if self.参战单位[id].气血 > self.参战单位[id].最大气血 then
              self.参战单位[id].气血 = self.参战单位[id].最大气血
            end
      end
      self:单独重置属性(id)
      local 流程表 = {流程=39,攻击方=编号}
      流程表.挨打方 = {
          挨打方=id,
          数据=self:取加载信息(id),
          队伍=self.参战单位[编号].队伍,
      }
      table.insert(self.战斗流程, 流程表)
      if self.参战单位[id].隐身 then
            self:增益技能计算(id,"修罗隐身",self.参战单位[id].等级,nil,self.参战单位[id].隐身,1)
      end
      if self.参战单位[id].盾气~=nil then
            self:增益技能计算(id,"盾气",self.参战单位[id].等级,nil,self.参战单位[id].盾气,1)
      end
      if self.参战单位[id].模型=="小精灵" or self.参战单位[id].模型=="进阶小精灵" then
         self:治疗技能计算(id,"峰回路转",self.参战单位[id].等级)
      elseif self.参战单位[id].模型=="鲲鹏" or self.参战单位[id].模型=="进阶鲲鹏" then
            self:法攻技能计算(id,"扶摇万里",self.参战单位[id].等级)
      end
      if self.参战单位[编号].奇经八脉.长啸 then
         self:添加状态("狂怒",编号,编号,self.参战单位[编号].等级)
         self.参战单位[编号].法术状态.狂怒.回合 = 4
      end
      if self.回合数>=2 then
          if self.参战单位[id].特性 ~= nil then
              self:添加状态特性(id)
          end
          if self.参战单位[id].进击必杀 ~= nil then
                self:添加状态("进击必杀",id,id,self.参战单位[id].进击必杀)
          end
          if self.参战单位[id].进击法暴 ~= nil then
                self:添加状态("进击法暴",id,id,self.参战单位[id].进击法暴)
          end
      end
end










function 战斗处理类:单独重置属性(n)
          self:加载初始属性(n,self.参战单位[n])
          if self.参战单位[n].类型~="角色"  then
                    local 临时技能=DeepCopy(self.参战单位[n].技能)
                    if self.参战单位[n].超级赐福~=nil then
                        local 随机编号=取随机数(1,4)
                        local 随机名称= self.参战单位[n].超级赐福[随机编号]
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
                            self.参战单位[n].超级进化=随机名称
                        end
                    end
                    if self.参战单位[n].法术认证~=nil then
                        for k,v in ipairs(self.参战单位[n].法术认证) do
                            if v=="上古灵符" or v=="月光" or v=="死亡召唤" or v=="水攻" or v=="落岩"
                              or v=="雷击" or v=="烈火" or v=="地狱烈火" or v=="奔雷咒" or v=="水漫金山"
                              or v=="泰山压顶" or v=="善恶有报" or v=="壁垒击破" or v=="惊心一剑"
                              or v=="夜舞倾城" or v=="力劈华山" then
                                table.insert(临时技能,v)
                            end
                        end
                    end
                    if self.参战单位[n].装备 and self.参战单位[n].装备[1] and self.参战单位[n].装备[2] and self.参战单位[n].装备[3] then
                        if self.参战单位[n].装备[1].套装效果  and self.参战单位[n].装备[2].套装效果  and self.参战单位[n].装备[3].套装效果 then
                            if self.参战单位[n].装备[1].套装效果[2] == self.参战单位[n].装备[2].套装效果[2] and self.参战单位[n].装备[1].套装效果[2] == self.参战单位[n].装备[3].套装效果[2] then
                                  if self.参战单位[n].装备[1].套装效果[1] == "追加法术" then
                                        self.参战单位[n].追加法术={[1]={名称=self.参战单位[n].装备[1].套装效果[2],等级=self.参战单位[n].等级}}
                                        self.参战单位[n].追加概率=25
                                  elseif self.参战单位[n].装备[1].套装效果[1] == "附加状态" then
                                        table.insert(临时技能,self.参战单位[n].装备[1].套装效果[2])
                                  end
                            end
                        end
                    end
                    if self.参战单位[n].统御 ~= nil then
                        local 坐骑编号 = self.参战单位[n].统御
                        local 玩家id = self.参战单位[n].玩家id
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
                    self:添加技能属性(n,临时技能)
                    if self.参战单位[n].类型~="孩子 "  then
                          self:添加内丹属性(n,self.参战单位[n].内丹数据)
                    end
                    self.参战单位[n].攻击修炼=玩家数据[self.参战单位[n].玩家id].角色.数据.bb修炼.攻击控制力[1]
                    self.参战单位[n].法术修炼=玩家数据[self.参战单位[n].玩家id].角色.数据.bb修炼.法术控制力[1]
                    self.参战单位[n].防御修炼=玩家数据[self.参战单位[n].玩家id].角色.数据.bb修炼.防御控制力[1]
                    self.参战单位[n].抗法修炼=玩家数据[self.参战单位[n].玩家id].角色.数据.bb修炼.抗法控制力[1]
          end
          self.初始属性[n] = DeepCopy(self.参战单位[n])
end


function 战斗处理类:捕捉计算(编号)
  if self.战斗类型~=100001 and self.战斗类型~=100005 and self.战斗类型~=100007
    and self.战斗类型~=100221 and self.战斗类型~=100225 then
    return
  end
  local 目标=self.参战单位[编号].指令.目标

  if not self:取目标状态(编号,目标,1) then
    self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/目标当前无法被捕获")
    return
  elseif self.参战单位[目标].类型=="角色" or self.参战单位[目标].类型=="召唤" then
  self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/目标当前无法被捕获!")
  return
  elseif self.参战单位[编号].自动战斗 then
  self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/自动状态无法抓宠")
  return
  elseif self.参战单位[目标].精灵 then
    self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/你无法捕获这样的目标")
    return
      elseif self.参战单位[目标].队伍~=0 then
    self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/你无法捕获这样的目标")
    return
  -- elseif self.参战单位[目标].参战等级~=nil and self.参战单位[目标].参战等级 > self.参战单位[编号].等级 then
  --   -- elseif self.参战单位[目标].参战等级~=nil and self.参战单位[目标].参战等级 >= 125 then
  --   self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/你目前等级无法捕获这样的目标")
  --   return
  elseif self.参战单位[编号].魔法<math.floor(self.参战单位[目标].等级*0.5+20) then
    self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/你没有足够的魔法")
    return
  elseif 玩家数据[self.参战单位[编号].玩家id].召唤兽:是否携带上限() then
    self:添加提示(self.参战单位[编号].玩家id,编号,"#Y/你当前无法携带更多的召唤兽")
    return
  end
  self.执行等待=self.执行等待+10
  self:减少魔法(编号,math.floor(self.参战单位[目标].等级*0.5+20))
  local 流程表 = {流程=42,攻击方=编号,挨打方={挨打方=目标}}
  local 初始几率=20
  初始几率=初始几率+(1-self.参战单位[目标].气血/self.参战单位[目标].最大气血)*100+self.参战单位[目标].猎术修炼*3
  if self.参战单位[编号].符石技能.心灵手巧 then
    初始几率=初始几率+self.参战单位[编号].符石技能.心灵手巧
  end
  流程表.宝宝=玩家数据[self.参战单位[编号].玩家id].角色.数据.宠物.模型
  流程表.名称=玩家数据[self.参战单位[编号].玩家id].角色.数据.宠物.名称
  if self.战斗类型==100225 then
    初始几率 = 初始几率/2
  end

  if 取随机数(1,220)<=初始几率 then
    流程表.捕捉成功=true
    if self.战斗类型==100225 then
       玩家数据[self.参战单位[编号].玩家id].召唤兽:添加召唤兽(self.参战单位[目标].模型,self.参战单位[目标].模型,"神兽")
    else
       玩家数据[self.参战单位[编号].玩家id].召唤兽:添加召唤兽(self.参战单位[目标].模型,self.参战单位[目标].模型,self.参战单位[目标].分类,nil,self.参战单位[目标].等级)
    end
    self.参战单位[目标].气血=0
    self.参战单位[目标].捕捉=true
    流程表.目标=self.参战单位[目标].名称
  end
  table.insert(self.战斗流程,流程表)

end

function 战斗处理类:取阵法克制(攻击方, 挨打方)
    local 攻击阵法 = self.参战单位[攻击方].附加阵法 or "普通"
    local 挨打阵法 = self.参战单位[挨打方].附加阵法 or "普通"
    local 阵法克制表 = {
        普通 = {
            普通 = 0,
            天覆阵 = 0.05,
            地载阵 = -0.05,
            风扬阵 = 0.05,
            云垂阵 = -0.05,
            龙飞阵 = 0.05,
            虎翼阵 = -0.05,
            鸟翔阵 = 0.05,
            蛇蟠阵 = -0.05,
            鹰啸阵 = 0.05,
            八卦阵 = 0,
            雷绝阵 = -0.05
        },
        天覆阵 = {
            普通 = -0.05,
            天覆阵 = 0,
            地载阵 = -0.1,
            风扬阵 = 0.1,
            云垂阵 = 0.05,
            龙飞阵 = -0.1,
            虎翼阵 = 0.05,
            鸟翔阵 = -0.05,
            蛇蟠阵 = 0.1,
            鹰啸阵 = -0.05,
            八卦阵 = 0,
            雷绝阵 = 0.05
        },
        地载阵 = {
            普通 = 0.05,
            天覆阵 = 0.1,
            地载阵 = 0,
            风扬阵 = -0.1,
            云垂阵 = -0.05,
            龙飞阵 = 0.05,
            虎翼阵 = -0.1,
            鸟翔阵 = 0.1,
            蛇蟠阵 = -0.05,
            鹰啸阵 = 0.1,
            八卦阵 = 0,
            雷绝阵 = -0.1
        },
        风扬阵 = {
            普通 = -0.05,
            天覆阵 = -0.1,
            地载阵 = 0.1,
            风扬阵 = 0,
            云垂阵 = 0.05,
            龙飞阵 = 0.05,
            虎翼阵 = 0.1,
            鸟翔阵 = -0.1,
            蛇蟠阵 = -0.05,
            鹰啸阵 = -0.1,
            八卦阵 = 0,
            雷绝阵 = 0.1
        },
        云垂阵 = {
            普通 = 0.05,
            天覆阵 = -0.05,
            地载阵 = 0.05,
            风扬阵 = -0.05,
            云垂阵 = 0,
            龙飞阵 = 0.1,
            虎翼阵 = 0.1,
            鸟翔阵 = -0.1,
            蛇蟠阵 = -0.1,
            鹰啸阵 = -0.1,
            八卦阵 = 0,
            雷绝阵 = 0.1
        },
        龙飞阵 = {
            普通 = -0.05,
            天覆阵 = 0.1,
            地载阵 = -0.05,
            风扬阵 = -0.05,
            云垂阵 = -0.1,
            龙飞阵 = 0,
            虎翼阵 = 0.05,
            鸟翔阵 = 0.05,
            蛇蟠阵 = 0.05,
            鹰啸阵 = 0.1,
            八卦阵 = 0,
            雷绝阵 = -0.1
        },
        虎翼阵 = {
            普通 = 0.05,
            天覆阵 = -0.05,
            地载阵 = 0.1,
            风扬阵 = -0.1,
            云垂阵 = -0.1,
            龙飞阵 = -0.05,
            虎翼阵 = 0,
            鸟翔阵 = 0.1,
            蛇蟠阵 = 0.05,
            鹰啸阵 = 0.05,
            八卦阵 = 0,
            雷绝阵 = -0.05
        },
        鸟翔阵 = {
            普通 = -0.05,
            天覆阵 = 0.05,
            地载阵 = -0.1,
            风扬阵 = 0.1,
            云垂阵 = 0.1,
            龙飞阵 = -0.05,
            虎翼阵 = -0.1,
            鸟翔阵 = 0,
            蛇蟠阵 = 0.05,
            鹰啸阵 = -0.05,
            八卦阵 = 0,
            雷绝阵 = 0.05
        },
        蛇蟠阵 = {
            普通 = 0.05,
            天覆阵 = -0.1,
            地载阵 = 0.05,
            风扬阵 = 0.05,
            云垂阵 = 0.1,
            龙飞阵 = -0.05,
            虎翼阵 = -0.05,
            鸟翔阵 = -0.05,
            蛇蟠阵 = 0,
            鹰啸阵 = 0.05,
            八卦阵 = 0,
            雷绝阵 = -0.05
        },
        鹰啸阵 = {
            普通 = -0.05,
            天覆阵 = 0.05,
            地载阵 = -0.1,
            风扬阵 = 0.1,
            云垂阵 = 0.1,
            龙飞阵 = -0.1,
            虎翼阵 = -0.05,
            鸟翔阵 = 0.05,
            蛇蟠阵 = -0.05,
            鹰啸阵 = 0,
            八卦阵 = 0,
            雷绝阵 = -0.05
        },
        八卦阵 = {
            普通 = 0,
            天覆阵 = 0,
            地载阵 = 0,
            风扬阵 = 0,
            云垂阵 = 0,
            龙飞阵 = 0,
            虎翼阵 = 0,
            鸟翔阵 = 0,
            蛇蟠阵 = 0,
            鹰啸阵 = 0,
            八卦阵 = 0,
            雷绝阵 = 0
        },        
        雷绝阵 = {
            普通 = 0.05,
            天覆阵 = -0.05,
            地载阵 = 0.1,
            风扬阵 = -0.1,
            云垂阵 = -0.1,
            龙飞阵 = 0.1,
            虎翼阵 = 0.05,
            鸟翔阵 = -0.05,
            蛇蟠阵 = 0.05,
            鹰啸阵 = -0.05,
            八卦阵 = 0,
            雷绝阵 = 0
        }
    }
    return 阵法克制表[挨打阵法][攻击阵法] or 0
end





function 战斗处理类:加载系统角色(队伍id)
      local 单位组 = {}
      if self.战斗类型==110013 then
        单位组[1]={
                位置=11,
                名称="程咬金",
                模型="程咬金",
                主动技能={"烟雨剑法","破釜沉舟","杀气诀"},
                发言 = "#G/这些败类\n我要让你们\n#Y死无葬身之地#4"
        }
        单位组[2]={
                位置=12,
                染色方案=2,
                模型="剑侠客",
                名称="大唐首席弟子",
                染色组={[1]=1,[2]=3,[3]=3,序号=3710},
                武器={名称="四法青云",子类=3,级别限制=140},
                主动技能={"烟雨剑法","后发制人"},

        }
        for k,v in pairs(单位组) do
              v.等级 = 70
              v.队伍 = 队伍id
              v.名称 = v.模型
              v.气血 = 100000
              v.不可封印 = true
              v.同门单位 = true
              v.类型 = "召唤"
          end
          self:加载指定单位(单位组)
      elseif self.战斗类型==100017 then
              单位组[1]={
                位置=3,
                等级=10,
                队伍=队伍id,
                同门单位=true,
                类型="系统角色",
                名称="苦战中的同门",
                模型=任务数据[self.任务id].模型,
              }
              self:加载指定单位(单位组)
      elseif self.战斗类型==110005 then
              local 编号 = 0
             for n=13,14 do
                编号 = 编号 + 1
                单位组[编号]={
                  位置=n,
                  模型="僵尸",
                  名称="海难者亡魂",
                  主动技能={"善恶有报","弱点击破"},
                }
             end
             编号 = 编号 + 1
             单位组[编号]={
                  位置=11,
                  模型="小毛头",
                  名称="雷黑子鬼魂",
                  主动技能={"后发制人","烟雨剑法"},
                  发言 = "#G/妖风\n复仇的时候\n到了"
                }
            编号 = 编号 + 1
            单位组[编号]={
                  位置=12,
                  模型="野鬼",
                  名称="商人的鬼魂",
                  主动技能={"尸腐毒","判官令"},
                  发言 = "#G/少侠不用怕\n我们来助你\n干掉他吧#91"
                }
            for k,v in pairs(单位组) do
                v.等级 = 10
                v.类型 = "召唤"
                v.队伍 = 队伍id
                v.名称 = v.模型
                v.不可封印 = true
                v.同门单位 = true
            end
            self:加载指定单位(单位组)
      elseif self.战斗类型==110002 then
            单位组[1]={
                位置=2,
                模型="二郎神",
                技能={"鬼魂术"},
                主动技能={"破釜沉舟","烟雨剑法"}
              }
              单位组[2]={
                位置=3,
                模型="镇元大仙",
                技能={"鬼魂术"},
                主动技能={"飘渺式","烟雨剑法"}
              }
              单位组[3]={
                位置=4,
                名称="地涌夫人",
                模型="地涌夫人",
                技能={"鬼魂术"},
                主动技能={"其徐如林","其疾如风","不动如山 ","侵掠如火","夺命咒"}
              }
              单位组[4]={
                位置=5,
                模型="地涌夫人",
                技能={"鬼魂术","超级法术连击"},
                主动技能={"落叶萧萧","破血狂攻"}
              }
              单位组[5]={
                位置=7,
                模型="东海龙王",
                技能={"鬼魂术","超级法术连击"},
                主动技能={"龙卷雨击","龙腾"}
              }
              单位组[6]={
                位置=8,
                模型="空度禅师",
                技能={"鬼魂术","超级法术连击"},
                主动技能={"唧唧歪歪","推气过宫"}
              }
               单位组[7]={
                位置=9,
                模型="牛魔王",
                技能={"鬼魂术","超级法术连击"},
                主动技能={"飞砂走石","剑荡四方"}
              }
              单位组[8]={
                位置=10,
                模型="大大王",
                技能={"鬼魂术","超级法术连击"},
                主动技能={"鹰击","连环击"}
              }
              for k,v in pairs(单位组) do
                  v.等级 = 175
                  v.类型 = "召唤"
                  v.队伍 = 队伍id
                  v.名称 = v.模型
                  v.不可封印 = true
                  v.同门单位 = true
              end
            self:加载指定单位(单位组)
   end

end
