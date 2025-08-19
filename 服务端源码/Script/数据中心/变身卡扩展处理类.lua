--======================================================================--
-- 变身卡扩展处理类
-- 处理货币加成、经验加成、多属性加成
-- 超级变身卡新加
--======================================================================--

变身卡扩展处理类 = {}

function 变身卡扩展处理类:new(玩家id)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.玩家id = 玩家id  -- 确保玩家ID被正确设置
    obj.货币加成缓存 = {}
    obj.经验加成缓存 = {}
    obj.多属性缓存 = {}
    print("变身卡扩展处理类: 初始化完成，玩家ID=" .. tostring(玩家id))
    return obj
end

function 变身卡扩展处理类:初始化(玩家id)
    -- 这个方法现在不需要了，因为在new方法中已经完成初始化
end

-- 应用变身卡扩展效果
function 变身卡扩展处理类:应用变身卡扩展效果(变身数据名称)
    -- 先清除之前的扩展效果
    self:清除变身卡扩展效果()
    if not 变身数据名称 then
        print("变身卡扩展处理类: 变身数据名称为空")
        return
    end
    
    if not 变身卡数据[变身数据名称] then
        print("变身卡扩展处理类: 找不到变身卡数据 - " .. 变身数据名称)
        return
    end
    
    local 变身卡配置 = 变身卡数据[变身数据名称]
    print("变身卡扩展处理类: 开始应用扩展效果 - " .. 变身数据名称)
    
    -- 应用货币加成
    if 变身卡配置.货币加成 and #变身卡配置.货币加成 > 0 then
        print("变身卡扩展处理类: 应用货币加成")
        self:应用货币加成(变身卡配置.货币加成)
    end
    
    -- 应用经验加成
    if 变身卡配置.经验加成 and #变身卡配置.经验加成 > 0 then
        print("变身卡扩展处理类: 应用经验加成")
        self:应用经验加成(变身卡配置.经验加成)
    end
    
    -- 应用多属性加成
    if 变身卡配置.多属性 and #变身卡配置.多属性 > 0 then
        print("变身卡扩展处理类: 应用多属性加成")
        self:应用多属性加成(变身卡配置.多属性)
    end
    
    print("变身卡扩展处理类: 扩展效果应用完成")
end

-- 清除变身卡扩展效果
function 变身卡扩展处理类:清除变身卡扩展效果()
    self:清除货币加成()
    self:清除经验加成()
    self:清除多属性加成()
end

-- 应用货币加成
function 变身卡扩展处理类:应用货币加成(货币加成配置)
    self.货币加成缓存 = {}
    
    for i, 配置 in ipairs(货币加成配置) do
        if 配置.类型 and 配置.加成 and 配置.正负 then
            self.货币加成缓存[配置.类型] = {
                加成 = 配置.加成,
                正负 = 配置.正负
            }
        end
    end
end

-- 应用经验加成
function 变身卡扩展处理类:应用经验加成(经验加成配置)
    self.经验加成缓存 = {}
    
    for i, 配置 in ipairs(经验加成配置) do
        if 配置.类型 and 配置.加成 and 配置.正负 then
            self.经验加成缓存[配置.类型] = {
                加成 = 配置.加成,
                正负 = 配置.正负
            }
        end
    end
end

-- 应用多属性加成
function 变身卡扩展处理类:应用多属性加成(多属性配置)
    self.多属性缓存 = {}
    
    for i, 配置 in ipairs(多属性配置) do
        if 配置.类型 and 配置.加成 and 配置.正负 then
            self.多属性缓存[配置.类型] = {
                加成 = 配置.加成,
                正负 = 配置.正负
            }
        end
    end
    
    -- 立即应用到角色属性
    self:应用多属性到角色()
end

-- 应用多属性到角色
function 变身卡扩展处理类:应用多属性到角色()
    print("变身卡扩展处理类: 多属性缓存已设置，将在属性计算时生效")
    
    -- 触发角色属性重新计算
    if self.玩家id and 玩家数据[self.玩家id] and 玩家数据[self.玩家id].角色 then
        local 角色 = 玩家数据[self.玩家id].角色
        if 角色.刷新信息 then
            角色:刷新信息()
            print("变身卡扩展处理类: 已触发角色属性重新计算")
        end
    end
end

-- 刷新角色属性显示
function 变身卡扩展处理类:刷新角色属性显示()
    if not self.玩家id or not 玩家数据[self.玩家id] then
        return
    end
    
    -- 尝试刷新角色属性
    local 角色 = 玩家数据[self.玩家id].角色
    if 角色 and 角色.刷新属性 then
        角色:刷新属性()
        print("变身卡扩展处理类: 已刷新角色属性")
    end
    
    -- 发送属性更新到客户端
    if 角色 and 角色.发送属性 then
        角色:发送属性()
        print("变身卡扩展处理类: 已发送属性到客户端")
    end
    
    -- 尝试重新计算战斗力
    if 角色 and 角色.计算战斗力 then
        角色:计算战斗力()
        print("变身卡扩展处理类: 已重新计算战斗力")
    end
