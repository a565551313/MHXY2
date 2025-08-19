

function 战斗处理类:加载流程处理()
        local 客户数据={状态={},气血={},冷却={}}
        for k,v in pairs(self.参战单位) do
            local 返回数据 = self:取战斗状态(v)
            客户数据.气血[k]=返回数据.气血 or {}
            客户数据.状态[k]=返回数据.状态 or {}
            客户数据.冷却[k]=返回数据.冷却 or {}
        end
        local 玩家数量 = 0
        for i,z in pairs(self.参战玩家) do
            local 返回气血={客户数据.气血[z.编号]}
            if self.参战单位[z.编号].召唤兽 then
                返回气血[2]=客户数据.气血[self.参战单位[z.编号].召唤兽]
            end
            发送数据(z.连接id,战斗序号.发送,self.战斗流程)
            发送数据(z.连接id,5519,客户数据.状态)
            发送数据(z.连接id,5506,返回气血)
            发送数据(z.连接id,5522,客户数据.冷却)
            玩家数量 = 玩家数量 + 1
        end
        self.执行等待=self.执行等待+os.time()
        self.加载数量=玩家数量
        self.回合进程="执行回合"
end




function 战斗处理类:数据处理(玩家id, 序号, 内容, 参数)
    if 序号 == 5510 then
        self:处理观战退出(玩家id)
        return
    end
    if self.观战玩家 and self.观战玩家[玩家id] then
        return
    end
    if 序号 == 5506 then
        self:逃跑事件处理(玩家id)
        return
    end
    if self.回合进程 == "加载回合" and 序号 == 5501 then
        self:处理加载回合(玩家id)

    elseif self.回合进程 == "命令回合" then
        if 序号 == 5502 then
            self:处理战斗指令(玩家id, 内容)
        elseif 序号 == 5599 then
            self:处理道具请求(玩家id, 内容)
        elseif 序号 == 5523 then
            self:处理灵宝请求(玩家id, 内容)
        elseif 序号 == 5504 then
            self:处理召唤道具请求(玩家id, 内容)
        elseif 序号 == 5508 then
            self:处理法宝请求(玩家id, 内容)
        elseif 序号 == 5505 then
            self:处理召唤请求(玩家id, 内容)
        elseif 序号 == 5507 then
            self:自动战斗设置(玩家id)
        end
    elseif self.回合进程 == "执行回合" then
        if 序号 == 战斗序号.收到 then --5503
            self:处理执行回合(玩家id)
        elseif 序号 == 5511 then
            self:处理多开指令修改(玩家id, 内容)
        elseif 序号 == 5507 then
            self:自动战斗设置(玩家id)
        end
    end
end








function 战斗处理类:处理观战退出(玩家id)
    local id组 = 取id组(玩家id)
    for _, id in ipairs(id组) do
        if 玩家数据[id].观战 and self.观战玩家[id] then
            发送数据(玩家数据[id].连接id, 5505)
            玩家数据[id].战斗 = 0
            玩家数据[id].观战 = nil
            玩家数据[id].遇怪时间 = os.time() + 取随机数(10, 20)
            if 玩家数据[id].自动遇怪 then
                玩家数据[id].自动遇怪 = os.time()
            end
        end
        self.观战玩家[id] = nil
    end
end

function 战斗处理类:处理加载回合(玩家id)
    self.加载数量 = self.加载数量 - 1
    for _, 单位 in ipairs(self.参战单位) do
        if 单位.玩家id == 玩家id and 单位.操作角色 then
            for _, 编号 in ipairs(单位.操作角色) do
                if self.参战单位[编号].类型 == "角色" then
                    self.加载数量 = self.加载数量 - 1
                end
            end
        end
    end
    if self.加载数量 <= 0 then
        if self.战斗流程 and #self.战斗流程 == 0 then
            self:设置命令处理()
        else
            self:加载流程处理()
        end
    end
end




