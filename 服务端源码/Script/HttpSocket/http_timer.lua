-- HTTP定时任务管理器
-- 支持多种类型的定时HTTP请求

local http_timer = {}

-- 定时任务列表
local tasks = {}

-- 任务类型定义
local TASK_TYPES = {
    HEARTBEAT = "heartbeat",      -- 心跳检测
    DATA_SYNC = "data_sync",      -- 数据同步
    STATUS_REPORT = "status_report", -- 状态上报
    CUSTOM = "custom"             -- 自定义任务
}

-- 创建定时任务
function http_timer.create_task(task_type, url, options)
    options = options or {}
    
    local task = {
        type = task_type,
        url = url,
        method = options.method or "GET",
        headers = options.headers or {},
        data = options.data or nil,
        interval = options.interval or 60,  -- 默认60秒
        last_execute = 0,
        enabled = options.enabled ~= false,
        max_retries = options.max_retries or 3,
        retry_count = 0,
        on_success = options.on_success,
        on_error = options.on_error,
        description = options.description or "HTTP定时任务"
    }
    
    table.insert(tasks, task)
    __gge.print(false, 10, "创建HTTP定时任务: " .. task.description .. "\n")
    
    return #tasks  -- 返回任务ID
end

-- 删除定时任务
function http_timer.remove_task(task_id)
    if tasks[task_id] then
        local task = tasks[task_id]
        __gge.print(false, 10, "删除HTTP定时任务: " .. task.description .. "\n")
        table.remove(tasks, task_id)
        return true
    end
    return false
end

-- 启用/禁用任务
function http_timer.set_task_enabled(task_id, enabled)
    if tasks[task_id] then
        tasks[task_id].enabled = enabled
        __gge.print(false, 10, "HTTP定时任务状态更改: " .. tasks[task_id].description .. " -> " .. (enabled and "启用" or "禁用") .. "\n")
        return true
    end
    return false
end

-- 执行单个任务
function http_timer.execute_task(task_id)
    if not tasks[task_id] or not tasks[task_id].enabled then
        return false
    end
    
    local task = tasks[task_id]
    local current_time = os.time()
    
    -- 检查是否需要执行
    if current_time - task.last_execute < task.interval then
        return false
    end
    
    __gge.print(false, 10, "执行HTTP定时任务: " .. task.description .. "\n")
    
    -- 执行HTTP请求
    local http_client = require("Script.HttpSocket.hpsocket_http")
    local success, result
    
    if task.method == "GET" then
        success, result = pcall(function()
            return http_client.get(task.url, task.headers)
        end)
    elseif task.method == "POST" then
        success, result = pcall(function()
            return http_client.post(task.url, task.data, task.headers)
        end)
    else
        success, result = pcall(function()
            return http_client.request(task.url, {
                method = task.method,
                headers = task.headers,
                body = task.data
            })
        end)
    end
    
    -- 处理结果
    if success and result then
        task.last_execute = current_time
        task.retry_count = 0
        
        __gge.print(false, 10, "HTTP定时任务执行成功: " .. task.description .. "\n")
        
        -- 调用成功回调
        if task.on_success then
            pcall(task.on_success, result, task)
        end
        
        return true
    else
        task.retry_count = task.retry_count + 1
        
        __gge.print(false, 10, "HTTP定时任务执行失败: " .. task.description .. " (重试 " .. task.retry_count .. "/" .. task.max_retries .. ")\n")
        
        -- 调用错误回调
        if task.on_error then
            pcall(task.on_error, result, task)
        end
        
        -- 如果重试次数超过限制，禁用任务
        if task.retry_count >= task.max_retries then
            task.enabled = false
            __gge.print(false, 10, "HTTP定时任务已禁用（重试次数超限）: " .. task.description .. "\n")
        end
        
        return false
    end
end

-- 执行所有任务
function http_timer.execute_all_tasks()
    local executed_count = 0
    
    for i = 1, #tasks do
        if http_timer.execute_task(i) then
            executed_count = executed_count + 1
        end
    end
    
    return executed_count
end

-- 获取任务信息
function http_timer.get_task_info(task_id)
    if tasks[task_id] then
        local task = tasks[task_id]
        return {
            type = task.type,
            url = task.url,
            method = task.method,
            interval = task.interval,
            enabled = task.enabled,
            last_execute = task.last_execute,
            retry_count = task.retry_count,
            max_retries = task.max_retries,
            description = task.description
        }
    end
    return nil
end

-- 获取所有任务信息
function http_timer.get_all_tasks()
    local task_list = {}
    for i = 1, #tasks do
        task_list[i] = http_timer.get_task_info(i)
    end
    return task_list
end

-- 创建心跳任务
function http_timer.create_heartbeat_task(url, interval)
    return http_timer.create_task(TASK_TYPES.HEARTBEAT, url, {
        method = "GET",
        interval = interval or 30,
        description = "心跳检测",
        on_success = function(result, task)
            __gge.print(false, 10, "心跳检测成功\n")
        end,
        on_error = function(error, task)
            __gge.print(false, 10, "心跳检测失败: " .. tostring(error) .. "\n")
        end
    })
end

-- 创建数据同步任务
function http_timer.create_data_sync_task(url, data, interval)
    return http_timer.create_task(TASK_TYPES.DATA_SYNC, url, {
        method = "POST",
        data = data,
        headers = {["Content-Type"] = "application/json"},
        interval = interval or 300,  -- 默认5分钟
        description = "数据同步",
        on_success = function(result, task)
            __gge.print(false, 10, "数据同步成功\n")
        end,
        on_error = function(error, task)
            __gge.print(false, 10, "数据同步失败: " .. tostring(error) .. "\n")
        end
    })
end

-- 创建状态上报任务
function http_timer.create_status_report_task(url, status_data, interval)
    return http_timer.create_task(TASK_TYPES.STATUS_REPORT, url, {
        method = "POST",
        data = status_data,
        headers = {["Content-Type"] = "application/json"},
        interval = interval or 60,
        description = "状态上报",
        on_success = function(result, task)
            __gge.print(false, 10, "状态上报成功\n")
        end,
        on_error = function(error, task)
            __gge.print(false, 10, "状态上报失败: " .. tostring(error) .. "\n")
        end
    })
end

-- 清理已禁用的任务
function http_timer.cleanup_disabled_tasks()
    local removed_count = 0
    for i = #tasks, 1, -1 do
        if not tasks[i].enabled and tasks[i].retry_count >= tasks[i].max_retries then
            table.remove(tasks, i)
            removed_count = removed_count + 1
        end
    end
    
    if removed_count > 0 then
        __gge.print(false, 10, "清理了 " .. removed_count .. " 个已禁用的HTTP定时任务\n")
    end
    
    return removed_count
end

return http_timer 