end

-- 应用召唤兽属性加成
function 变身卡扩展处理类:应用召唤兽属性加成(属性类型, 加成值)
    if not 玩家数据[self.玩家id] or not 玩家数据[self.玩家id].召唤兽 then
        return
    end
    
    local 召唤兽数据 = 玩家数据[self.玩家id].召唤兽.数据
    
    for 召唤兽id, 召唤兽 in pairs(召唤兽数据) do
        if 召唤兽 and 召唤兽.参战 == 1 then
            if 属性类型 == "伤害" then
                召唤兽.伤害 = (召唤兽.伤害 or 0) + 加成值
            elseif 属性类型 == "防御" then
                召唤兽.防御 = (召唤兽.防御 or 0) + 加成值
            elseif 属性类型 == "速度" then
                召唤兽.速度 = (召唤兽.速度 or 0) + 加成值
            end
        end
    end
end

-- 计算加成值
function 变身卡扩展处理类:计算加成值(加成, 正负, 属性类型)
    local 基础值 = self:获取基础属性值(属性类型)
    print("变身卡扩展处理类: 计算加成值 - 属性类型=" .. tostring(属性类型) .. ", 基础值=" .. tostring(基础值) .. ", 加成=" .. tostring(加成) .. ", 正负=" .. tostring(正负))
    
    local 结果 = 0
    if 正负 == 1 then
        -- 固定值加成
        结果 = 加成
        print("变身卡扩展处理类: 固定值加成 = " .. tostring(结果))
    elseif 正负 == 2 then
        -- 百分比加成
        结果 = math.floor(基础值 * (加成 / 100))
        print("变身卡扩展处理类: 百分比加成 = " .. tostring(结果))
    elseif 正负 == 3 then
        -- 倍率加成
        结果 = math.floor(基础值 * (加成 - 1))
        print("变身卡扩展处理类: 倍率加成 = " .. tostring(结果))
    end
    
    return 结果
end

-- 获取基础属性值
function 变身卡扩展处理类:获取基础属性值(属性类型)
    if not self.玩家id then
        print("变身卡扩展处理类: 获取基础属性值时玩家ID为空")
        return 100
    end
    
    if not 玩家数据[self.玩家id] or not 玩家数据[self.玩家id].角色 then
        print("变身卡扩展处理类: 获取基础属性值时玩家数据不存在")
        return 100
    end
    
    local 角色 = 玩家数据[self.玩家id].角色
    
    if 属性类型 == "伤害" then
        return 角色.数据.伤害 or 0
    elseif 属性类型 == "防御" then
        return 角色.数据.防御 or 0
    elseif 属性类型 == "命中" then
        return 角色.数据.命中 or 0
    elseif 属性类型 == "速度" then
        return 角色.数据.速度 or 0
    elseif 属性类型 == "法伤" then
        return 角色.数据.法伤 or 0
    elseif 属性类型 == "法防" then
        return 角色.数据.法防 or 0
    end
    
    return 100 -- 默认基础值
end

-- 清除货币加成
function 变身卡扩展处理类:清除货币加成()
    self.货币加成缓存 = {}
end

-- 清除经验加成
function 变身卡扩展处理类:清除经验加成()
    self.经验加成缓存 = {}
end

-- 清除多属性加成
function 变身卡扩展处理类:清除多属性加成()
    if not 玩家数据[self.玩家id] or not 玩家数据[self.玩家id].角色 then
        return
    end
    
    local 角色 = 玩家数据[self.玩家id].角色
    
    -- 从角色属性中减去之前的加成
    for 属性类型, 配置 in pairs(self.多属性缓存) do
        local 加成值 = self:计算加成值(配置.加成, 配置.正负, 属性类型)
        
        if 属性类型 == "伤害" then
            角色.数据.伤害 = (角色.数据.伤害 or 0) - 加成值
        elseif 属性类型 == "防御" then
            角色.数据.防御 = (角色.数据.防御 or 0) - 加成值
        elseif 属性类型 == "命中" then
            角色.数据.命中 = (角色.数据.命中 or 0) - 加成值
        elseif 属性类型 == "速度" then
            角色.数据.速度 = (角色.数据.速度 or 0) - 加成值
        elseif 属性类型 == "法伤" then
            角色.数据.法伤 = (角色.数据.法伤 or 0) - 加成值
        elseif 属性类型 == "法防" then
            角色.数据.法防 = (角色.数据.法防 or 0) - 加成值
        elseif 属性类型 == "召唤兽伤害" then
            self:清除召唤兽属性加成("伤害", 加成值)
        elseif 属性类型 == "召唤兽防御" then
            self:清除召唤兽属性加成("防御", 加成值)
        elseif 属性类型 == "召唤兽速度" then
            self:清除召唤兽属性加成("速度", 加成值)
        end
    end
    
    self.多属性缓存 = {}
end