function 战斗处理类:处理战斗指令(玩家id, 内容)
    local 编号 = self:取参战编号(玩家id, "角色")
    local 目标 = {编号}

    if self.参战单位[编号].召唤兽 then
        目标[2] = self.参战单位[编号].召唤兽
    end
    if self.参战单位[编号].操作角色 then
        for _, 角色 in ipairs(self.参战单位[编号].操作角色) do
            目标[#目标 + 1] = 角色
        end
    end

    for n, 指令 in ipairs(内容) do
        if 指令 and self.参战单位[目标[n]] then
            self:处理单个指令(目标[n], 指令)
            if self.参战单位[目标[n]].指令.类型 == "攻击" and self.参战单位[目标[n]].指令.目标 == 0 then
                self.参战单位[目标[n]].指令.目标 = self:取单个敌方目标(n)
            end
        end
    end

    if self.加载数量 <= 0 then
        self.回合进程 = "计算回合"
        self:执行回合处理()
    end
end

function 战斗处理类:处理单个指令(编号, 指令)
    local 查找主动 = false

    if 指令.多重施法 then
        for _, 施法 in pairs(指令.多重施法) do
            if 战斗技能[施法] and 战斗技能[施法].特技 then
                指令.类型 = "特技"
                指令.参数 = 施法.参数
                指令.目标 = 施法.目标
                指令.附加 = 施法.附加
                指令.敌我 = 施法.敌我
                指令.多重施法 = nil
                break
            end
        end
    end

    if 指令.类型 == "法术" then
        查找主动 = self:检查法术有效性(编号, 指令)
    elseif 指令.类型 == "特技" then
        指令.多重施法 = nil
        查找主动 = self:检查特技有效性(编号, 指令)
    else
        指令.多重施法 = nil
        查找主动 = true
    end

    if 查找主动 then
        self:设置有效指令(编号, 指令)
    else
        self:设置默认攻击指令(编号)
    end
end

function 战斗处理类:检查法术有效性(编号, 指令)
    if 指令.多重施法 and self.参战单位[编号].门派 == "九黎城" then
        for _, 施法 in pairs(指令.多重施法) do
            if 施法.类型 == "法术" then
                local 有效 = false
                for _, 技能 in pairs(self.参战单位[编号].主动技能) do
                    if 施法.参数 == 技能.名称 then
                        有效 = true
                        break
                    end
                end
                if not 有效 then return false end
            end
        end
        return true
    else
        指令.多重施法 = nil
        for _, 技能 in pairs(self.参战单位[编号].主动技能) do
            if 指令.参数 == 技能.名称 then
                return true
            end
        end
    end
    return false
end

function 战斗处理类:检查特技有效性(编号, 指令)
    if self.参战单位[编号].类型 == "角色" and (战斗技能[指令.参数].特技 or 指令.参数 == "琴音三叠") then
        for _, 特技 in pairs(self.参战单位[编号].特技技能) do
            if 指令.参数 == 特技.名称 then
                return true
            end
        end
    end
    return false
end


function 战斗处理类:设置有效指令(编号, 指令)
    if self.参战单位[编号].门派 == "九黎城" then
        指令.九黎挂机 = {}
        if self.参战单位[编号].自动指令 and self.参战单位[编号].自动指令.九黎挂机 then
            指令.九黎挂机 = DeepCopy(self.参战单位[编号].自动指令.九黎挂机)
        end
        if self.参战单位[编号].九黎次数 and 指令.多重施法 then
            if self.参战单位[编号].九黎次数 > 4 then
                self.参战单位[编号].九黎次数 = 4
            end
            local 次数 = self.参战单位[编号].九黎次数
            if #指令.多重施法 > 次数 then
                for i = 次数 + 1, #指令.多重施法 do
                    指令.多重施法[i] = nil
                end
            end
            指令.九黎挂机[次数] = DeepCopy(指令.多重施法)
        end
    end
    self.参战单位[编号].自动指令 = DeepCopy(指令)
    self.参战单位[编号].指令 = DeepCopy(self.参战单位[编号].自动指令)
    self.参战单位[编号].指令.下达 = true
    if self.参战单位[编号].类型 == "角色" then
        玩家数据[self.参战单位[编号].玩家id].角色.数据.自动指令 = 指令
        self.加载数量 = self.加载数量 - 1
    elseif self.参战单位[编号].类型 == "bb" then
        local bb编号 = 玩家数据[self.参战单位[编号].玩家id].召唤兽:取编号(self.参战单位[编号].认证码)
        玩家数据[self.参战单位[编号].玩家id].召唤兽.数据[bb编号].自动指令 = 指令
    end
end

function 战斗处理类:设置默认攻击指令(编号)
    self.参战单位[编号].指令.类型 = "攻击"
    self.参战单位[编号].指令.目标 = 0
    local  默认 = {下达 = false, 类型 = "攻击", 目标 = 0, 敌我 = 0, 参数 = "", 附加 = ""}
    if self.参战单位[编号].门派 == "九黎城" and self.参战单位[编号].自动指令 and self.参战单位[编号].自动指令.九黎挂机 then
        默认.九黎挂机 =  DeepCopy(self.参战单位[编号].自动指令.九黎挂机)
    end
    self.参战单位[编号].自动指令 = 默认
    if self.参战单位[编号].类型 == "角色" then
        self.加载数量 = self.加载数量 - 1
    end
end

function 战斗处理类:处理道具请求(玩家id, 内容)
    local 数据 = {}
    local 编号 = self:取参战编号(玩家id, "角色")
    if 内容.玩家 then
        编号 = tonumber(内容.玩家)
    end
    if self.参战单位[编号] and self.参战单位[编号].法术状态.日月乾坤 and self.参战单位[编号].法术状态.日月乾坤.陌宝 then
        常规提示(玩家id, "#Y/无法使用道具")
        return
    end
    数据.玩家id = self.参战单位[编号].玩家id
    数据.道具 = 玩家数据[self.参战单位[编号].玩家id].道具:索要道具2(self.参战单位[编号].玩家id)
    数据.无法使用 = {}
    if self.参战单位[编号].灵宝缚仙蛛丝 then
        数据.无法使用 = self.参战单位[编号].灵宝缚仙蛛丝
    end
    发送数据(玩家数据[玩家id].连接id, 5509, 数据)
    self.参战单位[编号].道具类型 = "道具"
end

function 战斗处理类:处理灵宝请求(玩家id, 内容)
    local 数据 = {}
    local 编号 = self:取参战编号(玩家id, "角色")
    if 内容.玩家 then
        编号 = tonumber(内容.玩家)
    end
    if self.参战单位[编号].法术状态.相思寒针 then
         常规提示(玩家id,"#Y/当前状态无法使用灵宝")
        return
    end
    数据.玩家id = self.参战单位[编号].玩家id
    数据.灵宝佩戴 = self.参战单位[编号].灵宝佩戴
    数据.灵元 = self.参战单位[编号].灵元.数值
    self.参战单位[编号].道具类型 = "灵宝"
    发送数据(玩家数据[玩家id].连接id, 5523, 数据)
end

function 战斗处理类:处理召唤道具请求(玩家id, 内容)
    local 数据 = {}
    local 编号 = self:取参战编号(玩家id, "角色")
    local 执行编号 = self.参战单位[编号].召唤兽

    if 内容.玩家 then
        编号 = tonumber(内容.玩家)
        执行编号 = self.参战单位[编号].召唤兽
    end
    if 执行编号 and self.参战单位[执行编号] and self.参战单位[执行编号].法术状态.日月乾坤 and self.参战单位[执行编号].法术状态.日月乾坤.陌宝 then
        常规提示(玩家id, "#Y/无法使用道具")
        return
    end
    数据.玩家id = self.参战单位[编号].玩家id
    数据.道具 = 玩家数据[self.参战单位[编号].玩家id].道具:索要道具2(self.参战单位[编号].玩家id)
    数据.无法使用 = {}
    if self.参战单位[编号].灵宝缚仙蛛丝 then
        数据.无法使用 = self.参战单位[编号].灵宝缚仙蛛丝
    end
    发送数据(玩家数据[玩家id].连接id, 5509, 数据)
    if 执行编号 then
        self.参战单位[执行编号].道具类型 = "道具"
    end
end

function 战斗处理类:处理法宝请求(玩家id, 内容)
    local 数据 = {}
    local 编号 = self:取参战编号(玩家id, "角色")

    if 内容.玩家 then
        编号 = tonumber(内容.玩家)
    end
    if self.参战单位[编号].法术状态.无字经 then
         常规提示(玩家id,"#Y/当前状态无法使用法宝")
        return
    end

    数据.玩家id = self.参战单位[编号].玩家id
    数据.道具 = 玩家数据[self.参战单位[编号].玩家id].道具:索要法宝1(self.参战单位[编号].玩家id, self.回合数)
    发送数据(玩家数据[玩家id].连接id, 5509, 数据)
    self.参战单位[编号].道具类型 = "法宝"
end


function 战斗处理类:处理召唤请求(玩家id, 内容)
    local 数据 = {}
    local 编号 = self:取参战编号(玩家id, "角色")

    if 内容.玩家 then
        编号 = tonumber(内容.玩家)
    end

    数据.玩家id = self.参战单位[编号].玩家id
    数据.召唤兽 = {
        数据 = 玩家数据[self.参战单位[编号].玩家id].召唤兽.数据,
        数量 = self.参战单位[编号].召唤数量
    }

    发送数据(玩家数据[玩家id].连接id, 5510, 数据)
end


function 战斗处理类:自动战斗设置(玩家id)
    local 更改内容 = {}
    local 指令内容 = {}
    local 编号 = self:取参战编号(玩家id, "角色")
    local 检查技能=function(单位,技能)
            for _, n in pairs(单位.主动技能) do
                if 技能 == n.名称 then
                    return true
                end
            end
            return false
    end
    local 指令设置=function(单位)
            local 指令 = {下达 = false, 类型 = "攻击", 目标 = 0, 敌我 = 0, 参数 = "", 附加 = ""}
            if 单位.自动指令 then
                指令 = DeepCopy(单位.自动指令)
                if 单位.门派=="九黎城" and 单位.自动指令.九黎挂机 then
                    指令.九黎挂机 = DeepCopy(单位.自动指令.九黎挂机)
                    if self.回合进程 == "命令回合" and 单位.九黎次数
                    and 单位.自动指令.九黎挂机[单位.九黎次数] then
                        指令.多重施法 = DeepCopy(单位.自动指令.九黎挂机[单位.九黎次数])
                    end
                end
            else
                单位.自动指令 = 指令
            end
            if 指令.参数 and (指令.参数=="" or (指令.类型=="法术" and not 检查技能(单位,指令.参数))) then
                指令.类型 = "攻击"
                指令.目标 = self:取单个敌方目标(单位.编号)
            end
            return 指令
    end
    if self.参战单位[编号].自动战斗 then
       self.参战单位[编号].自动战斗 =false
       玩家数据[玩家id].角色.数据.自动战斗 = false
       table.insert(更改内容, {id = 编号, 自动 = false})
       if self.参战单位[编号].召唤兽 then
            self.参战单位[self.参战单位[编号].召唤兽].自动战斗 =false
       end
       if self.参战单位[编号].操作角色 then
            for k,v in pairs(self.参战单位[编号].操作角色) do
                if self.参战单位[v].类型 == "角色" then
                    self.参战单位[v].自动战斗 =false
                    玩家数据[self.参战单位[v].玩家id].角色.数据.自动战斗 = false
                    if self.参战单位[v].召唤兽 then
                        self.参战单位[self.参战单位[v].召唤兽].自动战斗 =false
                    end
                    table.insert(更改内容, {id = v, 自动 = false})
                end
            end
       end
       常规提示(玩家id, "#Y/你取消了自动战斗")
       发送数据(玩家数据[玩家id].连接id, 5514, 更改内容)
    else
        self.参战单位[编号].自动战斗 =true
        玩家数据[玩家id].角色.数据.自动战斗 = true
        table.insert(更改内容, {id = 编号, 自动 = true})
        local 下达 = self.参战单位[编号].指令.下达
        self.参战单位[编号].指令 = 指令设置(self.参战单位[编号])
        if self.回合进程 == "命令回合" then
            self.参战单位[编号].指令.下达 = true
            if not 下达 then
                self.加载数量=self.加载数量-1
            end
        end
        table.insert(指令内容, {id = 编号, 自动 = self.参战单位[编号].指令})
        if self.参战单位[编号].召唤兽 then
            local 召唤兽 = self.参战单位[编号].召唤兽
            self.参战单位[召唤兽].自动战斗 =true
            self.参战单位[召唤兽].指令 = 指令设置(self.参战单位[召唤兽])
            if self.回合进程 == "命令回合" then
                self.参战单位[召唤兽].指令.下达 = true
            end
            table.insert(指令内容, {id = 召唤兽, 自动 = self.参战单位[召唤兽].指令})
        end
        if self.参战单位[编号].操作角色 then
            for k,v in pairs(self.参战单位[编号].操作角色) do
                if self.参战单位[v].类型 == "角色" then
                    self.参战单位[v].自动战斗 =true
                    玩家数据[self.参战单位[v].玩家id].角色.数据.自动战斗 = true
                    local 下达1 = self.参战单位[v].指令.下达
                    self.参战单位[v].指令 = 指令设置(self.参战单位[v])
                    if self.回合进程 == "命令回合" then
                        self.参战单位[v].指令.下达 = true
                        if not 下达1 then
                            self.加载数量=self.加载数量-1
                        end
                    end
                    table.insert(更改内容, {id = v, 自动 = true})
                    if self.参战单位[v].召唤兽 then
                        local 召唤兽 = self.参战单位[v].召唤兽
                        self.参战单位[召唤兽].自动战斗 = true
                        self.参战单位[召唤兽].指令 = 指令设置(self.参战单位[召唤兽])
                        if self.回合进程 == "命令回合" then
                            self.参战单位[召唤兽].指令.下达 = true
                        end
                        table.insert(指令内容, {id = 召唤兽, 自动 = self.参战单位[召唤兽].指令})
                    end
                end
            end
        end
        常规提示(玩家id, "#Y/你开启了自动战斗")
        发送数据(玩家数据[玩家id].连接id, 5513, 指令内容)
        发送数据(玩家数据[玩家id].连接id, 5514, 更改内容)
        if self.回合进程 == "命令回合" and self.加载数量<=0 then
            self.回合进程="计算回合"
            self:执行回合处理()
        end
    end

end

function 战斗处理类:处理执行回合(玩家id)
    self.加载数量 = self.加载数量 - 1
    local 编号 = self:取参战编号(玩家id, "角色")
    if self.参战单位[编号].操作角色 then
        for _, 角色 in ipairs(self.参战单位[编号].操作角色) do
            if self.参战单位[角色].类型 == "角色" then
                self.加载数量 = self.加载数量 - 1
            end
        end
    end
    self.执行等待 = os.time() + 10
    local 断线= 0
    for _, 玩家 in pairs(self.参战玩家) do
        if 玩家.断线 then
            断线 = 断线 + 1
        end
    end
    -- if self.加载数量 <= 0 and self.回合进程 ~= "结束回合" then
    --     self.回合进程 = "结束回合"
    --     self:结算流程处理()
    -- else
    if self.加载数量 <= 断线 and self.回合进程 ~= "结束回合" then
        self.回合进程 = "结束回合"
        self:结算流程处理()
    end
end


function 战斗处理类:处理多开指令修改(玩家id, 内容)
    local 修改 = 内容.修改
    local 指令内容 = {}
    local 更改内容 = {}
    local 检查技能=function(编号,技能)
            for _, n in pairs(self.参战单位[编号].主动技能) do
                if 技能 == n.名称 then
                    return true
                end
            end
            return false
    end
    if not 玩家数据[修改.id] or not 修改.类型 then return end
    if 玩家数据[修改.id].子角色操作 or 修改.id == 玩家id then
        local 编号 = self:取参战编号(修改.id, 修改.类型)
        if not 编号 and not self.参战单位[编号] then return end
        local 指令 = {下达 = false, 类型 = "攻击", 目标 = 0, 敌我 = 0, 参数 = "", 附加 = ""}
        if 修改.九黎技能 and self.参战单位[编号].门派=="九黎城" then
            local 挂机 = {}
            local 是否改变 = false
            if 修改.九黎技能[1] and 修改.九黎技能[2] then
                挂机[2] = {修改.九黎技能[1],修改.九黎技能[2]}
            else
                挂机[2]=nil
                常规提示(玩家id, "#Y/双技能设置有误")
            end
            if 修改.九黎技能[3] and 修改.九黎技能[4] and 修改.九黎技能[5] then
                挂机[3] = {修改.九黎技能[3],修改.九黎技能[4],修改.九黎技能[5]}
            else
                挂机[3]=nil
                常规提示(玩家id, "#Y/三技能设置有误")
            end
            if 修改.九黎技能[6] and 修改.九黎技能[7] and 修改.九黎技能[8] and 修改.九黎技能[9] then
                挂机[4] = {修改.九黎技能[6],修改.九黎技能[7],修改.九黎技能[8],修改.九黎技能[9]}
            else
                挂机[4]=nil
                常规提示(玩家id, "#Y/四技能设置有误")
            end
            if not 挂机[2] and not 挂机[3] and not 挂机[4] then
                return
            end
            local 通过 = true
            for i=2,4 do
                if 挂机[i] and 通过 then
                    for k,v in ipairs(挂机[i]) do
                        if not 检查技能(编号,v) then
                            通过 = false
                            break
                        end
                    end
                end
            end
            if 通过 then
                指令.九黎挂机={}
                for i=2,4 do
                    if 挂机[i] then
                        指令.九黎挂机[i]={}
                        for k,v in ipairs(挂机[i]) do
                            指令.九黎挂机[i][k]= {类型 = "法术",敌我 = 0,参数 = v}
                            local 临时技能=取法术技能(v)
                            指令.九黎挂机[i][k].附加 = 临时技能[3]
                            if 临时技能[3]==4 then
                                指令.九黎挂机[i][k].目标=self:取单个敌方目标(编号)
                            else
                                指令.九黎挂机[i][k].目标=self:取单个友方目标(编号)
                            end
                        end
                        指令.多重施法 = DeepCopy(指令.九黎挂机[i])
                        指令.参数 = 挂机[i][#挂机[i]]
                    end
                end
                local 临时技能=取法术技能(指令.参数)
                if 临时技能[3] then
                    指令.类型 = "法术"
                    指令.附加 = 临时技能[3]
                    if 临时技能[3]==4 then
                        指令.目标=self:取单个敌方目标(编号)
                    else
                        指令.目标=self:取单个友方目标(编号)
                    end
                end
            else
                return
            end
        elseif 修改.参数 == "攻击" then
            指令.类型 = "攻击"
        elseif 修改.参数 == "防御" then
            指令.类型 = "防御"
        elseif 修改.参数 then
                if 检查技能(编号,修改.参数)  then
                    local 临时技能=取法术技能(修改.参数)
                    if 临时技能[3] then
                        指令.类型 = "法术"
                        指令.参数 = 修改.参数
                        指令.附加 = 临时技能[3]
                        if 临时技能[3]==4 then
                            指令.目标=self:取单个敌方目标(编号)
                        else
                            指令.目标=self:取单个友方目标(编号)
                        end
                    end
                else
                    常规提示(玩家id, "#Y/设置的技能无效")
                    return
                end
        else
            return
        end
        if 修改.类型 == "角色" then
            self.参战单位[编号].自动指令 = 指令
            玩家数据[修改.id].角色.数据.自动指令 = DeepCopy(指令)
        elseif 修改.认证码 then
                指令.九黎挂机 = nil
                指令.多重施法 = nil
                self.参战单位[编号].自动指令 = 指令
                local bb编号X = 玩家数据[修改.id].召唤兽:取编号(修改.认证码)
                玩家数据[修改.id].召唤兽.数据[bb编号X].自动指令 = DeepCopy(指令)
        end
        指令内容[#指令内容 + 1] = {id = 编号, 自动 = self.参战单位[编号].自动指令}
        更改内容[#更改内容 + 1] = {id = 编号, 自动 = self.参战单位[编号].自动战斗}
        发送数据(玩家数据[玩家id].连接id, 5513, 指令内容)
        发送数据(玩家数据[玩家id].连接id, 5514, 更改内容)
        常规提示(玩家id, "#Y/自动技能已变更完成")
    end
end



