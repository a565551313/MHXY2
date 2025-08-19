-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2025-04-04 10:27:03
-- @最后修改来自: baidwwy
-- @Last Modified time: 2025-07-30 22:19:56


function 战斗处理类:取战斗状态(单位)
        local 数据 = {状态={},冷却={}}
        for k,v in pairs(单位.法术状态) do
            数据.状态[k]={回合=v.回合,护盾值=v.护盾值}
        end
        if 单位.门派=="凌波城" then -------------------特效状态
            数据.状态.战意=单位.战意
            if 单位.经脉流派 =="灵霄斗士" then
                数据.状态.超级战意=单位.超级战意
            end
         elseif 单位.门派=="神木林" then
                if 单位.经脉流派 =="灵木药宗" then
                    数据.状态.灵药红=单位.灵药.红
                    数据.状态.灵药蓝=单位.灵药.蓝
                    数据.状态.灵药黄=单位.灵药.黄
                else
                     数据.状态.风灵=单位.风灵
                end
        elseif 单位.门派=="方寸山" and 单位.经脉流派 =="五雷正宗" then
                数据.状态.符咒=单位.符咒
                数据.状态.雷法崩裂=单位.雷法.雷法崩裂
                数据.状态.雷法震煞=单位.雷法.雷法震煞
                数据.状态.雷法坤伏=单位.雷法.雷法坤伏
                数据.状态.雷法翻天=单位.雷法.雷法翻天
                数据.状态.雷法倒海=单位.雷法.雷法倒海
        elseif 单位.门派=="普陀山" and 单位.经脉流派 =="落伽神女" then
                数据.状态.五行珠金=单位.五行珠.金
                数据.状态.五行珠木=单位.五行珠.木
                数据.状态.五行珠水=单位.五行珠.水
                数据.状态.五行珠火=单位.五行珠.火
                数据.状态.五行珠土=单位.五行珠.土
        elseif 单位.门派=="五庄观" and 单位.经脉流派 =="万寿真仙"  then
                数据.状态.人参娃娃=单位.人参娃娃
        elseif 单位.门派=="大唐官府" and 单位.经脉流派 =="无双战神"  then
                数据.状态.剑意=单位.剑意
        end

        数据.气血={
                  气血=单位.气血,
                  魔法=单位.魔法,
                  愤怒=单位.愤怒,
                  气血上限=单位.气血上限,
                  最大气血=单位.最大气血,
                  最大魔法=单位.最大魔法
        }
        for k,v in pairs(战斗技能) do
            if v.冷却 and 单位[k] then
                数据.冷却[k] = 单位[k]
            end
        end

        return 数据
end







function 战斗处理类:逃跑计算(编号, 附加几率)
    if self.参战单位[编号].气血 <= 0 then return end
    if self.参战单位[编号].类型 == "角色" and self:取玩家战斗()  then
        self:添加提示(self.参战单位[编号].玩家id, 编号, "#Y/比武不能逃跑！")
        return
    end
    local 成功 = false
    local 几率 = 附加几率 or 30
    if self.参战单位[编号].指令.类型 == "逃跑" and (self.参战单位[编号].法术状态.捆仙绳 or self.参战单位[编号].法术状态.缚妖索) then
        几率 = 几率 - 15
    end
    if self.参战单位[编号].指令.参数 == "兵解符" then
        几率 = 0
    end
    成功 = 取随机数(1, 100) >= 几率
    self.执行等待 = self.执行等待 + 10
    if 成功 then
        self:处理逃跑成功(编号)
    end
    self:添加逃跑战斗流程(编号, 成功)
    if 成功 and self.参战单位[编号].队伍~=0 then
        self:处理召唤兽逃跑(编号)
    end
end


function 战斗处理类:处理逃跑成功(编号)
    self.参战单位[编号].逃跑 = true
    if self.参战单位[编号].类型 == "角色" and self.参战单位[编号].操作角色 and #self.参战单位[编号].操作角色 > 0 then
        for i = 1, #self.参战单位[编号].操作角色 do
            local 角色 = self.参战单位[编号].操作角色[i]
            if self.参战单位[角色].气血 > 0 then
                self.参战单位[角色].逃跑 = true
                if self.参战单位[角色].类型 == "角色" then
                    self:添加角色逃跑流程(角色)
                    self:逃跑事件处理(self.参战单位[角色].玩家id)
                end
            end
        end
    end
end