-- 清除召唤兽属性加成
function 变身卡扩展处理类:清除召唤兽属性加成(属性类型, 加成值)
    if not 玩家数据[self.玩家id] or not 玩家数据[self.玩家id].召唤兽 then
        return
    end
    
    local 召唤兽数据 = 玩家数据[self.玩家id].召唤兽.数据
    
    for 召唤兽id, 召唤兽 in pairs(召唤兽数据) do
        if 召唤兽 and 召唤兽.参战 == 1 then
            if 属性类型 == "伤害" then
                召唤兽.伤害 = (召唤兽.伤害 or 0) - 加成值
            elseif 属性类型 == "防御" then
                召唤兽.防御 = (召唤兽.防御 or 0) - 加成值
            elseif 属性类型 == "速度" then
                召唤兽.速度 = (召唤兽.速度 or 0) - 加成值
            end
        end
    end
end

-- 获取货币加成
function 变身卡扩展处理类:获取货币加成(货币类型)
    return self.货币加成缓存[货币类型]
end

-- 获取经验加成
function 变身卡扩展处理类:获取经验加成(经验类型)
    return self.经验加成缓存[经验类型]
end

-- 计算货币加成后的数值
function 变身卡扩展处理类:计算货币加成后数值(货币类型, 原始数值)
    local 加成配置 = self:获取货币加成(货币类型)
    if not 加成配置 then
        return 原始数值
    end
    
    if 加成配置.正负 == 1 then
        -- 固定值加成
        return 原始数值 + 加成配置.加成
    elseif 加成配置.正负 == 2 then
        -- 百分比加成
        return 原始数值 + math.floor(原始数值 * (加成配置.加成 / 100))
    elseif 加成配置.正负 == 3 then
        -- 倍率加成
        return 原始数值 * 加成配置.加成
    end
    
    return 原始数值
end

-- 计算经验加成后的数值
function 变身卡扩展处理类:计算经验加成后数值(经验类型, 原始数值)
    local 加成配置 = self:获取经验加成(经验类型)
    if not 加成配置 then
        return 原始数值
    end
    
    if 加成配置.正负 == 1 then
        -- 固定值加成
        return 原始数值 + 加成配置.加成
    elseif 加成配置.正负 == 2 then
        -- 百分比加成
        return 原始数值 + math.floor(原始数值 * (加成配置.加成 / 100))
    elseif 加成配置.正负 == 3 then
        -- 倍率加成
        return 原始数值 * 加成配置.加成
    end
    
    return 原始数值
end

-- 获取多属性加成值
function 变身卡扩展处理类:获取多属性加成值(属性类型)
    if not self.多属性缓存[属性类型] then
        return 0
    end
    
    local 配置 = self.多属性缓存[属性类型]
    return self:计算加成值(配置.加成, 配置.正负, 属性类型)
end

-- 查看当前扩展效果状态
function 变身卡扩展处理类:查看扩展效果状态()
    local 状态信息 = {}
    
    -- 货币加成状态
    if next(self.货币加成缓存) then
        table.insert(状态信息, "#G货币加成效果:")
        for 类型, 配置 in pairs(self.货币加成缓存) do
            local 描述 = ""
            if 配置.正负 == 1 then
                描述 = "固定+" .. 配置.加成
            elseif 配置.正负 == 2 then
                描述 = "百分比+" .. 配置.加成 .. "%"
            elseif 配置.正负 == 3 then
                描述 = "倍率x" .. 配置.加成
            end
            table.insert(状态信息, "  " .. 类型 .. ": " .. 描述)
        end
    end
    
    -- 经验加成状态
    if next(self.经验加成缓存) then
        table.insert(状态信息, "#B经验加成效果:")
        for 类型, 配置 in pairs(self.经验加成缓存) do
            local 描述 = ""
            if 配置.正负 == 1 then
                描述 = "固定+" .. 配置.加成
            elseif 配置.正负 == 2 then
                描述 = "百分比+" .. 配置.加成 .. "%"
            elseif 配置.正负 == 3 then
                描述 = "倍率x" .. 配置.加成
            end
            table.insert(状态信息, "  " .. 类型 .. ": " .. 描述)
        end
    end
    
    -- 多属性加成状态
    if next(self.多属性缓存) then
        table.insert(状态信息, "#R多属性加成效果:")
        for 类型, 配置 in pairs(self.多属性缓存) do
            local 描述 = ""
            if 配置.正负 == 1 then
                描述 = "固定+" .. 配置.加成
            elseif 配置.正负 == 2 then
                描述 = "百分比+" .. 配置.加成 .. "%"
            elseif 配置.正负 == 3 then
                描述 = "倍率x" .. 配置.加成
            end
            table.insert(状态信息, "  " .. 类型 .. ": " .. 描述)
        end
    end
    
    if #状态信息 == 0 then
        return "#Y当前没有激活的变身卡扩展效果"
    else
        return table.concat(状态信息, "\n")
    end
end

require("Script/数据中心/变身卡")
return 变身卡扩展处理类