function 战斗处理类:添加逃跑战斗流程(编号, 成功)
    local 结束 = false
    if 成功 and self.参战单位[编号].类型 == "角色" then
        结束 = true
        -- 计算玩家数量
        local 玩家数量 = 0
        for _ in pairs(self.参战玩家) do
            玩家数量 = 玩家数量 + 1
        end
        if 玩家数量 == 1 then
            self.全局结束 = true
        end
    end

    local 流程数据 = {
        流程 = 44,
        攻击方 = 编号,
        id = self.参战单位[编号].类型 == "角色" and self.参战单位[编号].玩家id or 0,
        成功 = 成功,
        结束 = 结束
    }

    if self.参战单位[编号].队伍 == 0 and self.参战单位[编号].捉鬼变异 then
        任务数据[self.任务id].变异奖励 = true
    end

    table.insert(self.战斗流程, 流程数据)
end


function 战斗处理类:处理召唤兽逃跑(编号)
    if self.参战单位[编号].类型 ~= "角色" then
        local 玩家id = self.参战单位[编号].玩家id
        for n = 1, #玩家数据[玩家id].召唤兽.数据 do
            if 玩家数据[玩家id].召唤兽.数据[n].认证码 == 玩家数据[玩家id].角色.数据.参战宝宝.认证码 then
                玩家数据[玩家id].召唤兽.数据[n].参战信息 = nil
                玩家数据[玩家id].角色.数据.参战宝宝 = {}
                玩家数据[玩家id].角色.数据.参战信息 = nil
                发送数据(玩家数据[玩家id].连接id, 18, 玩家数据[玩家id].角色.数据.参战宝宝)
                break
            end
        end
    else
        -- 处理主角色的召唤兽
        if self.参战单位[编号].召唤兽 and self.参战单位[self.参战单位[编号].召唤兽] and self.参战单位[self.参战单位[编号].召唤兽].气血 > 0 then
            self.战斗流程[#self.战斗流程].追加 = self.参战单位[编号].召唤兽
            self.参战单位[self.参战单位[编号].召唤兽].逃跑 = true
        end

        -- 处理子角色操作
        if self.参战单位[编号].子角色操作 and self.参战单位[编号].气血 > 0 then
            local 操作单位 = self:取参战编号(self.参战单位[编号].子角色操作, "角色")
            if 操作单位 and self.参战单位[操作单位] and self.参战单位[操作单位].操作角色 then
                self:移除操作角色(操作单位, 编号)
                self:逃跑事件处理(self.参战单位[编号].玩家id)
            end
        end
    end
end

function 战斗处理类:移除操作角色(操作单位, 编号)
    for i = #self.参战单位[操作单位].操作角色, 1, -1 do
        if self.参战单位[操作单位].操作角色[i] == 编号 then
            table.remove(self.参战单位[操作单位].操作角色, i)
        end
    end

    if self.参战单位[编号].召唤兽 then
        local 召唤编号 = self:取参战编号(self.参战单位[编号].玩家id, "bb")
        for i = #self.参战单位[操作单位].操作角色, 1, -1 do
            if self.参战单位[操作单位].操作角色[i] == 召唤编号 then
                table.remove(self.参战单位[操作单位].操作角色, i)
            end
        end
    end
end

function 战斗处理类:添加角色逃跑流程(编号)
    local 流程数据 = {
        流程 = 44,
        攻击方 = 编号,
        id = self.参战单位[编号].玩家id,
        成功 = true,
        结束 = false
    }

    if self.参战单位[编号].召唤兽 then
        流程数据.追加 = self.参战单位[编号].召唤兽
    end

    table.insert(self.战斗流程, 流程数据)
end


function 战斗处理类:逃跑事件处理(id)
      ---------摩托修改增加押镖任务逃跑就会失败
      if 战斗准备类.战斗盒子[玩家数据[id].战斗].战斗类型 == 110038 then--普通攻击
          玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(300))
          玩家数据[id].角色.押镖间隔=os.time()+180
          玩家数据[id].角色.数据.跑镖=nil
          添加最后对话(id,format("任务失败,押镖任务不能逃跑,您三分钟之内无法再次领取押镖任务"))
      end
      local 玩家数量 = 0

      for k,v in pairs(self.参战玩家) do
          if v.id == id then
              table.remove(self.参战玩家,k)
          else
              玩家数量 = 玩家数量 + 1
          end
      end
      if 玩家数量<=0 then
            self.回合进程="结束回合"
            self:战斗失败处理(id,"逃跑")
            self.结束条件=true
            for i,v in pairs(self.观战玩家) do
                if 玩家数据[i] then
                    发送数据(玩家数据[i].连接id,5505)
                    玩家数据[i].战斗=0
                    玩家数据[i].观战=nil
                    玩家数据[i].遇怪时间=os.time()+取随机数(10,20)
                    if 玩家数据[i].自动遇怪 then
                        玩家数据[i].自动遇怪=os.time()
                    end
                end
            end
            if self.任务id~=nil and self.任务id~=0 and 任务数据[self.任务id] ~= nil then
               任务数据[self.任务id].战斗=nil
            end
      end
      self:还原单位流程(id)
      if 玩家数据[id].队伍 and 玩家数据[id].队伍~=0 then
        队伍处理类:退出队伍(id)
      end
      if 玩家数据[id] then
        发送数据(玩家数据[id].连接id,5505)
        地图处理类:设置战斗开关(id)
      end
end

function 战斗处理类:结束战斗处理(胜利id,失败id,系统) --系统为不计算失败惩罚
      if 系统==nil then
         self:战斗胜利处理(胜利id,失败id,假人数据)
         self:战斗失败处理(失败id,nil,胜利id)
      end
      self:还原单位属性()
      self:退出发送流程()
end


function 战斗处理类:战斗失败处理(失败id, 是否逃跑, 胜利id)
    if not 失败id or 失败id == 0 then return end
    local id组 = {}
    self.失败玩家 = {}
    for _, 玩家 in pairs(self.参战玩家) do
        if 玩家.队伍 == 失败id and 玩家数据[玩家.id] then
            self.失败玩家[玩家.id] = true
            if 是否逃跑 or (玩家.编号 and self.参战单位[玩家.编号].逃跑) then
                self.失败玩家[玩家.id] = "逃跑"
            end
            table.insert(id组, 玩家.id)
        end
    end
    for _, 玩家id in ipairs(id组) do
        if not 玩家数据[玩家id] then goto continue end
        if self.战斗类型 == 100006 then -- 科举
            游戏活动类:科举回答题目(玩家数据[self.进入玩家id].连接id, self.进入玩家id, 答案, 5)
            if not 是否逃跑 then
                self:死亡对话(玩家id)
            end
        elseif self.战斗类型 == 100059 or self.战斗类型 == 100061 then -- 挑战失败可继续
            常规提示(self.进入玩家id, "#Y/挑战失败,你可以选择继续挑战！")
        elseif self.战斗类型 == 100017 or self.战斗类型 == 100016 then -- 师门任务失败
            地图处理类:删除单位(任务数据[self.任务id].地图编号, 任务数据[self.任务id].编号)
            常规提示(self.进入玩家id, "#Y/你的师门任务失败了")
            玩家数据[self.进入玩家id].角色:取消任务(self.任务id)
            任务数据[self.任务id] = nil
            玩家数据[self.进入玩家id].角色.数据.师门次数 = 0
        elseif self.战斗类型 == 100114 then -- 水陆大会-翼虎
            常规提示(玩家id, "#Y/想要击败我必须找到观音的法宝，哈哈")
            local 副本id = 任务数据[玩家数据[self.进入玩家id].角色:取任务(150)].副本id
            副本数据.水陆大会.进行[副本id].翼虎 = true
            副本数据.水陆大会.进行[副本id].击败翼虎 = false
            if 副本数据.水陆大会.进行[副本id].翼虎 and 副本数据.水陆大会.进行[副本id].蝰蛇 then
                副本数据.水陆大会.进行[副本id].进程 = 5
                任务处理类:设置水陆大会副本(副本id)
                玩家数据[self.进入玩家id].角色:刷新任务跟踪()
            end
        elseif self.战斗类型 == 100115 then -- 水陆大会-蝰蛇
            常规提示(玩家id, "#Y/想要击败我必须找到观音的法宝，哈哈")
            local 副本id = 任务数据[玩家数据[self.进入玩家id].角色:取任务(150)].副本id
            副本数据.水陆大会.进行[副本id].蝰蛇 = true
            副本数据.水陆大会.进行[副本id].击败蝰蛇 = false
            if 副本数据.水陆大会.进行[副本id].翼虎 and 副本数据.水陆大会.进行[副本id].蝰蛇 then
                副本数据.水陆大会.进行[副本id].进程 = 5
                任务处理类:设置水陆大会副本(副本id)
                玩家数据[self.进入玩家id].角色:刷新任务跟踪()
            end
        elseif self.战斗类型 == 100256 then -- 心魔挑战
                常规提示(self.进入玩家id, "#Y/看来想要打败心魔,必须找到方法才行")
                if 玩家数据[self.进入玩家id].角色:取任务(996) ~= 0 then
                    任务数据[玩家数据[self.进入玩家id].角色:取任务(996)].进程 = 4
                    玩家数据[self.进入玩家id].角色:刷新任务跟踪()
                end
        elseif self.战斗类型 == 110099 then -- 假人战斗失败
                -- 清理假人战斗状态
                if self.假人数据 then
                    假人战斗处理类:清理假人战斗状态(self.假人数据)
                end
        elseif self.战斗类型 == 100018 then -- 门派乾坤袋
            local xy = 地图处理类.地图坐标[任务数据[self.任务id].地图编号]:取随机点()
            任务数据[self.任务id].x, 任务数据[self.任务id].y = xy.x, xy.y
            玩家数据[self.进入玩家id].角色:刷新任务跟踪()
            地图处理类:添加单位(self.任务id)
            if not 是否逃跑 then
                --self:死亡对话(玩家id)
            end
        elseif self.战斗类型 == 100001 or self.战斗类型 == 100007 then -- 野外野怪
            if 玩家数据[self.进入玩家id].角色.数据.等级 and 玩家数据[self.进入玩家id].角色.数据.等级 > 10 then
                if not 是否逃跑 then
                    --self:死亡对话(玩家id)
                end
            end
        elseif not (self.战斗类型 == 100007 or self.战斗类型 == 100001 or
                  self.战斗类型 == 200003 or self.战斗类型 == 200004 or
                  self.战斗类型 == 200005 or self.战斗类型 == 200006) and
                  self.战斗类型 >= 100002 and self.战斗类型 <= 100010 then

            if not 是否逃跑 then
                --self:死亡对话(玩家id)
            end
            if self.战斗类型 == 100027 then -- 知了王
                广播消息({内容 = string.format("#R听说#G%s#R在挑战知了王时,被打的鼻青脸肿,连他妈都不认识了#24", 玩家数据[玩家id].角色.数据.名称), 频道 = "cw"})

            elseif self.战斗类型 == 100037 then -- 地煞星
                广播消息({内容 = string.format("#R听说#G%s#R在挑战地煞星时,被打的抱头鼠窜,一时成为了三界笑谈#24", 玩家数据[玩家id].角色.数据.名称), 频道 = "cw"})

            elseif self.战斗类型 == 200007 then -- PK
                local 胜利队长
                for _, v in pairs(self.参战玩家) do
                    if v.队伍 == 胜利id and 玩家数据[v.id] and (玩家数据[v.id].队长 or 玩家数据[v.id].队伍 == 0) then
                        胜利队长 = v.id
                        break
                    end
                end
                if 胜利队长 then
                    广播消息({内容 = string.format("#Y听说#G%s#Y在与#R%s#Ypk时,被打的头破血流,从此夹着尾巴做人！#24", 玩家数据[玩家id].角色.数据.名称, 玩家数据[胜利队长].角色.数据.名称), 频道 = "cw"})
                end
            elseif self.战斗类型 == 200008 then -- 强PK
                local 胜利队长
                for _, v in pairs(self.参战玩家) do
                    if v.队伍 == 胜利id and 玩家数据[v.id] and (玩家数据[v.id].队长 or 玩家数据[v.id].队伍 == 0) then
                        胜利队长 = v.id
                        break
                    end
                end
                if 玩家数据[玩家id].角色.数据.强P开关 then
                    玩家数据[玩家id].角色.数据.强P开关 = nil
                    发送数据(玩家数据[玩家id].连接id, 94)
                    地图处理类:更改强PK(玩家id)
                    if 玩家数据[玩家id].角色.数据.PK开关 then
                        发送数据(玩家数据[玩家id].连接id, 93, {开关 = true})
                        地图处理类:更改PK(玩家id, true)
                    end
                end
                if 胜利队长 and (玩家数据[玩家id].队伍 == 0 or 玩家数据[玩家id].队长) then
                    广播消息({内容 = string.format("#Y听说#G%s#Y被#R%s#Y强行XXXXX,从此结下了血海深仇！#24", 玩家数据[玩家id].角色.数据.名称, 玩家数据[胜利队长].角色.数据.名称), 频道 = "cw"})
                end
            elseif self.战斗类型 == 110038 then -- 押镖
                玩家数据[self.进入玩家id].角色:取消任务(玩家数据[self.进入玩家id].角色:取任务(300))
                玩家数据[self.进入玩家id].角色.押镖间隔 = os.time() + 180
                添加最后对话(self.进入玩家id, string.format("任务失败,押镖任务失败,您三分钟之内无法再次领取押镖任务"))
                玩家数据[self.进入玩家id].角色.数据.跑镖 = nil

            elseif (self.战斗类型 == 100307 or self.战斗类型 == 100008) and 取任务符合id(self.进入玩家id, self.任务id) then
                if 玩家数据[self.进入玩家id].自动抓鬼 and type(玩家数据[self.进入玩家id].自动抓鬼) == "table" and
                   玩家数据[self.进入玩家id].自动抓鬼.进程 == 5 and not 玩家数据[self.进入玩家id].自动抓鬼.开启 then
                    发送数据(玩家数据[self.进入玩家id].连接id, 101, {进程 = "关闭", 仙玉 = 玩家数据[self.进入玩家id].角色.数据.自动抓鬼, 事件 = "自动抓鬼"})
                    常规提示(self.进入玩家id, "#Y/自动抓鬼已关闭需要请重新开启")
                    玩家数据[self.进入玩家id].自动抓鬼 = nil
                end
            end
        end

        ::continue::
    end
    if self.任务id and 任务数据[self.任务id] then
        任务数据[self.任务id].战斗 = nil
    end
end




function 战斗处理类:死亡对话(id)
      玩家数据[id].战斗=0
      if 玩家数据[id].队长 then
      else
        队伍处理类:退出队伍(id)
      end
      local wb={}
      wb[1] = "生死有命,请珍惜生命？"
      local xx = {}
      self.临时数据={"白无常","白无常",wb[取随机数(1,#wb)],xx}
      self.发送数据={}
      self.发送数据.模型=self.临时数据[1]
      self.发送数据.名称=self.临时数据[2]
      self.发送数据.对话=self.临时数据[3]
      self.发送数据.选项=self.临时数据[4]
      发送数据(玩家数据[id].连接id,1501,self.发送数据)
      地图处理类:跳转地图(id,1125,24,27)
end






function 战斗处理类:还原单位流程(id)
    for k, v in pairs(self.参战单位) do
        if v.气血<=0 then v.气血=0 end
        if v.魔法<=0 then v.魔法=0 end
          if v.玩家id and v.玩家id==id and 玩家数据[v.玩家id] then
              if v.类型=="角色" then
                    if v.气血<=0 then
                        玩家数据[v.玩家id].角色:死亡处理()
                        玩家数据[v.玩家id].角色:刷新信息("1")
                    else
                       玩家数据[v.玩家id].角色:刷新信息()
                       玩家数据[v.玩家id].角色.数据.气血= v.气血
                       玩家数据[v.玩家id].角色.数据.魔法= v.魔法
                       玩家数据[v.玩家id].角色.数据.愤怒= v.愤怒
                    end
                    玩家数据[v.玩家id].战斗=0
                    玩家数据[v.玩家id].角色.数据.战斗开关=nil
                    玩家数据[v.玩家id].遇怪时间=os.time()+取随机数(10,20)
                    玩家数据[v.玩家id].道具:重置法宝回合(v.玩家id)
                    发送数据(玩家数据[v.玩家id].连接id,33,玩家数据[v.玩家id].角色:取总数据())

                elseif v.类型=="bb" and v.认证码 then
                      local bb编号X=玩家数据[v.玩家id].召唤兽:取编号(v.认证码)
                      if bb编号X or bb编号X~=0 then
                            if v.气血<=0 then
                                玩家数据[v.玩家id].召唤兽:死亡处理(v.认证码)
                                玩家数据[v.玩家id].召唤兽:刷新信息1(v.认证码,"1")
                            else
                                玩家数据[v.玩家id].召唤兽:刷新信息1(v.认证码)
                                玩家数据[v.玩家id].召唤兽.数据[bb编号X].气血= v.气血
                                玩家数据[v.玩家id].召唤兽.数据[bb编号X].魔法= v.魔法
                            end
                            if 玩家数据[v.玩家id].召唤兽.数据[bb编号X].气血 > 玩家数据[v.玩家id].召唤兽.数据[bb编号X].最大气血 then
                                玩家数据[v.玩家id].召唤兽.数据[bb编号X].气血 = 玩家数据[v.玩家id].召唤兽.数据[bb编号X].最大气血
                            end
                            if 玩家数据[v.玩家id].角色.数据.参战宝宝 and 玩家数据[v.玩家id].角色.数据.参战宝宝.认证码==玩家数据[v.玩家id].召唤兽.数据[bb编号X].认证码 then
                                玩家数据[v.玩家id].角色.数据.参战宝宝={}
                                玩家数据[v.玩家id].角色.数据.参战宝宝=DeepCopy(玩家数据[v.玩家id].召唤兽:取存档数据(bb编号X))
                                玩家数据[v.玩家id].角色.数据.参战信息=1
                                玩家数据[v.玩家id].召唤兽.数据[bb编号X].参战信息=1
                                发送数据(玩家数据[v.玩家id].连接id,18,玩家数据[v.玩家id].角色.数据.参战宝宝)
                            end
                            发送数据(玩家数据[v.玩家id].连接id,16,玩家数据[v.玩家id].召唤兽.数据)

                      end
                 end
          end
    end
end







function 战斗处理类:还原单位属性()
          local 恢复类型={[100130]=true,[100131]=true,[100132]=true,[100133]=true}
          for k, v in pairs(self.参战单位) do
              if v.类型=="角色" and v.玩家id and 玩家数据[v.玩家id] then
                   玩家数据[v.玩家id].战斗=0
                   玩家数据[v.玩家id].角色.数据.战斗开关=nil
                   玩家数据[v.玩家id].遇怪时间=os.time()+取随机数(10,20)
                   玩家数据[v.玩家id].道具:重置法宝回合(v.玩家id)
                   if 玩家数据[v.玩家id].自动遇怪 then
                        玩家数据[v.玩家id].自动遇怪 = os.time()
                    end
              end
              if v.气血<=0 then v.气血=0 end
              if v.魔法<=0 then v.魔法=0 end
              if v.队伍 and  v.队伍~=0  and v.玩家id and not v.逃跑 and 玩家数据[v.玩家id] then
                  if v.类型=="角色"  then
                      if self.失败玩家[v.玩家id] and self.失败玩家[v.玩家id]~="逃跑" then
                            if self:取玩家战斗() then
                                if self.战斗类型 == 200008 then
                                --  国庆数据[v.玩家id].累积=国庆数据[v.玩家id].累积+1
                                  玩家数据[v.玩家id].角色:死亡处理()
                                end
                            elseif self.战斗类型 ~= 100114 and self.战斗类型 ~= 100115 then
                                玩家数据[v.玩家id].角色:死亡处理()
                            end
                      end
                      if v.气血<=0 then
                          玩家数据[v.玩家id].角色:刷新信息("1")
                      else
                          玩家数据[v.玩家id].角色.数据.气血= v.气血
                          玩家数据[v.玩家id].角色.数据.魔法= v.魔法
                          玩家数据[v.玩家id].角色.数据.愤怒= v.愤怒
                          玩家数据[v.玩家id].角色:刷新信息()
                      end
                      if 玩家数据[v.玩家id].角色:取任务(10)~=0  and not 恢复类型[self.战斗类型] then
                            local 恢复id=玩家数据[v.玩家id].角色:取任务(10)
                            if 玩家数据[v.玩家id].角色.数据.气血<玩家数据[v.玩家id].角色.数据.最大气血 then
                                if 任务数据[恢复id].气血>0 then
                                    任务数据[恢复id].气血 = 任务数据[恢复id].气血 - 1
                                    玩家数据[v.玩家id].角色.数据.气血=玩家数据[v.玩家id].角色.数据.最大气血
                                    玩家数据[v.玩家id].角色.数据.气血上限=玩家数据[v.玩家id].角色.数据.最大气血
                                    if 任务数据[恢复id].气血==0  and  任务数据[恢复id].魔法==0 then
                                      玩家数据[v.玩家id].角色:取消任务(恢复id)
                                    end
                                end
                            end
                            if 玩家数据[v.玩家id].角色.数据.魔法<玩家数据[v.玩家id].角色.数据.最大魔法 then
                                if 任务数据[恢复id].魔法>0 then
                                    任务数据[恢复id].魔法 = 任务数据[恢复id].魔法 - 1
                                    玩家数据[v.玩家id].角色.数据.魔法=玩家数据[v.玩家id].角色.数据.最大魔法
                                    if 任务数据[恢复id].气血==0  and  任务数据[恢复id].魔法==0 then
                                      玩家数据[v.玩家id].角色:取消任务(恢复id)
                                    end
                                end
                            end
                            玩家数据[v.玩家id].角色:刷新任务跟踪()
                      end
                      发送数据(玩家数据[v.玩家id].连接id,33,玩家数据[v.玩家id].角色:取总数据())
                  elseif v.类型=="bb"  and v.认证码 then
                        local bb编号X=玩家数据[v.玩家id].召唤兽:取编号(v.认证码)
                        if bb编号X or bb编号X~=0 then
                            if v.气血<=0 then
                                玩家数据[v.玩家id].召唤兽:死亡处理(v.认证码)
                                玩家数据[v.玩家id].召唤兽:刷新信息1(v.认证码,"1")
                            else
                                玩家数据[v.玩家id].召唤兽:刷新信息1(v.认证码)
                                玩家数据[v.玩家id].召唤兽.数据[bb编号X].气血= v.气血
                                玩家数据[v.玩家id].召唤兽.数据[bb编号X].魔法= v.魔法
                            end

                            if 玩家数据[v.玩家id].召唤兽.数据[bb编号X].气血 > 玩家数据[v.玩家id].召唤兽.数据[bb编号X].最大气血 then
                                玩家数据[v.玩家id].召唤兽.数据[bb编号X].气血 = 玩家数据[v.玩家id].召唤兽.数据[bb编号X].最大气血
                            end
                            if 玩家数据[v.玩家id].角色:取任务(10)~=0  and not 恢复类型[self.战斗类型] then
                                local 恢复id=玩家数据[v.玩家id].角色:取任务(10)
                                if 玩家数据[v.玩家id].召唤兽.数据[bb编号X].气血<玩家数据[v.玩家id].召唤兽.数据[bb编号X].最大气血 then
                                    if 任务数据[恢复id].气血>0 then
                                        任务数据[恢复id].气血 = 任务数据[恢复id].气血 - 1
                                        玩家数据[v.玩家id].召唤兽.数据[bb编号X].气血=玩家数据[v.玩家id].召唤兽.数据[bb编号X].最大气血
                                        if 任务数据[恢复id].气血==0  and  任务数据[恢复id].魔法==0 then
                                          玩家数据[v.玩家id].角色:取消任务(恢复id)
                                        end
                                    end
                                end
                                if 玩家数据[v.玩家id].召唤兽.数据[bb编号X].魔法<玩家数据[v.玩家id].召唤兽.数据[bb编号X].最大魔法 then
                                    if 任务数据[恢复id].魔法>0 then
                                          任务数据[恢复id].魔法 = 任务数据[恢复id].魔法 - 1
                                          玩家数据[v.玩家id].召唤兽.数据[bb编号X].魔法=玩家数据[v.玩家id].召唤兽.数据[bb编号X].最大魔法
                                          if 任务数据[恢复id].气血==0  and  任务数据[恢复id].魔法==0 then
                                              玩家数据[v.玩家id].角色:取消任务(恢复id)
                                          end
                                    end
                                end
                                玩家数据[v.玩家id].角色:刷新任务跟踪()
                            end
                            if 玩家数据[v.玩家id].角色.数据.参战宝宝 and 玩家数据[v.玩家id].角色.数据.参战宝宝.认证码==玩家数据[v.玩家id].召唤兽.数据[bb编号X].认证码 then
                                玩家数据[v.玩家id].角色.数据.参战宝宝={}
                                玩家数据[v.玩家id].角色.数据.参战宝宝=DeepCopy(玩家数据[v.玩家id].召唤兽:取存档数据(bb编号X))
                                玩家数据[v.玩家id].角色.数据.参战信息=1
                                玩家数据[v.玩家id].召唤兽.数据[bb编号X].参战信息=1
                                发送数据(玩家数据[v.玩家id].连接id,18,玩家数据[v.玩家id].角色.数据.参战宝宝)
                            end
                            发送数据(玩家数据[v.玩家id].连接id,16,玩家数据[v.玩家id].召唤兽.数据)
                        end
                  end
              end
          end
end


function 战斗处理类:退出发送流程()
    for k,v in pairs(self.参战玩家) do
      if 玩家数据[v.id] then
          发送数据(v.连接id,5505)
          地图处理类:设置战斗开关(v.id)
          if 玩家数据[v.id].战斗对话 then
              发送数据(v.连接id,1501,玩家数据[v.id].战斗对话)
          end
          玩家数据[v.id].战斗对话=nil
          if os.time() < v.进入时间 and not self.失败玩家[v.id] then
             if not 玩家数据[v.id].退出过快 then
                    玩家数据[v.id].退出过快 = {次数=1,时间=os.time()}
                    常规提示(v.id,"#Y/退出过快,快速退出第#R/"..玩家数据[v.id].退出过快.次数.."#Y/次,短时间内连续请求3次直接封号")
              else
                    if os.time()-玩家数据[v.id].退出过快.时间>=3600 then
                        玩家数据[v.id].退出过快 = {次数=1,时间=os.time()}
                        常规提示(v.id,"#Y/退出过快,快速退出第#R/"..玩家数据[v.id].退出过快.次数.."#Y/次,短时间内连续请求3次直接封号")
                    else
                        玩家数据[v.id].退出过快.次数=玩家数据[v.id].退出过快.次数+1
                        玩家数据[v.id].退出过快.时间=os.time()
                        if 玩家数据[v.id].退出过快.次数>=3 then
                            共享货币[玩家数据[v.id].账号]:充值记录("跳过战斗被进封")
                            封禁账号(v.id,"跳过战斗")
                            广播消息({内容="#Y玩家id"..v.id.."疑似使用跳过战斗被封号",频道="xt"})
                            print(v.id,"因疑似跳过战斗封号。回合期望结束时间:",v.进入时间,"结束时间:",os.time())
                        else
                            常规提示(v.id,"#Y/退出过快,快速退出第#R/"..玩家数据[v.id].退出过快.次数.."#Y/次,短时间内连续请求3次直接封号")
                        end
                    end
              end
          end
          if v.断线 then
              系统处理类:断开游戏(v.id)
          end
      end


      if self.战斗类型==100019 and self.玩家胜利 and 取随机数()<=2 and v.id == self.进入玩家id and  玩家数据[v.id] then
              local id=self.进入玩家id
              if 玩家数据[id].角色.数据.地图数据.编号~=1620 then
                  local 随机递增=取随机数(1,3)
                  local 传送地图= 玩家数据[id].角色.数据.地图数据.编号+随机递增
                  if 传送地图>1620 then
                    传送地图=1620
                  end
                  local xy=地图处理类.地图坐标[传送地图]:取随机点()
                  地图处理类:跳转地图(id,传送地图,xy.x,xy.y)
                  常规提示(id,"#Y你击败了迷宫小怪后，意外地发现自己来到了#R"..取地图名称(传送地图))
              end
      elseif self.战斗类型==100214 and self.玩家胜利 and  v.id == self.进入玩家id and  玩家数据[v.id] then --大闹黑白无常
                地图处理类:跳转地图(v.id,6037,100,101)

      elseif self.战斗类型==100215 and self.玩家胜利 and  v.id == self.进入玩家id and  玩家数据[v.id] then
                地图处理类:跳转地图(v.id,6036,12,108)


      elseif self.战斗类型==200006  and self.失败玩家[v.id] and  玩家数据[v.id] then--胜利

          --帮战活动类:战斗胜利(胜利id,失败id)


      end
  end
  for i,v in pairs(self.观战玩家) do
      if 玩家数据[i] then
          发送数据(玩家数据[i].连接id,5505)
          玩家数据[i].战斗=0
          玩家数据[i].观战=nil
          玩家数据[i].遇怪时间=os.time()+取随机数(10,20)
          if 玩家数据[i].自动遇怪 then
               玩家数据[i].自动遇怪 = os.time()
          end
      end
  end



  self.结束条件=true
  if self.战斗类型==100046 and not self.失败玩家[self.进入玩家id] then   -------连续战斗
      战斗准备类:创建战斗(self.进入玩家id,100047,self.任务id)
  elseif self.战斗类型==100047 and not self.失败玩家[self.进入玩家id] then
      战斗准备类:创建战斗(self.进入玩家id,100048,self.任务id)
  elseif self.战斗类型==100130 and not self.失败玩家[self.进入玩家id]then
      战斗准备类:创建战斗(self.进入玩家id,100131,self.任务id)
  elseif self.战斗类型==100131 and not self.失败玩家[self.进入玩家id] then
      战斗准备类:创建战斗(self.进入玩家id,100132,self.任务id)
  elseif self.战斗类型==100132 and not self.失败玩家[self.进入玩家id] then
      战斗准备类:创建战斗(self.进入玩家id,100133,self.任务id)
  elseif self.战斗类型==100133 and not self.失败玩家[self.进入玩家id] then
      战斗准备类:创建战斗(self.进入玩家id,100134,self.任务id)
  elseif self.战斗类型==130038 and not self.失败玩家[self.进入玩家id] then
      战斗准备类:创建战斗(self.进入玩家id,130039,self.任务id)
  elseif self.战斗类型==130039 and not self.失败玩家[self.进入玩家id] then
      战斗准备类:创建战斗(self.进入玩家id,130040,self.任务id)

  end
  if self.任务id~=nil and 任务数据[self.任务id]~=nil then
     任务数据[self.任务id].战斗=nil
  end

end


